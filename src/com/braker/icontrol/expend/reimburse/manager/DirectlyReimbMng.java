package com.braker.icontrol.expend.reimburse.manager;

import java.io.File;
import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbPayeeInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbPayeeInfo;
import com.braker.workflow.entity.TProcessCheck;


/**
 * 直接报销申请的service抽象类
 * @author 叶崇晖
 * @createtime 2018-08-03
 * @updatetime 2018-08-03
 */
public interface DirectlyReimbMng extends BaseManager<DirectlyReimbAppliBasicInfo> {
	
	/*
	 * 分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-03
	 * @updatetime 2018-08-03
	 */
	public Pagination pageList(DirectlyReimbAppliBasicInfo bean, int pageNo, int pageSize, User user);
	
	/*
	 * 审批保存
	 * @author 李安达
	 * @createtime 2019-05-07
	 * @updatetime 2019-05-07
	 */
	public void check(TProcessCheck checkBean, DirectlyReimbAppliBasicInfo drBean,User user,String files) throws Exception;
	
	/*
	 * 直接报销申请新增和修改的保存
	 * @author 叶崇晖
	 * @createtime 2018-08-06
	 * @updatetime 2018-08-06
	 */
	public void save(DirectlyReimbAppliBasicInfo bean, DirectlyReimbPayeeInfo payeeBean, String mingxi, String fapiao, String files, User user) throws Exception;
	
	/*
	 * 直接报销申请删除
	 * @author 叶崇晖
	 * @createtime 2018-08-08
	 * @updatetime 2018-08-08
	 */
	public void delete(Integer id,String fid,User user);
	
	/*
	 * 审批分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-13
	 * @updatetime 2018-08-13
	 */
	public Pagination checkPageList(DirectlyReimbAppliBasicInfo bean, int pageNo,int pageSize, User user);
	
	/*
	 * 台账分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-14
	 * @updatetime 2018-08-14
	 */
	public Pagination ledgerPageList(String applyString,DirectlyReimbAppliBasicInfo bean, int pageNo,int pageSize, User user);
	
	/*
	 * 财务审定分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-16
	 * @updatetime 2018-08-16
	 */
	public Pagination auditPageList(DirectlyReimbAppliBasicInfo bean, int pageNo,int pageSize, User user);
	
	/*
	 * 出纳受理分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-22
	 * @updatetime 2018-08-22
	 */
	public Pagination cashierPageList(DirectlyReimbAppliBasicInfo bean, int pageNo,int pageSize, User user);
	
	/**
	 * 查询需要导出的全部台账信息
	 * @author 叶崇晖
	 * @return
	 */
	public List<DirectlyReimbAppliBasicInfo> ledgerList(String applyString,String userId);
	
	/**
	 * 
	 * @Description: 直接报销回退
	 * @param @param id
	 * @param @return
	 * @param @throws Exception   
	 * @return String  
	 * @throws
	 * @author 赵孟雷
	 * @date 2019年10月8日
	 */
	public String  directlyReimbReCall(Integer id)  throws Exception ;

	public void save1(DirectlyReimbAppliBasicInfo bean,
			DirectlyReimbPayeeInfo payeeBean, String files, User user,
			String mingxi,String form1,String payerinfoJson,
			   String payerinfoStudentJson,//学生付款列表json
			   String payerinfoCCBJson,//建行付款列表json
			   String payerinfoNoCCBJson//非建行付款列表json
			   ) throws Exception;

	public void updateCashier(DirectlyReimbAppliBasicInfo drBean);
	
	/**
	 * 
	 * @Description: 通过借款单ID 查询直接报销中的冲销借款
	 * @return   
	 * @throws
	 * @author 赵孟雷
	 * @date 2020年6月10日
	 */
	public List<DirectlyReimbAppliBasicInfo> findByLoanId(String id);
	/**
	 * 
	 * @Description: 通过借款单ID 查询直接报销中的冲销借款   查询全部的冲销数据
	 * @return   
	 * @throws
	 * @author 赵孟雷
	 * @date 2020年6月10日
	 */
	public List<DirectlyReimbAppliBasicInfo> findByLoanIdCX(String id,String code);

	public void saveApp(DirectlyReimbAppliBasicInfo bean, String files,
			User user, String mingxi, String form1, String payerinfoJson,
			String fpIds) throws Exception;
	
	/**
	 * 查询字典里审批状态
	 * @param categoryCode
	 * @param blanked
	 * @return
	 */
	List<Lookups> getLookupsJson(String categoryCode,String blanked,String selected);
	
	/**
	 * 将前台传入的直接报销明细转换成list对象
	 * @author zml
	 * @param file
	 * @return
	 */
	public List<ReimbPayeeInfo> directlyReimCollect(File file,String type); 
}


