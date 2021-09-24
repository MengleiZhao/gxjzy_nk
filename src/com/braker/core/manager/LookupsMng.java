package com.braker.core.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;

public interface LookupsMng extends BaseManager<Lookups>{
	public boolean isExist(Lookups bean);
	public Pagination list(Lookups bean,String sort,String order,int pageIndex,int pageSize);
	
	/**
	 * 
	* @author:安达
	* @Title: init 
	* @Description: 初始化数据
	* @return void    返回类型 
	* @date： 2019年7月20日上午9:35:16 
	* @throws
	 */
	public  void init();
	/**
	 * 根据类别code拿字典项
	 * @param categoryCode 类别code
	 * @return
	 */
	public List<Lookups> getLookupsByCategoryCode(String categoryCode);
	
	public Lookups findByLookId(String id);
	
	public Lookups findByLookCode(String code);
	
	public Lookups getByParentAndName(String parentCode, String name);
	
	public String getNameByCategoryCodeAndCode(String categoryCode, String code);
	
	/**
	 * 获得同级字典的最大排序
	 * @param pCode 父字典代码
	 * @return 数据库已有最大顺序+1
	 */
	public int getMaxOrderByParent(String pCode);
	/**
	 * 创建新字典
	 * @param name 字典名称
	 * @param pCode 父字典代码
	 * @param user
	 * @return
	 */
	public Lookups createNewLookups(String name, String pCode, User user);
	
	public List<Lookups> getLookupsSelect(String categoryCode,String blanked);
}
