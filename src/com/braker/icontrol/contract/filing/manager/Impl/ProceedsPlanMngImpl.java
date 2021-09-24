package com.braker.icontrol.contract.filing.manager.Impl;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.DataEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.enforcing.manager.ContPayMng;
import com.braker.icontrol.contract.enforcing.manager.UptMng;
import com.braker.icontrol.contract.enforcing.model.ContPay;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.manager.ProceedsPlanMng;
import com.braker.icontrol.contract.filing.manager.ReceivPlanMng;
import com.braker.icontrol.contract.filing.model.ProceedsPlan;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.icontrol.expend.reimburse.model.ContractReimburseInfo;
import com.braker.icontrol.expend.reimburse.model.InvoiceCouponInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbPayeeInfo;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

@Service
@Transactional
public class ProceedsPlanMngImpl extends BaseManagerImpl<ProceedsPlan> implements ProceedsPlanMng{

	@Autowired
	private FilingMng filingMng;
	@Autowired
	private FormulationMng formulationMng;
	@Autowired
	private UptMng uptMng;
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
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private ContPayMng contPayMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	@Autowired
	private ProceedsPlanMng proceedsPlanMng;
	@Autowired
	private DepartMng departMng;
	@Override
	public List<ContractBasicInfo> query_Amount(List<ContractBasicInfo> li) {
		
		for (int i = 0; i < li.size(); i++) {
			String sql = "SELECT sum(F_RECE_AMOUNT) fAllAmount FROM t_receiv_plan WHERE F_CONT_ID="+li.get(i).getFcId();
			Query query=getSession().createSQLQuery(sql);
			List fAllAmount = query.list();
			if(StringUtil.isEmpty(String.valueOf(fAllAmount.get(0)))){
				fAllAmount.set(0, "0.00");
			}
			li.get(i).setfAllAmount(String.valueOf(fAllAmount.get(0)));
			Double fcAmount=Double.valueOf(li.get(i).getFcAmount());
			Double fAAmount=Double.valueOf(String.valueOf(fAllAmount.get(0)));
			li.get(i).setfNotAllAmountL(String.valueOf(fcAmount-fAAmount));
		}
		return li;
	}

	@Override
	public Pagination allPlan(Integer id, Integer pageNo, Integer pageSize) {
		ContractBasicInfo cbi = formulationMng.findById(id);
		List<ProceedsPlan> planList = finduptandbase(cbi.getfUpdateStatus(),cbi.getFcId());
		//Finder finder=Finder.create(" FROM ReceivPlan WHERE fContId_R="+id+" ORDER BY fReceProperty DESC");
		Pagination p = new Pagination();
		p.setList(planList);
		return p;
	}

	public Pagination allProceedsPlan(Integer id, Integer pageNo, Integer pageSize) {
		ContractBasicInfo cbi = formulationMng.findById(id);
		List<ProceedsPlan> planList = finduptandbase(cbi.getfUpdateStatus(),cbi.getFcId());
		//Finder finder=Finder.create(" FROM ProceedsPlan WHERE  fContId="+id+" ORDER BY fProceedsProperty DESC");
		Pagination p = new Pagination();
		p.setList(planList);
		p.setPageNo(pageNo);
		p.setPageSize(planList.size());
		p.setTotalCount(planList.size());
		return p;
	}
	
	@Override
	public List<ProceedsPlan> findUnPay(Integer fContId_R) {
		Finder finder=Finder.create(" FROM ProceedsPlan WHERE fContId="+fContId_R+" AND fStauts=0");
		return super.find(finder);
	}

	@Override
	public List<ProceedsPlan> queryMoney1(Integer id) {
		Finder finder=Finder.create("FROM ProceedsPlan WHERE fStauts='0' AND fContId="+id);
		return super.find(finder);
	}

	@Override
	public List<ProceedsPlan> findbyUptId(Integer uptid) {
		Finder finder=Finder.create("FROM ProceedsPlan WHERE dataType='1' AND fUptId="+uptid);
		return super.find(finder);
	}

