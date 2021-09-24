/*
	 * 保存采购付款单的出纳受理信息
	 * @author 叶崇晖
	 * @createtime 2018-08-24
	 * @updatetime 2018-08-24
	 */package com.braker.icontrol.expend.cashier.manager.impl;

import java.math.BigDecimal;
import java.rmi.ServerException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.MatheUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.EconomicMng;
import com.braker.core.manager.LookupsMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Depart;
import com.braker.core.model.Economic;
import com.braker.core.model.Lookups;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.budget.release.entity.TIndexDetail;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgBidMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgSelMng;
import com.braker.icontrol.cgmanage.cgprocess.model.BidRegist;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.enforcing.model.ContPay;
import com.braker.icontrol.contract.filing.manager.FilingMng;
import com.braker.icontrol.contract.filing.manager.ReceivPlanMng;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.icontrol.contract.filing.model.SignInfo;
import com.braker.icontrol.expend.apply.manager.ApplyMng;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.apply.model.BudgetMessageList;
import com.braker.icontrol.expend.cashier.manager.CashierMng;
import com.braker.icontrol.expend.cashier.model.CashierAcceptInfo;
import com.braker.icontrol.expend.loan.manager.LoanMng;
import com.braker.icontrol.expend.loan.manager.PaymentMng;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;
import com.braker.icontrol.expend.loan.model.Payment;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbAppliMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbDetailMng;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbDetail;
import com.braker.icontrol.expend.voucher.manager.VoucherMng;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;

/**
 * 出纳受理的service实现类
 * @author 叶崇晖
 * @createtime 2018-08-23
 * @updatetime 2018-08-23
 */
@Service
@Transactional
public class CashierMngImpl extends BaseManagerImpl<CashierAcceptInfo> implements CashierMng {
	@Autowired
	private DirectlyReimbMng directlyReimbMng;
	
	@Autowired
	private ReimbAppliMng reimbAppliMng;
	
	@Autowired
	private ReimbDetailMng reimbDetailMng;
	
	@Autowired
	private FilingMng filingMng;
	
	@Autowired
	private ReceivPlanMng receivPlanMng;
	
	@Autowired
	private CgBidMng cgbidMng;
	
	@Autowired
	private CgSelMng cgselMng;
	
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	
	@Autowired
	private LoanMng loanMng;
	
	@Autowired
	private PersonalWorkMng personalWorkMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private ApplyMng applyMng;
	
	@Autowired
	private DepartMng departMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private VoucherMng voucherMng;
	
	@Autowired
	private TProExpendDetailMng tProExpendDetailMng;
	
	@Autowired
	private FormulationMng formulationMng;
	
	@Autowired
	private LookupsMng lookupsMng;
	
	@Autowired
	private EconomicMng economicMng;
	
	@Autowired
	private TProBasicInfoMng projectMng;
	
	@Autowired
	private PrivateInforMng privateInforMng;
	
	@Autowired
	private PaymentMng paymentMng;
	
