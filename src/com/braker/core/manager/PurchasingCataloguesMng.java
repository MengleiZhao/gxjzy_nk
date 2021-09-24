package com.braker.core.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Economic;
import com.braker.core.model.FunctionClassMgr;
import com.braker.core.model.PurchasingCatalogues;
import com.braker.core.model.User;

/**
 * 功能分类科目管理的service抽象类
 * @author 冉德茂
 * @createtime 2018-09-07
 * @updatetime 2018-09-07
 */
public interface PurchasingCataloguesMng extends BaseManager<PurchasingCatalogues>{
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-07-23
	 * @updatetime 2018-07-23
	 */
	public Pagination pageList(PurchasingCatalogues pbean, int pageNo, int pageSize, String pcode);
	/*
	 * 新增的保存
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	public void save(PurchasingCatalogues bean,User user);
	/*
	 * 根据ID删除
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	public void delete(Integer id);

	/*
	 * 删除查询有没有下一级的节点数据
	 * @author 冉德茂
	 * @createtime 2018-09-10
	 * @updatetime 2018-09-10
	 */
	List<PurchasingCatalogues> findNextbyParcode(String parCode);
	
	/*
	 * 查询所有的科目信息  和是否存在下级编码
	 * @author 冉德茂
	 * @createtime 2018-09-10
	 * @updatetime 2018-09-10
	 */
	List<PurchasingCatalogues> indexTree(String parCode);


	/**
	 * 根据编号和名字查询采购品目明细信息
	* <p>Description: </p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年6月4日
	 */
	List<PurchasingCatalogues> getItemsCodeName(String name);
}
