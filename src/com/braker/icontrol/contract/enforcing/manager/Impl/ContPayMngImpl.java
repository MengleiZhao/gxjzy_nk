package com.braker.icontrol.contract.enforcing.manager.Impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.RoleMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.contract.Formulation.manager.ApprovalMng;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.enforcing.manager.ContPayMng;
import com.braker.icontrol.contract.enforcing.manager.UptMng;
import com.braker.icontrol.contract.enforcing.model.ContPay;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.manager.ReceivPlanMng;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.icontrol.expend.reimburse.model.ContractReimburseInfo;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;

/**
 * 合同付款申请的service实现类
 * @author 叶崇晖
 * @createtime 2018-08-21
 * @updatetime 2018-08-21
 */
@Service
@Transactional
public class ContPayMngImpl extends BaseManagerImpl<ContPay> implements ContPayMng {
	@Autowired
	private ReceivPlanMng receivPlanMng;
	
	@Autowired
	private ApprovalMng approvalMng;
	
	@Autowired
	private ContPayMng contPayMng;
	
	@Autowired
	private PersonalWorkMng personalWorkMng;
	
	@Autowired
	private FormulationMng formulationMng;
	
	@Autowired
	private UserMng userMng;
	@Autowired
	private RoleMng roleMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private UptMng uptMng;
	@Autowired
	private FilingMng filingMng;
	@Autowired
	private CgApplysqMng cgsqMng;
	@Autowired
	private TProBasicInfoMng projectMng;
	/*
	 * 合同报销列表查询
	 * @author 叶崇晖
	 * @createtime 2018-08-21
	 * @updatetime 2018-08-21
	 */
	@Override
	public Pagination contractCheckPageList(ContPay bean, int pageNo, int pageSize, User user,String checkType) {
		//checkType(0位合同审批，1位财务审定)
		StringBuffer sql = new StringBuffer("SELECT t1.* FROM t_cont_pay t1,t_receiv_plan t2,t_contract_basic_info t3 WHERE t1.F_PLAN_ID=t2.F_PLAN_ID AND t2.F_CONT_ID=t3.F_CONT_ID");
		sql.append(" AND t1.F_USER_ID='"+user.getId()+"' AND t1.F_FLOW_STAUTS in('1','0')");
	/*	if(checkType.equals("0")){
			sql.append(" AND t1.F_N_CODE not in (SELECT F_N_ID FROM t_node_conf WHERE F_N_NAME='财务审定')");
		}*/
		
		if (!StringUtil.isEmpty(String.valueOf(bean.getFcTitle()))) {
			sql.append(" AND t3.F_CONT_TITLE LIKE '%"+bean.getFcTitle()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getFcCode()))) {
			sql.append(" AND t3.F_CONT_CODE LIKE '%"+bean.getFcCode()+"%'");
		}
		sql.append(" order by F_RECE_PLAN_TIME desc");
		Query query = getSession().createSQLQuery(sql.toString()).addEntity(ContPay.class);
		
