package com.braker.icontrol.expend.reimburse.manager.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.socket.TextMessage;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.PoiUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.webSocket.MyWebSocketHandler;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.EconomicMng;
import com.braker.core.manager.PaymentMethodInfoMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.RoleMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Economic;
import com.braker.core.model.Lookups;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.audit.manager.AuditInfoMng;
import com.braker.icontrol.expend.cashier.manager.CashierMng;
import com.braker.icontrol.expend.loan.manager.LoanMng;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbAttacMng;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbDetailMng;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbMng;
import com.braker.icontrol.expend.reimburse.manager.InvoiceCouponMng;
import com.braker.icontrol.expend.reimburse.manager.InvoiceMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbAppliMng;
import com.braker.icontrol.expend.reimburse.model.AppInvoiceInfo;
import com.braker.icontrol.expend.reimburse.model.CostDetailInfo;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbDetail;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbPayeeInfo;
import com.braker.icontrol.expend.reimburse.model.InvoiceCouponInfo;
import com.braker.icontrol.expend.reimburse.model.ReimCXInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbDetail;
import com.braker.icontrol.expend.reimburse.model.ReimbPayeeInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.workflow.manager.TProcessPrintDetailMng;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 直接报销申请的service实现类
 * @author 叶崇晖
 * @createtime 2018-08-03
 * @updatetime 2018-08-03
 */
