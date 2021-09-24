package com.braker.icontrol.expend.reimburse.manager;

import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Depart;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.expend.apply.model.AbroadAppliInfo;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.apply.model.MeetingAppliInfo;
import com.braker.icontrol.expend.apply.model.ReceptionAppliInfo;
import com.braker.icontrol.expend.apply.model.TrainingAppliInfo;
import com.braker.icontrol.expend.apply.model.TravelAppliInfo;
import com.braker.icontrol.expend.reimburse.model.CostDetailInfo;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.InvoiceCouponInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbPayeeInfo;
import com.braker.workflow.entity.TProcessCheck;

/**
 * 申请报销的service抽象类
 * @author 叶崇晖
 * @createtime 2018-08-08
 * @updatetime 2018-08-08
 */
public interface ReimbAppliMng extends BaseManager<ReimbAppliBasicInfo>{
	
	/*
	 * 分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-08
	 * @updatetime 2018-08-08
	 */
	public Pagination pageList(ReimbAppliBasicInfo bean, String reimburseType, int pageNo, int pageSize, User user);
	/*
	 * 保存申请报销的审批信息
	 * @author 叶崇晖
	 * @createtime 2018-08-14
	 * @updatetime 2018-08-14
	 */
	public void saveCheckInfo(TProcessCheck checkBean,ReimbAppliBasicInfo bean, User user,String files) throws Exception;
	
	/**
	 * 
	* @author:安达
	* @Title: saveCheckInfoTYSXBX 
	* @Description: 通用事项事前申请
	* @param checkBean
	* @param bean
	* @param user
	* @param files
	* @throws Exception
	* @return void    返回类型 
	* @date： 2019年8月13日下午11:45:27 
	* @throws
	 */
	public void saveCheckInfoTYSXBX(TProcessCheck checkBean,ReimbAppliBasicInfo bean, User user,String files)  throws Exception;
	/*
	 * 报销申请新增和修改的保存
	 * @author 叶崇晖
	 * @createtime 2018-08-10
	 * @updatetime 2018-08-10
	 */
	public void save(ReimbAppliBasicInfo bean, ReimbPayeeInfo payeeBean, String mingxi, String fapiao, String files, User user) throws Exception;
	
	/*
	 * 报销申请删除
	 * @author 叶崇晖
	 * @createtime 2018-08-17
	 * @updatetime 2018-08-17
	 */
	public void delete(Integer id,String fid ,User user);
	
	/*
	 * 审批分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-13
	 * @updatetime 2018-08-13
	 */
	public Pagination checkPageList(ReimbAppliBasicInfo bean, int pageNo,int pageSize, User user);
	
	/*
	 * 台账分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-14
	 * @updatetime 2018-08-14
	 */
	public Pagination ledgerPageList(String type, String applyString,ReimbAppliBasicInfo bean, int pageNo,int pageSize, User user);
	
	/*
	 * 财务审定分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-16
	 * @updatetime 2018-08-16
	 */
	public Pagination auditPageList(ReimbAppliBasicInfo bean, int pageNo,int pageSize, User user);
	
	/*
	 * 出纳受理分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-22
	 * @updatetime 2018-08-22
	 */
	public Pagination cashierPageList(ReimbAppliBasicInfo bean, int pageNo,int pageSize, User user);
	
	/**
	 * 查询需要导出的全部台账信息
	 * @author 叶崇晖
	 * @return
	 */
	public List<ReimbAppliBasicInfo> ledgerList(String applyString,String userId);
	
	/**
	 * 生成需要导出的台账HSSFWorkbook
	 * @author 叶崇晖
	 * @param drLedgerData
	 * @param rLedgerData
	 * @param filePath
	 * @return
	 */
	public HSSFWorkbook exportLedger(List<DirectlyReimbAppliBasicInfo> drLedgerData, List<ReimbAppliBasicInfo> rLedgerData, String filePath);
	
	/**
	 * 部门经费使用情况列表
	 * @author 焦广兴
	 * @param searchCode 报销单编号
	 * @param searchName 指标名字
	 * @createtime 2019-03-22
	 * @updatetime 2019-04-02
	 */
	public Pagination getData26(Depart depart,String itemName,String year, String dates, String datee, int pageNo, int pageSize,
			String searchCode,String searchName,User user);

