package com.braker.workflow.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.assets.rece.model.Rece;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;
import com.braker.icontrol.expend.loan.model.Payment;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessPrintDetail;

public interface TProcessPrintDetailMng extends BaseManager<TProcessPrintDetail>{

	
	/**
	 * 根据流程审批记录返回打印表单中审批信息(事前申请)
	 * @param type
	 * @param bean
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年6月4日
	 * @updator 陈睿超
	 * @updatetime 2020年6月4日
	 */
	public List<TProcessCheck> applycheckList(String type,ApplicationBasicInfo bean,User user ) throws Exception;
	
	/**
	 * 根据流程审批记录返回打印表单中审批信息(事后报销)
	 * @param type
	 * @param rbean
	 * @param user
	 * @return
	 * @throws Exception
	 * @author 陈睿超
	 * @createtime 2020年6月4日
	 * @updator 陈睿超
	 * @updatetime 2020年6月4日
	 */
	public List<TProcessCheck> reimbcheckList(String type,ReimbAppliBasicInfo rbean ,User user ) throws Exception;

	/**
	 * 根据流程审批记录返回打印表单中审批信息(直接报销)
	 * @param rbean
	 * @param user
	 * @return
	 * @throws Exception
	 * @author 陈睿超
	 * @createtime 2020年6月5日
	 * @updator 陈睿超
	 * @updatetime 2020年6月5日
	 */
	public List<TProcessCheck> directlycheckList(DirectlyReimbAppliBasicInfo bean ,User user ) throws Exception;

	/**
	 *  根据流程审批记录返回打印表单中审批信息
	 * @param type 0-借款，1-还款
	 * @param bean
	 * @param pbean
	 * @param user
	 * @return
	 * @throws Exception
	 * @author 陈睿超
	 * @createtime 2020年6月5日
	 * @updator 陈睿超
	 * @updatetime 2020年6月5日
	 */
	public List<TProcessCheck> LoanBasicInfocheckList(String type,LoanBasicInfo bean,Payment pbean ,User user ) throws Exception;
	
	
	/**
	 * 新的方式组装审签数据方式
	 * @param bean
	 * @param rbean
	 * @param type
	 * @param user
	 * @return
	 * @throws Exception
	 * @author 陈睿超
	 * @createtime 2020年8月5日
	 * @updator 陈睿超
	 * @updatetime 2020年8月5日
	 */
	public List<TProcessPrintDetail> arrangeNewCheckDetail(ApplicationBasicInfo bean,ReimbAppliBasicInfo rbean ,String type,User user) throws Exception ;
	
	/**
	 * 组装审签数据（原合同）
	 * @param bean 合同信息
	 * @param user
	 * @return
	 * @throws Exception
	 * @author 陈睿超
	 * @createtime 2020年8月10日
	 * @updator 陈睿超
	 * @updatetime 2020年8月10日
	 */
	public List<TProcessPrintDetail> arrangeContractDetail(ContractBasicInfo bean) throws Exception ;
	
	/**
	 * 组装审签数据（变更合同）
	 * @param bean
	 * @return
	 * @throws Exception
	 * @author 陈睿超
	 * @createtime 2020年8月11日
	 * @updator 陈睿超
	 * @updatetime 2020年8月11日
	 */
	public List<TProcessPrintDetail> arrangeUptContractDetail(Upt bean) throws Exception ;
	
	/**
	 * 组装审签数据（事前、事后）
	 * @param checkList
	 * @param bean
	 * @param rbean
	 * @param type 0-事前申请，1-事后报销
	 * @param user
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年6月4日
	 * @updator 陈睿超
	 * @updatetime 2020年6月4日
	 */
	public List<TProcessPrintDetail> arrangeCheckDetail(ApplicationBasicInfo bean,ReimbAppliBasicInfo rbean ,String type,User user) throws Exception ;
	
	/**
	 * 组装审签数据（采购申请）
	 * @param bean
	 * @param rbean
	 * @param type
	 * @param user
	 * @return
	 * @throws Exception
	 */
	public List<TProcessPrintDetail> arrangeCGCheckDetail(PurchaseApplyBasic bean,String type,User user) throws Exception ;
	
