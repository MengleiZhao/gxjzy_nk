package com.braker.icontrol.budget.project.manager;

import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;
import com.braker.icontrol.budget.data.entity.BudgetData1;
import com.braker.icontrol.budget.data.entity.BudgetData2;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProGoal;
import com.braker.icontrol.budget.project.entity.TProGoalDetail;
import com.braker.icontrol.budget.project.entity.TProPlan;


public interface TProGoalMng extends BaseManager<TProGoal> {

	/**
	 * 保存
	 */
	public TProGoal save(TProGoal goal, TProBasicInfo project, User user);
	/**
	 * 获得项目绩效目标计划
	 * @param proId 项目id
	 * @return
	 */
	public List<TProGoal> getTProGoalByPro(String proId);
	
	/**
	 * 查询分页
	 */
	public Pagination pageList(TProGoal bean, User user, int pageNo, int pageSize);
	
	/**
	 * 查询所有，导出需要
	 */
	List<TProGoal> listAll(TProGoal bean);
	
	/**
	 * 根据外键查询
	 * @param project
	 * @return
	 */
	 List<TProGoal> findByproject(TProBasicInfo project);
	
	 /**
	  * 保存更新
	  * @param pg
	  * @param pgd
	  * @param user
	  */
	 void save (TProGoal pg,List<TProGoalDetail> pgd,User user);
	 
	 /**
	  * 查询字典里相应数据
	  * @param categoryCode
	  * @param blanked
	  * @return
	  */
	 List<Lookups> getLookupsJson(String categoryCode,String blanked);
	 
	/*
	 * 导出绩效目标台账
	 * @author 安达
	 * @createtime 2018-10-19
	 * @updatetime 2018-10-19
	 */
	public HSSFWorkbook exportExcel(List<TProGoal> list, String filePath);
}
