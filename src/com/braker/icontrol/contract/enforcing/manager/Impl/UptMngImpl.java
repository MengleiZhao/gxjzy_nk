package com.braker.icontrol.contract.enforcing.manager.Impl;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;

import org.apache.commons.beanutils.BeanUtils;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.DataEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.LookupsMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.contract.Formulation.manager.ContractPlanListMng;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.Formulation.model.ContractPlanList;
import com.braker.icontrol.contract.enforcing.manager.UptClauseMng;
import com.braker.icontrol.contract.enforcing.manager.UptMng;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.contract.enforcing.model.UptClause;
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.manager.ProceedsPlanMng;
import com.braker.icontrol.contract.filing.manager.ReceivPlanMng;
import com.braker.icontrol.contract.filing.model.ProceedsPlan;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.icontrol.expend.apply.model.TravelAppliInfo;
import com.braker.icontrol.purchase.apply.manager.PurchaseApplyMng;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;

import freemarker.core.BugException;

@Service
@Transactional
public class UptMngImpl extends BaseManagerImpl<Upt> implements UptMng{

	@Autowired
	private UptClauseMng uptAttacMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private LookupsMng lookupsMng;  
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	@Autowired
	private FormulationMng formulationMng;
	@Autowired
	private ReceivPlanMng receivPlanMng;
	@Autowired
	private FilingMng filingMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	@Autowired
	private ContractPlanListMng contractPlanListMng;
	@Autowired
	private ProceedsPlanMng proceedsPlanMng;
	@Autowired
	private PurchaseApplyMng purchaseApplyMng;
	
	
	@Override
	public void saveUptAndUptAttac(ContractBasicInfo contractBasicInfo,Upt upt,User user,String htbgfiles,List<UptClause> uptClauseList,String uptplan,String proceedsPlanJson,String uptcgconfigJson,String htbgOtherfiles) throws Exception {
		contractBasicInfo=formulationMng.findById(contractBasicInfo.getFcId());
		//合同原编号
		upt.setfContCodeOld(contractBasicInfo.getFcCode());
		if(StringUtil.isEmpty(String.valueOf(upt.getfId_U()))){
			upt.setfId_U(Integer.valueOf(StringUtil.random8()));
			upt.setCreator(user.getName());
			upt.setCreateTime(new Date());
			upt.setAssisDeptId(contractBasicInfo.getAssisDeptId());
			upt.setAssisDeptName(contractBasicInfo.getAssisDeptName());
			String fcUptCode =getFcUptCode();
			upt.setfUptCode(fcUptCode);
			//upt.setfContName(contractBasicInfo.getFcTitle());
		}else {
			upt.setUpdator(user.getName());
			upt.setUpdateTime(new Date());
		}
		if(contractBasicInfo.getFcType().equals("HTFL-03")){
			upt.setfAmount(100000.00);//非经济类合同为了走最长的审批流
			upt.setIfFjjht(1);
		}else{
			upt.setIfFjjht(0);
		}

		upt.setStandard(contractBasicInfo.getStandard());
		upt.setAssisDeptId(contractBasicInfo.getAssisDeptId());
		upt.setAssisDeptName(contractBasicInfo.getAssisDeptId());

		//设置合同里变更状态
		if("1".equals(upt.getfUptFlowStauts())){
			contractBasicInfo.setfUpdateStatus("2");
		}
		formulationMng.merge(contractBasicInfo);
		//保存审批状态
		upt.setfReqTime(new Date());
		upt.setfUptStatus("1");//变更单状态1：正常
		upt.setfOperatorID(user.getId());//申请人id
		upt.setfOperator(user.getName());//申请人名称
		upt.setfDeptID(user.getDepart().getId());//所属部门ID
		upt.setfReqTime(new Date());//申请日期
		upt=(Upt) super.merge(upt);
		if("HTFL-01".equals(upt.getfContUptType())){//采购类合同
			//查询旧数据
			List<ReceivPlan> oldlist =  receivPlanMng.findbyUptId(upt.getfId_U());
			//转换成ReceivPlan类型的list   JSON.parseObject("["+travelPeop.toString()+"]",new TypeReference<List<TravelAppliInfo>>(){});
			List<ReceivPlan> newlist=JSON.parseObject(uptplan.toString(),new TypeReference<List<ReceivPlan>>(){});
			//Double d = 0.00;
			//删除旧数据
			if(oldlist.size()>0){
				for (int i = 0; i < oldlist.size(); i++) {
					receivPlanMng.deleteById(oldlist.get(i).getfPlanId());
				}
			}
			//保存新增的计划和更新旧的计划
			for (int i = 0; i < newlist.size(); i++) {
				ReceivPlan receivplan = newlist.get(i);
				ReceivPlan newreceivplan = (ReceivPlan) BeanUtils.cloneBean(receivplan);
				newreceivplan.setfUpateTime_R(new Date());
				newreceivplan.setfUpateUser_R(user.getName());
				newreceivplan.setDataType(1);//数据类型为变更合同付款计划
				newreceivplan.setfUptId_R(upt.getfId_U());//数据类型为变更合同付款计划
				newreceivplan.setfPlanId(null);
				receivPlanMng.merge(newreceivplan);
				//d+=newreceivplan.getfRecePlanAmount();
			}
			/*if(d>Double.valueOf(contractBasicInfo.getFcAmount())){
				upt.setfAmount(d);
			}else if(d<Double.valueOf(contractBasicInfo.getFcAmount())){
				upt.setfAmount(Double.valueOf(contractBasicInfo.getFcAmount()));
			}else {
				upt.setfAmount(d);
			}*/
			//采购数据
			//查询以前的采购数据
			List<ContractPlanList> oldContractPlanList = contractPlanListMng.findbyIdAndTypes("fId_U", String.valueOf(upt.getfId_U()), "1");
			//接受新的采购数据
			List<ContractPlanList> newContractPlanList=(List<ContractPlanList>)JSONArray.toList(JSONArray.fromObject(uptcgconfigJson), ContractPlanList.class);//前台传数据
			//删除原有数据	
			if(oldContractPlanList.size()>0){
				for (int i = 0; i < oldContractPlanList.size(); i++) {
					contractPlanListMng.deleteById(oldContractPlanList.get(i).getMainId());
				}
			}
			//保存新数据
			for (int i = 0; i < newContractPlanList.size(); i++) {
				ContractPlanList contractPlan = newContractPlanList.get(i);
				ContractPlanList newcontractPlan = (ContractPlanList) BeanUtils.cloneBean(contractPlan);
				newcontractPlan.setfId_U(upt.getfId_U());
				newcontractPlan.setFconId(null);
				newcontractPlan.setfType("1");
				newcontractPlan.setMainId(null);
				contractPlanListMng.merge(newcontractPlan);
			}
		}else if("HTFL-02".equals(upt.getfContUptType())){//收入类合同
			
			List<ProceedsPlan> oldproceedsPlanList = proceedsPlanMng.findbyUptId(upt.getfId_U());
			//转换成ProceedsPlan类型的list
			List<ProceedsPlan> newproceedsPlanList=JSON.parseObject(proceedsPlanJson.toString(),new TypeReference<List<ProceedsPlan>>(){});
			//Double d = 0.00;
			//删除原有数据	
			if(oldproceedsPlanList.size()>0){
				for (int i = 0; i < oldproceedsPlanList.size(); i++) {
					proceedsPlanMng.deleteById(oldproceedsPlanList.get(i).getfPId());
				}
			}
			//保存新增的计划和更新旧的计划
			for (int i = 0; i < newproceedsPlanList.size(); i++) {
				ProceedsPlan proceedsPlan = newproceedsPlanList.get(i);
				ProceedsPlan newproceedsPlan = (ProceedsPlan) BeanUtils.cloneBean(proceedsPlan);
				newproceedsPlan.setfUptId(upt.getfId_U());
				newproceedsPlan.setfUpateUser_R(user.getName());
				newproceedsPlan.setfUpateTime_R(new Date());
				newproceedsPlan.setDataType(1);
				newproceedsPlan.setfPId(null);
				//d = d + newproceedsPlan.getfProceedsAmount();
				proceedsPlanMng.merge(newproceedsPlan);
			}
			//upt.setfAmount(d);
		}
		upt=(Upt) super.merge(upt);
		if(upt.getfUptFlowStauts().equals("1")){//送审
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),upt.getJoinTable(),upt.getBeanCodeField(),upt.getBeanCode(), "HTBG", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("HTBG", user.getDpID());
			Integer flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			User nextUser=userMng.findById(node.getUserId());
			//根据前面获得的角色的信息设置下一环节的用户名称/编码
			upt.setfUserCode(nextUser.getId());
			upt.setfUserName(nextUser.getName());
			//设置下节点节点编码
			upt.setfNCode(firstKey+"");
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,upt.getBeanCode());
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(upt.getfUserCode());//任务处理人ID既是下节点处理人ID
			work.setTaskId(upt.getfId_U());//申请单ID
			work.setTaskCode(upt.getfUptCode());//为申请单的单号
			work.setTaskName("[变更申请]"+contractBasicInfo.getFcTitle());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/Change/approvalChange/"+upt.getfId_U());//为审批页面内容显示的url,需要将数据传入不然无法访问
			work.setUrl1("/Change/detail/"+ upt.getfId_U());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型：1-审批
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(new Date());//任务提交时间
			personalWorkMng.merge(work);
			//添加一个自己的已办事项
			PersonalWork minwork = new PersonalWork();
			minwork.setUserId(user.getId());//任务处理人ID既是下节点处理人ID
			minwork.setTaskId(upt.getfId_U());//申请单ID
			minwork.setTaskCode(upt.getfUptCode());//为申请单的单号
			minwork.setTaskName("[变更申请]"+contractBasicInfo.getFcTitle());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			minwork.setUrl("/Change/edit/"+upt.getfId_U());//退回修改url
			minwork.setUrl1("/Change/detail/"+ upt.getfId_U());//查看url
			minwork.setUrl2("/Change/delete/"+ upt.getfId_U());//退回删除url
			minwork.setTaskStauts("2");//待办
			minwork.setType("2");//任务类型：2-查看
			minwork.setBeforeUser(user.getName());//任务提交人姓名
			minwork.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			minwork.setBeforeTime(new Date());//任务提交时间
			minwork.setFinishTime(new Date());
			personalWorkMng.merge(minwork);
		}
