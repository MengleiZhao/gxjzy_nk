package com.braker.icontrol.budget.project.manager;

import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.ui.ModelMap;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.core.model.Depart;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.BigProjectInfo;
import com.braker.icontrol.budget.project.entity.PerformanceIndicatorModel;
import com.braker.icontrol.budget.project.entity.TProBasicCheckUpdate;
import com.braker.icontrol.budget.project.entity.TProBasicFunds;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.entity.XmDept;
import com.braker.icontrol.contract.Formulation.model.ExecuteProject;
import com.braker.workflow.entity.TProcessCheck;

public interface TProBasicInfoMng extends BaseManager<TProBasicInfo>{

	/**
	 * 保存基本预算
	 * @param bean 需要保存的对象
	 * @param user 操作人
	 * @param opType 操作类型，zc-暂存，sb-申报
	 * @param lxyjFiles 立项依据附件
	 * @param ssfaFiles 实施方案附件
	 * @param totalityPerformanceJson 绩效指标
	 */
	public void saveProject(TProBasicInfo bean, User user, String opeType,String outcomeJson,String purchaseJson,String purManyYearsProJson) throws Exception;
	/**
	 * 保存项目预算
	 * @param bean 需要保存的对象
	 * @param user 操作人
	 * @param opType 操作类型，zc-暂存，sb-申报
	 * @param lxyjFiles 立项依据附件
	 * @param ssfaFiles 实施方案附件
	 * @param totalityPerformanceJson 绩效指标
	 */
	public void saveProject1(TProBasicInfo bean, User user, String saveType, String outcomeJson,String purchaseJson,String purchaseJsonSE,
			String fundsJson, String lxyjFiles, String ssfaFiles,String totalityPerformanceJson,String purManyYearsProJson,String purManyYearsProJsonSE) throws Exception;
	
	/**
	 * 
	* @author:安达
	* @Title: saveReview 
	* @Description: 保存项目复核信息
	* @param bean
	* @return
	* @return TProBasicInfo    返回类型 
	* @date： 2019年5月27日下午5:35:09 
	* @throws
	 */
	public TProBasicInfo  saveReview(TProBasicInfo bean,User user);
	
	
	/**
	 * 分页查询
	 * @param bean 实体对象，存放查询条件
	 * @param user 操作人
	 * @param isOffice 是否单位角色
	 * @param pageNo 当前页码
	 * @param pageSize 总页数
	 * @return
	 */
	public Pagination pageList(TProBasicInfo bean, User user, boolean isOffice, int pageNo, int pageSize);
	/**
	 * 分页查询
	 * @param bean 根据查询条件统计所有的金额信息
	 * @param user 操作人
	 * @param isOffice 是否单位角色
	 * @return
	 */
	public List<TProBasicInfo> pageLists(TProBasicInfo bean, User user, boolean isOffice);
	
	/**
	 * 不分页查询
	 */
	public List<TProBasicInfo> getList();
	
	/**
	 * 获得经济科目列表
	 * @param basicType 基本支出类型 1-人员支出 2-公用支出
	 * @param parentCode  父节点代码
	 * @param year  年度
	 * @param qName 查询字段：科目名称
	 * @return 节点id 节点名称 节点代码 父节点代码
	 */
	public List<Object[]> getOutComeSubject(String basicType, String parentCode, String year, String qName);
	
	/**
	 * 
	* @author:安达
	* @Title: getOutComeSubject 
	* @Description: 根据年度和经济科目编码串获取经济科目列表
	* @param codes
	* @param year
	* @return
	* @return List<Object[]>    返回类型 
	* @date： 2019年10月11日下午6:52:28 
	* @throws
	 */
	public List<Object[]> getOutComeSubject(String codes, String year);
	/**
	 * 经济科目列表,根据parentCode作为KEY存入map集合
	 * @param basicType 基本支出类型 1-人员支出 2-公用支出
	 * @param parentCode  父节点代码
	 * @param year  年度
	 * @param qName 查询字段：科目名称
	 * @return 节点id 节点名称 节点代码 父节点代码
	 */
	public Map<String,Integer> getPidMap(String basicType, String parentCodes, String year, String qName);
	/**
	 * 下载附件
	 * @param type 附件类型
	 * @param proId 项目id
	 * @param savePath 下载后保存位置
	 * @return
	 */
	public String downFile(String type, String proId, String savePath);
	
