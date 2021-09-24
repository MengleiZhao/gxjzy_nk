package com.braker.icontrol.expend.apply.manager;

import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Lookups;
import com.braker.core.model.Notice;
import com.braker.core.model.NoticeAttac;
import com.braker.core.model.SystemCenterAttac;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.expend.apply.model.AbroadAppliInfo;
import com.braker.icontrol.expend.apply.model.AbroadExpenseInfo;
import com.braker.icontrol.expend.apply.model.ApplicationAttac;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.apply.model.ApplicationDetail;
import com.braker.icontrol.expend.apply.model.BudgetMessageList;
import com.braker.icontrol.expend.apply.model.MeetingAppliInfo;
import com.braker.icontrol.expend.apply.model.OfficeCar;
import com.braker.icontrol.expend.apply.model.ReceptionAppliInfo;
import com.braker.icontrol.expend.apply.model.ReceptionOther;
import com.braker.icontrol.expend.apply.model.TrainTeacherCost;
import com.braker.icontrol.expend.apply.model.TrainingAppliInfo;
import com.braker.icontrol.expend.apply.model.TravelAppliInfo;

/**
 * 事前申请的service抽象类
 * @author 叶崇晖
 * @createtime 2018-06-12
 * @updatetime 2018-06-12
 */
public interface ApplyMng extends BaseManager<ApplicationBasicInfo>{
	
	/*
	 * 分页查询
	 * @author 叶崇晖
	 * @createtime 2018-06-12
	 * @updatetime 2018-06-12
	 */
	public Pagination pageList(ApplicationBasicInfo bean, int pageNo, int pageSize, Integer type, User user);
	
	/*
	 * 事前申请新增和修改的保存
	 * @author 叶崇晖
	 * @createtime 2018-06-12
	 * @updatetime 2018-06-12
	 */
	public void save(ApplicationBasicInfo bean, 
			MeetingAppliInfo meetingBean, 
			TrainingAppliInfo trainingBean , 
			TravelAppliInfo travelBean, 
			ReceptionAppliInfo receptionBean,
			OfficeCar officeBean,
			AbroadAppliInfo abroadBean,
			String mingxi, 
			User user,
			String recePeop,
			String files
			) throws Exception;
	
	/*
	 * 事前申请删除
	 * @author 叶崇晖
	 * @createtime 2018-06-12
	 * @updatetime 2018-06-12
	 */
	public void delete(Integer id,User user,String fId);
	
	
	/*
	 * 查询单一对象的通用方法
	 * @author 叶崇晖
	 * @createtime 2018-06-14
	 * @updatetime 2018-06-14
	 */
	public Object getObject(String tableName, String idName, Integer id);
	
	/*
	 * 明细查询
	 * @author 叶崇晖
	 * @createtime 2018-06-14
	 * @updatetime 2018-06-14
	 * @param tableName 明细类型（培训、会议等等）
	 */
	public List<Object> getMingxi(String tableName ,String idName ,Integer id);
	
	/*
	 * 查询多个对象的通用方法
	 * @author 叶崇晖
	 * @createtime 2018-06-15
	 * @updatetime 2018-06-15
	 */
	public List<Object> getObjectList(String tableName, String idName, Integer id);
	
	
	/*
	 * 保存申请附件信息
	 * @author 叶崇晖
	 * @createtime 2018-07-05
	 * @updatetime 2018-07-05
	 */
	public void saveApplyAttac(ApplicationAttac attac);
	
	/*
	 * 审批分页查询
	 * @author 叶崇晖
	 * @createtime 2018-06-29
	 * @updatetime 2018-06-29
	 */
	public Pagination checkPageList(ApplicationBasicInfo bean, int pageNo,int pageSize, User user);
	
	/*
	 * 台账分页查询
	 * @author 叶崇晖
	 * @createtime 2018-07-06
	 * @updatetime 2018-07-06
	 */
	public Pagination ledgerPageList(ApplicationBasicInfo bean,String applyType,int pageNo,int pageSize, User user);
	
	
	/**
	 * 查询需要导出的全部台账信息
	 * @author 叶崇晖
	 * @return
	 */
	public List<ApplicationBasicInfo> ledgerList(ApplicationBasicInfo bean);
	
	/**
	 * 生成需要导出的台账HSSFWorkbook
	 * @author 叶崇晖
	 * @param ledgerData事前申请基本信息集合List
	 * @param filePath模板位置
	 * @return
	 */
	public HSSFWorkbook exportLedger(List<ApplicationBasicInfo> ledgerData, String filePath);
	
	
	/**
	 * 查询可以申请报销的当前登录人的事前申请信息
	 * @param applytype
	 * @return
	 */
	public List<ApplicationBasicInfo> reimburseList(String applyType, User user,String reqTime);
	
	/**
	 * 根据编码（code）查询
	 * @param code
	 * @return
	 */
	public ApplicationBasicInfo findByCode(String code);
	
