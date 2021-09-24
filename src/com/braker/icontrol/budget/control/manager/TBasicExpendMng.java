package com.braker.icontrol.budget.control.manager;

import java.util.List;

import com.braker.common.entity.DataEntity;
import com.braker.common.entity.TreeEntity;
import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.budget.control.entity.TBasicExpend;
import com.braker.icontrol.budget.control.entity.TBudgetControlNum;
import com.braker.icontrol.budget.control.entity.TProExpend;

public interface TBasicExpendMng extends BaseManager<TBasicExpend> {

	/**
	 * 批量保存
	 * @param user
	 * @param personOutList 
	 * @param type
	 */
	public void saveBasicOuts(User user, List<TBasicExpend> personOutList);

	/**
	 * 查询人员支出
	 * @param numId 控制数id
	 * @param parentId 父节点id
	 * @param user 用户
	 * @return
	 */

	public List<TBasicExpend> getPersonOutListEdit( User user,  Integer numId, String departName);
	
	public List<TBasicExpend> getPersonOutListEdit(String parentId, String departName);
	
	/**
	 * 查询公用支出
	 * @param user 用户
	 * @param numId 控制数id
	 * @param departName 部门名称
	 * @return
	 */
	public List<TBasicExpend> getCommOutListEdit( User user,  Integer numId, String departName);
	
	public List<TBasicExpend> getCommOutListEdit(String parentId, String departName);
	
	/**
	 * 部门控制数统计
	 * @param subjectName 科目名称
	 * @param departName 部门名称
	 * @param year 年度
	 * @param outType 支出类型
	 * @return
	 */
	public List<DataEntity> getDepartList(String subjectName, String departName, String year, String outType);
	
	/**
	 * 科目控制数统计
	 * @param subjectName 科目名称
	 * @param departName 部门名称
	 * @param year 年度
	 * @return
	 */
	public List<DataEntity> getSubjectList(String subjectName, String departName, String year);
	

}