		List<ContPay> li = query.list();
		List<ContractReimburseInfo> list = new ArrayList<ContractReimburseInfo>();
		for (int i = 0; i < li.size(); i++) {
			ReceivPlan rp = receivPlanMng.findById(li.get(i).getPlanId());
			ContractBasicInfo cbi = approvalMng.findById(rp.getfContId_R());
			ContractReimburseInfo info = new ContractReimburseInfo();
			info.setFcId(cbi.getFcId());
			info.setPayId(li.get(i).getPayId());
			info.setfPlanId(rp.getfPlanId());
			info.setfReceProperty(rp.getfReceProperty());
			info.setUserName(li.get(i).getUserName());
			info.setReqTime(li.get(i).getReqTime());
			info.setStauts(li.get(i).getStauts());
			info.setFlowStauts(li.get(i).getFlowStauts());
			info.setFcCode(cbi.getFcCode());
			info.setFcTitle(cbi.getFcTitle());
			info.setfRecePlanTime(rp.getfRecePlanTime());
			info.setfRecePlanAmount(rp.getfRecePlanAmount().doubleValue());
			info.setDeptName(li.get(i).getDepateName());
			list.add(info);
		}
		int totalCount = li.size();
		Pagination p = new Pagination(pageNo, pageSize, totalCount);
		p.setList(list);
		return p;
	}
	
	
	
	/*
	 * 保存合同报销的审批信息
	 * @author 叶崇晖
	 * @createtime 2018-08-21
	 * @updatetime 2018-08-21
	 */
	@Override
	public void saveContractCheckInfo(TProcessCheck checkBean, ContPay bean, ReceivPlan receivPlanBean, User user,String files)  throws Exception{
		bean=this.findById(bean.getPayId());
		CheckEntity entity=(CheckEntity)bean;
		String url="/reimburseCheck/check?id="+receivPlanBean.getfContId_R()+"&reimburseType=2&fPlanId="+receivPlanBean.getfPlanId()+"&payId="+bean.getPayId()+"&1=";
		String url1 ="/Enforcing/detailPay?id="+ receivPlanBean.getfContId_R()+"&fPlanId="+receivPlanBean.getfPlanId()+"&1=";
		//String url2 ="/audit/auditContract?id="+receivPlanBean.getfContId_R()+"&reimburseType=2&fPlanId="+receivPlanBean.getfPlanId()+"&payId="+bean.getPayId()+"&cashier=";
		ContractBasicInfo contractBasicInfos=filingMng.findById(receivPlanBean.getfContId_R());
		PurchaseApplyBasic cgsq = cgsqMng.findById(Integer.valueOf(contractBasicInfos.getfPurchNo()));
		TProBasicInfo pro = projectMng.findById(cgsq.getIndexId());
		String type = null;
		if (("JJ").equals(pro.getProUseType())) {
			type = "HTFKSQJJ";
		}else if (("WX").equals(pro.getProUseType())){
			type = "HTFKSQ";
		}else {
			type = "HYBX";
		}
		bean=(ContPay)tProcessCheckMng.checkProcess(checkBean, entity, user, type, url, url1,files);
		super.saveOrUpdate(bean);
		//修改付款计划中的付款申请审批记录
		getSession().createSQLQuery("UPDATE t_receiv_plan SET F_PAY_STAUTS='"+bean.getFlowStauts()+"' WHERE F_PLAN_ID='"+receivPlanBean.getfPlanId()+"'").executeUpdate();
	
		ContractBasicInfo contractBasicInfo=filingMng.findById(receivPlanBean.getfContId_R());
		if(receivPlanBean.getDataType()==0){
			List<ReceivPlan> receivPlans = receivPlanMng.findbyConId(receivPlanBean.getfContId_R());
			boolean flag = true;
			for (ReceivPlan receivPlan : receivPlans) {
				if(!"9".equals(receivPlan.getPayStauts())&&receivPlan.getfPlanId()!=receivPlanBean.getfPlanId()){
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
				filingMng.merge(contractBasicInfo);
			}
		}else{
			List<ReceivPlan> receivPlans = receivPlanMng.findbyUptId(receivPlanBean.getfUptId_R());
			Upt upt = uptMng.findById(receivPlanBean.getfUptId_R());
			boolean flag = true;
			for (ReceivPlan receivPlan : receivPlans) {
				if(!"9".equals(receivPlan.getPayStauts())&&receivPlan.getfPlanId()!=receivPlanBean.getfPlanId()){
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
			filingMng.merge(contractBasicInfo);
			uptMng.merge(upt);
		}
	}


	/*
	 * 出纳受理合同报销列表查询
	 * @author 叶崇晖
	 * @createtime 2018-08-22
	 * @updatetime 2018-08-22
	 */
	@Override
	public Pagination cashierPageList(ContPay bean, int pageNo, int pageSize, User user) {
		//checkType(0位合同审批，1位财务审定)
		StringBuffer sql = new StringBuffer("SELECT t1.* FROM t_cont_pay t1,t_receiv_plan t2,t_contract_basic_info t3 WHERE t1.F_PLAN_ID=t2.F_PLAN_ID AND t2.F_CONT_ID=t3.F_CONT_ID");
		sql.append(" AND t1.F_FLOW_STAUTS in('9') ");
		if (!StringUtil.isEmpty(String.valueOf(bean.getFcTitle()))) {
			sql.append(" AND t3.F_CONT_TITLE LIKE '%"+bean.getFcTitle()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getFcCode()))) {
			sql.append(" AND t3.F_CONT_CODE LIKE '%"+bean.getFcCode()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getIsLedger()))) {
			String deptIdStr=departMng.getDeptIdStrByUser(user);
	 		if("".equals(deptIdStr)){ //普通岗位只能查看自己的
	 			sql.append(" and t1.F_OPERATOR_ID = '"+user.getId()+"' ");
	 		}else if("all".equals(deptIdStr)){//校长可以查看所有人的
	 			
	 		}else{//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
	 			sql.append(" and t1.F_OPERATOR_DEPT_ID in ("+deptIdStr+")");
	 		}
		}
		Query query = getSession().createSQLQuery(sql.toString()).addEntity(ContPay.class);
		List<ContPay> li =query.list();
		List<ContractReimburseInfo> list = new ArrayList<ContractReimburseInfo>();
		for (int i = 0; i < li.size(); i++) {
			ReceivPlan rp = receivPlanMng.findById(li.get(i).getPlanId());
			ContractBasicInfo cbi = approvalMng.findById(rp.getfContId_R());
			ContractReimburseInfo info = new ContractReimburseInfo();
			info.setPayCode(li.get(i).getPayCode());
			info.setFcId(cbi.getFcId());
			info.setPayId(li.get(i).getPayId());
			info.setfPlanId(rp.getfPlanId());
			info.setfReceProperty(rp.getfReceProperty());
			info.setUserName(li.get(i).getUserName());
			info.setReqTime(li.get(i).getReqTime());
			info.setStauts(li.get(i).getStauts());
			info.setFlowStauts(li.get(i).getFlowStauts());
			info.setFcCode(cbi.getFcCode());
			info.setFcTitle(cbi.getFcTitle());
			info.setfRecePlanTime(rp.getfRecePlanTime());
			info.setfRecePlanAmount(rp.getfRecePlanAmount().doubleValue());
			info.setPayStauts(rp.getfStauts_R());
			info.setDeptName(li.get(i).getDepateName());
			list.add(info);
		}
		int totalCount = li.size();
		Pagination p = new Pagination(pageNo, pageSize, totalCount);
		p.setList(list);
		return p;
	}



	@Override
	public List<ContPay> findByFPlanid(Integer id) {
		Finder finder = Finder.create(" FROM ContPay WHERE planId='"+id+"'");
		return super.find(finder);
	}
}
