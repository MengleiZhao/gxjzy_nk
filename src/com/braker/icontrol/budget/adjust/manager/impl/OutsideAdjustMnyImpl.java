package com.braker.icontrol.budget.adjust.manager.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.page.Pagination;
import com.braker.common.util.MatheUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.icontrol.budget.adjust.entity.TIndexExteAd;
import com.braker.icontrol.budget.adjust.entity.TIndexExteAdLst;
import com.braker.icontrol.budget.adjust.manager.OutsideAdjustMny;
import com.braker.icontrol.budget.adjust.manager.TIndexExteAdLstMng;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;

/**
 * 外部指标调整的service实现类
 * @author 叶崇晖
 * @createtime 2018-08-25
 * @updatetime 2018-08-25
 */
@Service
@Transactional
public class OutsideAdjustMnyImpl extends BaseManagerImpl<TIndexExteAd> implements OutsideAdjustMny {
	@Autowired
	private TIndexExteAdLstMng adLstMng;
	
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private TNodeDataMng tNodeDataMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private DepartMng departMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	
	@Autowired
	private TProExpendDetailMng tProExpendDetailMng;
	
	/*
	 * 分页查询
	 * @author 叶崇晖
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 */
	@Override
	public Pagination pageList(TIndexExteAd bean, int pageNo, int pageSize, User user) {
		try {
			StringBuilder builder=new StringBuilder();
			builder.append("select * FROM  T_INDEX_EXTE_AD tiea where 1=1 and F_STAUTS in ('1','0') ");
			if(!StringUtil.isEmpty(bean.getIndexName())){ //按调整指标名称模糊查询
				builder.append(" AND  EXISTS (select tieal.F_A_ID FROM   T_INDEX_EXTE_AD_LST tieal  where  tiea.F_A_ID= tieal.F_A_ID  and tieal.F_B_INDEX_NAME like '%"+bean.getIndexName()+"%' ) ");
			}
			if(!StringUtil.isEmpty(String.valueOf(bean.getChangeAmountBegin())) && !StringUtil.isEmpty(String.valueOf(bean.getChangeAmountEnd()))){
				builder.append( " AND  EXISTS ( select tieal.F_A_ID,sum(tieal.F_INDEX_AMOUNT_INCR) as totalamount FROM   T_INDEX_EXTE_AD_LST  tieal  where  tiea.F_A_ID= tieal.F_A_ID       "
						+ "group by F_A_ID having totalamount  >= "+bean.getChangeAmountBegin()+" and totalamount  <= "+bean.getChangeAmountEnd()+" )");
			}
			else {
				
				if(!StringUtil.isEmpty(String.valueOf(bean.getChangeAmountBegin()))){
				builder.append( " AND  EXISTS ( select tieal.F_A_ID,sum(tieal.F_INDEX_AMOUNT_INCR) as totalamount FROM   T_INDEX_EXTE_AD_LST  tieal  where  tiea.F_A_ID= tieal.F_A_ID       "
						+ "group by F_A_ID having totalamount  >= "+bean.getChangeAmountBegin()+" )");
				}
				if(!StringUtil.isEmpty(String.valueOf(bean.getChangeAmountEnd()))){
				builder.append( " AND  EXISTS ( select tieal.F_A_ID,sum(tieal.F_INDEX_AMOUNT_INCR) as totalamount FROM   T_INDEX_EXTE_AD_LST  tieal  where  tiea.F_A_ID= tieal.F_A_ID       "
						+ "group by F_A_ID having  totalamount  <= "+bean.getChangeAmountEnd()+"  )");
				}
			}
			String deptIdStr=departMng.getDeptIdStrByUser(user);
	 		if("".equals(deptIdStr)){ //普通岗位只能查看自己的
		 			builder.append(" and tiea.F_DECLARER ="+ user.getId()+"");
		 		}else if("all".equals(deptIdStr)){//校长可以查看所有人的
		 			
		 		}else{//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
		 			builder.append(" and tiea.F_DEPT_CODE in ("+deptIdStr+")");
	 		}
			if(!StringUtil.isEmpty(bean.getFlowStauts())){//审批状态
				if("2".equals(bean.getFlowStauts())){//审核中
					builder.append(" AND F_FLOW_STAUTS >0 and F_FLOW_STAUTS <9");
				}else{
					builder.append(" AND F_FLOW_STAUTS ="+bean.getFlowStauts()+"");
				}
			}
			builder.append(" order by F_A_ID desc ");
			return super.findBySql( bean,builder.toString(), pageNo, pageSize);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return null;
	}

	
	/*
	 * 外部指标调整保存
	 * @author 叶崇晖
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 */
	@Override
	public void save(TIndexExteAd bean, List<TIndexExteAdLst> tzli, User user)  throws Exception{
		//设置调整时间
		Date d = new Date();
		bean.setOpTime(d);
		bean.setDeptCode(user.getDepart().getId());
		bean.setDeclarer(user.getId());
		//以下为工作流的节点配置（如果点送审则设置进入工作流1为提交2为审核中）
		if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), "WBZBDZ", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("WBZBDZ", user.getDpID());
			Integer flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			User nextUser=userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号		get(0)的原因是一个角色应该只能审批一级，所以查出来li应该只有一个数据
			bean.setFuserName(nextUser.getName());
			bean.setFuserId(nextUser.getId());
			//设置下节点节点编码
			bean.setnCode(firstKey+"");	
			
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			
			//保存预算指标内部调整信息
			bean = (TIndexExteAd) super.saveOrUpdate(bean);
			
			//如果是送审状态则需要添加代办事项
			if("1".equals(bean.getFlowStauts())){
				bean.setFuserName(nextUser.getName());
				bean.setFuserId(nextUser.getId());
				//设置下节点节点编码
				bean.setnCode(firstKey+"");
				//添加审批人个人首页代办信息
				PersonalWork work = new PersonalWork();
				work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
				work.setTaskId(bean.getaId());//申请单ID
				work.setTaskCode(bean.getOutCode());//为申请单的单号
				work.setTaskName(bean.getIndexName()+"外部调整审批");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				work.setUrl("/outsideCheck/check?id="+bean.getaId());//为审批页面内容显示的url,需要将数据传入不然无法访问
				work.setUrl1("/outsideAdjust/edit?editType=0&id="+ bean.getaId());//查看url
				work.setTaskStauts("0");//待办
				work.setType("1");//任务类型：1-审批
				work.setBeforeUser(user.getName());//任务提交人姓名
				work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
				work.setBeforeTime(new Date());//任务提交时间
				personalWorkMng.merge(work);
				//添加一个自己的已办事项
				PersonalWork minwork = new PersonalWork();
				minwork.setUserId(user.getId());//
				minwork.setTaskId(bean.getaId());//申请单ID
				minwork.setTaskCode(bean.getOutCode());//为申请单的单号
				minwork.setTaskName(bean.getIndexName()+"外部调整审批");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				minwork.setUrl("/outsideAdjust/edit?editType=1&id="+bean.getaId());//退回修改url
				minwork.setUrl1("/outsideAdjust/edit?editType=0&id="+ bean.getaId());//查看url
				minwork.setUrl2("/outsideAdjust/delete?id="+ bean.getaId());//退回删除url
				minwork.setTaskStauts("2");//待办
				minwork.setType("2");//任务类型：2-查看
				minwork.setBeforeUser(user.getName());//任务提交人姓名
				minwork.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
				minwork.setBeforeTime(new Date());//任务提交时间
				minwork.setFinishTime(new Date());
				personalWorkMng.merge(minwork);
			}
			
		} else {
			//保存预算指标内部调整信息
			bean = (TIndexExteAd) super.saveOrUpdate(bean);
		}
		//删除原有的明细
		adLstMng.deleteByAId(bean.getaId());
		