	/**
	 * 月份经费使用情况列表
	 * @author 焦广兴
	 * @createtime 2019-03-22
	 * @updatetime 2019-03-22
	 */
	public Pagination getData27(Depart depart,String itemName,String year, int pageNo, int pageSize,String searchCode,String searchName,User user);
	
	public Pagination getData21(Depart depart, String indexType, String year,
			int pageNo, int pageSize, String searchName, String searchContent);
	
	public Pagination getData22(Depart depart, String year, int pageNo, int pageSize,
			String searchName, String searchContent);
	
	public Pagination getData23(Depart depart, String indexType, String year,
			int pageNo, int pageSize, String searchName, String searchContent);
	
	public Pagination getData24(Depart depart, String year, int pageNo, int pageSize,
			String searchName, String searchContent);
	
	/**
	 * 
	 * @Description: 申请报销回退
	 * @param @param id
	 * @param @return
	 * @param @throws Exception   
	 * @return String  
	 * @throws
	 * @author 赵孟雷
	 * @date 2019年10月8日
	 */
	public String  reimburseReCall(Integer id)  throws Exception ;
	
	List<ReimbAppliBasicInfo> findByLoanId(String id);
	
	List<ReimbAppliBasicInfo> findByLoanIdCX(String id,String code);
	
	public void saveMeeting(ReimbAppliBasicInfo bean, MeetingAppliInfo meetingBean,
			String form1, String payerinfoJson, String files, User user, String meetPlan, String mingxi) throws Exception ;
	
	public List<CostDetailInfo> findByRId(Integer rId);
	
	public List<CostDetailInfo> findByDrId(Integer dRId);
	
	public List<InvoiceCouponInfo> findfp(Integer cId);
	
	public void saveTravel(ReimbAppliBasicInfo bean, ReimbPayeeInfo payeeBean,String travelPeop,
			String outsideTraffic,
			String inCity,						//市内交通费Json
			String hotelJson,						//住宿费Json
			String foodJson,
			String otherJson,						//会议、培训费Json
			String payerinfoJson,String studentsJson,String indexJsons,
			String form1, String form2, String form3, String form4,
			String form5, String files, User user ) throws Exception ;
	
	/**
	 * 市内公务出行非公共交通报销
	* <p>Description: </p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年8月16日
	 */
	public void saveTravelCity(ReimbAppliBasicInfo bean, String payerinfoJson,String travelPeop, String files, User user ) throws Exception;
	/**
	 * 参加培训报销
	* <p>Description: </p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年5月26日
	 */
	public void saveAttendTrain(ReimbAppliBasicInfo bean, ReimbPayeeInfo payeeBean,String travelPeop,
			String outsideTraffic,
			String inCity,						//市内交通费Json
			String hotelJson,						//住宿费Json
			String foodJson,
			String payerinfoJson,String indexJsons,
			String form1, String form2,String files, User user ,TravelAppliInfo travelAppliInfo) throws Exception ;
	
	public void saveReception(ReimbAppliBasicInfo bean,
			String form1, String form2, String form3, String form4,
			String form5, String files, User user,
			ReceptionAppliInfo receptionAppliInfo,
			String hotelJson,						 //住宿费Json
			String foodJson,                         //餐费或伙食费
			String otherJson,                        //其他费用
			String payerinfoJson,                     //收款人json
			String peopleJson, String accompanyPeopJson, String observePlanJson
			) throws Exception;
	
	public void saveAbroad(ReimbAppliBasicInfo bean,String payerinfoJson,
			String form1, String form2, String form3, String form4,
			String form5,
			String travelJson,	                    //国际旅费json
			String trafficJson1,					//城市间交通费和国外城市间交通费
			String hotelJson,	                    //住宿费json
			String foodJson,						//伙食费json
			String feeJson,							//公杂费json
			String feteJson,						//宴请费json
			String otherJson,						//其他收入json
			String abroadPlanJson,					//出访计划
			AbroadAppliInfo abroadBean,             //出国信息
			String files, User user, String abroadPeopleJson)
			throws Exception;
	
