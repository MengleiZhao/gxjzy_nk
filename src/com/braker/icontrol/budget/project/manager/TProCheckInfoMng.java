package com.braker.icontrol.budget.project.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.workflow.entity.TProcessCheck;

/**
 * 项目审批的service抽象类
 * @author 叶崇晖
 * @createtime 2018-09-21
 * @updatetime 2018-09-21
 */
public interface TProCheckInfoMng extends BaseManager<TProcessCheck> {
	

	/*
	 * 一上审批
	 * @author 叶崇晖
	 * @createtime 2018-09-25
	 * @updatetime 2018-09-25
	 */
	public void firstUpCheck(String fproIdLi, String result, String remake, User user ,Role role,String files) throws Exception;
	
	
	/*
	 * 二上审批
	 * @author 叶崇晖
	 * @createtime 2018-09-29
	 * @updatetime 2018-09-29
	 */
	public void secondUpCheck(TProBasicInfo beans, TProcessCheck checkBean, User user ,Role role,String files,String fundJson,String outcomeJson,String hyjyFile) throws Exception;
	
	
	/*
	 * 上报库审批结果数据查询
	 * @author 叶崇晖
	 * @createtime 2018-09-25
	 * @updatetime 2018-09-25
	 */
	public Pagination checkInfoPageList(TProcessCheck bean,int pageNo, int pageSize, User user ,String type);
	
	
	
	public List<TProcessCheck> getCheckList(Integer id, String type, String stauts);
	
}
