package com.braker.icontrol.budget.declare.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;

/**
 * 上报库的service抽象类
 * @author 叶崇晖
 * @createtime 2018-09-20
 * @updatetime 2018-09-20
 */
public interface DeclareMng extends BaseManager<TProBasicInfo> {
	
	/**
	 * 一上
	 */
	
	/*
	 * 一上申报列表数据查询
	 * @author 叶崇晖
	 * @createtime 2018-09-21
	 * @updatetime 2018-09-21
	 */
	public List<TProBasicInfo> yssbPageList(TProBasicInfo bean, int pageNo, int pageSize, User user);
	
	/*
	 * 一上批量上报数据保存
	 * @author 叶崇晖
	 * @createtime 2018-09-20
	 * @updatetime 2018-09-20
	 */
	public void firstUpApply(String fproIdLi, User user) throws Exception;
	
	/*
	 * 一上审批列表数据查询
	 * @author 叶崇晖
	 * @createtime 2018-09-21
	 * @updatetime 2018-09-21
	 */
	public Pagination ysspPageList(TProBasicInfo bean, int pageNo, int pageSize, User user);
	
	
	
	/**
	 * 二上
	 */
	
	
	/*
	 * 二上申报列表数据查询
	 * @author 叶崇晖
	 * @createtime 2018-09-27
	 * @updatetime 2018-09-27
	 */
	public Pagination essbPageList(TProBasicInfo bean, int pageNo, int pageSize, User user);
	
	/**
	 * 
	* @author:安达
	* @Title: secondUpApply 
	* @Description: 二上上报 
	* @param bean
	* @param user
	* @param opeType
	* @param lxyjFiles
	* @param ssfaFiles
	* @param jxmbFiles
	* @param jxmingxi
	* @param delIndex
	* @return
	* @throws Exception
	* @return TProBasicInfo    返回类型 
	* @date： 2019年5月30日下午9:01:53 
	* @throws
	 */
	public TProBasicInfo secondUpApply(TProBasicInfo bean, User user, String saveType, String outcomeJson,String purchaseJson,String purchaseJsonSE,
			String fundsJson, String lxyjFiles, String ssfaFiles,String totalityPerformanceJson,String purManyYearsProJson,String purManyYearsProJsonSE) throws Exception;
	
	/*
	 * 二上审批列表数据查询
	 * @author 叶崇晖
	 * @createtime 2018-09-28
	 * @updatetime 2018-09-28
	 */
	public Pagination esspPageList(TProBasicInfo bean, int pageNo, int pageSize, User user);
	
	/**
	 * 
	* @author:安达
	* @Title: reCall 
	* @Description: 撤回
	* @param id
	* @return
	* @throws Exception
	* @return String    返回类型 
	* @date： 2019年10月8日下午10:13:20 
	* @throws
	 */
	public String  reCall(Integer id)  throws Exception ;
}