//		upt=(Upt) super.merge(upt);
		attachmentMng.joinEntity(upt,htbgfiles);
		attachmentMng.joinEntity(upt,htbgOtherfiles);
		
	}

	@Override
	public List<Upt> findByFContId_U(String id) {
		Finder finder = Finder.create(" FROM Upt WHERE fContId_U ="+Integer.valueOf(id)+" and fUptStatus<>99 order by updateTime desc");
		return super.find(finder);
	}

	@Override
	public int findUpTInfoSize(String id) {
		Finder finder =Finder.create(" FROM Upt WHERE fContId_U="+Integer.valueOf(id)+" and fUptStatus<>99"); 
		return super.find(finder).size();
	}

	@Override
	public void deletebyfId(String fId) {
		String sql=" delete from T_CONTRACT_UPT_CLAUSE where F_ID="+fId;
		SQLQuery query = getSession().createSQLQuery(sql);
		query.executeUpdate();
	}
	
	@Override
	public void deletebyfId(Upt upt) {
		//修改变更表状态
		upt.setfUptStatus("99");
		super.merge(upt);
		//修改原合同状态
		ContractBasicInfo cbi = formulationMng.findById(Integer.valueOf(upt.getfContId_U()));
		cbi.setfUpdateStatus("0");
		super.merge(cbi);
		//删除工作计划
		getSession().createSQLQuery("delete from T_RECEIV_PLAN where F_UPT_ID ="+upt.getfId_U() +" ").executeUpdate();
		//删除相关工作台信息
		List<PersonalWork> worklost = personalWorkMng.findByCodeAndUser(upt.getfContCode(), userMng.findById(upt.getfOperatorID()));
		if(worklost.size()>0){
			for (int i = 0; i < worklost.size(); i++) {
				personalWorkMng.deleteById(Integer.valueOf(worklost.get(i).getfId()));
			}
		}
	}

	@Override
	public Pagination queryList(ContractBasicInfo contractBasicInfo, User user, Integer pageNo,Integer pageSize) {
		Finder finder=Finder.create(" FROM ContractBasicInfo WHERE fFlowStauts='1' AND fContStauts='1' and fyhtid is not null AND fUserCode='"+user.getId()+"'");
		if(!StringUtil.isEmpty(contractBasicInfo.getFcCode())){
			finder.append("AND fcCode LIKE :fcCode ");
			finder.setParam("fcCode", "%"+contractBasicInfo.getFcCode()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcTitle())){
			finder.append("AND fcTitle LIKE :fcTitle ");
			finder.setParam("fcTitle", "%"+contractBasicInfo.getFcTitle()+"%");
		}
		/*if(upt.getfReqTimeStart()!=null){
			finder.append(" AND DATE_FORMATE(fReqTime, '%Y-%m-%d') >="+upt.getfReqTimeStart());
		}
		if(upt.getfReqTimeEnd()!=null){
			finder.append(" AND DATE_FORMATE(fReqTime, '%Y-%m-%d') <="+upt.getfReqTimeEnd());
		}*/
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}

	/**
	 * 保存审批信息
	 * @createtime 2019-05-27
	 * @author 陈睿超
	 * @updatetime 2020-12-21
	 * @updator 陈睿超
	 */
	@Override
	@Transactional(propagation=Propagation.REQUIRED)//事务处理
	public void updateStatus(String fId_U, String status, User user,TProcessCheck checkBean, String file) throws Exception {
		//查询需要修改审批状态的表单
		Upt upt = super.findById(Integer.valueOf(fId_U));
		CheckEntity entity=(CheckEntity)upt;
		String checkUrl="/Change/approvalChange/";
		String lookUrl ="/Change/detail/";
		upt=(Upt)tProcessCheckMng.checkProcess(checkBean,entity,user,"HTBG",checkUrl,lookUrl,file);
		//更改合同主表的变更状态为1-有变更
		ContractBasicInfo cbi = formulationMng.findById(Integer.valueOf(upt.getfContId_U()));
		if("9".equals(upt.getfUptFlowStauts())){
			if("HTFL-01".equals(cbi.getFcType())){//采购合同才需要变更付款计划
				//变更后付款计划总金额
				StringBuilder sql = new StringBuilder();
				sql.append("SELECT SUM(t.F_RECE_PLAN_AMOUNT) AS totalAmount FROM T_RECEIV_PLAN t");
				sql.append(" WHERE t.F_UPT_ID = " + fId_U);
				sql.append(" AND t.F_DATA_TYPE = 1");
				SQLQuery query = getSession().createSQLQuery(sql.toString());
				List uptPlanlist = query.list();
				Double uptPlanAmount = 0d;
				if (uptPlanlist != null && !uptPlanlist.isEmpty() && uptPlanlist.get(0) != null) {
					uptPlanAmount = (Double) uptPlanlist.get(0);
				}
				//原合同付款计划总金额
				StringBuilder contractSql = new StringBuilder();
				contractSql.append("SELECT SUM(t.F_RECE_PLAN_AMOUNT) AS totalAmount FROM T_RECEIV_PLAN t");
				contractSql.append(" WHERE t.F_CONT_ID = " + cbi.getFcId());
				contractSql.append(" AND t.F_DATA_TYPE = 0");
				SQLQuery contractQuery = getSession().createSQLQuery(contractSql.toString());
				List contractPlanlist = contractQuery.list();
				Double contractPlanAmount = 0d;
				if (contractPlanlist != null && !contractPlanlist.isEmpty() && contractPlanlist.get(0) != null) {
					contractPlanAmount = (Double) contractPlanlist.get(0);
				}
				//指标
				TBudgetIndexMgr index = budgetIndexMgrMng.findById(cbi.getfBudgetIndexCode());
				//付款计划变更（增加）
				if (uptPlanAmount > contractPlanAmount) {
					Double d= uptPlanAmount-contractPlanAmount;
					if (index.getDjAmount().doubleValue()*10000 < d) {
						throw new ServiceException("操作失败，冻结金额不足！");
					}
					//判断申请金额是否超过可用金额
					Boolean b=budgetIndexMgrMng.checkAmounts(String.valueOf(cbi.getProDetailId()), BigDecimal.valueOf(d));
					if (!b) {
						throw new ServiceException("操作失败，可用金额不足！");
					}
				}
				//冻结金额
				//付款计划变更（增加）
				if (uptPlanAmount > contractPlanAmount) {
					Double d= uptPlanAmount-contractPlanAmount;
					budgetIndexMgrMng.addDjAmount(cbi.getfBudgetIndexCode(), cbi.getProDetailId(), BigDecimal.valueOf(d));
				}
				//付款计划变更（减少）
				if (uptPlanAmount < contractPlanAmount) {
					Double d= contractPlanAmount-uptPlanAmount;
					budgetIndexMgrMng.deleteDjAmount(cbi.getfBudgetIndexCode(), cbi.getProDetailId(), BigDecimal.valueOf(d));
				}
//				uptAmount(cbi,upt);
			}
			super.merge(cbi);
			upt.setFsealedStatus("0");//合同盖章状态
			upt.setFgdstatus("0");//合同归档状态
		}
		super.saveOrUpdate(upt);
	}

	@Override
	public Pagination List(Upt upt, User user, Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create(" FROM Upt WHERE fUptStatus='1' AND fOperatorID='"+user.getId()+"'");
		finder.append(" AND fDeptID = :fDeptID");
		finder.setParam("fDeptID", user.getDpID());
		
		if(!StringUtil.isEmpty(upt.getfContName())){
			finder.append(" AND fContName LIKE :fContName");
			finder.setParam("fContName", "%"+upt.getfContName()+"%");
		}
		if(!StringUtil.isEmpty(upt.getfUptCode())){
			finder.append(" AND fUptCode LIKE :fUptCode");
			finder.setParam("fUptCode", "%"+upt.getfUptCode()+"%");
		}
		if(upt.getfReqTimeStart()!=null){
			finder.append(" AND DATE_FORMAT(fReqTime, '%Y-%m-%d') >='"+upt.getfReqTimeStart()+"'");
		}
		if(upt.getfReqTimeEnd()!=null){
			finder.append(" AND DATE_FORMAT(fReqTime, '%Y-%m-%d') <='"+upt.getfReqTimeEnd()+"'");
		}
		finder.append(" order by fReqTime desc");
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public String reCall(String id) {
		Upt bean = super.findById(Integer.valueOf(id));
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="合同变更申请被撤回消息";
		String msg="您待审批合同  "+bean.getfContName() +",任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean=(Upt) reCall((CheckEntity) bean);
		this.updateDefault(bean);
		return "操作成功";
		
		
	}

	//根据变更付款计划变更指标冻结金额
	public void uptAmount(ContractBasicInfo cbi,Upt upt){
		Finder finder = Finder.create("from ReceivPlan where dataType =1 and fUptId_R ="+upt.getfId_U());
		Finder basefinder = Finder.create("from ReceivPlan where dataType =0 and fStauts_R = 1 and fContId_R ="+cbi.getFcId());
		List<ReceivPlan> planList = super.find(finder);
		List<ReceivPlan> baseplanList = super.find(basefinder);
		BigDecimal payamount = BigDecimal.ZERO;//原来合同已经支付的金额
		BigDecimal newPlanamount = BigDecimal.ZERO;//现在新的付款计划需要支付的总额
		BigDecimal camount = BigDecimal.valueOf(Double.valueOf(cbi.getFcAmount()));//现在新的付款计划需要支付的总额
		for (int i = 0; i < baseplanList.size(); i++) {
			payamount = payamount.add(baseplanList.get(i).getfRecePlanAmount());
		}
		for (int i = 0; i < planList.size(); i++) {
			newPlanamount =newPlanamount.add(planList.get(i).getfRecePlanAmount());
		}
		if(payamount.add(newPlanamount).compareTo(camount)==1){//已支付金额＋新的付款计划>原合同金额
			BigDecimal d= (payamount.add(newPlanamount).subtract(camount));
			budgetIndexMgrMng.addDjAmount(cbi.getfBudgetIndexCode(), cbi.getProDetailId(), d);
		}else if(payamount.add(newPlanamount).compareTo(camount)==-1){//已支付金额＋新的付款计划<原合同金额
			BigDecimal d= camount.subtract(payamount.add(newPlanamount));
			budgetIndexMgrMng.deleteDjAmount(cbi.getfBudgetIndexCode(), cbi.getProDetailId(), d);
			
		}

	}
	

	@Override
	public void updateStatus(Upt upt,User user) {
		String sql=" update T_CONTRACT_UPT SET F_GDSTATUS='5'";
		Query updateFCS =getSession().createSQLQuery(sql);
		updateFCS.executeUpdate();
	}

	/**
	 * 
	* @author:赵孟雷
	* @Title: getFcUptCode 
	* @Description: 获取变更合同编码
	* @return
	* @return String    返回类型 
	* @date： 2021年2月2日
	* @throws
	 */
	@Override
	public String getFcUptCode(){
		Finder finder =Finder.create(" FROM Upt where year(fReqTime) = year(now())");
		int num= super.countQueryResult(finder);
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		String fcCode="BGHT"+format.format(new Date())+StringUtil.autoGenericCode(num+"",4);
		return fcCode;
	}
}
