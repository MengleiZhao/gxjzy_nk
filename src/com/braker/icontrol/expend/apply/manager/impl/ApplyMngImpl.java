package com.braker.icontrol.expend.apply.manager.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.hibernate.SQLQuery;
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
import com.braker.common.util.StringUtil;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
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
import com.braker.icontrol.expend.apply.manager.ApplyAttacMng;
import com.braker.icontrol.expend.apply.manager.ApplyCheckMng;
import com.braker.icontrol.expend.apply.manager.ApplyMng;
import com.braker.icontrol.expend.apply.manager.BudgetMessageListMng;
import com.braker.icontrol.expend.apply.manager.FeteCostInfoMng;
import com.braker.icontrol.expend.apply.manager.FoodAllowanceInfoMng;
import com.braker.icontrol.expend.apply.manager.HotelExpenseInfoMng;
import com.braker.icontrol.expend.apply.manager.InternationalTravelingExpenseInfoMng;
import com.braker.icontrol.expend.apply.manager.TravelAppliInfoMng;
import com.braker.icontrol.expend.apply.model.AbroadAppliInfo;
import com.braker.icontrol.expend.apply.model.AbroadAppliPepoleInfo;
import com.braker.icontrol.expend.apply.model.AbroadExpenseInfo;
import com.braker.icontrol.expend.apply.model.AbroadPlan;
import com.braker.icontrol.expend.apply.model.ApplicationAttac;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.apply.model.ApplicationDetail;
import com.braker.icontrol.expend.apply.model.BudgetMessageList;
import com.braker.icontrol.expend.apply.model.FeteCostInfo;
import com.braker.icontrol.expend.apply.model.FoodAllowanceInfo;
import com.braker.icontrol.expend.apply.model.HotelExpenseInfo;
import com.braker.icontrol.expend.apply.model.InCityTrafficInfo;
import com.braker.icontrol.expend.apply.model.InternationalTravelingExpense;
import com.braker.icontrol.expend.apply.model.LecturerInfo;
import com.braker.icontrol.expend.apply.model.MeetPlan;
import com.braker.icontrol.expend.apply.model.MeetingAppliInfo;
import com.braker.icontrol.expend.apply.model.MiscellaneousFeeInfo;
import com.braker.icontrol.expend.apply.model.OfficeCar;
import com.braker.icontrol.expend.apply.model.OutsideTrafficInfo;
import com.braker.icontrol.expend.apply.model.ReceptionAppliInfo;
import com.braker.icontrol.expend.apply.model.ReceptionFood;
import com.braker.icontrol.expend.apply.model.ReceptionHotel;
import com.braker.icontrol.expend.apply.model.ReceptionObservePlan;
import com.braker.icontrol.expend.apply.model.ReceptionOther;
import com.braker.icontrol.expend.apply.model.ReceptionPeopleInfo;
import com.braker.icontrol.expend.apply.model.StudentsList;
import com.braker.icontrol.expend.apply.model.TrainTeacherCost;
import com.braker.icontrol.expend.apply.model.TrainingAppliInfo;
import com.braker.icontrol.expend.apply.model.TravelAppliInfo;
import com.braker.icontrol.expend.apply.model.TravelPeopleInfo;
import com.braker.icontrol.expend.standard.entity.HotelStandard;
import com.braker.icontrol.expend.standard.manager.HotelStandardMng;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 事前申请的service实现类
 * @author 叶崇晖
 * @createtime 2018-06-12
 * @updatetime 2018-06-12
 */
@Service
@Transactional
public class ApplyMngImpl extends BaseManagerImpl<ApplicationBasicInfo> implements ApplyMng {
	
	
	@Autowired
	private ApplyCheckMng checkMng;
	@Autowired
	private ApplyAttacMng attacMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private UserMng userMng;
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
	private PrivateInforMng privateInforMng;
	@Autowired
	private HotelStandardMng hotelStandardMng;
	@Autowired
	private TravelAppliInfoMng travelAppliInfoMng;
	@Autowired
	private TProBasicInfoMng tProBasicInfoMng;
	@Autowired
	private InternationalTravelingExpenseInfoMng internationalTravelingExpenseInfoMng;
	@Autowired
	private HotelExpenseInfoMng hotelExpenseInfoMng;
	@Autowired
	private FoodAllowanceInfoMng foodAllowanceInfoMng;
	@Autowired
	private FeteCostInfoMng feteCostInfoMng;
	@Autowired
	private BudgetMessageListMng budgetMessageListMng;
	@Autowired
	private TProBasicInfoMng projectMng;
	@Autowired
	private TProExpendDetailMng tProExpendDetailMng;
	
