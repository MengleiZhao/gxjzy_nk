package com.braker.core.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Lookups;
import com.braker.core.model.ProMgrLevel1;

public interface ProMgrLevelMng extends BaseManager<ProMgrLevel1>{

	/**
	 * 加载一级分类List页面数据
	 * @param proMgrLevel1 搜索条件
	 * @param sort
	 * @param order
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination list1(ProMgrLevel1 proMgrLevel1,String sort, String order, Integer pageNo, Integer pageSize);
	
	/**
	 * 根据一级分类代码查询
	 * @param fLevCode1
	 * @return
	 */
	Integer findbyFLevCode1(String fLevCode1);
	
	/**
	 * 查询字典里资产类型
	 * @param categoryCode
	 * @param blanked
	 * @return
	 */
	List<Lookups> getLookupsJson(String categoryCode,String blanked);
	
	/**
	 * 查询字典里资产类型（除了自己）
	 * @param categoryCode
	 * @param blanked
	 * @return
	 */
	Integer findbyFLevCode1NotMine(String fLevCode1,Integer fLvId1);
	
	/**
	 * 删除一级分类，并把相应下面的二级分类也删除
	 * @param id
	 */
	void deleteAll(Integer id);
	
	/**
	 * 获得一级科目最大的编号再加一
	 * @return
	 * @param str 表名
	 */
	String maxfLevCode1();
}
