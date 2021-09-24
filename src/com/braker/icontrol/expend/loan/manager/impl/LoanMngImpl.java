package com.braker.icontrol.expend.loan.manager.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.LookupsMng;
import com.braker.core.manager.PaymentMethodInfoMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Lookups;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.TotalAmountOfBorrowing;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.loan.manager.LoanCheckMng;
import com.braker.icontrol.expend.loan.manager.LoanMng;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;
import com.braker.icontrol.expend.loan.model.LoanPayeeInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;

/**
 * 借款申请的service实现类
 * @author 叶崇晖
 * @createtime 2018-07-06
 * @updatetime 2018-07-06
 */
@Service
@Transactional
public class LoanMngImpl extends BaseManagerImpl<LoanBasicInfo> implements LoanMng {
	@Autowired
	private LoanCheckMng checkMng;
	
	@Autowired
	private PersonalWorkMng personalWorkMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private PaymentMethodInfoMng paymentMethodInfoMng;

	@Autowired
	private DepartMng departMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	@Autowired
	private LookupsMng lookupsMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	/*
	 * 分页查询
	 * @author 叶崇晖
	 * @createtime 2018-07-06
	 * @updatetime 2018-07-06
	 */
	@Override
	public Pagination pageList(LoanBasicInfo bean, int pageNo, int pageSize, User user,String sign) {
		Finder finder = Finder.create(" FROM LoanBasicInfo WHERE stauts in('1','0') ");
		if (!StringUtil.isEmpty(String.valueOf(bean.getlCode()))) {
			finder.append(" AND lCode LIKE '%"+bean.getlCode()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getEstChargeTime1()))) {
			finder.append(" AND DATE_FORMAT(estChargeTime,'%Y-%m-%d') >= '"+bean.getEstChargeTime1()+"'");//日期去时分秒函数
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getEstChargeTime2()))) {
			finder.append(" AND DATE_FORMAT(estChargeTime,'%Y-%m-%d') <= '"+bean.getEstChargeTime2()+"'");//日期去时分秒函数
		}
		if (!StringUtil.isEmpty(bean.getFlowStauts())) {
			if(bean.getFlowStauts().equals("1")) {
				finder.append(" and flowStauts in('1','2','3','4','5','6','7','8')");
			} else {
				finder.append(" and flowStauts = '"+bean.getFlowStauts()+"'");
			}
		}
		if("0".equals(sign)){
			if (!StringUtil.isEmpty(String.valueOf(bean.getLoanPurpose()))) {
				finder.append(" AND loanPurpose LIKE '%"+bean.getLoanPurpose()+"%'");
			}
			finder.append(" AND flowStauts ='9' AND (frepayStatus is null or frepayStatus ='-1' or frepayStatus ='0')");
		}
		finder.append("  AND user='"+user.getId()+"'");
		finder.append(" ORDER BY reqTime DESC ");
		return super.find(finder, pageNo, pageSize);
	}
	/*
	 * 首页借款查询
	 * @author 赵孟雷
	 * @createtime 2019-04-24
	 * @updatetime 2019-04-24
	 */
	@Override
	public List<LoanBasicInfo> homePageList(String flowStauts,String userId) {
		String sql = "select F_L_ID lId,F_REQ_TIME reqTime,F_PURPOSE loanPurpose,F_AMOUNT lAmount from T_LOAN_BASIC_INFO loanbasici0_"
				+ " where (loanbasici0_.F_STAUTS in ('1' , '0'))"
				+ " and loanbasici0_.F_USER='"+userId+"'"
				+ " and loanbasici0_.F_FLOW_STAUTS='"+flowStauts+"'"
				+ " ORDER BY F_REQ_TIME desc limit 8";
		Query query = getSession().createSQLQuery(sql);
		List<LoanBasicInfo> newList = new ArrayList<LoanBasicInfo>();
		List<Object[]> list = query.list();
		for (int i = 0; i < list.size(); i++) {
			LoanBasicInfo basicInfo = new LoanBasicInfo();
			/*bean.set*/
			basicInfo.setlId((Integer) list.get(i)[0]);
			basicInfo.setReqTime((Date) list.get(i)[1]);;
			basicInfo.setLoanPurpose(list.get(i)[2].toString());
			basicInfo.setlAmount(BigDecimal.valueOf(Double.valueOf(list.get(i)[3].toString())));;
			newList.add(basicInfo);
		}
		return newList;
	}
	/*
	 * 首页借款条数和总额
	 * @author 赵孟雷
	 * @createtime 2019-04-24
	 * @updatetime 2019-04-24
	 */
	@Override
	public List<TotalAmountOfBorrowing> homeTotalAmount(String flowStauts,String userId) {
		String sql = "select count(F_L_ID) CountLId,IFNULL(sum(F_AMOUNT),0) SumLAmount"
				+ " from T_LOAN_BASIC_INFO loanbasici0_"
				+ " where (loanbasici0_.F_STAUTS in ('1' , '0'))"
				+ " and loanbasici0_.F_USER='"+userId+"'"
				+ " and loanbasici0_.F_FLOW_STAUTS='"+flowStauts+"'"
				+ " and YEAR(loanbasici0_.F_CREATE_TIME)=YEAR(NOW())";
		Query query = getSession().createSQLQuery(sql);
		List<TotalAmountOfBorrowing> newList = new ArrayList<TotalAmountOfBorrowing>();
		List<Object[]> list = query.list();
		for (int i = 0; i < list.size(); i++) {
			TotalAmountOfBorrowing amountOfBorrowing = new TotalAmountOfBorrowing();
			/*bean.set*/
			amountOfBorrowing.setCountLId(list.get(i)[0].toString());
			amountOfBorrowing.setSumLAmount(list.get(i)[1].toString());;
			newList.add(amountOfBorrowing);
		}
		return newList;
	}
	
	/*
	 * 借款申请新增和修改的保存
	 * @author 叶崇晖
	 * @createtime 2018-07-07
	 * @updatetime 2018-07-07
	 */
	@Override
	public void save(LoanBasicInfo bean, LoanPayeeInfo payeeBean, User user)  throws Exception{
		//以下为工作流的节点配置（如果点送审则设置进入工作流1为提交2为审核中）
		Date d = new Date();
		bean.setReqTime(d);
		bean.setUser(user.getId());
		bean.setDept(user.getDepart().getId());
		bean.setDeptName(user.getDepartName());
		bean.setFrepayStatus("0");

		if (bean.getlId()==null) {
			//创建人、创建时间、发布时间、编号
			bean.setCreator(user.getAccountNo());
			bean.setCreateTime(d);
			bean.setlCode(StringUtil.Random("JK"));
			//新增时，设置剩余还款金额为借款金额
			bean.setLeastAmount(bean.getlAmount());
			
		} else {
			//修改人、修改时间
			bean.setUpdator(user.getAccountNo());
			bean.setUpdateTime(d);
			bean.setLeastAmount(bean.getlAmount());
		}
		
		if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(), bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(),"JKSQ", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("JKSQ", user.getDpID());
			Integer flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			User nextUser=userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号		
			bean.setUserName2(nextUser.getName());
			bean.setFuserId(nextUser.getId());
			//设置下节点节点编码
			bean.setnCode(firstKey+"");	
			
			//保存基本信息
			bean = (LoanBasicInfo) super.saveOrUpdate(bean);
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getlId());//申请单ID
			work.setTaskCode(bean.getlCode());//为申请单的单号
			work.setTaskName("[借款申请]"+bean.getLoanPurpose());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/loanCheck/check?id="+bean.getlId()+"&cashier=0");//审批url
			work.setUrl1("/loan/edit?id="+bean.getlId()+"&editType=0");//查看url
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
			work2.setTaskId(bean.getlId());//申请单ID
			work2.setTaskCode(bean.getlCode());//为申请单的单号
			work2.setTaskName("[借款申请]"+bean.getLoanPurpose());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/loan/edit?id="+bean.getlId()+"&editType=1");//退回修改url
			work2.setUrl1("/loan/edit?id="+bean.getlId()+"&editType=0");//查看url
			work2.setUrl2("/loan/delete?id="+bean.getlId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setTaskType("0");//任务归属（0发起人）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work2.setBeforeTime(d);//任务提交时间
			work2.setFinishTime(d);
			personalWorkMng.merge(work2);
			
			//送审的时候 修改指标冻结金额和剩余
			//Double jknum = bean.getlAmount();//借款金额
			//budgetIndexMgrMng.addDjAmount(bean.getIndexId(),bean.getProDetailId(),jknum);
		} else {
			//保存基本信息
			bean = (LoanBasicInfo) super.saveOrUpdate(bean);
		}
		
		//保存收款人信息
		payeeBean.setlId(bean.getlId());//关联借款单主键
		payeeBean.setPayeeId(user.getId());//收款人id
		payeeBean.setPayeeName(user.getName());//搜款人姓名
		payeeBean.setPayeeAmount(bean.getlAmount());//应付金额
		payeeBean.setPaymentType(bean.getPaymentType());
		super.merge(payeeBean);
		
		//保存或修改个人收款信息
		paymentMethodInfoMng.saveInfo(payeeBean, user);
	}
	
	/*
	 * 借款申请删除
	 * @author 叶崇晖
	 * @createtime 2018-07-07
	 * @updatetime 2018-07-07
	 */
	@Override
	public void delete(Integer id,String fid,User user) {
		LoanBasicInfo bean = super.findById(Integer.valueOf(id));
		personalWorkMng.deleteDb(user.getId(),bean.getlCode(),"0");
		//借款单的状态为99（删除）
		getSession().createSQLQuery("UPDATE t_loan_basic_info SET F_STAUTS=99 WHERE F_L_ID="+id).executeUpdate();
		personalWorkMng.sendMessageToUser(user.getId(), 0);
	}

	
	
	/*
	 * 审批分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-02
	 * @updatetime 2018-08-02
	 */
	@Override
	public Pagination checkPageList(LoanBasicInfo bean, int pageNo,int pageSize, User user) {
		Finder finder = Finder.create(" FROM LoanBasicInfo WHERE stauts in('1','0') AND fuserId='"+user.getId()+"' AND cashierType is null");
		if (!StringUtil.isEmpty(String.valueOf(bean.getlCode()))) {
			finder.append(" AND lCode LIKE '%"+bean.getlCode()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getEstChargeTime1()))) {
			finder.append(" AND DATE_FORMAT(estChargeTime,'%Y-%m-%d') >= '"+bean.getEstChargeTime1()+"'");//日期去时分秒函数
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getEstChargeTime2()))) {
			finder.append(" AND DATE_FORMAT(estChargeTime,'%Y-%m-%d') <= '"+bean.getEstChargeTime2()+"'");//日期去时分秒函数
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getDeptName()))) {
			finder.append(" AND deptName LIKE '%"+bean.getDeptName()+"%'");
		}
		finder.append(" order by estChargeTime desc");
		return super.find(finder, pageNo, pageSize);
	}

	
	/*
	 * 台账分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-02
	 * @updatetime 2018-08-02
	 */
	@Override
	public Pagination ledgerPageList(String loanString, LoanBasicInfo bean, int pageNo,int pageSize, User user, boolean isCashier) {
		Finder finder = Finder.create(" FROM LoanBasicInfo WHERE flowStauts='9' AND stauts='1'");	
		if (!StringUtil.isEmpty(String.valueOf(bean.getlCode()))) {
			finder.append(" AND lCode LIKE '%"+bean.getlCode()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getEstChargeTime1()))) {
			finder.append(" AND DATE_FORMAT(estChargeTime,'%Y-%m-%d') >= '"+bean.getEstChargeTime1()+"'");//日期去时分秒函数
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getEstChargeTime2()))) {
			finder.append(" AND DATE_FORMAT(estChargeTime,'%Y-%m-%d') <= '"+bean.getEstChargeTime2()+"'");//日期去时分秒函数
		}
		
		//判断权限
		String deptIdStr=departMng.getDeptIdStrByUser(user);
		if (isCashier) {
			//出纳岗可以查看所有部门的
		} else {
			if("".equals(deptIdStr)){ //普通岗位只能查看自己的
				finder.append(" and user = :user").setParam("user", user.getId());
			}else if("all".equals(deptIdStr)){//校长可以查看所有人的
				
			}else{//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
				finder.append(" and dept in ("+deptIdStr+")");
			}
			if (!StringUtil.isEmpty(String.valueOf(bean.getDeptName()))) {
				finder.append(" AND deptName LIKE '%"+bean.getDeptName()+"%'");
			}
		}
		if("0".equals(loanString)){
			finder.append(" and YEAR(F_REQ_TIME)=YEAR(NOW())");
		}
		
		finder.append(" ORDER BY reqTime DESC ");
		return super.find(finder, pageNo, pageSize);
	}

	/*
	 * 出纳受理分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-22
	 * @updatetime 2018-08-22
	 */
	@Override
	public Pagination cashierPageList(LoanBasicInfo bean, int pageNo,
			int pageSize, User user) {
		Finder finder = Finder.create(" FROM LoanBasicInfo WHERE flowStauts=9");
		if (!StringUtil.isEmpty(String.valueOf(bean.getlCode()))) {
			finder.append(" AND lCode LIKE '%"+bean.getlCode()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getlAmount1()))) {
			finder.append(" AND lAmount >= '"+bean.getlAmount1()+"'");//借款金额起始
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getlAmount2()))) {
			finder.append(" AND lAmount <= '"+bean.getlAmount2()+"'");//借款金额截止
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getDeptName()))) {
			finder.append(" AND deptName LIKE '%"+bean.getDeptName()+"%'");
		}
		
		return super.find(finder, pageNo, pageSize);
	}
	/*
	 * 资金归垫模块查询已审批  未删除的借款单信息
	 * @author 冉德茂
	 * @createtime 2018-10-09
	 * @updatetime 2018-10-09
	 */
	@Override
	public Pagination repayforpageList(LoanBasicInfo bean, int pageNo,int pageSize, String type,User user) {
		Finder finder = Finder.create(" FROM LoanBasicInfo WHERE flowStauts='9' and stauts <>"+99+" ");	
		if (!StringUtil.isEmpty(String.valueOf(bean.getReqTime()))) {
			finder.append(" AND datediff(reqTime,'"+bean.getReqTime()+"')=0 ");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getEstChargeTime()))) {
			finder.append(" AND datediff(estChargeTime,'"+bean.getEstChargeTime()+"')=0 ");
		}
		
		if (!StringUtil.isEmpty(String.valueOf(bean.getlCode()))) {
			finder.append(" AND lCode LIKE '%"+bean.getlCode()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getlAmount1()))) {
			finder.append(" AND lAmount >= '"+bean.getlAmount1()+"'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getlAmount2()))) {
			finder.append(" AND lAmount <= '"+bean.getlAmount2()+"'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getDeptName()))) {
			finder.append(" AND deptName LIKE '%"+bean.getDeptName()+"%'");
		}
		
		if (!StringUtil.isEmpty(String.valueOf(bean.getLoanPurpose()))) {
		   finder.append(" AND loanPurpose LIKE '%"+bean.getLoanPurpose()+"%'");
		}
		if("1".equals(type)) {
			finder.append(" AND frepayStatus='1'");
		}
		if(!StringUtil.isEmpty(bean.getlCode())){
			finder.append(" AND lCode LIKE :lCode");
			finder.setParam("lCode", "%"+bean.getlCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getDeptName())){
			finder.append(" AND deptName LIKE :deptName");
			finder.setParam("deptName", "%"+bean.getDeptName()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFrepayStatus())){
			finder.append(" AND frepayStatus='"+bean.getFrepayStatus()+"'");
		}
		if(user.getRoleName().contains("管理员")){
			//预算管理查看岗可以查看所有部门的台账
		}else {
			finder.append(" and user = :user").setParam("user", user.getId());
			/*String deptIdStr=departMng.getDeptIdStrByUser(user);
	 		if("".equals(deptIdStr)){ //普通岗位只能查看自己的
	 			finder.append(" and user = :user").setParam("user", user.getId());
	 		}else if("all".equals(deptIdStr)){//校长可以查看所有人的
	 			
	 		}else{//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
	 			finder.append(" and dept in ("+deptIdStr+")");
	 		}*/
		}
		return super.find(finder, pageNo, pageSize);
	}

	/**
	 * 查询需要导出的所有台账信息
	 * @author 叶崇晖
	 * @return 所有审批通过在台账页面的借款单List
	 */
	@Override
	public List<LoanBasicInfo> ledgerList(LoanBasicInfo bean,String loanString,String userId) {
		Finder finder = Finder.create(" FROM LoanBasicInfo WHERE flowStauts='9' AND stauts='1'");
		if (!StringUtil.isEmpty(String.valueOf(bean.getlCode()))) {
			finder.append(" AND lCode LIKE '%"+bean.getlCode()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getEstChargeTime1()))) {
			finder.append(" AND DATE_FORMAT(estChargeTime,'%Y-%m-%d') >= '"+bean.getEstChargeTime1()+"'");//日期去时分秒函数
		}
		String deptIdStr=departMng.getDeptIdStrByUser(userMng.findById(userId));
 		if("".equals(deptIdStr)){ //普通岗位只能查看自己的
 			finder.append(" and user = :user").setParam("user", userId);
 		}else if("all".equals(deptIdStr)){//校长可以查看所有人的
 			
 		}else{//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
 			finder.append(" and dept in ("+deptIdStr+")");
 		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getEstChargeTime2()))) {
			finder.append(" AND DATE_FORMAT(estChargeTime,'%Y-%m-%d') <= '"+bean.getEstChargeTime2()+"'");//日期去时分秒函数
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getDeptName()))) {
			finder.append(" AND deptName LIKE '%"+bean.getDeptName()+"%'");
		}
		if("0".equals(loanString)){
			finder.append(" and YEAR(F_REQ_TIME)=YEAR(NOW())");
			
		}
		return super.find(finder);
	}

	/**
	 * 生成需要导出的台账HSSFWorkbook
	 * @param ledgerData借款申请基本信息集合List
	 * @param filePath模板位置
	 * @return 台账HSSFWorkbook
	 */
	@Override
	public HSSFWorkbook exportLedger(List<LoanBasicInfo> ledgerData, String filePath) {
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		FileInputStream fis =null;
		try {
			File file = new File(filePath);
			fis = new FileInputStream(file);
			HSSFWorkbook wb  = new HSSFWorkbook(fis);
			HSSFSheet sheet0 = wb.getSheetAt(0);
			
			sheet0.getRow(1).createCell(1).setCellValue(df.format(new Date()));//设置导出时间
			
			HSSFRow row = sheet0.getRow(3);//格式行
			
			if(ledgerData.size()>0&&ledgerData!=null){
				for (int i = 0; i < ledgerData.size(); i++) {
					HSSFRow hssfRow = sheet0.createRow(3+i);
					if(row != null) {
						hssfRow.setHeight(row.getHeight());
					}
					
					//序号
					hssfRow.createCell(0).setCellValue(i + 1);
					//申请单编号
					hssfRow.createCell(1).setCellValue(ledgerData.get(i).getlCode());
					//用途
					hssfRow.createCell(2).setCellValue(ledgerData.get(i).getLoanPurpose());
					//借款金额
					hssfRow.createCell(3).setCellValue(ledgerData.get(i).getlAmount().doubleValue());
					//预算指标
					hssfRow.createCell(4).setCellValue(ledgerData.get(i).getIndexName());
					//所属部门
					hssfRow.createCell(5).setCellValue(ledgerData.get(i).getDeptName());
					//借款人
					User user = userMng.findById(ledgerData.get(i).getUser());
					hssfRow.createCell(6).setCellValue(user!=null?user.getName():"");
					//借款时间
					hssfRow.createCell(7).setCellValue(df.format(ledgerData.get(i).getReqTime()));
					//预计冲账时间
					hssfRow.createCell(8).setCellValue(df.format(ledgerData.get(i).getEstChargeTime()));
					//借款事由
					hssfRow.createCell(9).setCellValue(ledgerData.get(i).getLoanReason());
				}
				return wb;
			} else {
				return null;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(fis!=null){
				try {
					fis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}
	@Override
	public void daysRemind() {
		// TODO Auto-generated method stub
		Finder finder = Finder.create(" FROM LoanBasicInfo WHERE flowStauts = 9 and cashierType <> 1 ");
		List<LoanBasicInfo> list = super.find(finder);
		
		
		//通过消息推送，提示页面main.jsp更新待办事项数字
		for (int i = 0; i < list.size(); i++) {
			 int days = DateUtil.getDaySpanNoAbs(list.get(i).getEstChargeTime(), DateUtil.today());
			 //还款时间小于15天，每天提醒一次
			 if(days<=15){
				String title="借款单号："+list.get(i).getlCode()+"还款提醒";
				String msg="您的一笔"+list.get(i).getlAmount()+"元借款，将于"+days+"日后抵达还款日期，请及时关注！（借款单号："+list.get(i).getlCode()+"）";
				privateInforMng.setMsg(title, msg, list.get(i).getUser(), "1");
			}
			
		}	
		
		
	}
	@Override
	public String loanReCall(Integer id) throws Exception {
		//根据id查询对象
		LoanBasicInfo bean=(LoanBasicInfo)super.findById(id);
		if(bean.getFlowStauts().equals("-4")){
			throw new ServiceException("该单据已被撤回，请勿重复操作！");
		}
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="申请被撤回消息";
		String msg="您待审批的  "+bean.getLoanPurpose() +",任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//归还冻结金额
		//	budgetIndexMgrMng.deleteDjAmount(bean.getIndexId(),bean.getProDetailId(),bean.getlAmount());
		//撤回
		bean=(LoanBasicInfo) reCall((CheckEntity) bean);
		this.updateDefault(bean);
		return "操作成功";
	}
}