	@Override
	public List<ProceedsPlan> finduptandbase(String ctype, Integer cid) {
		List<ProceedsPlan> payedPlan = new ArrayList<ProceedsPlan>();
		ContractBasicInfo findById = formulationMng.findById(cid);
			if("0".equals(ctype)){//未变更
				Finder finder=Finder.create("FROM ProceedsPlan WHERE dataType='0' AND fContId="+cid);
				payedPlan = super.find(finder);
			}else if("1".equals(ctype)){//有变更
				Finder finder=Finder.create("FROM ProceedsPlan WHERE dataType='1' AND fContId="+cid);
				Finder finder1=Finder.create("FROM ProceedsPlan WHERE fStauts ='1' and dataType='0' AND fContId="+cid);
				payedPlan = super.find(finder);
				List<ProceedsPlan> unPayPlan = super.find(finder1);
				for (int i = 0; i < unPayPlan.size(); i++) {
					payedPlan.add(unPayPlan.get(i));
				}
			}
		return payedPlan;
	}

	@Override
	public Pagination pagelist(ContractBasicInfo contractBasicInfo,ProceedsPlan bean, Integer page, Integer rows, User user) {
		Finder finder =Finder.create(" FROM ContractBasicInfo WHERE fFlowStauts='9'  AND fcType='HTFL-02' and fsealedStatus=1 and fUpdateStatus='0'");
		if(!StringUtil.isEmpty(contractBasicInfo.getFcCode())){
			finder.append("AND fcCode LIKE :fcCode ");
			finder.setParam("fcCode", "%"+contractBasicInfo.getFcCode()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcTitle())){
			finder.append("AND fcTitle LIKE :fcTitle ");
			finder.setParam("fcTitle", "%"+contractBasicInfo.getFcTitle()+"%");
		}
		String deptIdStr=departMng.getDeptIdStrByUser(user);
		List<Role> roles=user.getRoles();
		for (Role role : roles) {
			if("出纳岗".equals(role.getName())){
				deptIdStr = "all";
			}
		}
 		if("".equals(deptIdStr)){ //普通岗位只能查看自己的
 			finder.append(" and fOperatorId = :fOperatorId").setParam("fOperatorId", user.getId());
 		}else if("all".equals(deptIdStr)){//校长可以查看所有人的
 			
 		}else{//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
 			finder.append(" and fDeptId in ("+deptIdStr+")");
 		}
		if(contractBasicInfo.getfReqtIME()!=null){
			finder.append("AND datediff(fReqtIME,'"+contractBasicInfo.getfReqtIME()+"')=0");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcAmount())){
			finder.append("AND fcAmount LIKE :fcAmount ");
			finder.setParam("fcAmount", "%"+contractBasicInfo.getFcAmount()+"%");
		}
		
		finder.append(" order by updateTime desc");
		Pagination p = super.find(finder, page, rows);
		List<ContractBasicInfo> li = (List<ContractBasicInfo>) p.getList();
		for (int i = 0; i < li.size(); i++) {
			String dataType ="0";
			String getfUpdateStatus = li.get(i).getfUpdateStatus();
			getfUpdateStatus = "1";
			if(getfUpdateStatus.equals("1")){
				dataType ="1";
			}
			// AND F_DATA_TYPE ="+dataType+" 
			String str="SELECT ROUND(SUM(F_PROCEEDS_AMOUNT_SJ),2) FROM T_PROCEEDS_PLAN WHERE F_CONT_ID="+li.get(i).getFcId()+" AND F_STAUTS='1'";
			Query query=getSession().createSQLQuery(str);
			List<Double> l = query.list();
			Double c1 =0.00;//合同金额
			Double sumAomunt = l.get(0) == null ? 0.00:l.get(0);//已付金额
			if(StringUtil.isEmpty(String.valueOf(sumAomunt))){
				sumAomunt=0.00;
			}else{
				c1 = (Double.valueOf(li.get(i).getFcAmount()));
				DecimalFormat df = new DecimalFormat("0.00");//格式化小数   
				String percentage=df.format((sumAomunt/c1)*100)+"%";
				li.get(i).setPercentage(percentage);
				li.get(i).setfAllAmount(String.valueOf(sumAomunt));
				li.get(i).setfNotAllAmountL(String.valueOf(c1-sumAomunt));
			}
			if(StringUtil.isEmpty(String.valueOf(c1))||(c1==0.0)){
				c1=0.00;
				li.get(i).setPercentage("0.00%");
			}
			if(StringUtil.isEmpty(li.get(i).getfAllAmount())){
				li.get(i).setfAllAmount("0.00");
			}
			if(StringUtil.isEmpty(li.get(i).getfNotAllAmountL())){
				li.get(i).setfNotAllAmountL(String.valueOf(c1-sumAomunt));
			}
		}
		for (int i = li.size()-1; i >=0; i--) {
			Double Percentage = Double.valueOf(li.get(i).getPercentage().substring(0, li.get(i).getPercentage().length()-1));
			Double PercentageTempStart=0.00;
			if(contractBasicInfo.getPercentageTempStart()!=null){
				PercentageTempStart = contractBasicInfo.getPercentageTempStart()*100;
			}
			Double PercentageTempEndt = 0.00;
			if(contractBasicInfo.getPercentageTempEnd()!=null){
				PercentageTempEndt = contractBasicInfo.getPercentageTempEnd()*100;
			}
			
			if(PercentageTempEndt==0.00 && PercentageTempStart==0.00){
				
			}else{
				if(Percentage<PercentageTempStart||Percentage>PercentageTempEndt){
					li.remove(i);
				}
			}
		}
		