	/*
	 * 分页查询
	 * @author 叶崇晖
	 * @createtime 2018-06-12
	 * @updatetime 2018-06-12
	 */
	@Override
	public Pagination pageList(ApplicationBasicInfo bean, int pageNo, int pageSize, Integer type, User user) {
		//查询条件
		Finder finder = Finder.create(" FROM ApplicationBasicInfo WHERE stauts in('1','0') AND user='"+user.getId()+"' AND type="+type);
		if (!StringUtil.isEmpty(String.valueOf(bean.getgCode()))) {
			finder.append(" AND gCode LIKE '%"+bean.getgCode()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getgName()))) {
			finder.append(" AND gName LIKE '%"+bean.getgName()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getReqTime1()))) {
			/*finder.append(" AND datediff(reqTime,'"+bean.getReqTime()+"')=0 ");*/
			finder.append(" AND DATE_FORMAT(reqTime,'%Y-%m-%d') >= '"+bean.getReqTime1()+"'");//日期去时分秒函数
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getReqTime2()))) {
			/*finder.append(" AND datediff(reqTime,'"+bean.getReqTime()+"')=0 ");*/
			finder.append(" AND DATE_FORMAT(reqTime,'%Y-%m-%d') <= '"+bean.getReqTime2()+"'");//日期去时分秒函数
		}
		/*if (!StringUtil.isEmpty(bean.getFlowStauts())) {
			if(bean.getFlowStauts().equals("暂存")) {
				finder.append(" and flowStauts = '0'");
			}
			if(bean.getFlowStauts().equals("待审批")) {
				finder.append(" and flowStauts = '1'");
			}
			if(bean.getFlowStauts().equals("审批中")) {
				finder.append(" and flowStauts in('2','3','4','5','6','7','8')");
			}
			if(bean.getFlowStauts().equals("已审批")) {
				finder.append(" and flowStauts = '9'");
			}
			if(bean.getFlowStauts().equals("已退回")) {
				finder.append(" and flowStauts = '-1'");
			}
		}*/
		finder.append(" order by reqTime desc ");
		//设置其他属性
		Pagination p = super.find(finder, pageNo, pageSize);
		List<ApplicationBasicInfo> li = (List<ApplicationBasicInfo>) p.getList();
		for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(pageNo-1)*pageSize);
			//设置申请人姓名（id查姓名）,申请人所属部门
			User u = userMng.findById(li.get(x).getUser());
			li.get(x).setUserName(u.getName());
		}
		return p;
	}
	
	/*
	 * 事前申请新增和修改的保存
	 * @author 叶崇晖
	 * @createtime 2018-06-12
	 * @updatetime 2018-06-12
	 */
	@Override
	public void save(ApplicationBasicInfo bean, MeetingAppliInfo meetingBean, TrainingAppliInfo trainingBean,
			TravelAppliInfo travelBean, ReceptionAppliInfo receptionBean,OfficeCar officeBean,
			AbroadAppliInfo abroadBean, String mingxi, User user,String recePeop,String files)  throws Exception{
		
		/** 保存基本属性 **/
		
		//设置属性
		Date d = new Date();
		bean.setReqTime(d);//申请时间
		bean.setUser(user.getId());//申请人id
		bean.setDept(user.getDepart().getId());//申请人所属部门id
		bean.setDeptName(user.getDepartName());//申请人所属部门名称
		if (bean.getgId()==null) {
			//创建人、创建时间、申请单编号
			bean.setCreator(user.getAccountNo());
			bean.setCreateTime(d);
			bean.setgCode(StringUtil.Random(""));//编码不需要加SQ
		} else {
			//修改人、修改时间
			bean.setUpdator(user.getAccountNo());
			bean.setUpdateTime(d);
		}
		
		
		/** 保存基本信息 **/
		//转换type选择流程
		String strType = tProcessCheckMng.JudgmentProcess(String.valueOf(bean.getType()));
		if(bean.getType().equals("1")){
			if ("1".equals(bean.getFcostType())) {
				strType = "RYJFJBGZ";
			}
			if ("2".equals(bean.getFcostType())) {
				strType = "RYJFJX";
			}
			if ("3".equals(bean.getFcostType())) {
				strType = "TYSXSQ";
			}
			if ("4".equals(bean.getFcostType())) {
				strType = "BMRCBG";
			}
			if ("5".equals(bean.getFcostType())) {
				strType = "BMRCLW";
			}
			if ("6".equals(bean.getFcostType())) {
				strType = "YGCGSG";
			}
			if ("7".equals(bean.getFcostType())) {
				strType = "YGCGKY";
			}
			if ("8".equals(bean.getFcostType())) {
				TProBasicInfo basicInfo = tProBasicInfoMng.findById(bean.getProId());
				if ("1".equals(basicInfo.getIfScientificPro())) {
					strType = "KYJF";
				}else {
					strType = "JYJF";
				}
			}
			if ("9".equals(bean.getFcostType())) {
				strType = "QTGYJF";
			}
		}
		//工作流的节点配置（状态1和2可以继续走审批流，该状态不会变）
		if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
			Integer flowId =0;
			User nextUser = new User();
			/*if("1".equals(bean.getType())){
				nextUser = userMng.findById(bean.getFuserId());
			}else {*/
			
			/*if("1".equals(bean.getType())){
				nextUser = userMng.findById(bean.getFuserId());
			}else {*/
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), strType, user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode(strType, user.getDpID());
			flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			if(StringUtil.isEmpty(node.getText())){//如果是专用经费申请，则通过预算项目的id来获取预算项目的部门负责人
				if(!StringUtil.isEmpty(String.valueOf(bean.getProId()))){
					if (("KYJF").equals(strType) || ("JYJF").equals(strType)) {
						TProBasicInfo basicInfo = tProBasicInfoMng.findById(bean.getProId());//如果是专用经费申请，则通过预算项目的id来获取预算项目的部门负责人
						nextUser = userMng.findById(Integer.valueOf(basicInfo.getFProHeadId()));
					}else {
						TProBasicInfo basicInfo = tProBasicInfoMng.findById(bean.getProId());
						nextUser = userMng.getUserByRoleNameAndDepartName("部门负责人", basicInfo.getFProAppliDepart());
					}
				}
			}else{
				nextUser=userMng.findById(node.getUserId());
			}
			//设置下节点处理人姓名和编号		
			bean.setUserName2(nextUser.getName());
			bean.setFuserId(nextUser.getId());
			//设置下节点节点编码
			bean.setnCode(firstKey+"");	
			/*}*/
			
			/*}*/
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			//保存基本信息
			bean = (ApplicationBasicInfo) super.saveOrUpdate(bean);
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getgId());//申请单ID
			work.setTaskCode(bean.getgCode());//为申请单的单号
			String taskName = "";
			if("1".equals(bean.getType())) {
				taskName = "[通用事项申请]" + bean.getgName();
			} else if("2".equals(bean.getType())) {
				taskName = "[会议申请]" + bean.getgName();
			} else if("3".equals(bean.getType())) {
				taskName = "[举办培训申请]" + bean.getgName();
			} else if("4".equals(bean.getType())) {
				taskName = "[差旅申请]" + bean.getgName();
			} else if("5".equals(bean.getType())) {
				taskName = "[公务接待申请]" + bean.getgName();
			} else if("6".equals(bean.getType())) {
				taskName = "[公务用车申请]" + bean.getgName();
			} else if("7".equals(bean.getType())) {
				taskName = "[公务出国申请]" + bean.getgName();
			}
			work.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/applyCheck/check?id="+bean.getgId()+"&applyType="+bean.getType());//审批url
			work.setUrl1("/apply/edit?id="+ bean.getgId()+"&editType=0&applyType="+bean.getType());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setTaskType("1");//任务归属（1审批人）
			work.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work.setBeforeTime(d);//任务提交时间
			personalWorkMng.merge(work);
			
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(bean.getgId());//申请单ID
			work2.setTaskCode(bean.getgCode());//为申请单的单号
			work2.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/apply/edit?id="+ bean.getgId()+"&editType=1&applyType="+bean.getType());//退回修改url
			work2.setUrl1("/apply/edit?id="+ bean.getgId()+"&editType=0&applyType="+bean.getType());//查看url
			work2.setUrl2("/apply/delete?id="+ bean.getgId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setTaskType("0");//任务归属（0发起人）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work2.setBeforeTime(d);//任务提交时间
			work2.setFinishTime(d);
			personalWorkMng.merge(work2);
			
			List mxList = getMingXiJson(mingxi, ApplicationDetail.class);
			//计算明细申请金额总数
			Double num = 0.0;
			for (int i = 0; i < mxList.size(); i++) {
				ApplicationDetail mx = (ApplicationDetail) mxList.get(i);
				if(mx.getApplySum() != null) {
					num += mx.getApplySum();
				}
			}
			budgetIndexMgrMng.addDjAmount(bean.getIndexId(),bean.getProDetailId(),BigDecimal.valueOf(num));
		} else {
			//保存基本信息
			bean = (ApplicationBasicInfo) super.saveOrUpdate(bean);
		}
		
		/** 保存附件 **/
		
		//保存附件信息
		attachmentMng.joinEntity(bean,files);
		
		/** 保存明细信息 **/
		
		//删除数据库中   申请中
		getSession().createSQLQuery("delete from T_APPLI_DETAIL where F_G_ID ="+bean.getgId()+" and F_STATUS=0").executeUpdate();
			if(!StringUtil.isEmpty(mingxi)){
			//获取Json对象
			List<ApplicationDetail> foodAllowanceList = JSON.parseObject("["+mingxi.toString()+"]",new TypeReference<List<ApplicationDetail>>(){});
			for (ApplicationDetail applicationDetail: foodAllowanceList) {
				ApplicationDetail info = new ApplicationDetail();
				info.setgId(bean.getgId());
				info.setCostDetail(applicationDetail.getCostDetail());
				info.setApplySum(applicationDetail.getApplySum());
				info.setRemark(applicationDetail.getRemark());
				info.setfStatus(0);
				super.merge(info);
			}
		}
	}
	
	/*
	 * 事前申请删除
	 * @author 叶崇晖
	 * @createtime 2018-06-12
	 * @updatetime 2018-06-12
	 */
	@Override
	public void delete(Integer id,User user,String fId) {
		//事前申请的状态为99（删除）
		//PersonalWork pwork = personalWorkMng.findById(Integer.valueOf(fId));
		if(fId!=null){
			personalWorkMng.deleteById(Integer.valueOf(fId));
		}
		personalWorkMng.sendMessageToUser(user.getId(), 0);
		getSession().createSQLQuery("UPDATE t_application_basic_info SET F_STAUTS=99 WHERE F_G_ID="+id).executeUpdate();
		
	}
	
	/*
	 * 明细查询
	 * @author 叶崇晖
	 * @createtime 2018-06-14
	 * @updatetime 2018-06-14
	 */
	public List<Object> getMingxi(String tableName ,String idName ,Integer id) {
		Finder finder = Finder.create(" FROM " + tableName + " WHERE " + idName + "="+id);
		return super.find(finder);
	}
	
	/*
	 * 获取明细的Json对象
	 * @author 叶崇晖
	 * @createtime 2018-06-14
	 * @updatetime 2018-06-14
	 */
	public List getMingXiJson(String mingxi, Class tableClass) {
		//获取明细的Json对象
		List mx = null;
		JSONArray array =JSONArray.fromObject("["+mingxi.toString()+"]");
		mx = (List)JSONArray.toList(array, tableClass);
		return mx;
	}
	
	
	/*
	 * 查询单一对象的通用方法
	 * @author 叶崇晖
	 * @createtime 2018-06-14
	 * @updatetime 2018-06-14
	 */
	@Override
	public Object getObject(String tableName, String idName, Integer id) {
		Finder finder = Finder.create(" FROM " + tableName + " WHERE " + idName + "="+id);
		List<Object> li = super.find(finder);
		if(li.size()!=0) {
			return li.get(0);
		} else return null;
	}
	
	/*
	 * 查询多个对象的通用方法
	 * @author 叶崇晖
	 * @createtime 2018-06-14
	 * @updatetime 2018-06-14
	 */
	@Override
	public List<Object> getObjectList(String tableName, String idName, Integer id) {
		Finder finder = Finder.create(" FROM " + tableName + " WHERE " + idName + "="+id);
		return super.find(finder);
	}
	
	
	/*
	 * 保存申请附件信息
	 * @author 叶崇晖
	 * @createtime 2018-07-05
	 * @updatetime 2018-07-05
	 */
	@Override
	public void saveApplyAttac(ApplicationAttac attac) {
		super.saveOrUpdate(attac);
	}
	
	/*
	 * 审批分页查询
	 * @author 叶崇晖
	 * @createtime 2018-06-29
	 * @updatetime 2018-06-29
	 */
	@Override
	public Pagination checkPageList(ApplicationBasicInfo bean, int pageNo,int pageSize, User user) {
		//节点的编号为审批状态（暂时数据不准，为认为创造）		get(0)的原因是一个角色应该只能审批一级，所以查出来li应该只有一个数据
		Finder finder = Finder.create(" FROM ApplicationBasicInfo WHERE fuserId='"+user.getId()+"' AND stauts in('1','0')");	
		
		if (!StringUtil.isEmpty(String.valueOf(bean.getgCode()))) {
			finder.append(" AND gCode LIKE '%"+bean.getgCode()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getgName()))) {
			finder.append(" AND gName LIKE '%"+bean.getgName()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getReqTime1()))) {
			finder.append(" AND DATE_FORMAT(reqTime,'%Y-%m-%d') >= '"+bean.getReqTime1()+"'");//日期去时分秒函数
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getReqTime2()))) {
			finder.append(" AND DATE_FORMAT(reqTime,'%Y-%m-%d') <= '"+bean.getReqTime2()+"'");//日期去时分秒函数
		}
		
		finder.append(" order by reqTime desc");//
		return super.find(finder, pageNo, pageSize);
	}

	/*
	 * 台账分页查询
	 * @author 叶崇晖
	 * @createtime 2018-07-06
	 * @updatetime 2018-07-06
	 */
	@Override
	public Pagination ledgerPageList(ApplicationBasicInfo bean, String applyType, int pageNo,int pageSize, User user) {
		Finder finder = Finder.create(" FROM ApplicationBasicInfo WHERE flowStauts='9'");	
		if (!StringUtil.isEmpty(String.valueOf(bean.getgCode()))) {
			finder.append(" AND gCode LIKE '%"+bean.getgCode()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getgName()))) {
			finder.append(" AND gName LIKE '%"+bean.getgName()+"%'");
		}
		String deptIdStr=departMng.getDeptIdStrByUser(user);
 		if("".equals(deptIdStr)){ //普通岗位只能查看自己的
 			finder.append(" and user = :user").setParam("user", user.getId());
 		}else if("all".equals(deptIdStr)){//校长可以查看所有人的
 			
 		}else{//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
 			finder.append(" and dept in ("+deptIdStr+")");
 		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getDeptName()))) {
			finder.append(" AND deptName LIKE '%"+bean.getDeptName()+"%'");
		}
		finder.append(" order by reqTime desc");
		return super.find(finder, pageNo, pageSize);
	}

	
	/**
	 * 查询需要导出的全部台账信息
	 * @author 叶崇晖
	 * @return
	 */
	@Override
	public List<ApplicationBasicInfo> ledgerList(ApplicationBasicInfo bean) {
		Finder finder = Finder.create(" FROM ApplicationBasicInfo WHERE flowStauts='9' AND stauts='1'");	
		if (!StringUtil.isEmpty(String.valueOf(bean.getgCode()))) {
			finder.append(" AND gCode LIKE '%"+bean.getgCode()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getgName()))) {
			finder.append(" AND gName LIKE '%"+bean.getgName()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getDeptName()))) {
			finder.append(" AND deptName LIKE '%"+bean.getDeptName()+"%'");
		}
		return super.find(finder);
	}

	/**
	 * 生成需要导出的台账HSSFWorkbook
	 * @author 叶崇晖
	 * @param ledgerData事前申请基本信息集合List
	 * @param filePath模板位置
	 * @return
	 */
	@Override
	public HSSFWorkbook exportLedger(List<ApplicationBasicInfo> ledgerData, String filePath) {
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
					hssfRow.createCell(1).setCellValue(ledgerData.get(i).getgCode());
					//申请摘要名称
					hssfRow.createCell(2).setCellValue(ledgerData.get(i).getgName());
					//申请事项
					String type="";
					switch (ledgerData.get(i).getType()) {
					case "1":type = "通用事项申请";break;
					case "2":type = "会议申请";break;
					case "3":type = "差旅申请";break;
					case "4":type = "培训申请";break;
					case "5":type = "公务接待申请";break;
					case "6":type = "公务用车申请";break;
					case "7":type = "公务出国申请";break;
					}
					hssfRow.createCell(3).setCellValue(type);
					//申请金额
					hssfRow.createCell(4).setCellValue(ledgerData.get(i).getAmount()!=null?ledgerData.get(i).getAmount().doubleValue():0.0);
					//预算指标
					hssfRow.createCell(5).setCellValue(ledgerData.get(i).getIndexName());
					//申请部门
					hssfRow.createCell(6).setCellValue(ledgerData.get(i).getDeptName());
					//申请人
					User user = userMng.findById(ledgerData.get(i).getUser());
					hssfRow.createCell(7).setCellValue(user!=null?user.getName():"");
					//申请时间
					hssfRow.createCell(8).setCellValue(df.format(ledgerData.get(i).getReqTime()));
					//申请事由
					hssfRow.createCell(9).setCellValue(ledgerData.get(i).getReason());
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
	public List<ApplicationBasicInfo> reimburseList(String applyType, User user,String reqTime) {
		Finder finder = Finder.create(" FROM ApplicationBasicInfo WHERE flowStauts='9'");
		finder.append(" AND type = '"+applyType+"'");
		finder.append(" AND user = '"+user.getId()+"'");
		if(!StringUtil.isEmpty(reqTime)){
			finder.append(" AND DATE_FORMAT(reqTime,'%Y-%m-%d') ='"+reqTime+"'");
		}
		finder.append(" AND (reimbType NOT IN('1','9')  or F_REIMB_TYPE  is null)");
		finder.append(" order by updateTime desc ");
		List<ApplicationBasicInfo> list=super.find(finder);
		if (list != null && list.size() > 0) {
			int i = 0;
			for (ApplicationBasicInfo a: list) {
				i++;
				a.setNum(i);
			}
			return list;
		}		
		return null;
	}

	
	@Override
	public ApplicationBasicInfo findByCode(String code) {
		Finder finder = Finder.create(" FROM ApplicationBasicInfo WHERE gCode='"+code+"'");
		List<ApplicationBasicInfo> list = super.find(finder);
		if(list.size()>0) {
			return list.get(0);
		} else {
			return null;
		}
	}

	@Override
	public List<Object[]> getOutComeSubject(String basicType,
			String parentCode, String year, String qName,String indexType,String proId,String indexName,String deptName) {
	
		//String sql = " SELECT B.F_PRO_CODE,CONCAT(A.F_B_INDEX_NAME,'(',A.F_DEPT_NAME,')') , A.F_B_INDEX_CODE, B.F_PRO_ID "
		String sql = " SELECT B.F_PRO_CODE,A.F_B_INDEX_NAME , A.F_B_INDEX_CODE, B.F_PRO_ID,B.F_PRO_APPLI_DEPART "
		+ " FROM T_BUDGET_INDEX_MGR A"
		+ " INNER JOIN T_PRO_BASIC_INFO B "
		+ " ON A.F_B_INDEX_CODE = B.F_PRO_CODE "
		+ " WHERE A.F_RELEASE_STAUTS='1' "
		+ " AND A.F_YEARS=" + DateUtil.getCurrentYear()//只能获得当年指标
		+ " AND B.F_PRO_ID in("+proId+")";// 
//		+ " AND (A.F_DEPT_CODE ='"+deptId+"' or A.F_DEPT_CODE is null)"; 
		if("0".equals(indexType)){
			sql += " AND A.F_INDEX_TYPE=0";//基本支出
		}else if("1".equals(indexType)){
			sql += " AND A.F_INDEX_TYPE=1";//项目支出
		}
		if(StringUtils.isNotEmpty(indexName)){
			sql += " AND A.F_B_INDEX_NAME LIKE '%"+indexName+"%'";//按照项目名称查询
		}
		sql += " order by case when B.F_PRO_APPLI_DEPART='"+deptName+"' then 0 else B.F_PRO_APPLI_DEPART end  asc";//按照项目名称查询
		SQLQuery query = getSession().createSQLQuery(sql);
		return query.list();
}

	@Override
	public Map<String, Integer> getPidMap(String basicType, String parentCodes,
			String year, String qName) {
		
		/*Map<String,Integer> pidMap=new HashMap<String,Integer>();
		List<Integer> pidList=getPidListByparentCodes(basicType,parentCodes,year,qName);
		if(pidList!=null && pidList.size()>0){
			for(Integer pid:pidList){
				pidMap.put(pid+"", pid);
			}
		}
		return pidMap;*/
		
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
		
		String sql = " SELECT F_PRO_ID FROM T_PRO_EXPEND_DETAIL WHERE 1=1 ";
		
		if (!StringUtil.isEmpty(parentCodes)) {//父节点
			sql = sql + " and F_PRO_ID in (" + parentCodes+" )";
		}
		
		SQLQuery query = getSession().createSQLQuery(sql);
		return query.list();
	}

	@Override
	public List<Object[]> getOutDetail(String projectId) {
		
		String sql = "SELECT a.F_EXP_ID, "	//明细-id
				+ " a.F_SUB_NAME, "			//明细-名称
				+ " a.F_SUB_NUM, "			//明细-编码
				+ " pro.f_pro_head, "		//项目-负责人
				+ " a.F_SY_AMOUNT, "		//明细-剩余金额
				+ " ind.f_b_id, "			//指标-id
				+ " a.F_APPLI_AMOUNT, "		//明细-批复金额						
				+ " ind.F_YEARS, "			//指标-预算年度
				+ " ind.F_DEPT_NAME,"		//指标-使用部门
				+ " a.F_DJ_AMOUNT,"			//指标-冻结金额	9
				+ " ind.F_B_INDEX_NAME,"	//项目名称
				+ " ind.F_B_INDEX_CODE,"	//项目名称CODE
				+ " pro.F_IF_SCIENTIFIC_PRO"//是否科研项目
				+ " "		
				+ " "		
				+ " FROM T_PRO_EXPEND_DETAIL a "
				+ " inner join t_pro_basic_info pro on a.F_PRO_ID = pro.F_PRO_ID "
				+ " inner join t_budget_index_mgr ind on ind.F_B_INDEX_CODE = pro.f_pro_code"
				+ " WHERE 1=1"
				+ " AND a.F_PRO_ID= " + projectId + " ";
			
		SQLQuery query = getSession().createSQLQuery(sql);
		return query.list();	
	}

	@Override
	public String ApplyReCall(Integer id) throws Exception {
		//根据id查询对象
		ApplicationBasicInfo bean=(ApplicationBasicInfo)super.findById(id);
		if(bean.getFlowStauts().equals("-4")){
			throw new ServiceException("该单据已被撤回，请勿重复操作！");
		}
		//转换type选择流程
		String strType = tProcessCheckMng.JudgmentProcess(String.valueOf(bean.getType()));
		//转换type选择流程
		if("4".equals(String.valueOf(bean.getType()))){
			if (StringUtil.isEmpty(bean.getExpenditureType())) {
				strType = "CLSQ";
			}else{
				strType = bean.getExpenditureType();
			}
		}
		
		//查询工作流确定第一个审批节点有没有审批
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),strType,bean.getDept(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getgCode(),"1");
		if(nodeConfList.size()>0){
			Collections.reverse(nodeConfList);
			if("1".equals(String.valueOf(nodeConfList.get(0).getCheckInfo().getFcheckResult()))){
				throw new ServiceException("该单据已被下一级审批人审批，无法执行撤回操作！");
			}
		}else{
			throw new ServiceException("当前审批流错误！无法撤回！");
		}
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="申请被撤回消息";
		String msg="您待审批的  "+bean.getgName() +",任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//归还冻结金额
		if("4".equals(bean.getType())){
			List<BudgetMessageList> list = budgetMessageListMng.findByProperty("gId", bean.getgId());
			for(BudgetMessageList messageList : list){
				if(!StringUtil.isEmpty(messageList.getfCostClassifyShow()) && messageList.getfCostAmount()!=null){
					budgetIndexMgrMng.deleteDjAmount(messageList.getfIndexId(),messageList.getfProDetailId(),messageList.getfCostAmount());
				}
			}
		}else{
			budgetIndexMgrMng.deleteDjAmount(bean.getIndexId(),bean.getProDetailId(),bean.getAmount());
		}
		
		//撤回
		bean=(ApplicationBasicInfo) reCall((CheckEntity) bean);
		this.updateDefault(bean);
		return "操作成功";
	}

	@Override
	public Integer getMaxCodeToday5() {
		//返回当天最大值编码 
		Integer maxNum = 0;
		Finder finder = Finder.create(" select gCode from ApplicationBasicInfo where gCode like '%" + new SimpleDateFormat("yyyyMMdd").format(new Date()) + "%'" 
		+ " AND LENGTH(gCode)=10 ");
		List<String> list = super.find(finder);
		if (list != null && list.size() > 0) {
			for (String str: list) {
				if (str.length() > 6) {
					Integer num = Integer.valueOf(str.substring(str.length() - 6));
					if (num > maxNum) {
						maxNum = num;
					}
				}
			}
		}
		return maxNum;
	}

	@Override
	public String getDraft(Integer applyType, String userName) {
		String typeName = "";
		if (1==applyType) {
			typeName = "通用事项";
		} else if (2==applyType) {
			typeName = "会议";
		} else if (3==applyType) {
			typeName = "举办培训";
		} else if (4==applyType) {
			typeName = "差旅";
		} else if (5==applyType) {
			typeName = "公务接待";
		} else if (6==applyType) {
			typeName = "公车运维";
		} else if (7==applyType) {
			typeName = "公务出国";
		}else if(12==applyType){//12-参加培训
			typeName = "参加培训";
		}
		return userName + " - " + typeName + "申请";
	}
	
	/*
	 * 差旅申请新增和修改的保存
	 * @author 沈帆
	 * @createtime 2020-02-13
	 * @updatetime 2020-02-13
	 */
	@Override
	public void saveTravel(ApplicationBasicInfo bean,
			TravelAppliInfo travelBean, User user,String studentsJson,String travelPeop,String files,
			String outsideTraffic,						//城市间交通费Json
			String inCity,								//市内交通费Json
			String hotelJson,							//住宿费Json
			String otherJson,							//其他费Json
			String otherJsons,
			String indexJsons,							//预算指标Json
			String foodJson								//伙食费Json
			)  throws Exception{
		
		/** 保存基本属性 **/
		//设置属性
		Date d = new Date();
		bean.setReqTime(d);//申请时间
		bean.setUser(user.getId());//申请人id
		bean.setDept(user.getDepart().getId());//申请人所属部门id
		bean.setDeptName(user.getDepartName());//申请人所属部门名称
		if (bean.getgId()==null) {
			//创建人、创建时间、申请单编号
			bean.setCreator(user.getAccountNo());
			bean.setCreateTime(d);
			bean.setgCode(StringUtil.Random(""));//编码不需要加SQ
		} else {
			//修改人、修改时间
			bean.setUpdator(user.getAccountNo());
			bean.setUpdateTime(d);
		}
		/** 保存基本信息 **/
		//转换type选择流程
		String strType = "";
		if (StringUtil.isEmpty(bean.getExpenditureType())) {
			strType = "CLSQ";
		}else{
			strType = bean.getExpenditureType();
		}
		//工作流的节点配置（状态1和2可以继续走审批流，该状态不会变）
		if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
			Integer flowId =0;
			User nextUser = new User();
			
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), strType, user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode(strType, user.getDpID());
			flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
				nextUser=userMng.findById(node.getUserId());
			
			//设置下节点处理人姓名和编号		
			bean.setUserName2(nextUser.getName());
			bean.setFuserId(nextUser.getId());
			//设置下节点节点编码
			bean.setnCode(firstKey+"");	
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			//保存基本信息
			bean = (ApplicationBasicInfo) super.saveOrUpdate(bean);
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getgId());//申请单ID
			work.setTaskCode(bean.getgCode());//为申请单的单号
			String taskName = "";
			if("1".equals(bean.getType())) {
				taskName = "[通用事项申请]" + bean.getgName();
			} else if("2".equals(bean.getType())) {
				taskName = "[会议申请]" + bean.getgName();
			} else if("3".equals(bean.getType())) {
				taskName = "[培训申请]" + bean.getgName();
			} else if("4".equals(bean.getType())) {
				taskName = "[差旅申请]" + bean.getgName();
			} else if("5".equals(bean.getType())) {
				taskName = "[公务接待申请]" + bean.getgName();
			} else if("6".equals(bean.getType())) {
				taskName = "[公务用车申请]" + bean.getgName();
			} else if("7".equals(bean.getType())) {
				taskName = "[公务出国申请]" + bean.getgName();
			}
			work.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/applyCheck/check?id="+bean.getgId()+"&applyType="+bean.getType());//审批url
			work.setUrl1("/apply/edit?id="+ bean.getgId()+"&editType=0&applyType="+bean.getType());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setTaskType("1");//任务归属（1审批人）
			work.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work.setBeforeTime(d);//任务提交时间
			personalWorkMng.merge(work);
			
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(bean.getgId());//申请单ID
			work2.setTaskCode(bean.getgCode());//为申请单的单号
			work2.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/apply/edit?id="+ bean.getgId()+"&editType=1&applyType="+bean.getType());//退回修改url
			work2.setUrl1("/apply/edit?id="+ bean.getgId()+"&editType=0&applyType="+bean.getType());//查看url
			work2.setUrl2("/apply/delete?id="+ bean.getgId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setTaskType("0");//任务归属（0发起人）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work2.setBeforeTime(d);//任务提交时间
			work2.setFinishTime(d);
			personalWorkMng.merge(work2);

		} else {
			//保存基本信息
			bean = (ApplicationBasicInfo) super.saveOrUpdate(bean);
		}
		
		/** 保存附件 **/
		
		//保存附件信息
		attachmentMng.joinEntity(bean,files);
		
		/** 保存申请扩展信息 **/
		
		//保存差旅信息
		//删除数据库中   申请中的出差行程单
		getSession().createSQLQuery("delete from T_TRAVEL_APPLI_INFO where F_G_ID ="+bean.getgId()+" and F_STATUS=0").executeUpdate();
		if(!StringUtil.isEmpty(travelPeop)){
			//获取出差行程单的Json对象
			List<TravelAppliInfo> rp = JSON.parseObject("["+travelPeop.toString()+"]",new TypeReference<List<TravelAppliInfo>>(){});
			for (TravelAppliInfo travelAppliInfo : rp) {
				TravelAppliInfo info = new TravelAppliInfo();
				info.setgId(bean.getgId());
				info.setTravelDateStart(travelAppliInfo.getTravelDateStart());
				info.setTravelDateEnd(travelAppliInfo.getTravelDateEnd());
				info.setTravelArea(String.valueOf(travelAppliInfo.getTravelArea()));
				info.setTravelAreaName(travelAppliInfo.getTravelAreaName());
				info.setTravelAttendPeopId(travelAppliInfo.getTravelAttendPeopId());
				info.setTravelAttendPeop(travelAppliInfo.getTravelAttendPeop());
				info.setTravelType(bean.getTravelType());
				info.setTravelPersonnelLevel(travelAppliInfo.getTravelPersonnelLevel());
				info.setVehicle(travelAppliInfo.getVehicle());
				info.setVehicleId(travelAppliInfo.getVehicleId());
				info.setfStatus(0);
				super.merge(info);
			}
		}
		//删除数据库中   申请中的城市间交通费
		/*getSession().createSQLQuery("delete from T_OUTSIDE_TRADDIC_INFO where F_G_ID ="+bean.getgId()+" and F_STATUS='0'").executeUpdate();
		//获取出差行程单的Json对象
		if(!StringUtil.isEmpty(outsideTraffic)){
			List<OutsideTrafficInfo> outside = JSON.parseObject("["+outsideTraffic.toString()+"]",new TypeReference<List<OutsideTrafficInfo>>(){});
			for (OutsideTrafficInfo outsideTrafficInfo : outside) {
				OutsideTrafficInfo info = new OutsideTrafficInfo();
				info.setgId(bean.getgId());
				info.setfStartDate(outsideTrafficInfo.getfStartDate());
				info.setfEndDate(outsideTrafficInfo.getfEndDate());
				info.setVehicle(outsideTrafficInfo.getVehicle());
				info.setVehicleId(outsideTrafficInfo.getVehicleId());
				info.setVehicleLevel(outsideTrafficInfo.getVehicleLevel());
				info.setTravelPersonnel(outsideTrafficInfo.getTravelPersonnel());
				info.setApplyAmount(outsideTrafficInfo.getApplyAmount());
				info.setTravelPersonnelLevel(outsideTrafficInfo.getTravelPersonnelLevel());
				info.setTravelType(bean.getTravelType());
				info.setSts("0");
				super.merge(info);
			}	
		}*/
		//删除数据库中   申请中的城市间交通费
		/*getSession().createSQLQuery("delete from T_RECEPTION_OTEHR where F_G_ID ="+bean.getgId()+" and F_STATUS =0 and F_TYPE =1").executeUpdate();
		//获取出差行程单的Json对象
		if(!StringUtil.isEmpty(otherJson)){
			List<ReceptionOther> other = JSON.parseObject("["+otherJson.toString()+"]",new TypeReference<List<ReceptionOther>>(){});
			for (ReceptionOther receptionOther : other) {
				ReceptionOther info = new ReceptionOther();
				info.setgId(bean.getgId());
				info.setfCost(receptionOther.getfCost());
				info.setfCostStd(receptionOther.getfCostStd());
				info.setfStudentCostStd(receptionOther.getfStudentCostStd());
				info.setfTeacherCost(receptionOther.getfTeacherCost());
				info.setfStudentCost(receptionOther.getfStudentCost());
				info.setfCostName(receptionOther.getfCostName());
				info.setfStatus(0);
				info.setfType(receptionOther.getfType());
				super.merge(info);
				if("城市间交通费".equals(receptionOther.getfCostName())){
					bean.setOutsideAmount(receptionOther.getfCost());
				}
				if("住宿费".equals(receptionOther.getfCostName())){
					bean.setHotelAmount(receptionOther.getfCost());
				}
				if("伙食补助费".equals(receptionOther.getfCostName())){
					bean.setFoodAmount(receptionOther.getfCost());
				}
				if("市内交通费".equals(receptionOther.getfCostName())){
					bean.setCityAmount(receptionOther.getfCost());
				}
			}	
			bean = (ApplicationBasicInfo) super.saveOrUpdate(bean);
		}*/
		//删除数据库中   申请中的城市间交通费
		/*getSession().createSQLQuery("delete from T_RECEPTION_OTEHR where F_G_ID ="+bean.getgId()+" and F_STATUS =0 and F_TYPE =2").executeUpdate();
		//获取出差行程单的Json对象
		if(!StringUtil.isEmpty(otherJsons)){
			List<ReceptionOther> other = JSON.parseObject("["+otherJsons.toString()+"]",new TypeReference<List<ReceptionOther>>(){});
			for (ReceptionOther receptionOther : other) {
				ReceptionOther info = new ReceptionOther();
				info.setgId(bean.getgId());
				info.setfCost(receptionOther.getfCost());
				info.setfCostStd(receptionOther.getfCostStd());
				info.setfTeacherCost(receptionOther.getfTeacherCost());
				info.setfStudentCost(receptionOther.getfStudentCost());
				info.setfCostName(receptionOther.getfCostName());
				info.setfStatus(0);
				info.setfType(receptionOther.getfType());
				super.merge(info);
				if("会务费".equals(receptionOther.getfCostName())){
					bean.setOutsideAmount(receptionOther.getfCost());
				}
				if("培训费".equals(receptionOther.getfCostName())){
					bean.setHotelAmount(receptionOther.getfCost());
				}
			}	
			bean = (ApplicationBasicInfo) super.saveOrUpdate(bean);
		}*/
		//删除数据库中   申请中的预算json
		
		/*getSession().createSQLQuery("delete from T_BUDGET_MESSAGE_LIST where F_G_ID ="+bean.getgId()+"").executeUpdate();
		//获取出差行程单的Json对象
		if(!StringUtil.isEmpty(indexJsons)){
			List<BudgetMessageList> budgetMessageLists = JSON.parseObject("["+indexJsons.toString()+"]",new TypeReference<List<BudgetMessageList>>(){});
			for (BudgetMessageList budgetMessageList : budgetMessageLists) {
				BudgetMessageList info = new BudgetMessageList();
				info.setgId(bean.getgId());
				info.setfCostName(budgetMessageList.getfCostName());
				info.setfCostTheir(budgetMessageList.getfCostTheir());
				info.setfCostClassify(budgetMessageList.getfCostClassify());
				info.setfCostClassifyShow(budgetMessageList.getfCostClassifyShow());
				info.setfCostAmount(budgetMessageList.getfCostAmount());
				info.setfIndexId(budgetMessageList.getfIndexId());
				info.setfProDetailId(budgetMessageList.getfProDetailId());
				info.setfIndexType(budgetMessageList.getfIndexType());
				info.setfIndexName(budgetMessageList.getfIndexName());
				info.setfIndexPFAmount(budgetMessageList.getfIndexPFAmount());
				info.setfIndexKYAmount(budgetMessageList.getfIndexKYAmount());
				info.setfBudgetYear(budgetMessageList.getfBudgetYear());
				super.merge(info);
				if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
					if(!StringUtil.isEmpty(budgetMessageList.getfCostClassifyShow()) && budgetMessageList.getfCostAmount()!=null){
						budgetIndexMgrMng.addDjAmount(budgetMessageList.getfIndexId(),budgetMessageList.getfProDetailId(),budgetMessageList.getfCostAmount());
					}
				}
			}	
		}*/
	}	


	/**
	 * 市内公务非公共交通方式差旅申请新增和修改的保存
	* <p>Description: </p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年8月15日
	 */
	@Override
	public void saveTravelCity(ApplicationBasicInfo bean,
			TravelAppliInfo travelBean, User user,String travelPeop,String files)  throws Exception{
		
		/** 保存基本属性 **/
		Date d = new Date();
		bean.setReqTime(d);//申请时间
		bean.setUser(user.getId());//申请人id
		bean.setDept(user.getDepart().getId());//申请人所属部门id
		bean.setDeptName(user.getDepartName());//申请人所属部门名称
		if (bean.getgId()==null) {
			//创建人、创建时间、申请单编号
			bean.setCreator(user.getAccountNo());
			bean.setCreateTime(d);
			bean.setgCode(StringUtil.Random(""));//编码不需要加SQ
		} else {
			//修改人、修改时间
			bean.setUpdator(user.getAccountNo());
			bean.setUpdateTime(d);
		}
		/** 保存基本信息 **/
		//转换type选择流程
		String strType = "CXSQ";
		//工作流的节点配置（状态1和2可以继续走审批流，该状态不会变）
		if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
			Integer flowId =0;
			User nextUser = new User();
			
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), strType, user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode(strType, user.getDpID());
			flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			nextUser=userMng.findById(node.getUserId());
			
			//设置下节点处理人姓名和编号		
			bean.setUserName2(nextUser.getName());
			bean.setFuserId(nextUser.getId());
			//设置下节点节点编码
			bean.setnCode(firstKey+"");	
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			//保存基本信息
			bean = (ApplicationBasicInfo) super.saveOrUpdate(bean);
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getgId());//申请单ID
			work.setTaskCode(bean.getgCode());//为申请单的单号
			String taskName = "[市内公务非公共交通]" + bean.getgName();
			work.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/applyCheck/check?id="+bean.getgId()+"&applyType="+bean.getType());//审批url
			work.setUrl1("/apply/edit?id="+ bean.getgId()+"&editType=0&applyType="+bean.getType());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setTaskType("1");//任务归属（1审批人）
			work.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work.setBeforeTime(d);//任务提交时间
			personalWorkMng.merge(work);
			
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(bean.getgId());//申请单ID
			work2.setTaskCode(bean.getgCode());//为申请单的单号
			work2.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/apply/edit?id="+ bean.getgId()+"&editType=1&applyType="+bean.getType());//退回修改url
			work2.setUrl1("/apply/edit?id="+ bean.getgId()+"&editType=0&applyType="+bean.getType());//查看url
			work2.setUrl2("/apply/delete?id="+ bean.getgId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setTaskType("0");//任务归属（0发起人）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work2.setBeforeTime(d);//任务提交时间
			work2.setFinishTime(d);
			personalWorkMng.merge(work2);
			
			BigDecimal num = bean.getAmount();
			budgetIndexMgrMng.addDjAmount(bean.getIndexId(),bean.getProDetailId(),num);
		} else {
			//保存基本信息
			bean = (ApplicationBasicInfo) super.saveOrUpdate(bean);
		}
		
		/** 保存附件 **/
		
		//保存附件信息
		attachmentMng.joinEntity(bean,files);
		
		/** 保存申请扩展信息 **/
		
		//保存差旅信息
		//删除数据库中   申请中的出差行程单
		getSession().createSQLQuery("delete from T_TRAVEL_APPLI_INFO where F_G_ID ="+bean.getgId()+" and F_STATUS=0").executeUpdate();
		if(!StringUtil.isEmpty(travelPeop)){
			//获取出差行程单的Json对象
			List<TravelAppliInfo> rp = JSON.parseObject("["+travelPeop.toString()+"]",new TypeReference<List<TravelAppliInfo>>(){});
			for (TravelAppliInfo travelAppliInfo : rp) {
				TravelAppliInfo info = new TravelAppliInfo();
				info.setgId(bean.getgId());
				info.setTripType(travelAppliInfo.getTripType());
				info.setTravelDateStart(travelAppliInfo.getTravelDateStart());
				info.setTravelDateEnd(travelAppliInfo.getTravelDateEnd());
				info.setPlaceStart(travelAppliInfo.getPlaceStart());
				info.setPlaceEnd(travelAppliInfo.getPlaceEnd());
				info.setDistance(travelAppliInfo.getDistance());
				info.setfStatus(0);
				super.merge(info);
			}
		}
	}	
		
			
	/*
	 * 公务接待申请新增和修改的保存
	 * @author 沈帆
	 * @createtime 2020-02-16
	 * @updatetime 2020-02-16
	 */
	@Override
	public void saveRecp(User user, ApplicationBasicInfo bean,
			ReceptionAppliInfo receptionBean, String observePlanJson, String foodJson,
			String otherJson, String files,String recePeop, String jdghfiles)  throws Exception{
		
		/** 保存基本属性 **/
		
		//设置属性
		Date d = new Date();
		bean.setReqTime(d);//申请时间
		bean.setUser(user.getId());//申请人id
		bean.setDept(user.getDepart().getId());//申请人所属部门id
		bean.setDeptName(user.getDepartName());//申请人所属部门名称
		if (bean.getgId()==null) {
			//创建人、创建时间、申请单编号
			bean.setCreator(user.getAccountNo());
			bean.setCreateTime(d);
			bean.setgCode(StringUtil.Random(""));//编码不需要加SQ
		} else {
			//修改人、修改时间
			bean.setUpdator(user.getAccountNo());
			bean.setUpdateTime(d);
		}
		
		
		/** 保存基本信息 **/
		//转换type选择流程
		String strType = tProcessCheckMng.JudgmentProcess(String.valueOf(bean.getType()));
		/*if(receptionBean.getReceptionLevel1().equals("2")){
			if(receptionBean.getIsForeign().equals("1")){
				strType = "GWJDSQ-WB";
			}else{
				strType = "GWJDSQ-YJYX";
			}
		}*/
		//工作流的节点配置（状态1和2可以继续走审批流，该状态不会变）
		if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
			Integer flowId =0;
			User nextUser = new User();
			
			TBudgetIndexMgr budgetIndexMgr = budgetIndexMgrMng.findById(bean.getIndexId());
			TProBasicInfo pro = tProBasicInfoMng.findById(budgetIndexMgr.getFProId());
			if(1==pro.getFProOrBasic()){//项目支出才有项目负责人
				nextUser = userMng.findById(pro.getFProHeadId());
				TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode(strType, user.getDpID());
				flowId= processDefin.getFPId();
				//设置下节点处理人姓名和编号		
				bean.setUserName2(nextUser.getName());
				bean.setFuserId(nextUser.getId());
				//设置下节点节点编码
				bean.setnCode("FProHead");	//该标识标识目前处于项目负责人审批节点
			}else if(0==pro.getFProOrBasic()){
				//得到第一个审批节点key
				Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), strType, user);
				//根据资源名称和当前登陆者所属部门查询对应工作流
				TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode(strType, user.getDpID());
				flowId= processDefin.getFPId();
				TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
				nextUser=userMng.findById(node.getUserId());
				//设置下节点处理人姓名和编号		
				bean.setUserName2(nextUser.getName());
				bean.setFuserId(nextUser.getId());
				//设置下节点节点编码
				bean.setnCode(firstKey+"");	
			}
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			//保存基本信息
			bean = (ApplicationBasicInfo) super.saveOrUpdate(bean);
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getgId());//申请单ID
			work.setTaskCode(bean.getgCode());//为申请单的单号
			String taskName = "";
			if("1".equals(bean.getType())) {
				taskName = "[通用事项申请]" + bean.getgName();
			} else if("2".equals(bean.getType())) {
				taskName = "[会议申请]" + bean.getgName();
			} else if("3".equals(bean.getType())) {
				taskName = "[培训申请]" + bean.getgName();
			} else if("4".equals(bean.getType())) {
				taskName = "[差旅申请]" + bean.getgName();
			} else if("5".equals(bean.getType())) {
				taskName = "[公务接待申请]" + bean.getgName();
			} else if("6".equals(bean.getType())) {
				taskName = "[公务用车申请]" + bean.getgName();
			} else if("7".equals(bean.getType())) {
				taskName = "[公务出国申请]" + bean.getgName();
			}
			work.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/applyCheck/check?id="+bean.getgId()+"&applyType="+bean.getType());//审批url
			work.setUrl1("/apply/edit?id="+ bean.getgId()+"&editType=0&applyType="+bean.getType());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setTaskType("1");//任务归属（1审批人）
			work.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work.setBeforeTime(d);//任务提交时间
			personalWorkMng.merge(work);
			
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(bean.getgId());//申请单ID
			work2.setTaskCode(bean.getgCode());//为申请单的单号
			work2.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/apply/edit?id="+ bean.getgId()+"&editType=1&applyType="+bean.getType());//退回修改url
			work2.setUrl1("/apply/edit?id="+ bean.getgId()+"&editType=0&applyType="+bean.getType());//查看url
			work2.setUrl2("/apply/delete?id="+ bean.getgId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setTaskType("0");//任务归属（0发起人）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work2.setBeforeTime(d);//任务提交时间
			work2.setFinishTime(d);
			personalWorkMng.merge(work2);
			
			BigDecimal num = bean.getAmount();
			budgetIndexMgrMng.addDjAmount(bean.getIndexId(),bean.getProDetailId(),num);
		} else {
			//保存基本信息
			bean = (ApplicationBasicInfo) super.saveOrUpdate(bean);
		}
		
		/** 保存附件 **/
		
		//保存附件信息
		attachmentMng.joinEntity(bean,files);
		attachmentMng.joinEntity(bean,jdghfiles);
		
		/** 保存申请扩展信息 **/
		
		//保存公务接待信息
		if(receptionBean != null) {
			if (receptionBean.getjId()==null) {
				//创建人、创建时间、发布时间
				receptionBean.setCreator(user.getAccountNo());
				receptionBean.setCreateTime(d);
			} else {
				//修改人、修改时间
				receptionBean.setUpdator(user.getAccountNo());
				receptionBean.setUpdateTime(d);
			}
			receptionBean.setgId(bean.getgId());
			receptionBean = (ReceptionAppliInfo) super.saveOrUpdate(receptionBean);
			
			/*//保存接待人员名单
			JSONArray arrayPopele = JSONArray.fromObject("["+recePeop.toString()+"]");
			List recep = (List)JSONArray.toList(arrayPopele, ReceptionPeopleInfo.class);
			//获得老的接待人员名单
			List<Object> oldrecep = getObjectList("ReceptionPeopleInfo", "jId", receptionBean.getjId());
				for (int i = oldrecep.size()-1; i >= 0; i--) {
					ReceptionPeopleInfo oldrpi = (ReceptionPeopleInfo) oldrecep.get(i);
					for (int j = 0; j < recep.size(); j++) {		
						ReceptionPeopleInfo rpi = (ReceptionPeopleInfo) recep.get(j);
						if(rpi.getTravelRId()!=null){
							if(rpi.getTravelRId()==oldrpi.getTravelRId()){
								oldrecep.remove(i);
							}
						}
					}
				}
			//删除在新明细中没有的老明细
			if(oldrecep.size()>0){
				for (int i = 0; i < oldrecep.size(); i++) {
					ReceptionPeopleInfo oldrpi = (ReceptionPeopleInfo) oldrecep.get(i);
					super.delete(oldrpi);
				}
			}
			
			for (int i = 0; i < recep.size(); i++) {		
				ReceptionPeopleInfo rpi = (ReceptionPeopleInfo) recep.get(i);
				rpi.setjId(receptionBean.getjId());
				rpi.setCreator(user.getAccountNo());
				rpi.setCreateTime(d);
				//保存被接待人信息
				super.merge(rpi);
			}*/
			//获取住宿费的Json对象
			//获得新的参观考察安排
			/*JSONArray array = JSONArray.fromObject("["+observePlanJson.toString()+"]");
			List rp = (List)JSONArray.toList(array, ReceptionObservePlan.class);*/
			//List<ReceptionObservePlan> rp = JSON.parseObject("["+observePlanJson.toString()+"]",new TypeReference<List<ReceptionObservePlan>>(){});
			//获得老的参观考察安排
			/*List<Object> oldrp = getObjectList("ReceptionObservePlan", "jId", receptionBean.getjId());
				for (int i = oldrp.size()-1; i >= 0; i--) {
					ReceptionObservePlan oldrpi = (ReceptionObservePlan) oldrp.get(i);
					for (int j = 0; j < rp.size(); j++) {		
						ReceptionObservePlan rpi = (ReceptionObservePlan) rp.get(j);
						if(rpi.getoId()!=null){
							if(rpi.getoId()==oldrpi.getoId()){
								oldrp.remove(i);
							}
						}
					}
				}*/
			//删除在新明细中没有的老明细
			/*if(oldrp.size()>0){
				for (int i = 0; i < oldrp.size(); i++) {
					ReceptionObservePlan oldrpi = (ReceptionObservePlan) oldrp.get(i);
					super.delete(oldrpi);
				}
			}*/
			
			/*for (int i = 0; i < rp.size(); i++) {		
				ReceptionObservePlan rpi = (ReceptionObservePlan) rp.get(i);
				rpi.setjId(receptionBean.getjId());
				rpi.setCreator(user.getAccountNo());
				rpi.setCreateTime(d);
				//保存被接待人信息
				super.merge(rpi);
			}*/
			
			//获取餐费的Json对象
			//获得新的餐费信息
		/*	JSONArray array1 = JSONArray.fromObject("["+foodJson.toString()+"]");
			List rp1 = (List)JSONArray.toList(array1, ReceptionFood.class);*/
			//List<ReceptionFood> rp1 = JSON.parseObject("["+foodJson.toString()+"]",new TypeReference<List<ReceptionFood>>(){});
			
			//获得老的餐费信息
			/*List<Object> oldrp1 = getObjectList("ReceptionFood", "gId", bean.getgId());
				for (int i = oldrp1.size()-1; i >= 0; i--) {
					ReceptionFood oldrpi = (ReceptionFood) oldrp1.get(i);
					for (int j = 0; j < rp1.size(); j++) {		
						ReceptionFood rpi = (ReceptionFood) rp1.get(j);
						if(rpi.getfID()!=null){
							if(rpi.getfID()==oldrpi.getfID()){
								oldrp1.remove(i);
							}
						}
					}
				}*/
			//删除在新明细中没有的老明细
			/*if(oldrp1.size()>0){
				for (int i = 0; i < oldrp1.size(); i++) {
					ReceptionFood oldrpi = (ReceptionFood) oldrp1.get(i);
					super.delete(oldrpi);
				}
			}*/
			
			/*for (int i = 0; i < rp1.size(); i++) {		
				ReceptionFood rpi = (ReceptionFood) rp1.get(i);
				rpi.setgId(bean.getgId());
				rpi.setCreator(user.getAccountNo());
				rpi.setCreateTime(d);
				//保存被接待人信息
				super.merge(rpi);
			}*/
			
			//获取其他费用的Json对象
			//获得新的其他费用信息
			//JSONArray array11 = JSONArray.fromObject("["+otherJson.toString()+"]");
			//List rp11 = (List)JSONArray.toList(array11, ReceptionOther.class);
			
			/*List<Object> oldrp11 = getObjectList("ReceptionOther", "gId", bean.getgId());
				for (int i = oldrp11.size()-1; i >= 0; i--) {
					ReceptionOther oldrpi = (ReceptionOther) oldrp11.get(i);
					for (int j = 0; j < rp11.size(); j++) {		
						ReceptionOther rpi = (ReceptionOther) rp11.get(j);
						if(rpi.getoID()!=null){
							if(rpi.getoID()==oldrpi.getoID()){
								oldrp11.remove(i);
							}
						}
					}
				}*/
			//删除在新明细中没有的老明细
			/*if(oldrp11.size()>0){
				for (int i = 0; i < oldrp11.size(); i++) {
					ReceptionOther oldrpi = (ReceptionOther) oldrp11.get(i);
					super.delete(oldrpi);
				}
			}
			*/
			/*for (int i = 0; i < rp11.size(); i++) {		
				ReceptionOther rpi = (ReceptionOther) rp11.get(i);
				rpi.setgId(bean.getgId());
				rpi.setCreator(user.getAccountNo());
				rpi.setCreateTime(d);
				//保存信息
				super.merge(rpi);
			}*/
		}
	}	
	
	/*
	 * 公车运维申请新增和修改的保存
	 * @author 沈帆
	 * @createtime 2020-02-14
	 * @updatetime 2020-02-14
	 */
	@Override
	public void saveOfficeCar(ApplicationBasicInfo bean, User user,String officeCar,String files)  throws Exception{
		
		/** 保存基本属性 **/
		
		//设置属性
		Date d = new Date();
		bean.setReqTime(d);//申请时间
		bean.setUser(user.getId());//申请人id
		bean.setDept(user.getDepart().getId());//申请人所属部门id
		bean.setDeptName(user.getDepartName());//申请人所属部门名称
		if (bean.getgId()==null) {
			//创建人、创建时间、申请单编号
			bean.setCreator(user.getAccountNo());
			bean.setCreateTime(d);
			bean.setgCode(StringUtil.Random(""));//编码不需要加SQ
		} else {
			//修改人、修改时间
			bean.setUpdator(user.getAccountNo());
			bean.setUpdateTime(d);
		}
		
		
		/** 保存基本信息 **/
		//转换type选择流程
		String strType = tProcessCheckMng.JudgmentProcess(String.valueOf(bean.getType()));
		//工作流的节点配置（状态1和2可以继续走审批流，该状态不会变）
		if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
			Integer flowId =0;
			User nextUser = new User();
			TBudgetIndexMgr budgetIndexMgr = budgetIndexMgrMng.findById(bean.getIndexId());
			TProBasicInfo pro = tProBasicInfoMng.findById(budgetIndexMgr.getFProId());
			
			if(1==pro.getFProOrBasic()){//项目支出才有项目负责人
				nextUser = userMng.findById(pro.getFProHeadId());
				//设置下节点处理人姓名和编号		
				bean.setUserName2(nextUser.getName());
				bean.setFuserId(nextUser.getId());
				//设置下节点节点编码
				bean.setnCode("FProHead");	//该标识标识目前处于项目负责人审批节点
			}else{
				//得到第一个审批节点key
				Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), strType, user);
				//根据资源名称和当前登陆者所属部门查询对应工作流
				TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode(strType, user.getDpID());
				flowId= processDefin.getFPId();
				TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
				nextUser=userMng.findById(node.getUserId());
				//设置下节点处理人姓名和编号		
				bean.setUserName2(nextUser.getName());
				bean.setFuserId(nextUser.getId());
				//设置下节点节点编码
				bean.setnCode(firstKey+"");	
			}
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			//保存基本信息
			bean = (ApplicationBasicInfo) super.saveOrUpdate(bean);
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getgId());//申请单ID
			work.setTaskCode(bean.getgCode());//为申请单的单号
			String taskName = "";
			if("1".equals(bean.getType())) {
				taskName = "[通用事项申请]" + bean.getgName();
			} else if("2".equals(bean.getType())) {
				taskName = "[会议申请]" + bean.getgName();
			} else if("3".equals(bean.getType())) {
				taskName = "[培训申请]" + bean.getgName();
			} else if("4".equals(bean.getType())) {
				taskName = "[差旅申请]" + bean.getgName();
			} else if("5".equals(bean.getType())) {
				taskName = "[公务接待申请]" + bean.getgName();
			} else if("6".equals(bean.getType())) {
				taskName = "[公车运维申请]" + bean.getgName();
			} else if("7".equals(bean.getType())) {
				taskName = "[公务出国申请]" + bean.getgName();
			}
			work.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/applyCheck/check?id="+bean.getgId()+"&applyType="+bean.getType());//审批url
			work.setUrl1("/apply/edit?id="+ bean.getgId()+"&editType=0&applyType="+bean.getType());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setTaskType("1");//任务归属（1审批人）
			work.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work.setBeforeTime(d);//任务提交时间
			personalWorkMng.merge(work);
			
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(bean.getgId());//申请单ID
			work2.setTaskCode(bean.getgCode());//为申请单的单号
			work2.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/apply/edit?id="+ bean.getgId()+"&editType=1&applyType="+bean.getType());//退回修改url
			work2.setUrl1("/apply/edit?id="+ bean.getgId()+"&editType=0&applyType="+bean.getType());//查看url
			work2.setUrl2("/apply/delete?id="+ bean.getgId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setTaskType("0");//任务归属（0发起人）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work2.setBeforeTime(d);//任务提交时间
			work2.setFinishTime(d);
			personalWorkMng.merge(work2);
			
			BigDecimal num = bean.getAmount();
			budgetIndexMgrMng.addDjAmount(bean.getIndexId(),bean.getProDetailId(),num);
		} else {
			//保存基本信息
			bean = (ApplicationBasicInfo) super.saveOrUpdate(bean);
		}
		
		/** 保存附件 **/
		
		//保存附件信息
		attachmentMng.joinEntity(bean,files);
		
		/** 保存申请扩展信息 **/
		
		//保存公车运维信息
			
		//删除数据库中   申请中的公车运维费用明细
		getSession().createSQLQuery("delete from T_OFFICE_CAR where F_G_ID ="+bean.getgId()+" and F_STATUS='0'").executeUpdate();
		if(!StringUtil.isEmpty(officeCar)){
			//获取公车运维费用明细的Json对象
			List<OfficeCar> officeCarList = JSON.parseObject(officeCar,new TypeReference<List<OfficeCar>>(){});
			for (OfficeCar officeCarInfo : officeCarList) {
				OfficeCar info = new OfficeCar();
				info.setgId(bean.getgId());
				info.setfExpenseName(officeCarInfo.getfExpenseName());
				info.setfUseType(officeCarInfo.getfUseType());
				info.setfCarNum(officeCarInfo.getfCarNum());
				info.setfCarType(officeCarInfo.getfCarType());
				info.setfUseAmount(officeCarInfo.getfUseAmount());
				info.setfRemark(officeCarInfo.getfRemark());
				info.setfStatus(0);
				super.merge(info);
			}
		}
	}
	
	/*
	 * 培训申请新增和修改的保存
	 * @author 沈帆
	 * @createtime 2020-02-17
	 * @updatetime 2020-02-17
	 */
	@Override
	public void saveTrain(User user, ApplicationBasicInfo bean,
			TrainingAppliInfo trainingBean, String trainPlan, String files, String trainLecturer, String zongheJson, String lessonJson, String hotelJson, String foodJson, String trafficJson1, String trafficJson2)  throws Exception{
		
		/** 保存基本属性 **/
		
		//设置属性
		Date d = new Date();
		bean.setReqTime(d);//申请时间
		bean.setUser(user.getId());//申请人id
		bean.setDept(user.getDepart().getId());//申请人所属部门id
		bean.setDeptName(user.getDepartName());//申请人所属部门名称
		if (bean.getgId()==null) {
			//创建人、创建时间、申请单编号
			bean.setCreator(user.getAccountNo());
			bean.setCreateTime(d);
			bean.setgCode(StringUtil.Random(""));//编码不需要加SQ
		} else {
			//修改人、修改时间
			bean.setUpdator(user.getAccountNo());
			bean.setUpdateTime(d);
		}
		
		
		/** 保存基本信息 **/
		//转换type选择流程
		String strType = tProcessCheckMng.JudgmentProcess(String.valueOf(bean.getType()));
		//工作流的节点配置（状态1和2可以继续走审批流，该状态不会变）
		if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
			Integer flowId =0;
			User nextUser = new User();
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), strType, user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode(strType, user.getDpID());
			flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			
			
			if(StringUtil.isEmpty(node.getText())){//如果是专用经费申请，则通过预算项目的id来获取预算项目的部门负责人
				if(!StringUtil.isEmpty(String.valueOf(bean.getProId()))){
					TProBasicInfo basicInfo = tProBasicInfoMng.findById(bean.getProId());
					nextUser = userMng.getUserByRoleNameAndDepartName("部门负责人", basicInfo.getFProAppliDepart());
				}
			}else{
				nextUser=userMng.findById(node.getUserId());
			}
			
			//设置下节点处理人姓名和编号		
			bean.setUserName2(nextUser.getName());
			bean.setFuserId(nextUser.getId());
			//设置下节点节点编码
			bean.setnCode(firstKey+"");	
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			//保存基本信息
			bean = (ApplicationBasicInfo) super.saveOrUpdate(bean);
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getgId());//申请单ID
			work.setTaskCode(bean.getgCode());//为申请单的单号
			String taskName = "";
			taskName = "[举办培训申请]" + bean.getgName();
			work.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/applyCheck/check?id="+bean.getgId()+"&applyType="+bean.getType());//审批url
			work.setUrl1("/apply/edit?id="+ bean.getgId()+"&editType=0&applyType="+bean.getType());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setTaskType("1");//任务归属（1审批人）
			work.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work.setBeforeTime(d);//任务提交时间
			personalWorkMng.merge(work);
			
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(bean.getgId());//申请单ID
			work2.setTaskCode(bean.getgCode());//为申请单的单号
			work2.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/apply/edit?id="+ bean.getgId()+"&editType=1&applyType="+bean.getType());//退回修改url
			work2.setUrl1("/apply/edit?id="+ bean.getgId()+"&editType=0&applyType="+bean.getType());//查看url
			work2.setUrl2("/apply/delete?id="+ bean.getgId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setTaskType("0");//任务归属（0发起人）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work2.setBeforeTime(d);//任务提交时间
			work2.setFinishTime(d);
			personalWorkMng.merge(work2);
			
			BigDecimal num = bean.getAmount();
			budgetIndexMgrMng.addDjAmount(bean.getIndexId(),bean.getProDetailId(),num);
		} else {
			//保存基本信息
			bean = (ApplicationBasicInfo) super.saveOrUpdate(bean);
		}
		
		/** 保存附件 **/
		
		//保存附件信息
		attachmentMng.joinEntity(bean,files);
		
		/** 保存申请扩展信息 **/
		
		//保存培训信息
		if(trainingBean != null) {
			if (trainingBean.gettId()==null) {
				//创建人、创建时间、发布时间
				trainingBean.setCreator(user.getAccountNo());
				trainingBean.setCreateTime(d);
			} else {
				//修改人、修改时间
				trainingBean.setUpdator(user.getAccountNo());
				trainingBean.setUpdateTime(d);
			}
			trainingBean.setgId(bean.getgId());
			trainingBean = (TrainingAppliInfo) super.saveOrUpdate(trainingBean);
			
			//保存讲师信息
			//获得老的信息
			List<Object> oldlec = getObjectList("LecturerInfo", "tId", trainingBean.gettId());
			//获取现有的明细
			JSONArray array =JSONArray.fromObject("["+trainLecturer.toString()+"]");
			List newlec = (List)JSONArray.toList(array, LecturerInfo.class);
			//删除在新明细中没有的老明细
			if(oldlec.size()>0){
				for (int i = 0; i < oldlec.size(); i++) {
					LecturerInfo oldgad = (LecturerInfo) oldlec.get(i);
					super.delete(oldgad);
				}
			}
			//保存新的明细
			for (int j = 0; j < newlec.size(); j++) {
				LecturerInfo gad = (LecturerInfo) newlec.get(j);
				gad.settId(trainingBean.gettId());
				gad.setCreator(user.getAccountNo());
				gad.setCreateTime(d);
				super.merge(gad);
			}
			//保存培训日程
			//获得新的培训日程信息
			List<MeetPlan> oc = JSON.parseObject("["+trainPlan.toString()+"]",new TypeReference<List<MeetPlan>>(){});
			//获得老的信息
			List<Object> oldrp = getObjectList("MeetPlan", "tId", trainingBean.gettId());
			//删除在新明细中没有的老明细
			if(oldrp.size()>0){
				for (int i = 0; i < oldrp.size(); i++) {
					MeetPlan oldrpi = (MeetPlan) oldrp.get(i);
					super.delete(oldrpi);
				}
			}

			for (int i = 0; i < oc.size(); i++) {		
				MeetPlan rpi = (MeetPlan) oc.get(i);
				rpi.settId(trainingBean.gettId());
				rpi.setCreator(user.getAccountNo());
				rpi.setCreateTime(d);
				//保存培训日程信息
				super.merge(rpi);
			}
			//保存讲课费
			//获得老的信息
			List<TrainTeacherCost> oldlesson = getTeacherMingxi(trainingBean.gettId(),"lesson");
			//获取现有的明细
			JSONArray array1 =JSONArray.fromObject("["+lessonJson.toString()+"]");
			List newlesson = (List)JSONArray.toList(array1, TrainTeacherCost.class);
			//删除在新明细中没有的老明细
			if(oldlesson.size()>0){
				for (int i = 0; i < oldlesson.size(); i++) {
					TrainTeacherCost oldgad = oldlesson.get(i);
					super.delete(oldgad);
				}
			}
			//保存新的明细
			for (int j = 0; j < newlesson.size(); j++) {
				TrainTeacherCost gad = (TrainTeacherCost) newlesson.get(j);
				gad.settId(trainingBean.gettId());
				gad.setCreator(user.getAccountNo());
				gad.setCreateTime(d);
				gad.setCostType("lesson");
				super.merge(gad);
			}
			//保存住宿费
			//获得老的信息
			List<TrainTeacherCost> oldhotel = getTeacherMingxi(trainingBean.gettId(),"hotel");
			//获取现有的明细
			JSONArray array2 =JSONArray.fromObject("["+hotelJson.toString()+"]");
			List newhotel = (List)JSONArray.toList(array2, TrainTeacherCost.class);
			//删除在新明细中没有的老明细
			if(oldhotel.size()>0){
				for (int i = 0; i < oldhotel.size(); i++) {
					TrainTeacherCost oldgad = oldhotel.get(i);
					super.delete(oldgad);
				}
			}
			//保存新的明细
			for (int j = 0; j < newhotel.size(); j++) {
				TrainTeacherCost gad = (TrainTeacherCost) newhotel.get(j);
				gad.settId(trainingBean.gettId());
				gad.setCreator(user.getAccountNo());
				gad.setCreateTime(d);
				gad.setCostType("hotel");
				super.merge(gad);
			}
			//保存伙食费
			//获得老的信息
			List<TrainTeacherCost> oldfood = getTeacherMingxi(trainingBean.gettId(),"food");
			//获取现有的明细
			JSONArray array3 =JSONArray.fromObject("["+foodJson.toString()+"]");
			List newfood = (List)JSONArray.toList(array3, TrainTeacherCost.class);
			//删除在新明细中没有的老明细
			if(oldfood.size()>0){
				for (int i = 0; i < oldfood.size(); i++) {
					TrainTeacherCost oldgad = oldfood.get(i);
					super.delete(oldgad);
				}
			}
			//保存新的明细
			for (int j = 0; j < newfood.size(); j++) {
				TrainTeacherCost gad = (TrainTeacherCost) newfood.get(j);
				gad.settId(trainingBean.gettId());
				gad.setCreator(user.getAccountNo());
				gad.setCreateTime(d);
				gad.setCostType("food");
				super.merge(gad);
			}
			//保存城市间交通费
			//获得老的信息
			List<TrainTeacherCost> oldtraffic1 = getTeacherMingxi(trainingBean.gettId(),"traffic1");
			//获取现有的明细
			JSONArray array4 =JSONArray.fromObject("["+trafficJson1.toString()+"]");
			List newtraffic1 = (List)JSONArray.toList(array4, TrainTeacherCost.class);
			//删除在新明细中没有的老明细
			if(oldtraffic1.size()>0){
				for (int i = 0; i < oldtraffic1.size(); i++) {
					TrainTeacherCost oldgad = oldtraffic1.get(i);
					super.delete(oldgad);
				}
			}
			//保存新的明细
			for (int j = 0; j < newtraffic1.size(); j++) {
				TrainTeacherCost gad = (TrainTeacherCost) newtraffic1.get(j);
				gad.settId(trainingBean.gettId());
				gad.setCreator(user.getAccountNo());
				gad.setCreateTime(d);
				gad.setCostType("traffic1");
				super.merge(gad);
			}
			//保存市内交通费
			//获得老的信息
			/*List<TrainTeacherCost> oldtraffic2 = getTeacherMingxi(trainingBean.gettId(),"traffic2");
			//获取现有的明细
			JSONArray array5 =JSONArray.fromObject("["+trafficJson2.toString()+"]");
			List newtraffic2 = (List)JSONArray.toList(array5, TrainTeacherCost.class);
			//删除在新明细中没有的老明细
			if(oldtraffic2.size()>0){
				for (int i = 0; i < oldtraffic2.size(); i++) {
					TrainTeacherCost oldgad = oldtraffic2.get(i);
					super.delete(oldgad);
				}
			}
			//保存新的明细
			for (int j = 0; j < newtraffic2.size(); j++) {
				TrainTeacherCost gad = (TrainTeacherCost) newtraffic2.get(j);
				gad.settId(trainingBean.gettId());
				gad.setCreator(user.getAccountNo());
				gad.setCreateTime(d);
				gad.setCostType("traffic2");
				super.merge(gad);
			}*/
		}
	}
	
	/*
	 * 公务出国申请新增和修改的保存
	 * @author 沈帆
	 * @createtime 2020-02-18
	 * @updatetime 2020-02-18
	 */
	@Override
	public void saveAbroad(User user, ApplicationBasicInfo bean,
			AbroadAppliInfo abroadBean,
			String travelJson,	                    //国际旅费json
			String trafficJson1,					//城市间交通费和国外城市间交通费
			String hotelJson,	                    //住宿费json
			String foodJson,						//伙食费json
			String feeJson,							//公杂费json
			String feteJson,						//宴请费json
			String otherJson,						//其他收入json
			String abroadPlanJson,						//出访计划
			String travelWayJson,                   //出行方式json                   //出行方式json
			String abroadPeopleJson,
			String files)  throws Exception{
		
		/** 保存基本属性 **/
		
		//设置属性
		Date d = new Date();
		bean.setReqTime(d);//申请时间
		bean.setUser(user.getId());//申请人id
		bean.setDept(user.getDepart().getId());//申请人所属部门id
		bean.setDeptName(user.getDepartName());//申请人所属部门名称
		if (bean.getgId()==null) {
			//创建人、创建时间、申请单编号
			bean.setCreator(user.getAccountNo());
			bean.setCreateTime(d);
			bean.setgCode(StringUtil.Random(""));//编码不需要加SQ
		} else {
			//修改人、修改时间
			bean.setUpdator(user.getAccountNo());
			bean.setUpdateTime(d);
		}
		
		
		/** 保存基本信息 **/
		//转换type选择流程
		String strType = tProcessCheckMng.JudgmentProcess(String.valueOf(bean.getType()));
		//工作流的节点配置（状态1和2可以继续走审批流，该状态不会变）
		if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
			Integer flowId =0;
			User nextUser = new User();
			
			TBudgetIndexMgr budgetIndexMgr = budgetIndexMgrMng.findById(bean.getIndexId());
			TProBasicInfo pro = tProBasicInfoMng.findById(budgetIndexMgr.getFProId());
			if(1==pro.getFProOrBasic()){//项目支出才有项目负责人
				nextUser = userMng.findById(pro.getFProHeadId());
				TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode(strType, user.getDpID());
				flowId= processDefin.getFPId();
				//设置下节点处理人姓名和编号		
				bean.setUserName2(nextUser.getName());
				bean.setFuserId(nextUser.getId());
				//设置下节点节点编码
				bean.setnCode("FProHead");	//该标识标识目前处于项目负责人审批节点
			}else if(0==pro.getFProOrBasic()){
				//得到第一个审批节点key
				Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), strType, user);
				//根据资源名称和当前登陆者所属部门查询对应工作流
				TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode(strType, user.getDpID());
				flowId= processDefin.getFPId();
				TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
				nextUser=userMng.findById(node.getUserId());
				//设置下节点处理人姓名和编号		
				bean.setUserName2(nextUser.getName());
				bean.setFuserId(nextUser.getId());
				//设置下节点节点编码
				bean.setnCode(firstKey+"");	
			}
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			//保存基本信息
			bean = (ApplicationBasicInfo) super.saveOrUpdate(bean);
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getgId());//申请单ID
			work.setTaskCode(bean.getgCode());//为申请单的单号
			String taskName = "";
			if("1".equals(bean.getType())) {
				taskName = "[通用事项申请]" + bean.getgName();
			} else if("2".equals(bean.getType())) {
				taskName = "[会议申请]" + bean.getgName();
			} else if("3".equals(bean.getType())) {
				taskName = "[培训申请]" + bean.getgName();
			} else if("4".equals(bean.getType())) {
				taskName = "[差旅申请]" + bean.getgName();
			} else if("5".equals(bean.getType())) {
				taskName = "[公务接待申请]" + bean.getgName();
			} else if("6".equals(bean.getType())) {
				taskName = "[公车运维申请]" + bean.getgName();
			} else if("7".equals(bean.getType())) {
				taskName = "[公务出国申请]" + bean.getgName();
			}
			work.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/applyCheck/check?id="+bean.getgId()+"&applyType="+bean.getType());//审批url
			work.setUrl1("/apply/edit?id="+ bean.getgId()+"&editType=0&applyType="+bean.getType());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setTaskType("1");//任务归属（1审批人）
			work.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work.setBeforeTime(d);//任务提交时间
			personalWorkMng.merge(work);
			
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(bean.getgId());//申请单ID
			work2.setTaskCode(bean.getgCode());//为申请单的单号
			work2.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/apply/edit?id="+ bean.getgId()+"&editType=1&applyType="+bean.getType());//退回修改url
			work2.setUrl1("/apply/edit?id="+ bean.getgId()+"&editType=0&applyType="+bean.getType());//查看url
			work2.setUrl2("/apply/delete?id="+ bean.getgId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setTaskType("0");//任务归属（0发起人）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work2.setBeforeTime(d);//任务提交时间
			work2.setFinishTime(d);
			personalWorkMng.merge(work2);
			
			BigDecimal num = bean.getAmount();
			budgetIndexMgrMng.addDjAmount(bean.getIndexId(),bean.getProDetailId(),num);
		} else {
			//保存基本信息
			bean = (ApplicationBasicInfo) super.saveOrUpdate(bean);
		}
		
		/** 保存附件 **/
		
		//保存附件信息
		attachmentMng.joinEntity(bean,files);
		
		/** 保存申请扩展信息 **/
		
		//保存公务出国信息
		if(abroadBean != null) {
			if (abroadBean.getFaId()==null) {
				//创建人、创建时间、发布时间
				abroadBean.setCreator(user.getAccountNo());
				abroadBean.setCreateTime(d);
			} else {
				//修改人、修改时间
				abroadBean.setUpdator(user.getAccountNo());
				abroadBean.setUpdateTime(d);
			}
			abroadBean.setgId(bean.getgId());
			abroadBean = (AbroadAppliInfo) super.merge(abroadBean);
		
			
			//删除数据库中   申请中的出访计划信息
			getSession().createSQLQuery("delete from t_abroad_plan where F_G_ID ="+bean.getgId()+" and F_STATUS=0").executeUpdate();
			//获得新的出访计划信息
			if(!StringUtil.isEmpty(abroadPlanJson)){
				//获取出访计划信息的Json对象
				List<AbroadPlan> rp = JSON.parseObject("["+abroadPlanJson.toString()+"]",new TypeReference<List<AbroadPlan>>(){});
				for (AbroadPlan abroadPlan : rp) {
					AbroadPlan info = new AbroadPlan();
					info.setgId(bean.getgId());
					info.setAbroadDate(abroadPlan.getAbroadDate());
					info.setTimeEnd(abroadPlan.getTimeEnd());
					info.setArriveCountryId(abroadPlan.getArriveCountryId());
					info.setArriveCountry(abroadPlan.getArriveCountry());
					info.setArriveCity(abroadPlan.getArriveCity());
					info.setRemark(abroadPlan.getRemark());
					info.setStatus(0);
					super.merge(info);
				}
			}
			
			
			//删除数据库中   申请中的国际旅费
			getSession().createSQLQuery("delete from T_INTERNATIONAL_TRAVELING_EXPENSE where F_G_ID ="+bean.getgId()+" and F_STATUS=0").executeUpdate();
			//获得新的国际旅费
			if(!StringUtil.isEmpty(travelJson)){
				//获取国际旅费的Json对象
				List<InternationalTravelingExpense> rp = JSON.parseObject("["+travelJson.toString()+"]",new TypeReference<List<InternationalTravelingExpense>>(){});
				for (InternationalTravelingExpense internationalTravelingExpense : rp) {
					InternationalTravelingExpense info = new InternationalTravelingExpense();
					info.setgId(bean.getgId());
					info.setTimeStart(internationalTravelingExpense.getTimeStart());
					info.setTimeEnd(internationalTravelingExpense.getTimeEnd());
					info.setStartCity(internationalTravelingExpense.getStartCity());
					info.setArriveCity(internationalTravelingExpense.getArriveCity());
					info.setVehicle(internationalTravelingExpense.getVehicle());
					info.setApplyAmount(internationalTravelingExpense.getApplyAmount());
					info.setTrainSubsidies(internationalTravelingExpense.getTrainSubsidies());
					info.setfStatus(0);
					super.merge(info);
				}
			}
			
			//删除数据库中的出行方式
			getSession().createSQLQuery("delete from T_OUTSIDE_TRADDIC_INFO where F_G_ID ="+bean.getgId()+" and F_TRAVAL_TYPE='GWCG'").executeUpdate();
			//获取出行方式Json对象
			if (!StringUtil.isEmpty(travelWayJson)) {
				List<OutsideTrafficInfo> outsideTrafficInfoList = JSON.parseObject("["+travelWayJson.toString()+"]", new TypeReference<List<OutsideTrafficInfo>>(){});
				for (OutsideTrafficInfo outsideTrafficInfo : outsideTrafficInfoList) {
					OutsideTrafficInfo info = new OutsideTrafficInfo();
					info.setgId(bean.getgId());
					info.setfStartDate(outsideTrafficInfo.getfStartDate());
					info.setfEndDate(outsideTrafficInfo.getfEndDate());
					info.setDeparturePlace(outsideTrafficInfo.getDeparturePlace());
					info.setDestination(outsideTrafficInfo.getDestination());
					info.setVehicle(outsideTrafficInfo.getVehicle());
					info.setVehicleId(outsideTrafficInfo.getVehicleId());
					info.setVehicleLevel(outsideTrafficInfo.getVehicleLevel());
					info.setTravelPersonnel(outsideTrafficInfo.getTravelPersonnel());
					info.setTravelPersonnelId(outsideTrafficInfo.getTravelPersonnelId());
					info.setTravelPersonnelLevel(outsideTrafficInfo.getTravelPersonnelLevel());
					info.setTravelType("GWCG");
					super.merge(info);
				}
			}
			
			
			//删除数据库中   申请中的城市间交通费
			getSession().createSQLQuery("delete from T_OUTSIDE_TRADDIC_INFO where F_G_ID ="+bean.getgId()+" and F_STATUS='0'").executeUpdate();
			//获取出城市间交通费的Json对象
			if(!StringUtil.isEmpty(trafficJson1)){
				List<OutsideTrafficInfo> outside = JSON.parseObject("["+trafficJson1.toString()+"]",new TypeReference<List<OutsideTrafficInfo>>(){});
				for (OutsideTrafficInfo outsideTrafficInfo : outside) {
					OutsideTrafficInfo info = new OutsideTrafficInfo();
					info.setgId(bean.getgId());
					info.setTravelPersonnel(outsideTrafficInfo.getTravelPersonnel());
					info.setApplyAmount(outsideTrafficInfo.getApplyAmount());
					info.setSts("0");
					super.merge(info);
				}	
			}
			
			//删除数据库中   申请中的住宿费
			getSession().createSQLQuery("delete from T_HOTEL_EXPENSE_INFO where F_G_ID ="+bean.getgId()+" and F_STATUS='0'").executeUpdate();
			if(!StringUtil.isEmpty(hotelJson)){
				//获取住宿费的Json对象
				List<HotelExpenseInfo> rp = JSON.parseObject("["+hotelJson.toString()+"]",new TypeReference<List<HotelExpenseInfo>>(){});
				for (HotelExpenseInfo hotelExpenseInfo : rp) {
					HotelExpenseInfo info = new HotelExpenseInfo();
					info.setgId(bean.getgId());
					info.setLocationCity(hotelExpenseInfo.getLocationCity());
					info.setCheckInTime(hotelExpenseInfo.getCheckInTime());
					info.setCheckOUTTime(hotelExpenseInfo.getCheckOUTTime());
					info.setCityId(hotelExpenseInfo.getCityId());
					info.setStandard(hotelExpenseInfo.getStandard());
					info.setHotelDay(hotelExpenseInfo.getHotelDay());
					info.setCountStandard(hotelExpenseInfo.getCountStandard());
					info.setCurrency(hotelExpenseInfo.getCurrency());
					info.setApplyAmount(hotelExpenseInfo.getApplyAmount());
					info.setSts("0");
					super.merge(info);
				}
			}
			
			//删除数据库中   申请中的伙食费
			getSession().createSQLQuery("delete from T_FOOD_ALLOWANCE_INFO where F_G_ID ="+bean.getgId()+" and F_STATUS=0").executeUpdate();
			if(!StringUtil.isEmpty(foodJson)){
				//获取伙食费的Json对象
				List<FoodAllowanceInfo> rp = JSON.parseObject("["+foodJson.toString()+"]",new TypeReference<List<FoodAllowanceInfo>>(){});
				for (FoodAllowanceInfo foodAllowanceInfo : rp) {
					FoodAllowanceInfo info = new FoodAllowanceInfo();
					info.setgId(bean.getgId());
					info.setfAddress(foodAllowanceInfo.getfAddress());
					info.setStandard(foodAllowanceInfo.getStandard());
					info.setfDays(foodAllowanceInfo.getfDays());
					info.setCountStandard(foodAllowanceInfo.getCountStandard());
					info.setCurrency(foodAllowanceInfo.getCurrency());
					info.setfApplyAmount(foodAllowanceInfo.getfApplyAmount());
					info.setfStatus(0);
					super.merge(info);
				}
			}
			
			//删除数据库中   申请中的公杂费
			getSession().createSQLQuery("delete from T_MISCELLANEOUS_FEE where F_G_ID ="+bean.getgId()+" and F_STATUS=0").executeUpdate();
			if(!StringUtil.isEmpty(feeJson)){
				//获取公杂费的Json对象
				List<MiscellaneousFeeInfo> rp = JSON.parseObject("["+feeJson.toString()+"]",new TypeReference<List<MiscellaneousFeeInfo>>(){});
				for (MiscellaneousFeeInfo miscellaneousFeeInfo : rp) {
					MiscellaneousFeeInfo info = new MiscellaneousFeeInfo();
					info.setgId(bean.getgId());
					info.setfAddress(miscellaneousFeeInfo.getfAddress());
					info.setStandard(miscellaneousFeeInfo.getStandard());
					info.setfDays(miscellaneousFeeInfo.getfDays());
					info.setCountStandard(miscellaneousFeeInfo.getCountStandard());
					info.setCurrency(miscellaneousFeeInfo.getCurrency());
					info.setfApplyAmount(miscellaneousFeeInfo.getfApplyAmount());
					info.setfStatus(0);
					super.merge(info);
				}
			}
			
			//删除数据库中   申请中的宴请费
			getSession().createSQLQuery("delete from T_FETE_COST_INFO where F_G_ID ="+bean.getgId()+" and F_STATUS=0").executeUpdate();
			if(!StringUtil.isEmpty(feteJson)){
				//获取宴请费的Json对象
				List<FeteCostInfo> rp = JSON.parseObject("["+feteJson.toString()+"]",new TypeReference<List<FeteCostInfo>>(){});
				for (FeteCostInfo feteCostInfo : rp) {
					FeteCostInfo info = new FeteCostInfo();
					info.setgId(bean.getgId());
					info.setfAddress(feteCostInfo.getfAddress());
					info.setfAddressId(feteCostInfo.getfAddressId());
					info.setStandard(feteCostInfo.getStandard());
					info.setfFeeNum(feteCostInfo.getfFeeNum());
					info.setfAccompanyNum(feteCostInfo.getfAccompanyNum());
					info.setCountStandard(feteCostInfo.getCountStandard());
					info.setCurrency(feteCostInfo.getCurrency());
					info.setfApplyAmount(feteCostInfo.getfApplyAmount());
					info.setfStatus(0);
					super.merge(info);
				}
			}
			
			//删除数据库中   申请中的其他费
			getSession().createSQLQuery("delete from T_RECEPTION_OTEHR where F_G_ID ="+bean.getgId()+" and F_STATUS=0").executeUpdate();
			if(!StringUtil.isEmpty(otherJson)){
				//获取其他费的Json对象
				List<ReceptionOther> rp = JSON.parseObject("["+otherJson.toString()+"]",new TypeReference<List<ReceptionOther>>(){});
				for (ReceptionOther receptionOther : rp) {
					ReceptionOther info = new ReceptionOther();
					info.setgId(bean.getgId());
					info.setfCostName(receptionOther.getfCostName());
					info.setfCost(receptionOther.getfCost());
					info.setfRemark(receptionOther.getfRemark());
					info.setfStatus(0);
					super.merge(info);
				}
			}
			
			
			//删除数据库中   申请中的出国人员
			getSession().createSQLQuery("delete from T_ABROAD_APPLI_PEOPLE_INFO where F_A_ID ="+abroadBean.getFaId()+" ").executeUpdate();
			if(!StringUtil.isEmpty(abroadPeopleJson)){
				//获取其他费的Json对象
				List<AbroadAppliPepoleInfo> rp = JSON.parseObject("["+abroadPeopleJson.toString()+"]",new TypeReference<List<AbroadAppliPepoleInfo>>(){});
				for (AbroadAppliPepoleInfo abroad : rp) {
					AbroadAppliPepoleInfo info = new AbroadAppliPepoleInfo();
					info.setaId(abroadBean.getFaId());
					info.setIdCard(abroad.getIdCard());
					info.setTravelPeopName(abroad.getTravelPeopName());
					info.setPhoneNum(abroad.getPhoneNum());
					info.setPosition(abroad.getPosition());
					info.setTravelPeopId(abroad.getTravelPeopId());
					info.setTravelPersonnelLevel(abroad.getTravelPersonnelLevel());
					info.setfPassport(abroad.getfPassport());
					info.setCreateTime(new Date());
					info.setUpdateTime(new Date());
					info.setCreator(user.getName());
					super.merge(info);
				}
			}
			
			
		}
	}
	
	/*
	 * 分页查询
	 * @author 沈帆
	 * @createtime 2020-01-16
	 * @updatetime 2020-01-16
	 */
	@Override
	public Pagination reimbPageList(ApplicationBasicInfo bean, int pageNo, int pageSize, Integer type, User user,String rFlowStauts) {
		//查询条件
		/*Finder finder = Finder.create(" FROM ApplicationBasicInfo WHERE stauts in('1','0') AND user='"+user.getId()+"' AND type="+type);
		finder.append(" AND flowStauts='9' ");
		if (!StringUtil.isEmpty(String.valueOf(bean.getgCode()))) {
			finder.append(" AND gCode LIKE '%"+bean.getgCode()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getgName()))) {
			finder.append(" AND gName LIKE '%"+bean.getgName()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getReqTime1()))) {
			finder.append(" AND datediff(reqTime,'"+bean.getReqTime()+"')=0 ");
			finder.append(" AND DATE_FORMAT(reqTime,'%Y-%m-%d') >= '"+bean.getReqTime1()+"'");//日期去时分秒函数
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getReqTime2()))) {
			finder.append(" AND datediff(reqTime,'"+bean.getReqTime()+"')=0 ");
			finder.append(" AND DATE_FORMAT(reqTime,'%Y-%m-%d') <= '"+bean.getReqTime2()+"'");//日期去时分秒函数
		}
		if (!StringUtil.isEmpty(bean.getFlowStauts())) {
			if(bean.getFlowStauts().equals("暂存")) {
				finder.append(" and flowStauts = '0'");
			}
			if(bean.getFlowStauts().equals("待审批")) {
				finder.append(" and flowStauts = '1'");
			}
			if(bean.getFlowStauts().equals("审批中")) {
				finder.append(" and flowStauts in('2','3','4','5','6','7','8')");
			}
			if(bean.getFlowStauts().equals("已审批")) {
				finder.append(" and flowStauts = '9'");
			}
			if(bean.getFlowStauts().equals("已退回")) {
				finder.append(" and flowStauts = '-1'");
			}
		}
		finder.append(" order by updateTime desc ");
		//设置其他属性
		Pagination p = super.find(finder, pageNo, pageSize);
		List<ApplicationBasicInfo> li = (List<ApplicationBasicInfo>) p.getList();
		for(int x=0; x<li.size(); x++) {
			ReimbAppliBasicInfo reimb =reimbAppliMng.findByCode(li.get(x).getgCode());
			if(reimb!=null){
				li.get(x).setrId(reimb.getrId());
				li.get(x).setReimbAmount(reimb.getAmount());
				li.get(x).setReimbTime(reimb.getReimburseReqTime());
				li.get(x).setReimbFlowStauts(reimb.getFlowStauts());
				li.get(x).setReimbStauts(reimb.getStauts());
			}
			//序号设置	
			li.get(x).setNum((x+1)+(pageNo-1)*pageSize);
			//设置申请人姓名（id查姓名）,申请人所属部门
			User u = userMng.findById(li.get(x).getUser());
			li.get(x).setUserName(u.getName());
		}*/
		StringBuilder sb = new StringBuilder("select a.F_G_ID as gId,a.F_G_CODE as gCode,a.F_G_NAME as gName,"
				+ "a.F_AMOUNT as amount,a.F_REQ_TIME as reqTime,a.F_APP_TYPE as type,b.F_R_ID as rId,b.F_AMOUNT as reimbAmount,"
				+ "b.F_REQ_TIME as reimbTime,b.F_FLOW_STAUTS as reimbFlowStauts,b.F_STAUTS as reimbStauts,b.F_EXT_1 as rName,"
				+ "a.F_DEPT_NAME as deptName,a.F_USER_NAME as userNames,b.F_HOTEL_AMOUNT as hotelAmount,b.F_MEETING_TRAIN_AMOUNT as meetTrainAmount "
				+ "from T_APPLICATION_BASIC_INFO a left join t_reimb_appli_basic_info b on a.F_G_CODE = b.F_G_CODE");
		sb.append(" where a.F_STAUTS in('1','0')  AND a.F_USER='"+user.getId()+"' AND a.F_APP_TYPE="+type+" ");
		sb.append(" and a.F_FLOW_STAUTS='9' ");
		sb.append(" and (b.F_STAUTS!=99 or b.F_STAUTS is null)");
		if (!StringUtil.isEmpty(String.valueOf(bean.getgCode()))) {
			sb.append(" AND a.F_G_CODE LIKE '%"+bean.getgCode()+"%'");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getReqTime1()))) {
			sb.append(" AND DATE_FORMAT(b.F_REQ_TIME,'%Y-%m-%d') >= '"+bean.getReqTime1()+"'");//日期去时分秒函数
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getReqTime2()))) {
			sb.append(" AND DATE_FORMAT(b.F_REQ_TIME,'%Y-%m-%d') <= '"+bean.getReqTime2()+"'");//日期去时分秒函数
		}
		if (!StringUtil.isEmpty(rFlowStauts)) {
			if("99".equals(rFlowStauts)){
				sb.append(" AND b.F_FLOW_STAUTS is null");
			}else{
				sb.append(" AND b.F_FLOW_STAUTS = '"+rFlowStauts+"'");
			}
		}
		sb.append(" ORDER BY b.F_FLOW_STAUTS,b.F_REQ_TIME desc");
		String str=sb.toString();
		Pagination p1 =super.findObjectListBySql(str, pageNo, pageSize);
		List<Object[]> dataList = (List<Object[]>) p1.getList();
		List<ApplicationBasicInfo>list=new ArrayList<>();
		if (dataList != null && dataList.size() > 0) {
			int i = 0;
			for (Object[] obj: dataList) {
				ApplicationBasicInfo t=new ApplicationBasicInfo();
				t.setgId(Integer.valueOf(String.valueOf(obj[0])));
				t.setgCode(String.valueOf(obj[1]));
				t.setgName(String.valueOf(obj[2]));
				if(String.valueOf(obj[3]).isEmpty() || "null".equals(String.valueOf(obj[3]))){
					t.setAmount(BigDecimal.ZERO);
				}else{
					t.setAmount(BigDecimal.valueOf(Double.valueOf(String.valueOf(obj[3]))));
				}
				t.setReqTime((Date) obj[4]);
				t.setType(String.valueOf(obj[5]));
				if(obj[6]!=null){
					t.setrId(Integer.valueOf(String.valueOf(obj[6])));		
				}
				t.setReimbAmount(BigDecimal.valueOf(Double.valueOf(String.valueOf(obj[7]==null?0:obj[7]))));
				t.setReimbTime((Date) obj[8]);
				t.setReimbFlowStauts((String) obj[9]);
				t.setReimbStauts((String) obj[10]);
				t.setrName(String.valueOf(obj[11]));
				t.setDeptName(String.valueOf(obj[12]));
				t.setUserNames(String.valueOf(obj[13]));
				t.setHotelAmount(BigDecimal.valueOf(Double.valueOf(String.valueOf(obj[14]==null?0:obj[14]))));
				t.setMeetTrainAmount(BigDecimal.valueOf(Double.valueOf(String.valueOf(obj[15]==null?0:obj[15]))));
				t.setNum(pageNo * pageSize + i - (pageSize-1));
				i++;
				list.add(t);
			}
			p1.setList(list);
		}
		return p1;
	}
	
	
	@Override
	public List<Lookups> getLookupsJson(String categoryCode,String blanked,String selected) {
		Finder hql=Finder.create("FROM Lookups WHERE flag='1' ");
		hql.append("  AND category.code =:pcode ").setParam("pcode", categoryCode);
		if(!StringUtil.isEmpty(blanked)){
			hql.append(" AND code<>:code").setParam("code", blanked);
		}
		hql.append(" ORDER BY convert(orderNo,DECIMAL)");
		return super.find(hql);
	}
	
	@Override
	public List<TrainTeacherCost> getTeacherMingxi(Integer id, String costType){
		Finder hql=Finder.create("FROM TrainTeacherCost WHERE tId="+id+" and costType= '"+costType+"' ");
		return super.find(hql);
	}

	@Override
	public List<AbroadExpenseInfo> getExpenseDetail(Integer gId) {
		List<AbroadExpenseInfo> list = new ArrayList<AbroadExpenseInfo>();
		//国际旅费
		AbroadExpenseInfo abroadExpenseInfo = new AbroadExpenseInfo();
		List<InternationalTravelingExpense> internationalList = internationalTravelingExpenseInfoMng.findbygId(gId);
		BigDecimal internationalAmount = BigDecimal.ZERO;
		if (internationalList != null && !internationalList.isEmpty()) {
			BigDecimal amount = internationalList.get(0).getApplyAmount();
			if (amount != null) {
				internationalAmount = amount;
			}
		}
		abroadExpenseInfo.setExpenseName("国际旅费");
		abroadExpenseInfo.setApplyAmount(internationalAmount);
		abroadExpenseInfo.setgId(gId);
		list.add(abroadExpenseInfo);
		
		//国外城市间交通费
		abroadExpenseInfo = new AbroadExpenseInfo();
		Finder finder = Finder.create(" FROM OutsideTrafficInfo WHERE sts =0");	
		if (!StringUtil.isEmpty(String.valueOf(gId))){
			finder.append(" AND gId="+gId+"");
		}
		finder.append(" order by fStartDate asc");
		List<OutsideTrafficInfo> outsideTrafficInfoList = super.find(finder);
		BigDecimal outsideTrafficAmount = BigDecimal.ZERO;
		if (outsideTrafficInfoList != null && !outsideTrafficInfoList.isEmpty()) {
			BigDecimal amount = outsideTrafficInfoList.get(0).getApplyAmount();
			if (amount != null) {
				outsideTrafficAmount = amount;
			}
		}
		abroadExpenseInfo.setExpenseName("国外城市间交通费");
		abroadExpenseInfo.setApplyAmount(outsideTrafficAmount);
		abroadExpenseInfo.setgId(gId);
		list.add(abroadExpenseInfo);
		
		//住宿费
		abroadExpenseInfo = new AbroadExpenseInfo();
		List<HotelExpenseInfo> hotelList = hotelExpenseInfoMng.findbygId(gId, null);
		BigDecimal hotelAmount = BigDecimal.ZERO;
		if (hotelList != null && !hotelList.isEmpty()) {
			BigDecimal amount = hotelList.get(0).getApplyAmount();
			if (amount != null) {
				hotelAmount = amount;
			}
		}
		abroadExpenseInfo.setExpenseName("住宿费");
		abroadExpenseInfo.setApplyAmount(hotelAmount);
		abroadExpenseInfo.setgId(gId);
		list.add(abroadExpenseInfo);
		
		//伙食费
		abroadExpenseInfo = new AbroadExpenseInfo();
		List<FoodAllowanceInfo> foodList = foodAllowanceInfoMng.findbygId(gId, null);
		BigDecimal foodAmount = BigDecimal.ZERO;
		if (foodList != null && !foodList.isEmpty()) {
			BigDecimal amount = foodList.get(0).getfApplyAmount();
			if (amount != null) {
				foodAmount = amount;
			}
		}
		abroadExpenseInfo.setExpenseName("伙食费");
		abroadExpenseInfo.setApplyAmount(foodAmount);
		abroadExpenseInfo.setgId(gId);
		list.add(abroadExpenseInfo);
		
		//公杂费
		abroadExpenseInfo = new AbroadExpenseInfo();
		List<Object> feeList = this.getObjectList("MiscellaneousFeeInfo", "gId", gId);
		BigDecimal feeAmount = BigDecimal.ZERO;
		if (feeList != null && !feeList.isEmpty()) {
			MiscellaneousFeeInfo obj = (MiscellaneousFeeInfo)feeList.get(0);
			BigDecimal amount = obj.getfApplyAmount();
			if (amount != null) {
				feeAmount = amount;
			}
		}
		abroadExpenseInfo.setExpenseName("公杂费");
		abroadExpenseInfo.setApplyAmount(feeAmount);
		abroadExpenseInfo.setgId(gId);
		list.add(abroadExpenseInfo);
		
		//宴请费用
		abroadExpenseInfo = new AbroadExpenseInfo();
		List<FeteCostInfo> feteList = feteCostInfoMng.findbygId(gId);
		BigDecimal feteAmount = BigDecimal.ZERO;
		if (feteList != null && !feteList.isEmpty()) {
			BigDecimal amount = feteList.get(0).getfApplyAmount();
			if (amount != null) {
				feteAmount = amount;
			}
		}
		abroadExpenseInfo.setExpenseName("宴请费用");
		abroadExpenseInfo.setApplyAmount(feteAmount);
		abroadExpenseInfo.setgId(gId);
		list.add(abroadExpenseInfo);
		
		//其他费用
		abroadExpenseInfo = new AbroadExpenseInfo();
		List<Object> otherList = this.getObjectList("ReceptionOther", "gId", gId);
		BigDecimal otherAmount = BigDecimal.ZERO;
		if (otherList != null && !otherList.isEmpty()) {
			ReceptionOther obj = (ReceptionOther)otherList.get(0);
			BigDecimal amount = obj.getfCost();
			if (amount != null) {
				otherAmount = amount;
			}
		}
		abroadExpenseInfo.setExpenseName("其他费用");
		abroadExpenseInfo.setApplyAmount(otherAmount);
		abroadExpenseInfo.setgId(gId);
		list.add(abroadExpenseInfo);
		return list;
	}

	@Override
	public List<ReceptionOther> getReceptionOther(ReceptionOther bean, User user) {
		Finder finder = Finder.create(" FROM ReceptionOther WHERE 1=1");
		if (!StringUtil.isEmpty(String.valueOf(bean.getgId()))) {
			finder.append(" AND gId ="+bean.getgId()+"");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getrId()))) {
			finder.append(" AND rId ="+bean.getrId()+"");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getfType()))) {
			finder.append(" AND fType ="+bean.getfType()+"");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getfStatus()))) {
			finder.append(" AND fStatus ="+bean.getfStatus()+"");
		}
		finder.append(" order by updateTime desc ");
		return super.find(finder);
	}

	@Override
	public List<BudgetMessageList> getBudgetMessageList(BudgetMessageList bean,
			User user) {
		Finder finder = Finder.create(" FROM BudgetMessageList WHERE 1=1");
		if (!StringUtil.isEmpty(String.valueOf(bean.getgId()))) {
			finder.append(" AND gId ="+bean.getgId()+"");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getrId()))) {
			finder.append(" AND rId ="+bean.getrId()+"");
		}
		finder.append(" order by pID desc ");
		return super.find(finder);
	}
	/**
	 * 通过科目编号获取指标项目
	 * @param id
	 * @return
	 */
	@Override
	public List<TProExpendDetail> getProName(String year, String deptId, String number,String proId) {
		String sql = "select F_EXP_ID from t_pro_expend_detail where F_PRO_ID in"
				+ "(SELECT B.F_PRO_ID FROM T_BUDGET_INDEX_MGR A INNER JOIN T_PRO_BASIC_INFO B  ON A.F_B_INDEX_CODE = B.F_PRO_CODE "
				+ " WHERE A.F_RELEASE_STAUTS='1'  AND A.F_YEARS='"+year+"'"
				+ " and b.F_PRO_ID in("+proId+"))";// and F_SUB_NUM='"+number+"'
		SQLQuery query = getSession().createSQLQuery(sql);
		List<Object[]> objects = query.list();
		String pid = "";
		for (int i = 0; i < objects.size(); i++) {
			pid =pid + objects.get(i) + ",";
		}
		if(!StringUtil.isEmpty(pid)){
			pid = pid.substring(0, pid.length()-1);
		}
		List<TProExpendDetail> basicInfos = null;
		Finder finder =null;
		if(!StringUtil.isEmpty(pid)){
			finder = Finder.create(" FROM TProExpendDetail WHERE pid in("+pid+")");
			basicInfos = super.find(finder);
		}else{
			basicInfos = new ArrayList<TProExpendDetail>();
		}
		return basicInfos; 
	}
	/**
	 * 通过科目编号获取指标明细
	 * @param id
	 * @return
	 */
	@Override
	public List<TProExpendDetail> getSubjectDetail(String proId,String subCode) {
		TProExpendDetail detailInfos = tProExpendDetailMng.findById(Integer.valueOf(proId));
		List<TProExpendDetail> details = new ArrayList<TProExpendDetail>();
		if(detailInfos!=null){
			TBudgetIndexMgr budgetIndexMgr = budgetIndexMgrMng.findByProperty("FProId", detailInfos.getFProId()).get(0);
			TProBasicInfo basicInfo = projectMng.findById(detailInfos.getFProId());
			detailInfos.setbId(budgetIndexMgr.getbId());
			detailInfos.setfProOrBasic(budgetIndexMgr.getIndexType());
			detailInfos.setYears(budgetIndexMgr.getYears());
			detailInfos.setProName(basicInfo.getFProName());
			details.add(detailInfos);
		}
		return details; 
	}

	@Override
	public void saveAttendTrain(User user, ApplicationBasicInfo bean,
			TravelAppliInfo travelBean, String files) throws Exception {

		
		/** 保存基本属性 **/
		
		//设置属性
		Date d = new Date();
		bean.setReqTime(d);//申请时间
		bean.setUser(user.getId());//申请人id
		bean.setDept(user.getDepart().getId());//申请人所属部门id
		bean.setDeptName(user.getDepartName());//申请人所属部门名称
		if (bean.getgId()==null) {
			//创建人、创建时间、申请单编号
			bean.setCreator(user.getAccountNo());
			bean.setCreateTime(d);
			bean.setgCode(StringUtil.Random(""));//编码不需要加SQ
		} else {
			//修改人、修改时间
			bean.setUpdator(user.getAccountNo());
			bean.setUpdateTime(d);
		}
		
		
		/** 保存基本信息 **/
		//转换type选择流程
		String strType = tProcessCheckMng.JudgmentProcess(String.valueOf(bean.getType()));
		//工作流的节点配置（状态1和2可以继续走审批流，该状态不会变）
		if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
			Integer flowId =0;
			User nextUser = new User();
			
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), strType, user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode(strType, user.getDpID());
			flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			if(StringUtil.isEmpty(node.getText())){//如果是专用经费申请，则通过预算项目的id来获取预算项目的部门负责人
				if(!StringUtil.isEmpty(String.valueOf(bean.getProId()))){
					TProBasicInfo basicInfo = tProBasicInfoMng.findById(bean.getProId());
					nextUser = userMng.getUserByRoleNameAndDepartName("部门负责人", basicInfo.getFProAppliDepart());
				}
			}else{
				nextUser=userMng.findById(node.getUserId());
			}
			nextUser=userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号		
			bean.setUserName2(nextUser.getName());
			bean.setFuserId(nextUser.getId());
			//设置下节点节点编码
			bean.setnCode(firstKey+"");	
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			//保存基本信息
			bean = (ApplicationBasicInfo) super.saveOrUpdate(bean);
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getgId());//申请单ID
			work.setTaskCode(bean.getgCode());//为申请单的单号
			String taskName = "";
			taskName = "[参加培训申请]" + bean.getgName();
			work.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/applyCheck/check?id="+bean.getgId()+"&applyType="+bean.getType());//审批url
			work.setUrl1("/apply/edit?id="+ bean.getgId()+"&editType=0&applyType="+bean.getType());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setTaskType("1");//任务归属（1审批人）
			work.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work.setBeforeTime(d);//任务提交时间
			personalWorkMng.merge(work);
			
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(bean.getgId());//申请单ID
			work2.setTaskCode(bean.getgCode());//为申请单的单号
			work2.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/apply/edit?id="+ bean.getgId()+"&editType=1&applyType="+bean.getType());//退回修改url
			work2.setUrl1("/apply/edit?id="+ bean.getgId()+"&editType=0&applyType="+bean.getType());//查看url
			work2.setUrl2("/apply/delete?id="+ bean.getgId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setTaskType("0");//任务归属（0发起人）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work2.setBeforeTime(d);//任务提交时间
			work2.setFinishTime(d);
			personalWorkMng.merge(work2);
			
			BigDecimal num = bean.getAmount();
			budgetIndexMgrMng.addDjAmount(bean.getIndexId(),bean.getProDetailId(),num);
		} else {
			//保存基本信息
			bean = (ApplicationBasicInfo) super.saveOrUpdate(bean);
		}
		
		/** 保存附件 **/
		attachmentMng.joinEntity(bean,files);
		/** 保存申请扩展信息 **/
		travelBean.setgId(bean.getBeanId());
		travelAppliInfoMng.saveOrUpdate(travelBean);
	}
}
