package com.braker.icontrol.budget.project.manager.impl;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.hibernate.Finder;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProGoal;
import com.braker.icontrol.budget.project.entity.TProGoalDetail;
import com.braker.icontrol.budget.project.manager.TProGoalDetailMng;

@Service
public class TProGoalDetailMngImpl extends BaseManagerImpl<TProGoalDetail> implements TProGoalDetailMng {
	

	@Override
	public TProGoalDetail save(TProGoalDetail detail, TProGoal goal, User user) {
		
		Date date = new Date();
		if (detail.getPid() == null) {
			detail.setCreator(user);
			detail.setCreateTime(date);
		}
		detail.setUpdator(user);
		detail.setUpdateTime(date);
		return (TProGoalDetail) super.merge(detail);
	}

	@Override
	public void save(List<TProGoalDetail> detailList, TProGoal goal, User user) {
		List<TProGoalDetail> goaDetailList = getMingxi(Integer.valueOf(goal.getProject().getFProId()));
		for (int i = 0; i < goaDetailList.size(); i++) {
			super.delete(goaDetailList.get(i));
		}
		
		if (detailList != null) {
			for (TProGoalDetail li: detailList) {
				li.setGoal(goal);
				save(li, goal, user);
			}
		}
	}
	/*
	 *项目绩效指标明细信息查询
	 * @author 冉德茂
	 * @createtime 2018-09-17
	 * @updatetime 2018-09-17
	 */
	@Override
	public List<TProGoalDetail> getMingxi(Integer proid) {
		Finder finder = Finder.create(" FROM TProGoalDetail WHERE goal.project.FProId="+proid+" " );
		return super.find(finder);
	}

	@Override
	public Pagination findBygoal(String goal,Integer page, Integer rows) {
		Finder finder=Finder.create(" from TProGoalDetail where goal.pid="+Integer.valueOf(goal));
		return super.find(finder, page, rows);
	}

}
