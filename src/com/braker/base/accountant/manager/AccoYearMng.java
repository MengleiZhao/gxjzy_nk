package com.braker.base.accountant.manager;

import java.util.List;

import com.braker.base.accountant.entity.AccoTree;
import com.braker.base.accountant.entity.AccoYear;
import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Economic;
import com.braker.core.model.User;

public interface AccoYearMng extends BaseManager<AccoYear>{

	/**
	 * 显示主页数据
	 * @param yearsBasic
	 * @param sort
	 * @param order
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination list(AccoYear yearsBasic,String sort, String order, Integer pageNo, Integer pageSize);
	
	/**
	 * 保存
	 * @param yearsBasic
	 * @param user
	 */
	void save(AccoYear yearsBasic,User user);
	
	/**
	 * 删除
	 * @param fbId
	 */
	void yearsBasic_delete(String fbId);
	
	/**
	 * 根据年份查询
	 * @param year
	 * @return
	 */
	public List<AccoYear> findByYear(String year);
	
	List<AccoYear> getRoots(String parentId, String year);
	
	Pagination list_add(AccoTree economic,String departId,String sort,String order,Integer page,Integer rows);
	
	boolean queryID(String daw, String departId, AccoTree economic);
	
	int ye_save(String daw,String departId,AccoTree economic);
	
	boolean ye_delete(String fbId,String daw);
}