		//保存指标明细
		for (int i = 0; i < tzli.size(); i++) {
			TIndexExteAdLst tiea = tzli.get(i);
			//关联内部指标调整的副键ID
			tiea.setaId(bean.getaId());
			//指标调整生效日期
			tiea.setEffecTime(d);
			//调整类型IN-调入，OUT-调出
			tiea.setAdType("IN");
			
			//保存指标调出明细
			adLstMng.save(tiea);
			
		}
		

	}

	
	/*
	 * 根据项目指标编号查找相应的项目
	 * @author 叶崇晖
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 */
	@Override
	public TProBasicInfo findByIndexCode(String indexCode) {
		String sql = "SELECT * FROM t_pro_basic_info WHERE F_PRO_ID="
				+ "(SELECT F_PRO_ID FROM t_budgetary_indic_pro WHERE F_B_ID="
				+ "(SELECT F_B_ID from t_budgetary_indic_pro_itf WHERE F_B_I_ID='"+indexCode+"'))";
		Query q = getSession().createSQLQuery(sql).addEntity(TProBasicInfo.class);
		List<TProBasicInfo> li = q.list();
		return li.get(0);
	}

	
	/*
	 * 审批分页查询
	 * @author 叶崇晖
	 * @createtime 2018-07-26
	 * @updatetime 2018-07-26
	 */
	@Override
	public Pagination checkPageList(TIndexExteAd bean, int pageNo, int pageSize, User user) {
		try {
			StringBuilder builder=new StringBuilder();
			builder.append("select * FROM  T_INDEX_EXTE_AD tiea where F_FLOW_STAUTS in('0','1') and F_USER_ID='"+user.getId()+"'  ");
			if(!StringUtil.isEmpty(bean.getIndexName())){ //按调整指标名称模糊查询
				builder.append(" AND  EXISTS (select tieal.F_A_ID FROM   T_INDEX_EXTE_AD_LST tieal  where  tiea.F_A_ID= tieal.F_A_ID  and tieal.F_B_INDEX_NAME like '%"+bean.getIndexName()+"%' ) ");
			}
			if(!StringUtil.isEmpty(String.valueOf(bean.getChangeAmountBegin())) && !StringUtil.isEmpty(String.valueOf(bean.getChangeAmountEnd()))){
				builder.append( " AND  EXISTS ( select tieal.F_A_ID,sum(tieal.F_INDEX_AMOUNT_INCR) as totalamount FROM   T_INDEX_EXTE_AD_LST  tieal  where  tiea.F_A_ID= tieal.F_A_ID       "
						+ "group by F_A_ID having totalamount  >= "+bean.getChangeAmountBegin()+" and totalamount  <= "+bean.getChangeAmountEnd()+" )");
			}else{
				if(!StringUtil.isEmpty(String.valueOf(bean.getChangeAmountBegin()))){
				builder.append( " AND  EXISTS ( select tieal.F_A_ID,sum(tieal.F_INDEX_AMOUNT_INCR) as totalamount FROM   T_INDEX_EXTE_AD_LST  tieal  where  tiea.F_A_ID= tieal.F_A_ID       "
						+ "group by F_A_ID having totalamount  >= "+bean.getChangeAmountBegin()+" )");
				}
				 if(!StringUtil.isEmpty(String.valueOf(bean.getChangeAmountEnd()))){
					builder.append( " AND  EXISTS ( select tieal.F_A_ID,sum(tieal.F_INDEX_AMOUNT_INCR) as totalamount FROM   T_INDEX_EXTE_AD_LST  tieal  where  tiea.F_A_ID= tieal.F_A_ID       "
							+ "group by F_A_ID having  totalamount  <= "+bean.getChangeAmountEnd()+"  )");
				}
			}	 
			if(!StringUtil.isEmpty(bean.getFlowStauts())){//审批状态
				if("2".equals(bean.getFlowStauts())){//审核中
					builder.append(" AND F_FLOW_STAUTS >0 and F_FLOW_STAUTS <9");
				}else{
					builder.append(" AND F_FLOW_STAUTS ="+bean.getFlowStauts()+"");
				}
			}
			return super.findBySql( bean,builder.toString(), pageNo, pageSize);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return null;
	}


	
	/*
	 * 外部指标调整删除
	 * @author 叶崇晖
	 * @createtime 2018-08-01
	 * @updatetime 2018-08-01
	 */
	@Override
	public void delete(Integer id) {
		TIndexExteAd bean = super.findById(id);
		bean.setStauts("99");
		super.saveOrUpdate(bean);
	}


	@Override
	public void saveCheckInfo(TProcessCheck checkBean, TIndexExteAd insideBean,
			User user,String files)  throws Exception{
		// TODO Auto-generated method stub
		insideBean=this.findById(insideBean.getaId());
		CheckEntity entity=(CheckEntity)insideBean;
		String lookUrl="/outsideAdjust/edit?editType=0&id=";
		String checkUrl ="/outsideCheck/check?id=";
		insideBean=(TIndexExteAd)tProcessCheckMng.checkProcess(checkBean,entity,user,"WBZBDZ",checkUrl,lookUrl,files);
		if("9".equals(insideBean.getFlowStauts())) {		//审批全部通过,修改调入指标可用金额，修改调出指标冻结金额
			addAmount(insideBean.getaId());
		}
		super.saveOrUpdate(insideBean);
	}

	
	/**
	 * 
	* @author:安达
	* @Title: addAmount 
	* @Description: 审批全部通过,修改调入指标可用金额，修改调出指标冻结金额
	* @return void    返回类型 
	* @date： 2019年6月18日下午9:09:39 
	* @throws
	 */
	private void  addAmount(Integer aId){
		List<TIndexExteAdLst> indexExteAdLstList=adLstMng.findByAid(aId+"");
		for(TIndexExteAdLst indexExteAdLst:indexExteAdLstList){
			//修改项目剩余金额
			TBudgetIndexMgr bim = budgetIndexMgrMng.findById(indexExteAdLst.getBid());
			bim.setSyAmount(bim.getSyAmount().add(indexExteAdLst.getChangeAmount()));
			//修改批复总金额
			bim.setPfAmount(bim.getPfAmount().add(indexExteAdLst.getChangeAmount()));
			super.merge(bim);
			if(indexExteAdLst.getPid() !=null && indexExteAdLst.getPid()>0){
				//修改指标expendDetail
				TProExpendDetail expendDetail = tProExpendDetailMng.findById(indexExteAdLst.getPid());
				expendDetail.setSyAmount(expendDetail.getSyAmount().add(indexExteAdLst.getChangeAmount().multiply(BigDecimal.valueOf(10000))));
				super.merge(expendDetail);
			}
			
		}
	}
}
