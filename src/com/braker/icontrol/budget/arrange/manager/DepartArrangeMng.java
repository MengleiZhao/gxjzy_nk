package com.braker.icontrol.budget.arrange.manager;

import java.util.List;

import com.braker.common.entity.TreeEntity;
import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.budget.arrange.entity.DepartArrange;
import com.braker.icontrol.budget.arrange.entity.DepartBasicOut;
import com.braker.icontrol.budget.arrange.entity.DepartProjectOut;

public interface DepartArrangeMng extends BaseManager<DepartArrange> {

	/**
	 * 暂存
	 */
	public DepartArrange save(String saveType, DepartArrange bean, User user, String personData, String commData, String yearData, String leastData) throws Exception;
	
	public DepartArrange save(DepartArrange bean, User user);
	
	/**
	 * 查询
	 */
	public Pagination pageList(DepartArrange bean, User user, Integer pageNo, Integer pageSize, String menuType);
	
	/**
	 * 获取部门基本支出 人员
	 */
	public List<TreeEntity> getPersonOutFromControl(String parentId, String departName);//从控制数关联表获取
	public List<TreeEntity> getPersonOutFromArrange(String parentId, String arrangeId, String isRelease);//从部门预算编制关联表获取
	
	/**
	 * 获取部门基本支出 公用
	 */
	public List<TreeEntity> getCommOutFromControl(String parentId, String departName);//从控制数关联表获取
	public List<TreeEntity> getCommOutFromArrange(String parentId, String arrangeId, String isRelease);//从部门预算编制关联表获取
	

	/**
	 * 审批通过
	 */
	public void passArrange(DepartArrange arrange, User user, double total)  throws Exception;

	/**
	 * 审批不通过 
	 */
	public void noPassArrange(DepartArrange arrange, User user);
	
	/**
	 * 获得该编制的合计值
	 */
	public double getTotalAmount(int arrangeId);
}
