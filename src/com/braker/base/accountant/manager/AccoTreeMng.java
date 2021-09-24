package com.braker.base.accountant.manager;



import java.util.List;
import java.util.Map;

import com.braker.base.accountant.entity.AccoTree;
import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;

public interface AccoTreeMng extends BaseManager<AccoTree>{
	
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
	Pagination list(AccoTree economic,String departId,String sort,String order,Integer pageNo, Integer pageSize);
	
	/**
	 * 返回页面初始数据
	 * @return
	 * @author crc
	 * @createtime 2018-06-06
	 */
	List<AccoTree> EconomicList();
	
	/**
	 * 保存数据
	 * @param economic
	 * @author crc
	 * @createtime 2018-06-06
	 */
	void economic_save(AccoTree economic,User user);
	
	/**
	 * 根据fid删除所有相应节点下的节点
	 * @param fid
	 */
	void economic_delete(String fid);
	
	/**
	 * 查询所有根节点
	 * @return
	 */
	List<AccoTree> getRoots();
	
	/**
	 * 根据科目编号查询
	 * @param economic
	 * @return
	 */
	int queryFECCode(AccoTree economic);
	
	/**
	 * 是否有下一节点
	 * @param id 年度经济科目的id
	 * @param parentId 父节点
	 * @return
	 */
	List<AccoTree> indexTree(String id,String parentId);
	

	/**
	 * 根据父节点
	 * @param parentId
	 * @return
	 */
	Pagination List(String parentId,AccoTree economic,String departId,Integer pageNo, Integer pageSize);
	
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
	List<AccoTree> findbypid(Integer pid);
	/*
	 * 查询收入科目信息 类型KMLX-09	
	 * @author 冉德茂
	 * @createtime 2018-10-08
	 * @updatetime 2018-10-08
	 */
	List<AccoTree> indexTree(String parCode);
	
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
	
	
}
