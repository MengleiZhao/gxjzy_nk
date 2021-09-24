package com.braker.icontrol.expend.loan.manager.impl;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Depart;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.loan.manager.LoanMng;
import com.braker.icontrol.expend.loan.manager.PaymentMng;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;
import com.braker.icontrol.expend.loan.model.Payment;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.workflow.manager.TProcessPrintDetailMng;
import com.braker.zzww.comm.manager.AttachmentMng;

@Service
@Transactional
public class PaymentMngImpl extends BaseManagerImpl<Payment> implements PaymentMng {

	
	@Autowired
	private UserMng userMng;
	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	@Autowired
	private LoanMng loanMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	@Autowired
	private TProcessPrintDetailMng tProcessPrintDetailMng;
	
	
	
	
	
	@Override
	public Payment savePayment(Payment bean, String files, User user) throws Exception {
		
		Date date = new Date();
		LoanBasicInfo loanBean = loanMng.findById(bean.getlId());
		//默认信息
		if (StringUtil.isEmpty(bean.getId())) {
			bean.setCreator(user);
			bean.setCreatetime(date);
			bean.setFlag(1);
		} else {
			bean.setFlag(1);
			bean.setUpdator(user);
			bean.setUpdateTime(date);
		}
		//申请人id和姓名
		bean.setApplier(user.getName());
		bean.setApplierId(user.getId());
		//申请部门id和名称
		Depart depart = user.getDepart();
		if (depart != null) {
			bean.setApplyDepId(depart.getId());
			bean.setApplyDepName(depart.getName());
		}
		if (bean.getFlowStatus().equals("1") || bean.getFlowStatus().equals("2")) {
			//得到第一个审批节点key
			Integer firstKey = tProcessCheckMng.addProcessCheck(user.getDpID(), bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(),"HKDJ", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin = tProcessDefinMng.getByBusiAndDpcode("HKDJ", user.getDpID());
			Integer flowId= processDefin.getFPId();
			TNodeData node = tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			User nextUser = userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号		
			bean.setNextCheckUserName(nextUser.getName());
			bean.setNextCheckUserId(nextUser.getId());
			//设置下节点节点编码
			bean.setNextNodeCode(firstKey+"");	
			
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			//保存基本信息
			bean = (Payment) super.saveOrUpdate(bean);
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(Integer.valueOf(bean.getId()));//申请单ID
			work.setTaskCode(bean.getCode());//为申请单的单号
			work.setTaskName("[还款]"+loanBean.getLoanPurpose());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/payment/check/"+bean.getId());//审批url
			work.setUrl1("/payment/detail/"+ bean.getId());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setTaskType("1");//任务归属（1审批人）
			work.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work.setBeforeTime(date);//任务提交时间
			personalWorkMng.merge(work);
			
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(Integer.valueOf(bean.getId()));//申请单ID
			work2.setTaskCode(bean.getCode());//为申请单的单号
			work2.setTaskName("[还款]"+loanBean.getLoanPurpose());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/payment/edit/"+ loanBean.getlId());//退回修改url
			work2.setUrl1("/payment/detail/"+ bean.getId());//查看url
			work2.setUrl2("/payment/delete/"+ bean.getId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setTaskType("0");//任务归属（0发起人）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work2.setBeforeTime(date);//任务提交时间
			work2.setFinishTime(date);
			personalWorkMng.merge(work2);
		} else {
			//保存基本信息
			bean = (Payment) super.saveOrUpdate(bean);
		}
		loanBean.setCashierType("0");
		if("0".equals(bean.getFlowStatus())){//0是暂存
			loanBean.setFrepayStatus("0");
			loanBean.setPaymentId(bean.getId());
			super.saveOrUpdate(loanBean);
		}else{
			loanBean.setFrepayStatus("1");//1是送审中
			loanBean.setPaymentId(bean.getId());
			super.saveOrUpdate(loanBean);
		}
		
		//保存附件信息
		attachmentMng.joinEntity(bean,files);
		return (Payment) super.saveOrUpdate(bean);
	}
	
	//这个方法原本是有审批流程的时候，调用这个方法
	public Payment savePayment_bak(Payment bean, String files, User user) throws Exception {
		
		Date date = new Date();

		//默认信息
		if (StringUtil.isEmpty(bean.getId())) {
			bean.setCode(StringUtil.Random(""));
			bean.setCreator(user);
			bean.setCreatetime(date);
			bean.setFlag(1);
		} else {
			bean.setFlag(1);
			bean.setUpdator(user);
			bean.setUpdateTime(date);
		}
		
		if (bean.getFlowStatus().equals("1") || bean.getFlowStatus().equals("2")) {
			//得到第一个审批节点key
			Integer firstKey = tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), "HKDJ", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin = tProcessDefinMng.getByBusiAndDpcode("HKDJ", user.getDpID());
			Integer flowId= processDefin.getFPId();
			TNodeData node = tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			User nextUser = userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号		
			bean.setNextCheckUserName(nextUser.getName());
			bean.setNextCheckUserId(nextUser.getId());
			//设置下节点节点编码
			bean.setNextNodeCode(firstKey+"");	
			//申请人id和姓名
			bean.setApplier(user.getName());
			bean.setApplierId(user.getId());
			//申请部门id和名称
			Depart depart = user.getDepart();
			if (depart != null) {
				bean.setApplyDepId(depart.getId());
				bean.setApplyDepName(depart.getName());
			}
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			//保存基本信息
			bean = (Payment) super.saveOrUpdate(bean);
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(Integer.valueOf(bean.getId()));//申请单ID
			work.setTaskCode(bean.getCode());//为申请单的单号
			work.setTaskName("借款登记确认");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/payment/check/"+bean.getId());//审批url
			work.setUrl1("/payment/detail/"+ bean.getId());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work.setBeforeTime(date);//任务提交时间
			personalWorkMng.merge(work);
			
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(Integer.valueOf(bean.getId()));//申请单ID
			work2.setTaskCode(bean.getCode());//为申请单的单号
			work2.setTaskName("借款登记确认");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/payment/edit/"+ bean.getlId());//退回修改url
			work2.setUrl1("/payment/detail/"+ bean.getId());//查看url
			work2.setUrl2("/payment/delete/"+ bean.getId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work2.setBeforeTime(date);//任务提交时间
			work2.setFinishTime(date);
			personalWorkMng.merge(work2);
		} else {
			//保存基本信息
			bean = (Payment) super.saveOrUpdate(bean);
		}
		
		//保存附件信息
		attachmentMng.joinEntity(bean,files);
		return (Payment) super.saveOrUpdate(bean);
	}

	@Override
	public void deletePayment(Payment bean, User user) {

		bean.setFlag(0);
		bean.setUpdator(user);
		bean.setUpdateTime(new Date());
		super.saveOrUpdate(bean);
	}

	@Override
	public Pagination pageList(Payment bean, User user, String menuType, Integer pageNo, Integer pageSize) {
		
		Finder finder = Finder.create(" from Payment where flag=1 and nextUserId='"+user.getId()+"' and flowStatus in('1','0')");
		if (bean != null) {
			//还款人
			if (!StringUtil.isEmpty(bean.getPayPerson())) {
				finder.append(" and payPerson like:payPerson").setParam("payPerson", "%" + bean.getPayPerson() + "%");
			}
			//还款时间
			if (bean.getPayTimes() != null) {
				finder.append(" and payTime>=:payTimes").setParam("payTimes", bean.getPayTimes());
			}
			if (bean.getPayTimee() != null) {
				finder.append(" and payTime<=:payTimee").setParam("payTimee", bean.getPayTimee());
			}
		}
		
		finder.append(" ORDER BY createtime DESC ");
		
		Pagination p =  super.find(finder, pageNo, pageSize);
		List<Payment> list = (List<Payment>) p.getList();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				Payment pay = list.get(i);
				pay.setOrderNum(pageNo * pageSize + i - 9);
			}
		}
		return p;
	}