	/**
	 * 获得项目指标列表
	 * @param basicType 基本支出类型 1-人员支出 2-公用支出
	 * @param parentCode  父节点代码
	 * @param year  年度
	 * @param qName 查询字段：科目名称
	 * @param deptId 
	 * @return 节点id 节点名称 节点代码 父节点代码
	 */
	public List<Object[]> getOutComeSubject(String basicType, String parentCode, String year, String qName,String indexType, String proId,String indexName,String deptName);
	/**
	 * 项目支出明细列表,根据parentCode作为KEY存入map集合
	 * @param basicType 基本支出类型 1-人员支出 2-公用支出
	 * @param parentCode  父节点代码
	 * @param year  年度
	 * @param qName 查询字段：科目名称
	 * @return 节点id 节点名称 节点代码 父节点代码
	 */
	public Map<String,Integer> getPidMap(String basicType, String parentCodes, String year, String qName);

	/**
	 * 获得某项目具体的经济支出科目
	 * @param id
	 * @return
	 */
	public List<Object[]> getOutDetail(String projectId);
	
	/**
	 * 
	 * @Description: 事前申请退回
	 * @param @param id
	 * @param @return
	 * @param @throws Exception   
	 * @return String  
	 * @throws
	 * @author 赵孟雷
	 * @date 2019年10月8日
	 */
	public String  ApplyReCall(Integer id)  throws Exception ;

	/**
	 * 获得当日最大的申请单编码，最后五位
	 * @Author 张迅
	 * @Date 2020年1月13日
	 * @Params 
	 * @Return
	 */
	public Integer getMaxCodeToday5();
	
	/**
	 * 自动生成摘要
	 * @Author 张迅
	 * @Date 2020年1月13日
	 * @Params 
	 * @Return
	 */
	public String getDraft(Integer applyType, String userName);

	public void saveTravel(ApplicationBasicInfo bean,
			TravelAppliInfo travelBean, User user,String studentsJson,String travelPeop,String files,
			String outsideTraffic,						//城市间交通费Json
			String inCity,						//市内交通费Json
			String hotelJson,						//住宿费Json
			String otherJson,						//其他费Json
			String otherJsons,
			String indexJsons,						//预算指标Json
			String foodJson						//伙食费Json
			)  throws Exception;
	
	/**
	 * 市内公务非公共交通方式差旅申请新增和修改的保存
	* <p>Description: </p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年8月15日
	 */
	public void saveTravelCity(ApplicationBasicInfo bean,
			TravelAppliInfo travelBean, User user,String travelPeop,String files)  throws Exception;

	public void saveOfficeCar(ApplicationBasicInfo bean, User user,
			String officeCar, String files) throws Exception;

	public void saveRecp(User user, ApplicationBasicInfo bean,
			ReceptionAppliInfo receptionBean, String observePlanJson, String foodJson,
			String otherJson, String files, String recePeop, String jdghfiles) throws Exception;

	public void saveTrain(User user, ApplicationBasicInfo bean,
			TrainingAppliInfo trainingBean, String trainPlan, String files, String trainLecturer, String zongheJson, String lessonJson, String hotelJson, String foodJson, String trafficJson1, String trafficJson2) throws Exception;
	
	/**
	 * 参加培训
	* <p>Description: </p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年5月20日
	 */
	public void saveAttendTrain(User user, ApplicationBasicInfo bean,
			TravelAppliInfo travelBean, String files) throws Exception;

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
			String travelWayJson,                   //出行方式json
			String abroadPeopleJson, String files) throws Exception;


	public Pagination reimbPageList(ApplicationBasicInfo bean, int pageNo,
			int pageSize, Integer type, User user, String rFlowStauts);
	public List<Lookups> getLookupsJson(String categoryCode,String blanked,String selected);

	public List<TrainTeacherCost> getTeacherMingxi(Integer id, String costType);

	/**
	 * 查询公务出国费用明细
	 * @param gId
	 * @return
	 */
	public List<AbroadExpenseInfo> getExpenseDetail(Integer gId);
	
	
	/**
	 * 查询差旅费和会务、培训费
	 * @param oID
	 * @return 
	 */
	public List<ReceptionOther> getReceptionOther(ReceptionOther bean, User user);
	/**
	 * 查询多选指标
	 * @param pID
	 * @return 
	 */
	public List<BudgetMessageList> getBudgetMessageList(BudgetMessageList bean, User user);
	
	/**
	 * 通过科目编号获取指标项目
	 * @param id
	 * @return
	 */
	public List<TProExpendDetail> getProName(String year,String deptId,String number,String proId);
	
	/**
	 * 通过科目编号获取指标明细
	 * @param id
	 * @return
	 */
	public List<TProExpendDetail> getSubjectDetail(String proId,String subCode);
}
