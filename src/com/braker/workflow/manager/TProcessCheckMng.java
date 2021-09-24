package com.braker.workflow.manager;


import java.util.List;

import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Depart;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgcheck.model.PurchaseCheckInfo;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;

/**
 * 流程审批的service抽象类
 * @author 李安达
 * @createtime 2019-04-24
 * @updatetime 2019-04-24
 */
public interface TProcessCheckMng extends BaseManager<TProcessCheck>{
	
	
	
	/**
	 * 流程审批
	 * @author 李安达
	 * @createtime 2019-04-24
	 * @updatetime 2019-04-24
	 */
	public CheckEntity checkProcess( TProcessCheck checkBean, CheckEntity bean, User user,String FBusiArea,String checkUrl,String lookUrl,String files)throws Exception;
	
	/**
	 * 流程审批通用事项申请专用
	 * @author 陈睿超
	 * @createtime 2019-08-09
	 * @updatetime 2019-08-09
	 */
	public CheckEntity checkProcessTYSXSQ( TProcessCheck checkBean, CheckEntity bean, User user,String FBusiArea,String checkUrl,String lookUrl,String files,String suggestDepId,ApplicationBasicInfo abi)throws Exception;
	
	/**
	 * 流程审批通用事项报销专用
	 * @author 陈睿超
	 * @createtime 2019-08-09
	 * @updatetime 2019-08-09
	 */
	public CheckEntity checkProcessTYSXBX( TProcessCheck checkBean, CheckEntity bean, User user,String FBusiArea,String checkUrl,String lookUrl,String files,ReimbAppliBasicInfo rabi)throws Exception;
	
	/**
	 * 添加流程审批记录
	 * @param flowId
	 * @param foId
	 * @param user
	 * @param roleName
	 * @return
	 */

	public Integer addCheckHistory(TProcessCheck processCheck,Integer flowId,String beanCode,String byUserId,int overFlag, User user,TNodeData node,String files)throws Exception;
	
	/**
	 * 
	 * <p>Title: addFProHeadCheckHistory</p>  
	 * <p>Description: 添加流程项目负责人的审批记录</p>  
	 * @param processCheck
	 * @param flowId
	 * @param beanCode
	 * @param byUserId
	 * @param overFlag
	 * @param user
	 * @param node
	 * @param files
	 * @return
	 * @throws Exception
	 * @author 陈睿超
	 * @createtime 2020年11月5日
	 * @updator 陈睿超
	 * @updatetime 2020年11月5日
	 */
	Integer addFProHeadCheckHistory(TProcessCheck processCheck,Integer flowId,String beanCode,String byUserId,int overFlag, User user,TNodeData node,String files) throws Exception;
	
	
	/**
	 * 历史审批记录
	* @author 李安达
	 * @createtime 2019-04-24
	 * @updatetime 2019-04-24
	 */
	public List<TProcessCheck> checkHistory(Integer FPId, String foCode)throws Exception;
	
	
	/**
	 * 根据状态获得审批记录
	 */
	public List<TProcessCheck> findByStauts(Integer FPId, String foCode,String stauts)throws Exception;
	
	/**
	 * 根据状态获得审批记录,这里是右侧显示，需要去重复
	 */
	public List<TProcessCheck> findByStautsAndDistinct(Integer FPId, String foCode,String stauts) throws Exception;
	
	/**
	 * 送审，添加审批流程信息
	 * @author 李安达
	 * @createtime 2019-04-24
	 * @updatetime 2019-04-24
	 */
	public Integer addProcessCheck( String departCode,String tableName,String beanCodeField,String beanCode,String FBusiArea,User user)throws Exception;
	
	
	/**
	 * 	 * 获得相应业务的工作流
	 * 李安达
	 * @param FBusiArea 业务范围
	 * @param operUserId
	 * @param departId
	 * @param foCode
	 * @param nextKey
	 * @param tableName 数据库表名（一定要是数据库的表名！类的表名没用。）
	 * @param beanCodeField   编码的字段名
	 * @param beanCode   编码字段值
	 * @param checkResult  0不通过,  1通过
	 * @return
	 */
	public List<TNodeData> getNodeConf(String operUserId,String FBusiArea, String departId, String foCode,String nextKey,String  tableName,String beanCodeField,String beanCode,String checkResult);
	
	/**
	 * <p>Title: getNodeConfZCandCG</p>  
	 * <p>Description: 获得相应业务的工作流包含项目负责人</p>  
	 * @param operUserId
	 * @param FBusiArea
	 * @param departId
	 * @param foCode
	 * @param nextKey
	 * @param tableName
	 * @param beanCodeField
	 * @param beanCode
	 * @param checkResult
	 * @param indexId 预算指标Id
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年11月4日
	 * @updator 陈睿超
	 * @updatetime 2020年11月4日
	 */
	public List<TNodeData> getNodeConfZCandCG(String operUserId,String FBusiArea, String departId, String foCode,String nextKey,String  tableName,String beanCodeField,String beanCode,String checkResult,Integer indexId);
	
	/**
	 * 获得下一级审批节点
	 * @author 李安达
	 * @createtime 2019-04-24
	 * @updatetime 2019-04-24
	 */
	public TNodeData getNextCheckKey( TNodeData node,String tableName,String beanCodeField,String beanCode,String checkResult)throws Exception;
	