	/**
	 * 展示合同编号等相关信息（合同新增时用）
	 * @param tProBasicInfo
	 * @param pageNo
	 * @param pageSize
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-07-02
	 */
	public Pagination fProCode(TProBasicInfo tProBasicInfo, int pageNo, int pageSize);
	
	/**
	 * 项目结转
	 * @param user
	 * @param proId 
	 */
	public void overPro(User user, String proId);
	
	/**
	 * 为预算控制数获取项目信息
	 * @param year 年度
	 * @param libType 所属库类型
	 * @return
	 */
	public List<TProBasicInfo> proInfoForControlNum(Date date, String libType);

	/**
	 * 根据项目编号查询
	 * @param code 项目编号
	 * @return
	 */
	TProBasicInfo findbyCode(String code);

	
	/**
	 * 为预算控制数获取项目信息
	 * @param year 年度
	 * @param libType 所属库类型
	 * @return
	 */
	public Pagination proInfoForControlNumP(TProBasicInfo bean,Date date, String libType, Integer pageNo, Integer pageSize);

	
	
	/**
	 * 一上分页查询
	 * @param bean 实体对象，存放查询条件
	 * @param user 操作人
	 * @param isOffice 是否单位角色
	 * @param pageNo 当前页码
	 * @param pageSize 总页数
	 * @return
	 */
	public Pagination yspageList(TProBasicInfo bean, User user, int pageNo, int pageSize,String sbkLx);
	
	
	/**
	 * 一下查询
	 * @param bean 实体对象，存放查询条件
	 * @param user 操作人
	 * @param isOffice 是否单位角色
	 * @param pageNo 当前页码
	 * @param pageSize 总页数
	 * @return
	 */
	public Pagination yxpageList(TProBasicInfo bean, User user, int pageNo, int pageSize,String sbkLx);
	
	/*
	 * 叶崇晖
	 * 9/17
	 * 一上批量申报
	 */
	public void yssb(String fproIdLi,String fproIdLi2);
	
	/*
	 * 叶崇晖
	 * 9/17
	 * 一上批量申报
	 */
	public void yssp(String fproIdLi);
	
	/*
	 * 叶崇晖
	 * 9/17
	 * 一下
	 */
	public void yx(String fproIdLi, String commitAmountLi,String fext12Li);
	
	/**
	 * 将前台传入的项目支出明细转换成list对象
	 * @author 叶崇晖
	 * @param file
	 * @return
	 */
	public List<TProExpendDetail> outcomeCollect(File file); 
	
	
	/**
	 * 保存项目申报的审批
	 * @author 叶崇晖
	 * @param bean
	 * @param user
	 */
	public void saveCheck(TProBasicInfo bean, TProcessCheck checkBean, String files, User user,String fundJson,String outcomeJson) throws Exception;

	/**
	 * 导出项目台账
	 * @param dataList 数据
	 * @param filePath 文件路径
	 * @return 放入数据的文件对象
	 */
	public HSSFWorkbook exportExcel(List<TProBasicInfo> dataList,
			String filePath);
	
	
	/**
	 * 导出项目绩效目标列表
	 * @param dataList 数据
	 * @param filePath 文件路径
	 * @return 放入数据的文件对象
	 */
	public HSSFWorkbook exportExcePerformance(List<PerformanceIndicatorModel> dataList,
			String filePath);
	
	
	/**
	 * 删除项目
	 * @param id
	 */
	public void deleteProject(Integer id);
	/**
	 * 修改项目所在库
	 * @param id
	 */
	public void updateProjectLibrary(Integer id);
	
	/**
	 * 一下预算控制数分解附件上传
	 * @param id 项目基本信息主键
	 * @param filesName 附件名称
	 */
	void filesUpdate(String id ,String filesName);
	
	
	/**
	 * 项目结转保存
	 * @param bean
	 * @return
	 */
	public TProBasicInfo oversave(TProBasicInfo bean,String jxmingxi);
	
	
	/**
	 * 项目延期预警
	 * @author 沈帆
	 */
	public Pagination proDelayList(int pageNo, int pageSize,String fProCode,String fProName,String deptName);
	
	
	public List<TProBasicInfo> getbasiProByIds(String ids);
	
	public String  reCall(Integer id,User user)  throws Exception ;
	
