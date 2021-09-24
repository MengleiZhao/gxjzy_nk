package com.braker.core.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Category;
import com.braker.core.model.User;

public interface CategoryMng extends BaseManager<Category>{
	/**
	 * 获得所有根节点
	 * 
	 * @return
	 */
	public List<Category> getRoots();
	public List<Category> getCategoryRoots(String name,String parentId); 
	/**
	 * 获得子节点
	 * 
	 * @param pid
	 * @return
	 */
	public List<Category> getChild(String pid);
	public List<Category> getCategoryChild(String pid,String name,String parentId); 
	public boolean isExist(Category bean);
	public List<Category> getParent(String id);
	public Pagination list(Category bean,String sort,String order,int pageIndex,int pageSize);
	/**
	 * 通过父节点的编码获取子节点
	 * @param parentCode
	 * @return
	 */
	public List<Category> getChildByParentCode(String parentCode);
	
	/**
	 * 通过父节点和自身id获得节点
	 * @param parentCode
	 * @param selectedCode
	 * @return
	 */
	public Category getCateByParentAndSelf(String parentCode, String selfCode);
	
	/**
	 * 通过父节点的编码获取子节点
	 * @param parentCode
	 * @return
	 */
	public List<Category> getRylx(String parentCode);

	/**
	 * 获取所有的人员类别
	 * @return
	 */
	public List<Category> getrylb();
	/**
	 * 判断同级是否有当前代码
	 * @param pCode 父字典代码
	 * @param code 代码
	 * @return
	 */
	public boolean isExist(String pCode,String code);
	/**
	 * 吸毒人员字典项保存
	 * @param pCode 父级代码
	 * @param code代码
	 * @param user
	 */
	public void saveDrug(String pCode,String code,User user);
}
