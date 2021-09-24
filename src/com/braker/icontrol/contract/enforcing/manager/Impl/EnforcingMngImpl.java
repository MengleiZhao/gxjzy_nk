package com.braker.icontrol.contract.enforcing.manager.Impl;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
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
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.enforcing.manager.ContPayMng;
import com.braker.icontrol.contract.enforcing.manager.EnforcingMng;
import com.braker.icontrol.contract.enforcing.model.ContPay;
import com.braker.icontrol.contract.filing.manager.ReceivPlanMng;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.reimburse.manager.InvoiceCouponMng;
import com.braker.icontrol.expend.reimburse.model.InvoiceCouponInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbPayeeInfo;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

@Service
@Transactional
public class EnforcingMngImpl extends BaseManagerImpl<ContractBasicInfo> implements EnforcingMng{

	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private FormulationMng formulationMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private DepartMng departMng;
	
	@Autowired
	private TNodeDataMng tNodeDataMng;

	@Autowired
	private UserMng userMng;
	
	@Autowired
	private ReceivPlanMng receivPlanMng;
	
	@Autowired
	private ContPayMng contPayMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	@Autowired
	private InvoiceCouponMng invoiceCouponMng;
	@Autowired
	private CgApplysqMng cgsqMng;
	@Autowired
	private TProBasicInfoMng projectMng;
	