	/**
	 * 组装审签数据(直接报销)
	 * @param bean
	 * @param rbean
	 * @param user
	 * @return
	 * @throws Exception
	 * @author 陈睿超
	 * @createtime 2020年6月5日
	 * @updator 陈睿超
	 * @updatetime 2020年6月5日
	 */
	public List<TProcessPrintDetail> arrangedirectlyCheckDetail(DirectlyReimbAppliBasicInfo bean ,User user) throws Exception ;

	/**
	 * 组装审签数据（借款）
	 * @param bean
	 * @param user
	 * @return
	 * @throws Exception
	 * @author 陈睿超
	 * @createtime 2020年6月5日
	 * @updator 陈睿超
	 * @updatetime 2020年6月5日
	 */
	public List<TProcessPrintDetail> arrangeLoanBasicInfoCheckDetail(String type,Payment pbean,LoanBasicInfo bean ,User user) throws Exception ;
	
	/**
	 * 组装固定资产领用审签信息
	 * @param bean
	 * @param user
	 * @return
	 * @throws Exception
	 * @author 陈睿超
	 * @createtime 2020年8月12日
	 * @updator 陈睿超
	 * @updatetime 2020年8月12日
	 */
	public List<TProcessPrintDetail> arrangeReceFixedCheckDetail(Rece bean,User user) throws Exception ;
	
	/**
	 * 获取经办部门负责人审签信息
	 * @param type 0-事前申请，1-事后报销
	 * @param bean 事前申请单
	 * @param rbean 事后报销单
	 * @param user 当前用户
	 * @param checkList 审批记录
	 * @return 经办部门负责人审签信息
	 * @author 陈睿超
	 * @createtime 2020年6月4日
	 * @updator 陈睿超
	 * @updatetime 2020年6月4日
	 */
	public TProcessPrintDetail getJBBMFZR(List<TProcessCheck> checkList,String type,ApplicationBasicInfo bean ,ReimbAppliBasicInfo rbean ,DirectlyReimbAppliBasicInfo dbean,Integer fpWId);
	
	/**
	 * 获取会计岗审签信息
	 * @param checkList 审批记录
	 * @return 经办会计岗审签信息
	 * @author 陈睿超
	 * @createtime 2020年6月4日
	 * @updator 陈睿超
	 * @updatetime 2020年6月4日
	 */
	public TProcessPrintDetail getJKJG(List<TProcessCheck> checkList,Integer fpWId);
	
	/**
	 * 获取出纳岗审签信息
	 * @param checkList
	 * @param fpWId
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年6月5日
	 * @updator 陈睿超
	 * @updatetime 2020年6月5日
	 */
	public TProcessPrintDetail getCNG(List<TProcessCheck> checkList,Integer fpWId);

	/**
	 * 获得审签中的 办公室负责人
	 * @param checkList
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年6月4日
	 * @updator 陈睿超
	 * @updatetime 2020年6月4日
	 */
	public TProcessPrintDetail getBGSFZR(List<TProcessCheck> checkList,Integer fpWId);

	/**
	 * 获得审签中的经办处室分管局长
	 * @param checkList
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年6月4日
	 * @updator 陈睿超
	 * @updatetime 2020年6月4日
	 */
	public TProcessPrintDetail getJBCSFGJZ(List<TProcessCheck> checkList,String type,ApplicationBasicInfo bean ,ReimbAppliBasicInfo rbean ,DirectlyReimbAppliBasicInfo dbean,Integer fpWId);
	
	
	/**
	 * 获得审签中的分管财务局长
	 * @param checkList
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年6月4日
	 * @updator 陈睿超
	 * @updatetime 2020年6月4日
	 */
	public TProcessPrintDetail getFGCWJZ(List<TProcessCheck> checkList,Integer fpWId);

	/**
	 * 获得审签中的局长信息
	 * @param checkList
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年6月4日
	 * @updator 陈睿超
	 * @updatetime 2020年6月4日
	 */
	public TProcessPrintDetail getJZ(List<TProcessCheck> checkList,Integer fpWId);
	