@Service
@Transactional
public class DirectlyReimbMngImpl extends BaseManagerImpl<DirectlyReimbAppliBasicInfo> implements DirectlyReimbMng {
	@Autowired
	private DirectlyReimbDetailMng directlyReimbDetailMng;
	@Autowired
	private DirectlyReimbAttacMng directlyReimbAttacMng;
	@Autowired
	private CashierMng cashierMng;
	@Autowired
	private AuditInfoMng auditInfoMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private PaymentMethodInfoMng paymentMethodInfoMng;		//个人收款信息
	@Autowired
	private AttachmentMng attachmentMng;					//附件
	@Autowired
	private InvoiceMng invoiceMng;							//发票
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	@Autowired
	private RoleMng roleMng;
	@Autowired
	private LoanMng loanMng;
	@Autowired
	private TProExpendDetailMng indexDetailMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	@Autowired
	private EconomicMng economicMng;
	@Autowired
	private MyWebSocketHandler handler;
	@Autowired
	private ReimbAppliMng reimbAppliMng;
	@Autowired
	private InvoiceCouponMng invoiceCouponMng;
	@Autowired
	private TProcessPrintDetailMng tProcessPrintDetailMng;
	@Autowired
	private TProBasicInfoMng tProBasicInfoMng;
	/*
	 * 分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-03
	 * @updatetime 2018-08-03
	 */
	@Override
	public Pagination pageList(DirectlyReimbAppliBasicInfo bean, int pageNo,int pageSize, User user) {
		Finder finder = Finder.create(" FROM DirectlyReimbAppliBasicInfo WHERE stauts in('1','0') AND user='"+user.getId()+"'");
		
		if (!StringUtil.isEmpty(String.valueOf(bean.getDrCode()))) {
			finder.append(" AND drCode LIKE '%"+bean.getDrCode()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getReqTime1()))) {
			finder.append(" AND DATE_FORMAT(reqTime,'%Y-%m-%d') >= '"+bean.getReqTime1()+"'");//日期去时分秒函数
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getReqTime2()))) {
			finder.append(" AND DATE_FORMAT(reqTime,'%Y-%m-%d') <= '"+bean.getReqTime2()+"'");//日期去时分秒函数
		}
		if (!StringUtil.isEmpty(bean.getFlowStauts())) {
			if(bean.getFlowStauts().equals("1")) {
				finder.append(" and flowStauts in('1','2','3','4','5','6','7','8')");
			} else {
				finder.append(" and flowStauts = '"+bean.getFlowStauts()+"'");
			}
		}
		finder.append(" order by updateTime desc ");
		return super.find(finder, pageNo, pageSize);
	}
	
	/*
	 * 直接报销申请新增和修改的保存
	 * @author 叶崇晖
	 * @createtime 2018-08-06
	 * @updatetime 2018-08-06
	 */
	@Override
	public void save(DirectlyReimbAppliBasicInfo bean, DirectlyReimbPayeeInfo payeeBean, String mingxi, String fapiao, String files, User user)  throws Exception{
		Date d = new Date();
		bean.setReqTime(d);//报销时间
		bean.setUser(user.getId());//报销人ID
		bean.setDept(user.getDepart().getId());//报销人所属部门ID
		bean.setDeptName(user.getDepartName());//报销人所属部门名称
		
		if (bean.getDrId()==null) {
			bean.setCashierType("0");
			//创建人、创建时间
			bean.setCreator(user.getAccountNo());
			bean.setCreateTime(d);
			bean.setDrCode(StringUtil.Random(""));
			
		} else {
			//修改人、修改时间
			bean.setUpdator(user.getAccountNo());
			bean.setUpdateTime(d);
		}
		//工作流的节点配置（如果点送审则设置进入工作流1为提交2为审核中）
		if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), "ZJBX", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("ZJBX", user.getDpID());
			Integer flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			User nextUser=userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号		get(0)的原因是一个角色应该只能审批一级，所以查出来li应该只有一个数据
			bean.setUserName2(nextUser.getName());
			bean.setFuserId(nextUser.getId());
			//设置下节点节点编码
			bean.setnCode(firstKey+"");	
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			//保存基本信息
			bean = (DirectlyReimbAppliBasicInfo) super.saveOrUpdate(bean);
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getDrId());//申请单ID
			work.setTaskCode(bean.getDrCode());//为申请单的单号
			work.setTaskName("[直接报销]"+bean.getSummary());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/reimburseCheck/check?id="+bean.getDrId()+"&reimburseType=0");//为审批页面内容显示的url,需要将数据传入不然无法访问
			work.setUrl1("/directlyReimburse/edit?id="+ bean.getDrId()+"&editType=0");//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(d);//任务提交时间
			personalWorkMng.merge(work);
			
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(bean.getDrId());//申请单ID
			work2.setTaskCode(bean.getDrCode());//为申请单的单号
			work2.setTaskName("[直接报销]"+bean.getSummary());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/directlyReimburse/edit?id="+ bean.getDrId()+"&editType=1");//退回修改url
			work2.setUrl1("/directlyReimburse/edit?id="+ bean.getDrId()+"&editType=0");//查看url
			work2.setUrl2("/directlyReimburse/delete?id="+ bean.getDrId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work2.setBeforeTime(d);//任务提交时间
			work2.setFinishTime(d);
			personalWorkMng.merge(work2);
			BigDecimal num = bean.getAmount();//借款金额
			TBudgetIndexMgr index = budgetIndexMgrMng.findById(bean.getIndexId());
			index.setSyAmount(index.getSyAmount().subtract(num));//扣除剩余金额
			index.setDjAmount(index.getDjAmount().add(num));//添加冻结金额
		} else {
			//保存基本信息
			bean = (DirectlyReimbAppliBasicInfo) super.saveOrUpdate(bean);
		}
		
		
		//保存附件信息
		attachmentMng.joinEntity(bean,files);
		
		//旧明细
		List<DirectlyReimbDetail> oldmx = directlyReimbDetailMng.getMingxi(bean.getDrId());
		
		
		//新明细
		JSONArray array =JSONArray.fromObject("["+mingxi.toString()+"]");
		List<DirectlyReimbDetail> newmx = (List<DirectlyReimbDetail>)JSONArray.toList(array, DirectlyReimbDetail.class);
		
		//比较新老明细的不同
		for (int i = oldmx.size()-1; i >= 0; i--) {
			DirectlyReimbDetail olddrd = oldmx.get(i);
			for (int j = 0; j < newmx.size(); j++) {
				DirectlyReimbDetail newdrd = newmx.get(j);
				if(newdrd.getcId()!=null){
					if(newdrd.getcId()==olddrd.getcId()){
						oldmx.remove(i);
					}
				}
			}
		}
		
		//删除在新明细中没有的老明细
		if(oldmx.size()>0){
			for (int i = 0; i < oldmx.size(); i++) {
				DirectlyReimbDetail olddrd = oldmx.get(i);
				super.delete(olddrd);
			}
		}
		
		for (int i = 0; i < newmx.size(); i++) {
			DirectlyReimbDetail newdrd = newmx.get(i);
			newdrd.setDrId(bean.getDrId());
			newdrd.setCreator(user.getAccountNo());
			newdrd.setCreateTime(d);
			//保存新的明细
			super.merge(newdrd);
		}
		
		/*//旧发票
		List<InvoiceInfo> oldfp = invoiceMng.findByRID("1", bean.getDrId());
		
		Map classMap = new HashMap();
		classMap.put("couponList",InvoiceCouponInfo.class);
		
		//新发票
		JSONArray array2 =JSONArray.fromObject("["+fapiao.toString()+"]");
		
		List<InvoiceInfo> newfp = (List<InvoiceInfo>)JSONArray.toList(array2, InvoiceInfo.class, classMap);
		
		
		for (int i = oldfp.size()-1; i >= 0; i--) {
			InvoiceInfo olddrid = oldfp.get(i);
			for (int j = 0; j < newfp.size(); j++) {
				InvoiceInfo newdrid = newfp.get(j);
				if(newdrid.getiId()!=null) {
					if(newdrid.getiId().equals(olddrid.getiId())){
						oldfp.remove(i);
					}
				}
			}
		}
		
		//删除在新发票中没有的老发票
		if(oldfp.size()>0){
			for (int i = 0; i < oldfp.size(); i++) {
				InvoiceInfo olddrid = oldfp.get(i);
				//删除发票信息
				super.delete(olddrid);
			}
		}
		
		for (int i = 0; i < newfp.size(); i++) {
			InvoiceInfo newdrid = newfp.get(i);
			newdrid.setrId(bean.getDrId());//所属类型单据id
			newdrid.setType("1");//所属类型（1、直接报销）
			
			newdrid.setInvoiceTime(newfp.get(i).getInvoiceTime());
			
			
			//获得发票的票面信息
			List<InvoiceCouponInfo> couponList = newdrid.getCouponList();
			
			//保存新的发票信息
			String id = newdrid.getFileId();
			newdrid=(InvoiceInfo) super.merge(newdrid);
			
			//保存发票票面信息
			for (int j = 0; j < couponList.size(); j++) {
				InvoiceCouponInfo coupon = couponList.get(j);
				
				coupon.setiId(newdrid.getiId());//给发票票面信息设置副键
				super.merge(coupon);
			}
			
			//保存发票附件信息
			attachmentMng.joinEntity(newdrid,id);
		}
		*/
		
		//保存收款人信息
		payeeBean.setDrId(bean.getDrId());//关联直接报销单
		payeeBean.setPayeeId(user.getId());//收款人id
		payeeBean.setPayeeName(user.getName());//搜款人姓名
		payeeBean.setPayeeAmount(bean.getAmount());//应付金额
		super.merge(payeeBean);
		
		//保存或修改个人收款信息
		paymentMethodInfoMng.saveInfo(payeeBean, user);
	}

	
	/*
	 * 直接报销申请删除
	 * @author 叶崇晖
	 * @createtime 2018-08-08
	 * @updatetime 2018-08-08
	 */
	@Override
	public void delete(Integer id,String fid,User user) {
		//修改报销单的状态为99（删除）
		if(fid!=null){
			personalWorkMng.deleteById(Integer.valueOf(fid));
		}
		getSession().createSQLQuery("UPDATE t_directly_reimb_appli_basic_info SET F_STAUTS=99 WHERE F_DR_ID="+id).executeUpdate();
		personalWorkMng.sendMessageToUser(user.getId(), 0);
	}

	/*
	 * 审批分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-13
	 * @updatetime 2018-08-13
	 */
	@Override
	public Pagination checkPageList(DirectlyReimbAppliBasicInfo bean, int pageNo, int pageSize, User user) {
		//节点的编号为审批状态（暂时数据不准，为认为创造）		get(0)的原因是一个角色应该只能审批一级，所以查出来li应该只有一个数据
		Finder finder = Finder.create(" FROM DirectlyReimbAppliBasicInfo WHERE fuserId='"+user.getId()+"' AND stauts in('1','0')");	
		
		if (!StringUtil.isEmpty(String.valueOf(bean.getDrCode()))) {
			finder.append(" AND drCode LIKE '%"+bean.getDrCode()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getReqTime1()))) {
			finder.append(" AND DATE_FORMAT(reqTime,'%Y-%m-%d') >= '"+bean.getReqTime1()+"'");//日期去时分秒函数
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getReqTime2()))) {
			finder.append(" AND DATE_FORMAT(reqTime,'%Y-%m-%d') <= '"+bean.getReqTime2()+"'");//日期去时分秒函数
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getDeptName()))) {
			finder.append(" AND deptName LIKE '%"+bean.getDeptName()+"%'");
		}
		finder.append(" order by reqTime desc");
		return super.find(finder, pageNo, pageSize);
	}
	
	/*
	 * 台账分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-14
	 * @updatetime 2018-08-14
	 */
	@Override
	public Pagination ledgerPageList(String applyString,DirectlyReimbAppliBasicInfo bean, int pageNo, int pageSize, User user) {
		Finder finder = Finder.create(" FROM DirectlyReimbAppliBasicInfo WHERE flowStauts='9' AND stauts='1'");	
		if (!StringUtil.isEmpty(String.valueOf(bean.getDrCode()))) {
			finder.append(" AND drCode LIKE '%"+bean.getDrCode()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getDeptName()))) {
			finder.append(" AND deptName LIKE '%"+bean.getDeptName()+"%'");
		}
		String deptIdStr=departMng.getDeptIdStrByUser(user);
 		if("".equals(deptIdStr)){ //普通岗位只能查看自己的
 			finder.append(" and user = :user").setParam("user", user.getId());
 		}else if("all".equals(deptIdStr)){//校长可以查看所有人的
 			
 		}else{//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
 			finder.append(" and dept in ("+deptIdStr+")");
 		}
		if ("0".equals(applyString)) {
			finder.append(" and YEAR(F_REQ_TIME)=YEAR(NOW())");
		}
		finder.append(" order by reqTime desc");
		return super.find(finder, pageNo, pageSize);
	}

	/*
	 * 财务审定分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-16
	 * @updatetime 2018-08-16
	 */
	@Override
	public Pagination auditPageList(DirectlyReimbAppliBasicInfo bean, int pageNo, int pageSize, User user) {
		Finder finder = Finder.create(" FROM DirectlyReimbAppliBasicInfo WHERE fuserId='"+user.getId()+"' AND stauts in('1','0')");
		finder.append(" AND fuserId='"+user.getId()+"'");

		if (!StringUtil.isEmpty(String.valueOf(bean.getDrCode()))) {
			finder.append(" AND drCode LIKE '%"+bean.getDrCode()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getReqTime1()))) {
			finder.append(" AND DATE_FORMAT(reqTime,'%Y-%m-%d') >= '"+bean.getReqTime1()+"'");//日期去时分秒函数
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getReqTime2()))) {
			finder.append(" AND DATE_FORMAT(reqTime,'%Y-%m-%d') <= '"+bean.getReqTime2()+"'");//日期去时分秒函数
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getDeptName()))) {
			finder.append(" AND deptName LIKE '%"+bean.getDeptName()+"%'");
		}
		return super.find(finder, pageNo, pageSize);
	}

	/*
	 * 出纳受理分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-22
	 * @updatetime 2018-08-22
	 */
	@Override
	public Pagination cashierPageList(DirectlyReimbAppliBasicInfo bean, int pageNo, int pageSize, User user) {
		Finder finder = Finder.create(" FROM DirectlyReimbAppliBasicInfo WHERE stauts in('1','0') AND flowStauts=9  ");	
		if (!StringUtil.isEmpty(String.valueOf(bean.getDrCode()))) {
			finder.append(" AND drCode LIKE '%"+bean.getDrCode()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getReqTime1()))) {
			finder.append(" AND DATE_FORMAT(reqTime,'%Y-%m-%d') >= '"+bean.getReqTime1()+"'");//日期去时分秒函数
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getReqTime2()))) {
			finder.append(" AND DATE_FORMAT(reqTime,'%Y-%m-%d') <= '"+bean.getReqTime2()+"'");//日期去时分秒函数
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getDeptName()))) {
			finder.append(" AND deptName LIKE '%"+bean.getDeptName()+"%'");
		}
		finder.append(" order by cashierType,reqTime asc");
		return super.find(finder, pageNo, pageSize);
	}

	/**
	 * 查询需要导出的全部台账信息
	 * @author 叶崇晖
	 * @return
	 */
	@Override
	public List<DirectlyReimbAppliBasicInfo> ledgerList(String applyString,String userId) {
		Finder finder = Finder.create(" FROM DirectlyReimbAppliBasicInfo WHERE flowStauts='9' AND stauts='1'");
		String deptIdStr=departMng.getDeptIdStrByUser(userMng.findById(userId));
 		if("".equals(deptIdStr)){ //普通岗位只能查看自己的
 			finder.append(" and user = :user").setParam("user", userId);
 		}else if("all".equals(deptIdStr)){//校长可以查看所有人的
 			
 		}else{//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
 			finder.append(" and dept in ("+deptIdStr+")");
 		}
		if ("0".equals(applyString)) {
			finder.append(" and YEAR(F_REQ_TIME)=YEAR(NOW())");
		}
		return super.find(finder);
	}

	@Override
	public void check(TProcessCheck checkBean,DirectlyReimbAppliBasicInfo bean, User user,String files)  throws Exception{
		// TODO Auto-generated method stub
		//转换type选择流程
		bean=this.findById(bean.getDrId());
		CheckEntity entity=(CheckEntity)bean;
		String url="/reimburseCheck/check?reimburseType=0&id=";
		String url1 ="/directlyReimburse/edit?editType=0&id=";
		//String url2 ="/audit/auditReimburse?cashier=0&reimburseType=0&id=";
		if (("0").equals(bean.getIsconvention())) {
			bean=(DirectlyReimbAppliBasicInfo)tProcessCheckMng.checkProcess(checkBean, entity, user, "BXTYLC", url, url1,files);

		}else {
			bean=(DirectlyReimbAppliBasicInfo)tProcessCheckMng.checkProcess(checkBean, entity, user, "ZJBX", url, url1,files);
		}
		//因为直接报销申请冻结指标金额是在第一个人审批通过的时候，所以退回的话需要将剩余金额加回来，冻结金额减掉
		//修改指标冻结金额
		if("-1".equals(bean.getFlowStauts())) {		//打回原点的时候，需要解冻
			//DecimalFormat df = new DecimalFormat("0.000000");//保留6位小数
			/*TBudgetIndexMgr index = budgetIndexMgrMng.findById(bean.getIndexId());
			index.setSyAmount(BigDecimal.valueOf(df.format((index.getSyAmount()*10000+num)/10000)));//添加剩余金额
			index.setDjAmount(BigDecimal.valueOf(df.format((index.getDjAmount()*10000-num)/10000)));//扣除冻结金额
*/			
			//审批不通过的时候，归还冻结金额
			budgetIndexMgrMng.deleteDjAmount(bean.getIndexId(),bean.getProDetailId(),bean.getAmount());
		}
		tProcessPrintDetailMng.arrangedirectlyCheckDetail( bean,  user);
		if("9".equals(bean.getFlowStauts())) {	
				//直接报销
				bean.setCashierType("0");
				/*url = "/directlyReimburse/edit?id="+bean.getDrId()+"&editType=0";//设置单据查看路径
				super.merge(bean);
				//如果选择冲销借款  出纳点击付讫以后，报销的原有逻辑不变，新增判断，判断是否有冲销借款，如果有，则执行如下逻辑
				if (bean.getWithLoan() == 1){
					cashierMng.withLoan(bean.getLoan(),bean.getAmount());
				}
				//审批全部通过,修改冻结金额
				//费用类型1、收入	2、还款	3、直接报销		4、申请报销		5、借款	6、采购支付		7、合同报销
				cashierMng.deleteDjAmount(bean.getIndexId(),bean.getProDetailId(),bean.getAmount(),
						bean.getAmount(),bean.getDept(),bean.getUserId(),url,bean.getBeanCode(),"3");*/
				//生成审签信息
//				tProcessPrintDetailMng.arrangedirectlyCheckDetail( bean,  user);
		}
		super.saveOrUpdate(bean);
	}

	@Override
	public String directlyReimbReCall(Integer id) throws Exception {
		//根据id查询对象
		DirectlyReimbAppliBasicInfo bean=(DirectlyReimbAppliBasicInfo)super.findById(id);
		if(bean.getFlowStauts().equals("-4")){
			throw new ServiceException("该单据已被撤回，请勿重复操作！");
		}
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="申请被撤回消息";
		String msg="您待审批的  "+bean.getReason() +",任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//归还冻结金额
		budgetIndexMgrMng.deleteDjAmount(bean.getIndexId(),bean.getProDetailId(),bean.getAmount());
		//撤回
		bean=(DirectlyReimbAppliBasicInfo) reCall((CheckEntity) bean);
		this.updateDefault(bean);
		return "操作成功";
	}

	
	/*
	 * 直接报销申请新增和修改的保存
	 * @author 沈帆
	 * @createtime 2020-03-18
	 * @updatetime 2020-03-18
	 */
	@Override
	public void save1(DirectlyReimbAppliBasicInfo bean, DirectlyReimbPayeeInfo payeeBean, String files, User user, String mingxi,String form1,String payerinfoJson,
			   String payerinfoStudentJson,//学生付款列表json
			   String payerinfoCCBJson,//建行付款列表json
			   String payerinfoNoCCBJson//非建行付款列表json
			   )  throws Exception{
		
		Date d = new Date();
		bean.setReqTime(d);//报销时间
		bean.setUser(user.getId());//报销人ID
		bean.setDept(user.getDepart().getId());//报销人所属部门ID
		bean.setDeptName(user.getDepartName());//报销人所属部门名称
		bean.setType("0");
		if (bean.getDrId()==null) {
			bean.setCashierType("0");
			//创建人、创建时间
			bean.setCreator(user.getAccountNo());
			bean.setCreateTime(d);
			SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd"); 
			long date = new Date().getTime();
			int r=findBySql(bean, "select * from T_DIRECTLY_REIMB_APPLI_BASIC_INFO where year(F_CREATE_TIME) = year(now())", 0, 100000).getList().size();
			String data =format.format(date)+StringUtil.autoGenericCode(String.valueOf(r), 6);
			bean.setDrCode(data);
		} else {
			//修改人、修改时间
			bean.setUpdator(user.getAccountNo());
			bean.setUpdateTime(d);
		}
		//如果需要冲销  判断冲销金额是否超出借款金额和已经在执行的（剩余金额-冲销金）
		if("1".equals(String.valueOf(bean.getWithLoan()))){
			List<DirectlyReimbAppliBasicInfo> directlyList = findByLoanIdCX(String.valueOf(bean.getLoan().getlId()),bean.getDrCode());
			List<ReimbAppliBasicInfo> applyReimbList =reimbAppliMng.findByLoanIdCX(String.valueOf(bean.getLoan().getlId()),bean.getDrCode());
			List<ReimCXInfo> reimbList = new ArrayList<ReimCXInfo>();
			BigDecimal totalCxAmount =BigDecimal.ZERO;
			if(applyReimbList !=null && applyReimbList.size()>0){
				for(int i = 0;i < applyReimbList.size();i++){
					if(applyReimbList.get(i).getCxAmount() !=null){
						totalCxAmount =applyReimbList.get(i).getCxAmount().add(totalCxAmount);
					}
					ReimCXInfo info = new ReimCXInfo();
					info.setrId(applyReimbList.get(i).getrId());
					info.setgName(applyReimbList.get(i).getgName());
					info.setType(1);
					info.setCxAmount(applyReimbList.get(i).getCxAmount());
					info.setReimburseReqTime(applyReimbList.get(i).getReimburseReqTime());
					reimbList.add(info);
				}
			}
			if(directlyList !=null && directlyList.size()>0){
				for(int i = 0;i < directlyList.size();i++){
					if(directlyList.get(i).getCxAmount() !=null){
						totalCxAmount =directlyList.get(i).getCxAmount().add(totalCxAmount);
					}
					ReimCXInfo info = new ReimCXInfo();
					info.setrId(directlyList.get(i).getDrId());
					info.setgName(directlyList.get(i).getSummary());
					info.setType(0);
					info.setCxAmount(directlyList.get(i).getCxAmount());
					info.setReimburseReqTime(directlyList.get(i).getReqTime());
					reimbList.add(info);
				}
			}
			LoanBasicInfo loanBasicInfo = loanMng.findById(bean.getLoan().getlId());
			if("1".equals(loanBasicInfo.getFrepayStatus())||"9".equals(loanBasicInfo.getFrepayStatus())){
				throw new ServiceException("借款单正在还款登记或已还款，请选择其他冲销单据！");
			}
			if(totalCxAmount.compareTo(loanBasicInfo.getlAmount())==1){
				throw new ServiceException("累计冲销的金额超出了借款金额请注意查看！");
			}
			BigDecimal CE = loanBasicInfo.getlAmount().subtract(totalCxAmount);//获取到借款金额-已冲销金额（包括审核中的和已审核通过的冲销金额）=剩余还款金额
			if(CE.compareTo(bean.getCxAmount())==-1){
				throw new ServiceException("冲销金额超出了借款剩余还款金额请注意查看！");
			}
			
		}else{
			bean.setLoan(null);
		}
		TBudgetIndexMgr budgetIndexMgr = null;
		if(StringUtils.isNotEmpty(String.valueOf(bean.getIndexId()))){
			//判断所选指标是否当前用户部门指标，如果是则设置指标所属部门字段为空，如果不是则设置指标所属部门字段值为所选指标的部门
			budgetIndexMgr = budgetIndexMgrMng.findById(bean.getIndexId());
			if(StringUtils.isNotEmpty(String.valueOf(bean.getIndexId()))){
				if(!budgetIndexMgr.getDeptCode().equals(user.getDepart().getId())){
					bean.setIfDeptIndex("0");
				}else{
					bean.setIfDeptIndex("1");
				}
			}
		}
		//工作流的节点配置（如果点送审则设置进入工作流1为提交2为审核中）
		if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
			
			//保存基本信息
			bean = (DirectlyReimbAppliBasicInfo) super.saveOrUpdate(bean);
			String strType = "ZJBX";
			//得到第一个审批节点key
			TProcessDefin processDefin = null;
			//根据资源名称和当前登陆者所属部门查询对应工作流
			if (("0").equals(bean.getIsconvention())) {
				strType = "BXTYLC";
			}
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), strType, user);
			processDefin=tProcessDefinMng.getByBusiAndDpcode(strType, user.getDpID());

			Integer flowId = processDefin.getFPId();
			User nextUser = new User();
			TNodeData node = new TNodeData();
			
			TProBasicInfo pro = tProBasicInfoMng.findById(budgetIndexMgr.getFProId());
			
			if(1==pro.getFProOrBasic()){//项目支出才有项目负责人
				nextUser = userMng.findById(pro.getFProHeadId());
				//设置下节点处理人姓名和编号		
				bean.setUserName2(nextUser.getName());
				bean.setFuserId(nextUser.getId());
				//设置下节点节点编码
				bean.setnCode("FProHead");	//该标识标识目前处于项目负责人审批节点
			}else if(0==pro.getFProOrBasic()){//基本支出没有项目负责人
				node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
				nextUser=userMng.findById(node.getUserId());
				//设置下节点处理人姓名和编号		get(0)的原因是一个角色应该只能审批一级，所以查出来li应该只有一个数据
				bean.setUserName2(nextUser.getName());
				bean.setFuserId(nextUser.getId());
				//设置下节点节点编码
				bean.setnCode(firstKey+"");	
			}
			
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getDrId());//申请单ID
			work.setTaskCode(bean.getDrCode());//为申请单的单号
			work.setTaskName("[直接报销]"+bean.getSummary());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/reimburseCheck/check?id="+bean.getDrId()+"&reimburseType=0");//为审批页面内容显示的url,需要将数据传入不然无法访问
			work.setUrl1("/directlyReimburse/edit?id="+ bean.getDrId()+"&editType=0");//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setTaskType("1");//任务归属（1审批人）
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(d);//任务提交时间
			personalWorkMng.merge(work);
			
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(bean.getDrId());//申请单ID
			work2.setTaskCode(bean.getDrCode());//为申请单的单号
			work2.setTaskName("[直接报销]"+bean.getSummary());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/directlyReimburse/edit?id="+ bean.getDrId()+"&editType=1");//退回修改url
			work2.setUrl1("/directlyReimburse/edit?id="+ bean.getDrId()+"&editType=0");//查看url
			work2.setUrl2("/directlyReimburse/delete?id="+ bean.getDrId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setTaskType("0");//任务归属（0发起人）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work2.setBeforeTime(d);//任务提交时间
			work2.setFinishTime(d);
			personalWorkMng.merge(work2);
			//计算明细申请金额总数
			BigDecimal num = BigDecimal.ZERO;
			num = bean.getAmount();
			budgetIndexMgrMng.addDjAmount(bean.getIndexId(),bean.getProDetailId(),num);
		} else {
			//保存基本信息
			bean = (DirectlyReimbAppliBasicInfo) super.saveOrUpdate(bean);
		}
		//保存附件信息
		attachmentMng.joinEntity(bean,files);
		getSession().createSQLQuery("delete from T_DIRECTLY_REIMB_DETAIL where F_DR_ID="+bean.getDrId()+"").executeUpdate();
		
		//保存费用明细
		List<DirectlyReimbDetail> mingxiList = JSON.parseObject("["+mingxi.toString().substring(0, mingxi.length()-1)+"]",new TypeReference<List<DirectlyReimbDetail>>(){});
		for(int i=0;i<=mingxiList.size()-1;i++) {
			DirectlyReimbDetail reimbDetail =new DirectlyReimbDetail();
			reimbDetail = mingxiList.get(i);
			reimbDetail.setDrId(bean.getDrId());
			super.merge(reimbDetail);
		}
		if("TONGYONG".equals(bean.getDirType())){//直接报销类型----通用
			//删除数据库中   报销中的收款人
			getSession().createSQLQuery("delete from T_REIMB_PAYEE_INFO where F_D_R_ID ="+bean.getDrId()).executeUpdate();
				if(!StringUtil.isEmpty(payerinfoJson)){
				List<ReimbPayeeInfo> ReimbPayeeInfoList = JSON.parseObject("["+payerinfoJson.toString().substring(0, payerinfoJson.length()-1)+"]",new TypeReference<List<ReimbPayeeInfo>>(){});
				for (ReimbPayeeInfo reimbPayeeInfo : ReimbPayeeInfoList) {
					ReimbPayeeInfo info = new ReimbPayeeInfo();
					info.setDrId(bean.getDrId());
					info.setPayeeId(reimbPayeeInfo.getPayeeId());
					info.setPayeeName(reimbPayeeInfo.getPayeeName());
					info.setPaymentType(reimbPayeeInfo.getPaymentType());
					info.setBank(reimbPayeeInfo.getBank());
					info.setBankAccount(reimbPayeeInfo.getBankAccount());
					info.setPayeeAmount(reimbPayeeInfo.getPayeeAmount());
					info.setPayeeAmountGR(reimbPayeeInfo.getPayeeAmountGR());
					info.setZfbAccount(reimbPayeeInfo.getZfbAccount());//收款人个人卡开户行
					info.setWxAccount(reimbPayeeInfo.getWxAccount());//收款人个人卡账号
					super.merge(info);
				}
			}			
		}
		if("XUESHENG".equals(bean.getDirType())){//直接报销类型----学生
			//删除数据库中   报销中的收款人
			getSession().createSQLQuery("delete from T_REIMB_PAYEE_INFO where F_D_R_ID ="+bean.getDrId()).executeUpdate();
				if(!StringUtil.isEmpty(payerinfoStudentJson)){
				List<ReimbPayeeInfo> ReimbPayeeInfoList = JSON.parseObject("["+payerinfoStudentJson.toString().substring(0, payerinfoStudentJson.length()-1)+"]",new TypeReference<List<ReimbPayeeInfo>>(){});
				for (ReimbPayeeInfo reimbPayeeInfo : ReimbPayeeInfoList) {
					ReimbPayeeInfo info = new ReimbPayeeInfo();
					info.setDrId(bean.getDrId());
					info.setSclass(reimbPayeeInfo.getSclass());
					info.setPayeeName(reimbPayeeInfo.getPayeeName());
					info.setProName(reimbPayeeInfo.getProName());
					info.setNumberDays(reimbPayeeInfo.getNumberDays());
					info.setEveryoneAmount(reimbPayeeInfo.getEveryoneAmount());
					info.setBankAccount(reimbPayeeInfo.getBankAccount());
					info.setPayeeAmount(reimbPayeeInfo.getPayeeAmount());
					info.setTel(reimbPayeeInfo.getTel());
					info.setRemark(reimbPayeeInfo.getRemark());
					super.merge(info);
				}
			}
		}
		if("JIANHANG".equals(bean.getDirType())){//直接报销类型----建行
			//删除数据库中   报销中的收款人
			getSession().createSQLQuery("delete from T_REIMB_PAYEE_INFO where F_D_R_ID ="+bean.getDrId()).executeUpdate();
				if(!StringUtil.isEmpty(payerinfoCCBJson)){
				List<ReimbPayeeInfo> ReimbPayeeInfoList = JSON.parseObject("["+payerinfoCCBJson.toString().substring(0, payerinfoCCBJson.length()-1)+"]",new TypeReference<List<ReimbPayeeInfo>>(){});
				for (ReimbPayeeInfo reimbPayeeInfo : ReimbPayeeInfoList) {
					ReimbPayeeInfo info = new ReimbPayeeInfo();
					info.setDrId(bean.getDrId());
					info.setPayeeName(reimbPayeeInfo.getPayeeName());
					info.setCompany(reimbPayeeInfo.getCompany());
					info.setDuty(reimbPayeeInfo.getDuty());
					info.setTel(reimbPayeeInfo.getTel());
					info.setIdCard(reimbPayeeInfo.getIdCard());
					info.setBankAccount(reimbPayeeInfo.getBankAccount());
					info.setPlanAmount(reimbPayeeInfo.getPlanAmount());
					info.setDeductionAmount(reimbPayeeInfo.getDeductionAmount());
					info.setPayeeAmount(reimbPayeeInfo.getPayeeAmount());
					info.setRemark(reimbPayeeInfo.getRemark());
					super.merge(info);
				}
			}
		}
		if("FEIJIANHANG".equals(bean.getDirType())){//直接报销类型----非建行
			//删除数据库中   报销中的收款人
			getSession().createSQLQuery("delete from T_REIMB_PAYEE_INFO where F_D_R_ID ="+bean.getDrId()).executeUpdate();
				if(!StringUtil.isEmpty(payerinfoNoCCBJson)){
				List<ReimbPayeeInfo> ReimbPayeeInfoList = JSON.parseObject("["+payerinfoNoCCBJson.toString().substring(0, payerinfoNoCCBJson.length()-1)+"]",new TypeReference<List<ReimbPayeeInfo>>(){});
				for (ReimbPayeeInfo reimbPayeeInfo : ReimbPayeeInfoList) {
					ReimbPayeeInfo info = new ReimbPayeeInfo();
					info.setDrId(bean.getDrId());
					info.setPayeeName(reimbPayeeInfo.getPayeeName());
					info.setCompany(reimbPayeeInfo.getCompany());
					info.setDuty(reimbPayeeInfo.getDuty());
					info.setTel(reimbPayeeInfo.getTel());
					info.setIdCard(reimbPayeeInfo.getIdCard());
					info.setBank(reimbPayeeInfo.getBank());
					info.setBankAccount(reimbPayeeInfo.getBankAccount());
					info.setPlanAmount(reimbPayeeInfo.getPlanAmount());
					info.setDeductionAmount(reimbPayeeInfo.getDeductionAmount());
					info.setPayeeAmount(reimbPayeeInfo.getPayeeAmount());
					info.setRemark(reimbPayeeInfo.getRemark());
					super.merge(info);
				}
			}
		}
		
		//旧发票
		List<InvoiceCouponInfo> oldfp1 = invoiceCouponMng.findByrID(bean.getDrId(),"directly-1");
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
			newrd.setrId(bean.getDrId());
			newrd.setfDataType("directly-1");
			//保存新的明细
			super.merge(newrd);
		}	
	}

	@Override
	public void updateCashier(DirectlyReimbAppliBasicInfo drBean) {
		drBean = super.findById(drBean.getDrId());
		drBean.setCashierType("1");
		String url = "/directlyReimburse/edit?id="+drBean.getDrId()+"&editType=0";//设置单据查看路径
		//如果选择冲销借款  出纳点击付讫以后，报销的原有逻辑不变，新增判断，判断是否有冲销借款，如果有，则执行如下逻辑
		if(drBean.getWithLoan()!=null){
			if (drBean.getWithLoan() == 1){
				cashierMng.withLoan(drBean.getLoan(),drBean.getAmount());
			}
		}
		//审批全部通过,修改冻结金额
		//费用类型1、收入	2、还款	3、直接报销		4、申请报销		5、借款	6、采购支付		7、合同报销
		cashierMng.deleteDjAmount(drBean.getIndexId(),drBean.getProDetailId(),drBean.getAmount(),
				drBean.getAmount(),drBean.getDept(),drBean.getUserId(),url,drBean.getBeanCode(),"3");
		super.updateDefault(drBean);
		String msg = "您的编号："+drBean.getDrCode()+"的报销单据已经支付完成，请查收";
		privateInforMng.setMsg("[报销付讫]", msg, drBean.getUserId(), "3");
		personalWorkMng.sendMessageToUser(drBean.getUserId(), 0);
	}
	
	@Override
	public List<DirectlyReimbAppliBasicInfo> findByLoanId(String id) {
		Finder finder = Finder.create(" FROM  DirectlyReimbAppliBasicInfo WHERE loan.lId="+id+" and cashierType=1 and stauts !='99'");
		List<DirectlyReimbAppliBasicInfo> list = super.find(finder);
		return list;
	}

	@Override
	public List<DirectlyReimbAppliBasicInfo> findByLoanIdCX(String id,String code) {
		Finder finder = Finder.create(" FROM  DirectlyReimbAppliBasicInfo WHERE loan.lId="+id+" and stauts !='99' and drCode !='"+code+"' and flowStauts in('1','9')");
		List<DirectlyReimbAppliBasicInfo> list = super.find(finder);
		return list;
	}
	
	@Override
	public void saveApp(DirectlyReimbAppliBasicInfo bean, String files,
			User user, String mingxi, String form1, String payerinfoJson,
			String fpIds) throws Exception{
		Date d = new Date();
		bean.setReqTime(d);//报销时间
		bean.setUser(user.getId());//报销人ID
		bean.setDept(user.getDepart().getId());//报销人所属部门ID
		bean.setDeptName(user.getDepartName());//报销人所属部门名称
		bean.setType("0");
		if (bean.getDrId()==null) {
			bean.setCashierType("0");
			//创建人、创建时间
			bean.setCreator(user.getAccountNo());
			bean.setCreateTime(d);
			bean.setDrCode(StringUtil.Random(""));
		} else {
			//修改人、修改时间
			bean.setUpdator(user.getAccountNo());
			bean.setUpdateTime(d);
		}
		//如果需要冲销  判断冲销金额是否超出借款金额和已经在执行的（剩余金额-冲销金）
		if("1".equals(String.valueOf(bean.getWithLoan()))){
			List<DirectlyReimbAppliBasicInfo> directlyList = findByLoanIdCX(String.valueOf(bean.getLoan().getlId()),bean.getDrCode());
			List<ReimbAppliBasicInfo> applyReimbList =reimbAppliMng.findByLoanIdCX(String.valueOf(bean.getLoan().getlId()),bean.getDrCode());
			List<ReimCXInfo> reimbList = new ArrayList<ReimCXInfo>();
			BigDecimal totalCxAmount =BigDecimal.ZERO;
			if(applyReimbList !=null && applyReimbList.size()>0){
				for(int i = 0;i < applyReimbList.size();i++){
					if(applyReimbList.get(i).getCxAmount() !=null){
						totalCxAmount =applyReimbList.get(i).getCxAmount().add(totalCxAmount);
					}
					ReimCXInfo info = new ReimCXInfo();
					info.setrId(applyReimbList.get(i).getrId());
					info.setgName(applyReimbList.get(i).getgName());
					info.setType(1);
					info.setCxAmount(applyReimbList.get(i).getCxAmount());
					info.setReimburseReqTime(applyReimbList.get(i).getReimburseReqTime());
					reimbList.add(info);
				}
			}
			if(directlyList !=null && directlyList.size()>0){
				for(int i = 0;i < directlyList.size();i++){
					if(directlyList.get(i).getCxAmount() !=null){
						totalCxAmount =directlyList.get(i).getCxAmount().add(totalCxAmount);
					}
					ReimCXInfo info = new ReimCXInfo();
					info.setrId(directlyList.get(i).getDrId());
					info.setgName(directlyList.get(i).getSummary());
					info.setType(0);
					info.setCxAmount(directlyList.get(i).getCxAmount());
					info.setReimburseReqTime(directlyList.get(i).getReqTime());
					reimbList.add(info);
				}
			}
			LoanBasicInfo loanBasicInfo = loanMng.findById(bean.getLoan().getlId());
			if("1".equals(loanBasicInfo.getFrepayStatus())||"9".equals(loanBasicInfo.getFrepayStatus())){
				throw new ServiceException("借款单正在还款登记或已还款，请选择其他冲销单据！");
			}
			if(totalCxAmount.compareTo(loanBasicInfo.getlAmount())==1){
				throw new ServiceException("累计冲销的金额超出了借款金额请注意查看！");
			}
			BigDecimal CE = loanBasicInfo.getlAmount().subtract(totalCxAmount);//获取到借款金额-已冲销金额（包括审核中的和已审核通过的冲销金额）=剩余还款金额
			if(CE.compareTo(bean.getCxAmount())==-1){
				throw new ServiceException("冲销金额超出了借款剩余还款金额请注意查看！");
			}
			
		}else{
			bean.setLoan(null);
		}
		//工作流的节点配置（如果点送审则设置进入工作流1为提交2为审核中）
		if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), "ZJBX", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("ZJBX", user.getDpID());
			Integer flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			User nextUser=userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号		get(0)的原因是一个角色应该只能审批一级，所以查出来li应该只有一个数据
			bean.setUserName2(nextUser.getName());
			bean.setFuserId(nextUser.getId());
			//设置下节点节点编码
			bean.setnCode(firstKey+"");	
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			//保存基本信息
			bean = (DirectlyReimbAppliBasicInfo) super.merge(bean);
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getDrId());//申请单ID
			work.setTaskCode(bean.getDrCode());//为申请单的单号
			work.setTaskName("[直接报销]"+bean.getSummary());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/reimburseCheck/check?id="+bean.getDrId()+"&reimburseType=0");//为审批页面内容显示的url,需要将数据传入不然无法访问
			work.setUrl1("/directlyReimburse/edit?id="+ bean.getDrId()+"&editType=0");//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setTaskType("1");//任务归属（1审批人）
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(d);//任务提交时间
			personalWorkMng.merge(work);
			
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(bean.getDrId());//申请单ID
			work2.setTaskCode(bean.getDrCode());//为申请单的单号
			work2.setTaskName("[直接报销]"+bean.getSummary());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/directlyReimburse/edit?id="+ bean.getDrId()+"&editType=1");//退回修改url
			work2.setUrl1("/directlyReimburse/edit?id="+ bean.getDrId()+"&editType=0");//查看url
			work2.setUrl2("/directlyReimburse/delete?id="+ bean.getDrId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setTaskType("0");//任务归属（0发起人）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work2.setBeforeTime(d);//任务提交时间
			work2.setFinishTime(d);
			personalWorkMng.merge(work2);
			//计算明细申请金额总数
			BigDecimal num = BigDecimal.ZERO;
			num = bean.getAmount();
			budgetIndexMgrMng.addDjAmount(bean.getIndexId(),bean.getProDetailId(),num);
		} else {
			//保存基本信息
			bean = (DirectlyReimbAppliBasicInfo) super.merge(bean);
		}
		//保存附件信息
		attachmentMng.joinEntity(bean,files);
		getSession().createSQLQuery("delete from T_DIRECTLY_REIMB_DETAIL where F_DR_ID="+bean.getDrId()+"").executeUpdate();


		//保存费用明细
		List<DirectlyReimbDetail> mingxiList = JSON.parseObject("["+mingxi.toString()+"]",new TypeReference<List<DirectlyReimbDetail>>(){});
		for(int i=0;i<=mingxiList.size()-1;i++) {
			DirectlyReimbDetail reimbDetail =new DirectlyReimbDetail();
			reimbDetail = mingxiList.get(i);
			reimbDetail.setDrId(bean.getDrId());
			super.merge(reimbDetail);
		}

		//删除数据库中   报销中的收款人
		getSession().createSQLQuery("delete from T_REIMB_PAYEE_INFO where F_D_R_ID ="+bean.getDrId()).executeUpdate();
		if(!StringUtil.isEmpty(payerinfoJson)){
			List<ReimbPayeeInfo> ReimbPayeeInfoList = JSON.parseObject("["+payerinfoJson.toString()+"]",new TypeReference<List<ReimbPayeeInfo>>(){});
			for (ReimbPayeeInfo reimbPayeeInfo : ReimbPayeeInfoList) {
				ReimbPayeeInfo info = new ReimbPayeeInfo();
				info.setDrId(bean.getDrId());
				info.setPayeeId(reimbPayeeInfo.getPayeeId());
				info.setPayeeName(reimbPayeeInfo.getPayeeName());
				info.setBank(reimbPayeeInfo.getBank());
				info.setBankAccount(reimbPayeeInfo.getBankAccount());
				info.setPayeeAmount(reimbPayeeInfo.getPayeeAmount());
				super.merge(info);
			}
		}
		//取消之前关联的发票
		List<AppInvoiceInfo> oldInvoList = invoiceMng.findByRID("0", bean.getDrId());
		if(oldInvoList!=null&&oldInvoList.size()>0){
			for (AppInvoiceInfo oldInvo : oldInvoList) {
				oldInvo.setfRId(null);
				oldInvo.setfInvoiceStatus("0");
			}
		}
		//关联发票
		if (!StringUtil.isEmpty(fpIds) && bean != null) {
			fpIds = fpIds.substring(0,fpIds.length() - 1);
			String[] ids = fpIds.split(",");
			if (ids.length > 0) {
				for (String id: ids) {
					AppInvoiceInfo invo = invoiceMng.findById(Integer.valueOf(id));
					if (invo != null ) {
						invo.setfRId(bean.getDrId());
						invo.setfInvoiceStatus("1");
						invo.setReimbType("0");
						super.saveOrUpdate(invo);
					}
				}
			}
		}

	}
	
	
	@Override
	public List<Lookups> getLookupsJson(String categoryCode,String blanked,String selected) {
		Finder hql=Finder.create("FROM Lookups WHERE flag='1' ");
		hql.append("  AND category.code =:pcode ").setParam("pcode", categoryCode);
		if(!StringUtil.isEmpty(blanked)){
			hql.append(" AND code<>:code").setParam("code", blanked);
		}
		hql.append(" ORDER BY convert(orderNo,SIGNED)");
		return super.find(hql);
	}

	@Override
	public List<ReimbPayeeInfo> directlyReimCollect(File file,String type) {
		List<ReimbPayeeInfo> list = new ArrayList<ReimbPayeeInfo>();
		PoiUtil pu = new PoiUtil();//excel数字行格式工具类
		
		if (file.exists()) {
			FileInputStream fis = null;
			Workbook workBook = null;//生成poi的execlWorkbook
			try {
				fis = new FileInputStream(file);
				workBook = WorkbookFactory.create(fis);
				Sheet sheet = workBook.getSheetAt(0);//只有一个sheet页
				int rowsOfSheet = sheet.getPhysicalNumberOfRows(); // 获取当前Sheet的总行数
				if("student".equals(type)){
					studentDetail(list, pu, sheet, rowsOfSheet);//学生信息导入明细
				}
				if("ccb".equals(type)){
					ccbDetail(list, pu, sheet, rowsOfSheet);//建行导入明细
				}
				if("noCCB".equals(type)){
					noCCBDetail(list, pu, sheet, rowsOfSheet);//非建行导入明细
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}finally{
				System.gc();
				if(fis!=null){
					try {
						fis.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return list;
	}

	/**
	 * 学生信息导入明细
	* <p>Description: </p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年8月6日
	 */
	private void studentDetail(List<ReimbPayeeInfo> list, PoiUtil pu,
			Sheet sheet, int rowsOfSheet) {
		for (int r = 1; r < rowsOfSheet; r++) { // 总行
			ReimbPayeeInfo detail = new ReimbPayeeInfo();//创建项目报销对象
			Row row = sheet.getRow(r);//获得行
			if (row == null) {
				continue;
			} else {
				int numberOfCells = row.getPhysicalNumberOfCells();
				for (int c = 0; c < numberOfCells; c++) {
					Cell cell = row.getCell(c);//获得单元格
					if (c == 1) {
						//班级
						String stringCellValue = pu.getCellValue(cell);
						detail.setSclass(stringCellValue);
					}
					if (c == 2) {
						//姓名
						String stringCellValue = pu.getCellValue(cell);
						detail.setPayeeName(stringCellValue);
					}
					if (c == 3) {
						//项目
						String stringCellValue = pu.getCellValue(cell);
						detail.setProName(stringCellValue);
					}
					if (c == 4) {
						//天数
						Double stringCellValue = cell.getNumericCellValue();
						if(StringUtils.isNotEmpty(String.valueOf(stringCellValue))){
							detail.setNumberDays(stringCellValue.intValue());
						}
					}
					if (c == 5) {
						//金额/人
						String stringCellValue = pu.getCellValue(cell);
						if(StringUtils.isNotEmpty(stringCellValue)){
							detail.setEveryoneAmount(BigDecimal.valueOf(Double.valueOf(stringCellValue)));
						}
					}
					if (c == 6) {
						//建行账号
						String stringCellValue = pu.getCellValue(cell);
						if(StringUtils.isNotEmpty(stringCellValue)){
							detail.setBankAccount(stringCellValue);
						}
					}
					if (c == 7) {
						//总金额
						String stringCellValue = pu.getCellValue(cell);
						if(StringUtils.isNotEmpty(stringCellValue)){
							detail.setPayeeAmount(BigDecimal.valueOf(Double.valueOf(stringCellValue)));
						}
					}
					if (c == 8) {
						//联系号码
						String stringCellValue = pu.getCellValue(cell).substring(0, pu.getCellValue(cell).length());
						detail.setTel(stringCellValue);
					}
					if (c == 9) {
						//备注
						String stringCellValue = pu.getCellValue(cell);
						detail.setRemark(stringCellValue);
					}
					
				}
				list.add(detail);
			}
		}
	}
	
	/**
	 * 建行导入明细
	* <p>Description: </p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年8月6日
	 */
	private void ccbDetail(List<ReimbPayeeInfo> list, PoiUtil pu,
			Sheet sheet, int rowsOfSheet) {
		for (int r = 1; r < rowsOfSheet; r++) { // 总行
			ReimbPayeeInfo detail = new ReimbPayeeInfo();//创建项目报销对象
			Row row = sheet.getRow(r);//获得行
			if (row == null) {
				continue;
			} else {
				int numberOfCells = row.getPhysicalNumberOfCells();
				for (int c = 0; c < numberOfCells; c++) {
					Cell cell = row.getCell(c);//获得单元格
					if (c == 1) {
						//姓名
						String stringCellValue = pu.getCellValue(cell);
						detail.setPayeeName(stringCellValue);
					}
					if (c == 2) {
						//单位
						String stringCellValue = pu.getCellValue(cell);
						detail.setCompany(stringCellValue);
					}
					if (c == 3) {
						//职务/职称
						String stringCellValue = pu.getCellValue(cell);
						detail.setDuty(stringCellValue);
					}
					if (c == 4) {
						//手机号码
						String stringCellValue = pu.getCellValue(cell).substring(0, pu.getCellValue(cell).length());;
						detail.setTel(stringCellValue);
					}
					if (c == 5) {
						//身份证号
						String stringCellValue = pu.getCellValue(cell);
						detail.setIdCard(stringCellValue);
					}
					if (c == 6) {
						//建行账号
						String stringCellValue = pu.getCellValue(cell);
						detail.setBankAccount(stringCellValue);
					}
					if (c == 7) {
						//应发金额
						String stringCellValue = pu.getCellValue(cell);
						detail.setPlanAmount(BigDecimal.valueOf(Double.valueOf(stringCellValue)));
					}
					if (c == 8) {
						//扣税金额
						String stringCellValue = pu.getCellValue(cell);
						detail.setDeductionAmount(BigDecimal.valueOf(Double.valueOf(stringCellValue)));
					}
					if (c == 9) {
						//实发金额
						String stringCellValue = pu.getCellValue(cell);
						detail.setPayeeAmount(BigDecimal.valueOf(Double.valueOf(stringCellValue)));
					}
					if (c == 10) {
						//备注
						String stringCellValue = pu.getCellValue(cell);
						detail.setRemark(stringCellValue);
					}
					
				}
				list.add(detail);
			}
		}
	}
	
	/**
	 * 非建行导入明细
	* <p>Description: </p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年8月6日
	 */
	private void noCCBDetail(List<ReimbPayeeInfo> list, PoiUtil pu,
			Sheet sheet, int rowsOfSheet) {
		for (int r = 1; r < rowsOfSheet; r++) { // 总行
			ReimbPayeeInfo detail = new ReimbPayeeInfo();//创建项目报销对象
			Row row = sheet.getRow(r);//获得行
			if (row == null) {
				continue;
			} else {
				int numberOfCells = row.getPhysicalNumberOfCells();
				for (int c = 0; c < numberOfCells; c++) {
					Cell cell = row.getCell(c);//获得单元格
					if (c == 1) {
						//姓名
						String stringCellValue = pu.getCellValue(cell);
						detail.setPayeeName(stringCellValue);
					}
					if (c == 2) {
						//单位
						String stringCellValue = pu.getCellValue(cell);
						detail.setCompany(stringCellValue);
					}
					if (c == 3) {
						//职务/职称
						String stringCellValue = pu.getCellValue(cell);
						detail.setDuty(stringCellValue);
					}
					if (c == 4) {
						//手机号码
						String stringCellValue = pu.getCellValue(cell).substring(0, pu.getCellValue(cell).length());
						detail.setTel(stringCellValue);
					}
					if (c == 5) {
						//身份证号
						String stringCellValue = pu.getCellValue(cell);
						detail.setIdCard(stringCellValue);
					}
					if (c == 6) {
						//开户银行
						String stringCellValue = pu.getCellValue(cell);
						detail.setBank(stringCellValue);
					}
					if (c == 7) {
						//银行账号
						String stringCellValue = pu.getCellValue(cell);
						detail.setBankAccount(stringCellValue);
					}
					if (c == 8) {
						//应发金额
						String stringCellValue = pu.getCellValue(cell);
						detail.setPlanAmount(BigDecimal.valueOf(Double.valueOf(stringCellValue)));
					}
					if (c == 9) {
						//扣税金额
						String stringCellValue = pu.getCellValue(cell);
						detail.setDeductionAmount(BigDecimal.valueOf(Double.valueOf(stringCellValue)));
					}
					if (c == 10) {
						//实发金额
						String stringCellValue = pu.getCellValue(cell);
						detail.setPayeeAmount(BigDecimal.valueOf(Double.valueOf(stringCellValue)));
					}
					if (c == 11) {
						//备注
						String stringCellValue = pu.getCellValue(cell);
						detail.setRemark(stringCellValue);
					}
					
				}
				list.add(detail);
			}
		}
	}
}