	@Override
	public Pagination queryList_E(ContractBasicInfo contractBasicInfo, User user, Integer pageNo, Integer pageSize) {
		Finder finder =Finder.create(" FROM ContractBasicInfo WHERE fFlowStauts='9'  AND fcType='HTFL-01' and fsealedStatus=1");
		if(!StringUtil.isEmpty(contractBasicInfo.getFcCode())){
			finder.append("AND fcCode LIKE :fcCode ");
			finder.setParam("fcCode", "%"+contractBasicInfo.getFcCode()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcTitle())){
			finder.append("AND fcTitle LIKE :fcTitle ");
			finder.setParam("fcTitle", "%"+contractBasicInfo.getFcTitle()+"%");
		}
		String deptIdStr=departMng.getDeptIdStrByUser(user);
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
		Pagination p = super.find(finder, pageNo, pageSize);
		List<ContractBasicInfo> li = (List<ContractBasicInfo>) p.getList();
		for (int i = 0; i < li.size(); i++) {
			String dataType ="0";
			String getfUpdateStatus = li.get(i).getfUpdateStatus();
			getfUpdateStatus = "1";
			if(getfUpdateStatus.equals("1")){
				dataType ="1";
			}
			// AND F_DATA_TYPE ="+dataType+" 
			String str="SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),2) FROM T_RECEIV_PLAN WHERE F_CONT_ID="+li.get(i).getFcId()+" AND F_PAY_STAUTS='9'";
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

	
	/*
	 * 送审合同付款申请信息
	 * @author 叶崇晖
	 * @createtime 2018-08-20
	 * @updatetime 2018-08-20
	 */
	@Override
	public void save(ContPay bean, ReceivPlan receivPlanBean,  User user,String fhtzxFiles,ReimbPayeeInfo payee, String form1)  throws Exception{
		
		if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), "HTFKSQ", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			ContractBasicInfo cbi=formulationMng.findById(receivPlanBean.getfContId_R());
			PurchaseApplyBasic cgsq = cgsqMng.findById(Integer.valueOf(cbi.getfPurchNo()));
			TProBasicInfo pro = projectMng.findById(cgsq.getIndexId());
			String type = null;
			if (("JJ").equals(pro.getProUseType())) {
				type = "HTFKSQJJ";
			}else if (("WX").equals(pro.getProUseType())){
				type = "HTFKSQ";
			}else {
				type = "HYBX";
			}
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode(type, user.getDpID());
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
		bean.setPayCode(StringUtil.Random("HTFKSQ"));
		bean.setReqTime(d);
		bean.setUserName(user.getName());
		bean.setUserNameID(user.getId());
		bean.setDepateName(user.getDepartName());
		bean.setDepateID(user.getDepart().getId());
		super.saveOrUpdate(receivPlanBean);
		bean.setPlanId(receivPlanBean.getfPlanId());
		bean.setCashierType("0");
		bean = (ContPay) super.saveOrUpdate(bean);
		attachmentMng.joinEntity(bean,fhtzxFiles);
		if(bean.getStauts().equals("1")){
			ContractBasicInfo cbi=formulationMng.findById(receivPlanBean.getfContId_R());
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(bean.getFUserId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getPayId());//申请单ID
			work.setTaskCode(bean.getPayCode());//为申请单的单号
			work.setTaskName("[合同报销]"+cbi.getFcTitle());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/reimburseCheck/check?id="+receivPlanBean.getfContId_R()+"&reimburseType=2&fPlanId="+receivPlanBean.getfPlanId()+"&payId="+bean.getPayId());//为审批页面内容显示的url,需要将数据传入不然无法访问
			work.setUrl1("/Enforcing/detailPay?id="+receivPlanBean.getfContId_R()+"&fPlanId="+receivPlanBean.getfPlanId());//查看url
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
			minwork.setTaskName("[合同报销]"+cbi.getFcTitle());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			minwork.setUrl("/Enforcing/edit?id="+receivPlanBean.getfContId_R()+"&fPlanId="+receivPlanBean.getfPlanId());//退回修改url
			minwork.setUrl1("/Enforcing/detailPay?id="+receivPlanBean.getfContId_R()+"&fPlanId="+receivPlanBean.getfPlanId());//查看url
			minwork.setUrl2("");//退回删除url
			minwork.setTaskStauts("2");//待办
			minwork.setType("2");//任务类型：2-查看
			minwork.setBeforeUser(user.getName());//任务提交人姓名
			minwork.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			minwork.setBeforeTime(new Date());//任务提交时间
			minwork.setFinishTime(new Date());
			personalWorkMng.merge(minwork);
			//修改付款计划中的付款申请审批记录（1为提交待审批）和实际付款金额
			getSession().createSQLQuery("UPDATE t_receiv_plan SET F_PAY_STAUTS='1',F_PAY_ID ="+bean.getPayId()+" WHERE F_PLAN_ID='"+receivPlanBean.getfPlanId()+"'").executeUpdate();
		}else{
			getSession().createSQLQuery("UPDATE t_receiv_plan SET F_PAY_STAUTS='0',F_PAY_ID ="+bean.getPayId()+" WHERE F_PLAN_ID='"+receivPlanBean.getfPlanId()+"'").executeUpdate();
		}
		//保存   报销中的收款人
		payee.setContId(bean.getPayId());
		super.merge(payee);

		//旧发票
		List<InvoiceCouponInfo> oldfp1 = invoiceCouponMng.findByrID(bean.getPayId(),"contract");
		//新发票
		List<InvoiceCouponInfo> newfp1 =  JSON.parseObject(form1, new TypeReference<List<InvoiceCouponInfo>>(){});
		//旧发票
		//删除旧发票
		for (int h = 0; h < oldfp1.size(); h++) {
			if(!StringUtil.isEmpty(oldfp1.get(h).getFileId())&&!"null".equals(oldfp1.get(h).getFileId())){
				Attachment attachment=attachmentMng.findById(oldfp1.get(h).getFileId());
				if(attachment!=null){
					attachment.setFlag("0");
					attachment.setUpdator(user);
					attachment.setUpdateTime(new Date());
					attachmentMng.updateDefault(attachment);
				}
			}
			invoiceCouponMng.delete(oldfp1.get(h));
		}
		//新增发票
		for (int i = 0; i < newfp1.size(); i++) {
			InvoiceCouponInfo newrd = newfp1.get(i);
			newrd.setrId(bean.getPayId());
			newrd.setfDataType("contract");
			//保存新的明细
			super.merge(newrd);
		}	

	}


	@Override
	public String contractReCall(Integer id) throws Exception {
		//根据id查询对象
		ReceivPlan receivPlan= receivPlanMng.findById(id);
		ContPay bean=contPayMng.findUniqueByProperty("planId", receivPlan.getfPlanId());
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="[合同付款]申请被撤回消息";
		String msg="您待审批的  "+receivPlan.getfRecStage() +",任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean=(ContPay) reCall((ContPay) bean);
		receivPlan.setPayStauts("-4");
		this.updateDefault(receivPlan);
		this.updateDefault(bean);
		return "操作成功";
	}

}