	/**
	 * 获得审签中的实物管理岗信息
	 * @param checkList
	 * @param fpWId
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年8月11日
	 * @updator 陈睿超
	 * @updatetime 2020年8月11日
	 */
	public TProcessPrintDetail getsSWGLG(List<TProcessCheck> checkList);
	
	/**
	 * 获得审签中的经办部门负责人
	 */
	public TProcessPrintDetail getJBBMR(List<TProcessCheck> checkList,String type
			, ApplicationBasicInfo bean, ReimbAppliBasicInfo rbean,DirectlyReimbAppliBasicInfo dbean
			,Integer fpWId);
	
	/**
	 * 根据保存类的主键来查询
	 * @param FTabName 类的名称
	 * @param FTabIdName 类的主键名称
	 * @param FTabId 类主键id的值
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年8月12日
	 * @updator 陈睿超
	 * @updatetime 2020年8月12日
	 */
	List<TProcessPrintDetail> findbytab(String FTabName,String FTabIdName,Integer FTabId);
	
	/**
	 * 根据流程审批记录返回打印表单中审批信息(采购申请)
	 * @param type
	 * @param bean
	 * @author 赵孟雷
	 * @createtime 2021年3月1日
	 * @updator 赵孟雷
	 * @updatetime 2021年3月1日
	 */
	public List<TProcessCheck> cgApplycheckList(String type,PurchaseApplyBasic bean,User user ) throws Exception;
	
	
	/**
	 * 获取采购申请----申报部门负责人审签信息
	 * @param checkList 审批记录
	 * @return 申报部门负责人审签信息
	 * @author 赵孟雷
	 * @createtime 2021年3月1日
	 * @updator 赵孟雷
	 * @updatetime 2021年3月1日
	 */
	public TProcessPrintDetail getSBBMFZR_CG(List<TProcessCheck> checkList,PurchaseApplyBasic bean,Integer fpWId);
	
	/**
	 * 获取采购申请----获取归口部门负责人审签信息
	 * @param checkList 审批记录
	 * @return 归口部门负责人审签信息
	 * @author 赵孟雷
	 * @createtime 2021年3月1日
	 * @updator 赵孟雷
	 * @updatetime 2021年3月1日
	 */
	public TProcessPrintDetail getGKBMFZR_CG(List<TProcessCheck> checkList,PurchaseApplyBasic bean,Integer fpWId);
	/**
	 * 获取采购申请----申报部门主管校长审签信息
	 * @param checkList 审批记录
	 * @return 申报部门主管校长审签信息
	 * @author 赵孟雷
	 * @createtime 2021年3月1日
	 * @updator 赵孟雷
	 * @updatetime 2021年3月1日
	 */
	public TProcessPrintDetail getSBBMZGXZ_CG(List<TProcessCheck> checkList,PurchaseApplyBasic bean,Integer fpWId);
	/**
	 * 获取采购申请----归口部门主管校长审签信息
	 * @param checkList 审批记录
	 * @return 归口部门主管校长审签信息
	 * @author 赵孟雷
	 * @createtime 2021年3月1日
	 * @updator 赵孟雷
	 * @updatetime 2021年3月1日
	 */
	public TProcessPrintDetail getGKBMZGXZ_CG(List<TProcessCheck> checkList,PurchaseApplyBasic bean,Integer fpWId);
	/**
	 * 获取采购申请----校长审签信息
	 * @param checkList 审批记录
	 * @return 校长审签信息
	 * @author 赵孟雷
	 * @createtime 2021年3月1日
	 * @updator 赵孟雷
	 * @updatetime 2021年3月1日
	 */
	public TProcessPrintDetail getXZ_CG(List<TProcessCheck> checkList,PurchaseApplyBasic bean,Integer fpWId);
	
	/**
	 * 通过审批流程   获取审批明细
	 * @param checkList
	 * @param fpWId
	 * @return
	 */
	public List<TProcessPrintDetail> getDirCheckList(List<TNodeData> nodeConfList,User user,Integer fpWId,List<TProcessPrintDetail> detailList,DirectlyReimbAppliBasicInfo bean);

}