	public void saveTrain(ReimbAppliBasicInfo bean,
			TrainingAppliInfo trainingBean, String form1, String form2,
			String form3, String form4, String form5, String trainLecturer,
			String trainPlan, String zongheJson, String lessonJson,
			String trafficJson1, String trafficJson2, String payerinfoJson,
			String files, String hotelJson, String foodJson, User user) throws Exception;
	
	public void saveCar(ReimbAppliBasicInfo bean, String reimburseCartJson,String payerinfoJson,
			String arry, String files, User user) throws Exception;
	
	public void saveCommon(ReimbAppliBasicInfo bean, ReimbPayeeInfo payeeBean,
			String arry, String files, User user,String form1,String payerinfoJson) throws Exception;
	
	public void saveCurrent(ReimbAppliBasicInfo bean, ReimbPayeeInfo payeeBean,
			String arry, String files, User user,String form1,String payerinfoJson) throws Exception;
		
	public void saveContract(ReimbAppliBasicInfo bean, ReimbPayeeInfo payeeBean,
			String arry, String files, User user,String form1,String payerinfoJson) throws Exception;
	
		/**
	 * 更新出纳受理状态为1，已受理
	 * @param rBean
	 * @author 陈睿超
	 * @createtime 2020年1月10日
	 */
	void updateCashier(ReimbAppliBasicInfo rBean);	
	
	/**
	 * 根据报销申请单主键
	 * @param rId
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年4月23日
	 * @updator 陈睿超
	 * @updatetime 2020年4月23日
	 */
	List<InvoiceCouponInfo> findrId(Integer rId);
	
	/**
	 * 删除合同报销
	 * @param id
	 * @param user
	 * @author wanping
	 * @createtime 2020年8月29日
	 * @updator wanping
	 * @updatetime 2020年8月29日
	 */
	public void deleteEnforcingList(Integer id, User user);
	
	
	public void saveAppCommon(ReimbAppliBasicInfo bean, String fpIds,
			String mingxi, String files, User user, String form1,
			String payerinfoJson) throws Exception;
	
	public void saveAppCar(ReimbAppliBasicInfo bean, String fpIds,
			String mingxi, String files, User user, 
			String payerinfoJson) throws Exception;
	
	public void saveAppMeeting(ReimbAppliBasicInfo bean,
			MeetingAppliInfo meetingBean, String fpIds, String mingxi,
			String files, User user, String meetPlan, String payerinfoJson) throws Exception;
	
	public void saveAppTrain(ReimbAppliBasicInfo bean,
			TrainingAppliInfo trainingBean, String zhysFpIds,
			String hotelFpIds, String foodFpIds, String traffic1FpIds,
			String traffic2FpIds, String trainLecturer, String trainPlan,
			String zongheJson, String lessonJson, String hotelJson,
			String foodJson, String trafficJson1, String trafficJson2,
			String payerinfoJson, String files, User user) throws Exception;
	
	
	public void saveAppReception(ReimbAppliBasicInfo bean, String hotelFpIds,
			String foodFpIds, String trafficFpIds, String rentFpIds,
			String otherFpIds, String files, User user,
			ReceptionAppliInfo receptionAppliInfo, String hotelJson,
			String foodJson, String otherJson, String payerinfoJson) throws Exception;
	
	public void saveAppAbroad(ReimbAppliBasicInfo bean, String payerinfoJson,
			String travelFpIds, String hotelFpIds, String feteFpIds,
			String traffic1FpIds, String otherFpIds, String travelJson,
			String trafficJson1, String hotelJson, String foodJson,
			String feeJson, String feteJson, String otherJson,
			String abroadPlanJson, AbroadAppliInfo abroadBean, String files,
			User user) throws Exception;
	
	public void saveAppContract(ReimbAppliBasicInfo bean, String files,
			User user, String fpIds, String payerinfoJson) throws Exception;
	
	public void saveAppTravel(ReimbAppliBasicInfo bean, String files,
			User user, String trafficFpIds, String hotelFpIds,
			String payerinfoJson, String travelPeop, String outsideTraffic,
			String inCity, String hotelJson, String foodJson) throws Exception;
	
	public void savePurchase(ReimbAppliBasicInfo bean,
			ReimbPayeeInfo payeeBean, String files, User user, String form1) throws Exception;
	
	
	
	
}