	public void updateExportStatesByIds(String ids) throws Exception ;
	
	/**
	 * 
	 * @Description: 修改选中项的收报状态
	 * @author 汪耀
	 * @param @param sbIdList
	 * @param @param fExportStauts    
	 * @return void
	 */
	public void receiveReport(String receiveIdList, String fExportStauts);
	
	/**
	 * 
	 * @Description: 校验二级分类名称是否重复
	 * @author 汪耀
	 * @param @param departId
	 * @param @param year
	 * @param @param name
	 * @param @return    
	 * @return boolean
	 */
	public boolean checkSecondLevelName(String departId, String year, String code, String FProCode);
	
	/**
	 * 校验基本支出明细中选择的经济分类科目是否是前面选择的二级分类下的子节点
	 * @param bean
	 * @return
	 * @author 陈睿超
	 * @createTime2019年11月7日
	 * @updateTime2019年11月7日
	 */
	public boolean checkSecondCode(TProBasicInfo bean);
	
	/**
	 * 
	 * @Description: 导出项目申报页面
	 * @author 汪耀
	 * @param @param bean
	 * @param @param pimList
	 * @param @param tpdList
	 * @param @param tpcList
	 * @param @param filePath
	 * @param @return    
	 * @return HSSFWorkbook
	 */
	public HSSFWorkbook proExportExcel(TProBasicInfo bean, List<TProBasicFunds> tpbfList, List<PerformanceIndicatorModel> pimList, List<TProExpendDetail> tpedList, List<TProcessCheck> tpcList, String filePath);
	
	/**
	 * 
	 * @Description: 导出基本支出申报页面
	 * @author 汪耀
	 * @param @param bean
	 * @param @param tpbfList
	 * @param @param tpedList
	 * @param @param tpcList
	 * @param @param filePath
	 * @param @return    
	 * @return HSSFWorkbook
	 */
	public HSSFWorkbook basicExpenditureExport(TProBasicInfo bean, List<TProBasicFunds> tpbfList, List<TProExpendDetail> tpedList, List<TProcessCheck> tpcList, String filePath);
	
	/**
	 * 加载审批记录数据
	 * @param bean 查询条件
	 * @return
	 * @author 陈睿超
	 * @createTime2019年11月13日
	 * @updateTime2019年11月13日
	 */
	Pagination record(TProcessCheck bean,User user,Integer pageNo, Integer pageSize);
	
	/**
	 * 
	 * @Description: 审批页面的分页查询
	 * @author 汪耀
	 * @param @param bean
	 * @param @param pageNo
	 * @param @param pageSize
	 * @param @return    
	 * @return Pagination
	 */
	public Pagination checkUpdatePageList(TProBasicCheckUpdate bean, int pageNo, int pageSize);
	
	/**
	 * 
	 * @Description: 比较修改前后bean的不同并将新值覆盖旧值并添加修改记录
	 * @author 汪耀
	 * @param @param oldBean
	 * @param @param newBean
	 * @param @param delIndex
	 * @param @param totalityPerformanceJson
	 * @param @param user
	 * @param @return
	 * @param @throws Exception    
	 * @return TProBasicInfo
	 */
	public TProBasicInfo compareFields(TProBasicInfo oldBean, TProBasicInfo newBean, String lxyjFiles, String ssfaFiles, String delIndex, String totalityPerformanceJson, User user) throws Exception;
	
	/**
	 * 他根据库别不一样查询(供采购选择项目申报单据使用)
	 * @param bean
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 * @author 陈睿超
	 * @createTime2019年12月4日
	 * @updateTime2019年12月4日
	 */
	Pagination proLibTypePageList(TProBasicInfo bean, Integer pageNo, Integer pageSize, User user);

	List<BigProjectInfo> findByFpId(String id);

	List<Lookups> getBigProjectLookupsJson(String selected);

	Pagination zxmList(TProBasicInfo bean, int pageNo, int pageSize, User user);

	public void importZxm(Integer fProId, User user)  throws Exception;

	List<ExecuteProject> zzxmList(String id);
	public String proReCall(Integer id) throws Exception;
	public Pagination deptList(Depart bean, String sort, String order,
			int pageIndex, int pageSize);
	public void saveDept(String id, String ids);
	public List<XmDept> xmDeptList(String id);
}
