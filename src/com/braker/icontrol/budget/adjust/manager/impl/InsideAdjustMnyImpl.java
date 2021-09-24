package com.braker.icontrol.budget.adjust.manager.impl;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.page.Pagination;
import com.braker.common.util.JpushClientUtil;
import com.braker.common.util.MatheUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.budget.adjust.entity.TIndexAdItf;
import com.braker.icontrol.budget.adjust.entity.TIndexInnerAd;
import com.braker.icontrol.budget.adjust.manager.InsideAdjustMny;
import com.braker.icontrol.budget.adjust.manager.TIndexAdItfMng;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 内部指标调整的service实现类
 * @author 叶崇晖
 * @createtime 2018-08-10
 * @updatetime 2018-08-10
 */
@Service
@Transactional
public class InsideAdjustMnyImpl extends BaseManagerImpl<TIndexInnerAd> implements InsideAdjustMny{
	@Autowired
	private TIndexAdItfMng tIndexAdItfMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private TNodeDataMng tNodeDataMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private AttachmentMng attachmentMng;

	@Autowired
	private DepartMng departMng;
	
	@Autowired
	private PersonalWorkMng personalWorkMng;
	
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	
	@Autowired
	private TProExpendDetailMng tProExpendDetailMng;
	
	@Autowired
	private PrivateInforMng privateInforMng;
	/*
	 * 分页查询
	 * @author 叶崇晖
	 * @createtime 2018-07-10
	 * @updatetime 2018-07-10
	 */
	@Override
	public Pagination pageList(TIndexInnerAd bean, int pageNo, int pageSize, User user, String type) {
		try {
			StringBuilder builder=new StringBuilder();
			builder.append("select * FROM  T_INDEX_INNER_AD tii where  F_STAUTS in('0','1') ");
			if(!StringUtil.isEmpty(bean.getIndexNameIn())){ //按采购编号模糊查询
				builder.append(" AND  EXISTS (select tia.F_IN_ID FROM   T_INDEX_AD_ITF tia  where  tii.F_IN_ID= tia.F_IN_ID  and tia.F_B_INDEX_NAME like '%"+bean.getIndexNameIn()+"%' and F_AD_TYPE='IN') ");
			}
			if(!StringUtil.isEmpty(bean.getIndexNameOut())){ //按采购名称模糊查询
				builder.append(" and EXISTS (select tia.F_IN_ID from   T_INDEX_AD_ITF tia where  tii.F_IN_ID=tia.F_IN_ID  and tia.F_B_INDEX_NAME like  '%"+bean.getIndexNameOut()+"%' and F_AD_TYPE='OUT') ");
			}
			if(!StringUtil.isEmpty(bean.getFlowStauts()) ){//审批状态
				if("2".equals(bean.getFlowStauts())){	
					builder.append(" AND F_USER_ID = '" + user.getId() + "'");
				}
			}else{
				//台账查看权限
				String deptIdStr=departMng.getDeptIdStrByUser(user);
				if(user.getRoleName().contains("预算台账查看岗")){
					//预算管理查看岗可以查看所有部门的台账及指标台账
				}else {
					if("".equals(deptIdStr)){ //普通岗位只能查看自己的
						builder.append(" and tii.F_APP_USER ="+ user.getId()+"");
					}else if("all".equals(deptIdStr)){//校长可以查看所有人的
						
					}else{//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
						builder.append(" and tii.F_DEPT_CODE in ("+deptIdStr+")");
					}
				}
			}
			
			if(type != null) {
				builder.append(" AND F_FLOW_STAUTS='9'");
			}
			builder.append(" order by F_IN_ID desc");
			
			return super.findBySql( bean,builder.toString(), pageNo, pageSize);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/*
	 * 内部指标调整保存
	 * @author 叶崇晖
	 * @createtime 2018-07-23
	 * @updatetime 2018-07-23
	 */
	@Override
	public String save(TIndexInnerAd bean, User user, List<TIndexAdItf> dcList, List<TIndexAdItf> drList,String files) throws Exception {
		//做重复校验，调入指标不能跟调出指标一样,如果调出指标里有值跟调入指标一样，返回false
		boolean checkResult=duplicationCheck(dcList,drList);
		if(!checkResult){
			return "调入指标跟调出指标重复";
		}
		//设置调整时间
		Date d = new Date();
		bean.setOpTime(d);
		bean.setDeptCode(user.getDepart().getId());
		bean.setAppUser(user.getId());
		//工作流的节点配置（如果点送审则设置进入工作流1为提交2为审核中）
		if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
			Integer firstKey = null;
			Integer flowId = null;
			User nextUser = null;
			String strType ="";
			if("WBYSZBTZ".equals(bean.getChangeType())){
				strType ="WBZBDZ";
			}else{
				strType ="NBZBDZ";
			}
			//得到第一个审批节点key
			firstKey = tProcessCheckMng.addProcessCheck(user.getDpID(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getBeanCode(), strType, user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin = tProcessDefinMng.getByBusiAndDpcode(strType, user.getDpID());
			flowId = processDefin.getFPId();
			TNodeData node = tNodeDataMng.getByFlowIdAndKey(flowId, firstKey);
			nextUser = userMng.findById(node.getUserId());
			
			//设置下节点处理人姓名和编号		get(0)的原因是一个角色应该只能审批一级，所以查出来li应该只有一个数据
			bean.setFuserName(nextUser.getName());
			bean.setFuserId(nextUser.getId());
			//设置下节点节点编码
			bean.setnCode(String.valueOf(firstKey));
			
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId, bean.getBeanCode());
			
			//保存预算指标内部调整信息
			bean = (TIndexInnerAd) super.saveOrUpdate(bean);
			
			//如果是送审状态则需要添加代办事项
			if("1".equals(bean.getFlowStauts())){
				bean.setFuserName(nextUser.getName());
				bean.setFuserId(nextUser.getId());
				//设置下节点节点编码
				bean.setnCode(firstKey+"");
				
				//调减指标
				//获得资产名称集合
				List nameList = new ArrayList<>();
				for(int i=0; i<dcList.size(); i++){
					nameList.add(dcList.get(i).getActivity());
				}
				//调用名称拼接方法
				String name2 = StringUtil.nameJoint(nameList, "、", 3);
				
				//调增指标
				//获得资产名称集合
				List nameList1 = new ArrayList<>();
				for(int i=0; i<drList.size(); i++){
					nameList1.add(drList.get(i).getActivity());
				}
				//调用名称拼接方法
				String name1 = StringUtil.nameJoint(nameList1, "、", 3);
				
				String name =name1+"|"+name2;
				
				//添加审批人个人首页代办信息
				PersonalWork work = new PersonalWork();
				work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
				work.setTaskId(bean.getInId());//申请单ID
				work.setTaskCode(bean.getInCode());//为申请单的单号
				work.setTaskName("[指标调整]"+name);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				work.setUrl("/insideCheck/check?id="+bean.getInId());//为审批页面内容显示的url,需要将数据传入不然无法访问
				work.setUrl1("/insideAdjust/detail?id="+ bean.getInId());//查看url
				work.setTaskStauts("0");//待办
				work.setType("1");//任务类型：1-审批
				work.setTaskType("1");//任务归属（1审批人）
				work.setBeforeUser(user.getName());//任务提交人姓名
				work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
				work.setBeforeTime(new Date());//任务提交时间
				personalWorkMng.merge(work);
				//添加一个自己的已办事项
				PersonalWork minwork = new PersonalWork();
				minwork.setUserId(user.getId());//任务处理人ID既是下节点处理人ID
				minwork.setTaskId(bean.getInId());//申请单ID
				minwork.setTaskCode(bean.getInCode());//为申请单的单号
				minwork.setTaskName("[指标调整]"+name);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				minwork.setUrl("/insideAdjust/edit?id="+bean.getInId());//退回修改url
				minwork.setUrl1("/insideAdjust/detail?id="+ bean.getInId());//查看url
				minwork.setUrl2("/insideAdjust/delete?id="+ bean.getInId());//退回删除url
				minwork.setTaskStauts("2");//待办
				minwork.setType("2");//任务类型：2-查看
				minwork.setTaskType("0");//任务归属（0发起人）
				minwork.setBeforeUser(user.getName());//任务提交人姓名
				minwork.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
				minwork.setBeforeTime(new Date());//任务提交时间
				minwork.setFinishTime(new Date());
				personalWorkMng.merge(minwork);
				//推送通知到app
				if(JpushClientUtil.sendToRegistrationId(nextUser.getAccountNo(),null,"您有一条待审批任务",work.getTaskName(),bean.getInId().toString(), "0","zbtz")==1){
		            System.out.println("推送给指定Android用户success");
		        }
			}
		} else {
			//保存预算指标内部调整信息
			bean = (TIndexInnerAd) super.saveOrUpdate(bean);
		}
			
		//删除原有的明细
		tIndexAdItfMng.deleteByInId(bean.getInId());
		
		//保存指标明细
		for (int i = 0; i < dcList.size(); i++) {
			TIndexAdItf itf = dcList.get(i);
			//关联内部指标调整的副键ID
			itf.setInId(bean.getInId());
			//指标调整生效日期
			itf.setEffecTime(d);
			//调整类型IN-调入，OUT-调出
			itf.setAdType("OUT");
			BigDecimal changeAmountCount = itf.getChangeAmount().multiply(BigDecimal.valueOf(-1));
			itf.setChangeAmountCount(changeAmountCount);
			//如果是送审，就冻结金额  只修改调出的，等审批通过了再给调入的加金额
			if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
				//修改剩余金额和冻结金额
				frozenAmount(itf);
				
			}
			//保存指标调出明细
			tIndexAdItfMng.save(itf);
		}
		for (int i = 0; i < drList.size(); i++) {
			
			TIndexAdItf itf = drList.get(i);
			//关联内部指标调整的副键ID
			itf.setInId(bean.getInId());
			//指标调整生效日期
			itf.setEffecTime(d);
			//调整类型IN-调入，OUT-调出
			itf.setAdType("IN");
			itf.setChangeAmountCount(itf.getChangeAmount());
			//保存指标调入明细
			tIndexAdItfMng.save(itf);
			
		}
		//保存附件信息
		attachmentMng.joinEntity(bean,files);
		//修改指标下达明细信息
		return "操作成功";
	}
	
	/**
	 * 
	* @author:安达
	* @Title: duplicationCheck 
	* @Description: 做重复校验，调入指标不能跟调出指标一样
	* @param dcli
	* @param drli
	* @return
	* @return boolean    返回类型 
	* @date： 2019年6月26日上午10:28:57 
	* @throws
	 */
	private boolean duplicationCheck(List<TIndexAdItf> dcList, List<TIndexAdItf> drList){
		
		HashMap<Integer,Integer>  map=List2Map(dcList);
		for(TIndexAdItf index:drList){
			//如果调出指标里有值跟调入指标一样，返回false
			if(map.get(index.getBid())!=null){
				return false;
			}
		}
		return true;
	}
	
	/**
	 * 
	* @author:安达
	* @Title: List2Map 
	* @Description: 把调出指标转换成map
	* @param list
	* @return
	* @return HashMap<Integer,Integer>    返回类型 
	* @date： 2019年6月26日上午10:35:04 
	* @throws
	 */
	private HashMap<Integer,Integer> List2Map(List<TIndexAdItf> list){
		HashMap<Integer,Integer> map=new HashMap<Integer,Integer>();
		for(TIndexAdItf index:list){
			map.put(index.getBid(), index.getBid());
		}
		return map;
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
	 * 内部指标调整删除
	 * @author 安达
	 * @createtime 2019-03-13
	 * @updatetime 2019-03-13
	 */
	@Override
	public void delete(Integer id) {
		TIndexInnerAd bean = super.findById(id);
		List<TIndexAdItf> indexAditfList=tIndexAdItfMng.findByInId(id+"", null);
		for(TIndexAdItf ndexAditf:indexAditfList){
			if("IN".equals(ndexAditf.getAdType())){
				getSession().createSQLQuery("delete from T_PRO_EXPEND_DETAIL where F_EXP_ID ="+ndexAditf.getPid()+"").executeUpdate();
			}
		}
		bean.setStauts("99");
		super.saveOrUpdate(bean);
	}
	/**
	 * 审批
	 */
	@Override
	public void saveCheckInfo(TProcessCheck checkBean, TIndexInnerAd insideBean, User user, String files)  throws Exception{
		insideBean = this.findById(insideBean.getInId());
		checkBean.setCheckDeptId(insideBean.getInsideDeptId());
		CheckEntity entity = (CheckEntity)insideBean;
		String lookUrl = "/insideAdjust/detail?id=";
		String checkUrl = "/insideCheck/check?id=";
		String strType ="";
		if("WBYSZBTZ".equals(insideBean.getChangeType())){
			strType ="WBZBDZ";
		}else{
			strType ="NBZBDZ";
		}
		//若调减部门id为空，则为部门内部调整，否则为部门之间调整
		insideBean = (TIndexInnerAd)tProcessCheckMng.checkProcess(checkBean, entity, user, strType, checkUrl, lookUrl, files);
		super.saveOrUpdate(insideBean);
		if("-1".equals(insideBean.getFlowStauts())) {		//打回原点的时候，需要解冻
			getBackAmount(insideBean.getInId());
		}else if("9".equals(insideBean.getFlowStauts())) {		//审批全部通过,修改调入指标可用金额，修改调出指标冻结金额
			addAmount(insideBean.getInId());
		}
	}
	/**
	 * 
	* @author:安达
	* @Title: frozenAmount 
	* @Description: 送审，修改冻结金额和剩余金额
	* @param itf
	* @return void    返回类型 
	* @date： 2019年6月19日下午7:10:18 
	* @throws
	 */
	private void frozenAmount(TIndexAdItf itf){
		TBudgetIndexMgr bim = budgetIndexMgrMng.findById(itf.getBid());
		//修改项目剩余金额
		bim.setSyAmount(bim.getSyAmount().subtract(itf.getChangeAmount()));
		//修改项目冻结金额
		bim.setDjAmount(bim.getDjAmount().add(itf.getChangeAmount()));
		super.merge(bim);
		
		if(itf.getPid() !=null && itf.getPid()>0){
			TProExpendDetail expendDetail = tProExpendDetailMng.findById(itf.getPid());
			//修改指标剩余金额
			expendDetail.setSyAmount(expendDetail.getSyAmount().subtract(itf.getChangeAmount()));
			//修改指标冻结金额
			expendDetail.setDjAmount(expendDetail.getDjAmount().add(itf.getChangeAmount()));
			super.merge(expendDetail);
		}
	}
	/**
	 * 
	* @author:安达
	* @Title: getBackAmount 
	* @Description: 如果被打回，修改余额 
	* @return void    返回类型 
	* @date： 2019年6月18日下午9:09:39 
	* @throws
	 */
	private void  getBackAmount(Integer inId){
		List<TIndexAdItf> indexAditfList=tIndexAdItfMng.findByInId(inId+"", null);
		for(TIndexAdItf ndexAditf:indexAditfList){
			//只修改调出的，因为送审的时候也只修改调出的
			if("OUT".equals(ndexAditf.getAdType())){
				TBudgetIndexMgr bim = budgetIndexMgrMng.findById(ndexAditf.getBid());
				//修改项目剩余金额
				bim.setSyAmount(bim.getSyAmount().add(ndexAditf.getChangeAmount()));
				//修改项目冻结金额
				bim.setDjAmount(bim.getDjAmount().add(ndexAditf.getChangeAmount()));
				super.merge(bim);
				
				if(ndexAditf.getPid() !=null && ndexAditf.getPid()>0){
					TProExpendDetail expendDetail = tProExpendDetailMng.findById(ndexAditf.getPid());
					//修改指标剩余金额
					expendDetail.setSyAmount(expendDetail.getSyAmount().add(ndexAditf.getChangeAmount()));
					//修改指标冻结金额
					expendDetail.setDjAmount(expendDetail.getDjAmount().subtract(ndexAditf.getChangeAmount()));
					super.merge(expendDetail);
				}
				
			}
		}
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
	private void  addAmount(Integer inId){
		List<TIndexAdItf> indexAditfList=tIndexAdItfMng.findByInId(inId+"", null);
		for(TIndexAdItf ndexAditf:indexAditfList){
			if("OUT".equals(ndexAditf.getAdType())){
				TBudgetIndexMgr bim = budgetIndexMgrMng.findById(ndexAditf.getBid());
				//修改批复总金额
				//bim.setPfzAmount(MatheUtil.sub(bim.getPfzAmount(), Double.valueOf(ndexAditf.getChangeAmount())));
				bim.setXdAmount(bim.getXdAmount().subtract(ndexAditf.getChangeAmount()));
				bim.setPfAmount(bim.getPfAmount().subtract(ndexAditf.getChangeAmount()));
				//修改项目冻结金额
				bim.setDjAmount(bim.getDjAmount().subtract(ndexAditf.getChangeAmount()));
				super.merge(bim);
				if(ndexAditf.getPid() !=null && ndexAditf.getPid()>0){
					//修改指标冻结金额
					TProExpendDetail expendDetail = tProExpendDetailMng.findById(ndexAditf.getPid());
					expendDetail.setDjAmount(expendDetail.getDjAmount().subtract(ndexAditf.getChangeAmount()));
					
					expendDetail.setXdAmount(expendDetail.getXdAmount().subtract(ndexAditf.getChangeAmount()));
					super.merge(expendDetail);
				}
				
			} else if("IN".equals(ndexAditf.getAdType())){
				//修改项目剩余金额
				TBudgetIndexMgr bim = budgetIndexMgrMng.findById(ndexAditf.getBid());
				bim.setSyAmount(bim.getSyAmount().add(ndexAditf.getChangeAmount()));
				//修改批复总金额
				//bim.setPfzAmount(MatheUtil.add(bim.getPfzAmount(), Double.valueOf(ndexAditf.getChangeAmount())));
				bim.setXdAmount(bim.getXdAmount().add(ndexAditf.getChangeAmount()));
				bim.setPfAmount(bim.getPfAmount().add(ndexAditf.getChangeAmount()));
				if(ndexAditf.getPid() !=null && ndexAditf.getPid()>0){
					//修改指标expendDetail
					TProExpendDetail expendDetail = tProExpendDetailMng.findById(ndexAditf.getPid());
					expendDetail.setSyAmount(expendDetail.getSyAmount().add(ndexAditf.getChangeAmount()));
					expendDetail.setXdAmount(expendDetail.getXdAmount().add(ndexAditf.getChangeAmount()));
					if("1".equals(expendDetail.getCreateStatus())) {
						expendDetail.setCreateStatus(null);
						bim.setSyAmount(bim.getSyAmount().add(expendDetail.getXdAmount()));
						bim.setXdAmount(bim.getXdAmount().add(expendDetail.getXdAmount()));
						bim.setPfAmount(bim.getPfAmount().add(expendDetail.getXdAmount()));
					}
					super.merge(expendDetail);
				}
				super.merge(bim);
				
				
			}
			
		}
	}
	
	@Override
	public List<Object[]> adjustEconomicList() {
		String sql=" SELECT a.F_B_ID, b.F_SUB_NUM,b.F_SUB_NAME,sum(F_INDEX_AMOUNT_COUNT) "
				+ "FROM T_INDEX_AD_ITF a LEFT JOIN T_PRO_EXPEND_DETAIL b ON a.F_EXP_ID = b.F_EXP_ID "
				+ "LEFT JOIN T_INDEX_INNER_AD c ON a.F_IN_ID = c.F_IN_ID where c.F_FLOW_STAUTS ='9' and year(c.F_OP_TIME)  = year(NOW())"
				+ " GROUP BY b.F_SUB_NUM ";
		
		Query query = getSession().createSQLQuery(sql);
		List<Object[]> list = query.list();
		return list;
	}
	
	@Override
	public List<Object[]> departList() {
		String sql="SELECT d.F_DEPT_CODE,d.F_DEPT_NAME, b.F_SUB_NUM,b.F_SUB_NAME,sum(d.F_FIRST_AMOUNT),sum(F_INDEX_AMOUNT_COUNT),sum(d.F_PF_AMOUNT)"
				+ " FROM T_INDEX_AD_ITF a LEFT JOIN T_PRO_EXPEND_DETAIL b ON a.F_EXP_ID = b.F_EXP_ID"
				+ " LEFT JOIN T_INDEX_INNER_AD c ON a.F_IN_ID = c.F_IN_ID  "
				+ "left join T_BUDGET_INDEX_MGR d on a.F_B_ID=d.F_B_ID  "
				+ "where c.F_FLOW_STAUTS ='9' and year(F_OP_TIME)  = year(NOW())"
				+ " GROUP BY d.F_DEPT_CODE ";
		
		Query query = getSession().createSQLQuery(sql);
		List<Object[]> list = query.list();
		return list;
	}
	
	@Override
	public List<Object[]> prolist(String deptCode) {
		String sql="SELECT d.F_B_ID,d.F_B_INDEX_NAME, b.F_SUB_NUM,b.F_SUB_NAME,d.F_FIRST_AMOUNT,sum(F_INDEX_AMOUNT_COUNT),d.F_PF_AMOUNT"
				+ " FROM T_INDEX_AD_ITF a LEFT JOIN T_PRO_EXPEND_DETAIL b ON a.F_EXP_ID = b.F_EXP_ID "
				+ "LEFT JOIN T_INDEX_INNER_AD c ON a.F_IN_ID = c.F_IN_ID "
				+ " left join T_BUDGET_INDEX_MGR d on a.F_B_ID=d.F_B_ID  "
				+ "where c.F_FLOW_STAUTS ='9' and year(F_OP_TIME)  = year(NOW())"
				+ " and  d.F_DEPT_CODE ='"+deptCode+"' group by d.F_B_ID ORDER  BY d.F_INDEX_TYPE  ";
		
		Query query = getSession().createSQLQuery(sql);
		List<Object[]> list = query.list();
		return list;
	}
	
	public List<Object[]> departAndEconomicList(String deptCode,String subCode) {
		String sql="select sum(col1), sum(col2), sum(col3) from ( SELECT d.F_FIRST_AMOUNT as col1 ,sum(F_INDEX_AMOUNT_COUNT) as col2,d.F_PF_AMOUNT as col3"
				+ " FROM T_INDEX_AD_ITF a LEFT JOIN T_PRO_EXPEND_DETAIL b ON a.F_EXP_ID = b.F_EXP_ID "
				+ "LEFT JOIN T_INDEX_INNER_AD c ON a.F_IN_ID = c.F_IN_ID "
				+ " left join T_BUDGET_INDEX_MGR d on a.F_B_ID=d.F_B_ID  "
				+ "where c.F_FLOW_STAUTS ='9' and year(F_OP_TIME)  = year(NOW())"
				+ " and  d.F_DEPT_CODE ='"+deptCode+"' "
				+ " and b.F_SUB_NUM ='"+subCode+"' "
				+ "  GROUP BY a.F_B_ID ) as t1";
		Query query = getSession().createSQLQuery(sql);
		List<Object[]> list = query.list();
		return list;
	}
	
	public List<Object[]> indexAndEconomicList(String indexId,String subCode) {
		String sql="select sum(col1), sum(col2), sum(col3) from ( SELECT d.F_FIRST_AMOUNT as col1 ,sum(F_INDEX_AMOUNT_COUNT) as col2,d.F_PF_AMOUNT as col3"
				+ " FROM T_INDEX_AD_ITF a LEFT JOIN T_PRO_EXPEND_DETAIL b ON a.F_EXP_ID = b.F_EXP_ID "
				+ "LEFT JOIN T_INDEX_INNER_AD c ON a.F_IN_ID = c.F_IN_ID "
				+ " left join T_BUDGET_INDEX_MGR d on a.F_B_ID=d.F_B_ID  "
				+ "where c.F_FLOW_STAUTS ='9' and year(F_OP_TIME)  = year(NOW())"
				+ " and  d.F_B_ID ='"+indexId+"' "
				+ " and b.F_SUB_NUM ='"+subCode+"' "
				+ "  GROUP BY a.F_B_ID ) as t1";
		Query query = getSession().createSQLQuery(sql);
		List<Object[]> list = query.list();
		return list;
	}
	
	@Override
	public List<Object[]> getDataList(List<Object[]> adjustEconomicList,
			List<Object[]> departAndProlist){
		List<Object[]> list=new ArrayList<Object[]>();
		for (int i = 0; i < departAndProlist.size(); i++) {
			Object [] obj=new Object[adjustEconomicList.size()*3+5];
			
			obj[0]=departAndProlist.get(i)[1];
			for (int j = 0; j < adjustEconomicList.size(); j++) {
				String subCode=(String) adjustEconomicList.get(j)[1];
				if(departAndProlist.get(i)[7].equals("depart")){
					List<Object[]> departAndEconomicList =departAndEconomicList((String) departAndProlist.get(i)[0],subCode);
					obj[1+j*3]=departAndEconomicList.get(0)[0];
					obj[2+j*3]=departAndEconomicList.get(0)[1];
					obj[3+j*3]=departAndEconomicList.get(0)[2];
					obj[4+adjustEconomicList.size()*3]="depart";
				}
				if(departAndProlist.get(i)[7].equals("index")){
					List<Object[]> indexAndEconomicList =indexAndEconomicList( departAndProlist.get(i)[0].toString(),subCode);
					obj[1+j*3]=indexAndEconomicList.get(0)[0];
					obj[2+j*3]=indexAndEconomicList.get(0)[1];
					obj[3+j*3]=indexAndEconomicList.get(0)[2];
					obj[4+adjustEconomicList.size()*3]="index";
				}
			}
			obj[1+adjustEconomicList.size()*3]=departAndProlist.get(i)[4];
			obj[2+adjustEconomicList.size()*3]=departAndProlist.get(i)[5];
			obj[3+adjustEconomicList.size()*3]=departAndProlist.get(i)[6];
			list.add(obj);
		}
		Object [] totalobj=new Object[adjustEconomicList.size()*3+5];
		totalobj[0]="合计";
		if(list.size()>0){
			for (int i = 0; i < totalobj.length-1; i++) {
				Double num = 0.00;
				for (int y = 0; y < list.size(); y++) {
					Object [] obj =list.get(y);
					if(obj[4+adjustEconomicList.size()*3].equals("depart")){
						if(i!=0){
							if(obj[i]!=null){
								num=num+(Double) obj[i];
							}
						}
					}
					
				}
				if(i!=0){
					totalobj[i]=num;
				}
			}
		}
		list.add(totalobj);
		return list;
	}

	@Override
	public String reCall(Integer id) {
		TIndexInnerAd bean=(TIndexInnerAd)super.findById(id);
		if(bean.getCheckStauts().equals("-4")){
			throw new ServiceException("该单据已被撤回，请勿重复操作！");
		}
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="采购申请被撤回消息";
		String msg="您待审批的预算调整申请,任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean=(TIndexInnerAd) reCall((CheckEntity) bean);
		this.updateDefault(bean);
		return "操作成功";
	}

}