	@Autowired
	private CgApplysqMng cgsqMng;
	/*
	 * 保存合同付款单的出纳受理信息
	 * @author 叶崇晖
	 * @createtime 2018-08-24
	 * @updatetime 2018-08-24
	 */
	@Override
	public void saveContractCashierInfo(CashierAcceptInfo cashierBean,ContPay bean, ReceivPlan receivPlanBean, User user,TProcessCheck checkBean,String files,String bankAccountId,String economicCode) {
		Date date = new Date();
		cashierBean.setContId(bean.getPayId());
		ContractBasicInfo contractBasicInfo=filingMng.findById(Integer.valueOf(receivPlanBean.getfContId_R()));
		SignInfo payeeInfo = filingMng.find_Sign(contractBasicInfo).get(0);
		cashierBean.setPayee(payeeInfo.getfSignName());//保存收款人名称
		cashierBean.setAccount(payeeInfo.getfCardNo());//保存收款人账户
		cashierBean.setBank(payeeInfo.getfBankName());//保存收款人银行
		cashierBean.setAmount(bean.getfReceAmount());//保存收款金额
		cashierBean.setUserId(user.getId());//保存受理人id
		cashierBean.setAcceptTime(date);
		cashierBean.setStauts("1");
		cashierBean.setResult(checkBean.getFcheckResult());
		cashierBean.setRemark(checkBean.getFcheckRemake());
		//保存出纳受理信息
		super.saveOrUpdate(cashierBean);
		if("0".equals(checkBean.getFcheckResult())) {
			//不通过
			bean.setUserName2(null);
			bean.setFUserId(null);
			bean.setnCode(null);
			
			bean.setFlowStauts("-1");
			bean.setStauts("0");
			
			super.merge(bean);
			
			//首先修改自己的待办信息，将待办改为已办，将审批的url改为查看的url
			List<PersonalWork> workList = personalWorkMng.findByCodeAndUser(bean.getPayCode(), user);
			if (workList != null && workList.size() > 0) {
				PersonalWork work = workList.get(0);
				work.setTaskStauts("2");
				work.setType("2");//查看
				work.setFinishTime(date);
				super.merge(work);
			}
			//把申请人的已办改为代办，将已办的url改为修改的url
			List<PersonalWork> worklost = personalWorkMng.findByCodeAndUser(bean.getPayCode(), userMng.findById(bean.getUserNameID()));
			if (worklost != null && worklost.size() > 0) {
				PersonalWork work = worklost.get(0);
				work.setTaskStauts("0");
				work.setType("3");//退回修改
				super.merge(work);
			}
			
			//修改付款计划中的付款申请审批记录（-1为提交已退回）
			getSession().createSQLQuery("UPDATE t_receiv_plan SET F_PAY_STAUTS='-1' WHERE F_PLAN_ID='"+receivPlanBean.getfPlanId()+"'").executeUpdate();
		} else if("1".equals(checkBean.getFcheckResult())) {
			//通过
			//出纳受理必定为最后一人，清空下一审批人姓名、编号 及 下一审批节点，设置报销状态为1（已报销），设置审批状态为已审批（已通过）
			bean.setUserName2(null);
			bean.setFUserId(null);
			bean.setnCode(null);
			bean.setFlowStauts("9");
			bean.setCashierType("1");
			super.merge(bean);
			
			//修改付款计划中的付款申请审批记录（9为提交已审批）
			getSession().createSQLQuery("UPDATE t_receiv_plan SET F_PAY_STAUTS='9' WHERE F_PLAN_ID='"+receivPlanBean.getfPlanId()+"'").executeUpdate();
			
			receivPlanBean.setfReceAmount(bean.getfReceAmount());//填写付款计划的实际付款金额
			receivPlanBean.setfReceTime(date);//填写付款计划的实际付款时间
			receivPlanBean.setfStauts_R("1");
			//receivPlanBean.setPayStauts("99");
			super.merge(receivPlanBean);
			
			PersonalWork personalWork = personalWorkMng.getByCodeAndUser(bean.getPayCode(), userMng.findById(bean.getUserNameID()));//查询全部只需要user为null
			String url = personalWork.getUrl1();
			
			//审批全部通过,修改冻结金额
			deleteDjAmount(contractBasicInfo.getfBudgetIndexCode(),contractBasicInfo.getProDetailId(),bean.getfReceAmount(),
					bean.getfReceAmount(),contractBasicInfo.getfDeptId(),contractBasicInfo.getfOperatorId(),url,bean.getBeanCode(),"7");
			
			/*TProExpendDetail expendDetail = new TProExpendDetail();
			TBudgetIndexMgr bim = new TBudgetIndexMgr();
			String indexCodeAndName = null;
			String subName = null;//科目名称
			String subCode = null;//科目编码
			if(contractBasicInfo.getProDetailId() !=null){
				//项目支出
				//获取第四级指标名称（支出明细名称）
				expendDetail = tProExpendDetailMng.findById(contractBasicInfo.getProDetailId());
				subName = expendDetail.getSubName();//科目名称
				subCode = expendDetail.getSubCode();//科目编码
				//项目编号和名称
				bim = budgetIndexMgrMng.findById(contractBasicInfo.getfBudgetIndexCode());
				indexCodeAndName = "["+bim.getIndexCode()+"]\n"+bim.getIndexName();
			}else{
				//基本支出
				Economic economic = economicMng.findById(Integer.valueOf(economicCode));
				subName = economic.getName();//科目名称
				subCode = economic.getCode();//科目编码
				//项目编号和名称
				bim = budgetIndexMgrMng.findById(contractBasicInfo.getfBudgetIndexCode());
				String[] indexCode = bim.getIndexCode().split("-");
				indexCodeAndName = "["+indexCode[indexCode.length-1]+"]\n"+bim.getIndexName();
			}
			// 经济科目指标
			List<Economic> economicList = economicMng.findByProperty("code", subCode.substring(0,3));// 临时集合
			if(economicList!=null && economicList.size()>0){
				subName=subCode+"\n"+economicList.get(0).getName()+"_"+subName;
			}
			String fEconomicName=subName;
			//需要拼写银行字段（要全）
			//String id1 = contractBasicInfo.getBankAccountId();
			Lookups lookups = lookupsMng.findByLookCode(bankAccountId);
			String bankCode = lookups.getCode();
			bankCode = bankCode.split("-")[1];
			//银行编码和名称
			String bankCodeAndName = bankCode+"\n"+lookups.getName();
			String fSummary=contractBasicInfo.getFcTitle()+" 付"+contractBasicInfo.getFcTitle()+" 报销";*/
			//voucherMng.addVoucher(bean.getBeanCode(),fSummary,  bean.getDepateID(),bean.getDepateName(), indexCodeAndName,fEconomicName, Double.valueOf(bean.getfReceAmount()),Double.valueOf(contractBasicInfo.getFcAmount()),contractBasicInfo.getFundSource(),bankCodeAndName);
			
			
		}
		//根据资源名称和当前登陆者所属部门查询对应工作流
		TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("HTFKSQ", bean.getDepateID());
		Integer flowId= processDefin.getFPId();
		//添加流程审批记录
		/*TNodeData node =new TNodeData(user.getRoleCode(),user.getRoleName());
		try {
			tProcessCheckMng.addCheckHistory(checkBean,flowId, bean.getBeanCode(), bean.getUserId(),Integer.parseInt(checkBean.getFcheckResult()),user, node,files);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
	}

	/*
	 * 保存采购付款单的出纳受理信息
	 * @author 叶崇晖
	 * @createtime 2018-08-24
	 * @updatetime 2018-08-24
	 */
	@Override
	public void savePurchaseCashierInfo(CashierAcceptInfo cashierBean, PurchaseApplyBasic purchaseBean, TProcessCheck checkBean, User user,String files) {
		/*Date d = new Date();
		DecimalFormat df = new DecimalFormat("0.000000");//保留6位小数
		BidRegist bidregist = cgbidMng.getBidRegistByPId(purchaseBean.getFpId());
		WinningBidder fwbean = cgselMng.findById(bidregist.getFwId());
		cashierBean.setPayee(fwbean.getFpayeeName());
		cashierBean.setIdCard(fwbean.getFpayeeIdCard());//
		cashierBean.setAccount(fwbean.getFpayeeAccount());//设置银行账户
		cashierBean.setBank(fwbean.getFpayeeBank());//设置银行
		cashierBean.setAmount(Double.valueOf(purchaseBean.getAmount()));//设置付款金额
		cashierBean.setAcceptTime(d);//设值时间
		cashierBean.setUserId(user.getId());//保存受理人id
		cashierBean.setpId(purchaseBean.getFpId());//设置采购付款id
		cashierBean.setStauts("1");
		//保存出纳受理信息
		super.saveOrUpdate(cashierBean);
		
		if("0".equals(checkBean.getFcheckResult())) {
			//不通过，清空下一审批人姓名、编号 及 下一审批节点，设置审批状态为已退回，设置申请状态为暂存
			purchaseBean.setUserName2(null);
			purchaseBean.setFuserId(null);
			purchaseBean.setnCode(null);
			
			purchaseBean.setFpayStauts("-1");
			purchaseBean.setfStauts("0");
			
			super.merge(purchaseBean);
			
			//添加审批人个人首页代办信息
			//修改自己的待办信息，将待办改为已办，将审批的url改为查看的url
			PersonalWork work = personalWorkMng.findByCodeAndUser(purchaseBean.getFpCode(), user).get(0);
			work.setTaskStauts("2");
			work.setType("2");//任务类型（2查看）
			work.setFinishTime(d);
			super.merge(work);
			
			//修改申请人的待办信息（已办到待办）
			List<PersonalWork> list = personalWorkMng.findByCodeAndUser(purchaseBean.getFpCode(), userMng.findById(purchaseBean.getfUser()));
			if(list != null &&list.size()>0){
				PersonalWork work2 = list.get(0);
				work2.setTaskStauts("0");//退回信息已办改为待办
				work2.setType("3");//任务类型（3退回修改）
				super.merge(work2);
			}
			
		} else if("1".equals(checkBean.getFcheckResult())) {
			//通过
			purchaseBean.setUserName2(null);
			purchaseBean.setFuserId(null);
			purchaseBean.setnCode(null);
			purchaseBean.setFpayStauts("9");
			super.merge(purchaseBean);
			
			PersonalWork personalWork = personalWorkMng.getByCodeAndUser(purchaseBean.getFpCode(), null);//查询全部只需要user为null
			String url = personalWork.getUrl1();
			//将指标的冻结金额解冻，实际实际余额扣除
			//采购付款是实报实销的，所以只需要将冻结金额减去就完成了指标金额的修改
			Double num = Double.valueOf(purchaseBean.getAmount());
			TBudgetIndexMgr index = budgetIndexMgrMng.findById(Integer.valueOf(purchaseBean.getIndexCode()));
			index.setDjAmount(Double.valueOf(df.format((index.getDjAmount()*10000-num)/10000)));
			super.merge(index);
			
			//添加指标流水
			TIndexDetail detail = new TIndexDetail();
			detail.setfType("6");//费用类型（6采购）
			detail.setDepartment(purchaseBean.getfDeptName());//执行人部门名称	
			detail.setDepartmentId(purchaseBean.getfDeptId());
			detail.setUserId(purchaseBean.getfUser());//执行人id（申请人）
			detail.setTime(d);//执行时间
			detail.setAmount(Double.valueOf(df.format(0-purchaseBean.getAmount())));//支出
			detail.setIndexName(index.getIndexName());//指标名称
			detail.setIndexCode(index.getIndexCode());//指标code
			detail.setIndexType(index.getIndexType());//指标类型
			//如果指标类型为1项目指标的话需要设置项目编号和名称
			if("1".equals(index.getIndexType())) {
				detail.setProjectCode(index.getIndexCode());
				detail.setProjectName(index.getExpItemName());
			}
			
			//修改申请人的待办信息（已办到待办）
			detail.setUrl(url);//设置单据查看路径
			detail.setBillsCode(purchaseBean.getFpCode());//申请单号
			
			super.merge(detail);
		}
		//根据资源名称和当前登陆者所属部门查询对应工作流
		TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("CGPAY", purchaseBean.getfDeptId());
		Integer flowId= processDefin.getFPId();
		//添加流程审批记录
		TNodeData node =new TNodeData(user.getRoleCode(),user.getRoleName());
		try {
			tProcessCheckMng.addCheckHistory(checkBean,flowId, purchaseBean.getBeanCode(), purchaseBean.getUserId(),Integer.parseInt(checkBean.getFcheckResult()),user, node,files);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
	}

	@Override
	public List<CashierAcceptInfo> findByLoanId(Integer lId, String stauts) {
		Finder finder = Finder.create(" FROM CashierAcceptInfo WHERE cId='"+lId+"'");
		if(stauts != null) {
			finder.append(" AND stauts="+stauts);
		}
		return super.find(finder);
	}


	@Override
	public List<CashierAcceptInfo> findByDrId(Integer drId, String stauts) {
		Finder finder = Finder.create(" FROM CashierAcceptInfo WHERE drId='"+drId+"'");
		if(stauts != null) {
			finder.append(" AND stauts="+stauts);
		}
		return super.find(finder);
	}


	@Override
	public List<CashierAcceptInfo> findByFcId(Integer fcId, String stauts) {
		Finder finder = Finder.create(" FROM CashierAcceptInfo WHERE contId='"+fcId+"'");
		if(stauts != null) {
			finder.append(" AND stauts="+stauts);
		}
		return super.find(finder);
	}


	@Override
	public List<CashierAcceptInfo> findByRId(Integer rId, String stauts) {
		Finder finder = Finder.create(" FROM CashierAcceptInfo WHERE rId='"+rId+"'");
		if(stauts != null) {
			finder.append(" AND stauts="+stauts);
		}
		return super.find(finder);
	}


	@Override
	public List<CashierAcceptInfo> findByPId(Integer pId, String stauts) {
		Finder finder = Finder.create(" FROM CashierAcceptInfo WHERE pId='"+pId+"'");
		if(stauts != null) {
			finder.append(" AND stauts="+stauts);
		}
		return super.find(finder);
	}

	
	/**
	 * 
	* @author:安达
	* @Title: deleteDjAmount 
	* @Description: 审批全部通过,修改冻结金额
	* @return void    返回类型 
	* @date： 2019年6月18日下午9:09:39 
	* @throws
	 */
	@Override
	public void deleteDjAmount(Integer indexId,Integer proDetailId,BigDecimal amount,BigDecimal djAmount,String departId,String operatorId,String url,String beanCode,String type){
		TBudgetIndexMgr bim = budgetIndexMgrMng.findById(indexId);
		//修改项目冻结金额
		BigDecimal bimDjAmount=bim.getDjAmount().subtract(djAmount);
		bim.setDjAmount(bimDjAmount);
		BigDecimal bimSyAmount=BigDecimal.ZERO; 
		if(amount.compareTo(djAmount)==-1 ){
			//如果报销金额小于事前申请金额，多出来的冻结金额要归还到可用金额
			bimSyAmount=bim.getSyAmount().add((djAmount.subtract(amount)));
		}else{
			//如果报销金额大于事前申请金额，剩余金额还要再减掉超出金额
			bim.getSyAmount().subtract((amount.subtract(djAmount)));
		}
		bim.setSyAmount(bimSyAmount);
		super.merge(bim);
		if (proDetailId != null) {
			TProExpendDetail expendDetail = tProExpendDetailMng.findById(proDetailId);
			//修改指标冻结金额
			BigDecimal deatilDjAmount=expendDetail.getDjAmount().subtract(djAmount);
			expendDetail.setDjAmount(deatilDjAmount);
			BigDecimal deatilSyAmount=BigDecimal.ZERO; 
			if(amount.compareTo(djAmount)==-1){
				//如果报销金额小于事前申请金额，多出来的冻结金额要归还到可用金额
				deatilSyAmount=expendDetail.getSyAmount().add(djAmount.subtract(amount));
			}else{
				//如果报销金额大于事前申请金额，剩余金额还要再减掉超出金额
				deatilSyAmount=expendDetail.getSyAmount().subtract(amount.subtract(djAmount));
			}
			expendDetail.setSyAmount(deatilSyAmount);
			super.merge(expendDetail);
		}
		//添加指标流水
		TIndexDetail detail = new TIndexDetail();
		detail.setfType(type);//费用类型（7合同）
		Depart d = departMng.findById(departId);
		detail.setDepartment(d.getName());//执行人部门名称
		detail.setDepartmentId(departId);
		detail.setUserId(operatorId);//执行人id（申请人）
		detail.setTime(new Date());//执行时间
		detail.setAmount(amount);//支出
		detail.setIndexName(bim.getIndexName());//指标名称
		detail.setIndexCode(bim.getIndexCode());//指标code
		detail.setIndexType(bim.getIndexType());//指标类型
		//如果指标类型为1项目指标的话需要设置项目编号和名称
		if("1".equals(bim.getIndexType())) {
			detail.setProjectCode(bim.getIndexCode());
			detail.setProjectName(bim.getExpItemName());
		}
		detail.setUrl(url);//设置单据查看路径
		detail.setBillsCode(beanCode);//申请单号
		
		super.merge(detail);
		//消息推送
		//sendMsg(bim);
	}
	
	
	/**
	 * 事前申请报销
	 * 付讫之后保存信息生成凭证
	 */
	@Override
	public void savePayRegister( ReimbAppliBasicInfo rBean,String economicCode,User user) {
		ReimbAppliBasicInfo bean = reimbAppliMng.findById(rBean.getrId());
		bean.setFundSource(rBean.getFundSource());
		bean.setBankAccountId(rBean.getBankAccountId());
		bean.setRegister("1");
		bean.setCashierType("1");
		rBean=bean;
		PersonalWork personalWork = personalWorkMng.getByCodeAndUser(rBean.getrCode(), null);//查询全部只需要user为null
		String url = personalWork.getUrl1();
		if( !"9".equals(bean.getType()) && !"4".equals(bean.getType())&& !"10".equals(bean.getType())){//非往来款报销
			
			//如果选择冲销借款  出纳点击付讫以后，报销的原有逻辑不变，新增判断，判断是否有冲销借款，如果有，则执行如下逻辑
			if (!StringUtil.isEmpty(String.valueOf(bean.getWithLoan())) && bean.getWithLoan() == 1){
				//记录冲销金额
				if(bean.getLoan().getLeastAmount().compareTo(bean.getAmount())==-1 ){
					bean.setCxAmount(bean.getLoan().getLeastAmount());
				}else{
					bean.setCxAmount(bean.getAmount());
				}
				withLoan(bean.getLoan(),bean.getAmount());
			}
			super.merge(bean);
			//查询报销单，获取事前申请的金额， 如果报销金额小于事前申请金额，多出来的冻结金额要归还到可用金额
			ApplicationBasicInfo basicInfo=applyMng.findByCode(rBean.getgCode());
			if(rBean.getAmount().compareTo(basicInfo.getAmount())>-1){
				//审批全部通过,修改冻结金额
				deleteDjAmount(rBean.getIndexId(),rBean.getProDetailId(),rBean.getAmount(),basicInfo.getAmount(),rBean.getDept(),rBean.getUser(),url,rBean.getrCode(),"4");
				
			}else{
				//审批全部通过,修改冻结金额
				deleteDjAmount(rBean.getIndexId(),rBean.getProDetailId(),rBean.getAmount(),basicInfo.getAmount(),rBean.getDept(),rBean.getUser(),url,rBean.getrCode(),"4");
				
			}
		}else if("10".equals(bean.getType())){//采购报销
			//查询采购单，获取采购申请的金额， 如果报销金额小于采购申请金额，多出来的冻结金额要归还到可用金额
			PurchaseApplyBasic purchase = cgsqMng.findById(bean.getPurchaseId());
			if(rBean.getAmount().compareTo(purchase.getFpAmount())>-1 ){
				//审批全部通过,修改冻结金额
				deleteDjAmount(rBean.getIndexId(),rBean.getProDetailId(),rBean.getAmount(),purchase.getFpAmount(),rBean.getDept(),rBean.getUser(),url,rBean.getrCode(),"4");
				
			}else{
				//审批全部通过,修改冻结金额
				deleteDjAmount(rBean.getIndexId(),rBean.getProDetailId(),rBean.getAmount(),purchase.getFpAmount(),rBean.getDept(),rBean.getUser(),url,rBean.getrCode(),"4");
				
			}
		}else{
			if("4".equals(bean.getType())){
				ApplicationBasicInfo basicInfo=applyMng.findByCode(bean.getgCode());
				BudgetMessageList messageListReim = new BudgetMessageList();
				messageListReim.setrId(bean.getrId());
				List<BudgetMessageList> budgetMessageList = applyMng.getBudgetMessageList(messageListReim, null);
				BudgetMessageList messageListApply = new BudgetMessageList();
				messageListApply.setgId(basicInfo.getgId());
				List<BudgetMessageList> lists = applyMng.getBudgetMessageList(messageListApply, null);
				for (BudgetMessageList budgetMessageList1 : budgetMessageList) {//循环报销的预算
					for (BudgetMessageList budgetMessageList2 : lists){//循环事前的预算
						if(budgetMessageList2.getfCostName().equals(budgetMessageList1.getfCostName())){//判断费用名称是否一致
							if(budgetMessageList2.getfCostTheir().equals(budgetMessageList1.getfCostTheir())){//判断费用所属是否一致
								if(!StringUtil.isEmpty(budgetMessageList1.getfCostClassifyShow()) && budgetMessageList1.getfCostAmount()!=null){//如果预算分类与金额不为空或者null
									deleteDjAmount(budgetMessageList1.getfIndexId(),budgetMessageList1.getfProDetailId(),budgetMessageList1.getfCostAmount(),budgetMessageList2.getfCostAmount(),rBean.getDept(),rBean.getUser(),url,rBean.getrCode(),"4");
								}
							}
						}
					}
				}
			}
		}
//		TProExpendDetail expendDetail = new TProExpendDetail();
//		TBudgetIndexMgr bim = new TBudgetIndexMgr();
//		String indexCodeAndName = null;
//		String subName = null;//科目名称
//		String subCode = null;//科目编码
//		if("1".equals(rBean.getIndexType())){
//			//项目支出
//			//获取第四级指标名称（支出明细名称）
//			expendDetail = tProExpendDetailMng.findById(rBean.getProDetailId());
//			subName = expendDetail.getSubName();//科目名称
//			subCode = expendDetail.getSubCode();//科目编码
//			//项目编号和名称
//			bim = budgetIndexMgrMng.findById(rBean.getIndexId());
//			indexCodeAndName = "["+bim.getIndexCode()+"]\n"+bim.getIndexName();
//		}else if("0".equals(rBean.getIndexType())){
//			//基本支出
//			Economic economic = economicMng.findById(Integer.valueOf(economicCode));
//			subName = economic.getName();//科目名称
//			subCode = economic.getCode();//科目编码
//			//项目编号和名称
//			bim = budgetIndexMgrMng.findById(rBean.getIndexId());
//			String[] indexCode = bim.getIndexCode().split("-");
//			indexCodeAndName = "["+indexCode[indexCode.length-1]+"]\n"+bim.getIndexName();
//		}
//		// 经济科目指标
//		List<Economic> economicList = economicMng.findByProperty("code", subCode.substring(0,3));// 临时集合
//		if(economicList!=null && economicList.size()>0){
//			subName=subCode+"\n"+economicList.get(0).getName()+"_"+subName;
//		}
//		String fEconomicName=subName;
//		//需要拼写银行字段
//		String id1 = rBean.getBankAccountId();
//		Lookups lookups = lookupsMng.findByLookCode(id1);
//		String bankCode = lookups.getCode();
//		bankCode = bankCode.split("-")[1];
//		//银行编码和名称
//		String bankCodeAndName = bankCode+"\n"+lookups.getName();
//		
//		
//		//添加凭证库
//		voucherMng.addVoucher(rBean.getBeanCode(), rBean.getgName(),  rBean.getDept(),rBean.getDeptName(), indexCodeAndName,fEconomicName, rBean.getAmount(),0d,rBean.getFundSource(),bankCodeAndName);
	}



	/**
	 *  直接报销和借款报销
	 */
	@Override
	public void simplesavePayRegister(String id,String economicCode, String registertype, User user) {
		// TODO Auto-generated method stub
		String url = null;
		DirectlyReimbAppliBasicInfo bean = directlyReimbMng.findById(Integer.valueOf(id));
		LoanBasicInfo lbean = loanMng.findById(Integer.valueOf(id));
		if("0".equals(registertype)){
			//直接报销
			Economic economic = economicMng.findById(Integer.valueOf(id));
			bean.setEconomicCode(economic.getCode());
			bean.setCashierType("1");
			url = "/directlyReimburse/edit?id="+bean.getDrId()+"&editType=0";//设置单据查看路径
			bean = (DirectlyReimbAppliBasicInfo) super.merge(bean);
			//如果选择冲销借款  出纳点击付讫以后，报销的原有逻辑不变，新增判断，判断是否有冲销借款，如果有，则执行如下逻辑
			if (bean.getWithLoan() == 1){
				withLoan(bean.getLoan(),bean.getAmount());
			}
			//审批全部通过,修改冻结金额
			//费用类型1、收入	2、还款	3、直接报销		4、申请报销		5、借款	6、采购支付		7、合同报销
			deleteDjAmount(bean.getIndexId(),bean.getProDetailId(),bean.getAmount(),
					bean.getAmount(),bean.getDept(),bean.getUserId(),url,bean.getBeanCode(),"3");
		}else if("2".equals(registertype)){
			//借款报销，借款申请，在送审的时候就冻结金额，还款的时候解冻金额
			Economic economic = economicMng.findById(Integer.valueOf(id));
			lbean.setEconomicCode(economic.getCode());
			lbean.setCashierType("1");
			super.merge(lbean);
		}

	}
	/**
	 * 
	* @author:安达
	* @Title: sendMsg 
	* @Description: 指标使用达到一定程度，给用户发送消息
	* @param bim
	* @return void    返回类型 
	* @date： 2019年9月17日下午3:42:51 
	* @throws
	 */
	private void sendMsg(TBudgetIndexMgr bim){
		if(bim.getFProId()!=null){
			BigDecimal zxAmounts = (bim.getSyAmount().add(bim.getDjAmount())).divide(bim.getPfAmount());
			BigDecimal zxAmount =zxAmounts.multiply(BigDecimal.valueOf(100));
			TProBasicInfo info = projectMng.findById(bim.getFProId());
			//日期格式化（消息推送中使用）
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String msg="";
			if(zxAmount.compareTo(BigDecimal.valueOf(80))>-1&&zxAmount.compareTo(BigDecimal.valueOf(90))<1){
				//添加消息内容
				msg="您的指标："+bim.getIndexName()+",指标编号：("+bim.getIndexCode()+")于"+sdf.format(new Date())+"使用超过80%,请及时关注.";
			}else if(zxAmount.compareTo(BigDecimal.valueOf(90))==1&&zxAmount.compareTo(BigDecimal.valueOf(100))==-1){
				//添加消息内容
				msg="您的指标："+bim.getIndexName()+",指标编号：("+bim.getIndexCode()+")于"+sdf.format(new Date())+"使用超过90%,请做好结项准备.";
			}else if(zxAmount.compareTo(BigDecimal.valueOf(100))>-1){
				//添加消息内容
				msg="您的指标："+bim.getIndexName()+",指标编号：("+bim.getIndexCode()+")于"+sdf.format(new Date())+"已使用完,请结项.";
			}
			String title=bim.getIndexName()+"执行进度消息";
			privateInforMng.setMsg(title, msg, info.getFProAppliPeopleId(), "2");
		}
		
	}
	
	/**
	 * 
	* @author:安达
	* @Title: withLoan 
	* @Description:  冲销借款
	* 报销冲销借款逻辑：
		出纳点击付讫以后，报销的原有逻辑不变，新增判断，判断是否有冲销借款，如果有，则执行如下逻辑
		1、如果报销金额>=借款金额，则借款的还款状态改为已还款，借款的冻结金额扣为0，借款的剩余还款金额为0
		2、如果报销金额<借款金额 ，则借款的还款状态改为未还款，借款的冻结金额扣为（冻结金额-报销金额），
		借款的剩余还款金额为（冻结金额-报销金额）， 还款申请的时候，只需要还 剩余还款金额，还款确认通过以后，
		还款状态改为已还款
	* @param loan 借款信息
	* @param amount  报销金额
	* @return void    返回类型 
	* @date： 2019年9月17日下午3:34:43 
	* @throws
	 */
	@Override
	public void withLoan(LoanBasicInfo loan,BigDecimal amount){
		try {
			if (loan != null) {
				//借款单基础信息	改变应还金额 
				BigDecimal leastNum = loan.getLeastAmount();//剩余还款金额
				BigDecimal lAmount = loan.getlAmount();//借款金额
				//归还给剩余金额
				BigDecimal backAmount=BigDecimal.ZERO;
				if (amount.compareTo(leastNum)>-1) {
					//如果 报销金额>=借款金额，则借款的还款状态改为已还款，借款的冻结金额扣为0，借款的剩余还款金额为0
					loan.setLeastAmount(BigDecimal.ZERO);
					backAmount=leastNum;
					//还款（归垫）状态        0待还款  1待审定 -1已退回  9已还款
					loan.setFrepayStatus("9");
					/*Payment payment = paymentMng.findByLId(loan.getlId());
					if(payment==null){
						payment =new Payment();
						User user = userMng.findById(Integer.valueOf(loan.getUserId()));
						payment.setPayPerson(user.getName());
						payment.setPayAmount(0.00);
						payment.setFlowStatus("9");
						payment.setCode(loan.getlCode());
						payment.setlId(loan.getlId());
						payment.setPaymentType("冲销");
						payment.setApplier(user.getName());
						payment.setApplierId(user.getId());
						payment.setApplyDepId(user.getDepart().getId());
						payment.setApplyDepName(user.getDepart().getName());
					}
					payment.setPayTime(new Date());
					paymentMng.saveOrUpdate(payment);*/
				} else {
					//如果报销金额<借款金额 ，则借款的还款状态改为未还款，借款的冻结金额扣为（冻结金额-报销金额），
					loan.setLeastAmount(leastNum.subtract(amount));
					backAmount=amount;
				}
				
				//指标管理表	改变指标金额
				/*if (loan.getIndexId() != null) {
					TBudgetIndexMgr index = budgetIndexMgrMng.findById(loan.getIndexId());
					if (index != null) {
						double syAmount = index.getSyAmount();
						syAmount = MatheUtil.add(syAmount, backAmount/10000);
						index.setSyAmount(syAmount);
						Double indexDjAmount=MatheUtil.sub(index.getDjAmount(), backAmount/10000);
						index.setDjAmount(indexDjAmount);
						budgetIndexMgrMng.saveOrUpdate(index);
					}
				}
				//项目明细表	改变明细金额
				if (loan.getProDetailId() != null) {
					TProExpendDetail detail = tProExpendDetailMng.findById(loan.getProDetailId());
					double syAmount = detail.getSyAmount();
					syAmount = MatheUtil.add(syAmount, backAmount/10000);
					detail.setSyAmount(syAmount);
					Double detailDjAmount=MatheUtil.sub(detail.getDjAmount(), backAmount/10000);
					detail.setDjAmount(detailDjAmount);
					tProExpendDetailMng.saveOrUpdate(detail);
				}*/
				loanMng.updateDefault(loan);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
