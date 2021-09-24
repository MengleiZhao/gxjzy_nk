package com.braker.icontrol.cgmanage.cgapply.manager.impl;


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.JpushClientUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.EconomicMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.cgmanage.cgcheck.manager.CgCheckMng;
import com.braker.icontrol.cgmanage.cgconfplan.mananger.CgConPlanMng;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlanList;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgBidMng;
import com.braker.icontrol.cgmanage.cgprocess.model.BidRegist;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 采购申请的service实现类
 * @author 冉德茂
 * @createtime 2018-07-10
 * @updatetime 2018-07-10
 */
@Service
@Transactional
public class CgApplyMngImpl extends BaseManagerImpl<PurchaseApplyBasic> implements CgApplysqMng {
	
	
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private CgConPlanMng cgConfPlanMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private CgCheckMng cgcheckMng;
	@Autowired
	private EconomicMng economicMng;
	@Autowired
	private CgBidMng cgBidMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	@Autowired
	private TProBasicInfoMng tProBasicInfoMng;
	
	
	
	
	
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-07-10
	 * @updatetime 2018-07-10
	 */
	@Override
	public Pagination pageList(PurchaseApplyBasic bean, int pageNo, int pageSize, User user, String timea, String timeb, String amounta, String amountb) {		
		Finder finder =Finder.create(" FROM PurchaseApplyBasic WHERE fStauts <>"+99+"");
		
		String deptIdStr=departMng.getDeptIdStrByUsers(user);
		finder.append(" and fUser = :fUser").setParam("fUser", user.getId());
 		/*if("".equals(deptIdStr)){ //普通岗位只能查看自己的
 			finder.append(" and fUser = :fUser").setParam("fUser", user.getId());
 		}else if("all".equals(deptIdStr)){//校长可以查看所有人的
 			
 		}else{//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
 			finder.append(" and fDeptId in ("+deptIdStr+")");
 		}*/
		
		if(!StringUtil.isEmpty(bean.getFpCode())){ //按采购编号模糊查询
			finder.append(" AND fpCode LIKE :fpCode");
			finder.setParam("fpCode", "%"+bean.getFpCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFpName())){ //按采购名称模糊查询
			finder.append(" AND fpName LIKE :fpName");
			finder.setParam("fpName", "%"+bean.getFpName()+"%");
		}
		if(!StringUtil.isEmpty(bean.getfDeptName())){ //按部门名称模糊查询
			finder.append(" AND fDeptName LIKE :fDeptName");
			finder.setParam("fDeptName", "%"+bean.getfDeptName()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFpMethodStr()) ){//采购方式
			finder.append(" AND fpMethod = :fpMethod");
			finder.setParam("fpMethod", bean.getFpMethodStr());
		}
		/*if(!StringUtil.isEmpty(bean.getForgtype())){//组织形式
			finder.append(" AND fOrgType.code = :fOrgType");
			finder.setParam("fOrgType", bean.getForgtype());
		}*/
		if(!StringUtil.isEmpty(bean.getIndexCode()) ){//支出科目ID
			finder.append(" AND indexCode = :indexCode");
			finder.setParam("indexCode", bean.getIndexCode());
		}
		
		/*Double fpAmount = bean.getFpAmount();
		if(!StringUtil.isEmpty(String.valueOf(fpAmount))){//支出金额
			finder.append(" AND fpAmount = :fpAmount");
			finder.setParam("fpAmount", bean.getFpAmount());
		}*/
		if(bean.getFpAmount()!=null){//支出金额
			finder.append(" AND fpAmount = :fpAmount");
			finder.setParam("fpAmount", bean.getFpAmount());
		}
		if(!StringUtil.isEmpty(bean.getfCheckStauts()) ){//审批状态
			if("2".equals(bean.getfCheckStauts())){//审核中
				finder.append(" AND fCheckStauts >0 and fCheckStauts <9");
			}else{
				finder.append(" AND fCheckStauts = :fCheckStauts");
				finder.setParam("fCheckStauts", bean.getfCheckStauts());
				finder.append(" AND ((fIsContract='1' and fpAmount<10000 and fpPype!='CGLX-01') or (fbidStauts='1')) and fContractSts is null");
			}
		}
		finder.append(" order by fpId desc ");
		return super.find(finder,pageNo,pageSize);
	}