	@Override
	public void deletePayment(Integer id, User user,String fId) {
		Payment bean = findById(id);
		
		//修改申请单的报销状态为0（未还款）
		getSession().createSQLQuery("UPDATE t_loan_basic_info SET F_REPAY_STATUS=0 WHERE F_L_ID="+bean.getlId()+"").executeUpdate();
				
		if (bean != null) {
			bean.setFlag(0);
			bean.setUpdator(user);
			bean.setUpdateTime(new Date());
			super.saveOrUpdate(bean);
		}
		personalWorkMng.sendMessageToUser(user.getId(), 0);
	}

	@Override
	public void saveCheckPayment(TProcessCheck checkBean, Payment bean,
			User user, Role role, String file) throws Exception {
		bean = this.findById(Integer.valueOf(bean.getId()));
		CheckEntity entity = (CheckEntity)bean;
		String checkUrl = "/payment/check/";
		String lookUrl = "/payment/detail/";
		bean = (Payment)tProcessCheckMng.checkProcess(checkBean,entity,user,"HKDJ",checkUrl,lookUrl,file);
		if("-1".equals(bean.getFlowStatus())) {	
			LoanBasicInfo loanBean = loanMng.findById(bean.getlId());
			loanBean.setFrepayStatus("-1");
			super.saveOrUpdate(loanBean);
		}
		if("9".equals(bean.getFlowStatus())) {	
			//tProcessPrintDetailMng.arrangeLoanBasicInfoCheckDetail("1", bean, null, user);
			LoanBasicInfo loanBean = loanMng.findById(bean.getlId());
			loanBean.setFrepayStatus("9");//还款完成
			loanBean.setLeastAmount(BigDecimal.ZERO);
			super.saveOrUpdate(loanBean);
		}
		super.saveOrUpdate(bean);
	}

	@Override
	public String paymentReCall(Integer id) throws Exception {
		//根据id查询对象
		Payment bean=(Payment)super.findById(id);
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="申请被撤回消息";
		String msg="您待审批的还款单撤回,任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean=(Payment) reCall((CheckEntity) bean);
		this.updateDefault(bean);
		return "操作成功";
	}
	@Override
	public Payment findByLId(Integer id){
		Finder finder = Finder.create(" FROM  Payment WHERE lId ="+id+"");
		List<Payment> li = super.find(finder);
		if(li.size()!=0) {
			return li.get(0);
		} else return null;
	}
}
