package com.braker.icontrol.budget.project.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProGoal;
import com.braker.icontrol.budget.project.entity.TProGoalDetail;

public interface TProGoalDetailMng extends BaseManager<TProGoalDetail> {

	/**
	 * 保存
	 */
	public TProGoalDetail save(TProGoalDetail detail, TProGoal goal, User user);
	
	public void save(List<TProGoalDetail> detailList, TProGoal goal, User user);

	
	Pagination findBygoal(String goal,Integer page, Integer rows);

	
	/*
	 *项目绩效指标明细信息查询
	 * @author 冉德茂
	 * @createtime 2018-09-17
	 * @updatetime 2018-09-17
	 */
	public List<TProGoalDetail> getMingxi(Integer proid);

}
