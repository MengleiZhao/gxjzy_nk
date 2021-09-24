package com.braker.icontrol.budget.project.manager.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.DateUtil;
import com.braker.common.util.JpushClientUtil;
import com.braker.common.util.PoiUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.EconomicMng;
import com.braker.core.manager.LookupsMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Depart;
import com.braker.core.model.Lookups;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.ProjectDelay;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.budget.data.entity.AnalysisProBasicInfo;
import com.braker.icontrol.budget.data.manager.AnalysisProBasicInfoMng;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.BigProjectInfo;
import com.braker.icontrol.budget.project.entity.PerformanceIndicatorModel;
import com.braker.icontrol.budget.project.entity.TGovernmentPurchaseDetail;
import com.braker.icontrol.budget.project.entity.TProBasicCheckUpdate;
import com.braker.icontrol.budget.project.entity.TProBasicFunds;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.entity.TPurchaseManyYearsPro;
import com.braker.icontrol.budget.project.entity.XmDept;
import com.braker.icontrol.budget.project.manager.PerformanceIndicatorModelMng;
import com.braker.icontrol.budget.project.manager.TProBasicAccoAttacMng;
import com.braker.icontrol.budget.project.manager.TProBasicFundsMng;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProBasicPlanAttacMng;
import com.braker.icontrol.budget.project.manager.TProBasicRenameHistoryMng;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.budget.project.manager.TProGoalDetailMng;
import com.braker.icontrol.budget.project.manager.TProGoalMng;
import com.braker.icontrol.budget.project.manager.TProOutcomeAttacMng;
import com.braker.icontrol.budget.project.manager.TProPlanMng;
import com.braker.icontrol.budget.project.manager.XmDeptMng;
import com.braker.icontrol.contract.Formulation.model.ExecuteProject;
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
public class TProBasicInfoImpl extends BaseManagerImpl<TProBasicInfo> implements TProBasicInfoMng{
	
	@Autowired
	private XmDeptMng xmDeptMng;
	@Autowired 
	private TProBasicAccoAttacMng tProBasicAccoAttacMng;
	@Autowired
	private TProBasicPlanAttacMng tProBasicPlanAttacMng;
	@Autowired
	private TProOutcomeAttacMng tProOutcomeAttacMng;
	@Autowired
	private TProExpendDetailMng tProExpendDetailMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private EconomicMng economicMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	
	@Autowired
	private TProPlanMng tProPlanMng;
	@Autowired
	private TProGoalMng tProGoalMng;
	@Autowired
	private TProGoalDetailMng tProGoalDetailMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private TProBasicFundsMng tProBasicFundsMng;
	@Autowired
	private PerformanceIndicatorModelMng performancModelMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	@Autowired
	private TProBasicRenameHistoryMng tProBasicRenameHistoryMng;
	@Autowired
	private TProBasicInfoMng projectMng;
	@Autowired
	private AnalysisProBasicInfoMng analysisProMng;
	@Autowired
	private LookupsMng lookupsMng;
	
	
	
	@Override
	public void saveProject(TProBasicInfo bean, User user, String opeType, String outcomeJson,String purchaseJson,String purManyYearsProJson) throws Exception{
			//设置所属库
			if(bean.getFProOrBasic()==2){
				bean.setZxmImportStatus("0");
				bean.setFProLibType("5");
			}else{
				bean.setFProLibType("1");
			}
			//设置日期
			Date date = new Date();
			//设置常规信息
			if (bean.getFProId()==null) {//新增
				//创建人、 创建时间、申请人、申请部门
				bean.setCreator(user.getName());
				bean.setCreateTime(date);
				bean.setFProAppliTime(date);
				bean.setFProAppliPeopleId(user.getId());
				bean.setFProAppliPeople(user.getName());
				bean.setFProAppliDepartId(user.getDpID());
				bean.setFProAppliDepart(user.getDepartName());
				
				//保存常规信息--获取项目id
				bean = (TProBasicInfo) super.saveOrUpdate(bean);
				
				//项目编码
				
				String proCode=StringUtil.autoGenericCode(String.valueOf(bean.getFProId()), 6);
				//String proCode=bean.getFirstLevelCode()+"-"+bean.getSecondLevelCode()+"-"+user.getDepart().getCode()+"-"+idCode;     //一级编码+二级编码+部门+ID自增的6位数
				bean.setFProCode(proCode);
				if(bean.getFProOrBasic()==2){
					proCode="ZXM"+StringUtil.Random("");
					bean.setFProCode(proCode);
				}
				
				//更新常规信息
				bean = (TProBasicInfo) super.saveOrUpdate(bean);
			}else {//修改
				//修改人、修改时间
				bean.setUpdator(user.getName());
				bean.setUpdateTime(date);
				
				bean.setFProAppliTime(date);
				bean.setFProAppliPeopleId(user.getId());
				bean.setFProAppliPeople(user.getName());
				bean.setFProAppliDepartId(user.getDpID());
				bean.setFProAppliDepart(user.getDepartName());
				
				//保存修改后的信息
				super.updateDefault(bean);
			}
			//置顶操作
			//setTopOne(bean);
			
			//送审
			if ("11".equals(bean.getFFlowStauts())) {
				//设置业务范围
				String ywfw = null;
				if(bean.getFProOrBasic()==0){
					ywfw = "JBZCSB";
				}else if(bean.getFProOrBasic()==1){
					ywfw = "XMSB";
				}else if(bean.getFProOrBasic()==2){
					ywfw = "ZXMSB";
				}
				//得到第一个审批节点key
				Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), ywfw, user);
				//根据资源名称和当前登陆者所属部门查询对应工作流
				TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode(ywfw, user.getDpID());
				Integer flowId=processDefin.getFPId();
				TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
				User nextUser=userMng.findById(node.getUserId());
				//设置下节点处理人
				bean.setNextAssignerName(nextUser.getName());
				bean.setNextAssignerCode(nextUser.getId());
				bean.setFExt11(firstKey+"");//设置下节点编码
				//把历史审批记录全部设置为1，表示重新审批
				tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
				
				//设置收报状态
				if(nextUser != null && nextUser.getRoleName().contains("预算管理岗")){
					bean.setFExportStauts(2);//已经到达预算管理岗 审批了，他就可以开始进行报表收报
				}else {
					bean.setFExportStauts(0);
				}
				
				//更新常规信息
				super.updateDefault(bean);
				