	/**
	 * 修改审批历史状态
	 * @param FPId
	 * @param foId
	 */
	public void updateStauts(Integer FPId,String foCode)throws Exception;
	
	/**
	 * 支出申请中根据前台传过来的类型返回不同的流程代码
	 * @param type 前天传过来的类型 1-通用是申请，2-会议申请，3-培训申请，4-差旅申请，5-公务接待申请，6-公务用车申请，7-公务出国申请		
	 * @param FBusiArea
	 * @param departId
	 * @param foCode
	 * @param nextKey
	 * @return
	 * @author 陈睿超
	 * @createTime 2019年8月4日
	 * @updateTime 2019年8月4日
	 */
	String JudgmentProcess(String type);
	
	/**
	 * 
	 * <p>Title: JudgmentProcessName</p>  
	 * <p>Description: 事前申请返回中文</p>  
	 * @param type type 前天传过来的类型 1-通用是申请，2-会议申请，3-培训申请，4-差旅申请，5-公务接待申请，6-公务用车申请，7-公务出国申请	
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年11月18日
	 * @updator 陈睿超
	 * @updatetime 2020年11月18日
	 */
	String JudgmentProcessName(Integer type);
	
	
	/**
	 * 事后报销返回业务范围方法
	 * @param type
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年4月16日
	 * @updator 陈睿超
	 * @updatetime 2020年4月16日
	 */
	String JudgmentProcessOff(String type);
	
	/**
	 * 
	 * <p>Title: JudgmentProcessOffName</p>  
	 * <p>Description: 时候报销返回名字</p>  
	 * @param type
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年11月19日
	 * @updator 陈睿超
	 * @updatetime 2020年11月19日
	 */
	String JudgmentProcessOffName(String type);
	
	Integer JudgmentApplyType(String FBusiArea);
	
	/**
	 * 根据当前审批节点，得到审批以后的下一节点
	 * @param key 当前节点
	 * @param flowId  流程id
	 * @param checkResult  审批结果  0不通过,  1通过
	 * @return
	 */
	Integer getNextKey(TNodeData node,String  tableName,String beanCodeField,String beanCode,String checkResult)throws Exception;
	
	/**
	 * 
	* @author:安达
	* @Title: getHistoryNodes 
	* @Description: 审批历史节点
	* @param FPId  流程id
	* @param foCode  对象编码
	* @param stauts  状态  0是当前流程正在审批的。  1是历史审批
	* @return
	* @throws Exception
	* @return String    返回类型 
	* @date： 2019年9月29日上午11:03:17 
	* @throws
	 */
	public String getHistoryNodes(String FBusiArea ,String departId,String foCode) ;
	
	/**
	 * 
	 * @Description: 自定义内部指标调整的流程
	 * @author 汪耀
	 * @param @param userId
	 * @param @param departId
	 * @param @param foCode
	 * @param @param checkResult
	 * @param @return    
	 * @return List<TNodeData>
	 */
	public List<TNodeData> getInSideAdjustNodeConf(String userId, String departId, String foCode);
	
	/**
	 * 
	 * @Description: 内部指标调整的审批
	 * @author 汪耀
	 * @param @param checkBean
	 * @param @param bean
	 * @param @param user
	 * @param @param checkUrl
	 * @param @param lookUrl
	 * @param @param files
	 * @param @param departId
	 * @param @return
	 * @param @throws Exception    
	 * @return CheckEntity
	 */
	public CheckEntity inSideAdjustCheckProcess(TProcessCheck checkBean, CheckEntity bean, User user, String checkUrl, String lookUrl, String files, String departId)throws Exception;
	
	/**
	 * 查询被审批对象是否在当次流程中已经发生过审批
	 * @param code 被审批的对象编码
	 * @param status 审批信息状态 1:历史记录；0:默认
	 * @return true:已经有审批发生,false:没有
	 * @author 陈睿超
	 * @createTime2019年12月17日
	 * @updateTime2019年12月17日
	 */
	public Boolean findbyCode(String code , String status);
	
	/**
	 * 
	 * @Title findbyCodeES 
	 * @Description 查询被审批对象是否在当次流程中已经发生过审批(二上)
	 * @author 汪耀
	 * @Date 2020年2月20日 
	 * @param code 对象编码
	 * @param status 审批信息状态		0-默认	1-历史记录
	 * @param FPId 流程id，区分流程是一上还是二上
	 * @return 设定文件 
	 * @return Boolean 返回类型 
	 * @throws
	 */
	public Boolean findbyCodeES(String code, String status, Integer FPId);
	
	/*
	 * 获得去重复以后的右侧工作流
	 */
	public List<TNodeData> getDistinctNodeConf(String operUserId,String FBusiArea, String departId,String foCode,String nextKey,String  tableName,String beanCodeField,String beanCode,String checkResult);

	/**
	 * 获取已经去重复了的节点集合
	 */
	public List<TNodeData> getDistinctNodeList(String operUserId,String FBusiArea, String departId,String foCode,String nextKey,String  tableName,String beanCodeField,String beanCode,String checkResult) throws Exception;

	/**
	 * 截取审批记录到第一个不同意的点为止
	 * <p>Title: getTrueResult</p>  
	 * <p>Description: </p>  
	 * @param checkList
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年12月15日
	 * @updator 陈睿超
	 * @updatetime 2020年12月15日
	 */
	List<TProcessCheck> getTrueResult(List<TProcessCheck> checkList);

}
