package com.braker.icontrol.cgmanage.cgapply.manager;


import java.util.List;
















import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;

/**
 * 采购申请的service抽象类
 * @author 冉德茂
 * @createtime 2018-07-10
 * @updatetime 2018-07-10
 */
public interface CgApplysqMng extends BaseManager<PurchaseApplyBasic>{
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-07-10
	 * @updatetime 2018-07-10
	 */
	public Pagination pageList(PurchaseApplyBasic bean, int pageNo, int pageSize, User user, String timea, String timeb, String amounta, String amountb);
	/*
	 * 根据ID删除
	 * @author 冉德茂
	 * @createtime 2018-07-11
	 * @updatetime 2018-07-11
	 */
	public void delete(Integer id);
	
	
	/*
	 * 采购申请的保存
	 * @author 冉德茂
	 * @createtime 2018-07-13
	 * @updatetime 2018-07-13
	 */
	public void save(PurchaseApplyBasic bean, String files1, String files2, String files3, String files4, String mingxi, User user) throws Exception ;
	
	
	/*
	 * 采购品目明细查询
	 * @author 冉德茂
	 * @createtime 2018-07-13
	 * @updatetime 2018-07-13
	 */
	public List<Object> getMingxi(String tableName ,String idName ,Integer id);
	
	
	/*
	 * 审批台账分页查询
	 * @author 冉德茂
	 * @createtime 2018-07-20
	 * @updatetime 2018-07-20
	 */
	public Pagination ledgerPageList(PurchaseApplyBasic bean, int pageNo,int pageSize, User user);
	
	/*
	 * 验收台账分页查询
	 * @author 冉德茂
	 * @createtime 2018-07-20
	 * @updatetime 2018-07-20
	 */
	public Pagination receiveledgerPageList(PurchaseApplyBasic bean,String timea,String timeb, int pageNo,int pageSize, User user);
	
	/*
	 * 根据fpid查询采购批次编号
	 * @author 冉德茂
	 * @createtime 2018-07-24
	 * @updatetime 2018-07-24
	 * 
	 */
	public List<PurchaseApplyBasic> getCodeById(Integer id);
	
	
	/*
	 * 询比价登记查看采购基本信息
	 * @author 冉德茂
	 * @createtime 2018-08-01
	 * @updatetime 2018-08-01
	 * 
	 */
	public Pagination qingdanpageList(PurchaseApplyBasic bean, Integer page,Integer rows, User user);
	
	/**
	 * 根据采购批次号
	 * @param fpCode
	 * @return
	 */
	PurchaseApplyBasic findbyfpCode(String fpCode);
	/*
	 * 根据采购批次Id获取合同金额
	 * @author 李安达
	 * @createtime 2018-11-29
	 * @updatetime 2018-11-29
	 * 
	 */
	String findFpAmountbyfpId(String fpId);
	
	/**
	 * 采购申请撤回
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public String  reCall(Integer id)  throws Exception ;
	
	public Pagination ItemsPageList(Integer page, Integer rows, String item);
	
	/**
	 * 
	 * <p>Title: ledgerPageList</p>  
	 * <p>Description: 登记的list页面</p>  
	 * @param bean
	 * @param pageNo
	 * @param pageSize
	 * @param user
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年12月10日
	 * @updator 陈睿超
	 * @updatetime 2020年12月10日
	 */
	Pagination cgTenderingPageList(PurchaseApplyBasic bean, Integer pageNo,Integer pageSize, User user);
	
	
	/**采购报销分页数据
	 * @param page
	 * @param rows
	 * @param bean
	 * @param user
	 * @return
	 */
	public Pagination reimbPageList(Integer page, Integer rows,
			PurchaseApplyBasic bean, User user);
	public Pagination reimbCheckPageList(Integer page, Integer rows,
			PurchaseApplyBasic bean, User user);
	
	
	/**
	 * 导出excel转换采购台账
	 * @param bean 转换数据
	 * @param filePath
	 * @return
	 */
	HSSFWorkbook exportExcel(List<PurchaseApplyBasic> bean, String filePath);
}
