package com.braker.core.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.FunctionClassMgrMng;
import com.braker.core.model.FunctionClassMgr;
import com.braker.core.model.User;

/**
 * 功能分类科目管理的service实现类
 * @author 冉德茂
 * @createtime 2018-09-07
 * @updatetime 2018-09-07
 */
@Service
@Transactional
public class FunctionClassMgrMngImpl extends BaseManagerImpl<FunctionClassMgr> implements FunctionClassMgrMng {
	
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-09-07
	 * @updatetime 2018-09-07
	 */
	@Override
	public Pagination pageList(FunctionClassMgr bean, int pageNo, int pageSize) {

		Finder finder =Finder.create("  FROM FunctionClassMgr where 1=1 ");
		if(!StringUtil.isEmpty(bean.getFecCode())){
			finder.append(" AND fecCode LIKE :fecCode");
			finder.setParam("fecCode", bean.getFecCode());
		}
		if(!StringUtil.isEmpty(bean.getFecName())){
			finder.append(" AND fecName LIKE :fecName");
			finder.setParam("fecName", bean.getFecName());
		}

		return super.find(finder,pageNo,pageSize);
	}
	/*
	 * 新增的保存
	 * @author 冉德茂
	 * @createtime 2018-09-07
	 * @updatetime 2018-09-07
	 */
	@Override
	public void save(FunctionClassMgr bean, User user) {
	
		bean = (FunctionClassMgr) super.saveOrUpdate(bean);
	}
	/*
	 * 根据ID删除
	 * @author 冉德茂
	 * @createtime 2018-09-07
	 * @updatetime 2018-09-07
	 */
	@Override
	public void delete(Integer id) {
		FunctionClassMgr bean = super.findById(id);
		super.delete(bean);
	}
	
	
	@Override
	public List<FunctionClassMgr> findAll(String fecCode){
		Finder finder=Finder.create("from FunctionClassMgr where 1=1");
		if(!StringUtil.isEmpty(fecCode)){
			finder.append(" and fecCode ='"+fecCode+"'");
		}
		return super.find(finder);
	}
	

}

	
	
	