				//添加审批人个人首页代办信息
				PersonalWork work = new PersonalWork();
				work.setUserId(bean.getNextAssignerCode());//任务处理人ID既是下节点处理人ID
				work.setTaskId(bean.getFProId());//项目ID
				work.setTaskCode(bean.getFProCode());//项目编号
				String appTaskType ="";//传给app用来区分任务类型
				if(bean.getFProOrBasic()==0){
					work.setTaskName("[基本支出申报]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
					appTaskType ="jbzcsb";
				}else if(bean.getFProOrBasic()==2) {
					work.setTaskName("[子项目申报]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
					appTaskType ="zxmsb";
				}else {
					work.setTaskName("[项目申报]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
					appTaskType ="xmsb";
				}
				work.setUrl("/project/verdict/"+bean.getFProId());//审批地址
				work.setUrl1("/project/detail/"+bean.getFProId());//查看地址（审批完成时使用）
				work.setTaskStauts("0");//待办
				work.setBeforeUser(user.getName());//任务提交人姓名
				work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
				work.setBeforeTime(date);//任务提交时间
				work.setType("1");//任务类型（1审批）
				work.setTaskType("1");//任务归属（1审批人）
				personalWorkMng.merge(work);

				//添加申请人的个人首页已办信息
				PersonalWork work2 = new PersonalWork();
				work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
				work2.setTaskId(bean.getFProId());//项目ID
				work2.setTaskCode(bean.getFProCode());//项目编号
				if(bean.getFProOrBasic()==0){
					work2.setTaskName("[基本支出申报]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				}else if(bean.getFProOrBasic()==2) {
					work2.setTaskName("[子项目申报]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				}else {
					work2.setTaskName("[项目申报]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				}
				work2.setUrl("/project/edit/"+bean.getFProId());//退回修改地址（被退回时使用）
				work2.setUrl1("/project/detail/"+bean.getFProId());//查看地址
				work2.setUrl2("/project/delete/"+bean.getFProId());//删除地址（被退回时使用）
				work2.setTaskStauts("2");//已办
				work2.setBeforeUser(user.getName());//任务提交人姓名
				work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
				work2.setBeforeTime(date);//任务提交时间
				work2.setFinishTime(bean.getCreateTime());
				work2.setType("2");//任务类型（1查看）
				work2.setTaskType("0");//任务归属（0发起人）
				personalWorkMng.merge(work2);
				//推送通知到app
				/*if(JpushClientUtil.sendToRegistrationId(nextUser.getAccountNo(),null,"您有一条待审批任务",work.getTaskName()+"\b"+"任务编号："+bean.getFProCode(),bean.getFProId().toString(), "0",appTaskType)==1){
			        System.out.println("推送给指定Android用户success");
			    }*/
			}
			//删除数据库中申请中的基本支出明细
			getSession().createSQLQuery("delete from T_PRO_EXPEND_DETAIL where F_PRO_ID ="+bean.getFProId()+"").executeUpdate();
			if(!StringUtil.isEmpty(outcomeJson)){
				//获取基本支出明细的Json对象
				List<TProExpendDetail> proExpendDetail = JSON.parseObject("["+outcomeJson+"]",new TypeReference<List<TProExpendDetail>>(){});
				for (TProExpendDetail infos : proExpendDetail) {
					TProExpendDetail info = new TProExpendDetail();
					info.setFProId(bean.getFProId());
					info.setActivity(infos.getActivity());
					info.setFunSubName(infos.getFunSubName());
					info.setFunSubCode(infos.getFunSubCode());
					info.setSubName(infos.getSubName());
					info.setSubCode(infos.getSubCode());
					info.setCapitalSourceName(infos.getCapitalSourceName());
					info.setCapitalSourceCode(infos.getCapitalSourceCode());
					info.setOutAmount(infos.getOutAmount());
					info.setActDesc(infos.getActDesc());
					super.merge(info);
				}
			}
			//删除数据库中申请中的政府采购明细
			getSession().createSQLQuery("delete from T_GOVERNMENT_PURCHASE_DETAIL where F_PRO_ID ="+bean.getFProId()+"").executeUpdate();
			if(!StringUtil.isEmpty(purchaseJson)){
				//获取政府采购明细的Json对象
				List<TGovernmentPurchaseDetail> governmentPurchaseDetail = JSON.parseObject("["+purchaseJson+"]",new TypeReference<List<TGovernmentPurchaseDetail>>(){});
				for (TGovernmentPurchaseDetail infos : governmentPurchaseDetail) {
					TGovernmentPurchaseDetail info = new TGovernmentPurchaseDetail();
					info.setfProId(bean.getFProId());
					info.setfItemsDetail(infos.getfItemsDetail());
					info.setfItemsCodeName(infos.getfItemsCodeName());
					info.setfItemsCode(infos.getfItemsCode());
					info.setfItemsName(infos.getfItemsName());
					info.setSubName(infos.getSubName());
					info.setSubCode(infos.getSubCode());
					info.setfIfThreeAssets(infos.getfIfThreeAssets());
					info.setfProcurementNum(infos.getfProcurementNum());
					info.setfMeasurement(infos.getfMeasurement());
					info.setfUnitPrice(infos.getfUnitPrice());
					info.setfAmount(infos.getfAmount());
					info.setfPlanDate(infos.getfPlanDate());
					info.setfRefiningExplain(infos.getfRefiningExplain());
					info.setfAllocationStandard(infos.getfAllocationStandard());
					info.setfIfSoftware("0");
					super.merge(info);
				}
			}
			//删除数据库中申请中的政府采购明细中的一采多年明细
			getSession().createSQLQuery("delete from T_PURCHASE_MANY_YEARS_PRO where F_PRO_ID ="+bean.getFProId()+" and F_IF_SOFTWARE='0'").executeUpdate();
			if(!StringUtil.isEmpty(purManyYearsProJson)){
				//获取政府采购明细中的一采多年明细的Json对象
				List<TPurchaseManyYearsPro> TPurchaseManyYearsProList = JSON.parseObject("["+purManyYearsProJson+"]",new TypeReference<List<TPurchaseManyYearsPro>>(){});
				for (TPurchaseManyYearsPro infos : TPurchaseManyYearsProList) {
					TPurchaseManyYearsPro info = new TPurchaseManyYearsPro();
					info.setfProId(bean.getFProId());
					info.setPurYear(infos.getPurYear());
					info.setYearAmount(infos.getYearAmount());
					info.setfExplain(infos.getfExplain());
					info.setfIfSoftware("0");
					super.merge(info);
				}
			}
	}
	
	
	@Override
	public void saveProject1(TProBasicInfo bean, User user, String saveType, String outcomeJson,String purchaseJson,String purchaseJsonSE,
			String fundsJson, String lxyjFiles, String ssfaFiles,String totalityPerformanceJson,String purManyYearsProJson,String purManyYearsProJsonSE) throws Exception{
		//设置所属库
		if(bean.getFProOrBasic()==2){
			bean.setZxmImportStatus("0");
			bean.setFProLibType("5");
		}else{
			bean.setFProLibType("1");
		}
		//设置日期
		Date date = new Date();
		//设置常规信息
		if (bean.getFProId()==null) {//新增
			//创建人、 创建时间、申请人、申请部门
			bean.setCreator(user.getName());
			bean.setCreateTime(date);
			bean.setFProAppliTime(date);
			bean.setFProAppliPeopleId(user.getId());
			bean.setFProAppliPeople(user.getName());
			bean.setFProAppliDepartId(user.getDpID());
			bean.setFProAppliDepart(user.getDepartName());
			
			//保存常规信息--获取项目id
			bean = (TProBasicInfo) super.saveOrUpdate(bean);
			
			//项目编码
			
			String proCode=StringUtil.autoGenericCode(String.valueOf(bean.getFProId()), 6);
			//String proCode=bean.getFirstLevelCode()+"-"+bean.getSecondLevelCode()+"-"+user.getDepart().getCode()+"-"+idCode;     //一级编码+二级编码+部门+ID自增的6位数
			bean.setFProCode(proCode);
			if(bean.getFProOrBasic()==2){
				proCode="ZXM"+StringUtil.Random("");
				bean.setFProCode(proCode);
			}
			
			//更新常规信息
			bean = (TProBasicInfo) super.saveOrUpdate(bean);
		}else {//修改
			//修改人、修改时间
			bean.setUpdator(user.getName());
			bean.setUpdateTime(date);
			
			bean.setFProAppliTime(date);
			bean.setFProAppliPeopleId(user.getId());
			bean.setFProAppliPeople(user.getName());
			bean.setFProAppliDepartId(user.getDpID());
			bean.setFProAppliDepart(user.getDepartName());
			
			//保存修改后的信息
			super.updateDefault(bean);
		}
		//置顶操作
		//setTopOne(bean);
		
		//送审
		if ("11".equals(bean.getFFlowStauts())) {
			//设置业务范围
			String ywfw = null;
			if(bean.getFProOrBasic()==0){
				ywfw = "JBZCSB";
			}else if(bean.getFProOrBasic()==1){
				ywfw = "XMSB";
			}else if(bean.getFProOrBasic()==2){
				ywfw = "ZXMSB";
			}
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), ywfw, user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode(ywfw, user.getDpID());
			Integer flowId=processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			User nextUser=userMng.findById(node.getUserId());
			//设置下节点处理人
			bean.setNextAssignerName(nextUser.getName());
			bean.setNextAssignerCode(nextUser.getId());
			bean.setFExt11(firstKey+"");//设置下节点编码
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			
			//设置收报状态
			if(nextUser != null && nextUser.getRoleName().contains("预算管理岗")){
				bean.setFExportStauts(2);//已经到达预算管理岗 审批了，他就可以开始进行报表收报
			}else {
				bean.setFExportStauts(0);
			}
			
			//更新常规信息
			super.updateDefault(bean);
			
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(bean.getNextAssignerCode());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getFProId());//项目ID
			work.setTaskCode(bean.getFProCode());//项目编号
			String appTaskType ="";//传给app用来区分任务类型
			if(bean.getFProOrBasic()==0){
				work.setTaskName("[基本支出申报]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				appTaskType ="jbzcsb";
			}else if(bean.getFProOrBasic()==2) {
				work.setTaskName("[子项目申报]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				appTaskType ="zxmsb";
			}else {
				work.setTaskName("[项目申报]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				appTaskType ="xmsb";
			}
			work.setUrl("/project/verdict/"+bean.getFProId());//审批地址
			work.setUrl1("/project/detail/"+bean.getFProId());//查看地址（审批完成时使用）
			work.setTaskStauts("0");//待办
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(date);//任务提交时间
			work.setType("1");//任务类型（1审批）
			work.setTaskType("1");//任务归属（1审批人）
			personalWorkMng.merge(work);
			
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(bean.getFProId());//项目ID
			work2.setTaskCode(bean.getFProCode());//项目编号
			if(bean.getFProOrBasic()==0){
				work2.setTaskName("[基本支出申报]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			}else if(bean.getFProOrBasic()==2) {
				work2.setTaskName("[子项目申报]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			}else {
				work2.setTaskName("[项目申报]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			}
			work2.setUrl("/project/edit/"+bean.getFProId());//退回修改地址（被退回时使用）
			work2.setUrl1("/project/detail/"+bean.getFProId());//查看地址
			work2.setUrl2("/project/delete/"+bean.getFProId());//删除地址（被退回时使用）
			work2.setTaskStauts("2");//已办
			work2.setBeforeUser(user.getName());//任务提交人姓名
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work2.setBeforeTime(date);//任务提交时间
			work2.setFinishTime(bean.getCreateTime());
			work2.setType("2");//任务类型（1查看）
			work2.setTaskType("0");//任务归属（0发起人）
			personalWorkMng.merge(work2);
			//推送通知到app
			/*if(JpushClientUtil.sendToRegistrationId(nextUser.getAccountNo(),null,"您有一条待审批任务",work.getTaskName()+"\b"+"任务编号："+bean.getFProCode(),bean.getFProId().toString(), "0",appTaskType)==1){
			        System.out.println("推送给指定Android用户success");
			    }*/
		}

		//保存附件信息
		attachmentMng.joinEntity(bean, lxyjFiles);
		attachmentMng.joinEntity(bean, ssfaFiles);
		
		//删除数据库中申请中的基本支出明细
		getSession().createSQLQuery("delete from T_PRO_EXPEND_DETAIL where F_PRO_ID ="+bean.getFProId()+"").executeUpdate();
		if(!StringUtil.isEmpty(outcomeJson)){
			//获取基本支出明细的Json对象
			List<TProExpendDetail> proExpendDetail = JSON.parseObject("["+outcomeJson+"]",new TypeReference<List<TProExpendDetail>>(){});
			for (TProExpendDetail infos : proExpendDetail) {
				TProExpendDetail info = new TProExpendDetail();
				info.setFProId(bean.getFProId());
				info.setActivity(infos.getActivity());
				info.setFunSubName(infos.getFunSubName());
				info.setFunSubCode(infos.getFunSubCode());
				info.setSubName(infos.getSubName());
				info.setSubCode(infos.getSubCode());
				info.setCapitalSourceName(infos.getCapitalSourceName());
				info.setCapitalSourceCode(infos.getCapitalSourceCode());
				info.setOutAmount(infos.getOutAmount());
				info.setActDesc(infos.getActDesc());
				super.merge(info);
			}
		}
		//删除数据库中申请中的政府采购明细
		getSession().createSQLQuery("delete from T_GOVERNMENT_PURCHASE_DETAIL where F_PRO_ID ="+bean.getFProId()+" and F_IF_SOFTWARE='0'").executeUpdate();
		if(!StringUtil.isEmpty(purchaseJson)){
			//获取政府采购明细的Json对象
			List<TGovernmentPurchaseDetail> governmentPurchaseDetail = JSON.parseObject("["+purchaseJson+"]",new TypeReference<List<TGovernmentPurchaseDetail>>(){});
			for (TGovernmentPurchaseDetail infos : governmentPurchaseDetail) {
				TGovernmentPurchaseDetail info = new TGovernmentPurchaseDetail();
				info.setfProId(bean.getFProId());
				info.setfItemsDetail(infos.getfItemsDetail());
				info.setfItemsCodeName(infos.getfItemsCodeName());
				info.setfItemsCode(infos.getfItemsCode());
				info.setfItemsName(infos.getfItemsName());
				info.setSubName(infos.getSubName());
				info.setSubCode(infos.getSubCode());
				info.setfIfThreeAssets(infos.getfIfThreeAssets());
				info.setfProcurementNum(infos.getfProcurementNum());
				info.setfMeasurement(infos.getfMeasurement());
				info.setfUnitPrice(infos.getfUnitPrice());
				info.setfAmount(infos.getfAmount());
				info.setfPlanDate(infos.getfPlanDate());
				info.setfRefiningExplain(infos.getfRefiningExplain());
				info.setfAllocationStandard(infos.getfAllocationStandard());
				info.setfIfSoftware("0");
				super.merge(info);
			}
		}
		//删除数据库中申请中的政府采购软件明细
		getSession().createSQLQuery("delete from T_GOVERNMENT_PURCHASE_DETAIL where F_PRO_ID ="+bean.getFProId()+" and F_IF_SOFTWARE='1'").executeUpdate();
		if(!StringUtil.isEmpty(purchaseJsonSE)){
			//获取政府采购软件明细的Json对象
			List<TGovernmentPurchaseDetail> governmentPurchaseDetail = JSON.parseObject("["+purchaseJsonSE+"]",new TypeReference<List<TGovernmentPurchaseDetail>>(){});
			for (TGovernmentPurchaseDetail infos : governmentPurchaseDetail) {
				TGovernmentPurchaseDetail info = new TGovernmentPurchaseDetail();
				info.setfProId(bean.getFProId());
				info.setfItemsDetail(infos.getfItemsDetail());
				info.setfItemsCodeName(infos.getfItemsCodeName());
				info.setfItemsCode(infos.getfItemsCode());
				info.setfItemsName(infos.getfItemsName());
				info.setSubName(infos.getSubName());
				info.setSubCode(infos.getSubCode());
				info.setfIfThreeAssets(infos.getfIfThreeAssets());
				info.setfProcurementNum(infos.getfProcurementNum());
				info.setfMeasurement(infos.getfMeasurement());
				info.setfUnitPrice(infos.getfUnitPrice());
				info.setfAmount(infos.getfAmount());
				info.setfPlanDate(infos.getfPlanDate());
				info.setfRefiningExplain(infos.getfRefiningExplain());
				info.setfAllocationStandard(infos.getfAllocationStandard());
				info.setfIfSoftware("1");
				super.merge(info);
			}
		}
		
		//删除数据库中申请中的绩效明细
		getSession().createSQLQuery("delete from T_PERFORMANCE_INDICATOR where F_PRO_ID ="+bean.getFProId()).executeUpdate();
		if(!StringUtil.isEmpty(totalityPerformanceJson)){
			//获取绩效明细的Json对象
			List<PerformanceIndicatorModel> performanceIndicatorModelList = JSON.parseObject("["+totalityPerformanceJson+"]",new TypeReference<List<PerformanceIndicatorModel>>(){});
			for (PerformanceIndicatorModel infos : performanceIndicatorModelList) {
				PerformanceIndicatorModel info = new PerformanceIndicatorModel();
				info.setfProId(bean.getFProId());
				info.settOneCode(infos.gettOneCode());
				info.settOneName(infos.gettOneName());
				info.settTwoCode(infos.gettTwoCode());
				info.settTwoName(infos.gettTwoName());
				info.setIndexContent(infos.getIndexContent());
				info.settIndexVal(infos.gettIndexVal());
				super.merge(info);
			}
		}
		//删除数据库中申请中的政府采购明细中的一采多年明细
		getSession().createSQLQuery("delete from T_PURCHASE_MANY_YEARS_PRO where F_PRO_ID ="+bean.getFProId()+" and F_IF_SOFTWARE='0'").executeUpdate();
		if(!StringUtil.isEmpty(purManyYearsProJson)){
			//获取政府采购明细中的一采多年明细的Json对象
			List<TPurchaseManyYearsPro> TPurchaseManyYearsProList = JSON.parseObject("["+purManyYearsProJson+"]",new TypeReference<List<TPurchaseManyYearsPro>>(){});
			for (TPurchaseManyYearsPro infos : TPurchaseManyYearsProList) {
				TPurchaseManyYearsPro info = new TPurchaseManyYearsPro();
				info.setfProId(bean.getFProId());
				info.setPurYear(infos.getPurYear());
				info.setYearAmount(infos.getYearAmount());
				info.setfExplain(infos.getfExplain());
				info.setfIfSoftware("0");
				super.merge(info);
			}
		}
		//删除数据库中申请中的政府软件采购明细中的一采多年明细
		getSession().createSQLQuery("delete from T_PURCHASE_MANY_YEARS_PRO where F_PRO_ID ="+bean.getFProId()+" and F_IF_SOFTWARE='1'").executeUpdate();
		if(!StringUtil.isEmpty(purManyYearsProJsonSE)){
			//获取政府软件采购明细中的一采多年明细的Json对象
			List<TPurchaseManyYearsPro> TPurchaseManyYearsProList = JSON.parseObject("["+purManyYearsProJsonSE+"]",new TypeReference<List<TPurchaseManyYearsPro>>(){});
			for (TPurchaseManyYearsPro infos : TPurchaseManyYearsProList) {
				TPurchaseManyYearsPro info = new TPurchaseManyYearsPro();
				info.setfProId(bean.getFProId());
				info.setPurYear(infos.getPurYear());
				info.setYearAmount(infos.getYearAmount());
				info.setfExplain(infos.getfExplain());
				info.setfIfSoftware("1");
				super.merge(info);
			}
		}
	}
	
	private void setTopOne(TProBasicInfo bean) {
		//如果该项目置顶，则将其他置顶项目的序号变为99
		if (bean != null && "1".equals(bean.getFExt2())) {
			Finder f = Finder.create(" from TProBasicInfo where FExt2='1' ");
			List<TProBasicInfo> list = super.find(f);
			if (list != null && list.size() > 0) {
				for (TProBasicInfo pro: list) {
					pro.setFExt2("99");
					super.saveOrUpdate(pro);
				}
			}
		}
	}
	
	@Override
	public Pagination pageList(TProBasicInfo bean, User user, boolean isOffice, int pageNo, int pageSize) {
 		Finder finder = Finder.create(" from TProBasicInfo t1 where (FExt1 IS NULL OR FExt1!='0') and (F_STAUTS IS NULL OR F_STAUTS!='99')");
		/*//权限控制
		if (!isOffice) {
			//非单位用户：只能查看申报部门为本部门的
			finder.append(" and FProAppliDepart=:departName ").setParam("departName", user.getDepartName());
		}*/
		//查询条件
 		if(!StringUtil.isEmpty(bean.getPlanStartYear())) {//预算年度
 			finder.append(" and t1.planStartYear like :planStartYear").setParam("planStartYear", "%" + bean.getPlanStartYear() + "%");
 		}
		if(!StringUtil.isEmpty(bean.getFProCode())) {//项目编码
			finder.append(" and t1.FProCode like :fProCode").setParam("fProCode", "%" + bean.getFProCode() + "%");
		}
		if(!StringUtil.isEmpty(bean.getFProName())) {//名称
			finder.append(" and t1.FProName like :name").setParam("name", "%" + bean.getFProName() + "%");
		}
		/*if(!StringUtil.isEmpty(bean.getFProClass())) {// 项目类别
			finder.append(" and t1.FProClass like :FProClass").setParam("FProClass", "%" + bean.getFProClass() + "%");
		}*/
		if(!StringUtils.isEmpty(bean.getFProLibType())){//库别
			finder.append(" and t1.FProLibType = :FProLibType").setParam("FProLibType", bean.getFProLibType());
		}
		if(bean.getFProAppliTime1()!=null) {
			finder.append(" AND DATE_FORMAT(t1.FProAppliTime,'%Y-%m-%d') >= '"+bean.getFProAppliTime1()+"'");//申报开始时间
		}
		if(bean.getFProAppliTime2()!=null) {
			finder.append(" AND DATE_FORMAT(t1.FProAppliTime,'%Y-%m-%d') <= '"+bean.getFProAppliTime2()+"'");//申报结束时间
		}
		if(!StringUtil.isEmpty(String.valueOf(bean.getEfficiency1()))) {
			finder.append(" AND EXISTS (SELECT t2.indexCode FROM TBudgetIndexMgr t2 where t1.FProCode=t2.indexCode AND (1 - ((t2.syAmount+t2.djAmount) / t2.pfAmount))>='"+bean.getEfficiency1()+"')");
		}
		if(!StringUtil.isEmpty(String.valueOf(bean.getEfficiency2()))) {
			finder.append(" AND EXISTS (SELECT t2.indexCode FROM TBudgetIndexMgr t2 where t1.FProCode=t2.indexCode AND (1 - ((t2.syAmount+t2.djAmount) / t2.pfAmount))<='"+bean.getEfficiency2()+"')");
		}
		if(!StringUtil.isEmpty(bean.getFirstLevelCode())) {//一级分类
			finder.append(" and t1.firstLevelCode=:firstLevelCode").setParam("firstLevelCode", bean.getFirstLevelCode());
		}
		if(!StringUtil.isEmpty(bean.getSecondLevelCode())) {//二级分类
			finder.append(" and t1.secondLevelCode=:secondLevelCode").setParam("secondLevelCode", bean.getSecondLevelCode());
		}
		if(!StringUtil.isEmpty(bean.getFProAppliDepart())) {//申报部门
			finder.append(" and t1.FProAppliDepart like :FProAppliDepart").setParam("FProAppliDepart", "%" + bean.getFProAppliDepart() + "%");
		}
		if(!StringUtil.isEmpty(bean.getFProAppliPeople())) {//申报部门
			finder.append(" and t1.FProAppliPeople like :FProAppliPeople").setParam("FProAppliPeople", "%" +bean.getFProAppliPeople() + "%");
		}
		//审批状态
		if(!StringUtil.isEmpty(bean.getFFlowStauts())) {
			if("11".equals(bean.getFFlowStauts())) {
				finder.append(" and t1.FFlowStauts in('11', '12')");
			}
		}
		//预算支出类型     区分基本支出或项目支出：0-基本支出，1-项目支出
		if(!StringUtil.isEmpty(String.valueOf(bean.getFProOrBasic()))) {
			finder.append(" and t1.FProOrBasic = :FProOrBasic").setParam("FProOrBasic", bean.getFProOrBasic());
		}
		//收报状态
		if(bean.getFExportStauts()!=null || !StringUtil.isEmpty(String.valueOf(bean.getFExportStauts()))) {//审批状态
			if("1".equals(String.valueOf(bean.getFExportStauts()))){
				finder.append(" and t1.FExportStauts = 1");
			}else if("0".equals(String.valueOf(bean.getFExportStauts()))){
				finder.append(" and t1.FExportStauts in('0', '2')");
			}
		}
		if(!StringUtil.isEmpty(bean.getSbkLx())) {//申报库类型
			if ("xmsb".equals(bean.getSbkLx())||"zxmsb".equals(bean.getSbkLx())) {
				if(user.getRoleName().contains("部门负责人")&&user.getDpID().equals("34")){
					//综合改革办公室部门负责人
					finder.append(" and (t1.FProAppliPeopleId= '"+user.getId()+"' or t1.zxmId is not null ) ");
				}else{
					
					//项目申报-	 申报人是自己的
					finder.append(" and t1.FProAppliPeopleId=:applyUser").setParam("applyUser", user.getId());
				}

			}else if ("xmsp".equals(bean.getSbkLx())) {
				//项目审批-	显示审批状态为1、2的数据 +  审核人或者申报人是自己的 
				finder.append(" and  t1.nextAssignerCode=:userId")
				.setParam("userId", user.getId());
				finder.append(" and t1.FProOrBasic !=2");
				/*finder.append(" and (t1.FFlowStauts = '11' or t1.FFlowStauts='19' or t1.FFlowStauts='12') and t1.nextAssignerCode=:userId ")
					.setParam("userId", user.getId());*/
			}else if("xmtz".equals(bean.getSbkLx())) {
				//项目台账-
				finder.append(" and t1.FFlowStauts not in('0','-11','-14')");
			}else if("zxmtz".equals(bean.getSbkLx())) {
				//子项目台账-
				finder.append(" and t1.FFlowStauts ='19' and t1.FProOrBasic='2' ");
			}else if("ysshoub".equals(bean.getSbkLx())) {
				//预算收报-
				finder.append(" and t1.FFlowStauts not in('0','-11','-14')");
			}else if("myzxk".equals(bean.getSbkLx())) {
				//我的执行库，申报人是自己的 
				finder.append(" and t1.FProAppliPeopleId = :FProAppliPeopleId").setParam("FProAppliPeopleId", user.getId());
				//finder.append(" and t1.FProAppliPeopleId = 'a5a88d66-b2cb-11eb-a316-10e7c6129797'");
			}else if("xmfh".equals(bean.getSbkLx())) {
				//项目复核-	显示所有审核通过的数据
				finder.append(" and t1.FFlowStauts = 3");
			}else if("bmxmjx".equals(bean.getSbkLx())) {
				//部门项目结项-	显示本部门的 + 执行库的 + 未结项的
				finder.append(" and t1.FProAppliDepart=:departName").setParam("departName", user.getDepartName());
				finder.append(" and t1.FProLibType = 3");
			}else if("dwxmjx".equals(bean.getSbkLx())) {
				//单位项目结项- 执行库或结转的 +  未结项的
				finder.append(" and t1.FProLibType = 3");
			}
		}
		/*//查询该某审核人的所有审核任务
		if (!StringUtil.isEmpty(bean.getNextAssignerId())) {
			finder.append(" and nextAssignerId =:nextAssignerId").setParam("nextAssignerId", bean.getNextAssignerId());
		}*/
		if("zxmtz".equals(bean.getSbkLx())){
			
		}else{
			if (!"xmsp".equals(bean.getSbkLx())){
				if(user.getRoleName().contains("预算主办会计")||user.getRoleName().contains("党委书记")||user.getRoleName().contains("校长")||user.getRoleName().contains("总会计师")||user.getRoleName().contains("财务处部门负责人")){
					if(!StringUtil.isEmpty(bean.getFProAppliPeople())){
						finder.append(" and t1.FProAppliPeople=:FProAppliPeople").setParam("FProAppliPeople", bean.getFProAppliPeople());
					}
					//预算管理查看岗可以查看所有部门的台账
				}else {
					String deptIdStr=departMng.getDeptIdStrByUser(user);
					if("".equals(deptIdStr)){ //普通岗位只能查看自己的
						finder.append(" and t1.FProAppliPeopleId = :FProAppliPeopleId").setParam("FProAppliPeopleId", user.getId());
					}else if("all".equals(deptIdStr)){//校长可以查看所有人的
						
					}else{//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
						if(user.getRoleName().contains("部门负责人")&&user.getDpID().equals("34")){
							
						}else{
							finder.append(" and t1.FProAppliDepartId in ("+deptIdStr+")");
						}
					}
				}
			}
		}
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}
	
	
	@Override
	public List<TProBasicInfo> pageLists(TProBasicInfo bean, User user, boolean isOffice) {
 		Finder finder = Finder.create(" from TProBasicInfo t1 where (FExt1 IS NULL OR FExt1!='0') and (F_STAUTS IS NULL OR F_STAUTS!='99')");
		/*//权限控制
		if (!isOffice) {
			//非单位用户：只能查看申报部门为本部门的
			finder.append(" and FProAppliDepart=:departName ").setParam("departName", user.getDepartName());
		}*/
		//查询条件
 		if(!StringUtil.isEmpty(bean.getPlanStartYear())) {//预算年度
 			finder.append(" and t1.planStartYear like :planStartYear").setParam("planStartYear", "%" + bean.getPlanStartYear() + "%");
 		}
		if(!StringUtil.isEmpty(bean.getFProCode())) {//项目编码
			finder.append(" and t1.FProCode like :fProCode").setParam("fProCode", "%" + bean.getFProCode() + "%");
		}
		if(!StringUtil.isEmpty(bean.getFProName())) {//名称
			finder.append(" and t1.FProName like :name").setParam("name", "%" + bean.getFProName() + "%");
		}
		/*if(!StringUtil.isEmpty(bean.getFProClass())) {// 项目类别
			finder.append(" and t1.FProClass like :FProClass").setParam("FProClass", "%" + bean.getFProClass() + "%");
		}*/
		if(!StringUtils.isEmpty(bean.getFProLibType())){//库别
			finder.append(" and t1.FProLibType = :FProLibType").setParam("FProLibType", bean.getFProLibType());
		}
		if(bean.getFProAppliTime1()!=null) {
			finder.append(" AND DATE_FORMAT(t1.FProAppliTime,'%Y-%m-%d') >= '"+bean.getFProAppliTime1()+"'");//申报开始时间
		}
		if(bean.getFProAppliTime2()!=null) {
			finder.append(" AND DATE_FORMAT(t1.FProAppliTime,'%Y-%m-%d') <= '"+bean.getFProAppliTime2()+"'");//申报结束时间
		}
		if(!StringUtil.isEmpty(String.valueOf(bean.getEfficiency1()))) {
			finder.append(" AND EXISTS (SELECT t2.indexCode FROM TBudgetIndexMgr t2 where t1.FProCode=t2.indexCode AND (1 - ((t2.syAmount+t2.djAmount) / t2.pfAmount))>='"+bean.getEfficiency1()+"')");
		}
		if(!StringUtil.isEmpty(String.valueOf(bean.getEfficiency2()))) {
			finder.append(" AND EXISTS (SELECT t2.indexCode FROM TBudgetIndexMgr t2 where t1.FProCode=t2.indexCode AND (1 - ((t2.syAmount+t2.djAmount) / t2.pfAmount))<='"+bean.getEfficiency2()+"')");
		}
		if(!StringUtil.isEmpty(bean.getFirstLevelCode())) {//一级分类
			finder.append(" and t1.firstLevelCode=:firstLevelCode").setParam("firstLevelCode", bean.getFirstLevelCode());
		}
		if(!StringUtil.isEmpty(bean.getSecondLevelCode())) {//二级分类
			finder.append(" and t1.secondLevelCode=:secondLevelCode").setParam("secondLevelCode", bean.getSecondLevelCode());
		}
		if(!StringUtil.isEmpty(bean.getFProAppliDepart())) {//申报部门
			finder.append(" and t1.FProAppliDepart like :FProAppliDepart").setParam("FProAppliDepart", "%" + bean.getFProAppliDepart() + "%");
		}
		if(!StringUtil.isEmpty(bean.getFProAppliPeople())) {//申报部门
			finder.append(" and t1.FProAppliPeople like :FProAppliPeople").setParam("FProAppliPeople", "%" +bean.getFProAppliPeople() + "%");
		}
		//审批状态
		if(!StringUtil.isEmpty(bean.getFFlowStauts())) {
			if("11".equals(bean.getFFlowStauts())) {
				finder.append(" and t1.FFlowStauts in('11', '12')");
			}
		}
		//预算支出类型     区分基本支出或项目支出：0-基本支出，1-项目支出
		if(!StringUtil.isEmpty(String.valueOf(bean.getFProOrBasic()))) {
			finder.append(" and t1.FProOrBasic = :FProOrBasic").setParam("FProOrBasic", bean.getFProOrBasic());
		}
		//收报状态
		if(bean.getFExportStauts()!=null || !StringUtil.isEmpty(String.valueOf(bean.getFExportStauts()))) {//审批状态
			if("1".equals(String.valueOf(bean.getFExportStauts()))){
				finder.append(" and t1.FExportStauts = 1");
			}else if("0".equals(String.valueOf(bean.getFExportStauts()))){
				finder.append(" and t1.FExportStauts in('0', '2')");
			}
		}
		if(!StringUtil.isEmpty(bean.getSbkLx())) {//申报库类型
			if ("xmsb".equals(bean.getSbkLx())||"zxmsb".equals(bean.getSbkLx())) {
				if(user.getRoleName().contains("部门负责人")&&user.getDpID().equals("34")){
					//综合改革办公室部门负责人
					finder.append(" and (t1.FProAppliPeopleId= '"+user.getId()+"' or t1.zxmId is not null ) ");
				}else{
					
					//项目申报-	 申报人是自己的
					finder.append(" and t1.FProAppliPeopleId=:applyUser").setParam("applyUser", user.getId());
				}

			}else if ("xmsp".equals(bean.getSbkLx())) {
				//项目审批-	显示审批状态为1、2的数据 +  审核人或者申报人是自己的 
				finder.append(" and  t1.nextAssignerCode=:userId")
				.setParam("userId", user.getId());
				finder.append(" and t1.FProOrBasic !=2");
				/*finder.append(" and (t1.FFlowStauts = '11' or t1.FFlowStauts='19' or t1.FFlowStauts='12') and t1.nextAssignerCode=:userId ")
					.setParam("userId", user.getId());*/
			}else if("xmtz".equals(bean.getSbkLx())) {
				//项目台账-
				finder.append(" and t1.FFlowStauts not in('0','-11','-14')");
			}else if("zxmtz".equals(bean.getSbkLx())) {
				//子项目台账-
				finder.append(" and t1.FFlowStauts ='19' and t1.FProOrBasic='2' ");
			}else if("ysshoub".equals(bean.getSbkLx())) {
				//预算收报-
				finder.append(" and t1.FFlowStauts not in('0','-11','-14')");
			}else if("myzxk".equals(bean.getSbkLx())) {
				//我的执行库，申报人是自己的 
				finder.append(" and t1.FProAppliPeopleId = :FProAppliPeopleId").setParam("FProAppliPeopleId", user.getId());
			}else if("xmfh".equals(bean.getSbkLx())) {
				//项目复核-	显示所有审核通过的数据
				finder.append(" and t1.FFlowStauts = 3");
			}else if("bmxmjx".equals(bean.getSbkLx())) {
				//部门项目结项-	显示本部门的 + 执行库的 + 未结项的
				finder.append(" and t1.FProAppliDepart=:departName").setParam("departName", user.getDepartName());
				finder.append(" and t1.FProLibType = 3");
			}else if("dwxmjx".equals(bean.getSbkLx())) {
				//单位项目结项- 执行库或结转的 +  未结项的
				finder.append(" and t1.FProLibType = 3");
			}
		}
		/*//查询该某审核人的所有审核任务
		if (!StringUtil.isEmpty(bean.getNextAssignerId())) {
			finder.append(" and nextAssignerId =:nextAssignerId").setParam("nextAssignerId", bean.getNextAssignerId());
		}*/
		if("zxmtz".equals(bean.getSbkLx())){
			
		}else{
			if(user.getRoleName().contains("预算台账查看岗")){
				if(!StringUtil.isEmpty(bean.getFProAppliPeople())){
					finder.append(" and t1.FProAppliPeople=:FProAppliPeople").setParam("FProAppliPeople", bean.getFProAppliPeople());
				}
				//预算管理查看岗可以查看所有部门的台账
			}else {
				String deptIdStr=departMng.getDeptIdStrByUser(user);
				if("".equals(deptIdStr)){ //普通岗位只能查看自己的
					finder.append(" and t1.FProAppliPeopleId = :FProAppliPeopleId").setParam("FProAppliPeopleId", user.getId());
				}else if("all".equals(deptIdStr)){//校长可以查看所有人的
					
				}else{//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
					if(user.getRoleName().contains("部门负责人")&&user.getDpID().equals("34")){
						
					}else{
						finder.append(" and t1.FProAppliDepartId in ("+deptIdStr+")");
					}
				}
			}
		}
		finder.append(" order by updateTime desc");
		return super.find(finder);
	}
	@Override
	public List<Object[]> getOutComeSubject(String basicType, String parentCode, String year, String qName) {
		String sql = " select F_EC_ID,F_EC_NAME,F_EC_CODE,F_P_EC_ID "
				+ " from T_ECONOMIC_SUBJECT_LIB "
				+ " inner join T_YEARS_BASIC "
				+ " on T_ECONOMIC_SUBJECT_LIB.F_Y_B_ID = T_YEARS_BASIC.F_Y_B_ID "
				+ " where F_EC_TYPE='KMLX-01' ";
		
		if (!StringUtil.isEmpty(basicType)) {
			if ("personOut".equals(basicType)) {//人员基本支出
				sql = sql + " and (F_EC_CODE like '301%' or F_EC_CODE like '303%')  ";
			} else if ("commOut".equals(basicType)) {//公用基本支出
				sql = sql + " and F_EC_CODE like '302%' ";
			}else if ("project".equals(basicType)) {//项目支出
				sql = sql + " and F_EC_CODE in (302,310,301,303) ";
			}
		}
		if (!StringUtil.isEmpty(year)) {//年度
			sql = sql + " and T_YEARS_BASIC.F_PERIOD=" + year;
		}
		if (!StringUtil.isEmpty(parentCode)) {//父节点
			sql = sql + " and F_P_EC_CODE=" + parentCode;
		}
		if (!StringUtil.isEmpty(qName)) {//查询-节点名称
			sql = sql + " and F_EC_NAME like '%" + qName + "%'";
		}
		
		sql = sql + " order by F_EC_CODE asc ";
		
		SQLQuery query = getSession().createSQLQuery(sql);
		return query.list();
	}
	@Override
	public List<Object[]> getOutComeSubject(String year, String codes) {
		String sql = " select F_EC_ID,F_EC_NAME,F_EC_CODE,F_P_EC_ID "
				+ " from T_ECONOMIC_SUBJECT_LIB "
				+ " inner join T_YEARS_BASIC "
				+ " on T_ECONOMIC_SUBJECT_LIB.F_Y_B_ID = T_YEARS_BASIC.F_Y_B_ID "
				+ " where F_EC_LEVE in('KMJB-01','KMJB-02') ";
		
		if (!StringUtil.isEmpty(year)) {//年度
			sql = sql + " and T_YEARS_BASIC.F_PERIOD=" + year;
		}
		if (!StringUtil.isEmpty(codes)) {//编码\
			if("30209".endsWith(codes)){
				codes+=",30213,30227";
			}
			sql = sql + " and F_EC_CODE in ("+codes+")" ;
		}
		sql = sql + " order by F_EC_CODE asc ";
		
		SQLQuery query = getSession().createSQLQuery(sql);
		return query.list();
	}
	@Override
	public Map<String,Integer> getPidMap(String basicType, String parentCodes, String year, String qName) {
		Map<String,Integer> pidMap=new HashMap<String,Integer>();
		List<Integer> pidList=getPidListByparentCodes(basicType,parentCodes,year,qName);
		if(pidList!=null && pidList.size()>0){
			for(Integer pid:pidList){
				pidMap.put(pid+"", pid);
			}
		}
		return pidMap;
	}
	public List<Integer> getPidListByparentCodes(String basicType, String parentCodes, String year, String qName){
		String sql = " select F_P_EC_CODE  "
				+ " from T_ECONOMIC_SUBJECT_LIB "
				+ " inner join T_YEARS_BASIC "
				+ " on T_ECONOMIC_SUBJECT_LIB.F_Y_B_ID = T_YEARS_BASIC.F_Y_B_ID "
				+ " where F_EC_TYPE='KMLX-01' ";
		
		if (!StringUtil.isEmpty(basicType)) {
			if ("personOut".equals(basicType)) {//人员基本支出
				sql = sql + " and (F_EC_CODE like '301%' or F_EC_CODE like '303%')  ";
			} else if ("commOut".equals(basicType)) {//公用基本支出
				sql = sql + " and F_EC_CODE like '302%' ";
			}
		}
		if (!StringUtil.isEmpty(year)) {//年度
			sql = sql + " and T_YEARS_BASIC.F_PERIOD=" + year;
		}
		if (!StringUtil.isEmpty(parentCodes)) {//父节点
			sql = sql + " and F_P_EC_CODE in (" + parentCodes+")";
		}
		if (!StringUtil.isEmpty(qName)) {//查询-节点名称
			sql = sql + " and F_EC_NAME like '%" + qName + "%'";
		}
		
		sql = sql + " order by F_EC_CODE asc ";
		
		SQLQuery query = getSession().createSQLQuery(sql);
		return query.list();
	}
	
	@Override
	public String downFile(String type, String fileName, String savePath) {
		
		if (!StringUtil.isEmpty(type)) {
			if ("proAcco".equals(type)) {
				tProBasicAccoAttacMng.downloadAtta(fileName,savePath);
			} else if ("proPlan".equals(type)) {
//				tProBasicPlanAttacMng.downloadAtta(fileName,savePath);
			} else if ("proOutcome".equals(type)) {
				
			}
		}
		return "0";
	}
	@Override
	public Pagination fProCode(TProBasicInfo tProBasicInfo, int pageNo,int pageSize) {
		
		Finder finder = Finder.create(" from TProBasicInfo where 1=1 and FProLibType = '3' ");//执行库
		//查询条件
		if (!StringUtil.isEmpty(tProBasicInfo.getFProCode())) {//项目编码
			finder.append(" and FProCode like :fProCode").setParam("fProCode", "%" + tProBasicInfo.getFProCode() + "%");
		}
		if (!StringUtil.isEmpty(tProBasicInfo.getFProName())) {//名称
			finder.append(" and FProName like :name").setParam("name", "%" + tProBasicInfo.getFProName() + "%");
		}
		if (!StringUtil.isEmpty(tProBasicInfo.getFProAppliDepart())) {//申报部门
			finder.append(" and FProAppliDepart = :FProAppliDepart").setParam("FProAppliDepart", "%" + tProBasicInfo.getFProAppliDepart() + "%");
		}
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}
	
	@Override
	public void overPro(User user, String proId) {
		
		TProBasicInfo bean = findById(Integer.valueOf(proId));
		bean.setUpdator(user.getAccountNo());
		bean.setUpdateTime(new Date());
		//结转
		bean.setFProLibType("4");
		/*saveOrUpdate(bean);*/
	}
	
	@Override
	public List<TProBasicInfo> proInfoForControlNum(Date date, String libType) {
		
		Finder finder = Finder.create(" from TProBasicInfo where 1=1");
		if (date != null) {
			//年份
			Integer year=1+Integer.valueOf(new SimpleDateFormat("yyyy").format(date));
			finder.append(" and planStartYear= '"+year+"'");
		}
		if (!StringUtil.isEmpty(libType)) {
			finder.append(" and FProLibType =:libType ").setParam("libType", libType);
		}
		finder.append(" order by FExt2 asc,FProCode asc ");
		return super.find(finder);
	}

	@Override
	public TProBasicInfo findbyCode(String code) {
		Finder f=Finder.create(" from TProBasicInfo where FProCode='"+code+"'");
		List<TProBasicInfo> list= super.find(f);
		if(list==null || list.size()==0){
			return new TProBasicInfo();
		}
		return (TProBasicInfo) super.find(f).get(0);
	}

	
	
	
	
	
	
	
	
	
	
	/**
	 * 一上分页查询
	 * @param bean 实体对象，存放查询条件
	 * @param user 操作人
	 * @param isOffice 是否单位角色
	 * @param pageNo 当前页码
	 * @param pageSize 总页数
	 * @return
	 */
	@Override
	public Pagination yspageList(TProBasicInfo bean, User user, int pageNo, int pageSize,String sbkLx) {
		Finder finder = Finder.create(" from TProBasicInfo where (FExt1 IS NULL OR FExt1!='0') ");
		finder.append(" and FProLibType ='2' and FFlowStauts in('19','21','29') and FExt4 in('10','11')");
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}
	
	/**
	 * 一下查询
	 * @param bean 实体对象，存放查询条件
	 * @param user 操作人
	 * @param isOffice 是否单位角色
	 * @param pageNo 当前页码
	 * @param pageSize 总页数
	 * @return
	 */
	@Override
	public Pagination yxpageList(TProBasicInfo bean, User user, int pageNo, int pageSize, String sbkLx) {
		Finder finder = Finder.create(" from TProBasicInfo where (FExt1 IS NULL OR FExt1!='0') ");
		finder.append(" and FProLibType ='2' and FFlowStauts ='29' and FExt4='11'");
		return super.find(finder, pageNo, pageSize);
	}

	
	/*
	 * 叶崇晖
	 * 9/17
	 * 一上批量申报
	 */
	@Override
	public void yssb(String fproIdLi,String fproIdLi2) {
		String[] strarray2 = fproIdLi2.split(",");
		for (int i = 0; i < strarray2.length; i++) {
			//修改审批状态为21
			getSession().createSQLQuery("UPDATE t_pro_basic_info SET F_FLOW_STAUTS='21' WHERE F_PRO_ID='"+strarray2[i]+"'").executeUpdate();
		}
		
		
		String[] strarray=fproIdLi.split(","); 
		for (int i = 0; i < strarray.length; i++) {
			//修改申报状态为11
			getSession().createSQLQuery("UPDATE t_pro_basic_info SET F_EXT_4='11' WHERE F_PRO_ID='"+strarray[i]+"'").executeUpdate();
		}
	}

	@Override
	public void yssp(String fproIdLi) {
		String[] strarray=fproIdLi.split(","); 
		for (int i = 0; i < strarray.length; i++) {
			//修改审批状态为21
			getSession().createSQLQuery("UPDATE t_pro_basic_info SET F_FLOW_STAUTS='29' WHERE F_PRO_ID='"+strarray[i]+"'").executeUpdate();
		}
	}

	/*
	 * 叶崇晖
	 * 9/17
	 * 一下
	 */
	@Override
	public void yx(String fproIdLi, String commitAmountLi, String fext12Li) {
		String[] strarray1=fproIdLi.split(","); 
		String[] strarray2=commitAmountLi.split(","); 
		String[] strarray3=fext12Li.split(","); 
		for (int i = 0; i < strarray1.length; i++) {
			//保存一下控制数和备注
			getSession().createSQLQuery("UPDATE t_pro_basic_info SET F_CB_1='"+Double.valueOf(strarray2[i])+"',F_EXT_12='"+strarray3[i]+"' WHERE F_PRO_ID='"+strarray1[i]+"'").executeUpdate();
		}
	}



	@Override
	public Pagination proInfoForControlNumP(TProBasicInfo bean,Date date, String libType,Integer pageNo, Integer pageSize) {
		Finder finder = Finder.create(" from TProBasicInfo where 1=1");
		if (!StringUtil.isEmpty(bean.getFProCode()) ) {//项目编号
			finder.append(" and FProCode LIKE :FProCode");
			finder.setParam("FProCode", "%"+bean.getFProCode()+"%");
		}
		if (!StringUtil.isEmpty(bean.getFProName())) {//项目名称
			finder.append(" and FProName LIKE :FProName");
			finder.setParam("FProName", "%"+bean.getFProName()+"%");
		}
		if (!StringUtil.isEmpty(bean.getFProAppliDepart())) {//部门
			finder.append(" and FProAppliDepart LIKE :FProAppliDepart");
			finder.setParam("FProAppliDepart", "%"+bean.getFProAppliDepart()+"%");
		}
		finder.append(" order by FExt2 asc,FProCode asc ");
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public List<TProBasicInfo> getList() {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * 将前台传入的项目支出明细转换成list对象
	 * @author 叶崇晖
	 * @param file
	 * @return
	 */
	@Override
	public List<TProExpendDetail> outcomeCollect(File file) {
		List<TProExpendDetail> list = new ArrayList<TProExpendDetail>();
		PoiUtil pu = new PoiUtil();//excel数字行格式工具类
		
		if (file.exists()) {
			FileInputStream fis = null;
			Workbook workBook = null;//生成poi的execlWorkbook
			try {
				fis = new FileInputStream(file);
				workBook = WorkbookFactory.create(fis);
				Sheet sheet = workBook.getSheetAt(0);//只有一个sheet页
				int rowsOfSheet = sheet.getPhysicalNumberOfRows(); // 获取当前Sheet的总行数
				
				Map<Object,Object> nameCodeMap=economicMng.getCodeMap();
				int flag = 0;
				for (int r = 4; r < rowsOfSheet; r++) { // 总行
					TProExpendDetail detail = new TProExpendDetail();//创建项目支出明细对象
					Row row = sheet.getRow(r);//获得行
					if(flag>0){
						break;
					}
					if (row == null) {
						continue;
					} else {
						int numberOfCells = row.getPhysicalNumberOfCells();
						for (int c = 0; c < numberOfCells; c++) {
							Cell cell = row.getCell(c);//获得单元格
							if (c == 1) {
								//具体业务单元格
								String stringCellValue = pu.getCellValue(cell);
								if(StringUtils.isEmpty(stringCellValue)){
									flag +=1; 
									break;
								}
								detail.setActivity(stringCellValue);
							}
							else if (c == 2) {
								//功能分类科目
								String stringCellValue = pu.getCellValue(cell);
								detail.setFunSubName(stringCellValue);
							}
							else if (c == 3) {
								//功能分类科目编号
								String stringCellValue = pu.getCellValue(cell);
								detail.setFunSubCode(String.valueOf(Double.valueOf(stringCellValue).intValue()));
							}
							else if (c == 4) {
								//经济分类科目
								String stringCellValue = pu.getCellValue(cell);
								detail.setSubName(stringCellValue);
							}
							else if (c == 5) {
								//经济分类科目编号
								String stringCellValue = pu.getCellValue(cell);
								detail.setSubCode(String.valueOf(Double.valueOf(stringCellValue).intValue()));
							}
							else if (c == 6) {
								//支出金额
								String stringCellValue = pu.getCellValue(cell);
								if(StringUtils.isEmpty(stringCellValue)){
									detail.setOutAmount(null);
								}else{
									detail.setOutAmount(BigDecimal.valueOf(Double.valueOf(stringCellValue)));
								}
							}
							else if (c == 7) {
								//备注
								String stringCellValue = pu.getCellValue(cell);
								detail.setActDesc(stringCellValue);
							}
							
						}
						if(flag==0){
							list.add(detail);
						}
					}
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
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		}
		return list;
	}

	
	
	@Override
	public void saveCheck(TProBasicInfo bean, TProcessCheck checkBean, String files, User user,
			String fundJson,
			String outcomeJson) throws Exception {
		CheckEntity entity = (CheckEntity)bean;
		String checkUrl = "/project/verdict/";
		String lookUrl = "/project/detail/";
		String ywfw = "XMSB";
		String appTaskType ="xmsb";
		if(bean.getFProOrBasic()==0){
			ywfw = "JBZCSB";
			appTaskType ="jbzcsb";
		}if(bean.getFProOrBasic()==2){
			ywfw = "ZXMSB";
			appTaskType ="zxmsb";
		}
		
		bean = (TProBasicInfo)tProcessCheckMng.checkProcess(checkBean,entity,user,ywfw,checkUrl,lookUrl,files);
		User nextUser = userMng.findById(bean.getNextCheckUserId());
		if(nextUser != null && nextUser.getRoleName().contains("预算管理岗")){
			bean.setFExportStauts(2);//已经到达预算管理岗 审批了，他就可以开始进行报表收报
		}
		//取出来以后重新设置值，因为项目申报的状态属性不一样
		User applyUser = userMng.findById(bean.getFProAppliPeopleId());
		if("-1".equals(bean.getFFlowStauts())){//打回原点
			bean.setFFlowStauts("-11");
			bean.setFExportStauts(0);
			/*User u1 = userMng.getUserByRoleNameAndDepartName("部门负责人", "综合改革办公室");
			bean.setFProAppliPeople(u1.getName());//项目申报人
			bean.setFProAppliPeopleId(u1.getId());//项目申报人id
			bean.setFProAppliDepart(u1.getDepart().getName());//申报部门
			bean.setFProAppliDepartId(u1.getDepart().getId());//申报部门id
			 */
			//退回推送通知给app
			/*if(JpushClientUtil.sendToRegistrationId(applyUser.getAccountNo(),null,"您的任务被退回",bean.getFProName()+"任务编号："+bean.getFProCode(),bean.getFProId().toString(), "0",appTaskType)==1){
				System.out.println("推送给指定Android用户success");
			}*/
		}else if("9".equals(bean.getFFlowStauts())){//审批结束
			bean.setFFlowStauts("19");
			if(0==bean.getFProOrBasic()){
				//基本支出
				bean.setFProLibType("2");//所属库 1：备选库 2：上报库   3：执行中 4：已完结
				bean.setFExt6("2");//项目评审状态   0、未评审 1、待评 2、已通过 -1、已退回
				bean.setFExt8(DateUtil.formatDate(new Date()));//评审时间   年-月-日
				bean.setFExt4("21");//上报状态 20、二上未申报   21、二上已申报
				bean.setFExt5(null);
				bean.setFFlowStauts("29");
				bean.setFIsExecute("0");
				List<TProBasicInfo> beanList = new ArrayList<TProBasicInfo>();
				beanList.add(bean);
				//生成二下通过的指标
				budgetIndexMgrMng.createIndex(beanList);
			}else if(1==bean.getFProOrBasic()){
				//项目支出
				bean.setFProLibType("2");//所属库 1：备选库 2：上报库   3：执行中 4：已完结
				bean.setFExt6("0");//项目评审状态  0 未评审  ，
			}else if(2==bean.getFProOrBasic()){
				//项目支出
				bean.setFProLibType("5");//所属库 1：备选库 2：上报库   3：执行中 4：已完结 5:子项目申报库
				bean.setFExt6("0");//项目评审状态  0 未评审  ，
			}
			//复核  给预算管理岗推送消息
			String title = "有新的项目已审批成功,请及时反馈!";
			String msg = "申报的项目名称:"+bean.getFProName()+",编号:"+bean.getFProCode()+",已审批成功!";
			User u1 = userMng.getUserByRoleNameAndDepartName("预算管理岗", "财务处");
			privateInforMng.setMsg(title, msg, u1.getId(), "2");
			//保存一条数据到数据分析的表里
			if(bean.getFProOrBasic()!=2){
				analysisProMng.copyProBasicInfo(bean, 1);
			}
			/*//退回推送通知给app
			if(JpushClientUtil.sendToRegistrationId(applyUser.getAccountNo(),null,"您的任务被退回",bean.getFProName()+"任务编号："+bean.getFProCode(),bean.getFProId().toString(), "0",appTaskType)==1){
				System.out.println("推送给指定Android用户success");
			}*/
		}
		bean = (TProBasicInfo) super.saveOrUpdate(bean);
		
		
		if(user.getRoleName().contains("预算主办会计岗")){
			//删除数据库中资金来源
			getSession().createSQLQuery("delete from T_PRO_BASIC_FUNDS where F_PRO_ID ="+bean.getFProId()).executeUpdate();
				if(!StringUtil.isEmpty(fundJson)){
				//获取Json对象
				List<TProBasicFunds> tProBasicFundsList = JSON.parseObject("["+fundJson.toString()+"]",new TypeReference<List<TProBasicFunds>>(){});
				for (TProBasicFunds tProBasicFunds: tProBasicFundsList) {
					TProBasicFunds info = new TProBasicFunds();
					info.setFProId(bean.getFProId());
					info.setFundsSource(tProBasicFunds.getFundsSource());
					info.setFundsSourceText(tProBasicFunds.getFundsSourceText());
					info.setAmount(tProBasicFunds.getAmount());
					super.merge(info);
				}
			}
				
			//删除数据库中申请中的基本支出明细
			getSession().createSQLQuery("delete from T_PRO_EXPEND_DETAIL where F_PRO_ID ="+bean.getFProId()+"").executeUpdate();
			if(!StringUtil.isEmpty(outcomeJson)){
				//获取基本支出明细的Json对象
				List<TProExpendDetail> proExpendDetail = JSON.parseObject("["+outcomeJson+"]",new TypeReference<List<TProExpendDetail>>(){});
				for (TProExpendDetail infos : proExpendDetail) {
					TProExpendDetail info = new TProExpendDetail();
					info.setFProId(bean.getFProId());
					info.setActivity(infos.getActivity());
					info.setFunSubName(infos.getFunSubName());
					info.setFunSubCode(infos.getFunSubCode());
					info.setSubName(infos.getSubName());
					info.setSubCode(infos.getSubCode());
					info.setCapitalSourceName(infos.getCapitalSourceName());
					info.setCapitalSourceCode(infos.getCapitalSourceCode());
					info.setOutAmount(infos.getOutAmount());
					info.setActDesc(infos.getActDesc());
					super.merge(info);
				}
			}
		}
	}

	@Override
	public HSSFWorkbook exportExcel(List<TProBasicInfo> dataList,
			String filePath) {
		
		FileInputStream fis =null;
		try {
			File file = new File(filePath);
			fis = new FileInputStream(file);
			HSSFWorkbook wb  = new HSSFWorkbook(fis);
			HSSFSheet sheet0 = wb.getSheetAt(0);
			if (dataList != null && dataList.size() > 0) {
				HSSFRow row = sheet0.getRow(2);//格式行
				for (int i = 0 ; i < dataList.size(); i++) {
					HSSFRow hssfRow = sheet0.createRow(2+i);
					hssfRow.setHeight(row.getHeight());
					TProBasicInfo data = dataList.get(i);
					
					HSSFCell cell0 = hssfRow.createCell(0);
					HSSFCell cell1 = hssfRow.createCell(1);
					HSSFCell cell2 = hssfRow.createCell(2);
					HSSFCell cell3 = hssfRow.createCell(3);
					HSSFCell cell4 = hssfRow.createCell(4);
					HSSFCell cell5 = hssfRow.createCell(5);
					HSSFCell cell6 = hssfRow.createCell(6);
					HSSFCell cell7 = hssfRow.createCell(7);
					HSSFCell cell8 = hssfRow.createCell(8);
					HSSFCell cell9 = hssfRow.createCell(9);
					HSSFCell cell10 = hssfRow.createCell(10);
					HSSFCell cell11 = hssfRow.createCell(11);
					HSSFCell cell12 = hssfRow.createCell(12);
					HSSFCell cell13 = hssfRow.createCell(13);
					HSSFCell cell14 = hssfRow.createCell(14);
					HSSFCell cell15 = hssfRow.createCell(15);
					HSSFCell cell16 = hssfRow.createCell(16);
					/*HSSFCell cell17 = hssfRow.createCell(17);
					HSSFCell cell18 = hssfRow.createCell(18);
					HSSFCell cell19 = hssfRow.createCell(19);
					HSSFCell cell20 = hssfRow.createCell(20);
					HSSFCell cell21 = hssfRow.createCell(21);
					HSSFCell cell22 = hssfRow.createCell(22);
					HSSFCell cell23 = hssfRow.createCell(23);*/
					
					cell0.setCellValue(i + 1);
					cell1.setCellValue(data.getFProCode());
					cell2.setCellValue(data.getFProName());
					cell3.setCellValue(data.getFProOrBasic()==0?"基本支出":"项目支出");
					cell4.setCellValue(data.getFirstLevelName());
					cell5.setCellValue(data.getFirstLevelCode());
					cell6.setCellValue(data.getSecondLevelName());
					cell7.setCellValue(data.getSecondLevelCode());
					cell8.setCellValue(data.getFProBudgetAmount().doubleValue());
					cell9.setCellValue(data.getFProAppliDepart());
					cell10.setCellValue(DateUtil.formatDate(data.getFProAppliTime(), "yyyy-MM-dd"));
					cell11.setCellValue(data.getFProAppliPeople());
					cell12.setCellValue(data.getFProAppliPeople());
					cell13.setCellValue(data.getHeaderPhone());
					cell14.setCellValue(data.getPlanStartYear());
					String FProStauts = data.getFProStauts();
					if("0".equals(FProStauts)){
						FProStauts = "暂存";
					}else if("-1".equals(FProStauts)){
						FProStauts = "已退回";
					}else if("9".equals(FProStauts)){
						FProStauts = "已完结";
					}else if("1".equals(FProStauts)){
						FProStauts = "待审批";
					}else {
						FProStauts = "未结项";
					}
					cell15.setCellValue(FProStauts);
					cell16.setCellValue("1".equals(data.getFExportStauts())?"已收报":"未收报");
					/*cell14.setCellValue(data.getFunctionType());
					cell15.setCellValue(StringUtil.numToCh(data.getFContinuousYn()));
					cell16.setCellValue(StringUtil.numToCh(data.getIsMerge()));
					cell17.setCellValue(StringUtil.numToCh(data.getIsMerge()));
					cell18.setCellValue(StringUtil.numToCh(data.getIsOrientation()));
					cell19.setCellValue(data.getPlanStartYear());
					cell20.setCellValue(data.getFProRollingCycle());
					cell21.setCellValue(data.getSecretLevel());
					cell22.setCellValue(data.getSecretDeadline());
					cell23.setCellValue(StringUtil.numToCh(data.getFProStauts()));*/
					
					cell0.setCellStyle(row.getCell(0).getCellStyle());
					cell1.setCellStyle(row.getCell(1).getCellStyle());
					cell2.setCellStyle(row.getCell(2).getCellStyle());
					cell3.setCellStyle(row.getCell(3).getCellStyle());
					cell4.setCellStyle(row.getCell(4).getCellStyle());
					cell5.setCellStyle(row.getCell(5).getCellStyle());
					cell6.setCellStyle(row.getCell(6).getCellStyle());
					cell7.setCellStyle(row.getCell(7).getCellStyle());
					cell8.setCellStyle(row.getCell(8).getCellStyle());
					cell9.setCellStyle(row.getCell(9).getCellStyle());
					cell10.setCellStyle(row.getCell(10).getCellStyle());
					cell11.setCellStyle(row.getCell(11).getCellStyle());
					cell12.setCellStyle(row.getCell(12).getCellStyle());
					cell13.setCellStyle(row.getCell(13).getCellStyle());
					cell14.setCellStyle(row.getCell(14).getCellStyle());
					cell15.setCellStyle(row.getCell(15).getCellStyle());
					cell16.setCellStyle(row.getCell(16).getCellStyle());
				}
			}
			return wb;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return null;
	}
	
	@Override
	public HSSFWorkbook exportExcePerformance(List<PerformanceIndicatorModel> dataList,
			String filePath) {
		
		FileInputStream fis =null;
		try {
			File file = new File(filePath);
			fis = new FileInputStream(file);
			HSSFWorkbook wb  = new HSSFWorkbook(fis);
			HSSFSheet sheet0 = wb.getSheetAt(0);
			if (dataList != null && dataList.size() > 0) {
				HSSFRow row = sheet0.getRow(2);//格式行
				for (int i = 0 ; i < dataList.size(); i++) {
					HSSFRow hssfRow = sheet0.createRow(2+i);
					hssfRow.setHeight(row.getHeight());
					PerformanceIndicatorModel data = dataList.get(i);
					
					HSSFCell cell0 = hssfRow.createCell(0);
					HSSFCell cell1 = hssfRow.createCell(1);
					HSSFCell cell2 = hssfRow.createCell(2);
					HSSFCell cell3 = hssfRow.createCell(3);
					
					cell0.setCellValue(data.gettOneName());
					cell1.setCellValue(data.gettTwoName());
					cell2.setCellValue(data.getIndexContent());
					cell3.setCellValue(data.gettIndexVal());
				}
			}
			return wb;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return null;
	}

	@Override
	public void deleteProject(Integer id) {
		//事前申请的状态为99（删除）
		getSession().createSQLQuery("UPDATE t_pro_basic_info SET F_STAUTS=99 WHERE F_PRO_ID="+id).executeUpdate();
		TProBasicInfo bean=super.findById(id);
		if(bean.getZxmId()!=null){
			TProBasicInfo oldBean =super.findById(bean.getZxmId());
			if(oldBean!=null){
				oldBean.setZxmImportStatus("0");
				super.saveOrUpdate(oldBean);
			}
		}
	}
	@Override
	public void updateProjectLibrary(Integer id) {
		//事前申请的状态为99（删除）
		getSession().createSQLQuery("UPDATE t_pro_basic_info SET F_STAUTS='99' WHERE F_PRO_ID="+id).executeUpdate();
		TProBasicInfo bean=super.findById(id);
		if(bean.getZxmId()!=null){
			TProBasicInfo oldBean =super.findById(bean.getZxmId());
			if(oldBean!=null){
				//给待审批人发送消息
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String title="[项目申报]申请被退回消息";
				String msg="您待审批的  "+oldBean.getFProName() +",任务编号：("+oldBean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
				privateInforMng.setMsg(title, msg, oldBean.getNextCheckUserId(), "3");
				//撤回
				oldBean.setCheckStauts("-14");//已撤回
				oldBean.setStauts("0");//暂存
				oldBean.setNextCheckKey("0");//设置到初始节点
				oldBean.setNextCheckUserId("");
				oldBean.setFProLibType("5");
				oldBean.setNextCheckUserName("");
				oldBean.setFExportStauts(0);//收报状态
				oldBean.setZxmImportStatus("0");
				super.saveOrUpdate(oldBean);
			}
		}
	}

	@Override
	public void filesUpdate(String id, String filesName) {
		TProBasicInfo bean = findById(Integer.valueOf(id));
		attachmentMng.joinEntity(bean,filesName);
	}

	@Override
	public TProBasicInfo oversave(TProBasicInfo bean,String jxmingxi) {
		String rollingCycle = bean.getFProRollingCycle();
		
		bean = super.findById(bean.getFProId());
		bean.setFProRollingCycle(rollingCycle);
		bean = (TProBasicInfo) super.merge(bean);
		
		return bean;
	}
	
	/**
	 * 项目延期预警列表
	 * **/
	@Override
	public Pagination proDelayList(int pageNo, int pageSize,String fProCode,String fProName,String deptName) {
		StringBuilder sb=new StringBuilder("SELECT F_B_INDEX_CODE fProCode,F_EXP_ITEM_NAME fProName,F_AMOUNT fContAmount,t1.F_DEPT_NAME deptName,F_RECE_PROPERTY fReceProperty,F_RECE_STAGE fReceStage,DATE_FORMAT(t3.F_RECE_PLAN_TIME,'%Y-%m-%d') fRecePlanTime,t1.F_CONT_ID fcId,datediff(DATE_FORMAT(t3.F_RECE_PLAN_TIME,'%Y-%m-%d'),DATE_FORMAT(now(), '%Y-%m-%d')) delayDays");
		sb.append("	FROM T_CONTRACT_BASIC_INFO t1 inner join t_budget_index_mgr t2 on t1.F_BUDGET_INDEX_CODE=t2.F_B_ID and t2.F_INDEX_TYPE =1 inner join T_RECEIV_PLAN t3 on t1.F_CONT_ID=t3.F_CONT_ID");
		sb.append(" and t3.F_RECE_TIME is null");
		sb.append(" and DATE_FORMAT(t3.F_RECE_PLAN_TIME,'%Y-%m-%d') <= date_add(CURDATE(),INTERVAL 3 month)"); 
		//按项目编号模糊搜索
		if(!StringUtil.isEmpty(fProCode)){
			sb.append(" AND F_B_INDEX_CODE LIKE('%"+fProCode+"%')");
		}
		//按项目名称模糊搜索
		if(!StringUtil.isEmpty(fProName)){
			sb.append(" AND F_EXP_ITEM_NAME LIKE('%"+fProName+"%')");
		}
		//按部门名称模糊搜索
		if(!StringUtil.isEmpty(deptName)){
			sb.append(" AND t1.F_DEPT_NAME LIKE('%"+deptName+"%')");
		}
		sb.append(" order by t3.F_RECE_PLAN_TIME");
		String str=sb.toString();
		Pagination p=super.findObjectListBySql(str, pageNo, pageSize);
		List<Object[]> dataList = (List<Object[]>) p.getList();
		List<ProjectDelay>list=new ArrayList<>();
		if (dataList != null && dataList.size() > 0) {
			int i = 0;
			for (Object[] obj: dataList) {
				ProjectDelay t=new ProjectDelay();
				t.setfProCode(String.valueOf(obj[0]));
				t.setfProName(String.valueOf(obj[1]));
				t.setfContAmount(Double.valueOf((String) obj[2]));
				t.setdeptName(String.valueOf(obj[3]));
				t.setfReceProperty(String.valueOf(obj[4]));
				t.setfReceStage(String.valueOf(obj[5]));
				t.setfRecePlanTime(String.valueOf(obj[6]));		
				t.setfcId(Integer.valueOf(String.valueOf(obj[7])));
				t.setdelayDays(Integer.valueOf(String.valueOf(obj[8])));
				t.setDayNum(Integer.valueOf(String.valueOf(obj[8])));
				t.setNum(pageNo * pageSize + i - 9);
				i++;
				list.add(t);
			}
			p.setList(list);
		}
		return p;
	}

	@Override
	public TProBasicInfo saveReview(TProBasicInfo bean,User user) {
		// TODO Auto-generated method stub
		//保存项目信息
		TProBasicInfo updateinfo=(TProBasicInfo)super.findById(bean.getFProId());
		//新增复核历史记录
		tProBasicRenameHistoryMng.saveHistory(updateinfo,bean.getFProName(),user);
		updateinfo.setFProName(bean.getFProName());
		//复核  给项目申报人推送消息
		String title="您申报的项目信息有更新";
		String msg="您申报的项目名称:"+updateinfo.getFProName()+",编号:"+updateinfo.getFProCode()+",项目名称被变更为:"+bean.getFProName();
		String userId=updateinfo.getUserId();
		privateInforMng.setMsg(title, msg, userId,"3");
		TProBasicInfo info = (TProBasicInfo) super.saveOrUpdate(updateinfo);
		return info;
	}

	@Override
	public List<TProBasicInfo> getbasiProByIds(String ids) {
		// TODO Auto-generated method stub
		List<TProBasicInfo> list=new ArrayList<TProBasicInfo>();
		if(StringUtils.isNotEmpty(ids)){
			Finder finder = Finder.create(" from TProBasicInfo where FProId in ("+ids+")");
			return super.find(finder);
		}
		return list;
	}
	
	@Override
	public void updateExportStatesByIds(String ids){
		String sql="update t_pro_basic_info set F_EXPORT_STAUTS = 1 where f_pro_id in ("+ids+")";
		Query query=getSession().createSQLQuery(sql);
		query.executeUpdate();
	}
	
	@Override
	public String reCall(Integer id,User user) throws Exception {
		//根据id查询对象
		TProBasicInfo bean=(TProBasicInfo)super.findById(id);
		//如果已经被收报，无法撤销,只有预算管理岗才能撤销
		if(bean.getFExportStauts() !=null && bean.getFExportStauts()==1 && !user.getRoleName().contains("预算管理岗")){
			throw new ServiceException("该项目已经被收报，无法撤销");
		}
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="[项目申报]申请被撤回消息";
		if(bean.getFProOrBasic()==0){
			title="[基本支出申报]申请被撤回消息";
		}
		String msg="您待审批的  "+bean.getFProName() +",任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean.setCheckStauts("-14");//已撤回
		bean.setStauts("0");//暂存
		bean.setNextCheckKey("0");//设置到初始节点
		bean.setNextCheckUserId("");
		if(bean.getFProOrBasic()==2){
			bean.setFProLibType("5");
		}else{
			bean.setFProLibType("1");//设置返回备选库
		}
		bean.setNextCheckUserName("");
		bean.setFExportStauts(0);//收报状态
		this.updateDefault(bean);
		return "操作成功";
	}

	@Override
	public String proReCall(Integer id) throws Exception {
		//根据id查询对象
		TProBasicInfo bean=(TProBasicInfo)super.findById(id);
		List<ExecuteProject> zzxmList = projectMng.zzxmList(bean.getFProId().toString());
		ExecuteProject executeProject = zzxmList.get(0);
		//删除待办
		personalWorkMng.deleteDb(executeProject.getNextCheckUserId() , executeProject.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="[列支结转]申请被撤回消息";
		String msg="您待审批的  "+bean.getFProName() +",任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		executeProject=(ExecuteProject) reCall((ExecuteProject) executeProject);
		bean.setFjzspzt(executeProject.getJzspzt());
		bean.setFjzclrbm(executeProject.getZxxmclrbm());
		this.updateDefault(bean);
		this.updateDefault(executeProject);
		return "操作成功";
	}
	
	
	@Override
	public void receiveReport(String receiveIdList, String fExportStauts) {
		//选中项收报
		String[] reStrarray = receiveIdList.split(",");
		if(reStrarray.length>0 && StringUtils.isNotEmpty(reStrarray[0])){
			for (int i = 0; i < reStrarray.length; i++) {
				TProBasicInfo proBean = projectMng.findById(Integer.valueOf(reStrarray[i]));
				proBean.setFExportStauts(Integer.valueOf(fExportStauts));
				super.saveOrUpdate(proBean);
			}
		}
			
	}

	@Override
	public boolean checkSecondLevelName(String departId, String year, String code, String FProCode) {
		Finder finder = Finder.create(" FROM TProBasicInfo WHERE (FStauts <> 99 or FStauts is null)");
		if(!StringUtil.isEmpty(departId)){
			finder.append(" AND FProAppliDepartId='"+departId+"'");
		}
		if(!StringUtil.isEmpty(year)){
			finder.append(" AND planStartYear='"+year+"'");
		}
		if(!StringUtil.isEmpty(code)){
			finder.append(" AND secondLevelCode='"+code+"'");
		}
		List<TProBasicInfo> list = super.find(finder);
		if(list != null && list.size() > 0){//项目是否存在
			if(!StringUtil.isEmpty(FProCode)){//项目的编号不为空	null-新增	有值-暂存后修改送审、审批中修改通过
				if(list.get(0).getFProCode().equals(FProCode)){//判断是否为同一个项目, 项目编号一致，说明是同一个项目，未重复
					return true;
				}
			}
		}else {//项目不存在
			return true;
		}
		return false;
	}

	@Override
	public boolean checkSecondCode(TProBasicInfo bean) {
		List<TProExpendDetail> beanList = bean.getExpendList();
		String secondLevelCode = bean.getSecondLevelCode();
		
		for (int i = 0; i < beanList.size(); i++) {
			String subCode = beanList.get(i).getSubCode().substring(0, 3);
			//如果不相等则证明选择的经济分类科目不是该二级指标下的数据返回true
			if(!secondLevelCode.equals(subCode)){
				return true;
			}
		}
		return false;
	}

	@Override
	public HSSFWorkbook proExportExcel(TProBasicInfo bean,
			List<TProBasicFunds> tpbfList, List<PerformanceIndicatorModel> pimList,
			List<TProExpendDetail> tpedList, List<TProcessCheck> tpcList,
			String filePath) {
		
		FileInputStream fis = null;
		try {
			File file = new File(filePath);
			fis = new FileInputStream(file);
			HSSFWorkbook wb = new HSSFWorkbook(fis);
			//Excel标签页sheet1-项目基本信息
			HSSFSheet sheet1 = wb.getSheetAt(0);
			//Excel标签页sheet2-项目支出绩效目标
			HSSFSheet sheet2 = wb.getSheetAt(1);
			//Excel标签页sheet3-项目支出明细
			HSSFSheet sheet3 = wb.getSheetAt(2);
			//Excel标签页sheet4-审批记录
			HSSFSheet sheet4 = wb.getSheetAt(3);
			
			//项目基本信息
			if (bean != null) {
				//项目编号
				HSSFRow row1 = sheet1.getRow(1);
				HSSFCell proCodeCell = row1.getCell(1);
				proCodeCell.setCellValue(bean.getFProCode());
				
				//项目名称
				HSSFRow row2 = sheet1.getRow(2);
				HSSFCell proNameCell = row2.getCell(1);
				proNameCell.setCellValue(bean.getFProName());
				
				HSSFRow row3 = sheet1.getRow(3);
				//预算支出类型
				HSSFCell proOrBasicCell = row3.getCell(1);
				proOrBasicCell.setCellValue(bean.getFProOrBasic()==0?"基本支出":"项目支出");
				//部门
				HSSFCell proAppliDeptCell = row3.getCell(3);
				proAppliDeptCell.setCellValue(bean.getFProAppliDepart());
				
				HSSFRow row4 = sheet1.getRow(4);
				//所属一级分类名称
				HSSFCell firstLevelNameCell = row4.getCell(1);
				firstLevelNameCell.setCellValue(bean.getFirstLevelName());
				//所属一级分类代码
				HSSFCell firstLevelCodeCell = row4.getCell(3);
				firstLevelCodeCell.setCellValue(bean.getFirstLevelCode());
				
				HSSFRow row5 = sheet1.getRow(5);
				//二级分类名称
				HSSFCell secondLevelNameCell = row5.getCell(1);
				secondLevelNameCell.setCellValue(bean.getSecondLevelName());
				//二级分类代码
				HSSFCell secondLevelCodeCell = row5.getCell(3);
				secondLevelCodeCell.setCellValue(bean.getSecondLevelCode());
				
				HSSFRow row6 = sheet1.getRow(6);
				//项目预算金额
				HSSFCell proBudgetAmountCell = row6.getCell(1);
				proBudgetAmountCell.setCellValue(bean.getFProBudgetAmount().doubleValue());
				//大写金额
				HSSFCell proBudgetBigAmountCell = row6.getCell(3);
				proBudgetBigAmountCell.setCellValue(StringUtil.getChnmoney(bean.getFProBudgetAmount().doubleValue()*10000));
				
				HSSFRow row7 = sheet1.getRow(7);
				//资金来源
				String fundsSource = tpbfList.get(0).getFundsSource();
				if("0".equals(fundsSource)) {
					fundsSource = "财政拨款收入";
				}else if("1".equals(fundsSource)) {
					fundsSource = "教育事业收入";
				}else if("2".equals(fundsSource)) {
					fundsSource = "科研事业收入";
				}else if("3".equals(fundsSource)) {
					fundsSource = "非同级拨款收入";
				}else if("4".equals(fundsSource)) {
					fundsSource = "其他收入";
				}else if("5".equals(fundsSource)) {
					fundsSource = "利息收入";
				}
				HSSFCell fundsSourceCell = row7.getCell(1);
				fundsSourceCell.setCellValue(fundsSource);
				//开始执行年份
				HSSFCell planStartYearCell = row7.getCell(3);
				planStartYearCell.setCellValue(bean.getPlanStartYear());
				
				HSSFRow row8 = sheet1.getRow(8);
				//申报部门
				HSSFCell proAppliDepartCell = row8.getCell(1);
				proAppliDepartCell.setCellValue(bean.getFProAppliDepart());
				//申报人
				HSSFCell proAppliPeopleCell = row8.getCell(3);
				proAppliPeopleCell.setCellValue(bean.getFProAppliPeople());
				
				HSSFRow row9 = sheet1.getRow(9);
				//立项依据
				HSSFCell proAccordingCell = row9.getCell(1);
				proAccordingCell.setCellValue(bean.getFProAccording());
				
				HSSFRow row10 = sheet1.getRow(10);
				//项目实施方案
				HSSFCell explainCell = row10.getCell(1);
				explainCell.setCellValue(bean.getFExplain());
				
				HSSFRow sheet2Row = sheet2.getRow(1);
				//总体目标
				HSSFCell totalityDescribeCell = sheet2Row.getCell(1);
				totalityDescribeCell.setCellValue(bean.getTotalityDescribe());
			}
			
			//项目支出绩效目标
			if(pimList != null && pimList.size() > 0){
				//格式行
				HSSFRow row = sheet2.getRow(3);
				for (int i = 0; i < pimList.size(); i++) {
					//创建内容行
					HSSFRow hssfRow = sheet2.createRow(i+3);
					hssfRow.setHeight(row.getHeight());
					
					//创建内容列
					HSSFCell cell1 = hssfRow.createCell(0);
					HSSFCell cell2 = hssfRow.createCell(1);
					HSSFCell cell3 = hssfRow.createCell(2);
					HSSFCell cell4 = hssfRow.createCell(3);
					
					//设置内容列值
					cell1.setCellValue(i+1);
					cell2.setCellValue(pimList.get(i).gettOneName());
					cell3.setCellValue(pimList.get(i).gettTwoName());
					cell4.setCellValue(pimList.get(i).gettIndexVal());
					
					//设置单元格格式
					cell1.setCellStyle(row.getCell(0).getCellStyle());
					cell2.setCellStyle(row.getCell(1).getCellStyle());
					cell3.setCellStyle(row.getCell(2).getCellStyle());
					cell4.setCellStyle(row.getCell(3).getCellStyle());
				}
			}
			
			//项目支出明细
			if(tpedList != null && tpedList.size() > 0){
				//格式行
				HSSFRow row = sheet3.getRow(2);
				for (int i = 0; i < tpedList.size(); i++) {
					//创建内容行
					HSSFRow hssfRow = sheet3.createRow(i+2);
					hssfRow.setHeight(row.getHeight());
					
					//创建内容列
					HSSFCell cell1 = hssfRow.createCell(0);
					HSSFCell cell2 = hssfRow.createCell(1);
					HSSFCell cell3 = hssfRow.createCell(2);
					HSSFCell cell4 = hssfRow.createCell(3);
					HSSFCell cell5 = hssfRow.createCell(4);
					
					//设置内容列值
					cell1.setCellValue(i+1);
					cell2.setCellValue(tpedList.get(i).getActivity());
					cell3.setCellValue(tpedList.get(i).getSubName());
					cell4.setCellValue(tpedList.get(i).getOutAmount().doubleValue());
					cell5.setCellValue(tpedList.get(i).getActDesc());
					
					//设置单元格格式
					cell1.setCellStyle(row.getCell(0).getCellStyle());
					cell2.setCellStyle(row.getCell(1).getCellStyle());
					cell3.setCellStyle(row.getCell(2).getCellStyle());
					cell4.setCellStyle(row.getCell(3).getCellStyle());
					cell5.setCellStyle(row.getCell(4).getCellStyle());
				}
			}
			
			//审批记录
			if(tpcList != null && tpcList.size() > 0){
				//格式行
				HSSFRow row = sheet4.getRow(2);
				for (int i = 0; i < tpcList.size(); i++) {
					//创建内容行
					HSSFRow hssfRow = sheet4.createRow(i+2);
					hssfRow.setHeight(row.getHeight());
					
					//创建内容列
					HSSFCell cell1 = hssfRow.createCell(0);
					HSSFCell cell2 = hssfRow.createCell(1);
					HSSFCell cell3 = hssfRow.createCell(2);
					HSSFCell cell4 = hssfRow.createCell(3);
					HSSFCell cell5 = hssfRow.createCell(4);
					
					//设置内容列值
					cell1.setCellValue(tpcList.get(i).getFuserName());
					cell2.setCellValue(("1".equals(tpcList.get(i).getFcheckResult()))?"通过":"不通过");
					cell3.setCellValue(DateUtil.formatDate(tpcList.get(i).getFcheckTime(), "yyyy-MM-dd"));
					cell4.setCellValue(tpcList.get(i).getFcheckRemake());
					cell5.setCellValue((tpcList.get(i).getFilesPid() == null || "".equals(tpcList.get(i).getFilesPid()))?"无附件":"有附件");
					
					//设置单元格格式
					cell1.setCellStyle(row.getCell(0).getCellStyle());
					cell2.setCellStyle(row.getCell(1).getCellStyle());
					cell3.setCellStyle(row.getCell(2).getCellStyle());
					cell4.setCellStyle(row.getCell(3).getCellStyle());
					cell5.setCellStyle(row.getCell(4).getCellStyle());
				}
			}
			return wb;
		} catch (Exception e) {
			
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (IOException e) {
					
				}
			}
		}
		return null;
	}

	@Override
	public HSSFWorkbook basicExpenditureExport(TProBasicInfo bean,
			List<TProBasicFunds> tpbfList, List<TProExpendDetail> tpedList,
			List<TProcessCheck> tpcList, String filePath) {
		
		FileInputStream fis = null;
		try {
			File file = new File(filePath);
			fis = new FileInputStream(file);
			HSSFWorkbook wb = new HSSFWorkbook(fis);
			//Excel标签页sheet1-基本支出信息
			HSSFSheet sheet1 = wb.getSheetAt(0);
			//Excel标签页sheet2-基本支出明细
			HSSFSheet sheet2 = wb.getSheetAt(1);
			//Excel标签页sheet3-审批记录
			HSSFSheet sheet3 = wb.getSheetAt(2);
			
			//基本支出信息
			if (bean != null) {
				//基本支出编号
				HSSFRow row1 = sheet1.getRow(1);
				HSSFCell proCodeCell = row1.getCell(1);
				proCodeCell.setCellValue(bean.getFProCode());
				
				//基本支出名称
				HSSFRow row2 = sheet1.getRow(2);
				HSSFCell proNameCell = row2.getCell(1);
				proNameCell.setCellValue(bean.getFProName());
				
				HSSFRow row3 = sheet1.getRow(3);
				//预算支出类型
				HSSFCell proOrBasicCell = row3.getCell(1);
				proOrBasicCell.setCellValue(bean.getFProOrBasic()==0?"基本支出":"项目支出");
				//部门
				HSSFCell proAppliDeptCell = row3.getCell(3);
				proAppliDeptCell.setCellValue(bean.getFProAppliDepart());
				
				HSSFRow row4 = sheet1.getRow(4);
				//所属一级分类名称
				HSSFCell firstLevelNameCell = row4.getCell(1);
				firstLevelNameCell.setCellValue(bean.getFirstLevelName());
				//所属一级分类代码
				HSSFCell firstLevelCodeCell = row4.getCell(3);
				firstLevelCodeCell.setCellValue(bean.getFirstLevelCode());
				
				HSSFRow row5 = sheet1.getRow(5);
				//二级分类名称
				HSSFCell secondLevelNameCell = row5.getCell(1);
				secondLevelNameCell.setCellValue(bean.getSecondLevelName());
				//二级分类代码
				HSSFCell secondLevelCodeCell = row5.getCell(3);
				secondLevelCodeCell.setCellValue(bean.getSecondLevelCode());
				
				HSSFRow row6 = sheet1.getRow(6);
				//项目预算金额
				HSSFCell proBudgetAmountCell = row6.getCell(1);
				proBudgetAmountCell.setCellValue(bean.getFProBudgetAmount().doubleValue());
				//大写金额
				HSSFCell proBudgetBigAmountCell = row6.getCell(3);
				proBudgetBigAmountCell.setCellValue(StringUtil.getChnmoney(bean.getFProBudgetAmount().doubleValue()*10000));
				
				HSSFRow row7 = sheet1.getRow(7);
				//资金来源
				String fundsSource = tpbfList.get(0).getFundsSource();
				if("0".equals(fundsSource)) {
					fundsSource = "财政拨款收入";
				}else if("1".equals(fundsSource)) {
					fundsSource = "教育事业收入";
				}else if("2".equals(fundsSource)) {
					fundsSource = "科研事业收入";
				}else if("3".equals(fundsSource)) {
					fundsSource = "非同级拨款收入";
				}else if("4".equals(fundsSource)) {
					fundsSource = "其他收入";
				}else if("5".equals(fundsSource)) {
					fundsSource = "利息收入";
				}
				HSSFCell fundsSourceCell = row7.getCell(1);
				fundsSourceCell.setCellValue(fundsSource);
				//开始执行年份
				HSSFCell planStartYearCell = row7.getCell(3);
				planStartYearCell.setCellValue(bean.getPlanStartYear());
				
				HSSFRow row8 = sheet1.getRow(8);
				//申报部门
				HSSFCell proAppliDepartCell = row8.getCell(1);
				proAppliDepartCell.setCellValue(bean.getFProAppliDepart());
				//申报人
				HSSFCell proAppliPeopleCell = row8.getCell(3);
				proAppliPeopleCell.setCellValue(bean.getFProAppliPeople());
			}
			
			//基本支出明细
			if(tpedList != null && tpedList.size() > 0){
				//格式行
				HSSFRow row = sheet2.getRow(2);
				for (int i = 0; i < tpedList.size(); i++) {
					//创建内容行
					HSSFRow hssfRow = sheet2.createRow(i+2);
					hssfRow.setHeight(row.getHeight());
					
					//创建内容列
					HSSFCell cell1 = hssfRow.createCell(0);
					HSSFCell cell2 = hssfRow.createCell(1);
					HSSFCell cell3 = hssfRow.createCell(2);
					HSSFCell cell4 = hssfRow.createCell(3);
					HSSFCell cell5 = hssfRow.createCell(4);
					
					//设置内容列值
					cell1.setCellValue(i+1);
					cell2.setCellValue(tpedList.get(i).getActivity());
					cell3.setCellValue(tpedList.get(i).getSubName());
					cell4.setCellValue(tpedList.get(i).getOutAmount().doubleValue());
					cell5.setCellValue(tpedList.get(i).getActDesc());
					
					//设置单元格格式
					cell1.setCellStyle(row.getCell(0).getCellStyle());
					cell2.setCellStyle(row.getCell(1).getCellStyle());
					cell3.setCellStyle(row.getCell(2).getCellStyle());
					cell4.setCellStyle(row.getCell(3).getCellStyle());
					cell5.setCellStyle(row.getCell(4).getCellStyle());
				}
			}
			
			//审批记录
			if(tpcList != null && tpcList.size() > 0){
				//格式行
				HSSFRow row = sheet3.getRow(2);
				for (int i = 0; i < tpcList.size(); i++) {
					//创建内容行
					HSSFRow hssfRow = sheet3.createRow(i+2);
					hssfRow.setHeight(row.getHeight());
					
					//创建内容列
					HSSFCell cell1 = hssfRow.createCell(0);
					HSSFCell cell2 = hssfRow.createCell(1);
					HSSFCell cell3 = hssfRow.createCell(2);
					HSSFCell cell4 = hssfRow.createCell(3);
					HSSFCell cell5 = hssfRow.createCell(4);
					
					//设置内容列值
					cell1.setCellValue(tpcList.get(i).getFuserName());
					cell2.setCellValue(("1".equals(tpcList.get(i).getFcheckResult()))?"通过":"不通过");
					cell3.setCellValue(DateUtil.formatDate(tpcList.get(i).getFcheckTime(), "yyyy-MM-dd"));
					cell4.setCellValue(tpcList.get(i).getFcheckRemake());
					cell5.setCellValue((tpcList.get(i).getFilesPid() == null || "".equals(tpcList.get(i).getFilesPid()))?"无附件":"有附件");
					
					//设置单元格格式
					cell1.setCellStyle(row.getCell(0).getCellStyle());
					cell2.setCellStyle(row.getCell(1).getCellStyle());
					cell3.setCellStyle(row.getCell(2).getCellStyle());
					cell4.setCellStyle(row.getCell(3).getCellStyle());
					cell5.setCellStyle(row.getCell(4).getCellStyle());
				}
			}
			return wb;
		} catch (Exception e) {
			
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (IOException e) {
					
				}
			}
		}
		return null;
	}
	
	@Override
	public Pagination record(TProcessCheck bean,User user,Integer pageNo, Integer pageSize) {
		Finder finder = Finder.create("from TProcessCheck where fuserId = '"+user.getId()+"'");
		if(!StringUtil.isEmpty(bean.getFcheckResult())){
			finder.append(" and fcheckResult =:fcheckResult ").setParam("fcheckResult", bean.getFcheckResult());
		}
		Pagination pagination = super.find(finder, pageNo, pageSize);
		List<TProcessCheck> list = (List<TProcessCheck>) pagination.getList();
		HashSet<TProBasicInfo> temp = new HashSet<TProBasicInfo>();
		//项目数据
		for (int i = list.size()-1; i >= 0; i--) {
			TProBasicInfo pbi = findbyCode(list.get(i).getFoCode());
			if(!StringUtil.isEmpty(pbi.getFProCode())){//查询出来不为空
				if(temp.add(pbi)){//判断是否能够添加
					temp.add(pbi);
					list.get(i).setFProName(pbi.getFProName());
					list.get(i).setFProCode(pbi.getFProCode());
					list.get(i).setFProID(pbi.getFProId());
					list.get(i).setNum(i+1);
				}else {
					list.remove(i);
				}
			}else{
				list.remove(i);
			}
		}
		pagination.setList(list);
		return pagination;
	}
	
	@Override
	public Pagination checkUpdatePageList(TProBasicCheckUpdate bean,
			int pageNo, int pageSize) {
		Finder finder = null;
		if(bean.getProId() != null){
			finder = Finder.create("  FROM TProBasicCheckUpdate WHERE proId = '"+bean.getProId()+"'");
		}
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public TProBasicInfo compareFields(TProBasicInfo oldBean, TProBasicInfo newBean, String lxyjFiles, String ssfaFiles,
		String delIndex, String totalityPerformanceJson, User user) throws Exception {
		//修改记录
		TProBasicCheckUpdate updRecord = new TProBasicCheckUpdate();
		updRecord.setProId(oldBean.getFProId());
		updRecord.setUserName(user.getName());
		updRecord.setUpdateTime(new Date());
		
		//保存修改项字段
		String str = "";
		//保存旧值字段
		String oldValue = "";
		//保存新值字段
		String newValue = "";
		
		if((oldBean.getFProOrBasic()==1 && newBean.getFProOrBasic()==1)||(oldBean.getFProOrBasic()==2 && newBean.getFProOrBasic()==2)){//项目支出
			//可修改项
			if(!oldBean.getFProName().equals(newBean.getFProName())){//项目名称
				str = "项目名称";
				oldValue = oldBean.getFProName();
				newValue = newBean.getFProName();
				
				updRecord.setColumnName(str);
				updRecord.setOldValue(oldValue);
				updRecord.setNewValue(newValue);
				//保存修改记录
				super.merge(updRecord);
				
				//将新值覆盖旧值用于保存和审批
				oldBean.setFProName(newBean.getFProName());
			}
			if(!oldBean.getFirstLevelName().equals(newBean.getFirstLevelName())){//所属一级项目名称
				str = "所属一级分类名称";
				oldValue = oldBean.getFirstLevelName();
				newValue = newBean.getFirstLevelName();
				
				updRecord.setColumnName(str);
				updRecord.setOldValue(oldValue);
				updRecord.setNewValue(newValue);
				//保存修改记录
				super.merge(updRecord);
				
				//将新值覆盖旧值用于保存和审批
				oldBean.setFirstLevelName(newBean.getFirstLevelName());
			}
			if(!oldBean.getFirstLevelCode().equals(newBean.getFirstLevelCode())){//所属一级分类代码
				//将新值覆盖旧值用于保存和审批
				oldBean.setFirstLevelCode(newBean.getFirstLevelCode());
			}
			if(!oldBean.getSecondLevelName().equals(newBean.getSecondLevelName())){//二级分类名称
				str = "二级分类名称";
				oldValue = oldBean.getSecondLevelName();
				newValue = newBean.getSecondLevelName();
				
				updRecord.setColumnName(str);
				updRecord.setOldValue(oldValue);
				updRecord.setNewValue(newValue);
				//保存修改记录
				super.merge(updRecord);
				
				//将新值覆盖旧值用于保存和审批
				oldBean.setSecondLevelName(newBean.getSecondLevelName());
			}
			if(!oldBean.getSecondLevelCode().equals(newBean.getSecondLevelCode())){//二级分类代码
				//将新值覆盖旧值用于保存和审批
				oldBean.setSecondLevelCode(newBean.getSecondLevelCode());
				
				//资金来源名称
				String selectCode = "";
				if("4001".equals(newBean.getSecondLevelCode())){
	     			selectCode = "0";
	     		}else if("4002".equals(newBean.getSecondLevelCode())){
	     			selectCode = "4";
	     		}else if("4003".equals(newBean.getSecondLevelCode())){
	     			selectCode = "1";
	     		}
				//修改资金来源类型
				TProBasicFunds funds = tProBasicFundsMng.getByProId(oldBean.getFProId()).get(0);
				funds.setFundsSource(selectCode);
				super.saveOrUpdate(funds);
			}
			if(!oldBean.getPlanStartYear().equals(newBean.getPlanStartYear())){//开始执行年份
				str = "开始执行年份";
				oldValue = oldBean.getPlanStartYear();
				newValue = newBean.getPlanStartYear();
				
				updRecord.setColumnName(str);
				updRecord.setOldValue(oldValue);
				updRecord.setNewValue(newValue);
				//保存修改记录
				super.merge(updRecord);
				
				//将新值覆盖旧值用于保存和审批
				oldBean.setPlanStartYear(newBean.getPlanStartYear());
			}
			if(!oldBean.getHeaderPhone().equals(newBean.getHeaderPhone())){//负责人电话
				str = "负责人电话";
				oldValue = oldBean.getHeaderPhone();
				newValue = newBean.getHeaderPhone();
				
				updRecord.setColumnName(str);
				updRecord.setOldValue(oldValue);
				updRecord.setNewValue(newValue);
				//保存修改记录
				super.merge(updRecord);
				
				//将新值覆盖旧值用于保存和审批
				oldBean.setHeaderPhone(newBean.getHeaderPhone());
			}
			if(oldBean.getFProOrBasic()==2 && newBean.getFProOrBasic()==2){
				if(!oldBean.getBigProId().equals(newBean.getBigProId())){//大项目名称
					str = "大项目名称";
					oldValue = oldBean.getBigProName();
					newValue = newBean.getBigProName();
					
					updRecord.setColumnName(str);
					updRecord.setOldValue(oldValue);
					updRecord.setNewValue(newValue);
					//保存修改记录
					super.merge(updRecord);
					
					//将新值覆盖旧值用于保存和审批
					oldBean.setBigProId(newBean.getBigProId());
					oldBean.setBigProName(newBean.getBigProName());
				}
			}
			//Doulbe类型用==比较存在精度差异，所以先转换成string类型比较
			if(!String.valueOf(oldBean.getFProBudgetAmount()).equals(String.valueOf(newBean.getFProBudgetAmount()))){//项目预算金额	
				str = "项目预算金额";
				oldValue = String.valueOf(oldBean.getFProBudgetAmount());
				newValue = String.valueOf(newBean.getFProBudgetAmount());
				
				updRecord.setColumnName(str);
				updRecord.setOldValue(oldValue);
				updRecord.setNewValue(newValue);
				//保存修改记录
				super.merge(updRecord);
				
				//将新值覆盖旧值用于保存和审批
				oldBean.setFProBudgetAmount(newBean.getFProBudgetAmount());
				
				//修改资金来源金额
				TProBasicFunds funds = tProBasicFundsMng.getByProId(oldBean.getFProId()).get(0);
				funds.setAmount(newBean.getFProBudgetAmount().multiply(BigDecimal.valueOf(10000)));
				super.saveOrUpdate(funds);
			}
			if(!oldBean.getTotalityDescribe().equals(newBean.getTotalityDescribe())){//总体目标
				str = "总体目标";
				oldValue = oldBean.getTotalityDescribe();
				newValue = newBean.getTotalityDescribe();
				
				updRecord.setColumnName(str);
				updRecord.setOldValue(oldValue);
				updRecord.setNewValue(newValue);
				//保存修改记录
				super.merge(updRecord);
				
				//将新值覆盖旧值用于保存和审批
				oldBean.setTotalityDescribe(newBean.getTotalityDescribe());
			}
			if(!oldBean.getFProAccording().equals(newBean.getFProAccording())){//立项依据
				str = "立项依据";
				oldValue = oldBean.getFProAccording();
				newValue = newBean.getFProAccording();
						
				updRecord.setColumnName(str);
				updRecord.setOldValue(oldValue);
				updRecord.setNewValue(newValue);
				//保存修改记录
				super.merge(updRecord);
				
				//将新值覆盖旧值用于保存和审批
				oldBean.setFProAccording(newBean.getFProAccording());
			}
			if(!oldBean.getFExplain().equals(newBean.getFExplain())){//项目实施方案
				str = "项目实施方案";
				oldValue = oldBean.getFExplain();
				newValue = newBean.getFExplain();
						
				updRecord.setColumnName(str);
				updRecord.setOldValue(oldValue);
				updRecord.setNewValue(newValue);
				//保存修改记录
				super.merge(updRecord);
				
				//将新值覆盖旧值用于保存和审批
				oldBean.setFExplain(newBean.getFExplain());
			}
			
			// 保存项目 绩效指标
			JSONArray jsonArr = JSONArray.fromObject("[" + totalityPerformanceJson.toString()+ "]");
			List<PerformanceIndicatorModel> indexList = JSONArray.toList(jsonArr, PerformanceIndicatorModel.class);
			performancModelMng.save(newBean.getFProId(), indexList);
		}else if(oldBean.getFProOrBasic()==0 && newBean.getFProOrBasic()==0){//基本支出
			if(!oldBean.getSecondLevelName().equals(newBean.getSecondLevelName())){//二级分类名称
				str = "二级分类名称";
				oldValue = oldBean.getSecondLevelName();
				newValue = newBean.getSecondLevelName();
				
				updRecord.setColumnName(str);
				updRecord.setOldValue(oldValue);
				updRecord.setNewValue(newValue);
				//保存修改记录
				super.merge(updRecord);
				
				//将新值覆盖旧值用于保存和审批
				oldBean.setSecondLevelName(newBean.getSecondLevelName());
			}
			if(!oldBean.getSecondLevelCode().equals(newBean.getSecondLevelCode())){//二级分类代码
				//将新值覆盖旧值用于保存和审批
				oldBean.setSecondLevelCode(newBean.getSecondLevelCode());
				
				//修改资金来源类型
				TProBasicFunds funds = tProBasicFundsMng.getByProId(oldBean.getFProId()).get(0);
				funds.setFundsSource("0");
				super.saveOrUpdate(funds);
			}
			if(!oldBean.getPlanStartYear().equals(newBean.getPlanStartYear())){//开始执行年份
				str = "开始执行年份";
				oldValue = oldBean.getPlanStartYear();
				newValue = newBean.getPlanStartYear();
				
				updRecord.setColumnName(str);
				updRecord.setOldValue(oldValue);
				updRecord.setNewValue(newValue);
				//保存修改记录
				super.merge(updRecord);
				
				//将新值覆盖旧值用于保存和审批
				oldBean.setPlanStartYear(newBean.getPlanStartYear());
			}
			if(!oldBean.getHeaderPhone().equals(newBean.getHeaderPhone())){//负责人电话
				str = "负责人电话";
				oldValue = oldBean.getHeaderPhone();
				newValue = newBean.getHeaderPhone();
				
				updRecord.setColumnName(str);
				updRecord.setOldValue(oldValue);
				updRecord.setNewValue(newValue);
				//保存修改记录
				super.merge(updRecord);
				
				//将新值覆盖旧值用于保存和审批
				oldBean.setHeaderPhone(newBean.getHeaderPhone());
			}
			//Doulbe类型用==比较存在精度差异，所以先转换成string类型比较
			if(!String.valueOf(oldBean.getFProBudgetAmount()).equals(String.valueOf(newBean.getFProBudgetAmount()))){//基本支出预算金额
				str = "基本支出预算金额";
				oldValue = String.valueOf(oldBean.getFProBudgetAmount());
				newValue = String.valueOf(newBean.getFProBudgetAmount());
				
				updRecord.setColumnName(str);
				updRecord.setOldValue(oldValue);
				updRecord.setNewValue(newValue);
				//保存修改记录
				super.merge(updRecord);
				
				//将新值覆盖旧值用于保存和审批
				oldBean.setFProBudgetAmount(newBean.getFProBudgetAmount());
				
				//修改资金来源金额
				TProBasicFunds funds = tProBasicFundsMng.getByProId(oldBean.getFProId()).get(0);
				funds.setAmount(newBean.getFProBudgetAmount().multiply(BigDecimal.valueOf(10000)));
				super.saveOrUpdate(funds);
			}
		}
		//保存项目基本信息
		super.saveOrUpdate(oldBean);
		
		//保存附件信息
		attachmentMng.joinEntity(oldBean, lxyjFiles);
		attachmentMng.joinEntity(oldBean, ssfaFiles);
		
		String strdelIndex[] = delIndex.split(",");
		List<TProExpendDetail> expendList = newBean.getExpendList();
		// 保存项目支出明细
		tProExpendDetailMng.save(oldBean.getFProId(), expendList);
		return oldBean;
	}

	@Override
	public Pagination proLibTypePageList(TProBasicInfo bean, Integer pageNo, Integer pageSize, User user) {
 		Finder finder = Finder.create(" from TProBasicInfo t1 where (FExt1 IS NULL OR FExt1!='0') and (F_STAUTS IS NULL OR F_STAUTS!='99')");
		//查询条件
		if(!StringUtil.isEmpty(bean.getFProCode())) {//项目编码
			finder.append(" and t1.FProCode like :fProCode").setParam("fProCode", "%" + bean.getFProCode() + "%");
		}
		if(!StringUtil.isEmpty(bean.getFProName())) {//名称
			finder.append(" and t1.FProName like :name").setParam("name", "%" + bean.getFProName() + "%");
		}
		if(!StringUtils.isEmpty(bean.getFProLibType())) {//库别
			finder.append(" and t1.FProLibType = :FProLibType").setParam("FProLibType", bean.getFProLibType());
		}
		//审批状态
		if(!StringUtil.isEmpty(bean.getFFlowStauts())) {
			if("11".equals(bean.getFFlowStauts())) {
				finder.append(" and t1.FFlowStauts in('19')");
			}
		}
		//普通岗位只能查看自己的
		finder.append(" and t1.FProAppliPeopleId = :FProAppliPeopleId").setParam("FProAppliPeopleId", user.getId());
		//被关联完项目支出明细的项目不在采购预算明细list中显示
		finder.append(" and t1.FProId in(select FProId from TProExpendDetail where pid not in(select pid FROM ProcurementPlan where pid is not null))");
		finder.append(" order by updateTime desc");
		Pagination p = super.find(finder, pageNo, pageSize);
		List<TProBasicInfo> list = (List<TProBasicInfo>) p.getList();
		for(int i = 0; i < list.size(); i++) {
			list.get(i).setPageOrder(i+1);
		}
		p.setList(list);
		return p;
	}
	
	
	@Override
	public List<BigProjectInfo> findByFpId(String id) {
		Finder finder = Finder.create(" FROM BigProjectInfo WHERE stauts<>99");
		if(!StringUtil.isEmpty(String.valueOf(id))){
			finder.append(" AND pid ="+id);
		}
		finder.append(" order by pid desc");
		return super.find(finder);
	}
	
	@Override
	public List<Lookups> getBigProjectLookupsJson(String selected) {
		List<Lookups> list = new ArrayList<Lookups>();
		selected = StringUtil.isEmpty(selected)?null:selected;
		List<BigProjectInfo> brlist = this.findByFpId(selected);
		for (int i = 0; i < brlist.size(); i++) {
			Lookups lookups = new Lookups();
			BigProjectInfo big = brlist.get(i);
			lookups.setCode(String.valueOf(big.getPid()));
			lookups.setName(big.getpName());
			list.add(lookups);
		}
		return list;
	}
	
	@Override
	public Pagination zxmList(TProBasicInfo bean,
			int pageNo, int pageSize,User user) {
		Finder finder = null;
		finder = Finder.create("  FROM TProBasicInfo WHERE FProLibType = '5' and FFlowStauts ='19' and zxmImportStatus <>1");
		if(!StringUtil.isEmpty(bean.getBigProName())){
			finder.append(" and bigProName like '%"+bean.getBigProName()+"%' ");
		}
		if(!StringUtil.isEmpty(bean.getFProName())){
			finder.append(" and FProName like '%"+bean.getFProName()+"%' ");
		}
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}
	
	public void importZxm(Integer fProId, User user)  throws Exception{
		TProBasicInfo oldBean =projectMng.findById(fProId);
		oldBean.setZxmImportStatus("1");
		super.saveOrUpdate(oldBean);
		User applyser =userMng.findById(oldBean.getFProAppliPeopleId());
		TProBasicInfo bean = new TProBasicInfo();
		BeanUtils.copyProperties(oldBean, bean);
		bean.setFProId(null);
		bean.setFProOrBasic(1);
		bean.setFFlowStauts("11");
		bean.setZxmImportStatus(null);
		bean.setZxmId(oldBean.getFProId());
		//设置所属库
		bean.setFProLibType("1");
		//设置日期
		Date date = new Date();
		//设置常规信息
		if (bean.getFProId()==null) {//新增
			//创建人、 创建时间、申请人、申请部门
			bean.setCreator(applyser.getName());
			bean.setCreateTime(date);

			bean.setFProAppliTime(date);
			bean.setFProAppliPeopleId(applyser.getId());
			bean.setFProAppliPeople(applyser.getName());
			bean.setFProAppliDepartId(applyser.getDpID());
			bean.setFProAppliDepart(applyser.getDepartName());

			//保存常规信息--获取项目id
			bean = (TProBasicInfo) super.saveOrUpdate(bean);

			//项目编码
			String idCode=StringUtil.autoGenericCode(String.valueOf(bean.getFProId()), 6);
			String proCode=bean.getFirstLevelCode()+"-"+bean.getSecondLevelCode()+"-"+applyser.getDepart().getCode()+"-"+idCode;     //一级编码+二级编码+部门+ID自增的6位数
			bean.setFProCode(proCode);

			//更新常规信息
			bean = (TProBasicInfo) super.saveOrUpdate(bean);
		}else {//修改
			//修改人、修改时间
			bean.setUpdator(applyser.getName());
			bean.setUpdateTime(date);

			//保存修改后的信息
			super.updateDefault(bean);
		}
		//置顶操作
		setTopOne(bean);

		//送审
		//设置业务范围
		String ywfw = null;
		if(bean.getFProOrBasic()==0){
			ywfw = "JBZCSB";
		}else if(bean.getFProOrBasic()==1){
			ywfw = "XMSB";
		}else if(bean.getFProOrBasic()==2){
			ywfw = "ZXMSB";
		}
		//得到第一个审批节点key
		Integer firstKey=tProcessCheckMng.addProcessCheck(applyser.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), ywfw, applyser);
		//根据资源名称和当前登陆者所属部门查询对应工作流
		TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode(ywfw, applyser.getDpID());
		Integer flowId=processDefin.getFPId();
		TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
		User nextUser=userMng.findById(node.getUserId());
		//设置下节点处理人
		bean.setNextAssignerName(nextUser.getName());
		bean.setNextAssignerCode(nextUser.getId());
		bean.setFExt11(firstKey+"");//设置下节点编码
		//把历史审批记录全部设置为1，表示重新审批
		tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());

		//设置收报状态
		if(nextUser != null && nextUser.getRoleName().contains("预算管理岗")){
			bean.setFExportStauts(2);//已经到达预算管理岗 审批了，他就可以开始进行报表收报
		}else {
			bean.setFExportStauts(0);
		}

		//更新常规信息
		super.updateDefault(bean);

		//添加审批人个人首页代办信息
		PersonalWork work = new PersonalWork();
		work.setUserId(bean.getNextAssignerCode());//任务处理人ID既是下节点处理人ID
		work.setTaskId(bean.getFProId());//项目ID
		work.setTaskCode(bean.getFProCode());//项目编号
		if(bean.getFProOrBasic()==0){
			work.setTaskName("[基本支出申报]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
		}else if(bean.getFProOrBasic()==2) {
			work.setTaskName("[子项目申报]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
		}else {
			work.setTaskName("[项目申报]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
		}
		work.setUrl("/project/verdict/"+bean.getFProId());//审批地址
		work.setUrl1("/project/detail/"+bean.getFProId());//查看地址（审批完成时使用）
		work.setTaskStauts("0");//待办
		work.setBeforeUser(applyser.getName());//任务提交人姓名
		work.setBeforeDepart(applyser.getDepartName());//任务提交人所属部门名称
		work.setBeforeTime(date);//任务提交时间
		work.setType("1");//任务类型（1审批）
		personalWorkMng.merge(work);

		//添加申请人的个人首页已办信息
		PersonalWork work2 = new PersonalWork();
		work2.setUserId(applyser.getId());//任务处理人ID既是申请人的ID
		work2.setTaskId(bean.getFProId());//项目ID
		work2.setTaskCode(bean.getFProCode());//项目编号
		if(bean.getFProOrBasic()==0){
			work2.setTaskName("[基本支出申报]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
		}else if(bean.getFProOrBasic()==2) {
			work2.setTaskName("[子项目申报]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
		}else {
			work2.setTaskName("[项目申报]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
		}
		work2.setUrl("/project/edit/"+bean.getFProId());//退回修改地址（被退回时使用）
		work2.setUrl1("/project/detail/"+bean.getFProId());//查看地址
		work2.setUrl2("/project/delete/"+bean.getFProId());//删除地址（被退回时使用）
		work2.setTaskStauts("2");//已办
		work2.setBeforeUser(applyser.getName());//任务提交人姓名
		work2.setBeforeDepart(applyser.getDepartName());//任务提交人所属部门名称
		work2.setBeforeTime(date);//任务提交时间
		work2.setFinishTime(bean.getCreateTime());
		work2.setType("2");//任务类型（1查看）
		personalWorkMng.merge(work2);
		//保存附件信息
		List<Attachment> newAttaList = new ArrayList<Attachment>();
		List<Attachment> attaList = attachmentMng.list(oldBean);
		if(attaList!=null&&attaList.size()>0){
			for (Attachment attachment : attaList) {
				Attachment newAttachment =new Attachment();
				BeanUtils.copyProperties(attachment, newAttachment);
				newAttachment.setId(null);
				newAttachment.setEntryId(bean.getEntryId());
				attachmentMng.save(newAttachment);
			}
		}

		//保存项目支出明细
		//String strdelIndex[] = delIndex.split(",");
		List<TProExpendDetail> expendList = tProExpendDetailMng.getByProId(oldBean.getFProId());
		List<TProExpendDetail> newExpendList =new ArrayList<TProExpendDetail>();
		if(expendList!=null&&expendList.size()>0){
			for (TProExpendDetail tProExpendDetail : expendList) {
				TProExpendDetail newTProExpendDetail =new TProExpendDetail();
				BeanUtils.copyProperties(tProExpendDetail, newTProExpendDetail);
				newTProExpendDetail.setPid(null);
				newExpendList.add(newTProExpendDetail);
			}
			tProExpendDetailMng.save(bean.getFProId(), newExpendList);
		}

		//保存项目计划
		//tProPlanMng.save(bean.getPlanList(), user, info);20190523  页面已经删除项目计划

		//保存项目绩效目标总表
		//TProGoal goal = tProGoalMng.save(bean.getGoal(), info, user);20190523页面已经删除项目绩效目标

		//保存资金来源明细
		
		List<TProBasicFunds> fundsList = tProBasicFundsMng.findByProperty("FProId", oldBean.getFProId());
		List<TProBasicFunds> newFundsList = new ArrayList<TProBasicFunds>();
		if(fundsList!=null&&fundsList.size()>0){
			for (TProBasicFunds tProBasicFunds : fundsList) {
				TProBasicFunds newTProBasicFunds =new TProBasicFunds();
				BeanUtils.copyProperties(tProBasicFunds, newTProBasicFunds);
				newTProBasicFunds.setId(null);
				newFundsList.add(newTProBasicFunds);
			}
			tProBasicFundsMng.save(bean,newFundsList);
		}

		//保存项目绩效指标
		List<PerformanceIndicatorModel> indexList = performancModelMng.findByProperty("fProId", fProId);
		List<PerformanceIndicatorModel> newIndexList = new ArrayList<PerformanceIndicatorModel>();
		if(indexList!=null&&indexList.size()>0){
			for (PerformanceIndicatorModel performanceIndicatorModel : indexList) {
				PerformanceIndicatorModel newPerformanceIndicatorModel =new PerformanceIndicatorModel();
				BeanUtils.copyProperties(performanceIndicatorModel, newPerformanceIndicatorModel);
				newPerformanceIndicatorModel.settPId(null);
				newIndexList.add(newPerformanceIndicatorModel);
			}
			performancModelMng.save(bean.getFProId(),newIndexList);
		}
	}
	
	@Override
	public List<ExecuteProject> zzxmList(String id) {
		Finder finder = Finder.create(" from ExecuteProject where fzxxmId ='"+id+"'");
		return super.find(finder);
	}
	
	@Override
	public Pagination deptList(Depart bean, String sort, String order,
			int pageIndex, int pageSize) {
		// TODO Auto-generated method stub
		Finder f=Finder.create("from Depart Where flag='1' and code != '10000'");
		if(null!=bean){
			if(!StringUtil.isEmpty(bean.getName())){
				f.append(" and name like :name");
				f.setParam("name","%"+bean.getName()+"%");
			}
			if(!StringUtil.isEmpty(bean.getCode())){
				f.append(" and code like :code");
				f.setParam("code","%"+bean.getCode()+"%");
			}
			if(!StringUtil.isEmpty(bean.getId())){
				f.append(" and id = :id");
				f.setParam("id",bean.getId());
			}
		}
		if(!StringUtil.isEmpty(sort)){
			f.append(" order by " + sort );
		}else{
			f.append(" order by   CONVERT(orderNo,SIGNED)");
		}
		if(!StringUtil.isEmpty(order)){
			
		}else{
			f.append(" asc");
		}
		return super.find(f, pageIndex, pageSize);
	}
	
	@Override
	public void saveDept(String id, String ids) {
		getSession().createSQLQuery("delete from xm_dept where F_XMID ="+id+"").executeUpdate();
		String[] split = ids.split(",");
		for (int i = 0; i < split.length; i++) {
			XmDept xmDept = new XmDept();
			xmDept.setFxmid(id);
			xmDept.setFdeptid(split[i]);
			xmDeptMng.saveOrUpdate(xmDept);
		}
	}
	
	@Override
	public List<XmDept> xmDeptList(String id) {
		Finder finder = Finder.create(" from XmDept where fxmid ='"+id+"'");
		return super.find(finder);
	}
}
