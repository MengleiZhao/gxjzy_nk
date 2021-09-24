package com.braker.icontrol.incomemanage.accountsCurrent.manager.impl;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.expend.apply.model.ApplicationDetail;
import com.braker.icontrol.incomemanage.accountsCurrent.manager.AccountsCurrentMng;
import com.braker.icontrol.incomemanage.accountsCurrent.manager.AccountsRegisterMng;
import com.braker.icontrol.incomemanage.accountsCurrent.model.AccountsCurrent;
import com.braker.icontrol.incomemanage.accountsCurrent.model.AccountsRegister;
import com.braker.icontrol.incomemanage.accountsCurrent.model.ReceiveMoneyDetail;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 往来款立项申请实现层
 * @author 赵孟雷
 */
@Service
@Transactional
public class AccountsRegisterMngImpl extends BaseManagerImpl<AccountsRegister> implements AccountsRegisterMng{
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TNodeDataMng tNodeDataMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	
	@Autowired
	private PersonalWorkMng personalWorkMng;
	
	@Autowired
	private AccountsCurrentMng accountsCurrentMng;
	
	@Autowired
	private PrivateInforMng privateInforMng;
	
	@Autowired
	private DepartMng departMng;
	/*
	 * 分页查询来款登记
	 * @author 赵孟雷
	 * @createtime 2020-11-10
	 * @updatetime 2020-11-10
	 */
	@Override
	public Pagination pageList(AccountsRegister bean, int pageNo, int pageSize,Integer type, User user) {
			//查询条件
			/*Finder finder = Finder.create(" FROM AccountsRegister WHERE stauts <>99 AND userId='"+user.getId()+"'");
			if(!StringUtil.isEmpty(bean.getProCode())){ //按项目编号模糊查询
				finder.append(" AND proCode LIKE :proCode");
				finder.setParam("proCode", "%"+bean.getProCode()+"%");
			}
			if(!StringUtil.isEmpty(bean.getProName())){ //按项目名称模糊查询
				finder.append(" AND proName LIKE :proName");
				finder.setParam("proName", "%"+bean.getProName()+"%");
			}
			finder.append(" order by reqTime desc ");
			Pagination p = super.find(finder, pageNo, pageSize);*/
			//查询条件
			StringBuilder sbf = new StringBuilder("SELECT * FROM T_MONEY_REGISTER a left join T_RECEIVE_MONEY_DETAIL b on a.F_M_S_ID = b.F_M_S_ID  WHERE a.F_STAUTS<>99 and a.F_USER='"+user.getId()+"'");
			if(!StringUtil.isEmpty(bean.getProCode())){
				sbf.append(" and (concat(a.F_REGISTER_CODE,',',a.F_PRO_NAME,',',a.F_DEPT_NAME,',',a.F_USER_NAME,',',a.F_REQ_TIME,',',b.F_OPPOSITE_UNIT,',',b.F_PLAN_MONEY) LIKE '%"+bean.getProCode()+"%')");
			}
			sbf.append(" order by a.F_REQ_TIME desc");
			String str=sbf.toString();
			Pagination p = super.findBySql(new AccountsRegister(), str, pageNo, pageSize);
			return p;
	}
	
	/*
	 * 分页查询来款登记审批
	 * @author 赵孟雷
	 * @createtime 2020-11-10
	 * @updatetime 2020-11-10
	 */
	@Override
	public Pagination pageCheckList(AccountsRegister bean, int pageNo, int pageSize,Integer type, User user) {
		//查询条件
		StringBuilder sbf = new StringBuilder("SELECT * FROM T_MONEY_REGISTER a left join T_RECEIVE_MONEY_DETAIL b on a.F_M_S_ID = b.F_M_S_ID  WHERE a.F_STAUTS<>99 and a.F_USER_ID='"+user.getId()+"'");
		if(!StringUtil.isEmpty(bean.getProCode())){
			sbf.append(" and (concat(a.F_REGISTER_CODE,',',a.F_PRO_NAME,',',a.F_DEPT_NAME,',',a.F_USER_NAME,',',a.F_REQ_TIME,',',b.F_OPPOSITE_UNIT,',',b.F_PLAN_MONEY) LIKE '%"+bean.getProCode()+"%')");
		}
		sbf.append(" order by a.F_REQ_TIME desc");
		String str=sbf.toString();
		Pagination p = super.findBySql(new AccountsRegister(), str, pageNo, pageSize);
		return p;
	}
	