	/*
	 * 根据id删除
	 * @author 冉德茂
	 * @createtime 2018-07-11
	 * @updatetime 2018-07-11
	 */
	@Override
	public void delete(Integer id) {
		//更改采购的显示状态
		PurchaseApplyBasic bean = super.findById(id);
		bean.setfStauts("99");
		/*//更改配置计划的显示状态
		ProcurementPlan confbean = cgConfPlanMng.findById(bean.getFplId());
		confbean.setFisChecked("0");*/
		
		super.saveOrUpdate(bean);
	//	super.merge(confbean);
		
	}

	/*
	 * 保存采购计划申请信息
	 * @author 冉德茂
	 * @createtime 2018-10-17
	 * @updatetime 2018-10-17
	 */
	@Override
	@Transactional(propagation=Propagation.REQUIRED)//事务处理
	public void save(PurchaseApplyBasic pab, String files1, String files2, String files3,String files4,  String mingxi,User user)  throws Exception {
		//获取现有的明细
//		List mxList = getMingXiJson(mingxi, ProcurementPlanList.class);
		Date date = new Date();
		if (pab.getFpId()==null) {
			//创建人、创建时间、发布时间  设置验收状态
			pab.setCreator(user.getName());
			pab.setCreateTime(date);
			pab.setfDeptId(user.getDpID());
			pab.setfDeptName(user.getDepartName());
			pab.setfUser(user.getId());
			pab.setfReqTime(date);
			
		} else {
			//修改人、修改时间
			pab.setUpdator(user.getName());
			pab.setUpdateTime(date);
			pab.setfReqTime(date);
			
		}
		
		//保存采购方式   组织形式   评标方法   为字典表类型
//		pab.setfEvaMethod(economicMng.findLookupsByCode(pab.getfEvaMethod().getCode(), "BID_METHOD"));
		/*pab.setfOrgType(economicMng.findLookupsByCode(pab.getfOrgType().getCode(), "CGORG_TYPE"));
		if(pab.getfOrgType().getCode().equals("CGORG_TYPE_1")){
			pab.setFpMethod(economicMng.findLookupsByCode(pab.getFpMethod().getCode(), "JZCGFS"));
		}else{
			pab.setFpMethod(economicMng.findLookupsByCode(pab.getFpMethod().getCode(), "FSCGFS"));
		}*/
		
		//设置默认状态
		pab.setFbidStauts("0");//中标状态   默认0
		pab.setfIsReceive("0"); // 默认验收状态   0 未验收		1已验收
		//pab.setfIsInquiry("0");//默认询价状态   0 未询价    1已询价   询价状态   焦广兴更改为 是否论证状态 
		pab.setFpayStauts("0");//付款的审批状态默认0   验收通过发起申请 通过后变为9
		pab.setFevalStauts("0");//供应商的评价状态  评价后改为1
		pab.setFtendingStauts("0");//招标状态  10.23更改需求  不允许流标
		
		if(pab.getFpAmount().compareTo(BigDecimal.valueOf(10000))==-1){
			if(pab.getfIsContract().equals("1")){
				pab.setfPType("1");
			}else{
				pab.setfPType("2");
			}
		}else{
			pab.setfPType("3");
		}
		
		//以下为工作流的节点配置（如果点送审则设置进入工作流1为提交2为审核中）
		if(pab.getfCheckStauts().equals("1") || pab.getfCheckStauts().equals("2")){
			Integer flowId =0;
			User nextUser = new User();
			TBudgetIndexMgr budgetIndexMgr = budgetIndexMgrMng.findById(pab.getIndexId());
			TProBasicInfo pro = tProBasicInfoMng.findById(budgetIndexMgr.getFProId());
			String type = null;
			if (pro.getFProAppliDepart().equals(pab.getfDeptName())) {
				type= "HWCGSQ";
			}else {
				type= "HWCGSQF";
			}
			//得到第一个审批节点key
			Integer firstKey;
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=new TProcessDefin();
			if(pab.getfItems().equals("A")|| "B".equals(pab.getfItems())|| "C".equals(pab.getfItems())){
				firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(), pab.getJoinTable(),pab.getBeanCodeField(),pab.getBeanCode(),type, user);
				processDefin=tProcessDefinMng.getByBusiAndDpcode(type, user.getDpID());
			}else{
				firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),pab.getJoinTable(),pab.getBeanCodeField(),pab.getBeanCode(), "GCCGSQ", user);
				processDefin=tProcessDefinMng.getByBusiAndDpcode("GCCGSQ", user.getDpID());
			}
			flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			if(StringUtil.isEmpty(node.getText())){
				if(!StringUtil.isEmpty(String.valueOf(pab.getIndexId()))){
					TProBasicInfo basicInfo = tProBasicInfoMng.findById(pab.getIndexId());//如果是专用经费申请，则通过预算项目的id来获取预算项目的部门负责人
					nextUser = userMng.getUserByRoleNameAndDepartName("部门负责人", basicInfo.getFProAppliDepart());
				}
			}else{
				nextUser=userMng.findById(node.getUserId());
			}
			//设置下节点处理人姓名和编号 get(0)的原因是一个角色应该只能审批一级，所以查出来li应该只有一个数据
			pab.setUserName2(nextUser.getName());
			pab.setFuserId(nextUser.getId());
			//设置下节点节点编码
			pab.setnCode(firstKey+"");	
			
			
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,pab.getBeanCode());
			//保存基本信息
			if(pab.getFpId()==null){
				pab = (PurchaseApplyBasic) super.saveOrUpdate(pab); //新增
				
			}else{
				super.updateDefault(pab);//修改
			}
			
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(pab.getFpId());//申请单ID
			work.setTaskCode(pab.getFpCode());//为申请单的单号
			work.setTaskName("[采购申请]"+pab.getFpName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/cgcheck/check?id="+pab.getFpId());//为审批页面内容显示的url,需要将数据传入不然无法访问
			work.setUrl1("/cgsqsp/detail?id="+pab.getFpId());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setTaskType("1");//任务归属（1审批人）
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(date);//任务提交时间
			personalWorkMng.merge(work);
			
			/**叶添加**/
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(pab.getFpId());//申请单ID
			work2.setTaskCode(pab.getFpCode());//为申请单的单号
			work2.setTaskName("[采购申请]"+pab.getFpName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/cgsqsp/edit?id="+pab.getFpId());//修改url
			work2.setUrl1("/cgsqsp/detail?id="+pab.getFpId());//查看url
			work2.setUrl2("/cgsqsp/delete?id="+pab.getFpId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setTaskType("0");//任务归属（0发起人）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work2.setBeforeTime(date);//任务提交时间
			work2.setFinishTime(date);
			personalWorkMng.merge(work2);
			BigDecimal num = pab.getFpAmount();
			budgetIndexMgrMng.addDjAmount(pab.getIndexId(),pab.getProDetailId(),num);
			//推送通知到app
			if(JpushClientUtil.sendToRegistrationId(nextUser.getAccountNo(),null,"您有一条待审批任务",work.getTaskName()+"\b"+"任务编号："+work.getTaskCode(),work.getTaskId().toString(), "0","cgsq")==1){
	            System.out.println("推送给指定Android用户success");
	        }
		} else {
			//保存基本信息
			if(pab.getFpId()==null){
				pab = (PurchaseApplyBasic) super.saveOrUpdate(pab); //新增
			}else{
				super.updateDefault(pab);//修改
			}
		}
		
		//获得老的明细
//		List<Object> oldmxList = getParchaseMingxi(pab.getFpId(),"1");
//		
//		//比较新老明细的不同
//		for (int i = oldmxList.size()-1; i >= 0; i--) {
//			ProcurementPlanList oldgad = (ProcurementPlanList) oldmxList.get(i);
//			for (int j = 0; j < mxList.size(); j++) {
//				ProcurementPlanList gad = (ProcurementPlanList) mxList.get(j);
//				if(gad.getFpId()!=null){
//					if(gad.getFpId()==oldgad.getFpId()){
//						oldmxList.remove(i);
//					}
//				}
//			}
//		}
//		
//		//删除在新明细中没有的老明细
//		if(oldmxList.size()>0){
//			for (int i = 0; i < oldmxList.size(); i++) {
//				ProcurementPlanList oldgad = (ProcurementPlanList) oldmxList.get(i);
//				super.delete(oldgad);
//			}
//		}
//		
//		//保存新的明细
//		for (int j = 0; j < mxList.size(); j++) {
//			ProcurementPlanList gad = (ProcurementPlanList) mxList.get(j);
//			gad.setFpId(pab.getFpId());
//			gad.setfType("1");
//			/*gad.setCreator(user.getAccountNo());
//			gad.setCreateTime(d);*/
//			super.merge(gad);
//		}
		
		//保存附件信息
		//项目需求书
		attachmentMng.joinEntity(pab, files1);
		//采购论证结论
		attachmentMng.joinEntity(pab, files2);
		//三重一大会议纪要
		attachmentMng.joinEntity(pab, files3);
		//大型仪器设备前期调研报告
		attachmentMng.joinEntity(pab, files4);
	
	}
	
	/*
	 * 采购品目明细查询
	 * @author 冉德茂
	 * @createtime 2018-07-13
	 * @updatetime 2018-07-13
	 */
	public List<Object> getMingxi(String tableName ,String idName ,Integer pid) {
		Finder finder = Finder.create(" FROM " + tableName + " WHERE " + idName + "="+pid);
		return super.find(finder);
	}
	
	
	public List<Object> getParchaseMingxi(Integer pid,String type) {
		Finder finder = Finder.create(" from ProcurementPlanList WHERE fpId ='"+pid+"' and fType ='"+type+"' ");
		return super.find(finder);
	}
	
	/*
	 * 获取明细的Json对象
	 * @author 冉德茂
	 * @createtime 2018-07-14
	 * @updatetime 2018-07-14
	 */
	public List getMingXiJson(String mingxi, Class tableClass) {
		//获取明细的Json对象
		List mx = null;
		JSONArray array =JSONArray.fromObject("["+mingxi.toString()+"]");
		mx = (List)JSONArray.toList(array, tableClass);
		return mx;
	}


	
	
	/*
	 * 审批台账分页查询
	 * @author 冉德茂
	 * @createtime 2018-07-20
	 * @updatetime 2018-07-20
	 */
	@Override
	public Pagination ledgerPageList(PurchaseApplyBasic bean, int pageNo,int pageSize, User user) {
		Finder finder = Finder.create(" FROM PurchaseApplyBasic WHERE fCheckStauts='9' AND fStauts <> '99'");	
				
		if(!StringUtil.isEmpty(bean.getFpCode())){ //按采购编号模糊查询
			finder.append(" AND fpCode LIKE :fpCode");
			finder.setParam("fpCode", "%"+bean.getFpCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFpName())){ //按采购名称模糊查询
			finder.append(" AND fpName LIKE :fpName");
			finder.setParam("fpName", "%"+bean.getFpName()+"%");
		}
		String deptIdStr=departMng.getDeptIdStrByUser(user);
 		if("".equals(deptIdStr)){ //普通岗位只能查看自己的
 			finder.append(" and fUser = :fUser").setParam("fUser", user.getId());
 		}else if("all".equals(deptIdStr)){//校长可以查看所有人的
 			
 		}else{//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门（设备与安技处除外）
 			//if(!"设备与安技处".equals(user.getDepartName())){
 				finder.append(" and fDeptId in ("+deptIdStr+")");
 			//}
 		}
 		/*if(!StringUtil.isEmpty(bean.getFpMethodStr()) ){//采购方式
			finder.append(" AND fpMethod = :fpMethod");
			finder.setParam("fpMethod", bean.getFpMethodStr());
		}*/
		/*if(!StringUtil.isEmpty(bean.getForgtype())){//组织形式
			finder.append(" AND fOrgType.code = :fOrgType");
			finder.setParam("fOrgType", bean.getForgtype());
		}*/
		if(!StringUtil.isEmpty(bean.getfDeptName())){ //按申报部门模糊查询
			finder.append(" AND fDeptName LIKE :fDeptName");
			finder.setParam("fDeptName", "%"+bean.getfDeptName()+"%");
		}
		if(!StringUtil.isEmpty(bean.getfCheckStauts()) ){//审批状态
			if("2".equals(bean.getfCheckStauts())){//审核中
				finder.append(" AND fCheckStauts >0 and fCheckStauts <9");
			}else{
				finder.append(" AND fCheckStauts = :fCheckStauts");
				finder.setParam("fCheckStauts", bean.getfCheckStauts());
			}
		}
		finder.append(" order by fpId desc ");
		return super.find(finder, pageNo, pageSize);
	}
	
	
	/*
	 * 验收分页查询
	 * @author 冉德茂
	 * @createtime 2018-07-20
	 * @updatetime 2018-07-20
	 */
	@Override
	public Pagination receiveledgerPageList(PurchaseApplyBasic bean,String timea,String timeb, int pageNo,int pageSize, User user) {
		
		//查询已审批   已验收  已中标  未删除的数据  
		Finder finder =Finder.create(" FROM PurchaseApplyBasic WHERE fCheckStauts="+9+" AND fIsReceive ="+1+" AND fStauts <>"+99+" AND  fbidStauts='1' AND fevalStauts='1'");
		if(!StringUtil.isEmpty(bean.getFpCode())){ //按采购编号模糊查询
			finder.append(" AND fpCode LIKE :fpCode");
			finder.setParam("fpCode", "%"+bean.getFpCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFpName())){ //按采购名称模糊查询
			finder.append(" AND fpName LIKE :fpName");
			finder.setParam("fpName", "%"+bean.getFpName()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFpMethodStr()) ){//采购方式
			finder.append(" AND fpMethod = :fpMethod");
			finder.setParam("fpMethod", bean.getFpMethodStr());
		}
		/*if(!StringUtil.isEmpty(bean.getForgtype())){//组织形式
			finder.append(" AND fOrgType.code = :fOrgType");
			finder.setParam("fOrgType", bean.getForgtype());
		}*/
		String deptIdStr=departMng.getDeptIdStrByUser(user);
 		if("".equals(deptIdStr)){ //普通岗位只能查看自己的
 			finder.append(" and fUser = :fUser").setParam("fUser", user.getId());
 		}else if("all".equals(deptIdStr)){//校长可以查看所有人的
 			
 		}else{//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
 			finder.append(" and fDeptId in ("+deptIdStr+")");
 		}
		if(!StringUtil.isEmpty(bean.getfDeptName())){ //按申报部门模糊查询
			finder.append(" AND fDeptName LIKE :fDeptName");
			finder.setParam("fDeptName", "%"+bean.getfDeptName()+"%");
		}
		if(!StringUtil.isEmpty(String.valueOf(timea)) && !StringUtil.isEmpty(String.valueOf(timeb))){
			finder.append(" AND DATE_FORMAT(fReqTime,'%Y-%m-%d') >='"+timea+"' AND DATE_FORMAT(fReqTime,'%Y-%m-%d') <= '"+timeb+"'");//日期去时分秒函数
		}else if(!StringUtil.isEmpty(String.valueOf(timea))){
			finder.append(" AND DATE_FORMAT(fReqTime,'%Y-%m-%d') >='"+timea+"'");//日期去时分秒函数
		}else if(!StringUtil.isEmpty(String.valueOf(timeb))){
			finder.append(" AND  AND DATE_FORMAT(fReqTime,'%Y-%m-%d') <= '"+timeb+"'");//日期去时分秒函数
		}
		finder.append(" order by fpId desc ");
		Pagination p =super.find(finder, pageNo, pageSize);
		List<PurchaseApplyBasic> pabList = (List<PurchaseApplyBasic>) p.getList();
		/*//查询中标单位名称
		for (int i = 0; i < pabList.size(); i++) {
			BidRegist brList = cgBidMng.getBidRegistByPId(pabList.get(i).getFpId());
			pabList.get(i).setfOrgName(brList.getForgName());
		}
		p.setList(pabList);*/
		return p;
	}

	/*
	 * 根据pid查询采购批次编号
	 * @author 冉德茂
	 * @createtime 2018-07-24
	 * @updatetime 2018-07-24
	 */
	@Override
	public List<PurchaseApplyBasic> getCodeById(Integer id) {		
		Finder finder = Finder.create(" FROM PurchaseApplyBasic WHERE fpId='"+id+"'");	
		return super.find(finder);
	}

	
	/*
	 * 询比价登记查看采购基本信息
	 * @author 冉德茂
	 * @createtime 2018-08-01
	 * @updatetime 2018-08-01
	 * 
	 */
	@Override
	public Pagination qingdanpageList(PurchaseApplyBasic bean, Integer page,Integer rows, User user) {		
		Finder finder =Finder.create(" FROM PurchaseApplyBasic WHERE fCheckStauts="+9+" AND fStauts <>"+99+" ");
		if(!StringUtil.isEmpty(bean.getFpCode())){ //按采购编号模糊查询
			finder.append(" AND fpCode LIKE :fpCode");
			finder.setParam("fpCode", "%"+bean.getFpCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFpName())){ //按采购名称模糊查询
			finder.append(" AND fpName LIKE :fpName");
			finder.setParam("fpName", "%"+bean.getFpName()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFpMethodStr()) ){//采购方式
			finder.append(" AND fpMethod = :fpMethod");
			finder.setParam("fpMethod", bean.getFpMethodStr());
		}
		/*if(!StringUtil.isEmpty(bean.getForgtype())){//组织形式
			finder.append(" AND fOrgType.code = :fOrgType");
			finder.setParam("fOrgType", bean.getForgtype());
		}*/
		finder.append(" order by fReqTime desc");
		return super.find(finder,page, rows);
	}

	@Override
	public PurchaseApplyBasic findbyfpCode(String fpCode) {
		Finder finder=Finder.create(" from PurchaseApplyBasic where fpCode='"+fpCode+"'");
		return (PurchaseApplyBasic) super.find(finder).get(0);
	}
	/*
	 * 根据采购批次id获取合同金额
	 * @author 李安达
	 * @createtime 2018-11-29
	 * @updatetime 2018-11-29
	 * 
	 */
	@Override
	public String findFpAmountbyfpId(String fpId) {
		// TODO Auto-generated method stub
		Finder finder=Finder.create(" from BidRegist where fpId="+fpId+"");
		List<BidRegist> list=super.find(finder);
		if(list !=null && list.size()>0){
			BidRegist bidRegist=list.get(0);
			return bidRegist.getFbidAmount();
		}
		return "";
	}

	@Override
	public String reCall(Integer id) throws Exception {
		//根据id查询对象
		PurchaseApplyBasic bean=(PurchaseApplyBasic)super.findById(id);
		if(bean.getCheckStauts().equals("-4")){
			throw new ServiceException("该单据已被撤回，请勿重复操作！");
		}
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="采购申请被撤回消息";
		String msg="您待审批的  "+bean.getFpName() +",任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		budgetIndexMgrMng.deleteDjAmount(bean.getIndexId(),bean.getProDetailId(),bean.getFpAmount());
		//撤回
		bean=(PurchaseApplyBasic) reCall((CheckEntity) bean);
		this.updateDefault(bean);
		return "操作成功";
	}
	
	
	/*
	 * 采购细目分页查询
	 * @author 沈帆
	 * @createtime 2020-12-10
	 * @updatetime 2020-12-10
	 */
	@Override
	public Pagination ItemsPageList(Integer pageNo, Integer pageSize, String item) {		
		Finder finder =Finder.create(" FROM PurchaseItemsDetail WHERE fItem = '"+item+"' ");
		return super.find(finder,pageNo,pageSize);
	}

	/* 
	 * <p>Title: ledgerPageList</p>
	 * <p>Description: </p>
	 * @param bean
	 * @param pageNo
	 * @param pageSize
	 * @param user
	 * @return
	 * @see com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng#ledgerPageList(com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic, java.lang.Integer, java.lang.Integer, com.braker.core.model.User) 
	 * @author 陈睿超
	 * @createtime 2020年12月10日
	 * @updator 陈睿超
	 * @updatetime 2020年12月10日
	 */
	@Override
	public Pagination cgTenderingPageList(PurchaseApplyBasic bean, Integer pageNo,
			Integer pageSize, User user) {
			Finder finder = Finder.create(" FROM PurchaseApplyBasic WHERE fCheckStauts='9' AND fStauts <>"+99+" and fUser = '"+user.getId()+"'");	
					
			if(!StringUtil.isEmpty(bean.getFpCode())){ //按采购编号模糊查询
				finder.append(" AND fpCode LIKE :fpCode");
				finder.setParam("fpCode", "%"+bean.getFpCode()+"%");
			}
//			if(user.getRoleName().contains("部门负责人") && "设备与安技处".equals(user.getDepartName())){//如果是设备与安技处的部门负责人，登记政采项目
//					finder.append(" AND (((fPType='3' or fpPype='CGLX-01' or fUser='"+user.getId()+"') and fItems!='A40') or (fItems='A40' and fpAmount>=50000))");
//				}else{//否则申请人登记
//					finder.append(" AND (((fPType='3' and fpPype!='CGLX-01' and fUser='"+user.getId()+"') and fItems!='A40') or (fItems='A40' and fpAmount<50000))");
//				}
			if(!StringUtil.isEmpty(bean.getFpName())){ //按采购名称模糊查询
				finder.append(" AND fpName LIKE :fpName");
				finder.setParam("fpName", "%"+bean.getFpName()+"%");
			}
			if(!StringUtil.isEmpty(bean.getfDeptName())){ //按申报部门模糊查询
				finder.append(" AND fDeptName LIKE :fDeptName");
				finder.setParam("fDeptName", "%"+bean.getfDeptName()+"%");
			}
			finder.append(" order by fpId desc ");
			return super.find(finder, pageNo, pageSize);
		}
	
	/*
	 * 采购报销列表分页查询
	 * @author 沈帆
	 * @createtime 2020-12-15
	 * @updatetime 2020-12-15
	 */
	@Override
	public Pagination reimbPageList(Integer pageNo, Integer pageSize,PurchaseApplyBasic bean, User user){
		Finder finder =Finder.create(" FROM PurchaseApplyBasic WHERE fCheckStauts = '9' and  fIsReceive= '2'  and fpPype!='CGLX-01'");
		finder.append(" and fUser = '"+user.getId()+"' ");
		if(!StringUtil.isEmpty(bean.getFpCode())){ //按采购编号模糊查询
			finder.append(" AND fpCode LIKE :fpCode");
			finder.setParam("fpCode", "%"+bean.getFpCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFpName())){ //按采购名称模糊查询
			finder.append(" AND fpName LIKE :fpName");
			finder.setParam("fpName", "%"+bean.getFpName()+"%");
		}
		if(!StringUtil.isEmpty(bean.getfDeptName())){ //按部门名称模糊查询
			finder.append(" AND fDeptName LIKE :fDeptName");
			finder.setParam("fDeptName", "%"+bean.getfDeptName()+"%");
		}
		finder.append(" order by fReqTime desc, rId asc");
		return super.find(finder,pageNo,pageSize);
	}
	
	/*
	 * 采购报销审批列表分页查询
	 * @author 沈帆
	 * @createtime 2020-12-16
	 * @updatetime 2020-12-16
	 */
	@Override
	public Pagination reimbCheckPageList(Integer pageNo, Integer pageSize,PurchaseApplyBasic bean, User user){
		Finder finder =Finder.create(" FROM PurchaseApplyBasic WHERE fCheckStauts = '9' and  fIsReceive= '2' and fPType = '2' ");
		finder.append(" and fpId in (select purchaseId from ReimbAppliBasicInfo where type ='10' and fuserId =  '"+user.getId()+"') ");
		if(!StringUtil.isEmpty(bean.getFpCode())){ //按采购编号模糊查询
			finder.append(" AND fpCode LIKE :fpCode");
			finder.setParam("fpCode", "%"+bean.getFpCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFpName())){ //按采购名称模糊查询
			finder.append(" AND fpName LIKE :fpName");
			finder.setParam("fpName", "%"+bean.getFpName()+"%");
		}
		if(!StringUtil.isEmpty(bean.getfDeptName())){ //按部门名称模糊查询
			finder.append(" AND fDeptName LIKE :fDeptName");
			finder.setParam("fDeptName", "%"+bean.getfDeptName()+"%");
		}
		return super.find(finder,pageNo,pageSize);
	}

	@Override
	public HSSFWorkbook exportExcel(List<PurchaseApplyBasic> bean,
			String filePath) {
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
		FileInputStream fis =null;
		try {
			File file = new File(filePath);
			fis = new FileInputStream(file);
			HSSFWorkbook wb  = new HSSFWorkbook(fis);
			HSSFSheet sheet0 = wb.getSheetAt(0);
			if(bean.size()>0&&bean!=null){
				HSSFRow row = sheet0.getRow(1);//格式行
				for (int i = 0; i < bean.size(); i++) {
					HSSFRow hssfRow = sheet0.createRow(2+i);
					hssfRow.setHeight(row.getHeight());
					PurchaseApplyBasic data = bean.get(i);
					//序号
					HSSFCell cell0 = hssfRow.createCell(0);
					cell0.setCellValue(i + 1);
					//采购批次编号
					HSSFCell cell1 = hssfRow.createCell(1);
					cell1.setCellValue(data.getFpCode());
					//采购名称
					HSSFCell cell2 = hssfRow.createCell(2);
					cell2.setCellValue(data.getFpName());
					//采购金额
					HSSFCell cell3 = hssfRow.createCell(3);
					cell3.setCellValue(data.getFpAmount().doubleValue());
					//中标单位
					HSSFCell cell4 = hssfRow.createCell(4);
					cell4.setCellValue(data.getfOrgName());
					//中标金额
					HSSFCell cell5 = hssfRow.createCell(5);
					if(data.getFbidAmount()!=null){
						cell5.setCellValue(data.getFbidAmount().doubleValue());
					}else{
						cell5.setCellValue("");
					}
					//申报部门
					HSSFCell cell6 = hssfRow.createCell(6);
					cell6.setCellValue(data.getfDeptName());
					//申报时间
					HSSFCell cell7 = hssfRow.createCell(7);
					cell7.setCellValue(df.format(data.getfReqTime()));
					//申请人
					HSSFCell cell8 = hssfRow.createCell(8);
					cell8.setCellValue(data.getfUserName());
				}
				return wb;
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
}

	
	
	


