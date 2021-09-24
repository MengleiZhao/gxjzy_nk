package com.braker.core.manager;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Economic;
import com.braker.core.model.Lookups;
import com.braker.core.model.PurchasingCatalogues;
import com.braker.core.model.User;
import com.braker.core.model.YearsBasic;

public interface EconomicMng extends BaseManager<Economic>{
	
	/**
	 * 
	* @author:安达
	* @Title: init 
	* @Description: 初始化数据，存入内存里
	* @return void    返回类型 
	* @date： 2019年10月10日下午4:19:44 
	* @throws
	 */
	public  void init();
	/**
	 * 显示页面查询信息
	 * @param economic
	 * @param departId
	 * @param sort
	 * @param order
	 * @param pageNo
	 * @param pageSize
	 * @return
	 * @author crc
	 * @createtime 2018-06-06
	 */
	Pagination list(Economic economic,String departId,String sort,String order,Integer pageNo, Integer pageSize);
	
	/**
	 * 返回页面初始数据
	 * @return
	 * @author crc
	 * @createtime 2018-06-06
	 */
	List<Economic> EconomicList();
	
	/**
	 * 保存数据
	 * @param economic
	 * @author crc
	 * @createtime 2018-06-06
	 */
	void economic_save(Economic economic,User user);
	
	/**
	 * 根据fid删除所有相应节点下的节点
	 * @param fid
	 */
	void economic_delete(String fid);
	
	/**
	 * 查询所有根节点
	 * @return
	 */
	List<Economic> getRoots();
	
	/**
	 * 根据科目编号查询
	 * @param economic
	 * @return
	 */
	int queryFECCode(Economic economic);
	
	/**
	 * 根据科目编号查询(当年)
	 * @param code
	 * @return
	 */
	Economic findbyCode(String code);
	
	/**
	 * 是否有下一节点
	 * @param id 年度经济科目的id
	 * @param parentId 父节点
	 * @return
	 */
	List<Economic> indexTree(String id,String parentId);
	

	/**
	 * 根据父节点
	 * @param parentId
	 * @return
	 */
	Pagination List(String parentId,Economic economic,String departId,Integer pageNo, Integer pageSize);
	
	/**
	 * 查询字典里相应数据
	 * @param categoryCode
	 * @param blanked
	 * @return
	 */
	List<Lookups> getLookupsJson(String categoryCode,String blanked);
	
	/**
	 * 复制选中年份的模板
	 * @param id
	 */
	void copy(Integer id);
	
	/**
	 * 根据上级科目编号查询
	 * @param pid
	 * @return
	 */
	List<Economic> findbypid(Integer pid);
	/*
	 * 查询收入科目信息 类型KMLX-09	
	 * @author 冉德茂
	 * @createtime 2018-10-08
	 * @updatetime 2018-10-08
	 */
	List<Economic> indexTree(String parCode);
	
	/**
	 * 
	* @author:安达
	* @Title: findEconomicLeve2 
	* @Description: 查询二级指标名称
	* @return
	* @return List<Economic>    返回类型 
	* @date： 2019年8月16日下午4:04:06 
	* @throws
	 */
	List<Economic> findEconomicLeve2();
	
	/**
	 * 项目申报页面项目支出明细,返回name和code集合
	 * @author 叶崇晖
	 * @param name
	 * @return
	 */
	Map<Object,Object> getCodeMap();
	
	/**
	 * 根据 lookupscode 和 categoryCode查询 Lookups对象
	 * @author 李安达
	 * @param lookupscode
	 * @param categoryCode
	 * @return
	 */
	Lookups findLookupsByCode(String lookupscode,String categoryCode);
	
	/**
	 * 根据科目级别获取 
	 * @param leve	科目级别 KMJB-02
	 * @param year
	 * @return
	 */
	List<Economic> findByEjLeve(String leve,String year);
	
	void copyEconomic(Integer oldYearId, YearsBasic newYb) throws Exception;
	
	List<Economic> findByYearIdAllData(Integer fYBId);
	
}