	@Override
	public void save(AccountsRegister bean, String files,User user,String registerJson) throws Exception{
		Date d = new Date();
		bean.setReqTime(d);//申请时间
		bean.setUserId(user.getId());//申请人id
		bean.setDeptId(user.getDepart().getId());//申请人所属部门id
		bean.setDeptName(user.getDepartName());//申请人所属部门名称
		if(bean.getfMSId()==null){
			//创建人、创建时间、申请单编号
			bean.setCreator(user.getAccountNo());
			bean.setCreateTime(d);
		}else{
			//修改人、修改时间
			bean.setUpdator(user.getAccountNo());
			bean.setUpdateTime(d);
		}
		if(StringUtil.isEmpty(String.valueOf(bean.getfAcaId()))){
			throw new ServiceException("往来款项目为空，请重新选择！");
		}
		//工作流的节点配置（状态1和2可以继续走审批流，该状态不会变）
		if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
			Integer flowId =0;
			User nextUser = new User();
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), "WLKDJ", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("WLKDJ", user.getDpID());
			flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			nextUser=userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号
			bean.setUserName2(nextUser.getName());
			bean.setFuserId(nextUser.getId());
			//设置下节点节点编码
			bean.setnCode(firstKey+"");	
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			//保存基本信息
			bean = (AccountsRegister) super.saveOrUpdate(bean);
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getfMSId());//申请单ID
			work.setTaskCode(bean.getRegisterCode());//为申请单的单号
			String taskName =  "[往来款登记]" + bean.getProName();
			work.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/accountsRegisterCheck/check?id="+bean.getfMSId());//审批url
			work.setUrl1("/accountsRegister/detail?id="+ bean.getfMSId());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setTaskType("1");//任务归属（1审批人）
			work.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work.setBeforeTime(d);//任务提交时间
			personalWorkMng.merge(work);
			
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(bean.getfMSId());//申请单ID
			work2.setTaskCode(bean.getRegisterCode());//为申请单的单号
			work2.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/accountsRegister/edit?id="+ bean.getfMSId());//退回修改url
			work2.setUrl1("/accountsRegister/detail?id="+ bean.getfMSId());//查看url
			work2.setUrl2("/accountsRegister/delete?id="+ bean.getfMSId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setTaskType("0");//任务归属（0发起人）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work2.setBeforeTime(d);//任务提交时间
			work2.setFinishTime(d);
			personalWorkMng.merge(work2);
		} else {
			//保存基本信息
			bean = (AccountsRegister) super.saveOrUpdate(bean);
		}
		//保存附件信息
		attachmentMng.joinEntity(bean,files);
		
		/** 保存明细信息 **/
		//删除数据库中   申请中
		getSession().createSQLQuery("delete from T_RECEIVE_MONEY_DETAIL where F_M_S_ID ="+bean.getfMSId()+" and F_TYPE='2'").executeUpdate();
		if(!StringUtil.isEmpty(registerJson)){
			//获取Json对象
			List<ReceiveMoneyDetail> receiveMoneyDetailList = JSON.parseObject("["+registerJson.toString()+"]",new TypeReference<List<ReceiveMoneyDetail>>(){});
			for (ReceiveMoneyDetail receiveMoneyDetail: receiveMoneyDetailList) {
				ReceiveMoneyDetail info = new ReceiveMoneyDetail();
				info.setfMSId(bean.getfMSId());
				info.setOppositeUnit(receiveMoneyDetail.getOppositeUnit());
				info.setPlanMoney(receiveMoneyDetail.getPlanMoney());
				info.setPlanTime(receiveMoneyDetail.getPlanTime());
				info.setInvoiceKind(receiveMoneyDetail.getInvoiceKind());
				info.setInvoiceKindShow(receiveMoneyDetail.getInvoiceKindShow());
				info.setfType("2");
				super.merge(info);
			}
		}
		
	}
	
	@Override
	public void check(TProcessCheck checkBean,AccountsRegister bean, String files, User user) throws Exception {
		bean=this.findById(bean.getfMSId());
		CheckEntity entity=(CheckEntity)bean;
		String checkUrl="/accountsRegisterCheck/check?id=";
		String lookUrl ="/accountsRegister/detail?id=";
		bean=(AccountsRegister)tProcessCheckMng.checkProcess(checkBean,entity,user,"WLKDJ",checkUrl,lookUrl,files);
		if("9".equals(bean.getFlowStauts())){
			//审批通过后，设置登记立项的登记状态和确认状态
			bean.setrStauts("1");
			bean.setaStauts("0");
		}
		super.saveOrUpdate(bean);
	}

	/*
	 * 删除
	 * @author 赵孟雷
	 * @createtime 2020-11-12
	 * @updatetime 2020-11-12
	 */
	@Override
	public void delete(Integer id,User user,String fId) {
		//事前申请的状态为99（删除）
		if(fId!=null){
			personalWorkMng.deleteById(Integer.valueOf(fId));
		}
		personalWorkMng.sendMessageToUser(user.getId(), 0);
		getSession().createSQLQuery("UPDATE T_MONEY_REGISTER SET F_STAUTS=99 WHERE F_M_S_ID="+id).executeUpdate();
		
	}

	@Override
	public Pagination registerAffirmPage(AccountsRegister bean, int pageNo, int pageSize, Integer type, User user) {
		//查询条件
		StringBuilder sbf = new StringBuilder("SELECT * FROM T_MONEY_REGISTER a left join T_RECEIVE_MONEY_DETAIL b on a.F_M_S_ID = b.F_M_S_ID  WHERE a.F_STAUTS<>99 and a.F_REGISTER_STAUTS='1'");
		
		if(user.getRoleName().contains("会计岗")){
			
		}else{
			String deptIdStr=departMng.getDeptIdStrByUser(user);
			if("".equals(deptIdStr)){ //普通岗位只能查看自己的
				sbf.append(" and a.F_USER='"+user.getId()+"'");
			}else if("all".equals(deptIdStr)){//校长可以查看所有人的
				
			}else{//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
				sbf.append(" and a.F_DEPT_ID in ("+deptIdStr+")");
			}
		}
		if(!StringUtil.isEmpty(bean.getProCode())){
			sbf.append(" and (concat(a.F_REGISTER_CODE,',',a.F_PRO_NAME,',',a.F_DEPT_NAME,',',a.F_USER_NAME,',',a.F_REQ_TIME,',',b.F_OPPOSITE_UNIT,',',b.F_PLAN_MONEY) LIKE '%"+bean.getProCode()+"%')");
		}
		sbf.append(" order by a.F_REQ_TIME desc");
		String str=sbf.toString();
		Pagination p = super.findBySql(new AccountsRegister(), str, pageNo, pageSize);
		return p;
	}

	@Override
	public void saveRegisterAffirm(AccountsRegister bean,User user) throws Exception {
		Date d = new Date();
		bean.setAffirmUserId(user.getId());//确认人ID
		bean.setAffirmUserName(user.getName());//确认人姓名
		bean.setUpdator(user.getName());//更新人姓名
		bean.setAffTime(d);//确认时间
		bean.setAccDocNumber(bean.getAccDocNumber());//会计凭证号
		bean.setRealityDate(bean.getRealityDate());//实际来款日期
		bean.setaStauts("1");
		super.saveOrUpdate(bean);
	}

	@Override
	public String registerAffirmReCall(Integer id) throws Exception {
		//根据id查询对象
		AccountsRegister bean= super.findById(id);
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="申请被撤回消息";
		String msg="您待审批的  "+bean.getProName() +",任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean.setCheckStauts("-4");//已撤回
		bean.setStauts("0");//暂存
		bean.setNextCheckKey("0");//设置到初始节点
		bean.setNextCheckUserId("");
		bean.setNextCheckUserName("");
		super.updateDefault(bean);
		return "";
	}

	@Override
	public List<AccountsRegister> registerList(AccountsRegister bean, User user) throws Exception {
		//查询条件
				Finder finder = Finder.create(" FROM AccountsRegister WHERE stauts <>99 AND rStauts='1'");
				if(!StringUtil.isEmpty(String.valueOf(bean.getfAcaId()))){ //按项目编号模糊查询
					finder.append(" AND fAcaId =:fAcaId");
					finder.setParam("fAcaId", bean.getfAcaId());
				}
				if(!StringUtil.isEmpty(bean.getProCode())){ //按项目编号模糊查询
					finder.append(" AND proCode LIKE :proCode");
					finder.setParam("proCode", "%"+bean.getProCode()+"%");
				}
				if(!StringUtil.isEmpty(bean.getProName())){ //按项目名称模糊查询
					finder.append(" AND proName LIKE :proName");
					finder.setParam("proName", "%"+bean.getProName()+"%");
				}
				finder.append(" order by reqTime desc ");
				List<AccountsRegister> list = super.find(finder);
				return list;
	}
}