		p.setList(li);
		return p;
	}

	@Override
	public void editAffirm(ProceedsPlan bean) {
		ProceedsPlan plan = super.findById(bean.getfPId());
		ContractBasicInfo contractBasicInfo = formulationMng.findById(bean.getfContId());
		if(bean.getDataType().toString().equals("0")){//如果数据类型是0  代表原合同的收入明细   需要去查询  单据是否有在变更 如果在变更提示不允许确认收款
			if("2".equals(contractBasicInfo.getfUpdateStatus())){
				throw new ServiceException("当前合同正在变更中，请变更完成后再进行操作！");
			}
			plan.setAccountantNum(bean.getAccountantNum());//会计凭证号
			plan.setfReceTime(bean.getfReceTime());//实际付款时间
			plan.setfStauts("1");//确认收款状态
		}else{
			plan.setAccountantNum(bean.getAccountantNum());//会计凭证号
			plan.setfReceTime(bean.getfReceTime());//实际付款时间
			plan.setfStauts("1");//确认收款状态
		}
		super.saveOrUpdate(plan);

		if(bean.getDataType()==0){
			List<ProceedsPlan> proceedsPlans = findbyConId(bean.getfContId());
			boolean flag = true;
			for (ProceedsPlan proceedsPlan : proceedsPlans) {
				if(!"1".equals(proceedsPlan.getfStauts())&&proceedsPlan.getfPId()!=bean.getfPId()){
					flag = false;
					break;
				}
			}
			if(!"1".equals(contractBasicInfo.getIfReim())){
				if(!flag){
					contractBasicInfo.setIfReim("0");//未报销完
				}else{
					contractBasicInfo.setIfReim("1");//已报销完
				}
				formulationMng.merge(contractBasicInfo);
			}
		}else{
			List<ProceedsPlan> proceedsPlans = findbyUptId(bean.getfUptId());
			Upt upt = uptMng.findById(bean.getfUptId());
			boolean flag = true;
			for (ProceedsPlan proceedsPlan : proceedsPlans) {
				if(!"1".equals(proceedsPlan.getfStauts())&&proceedsPlan.getfPId()!=bean.getfPId()){
					flag = false;
					break;
				}
			}
			if(!flag){
				if(!"1".equals(contractBasicInfo.getIfReim())){
					contractBasicInfo.setIfReim("0");//未报销完
				}
				upt.setIfReim("0");//未报销完
			}else{
				contractBasicInfo.setIfReim("1");//已报销完
				upt.setIfReim("1");//已报销完
			}
			formulationMng.merge(contractBasicInfo);
			uptMng.merge(upt);
		}
	}

	@Override
	public List<ProceedsPlan> findbyConId(Integer conId) {
		Finder finder=Finder.create("FROM ProceedsPlan WHERE dataType='0' AND fContId="+conId);
		return super.find(finder);
	}
	
	/*
	 * 送审合同付款申请信息
	 * @author 叶崇晖
	 * @createtime 2018-08-20
	 * @updatetime 2018-08-20
	 */
	public void savesk(ContPay bean, ProceedsPlan receivPlanBean,  User user,String fhtzxFiles,ReimbPayeeInfo payee, String form1)  throws Exception{
		
		if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), "HTFKSQ", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("HTSR", user.getDpID());
			Integer flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			User nextUser=userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号		
			bean.setUserName2(nextUser.getName());
			bean.setFUserId(nextUser.getId());
			//设置下节点节点编码
			bean.setnCode(firstKey+"");	
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
		}
		Date d = new Date();
		bean.setPayCode(StringUtil.Random("HTSR"));
		bean.setReqTime(d);
		bean.setUserName(user.getName());
		bean.setUserNameID(user.getId());
		bean.setDepateName(user.getDepartName());
		bean.setDepateID(user.getDepart().getId());
		bean.setPlanId(receivPlanBean.getfPId());
		bean.setCashierType("0");
		if (bean.getfReAmount() != null) {
			receivPlanBean.setfProceedsAmountsj(bean.getfReAmount().doubleValue());
		}
		if (bean.getfReceAmount() != null) {
			receivPlanBean.setfProceedsAmount(bean.getfReceAmount().doubleValue());
		}
		super.saveOrUpdate(receivPlanBean);
		bean = (ContPay) super.saveOrUpdate(bean);
		attachmentMng.joinEntity(bean,fhtzxFiles);
		if(bean.getStauts().equals("1")){
			ContractBasicInfo cbi=formulationMng.findById(receivPlanBean.getfContId());
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(bean.getFUserId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getPayId());//申请单ID
			work.setTaskCode(bean.getPayCode());//为申请单的单号
			work.setTaskName("[合同收入]"+cbi.getFcTitle());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/proceedsPlan/checkPro?id="+receivPlanBean.getfContId()+"&fPlanId="+receivPlanBean.getfPId());//为审批页面内容显示的url,需要将数据传入不然无法访问
			work.setUrl1("/proceedsPlan/detailPro?id="+receivPlanBean.getfContId()+"&fPlanId="+receivPlanBean.getfPId());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型：1-审批
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(new Date());//任务提交时间
			personalWorkMng.merge(work);
			
			
			//添加一个自己的已办事项
			PersonalWork minwork = new PersonalWork();
			minwork.setUserId(user.getId());//任务处理人ID既是下节点处理人ID
			minwork.setTaskId(bean.getPayId());//申请单ID
			minwork.setTaskCode(bean.getPayCode());//为申请单的单号
			minwork.setTaskName("[合同收入]"+cbi.getFcTitle());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			minwork.setUrl("/proceedsPlan/edits?id="+receivPlanBean.getfContId()+"&fPlanId="+receivPlanBean.getfPId());//退回修改url
			minwork.setUrl1("/proceedsPlan/detailPro?id="+receivPlanBean.getfContId()+"&fPlanId="+receivPlanBean.getfPId());//查看url
			minwork.setUrl2("");//退回删除url
			minwork.setTaskStauts("2");//待办
			minwork.setType("2");//任务类型：2-查看
			minwork.setBeforeUser(user.getName());//任务提交人姓名
			minwork.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			minwork.setBeforeTime(new Date());//任务提交时间
			minwork.setFinishTime(new Date());
			personalWorkMng.merge(minwork);
			//修改付款计划中的付款申请审批记录（1为提交待审批）和实际付款金额
			ProceedsPlan receivPlan = proceedsPlanMng.findById(receivPlanBean.getfPId());
			receivPlan.setPayStauts("1");
			receivPlan.setProId(bean.getPayId());
			saveOrUpdate(receivPlan);
			//getSession().createSQLQuery("UPDATE T_PROCEEDS_PLAN SET F_PAY_STAUTS='1' WHERE F_P_ID="+receivPlanBean.getfPId()).executeUpdate();
			//getSession().createSQLQuery("UPDATE T_PROCEEDS_PLAN SET F_PRO_ID ="+bean.getPayId()+" WHERE F_P_ID="+receivPlanBean.getfPId()).executeUpdate();
		}else{
			ProceedsPlan receivPlan = proceedsPlanMng.findById(receivPlanBean.getfPId());
			receivPlan.setPayStauts("0");
			receivPlan.setProId(bean.getPayId());
			saveOrUpdate(receivPlan);
			//getSession().createSQLQuery("UPDATE T_PROCEEDS_PLAN SET F_PAY_STAUTS='0',F_PRO_ID ="+bean.getPayId()+" WHERE F_P_ID='"+receivPlanBean.getfPId()+"'").executeUpdate();
		}
		/*//保存   报销中的收款人
		payee.setContId(bean.getPayId());
		super.merge(payee);*/
	}
	

	@Override
	public String reCall(Integer id) throws Exception {
		//根据id查询对象
		ProceedsPlan findById = proceedsPlanMng.findById(Integer.valueOf(id));
		ContPay bean=contPayMng.findUniqueByProperty("planId", findById.getfPId());
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="[合同收款]申请被撤回消息";
		String msg="您待审批的  "+findById.getfProceedsProperty() +",任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean=(ContPay) reCall((ContPay) bean);
		findById.setPayStauts("-4");
		this.updateDefault(findById);
		this.updateDefault(bean);
		return "操作成功";
	}
	
	@Override
	public Pagination pagelistCkeck(ContractBasicInfo contractBasicInfo,ProceedsPlan bean, Integer page, Integer rows, User user) {
		StringBuffer sql = new StringBuffer("SELECT t1.*,t2.F_CONT_ID FROM t_cont_pay t1,T_PROCEEDS_PLAN t2,t_contract_basic_info t3 WHERE t1.F_PLAN_ID=t2.F_P_ID AND t2.F_CONT_ID=t3.F_CONT_ID AND t3.F_CONT_TYPE='HTFL-02' AND t3.F_SEALED_STATUS=1");
		sql.append(" AND t1.F_USER_ID='"+user.getId()+"' AND t1.F_FLOW_STAUTS in('1','0')");
		if (!StringUtil.isEmpty(String.valueOf(bean.getFcTitle()))) {
			sql.append(" AND t3.F_CONT_TITLE LIKE '%"+bean.getFcTitle()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getFcCode()))) {
			sql.append(" AND t3.F_CONT_CODE LIKE '%"+bean.getFcCode()+"%'");
		}
		sql.append(" order by F_PROCEEDS_TIME desc");
		//String deptIdStr=departMng.getDeptIdStrByUser(user);
 		/*if("".equals(deptIdStr)){ //普通岗位只能查看自己的
 			finder.append(" and fOperatorId = :fOperatorId").setParam("fOperatorId", user.getId());
 		}else if("all".equals(deptIdStr)){//校长可以查看所有人的
 			
 		}else{//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
 			finder.append(" and fDeptId in ("+deptIdStr+")");
 		}*/
		/*if(contractBasicInfo.getfReqtIME()!=null){
			finder.append("AND datediff(fReqtIME,'"+contractBasicInfo.getfReqtIME()+"')=0");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcAmount())){
			finder.append("AND fcAmount LIKE :fcAmount ");
			finder.setParam("fcAmount", "%"+contractBasicInfo.getFcAmount()+"%");
		}
		
		finder.append(" order by updateTime desc");*/
		//Pagination p = super.find(finder, page, rows);
		Query query = getSession().createSQLQuery(sql.toString()).addEntity(ContPay.class);
		List<ContPay> li = query.list();
		List<ContractBasicInfo> list = new ArrayList<ContractBasicInfo>();
		//List<ContractBasicInfo> li = (List<ContractBasicInfo>) p.getList();
		for (int i = 0; i < li.size(); i++) {
			//String dataType ="0";
			//String getfUpdateStatus = li.get(i).getfUpdateStatus();
			//getfUpdateStatus = "1";
			//if(getfUpdateStatus.equals("1")){
			//	dataType ="1";
			//}
			// AND F_DATA_TYPE ="+dataType+" 
			ContractBasicInfo contractBasic = new ContractBasicInfo();
			ProceedsPlan findById = proceedsPlanMng.findById(li.get(i).getPlanId());
			ContractBasicInfo info = filingMng.findById(Integer.valueOf(findById.getfContId()));
			String str="SELECT ROUND(SUM(F_PROCEEDS_AMOUNT_SJ),2) FROM T_PROCEEDS_PLAN WHERE F_CONT_ID="+findById.getfContId()+" AND F_STAUTS='1'";
			Query query1=getSession().createSQLQuery(str);
			List<Double> l = query1.list();
			Double c1 =0.00;//合同金额
			Double sumAomunt = l.get(0) == null ? 0.00:l.get(0);//已付金额
			if(StringUtil.isEmpty(String.valueOf(sumAomunt))){
				sumAomunt=0.00;
			}else{
				c1 = (Double.valueOf(info.getFcAmount()));
				DecimalFormat df = new DecimalFormat("0.00");//格式化小数   
				String percentage=df.format((sumAomunt/c1)*100)+"%";
				contractBasic.setPercentage(percentage);
				contractBasic.setfAllAmount(String.valueOf(sumAomunt));
				contractBasic.setfNotAllAmountL(String.valueOf(c1-sumAomunt));
			}
			if(StringUtil.isEmpty(String.valueOf(c1))||(c1==0.0)){
				c1=0.00;
				contractBasic.setPercentage("0.00%");
			}
			if(StringUtil.isEmpty(info.getfAllAmount())){
				contractBasic.setfAllAmount("0.00");
			}
			if(StringUtil.isEmpty(info.getfNotAllAmountL())){
				contractBasic.setfNotAllAmountL(String.valueOf(c1-sumAomunt));
			}
			contractBasic.setFcCode(info.getFcCode());
			contractBasic.setFcTitle(info.getFcTitle());
			contractBasic.setFcAmount(info.getFcAmount());
			contractBasic.setfDeptName(info.getfDeptName());
			contractBasic.setFlowStauts(li.get(i).getFlowStauts());
			contractBasic.setfOperator(info.getfOperator());
			contractBasic.setfProceeds(findById.getfProceedsProperty());
			contractBasic.setBcSkAmount(findById.getfProceedsAmountsj());
			contractBasic.setFcId(info.getFcId());
			contractBasic.setfPlanId(li.get(i).getPlanId());
			list.add(contractBasic);
		}
		/*for (int i = li.size()-1; i >=0; i--) {
			Double Percentage = Double.valueOf(li.get(i).getPercentage().substring(0, li.get(i).getPercentage().length()-1));
			Double PercentageTempStart=0.00;
			if(contractBasicInfo.getPercentageTempStart()!=null){
				PercentageTempStart = contractBasicInfo.getPercentageTempStart()*100;
			}
			Double PercentageTempEndt = 0.00;
			if(contractBasicInfo.getPercentageTempEnd()!=null){
				PercentageTempEndt = contractBasicInfo.getPercentageTempEnd()*100;
			}
			
			if(PercentageTempEndt==0.00 && PercentageTempStart==0.00){
				
			}else{
				if(Percentage<PercentageTempStart||Percentage>PercentageTempEndt){
					li.remove(i);
				}
			}
		}*/
		int totalCount = list.size();
		Pagination p = new Pagination(page, rows, totalCount);
		p.setList(list);
		//p.setList(li);
		return p;
	}
	
	
	
	@Override
	public void saveProCheckInfo(TProcessCheck checkBean, ContPay bean, ProceedsPlan proceedsPlan, User user,String files)  throws Exception{
		bean=(ContPay) contPayMng.findById(bean.getPayId());
		
		CheckEntity entity=(CheckEntity)bean;
		String url="/proceedsPlan/checkPro?id="+proceedsPlan.getfContId()+"&fPlanId="+proceedsPlan.getfPId()+"&fid=";
		String url1 ="/proceedsPlan/detailPro?id="+proceedsPlan.getfContId()+"&fPlanId="+proceedsPlan.getfPId()+"&fid=";
		bean=(ContPay)tProcessCheckMng.checkProcess(checkBean, entity, user, "HTSR", url, url1,files);
		super.saveOrUpdate(bean);
		//修改付款计划中的付款申请审批记录
		getSession().createSQLQuery("UPDATE T_PROCEEDS_PLAN SET F_PAY_STAUTS='"+bean.getFlowStauts()+"' WHERE F_P_ID='"+proceedsPlan.getfPId()+"'").executeUpdate();
	
		//审批全部通过
		if("9".equals(bean.getFlowStauts())){
			getSession().createSQLQuery("UPDATE T_PROCEEDS_PLAN SET F_STAUTS='1' WHERE F_P_ID='"+proceedsPlan.getfPId()+"'").executeUpdate();
		}
		
	}
}
