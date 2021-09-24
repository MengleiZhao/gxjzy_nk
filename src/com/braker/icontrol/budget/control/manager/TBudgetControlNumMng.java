package com.braker.icontrol.budget.control.manager;

import java.io.IOException;
import java.util.List;

import com.braker.common.entity.TreeEntity;
import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.budget.control.entity.TBasicExpend;
import com.braker.icontrol.budget.control.entity.TBudgetControlNum;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;

public interface TBudgetControlNumMng extends BaseManager<TBudgetControlNum> {

	/**
	 * 获得数据列表
	 * @param bean 查询条件
	 * @param user 用户
	 * @param pageNo 当前页
	 * @param pageSize 每页数据量
	 * @return
	 */
	public Pagination pageList(TBudgetControlNum bean, User user, Integer pageNo,
			Integer pageSize);

	/**
	 * 保存预算控制数(新增)
	 * @param user 用户
	 * @param bean 控制数
	 * @param personOutJson 人员支出
	 * @param commOutJson 公用指出
	 * @param yearOutJson 年度项目支出
	 * @param leastOutJson 结转项目支出
	 */
	public void save(User user, TBudgetControlNum bean,
			String personOutJson, String commOutJson, String yearOutJson,
			String leastOutJson) throws JsonParseException, JsonMappingException, IOException;
	
	/**
	 * 保存预算控制数(修改)
	 * @param user 用户
	 * @param bean 控制数
	 * @param personOutJson 人员支出
	 * @param commOutJson 公用指出
	 * @param yearOutJson 年度项目支出
	 * @param leastOutJson 结转项目支出
	 */
	public void editSave(User user, TBudgetControlNum bean,
			String personOutJson, String commOutJson, String yearOutJson,
			String leastOutJson) throws JsonParseException, JsonMappingException, IOException;

	/**
	 * 逻辑删除
	 * @param user 操作人
	 * @param conId 预算控制数id
	 */
	public void logicDeleteById(User user, String conId);

	/**
	 * 生成需要填写的人员基本支出列表
	 * @param operationType 操作类型
	 * @param user 用户
	 * @param parentId 父节点id
	 * @param numId 控制数id
	 * @return
	 */
	public List<TreeEntity> getPersonOutListAdd( User user, String parentId, String numId);

	/**
	 * 生成需要填写的公用基本支出列表
	 * @param operationType 操作类型
	 * @param user 用户
	 * @param id 父节点id
	 * @return
	 */
	public List<TreeEntity> getCommOutList(String operationType, User user,
			String id);

}
