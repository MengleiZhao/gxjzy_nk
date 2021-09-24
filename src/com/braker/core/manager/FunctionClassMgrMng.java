package com.braker.core.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.FunctionClassMgr;
import com.braker.core.model.User;

/**
 * 功能分类科目管理的service抽象类
 * @author 冉德茂
 * @createtime 2018-09-07
 * @updatetime 2018-09-07
 */
public interface FunctionClassMgrMng extends BaseManager<FunctionClassMgr>{
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-07-23
	 * @updatetime 2018-07-23
	 */
	public Pagination pageList(FunctionClassMgr bean, int pageNo, int pageSize);
	/*
	 * 新增的保存
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	public void save(FunctionClassMgr bean,User user);
	/*
	 * 根据ID删除
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	public void delete(Integer id);
	
	/**
	 * 查询所有的功能分类
	 * @param fecCode
	 * @return
	 */
	List<FunctionClassMgr> findAll(String fecCode);
}
