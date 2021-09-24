package com.braker.icontrol.budget.project.manager.impl;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.DataEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TYearTermGoals;
import com.braker.icontrol.budget.project.manager.TYearTermGoalsMng;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
@Transactional
public class TYearTermGoalsMngImpl extends BaseManagerImpl<TYearTermGoals> implements TYearTermGoalsMng {

	@Override
	public void saveYearAimByProject(TProBasicInfo project, User user,
			List<TYearTermGoals> aimList) {
		
		for (TYearTermGoals goal: aimList) {
			goal.setTProBasicInfo(project);
			if (goal.getFMId() == null) {
				goal.setFCreateUser(user.getAccountNo());
				goal.setFCreateTime(new Date());
			} else {
				goal.setFUpdateUser(user.getAccountNo());
				goal.setFUpdateTime(new Date());
			}
			merge(goal);
		}
	}

	@Override
	public List<TYearTermGoals> generateYearAimFromDataEntity(
			List<DataEntity> dataList) throws ParseException {
		
		List<TYearTermGoals> list = new ArrayList<TYearTermGoals>();
		for (DataEntity data: dataList) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			TYearTermGoals goal = new TYearTermGoals();
			goal.setFNum(data.getCol1());
			goal.setFPlan(data.getCol2());
			if (!StringUtil.isEmpty(data.getCol3())) {//主键
				goal.setFMId(Integer.valueOf(data.getCol3()));
			}
			list.add(goal);
		}
		return list;
	}

	@Override
	public List<TYearTermGoals> getGoalByPro(String proId) {
		
		Finder f = Finder.create(" from TYearTermGoals where TProBasicInfo.FProId = " + proId);
		f.append(" order by FNum asc");
		return super.find(f);
	}

	@Override
	public void deleteGoalByProject(Integer fProId,
			List<TYearTermGoals> editList) {
		
		List<Integer> editIdList = new ArrayList<>();
		for (TYearTermGoals go: editList) {
			editIdList.add(go.getFMId());
		}
		List<TYearTermGoals> oldList = getGoalByPro(String.valueOf(fProId));
		for (TYearTermGoals go: oldList) {
			if (!editIdList.contains(go.getFMId())) {
				deleteById(go.getFMId());
			}
		}
	}

	@Override
	public void saveYearAimByProject(TProBasicInfo project, User user,
			String yearAimJson) throws JsonParseException, JsonMappingException, IOException, ParseException {
		
		ObjectMapper mapper = new ObjectMapper();  //json解析
		List<DataEntity> dataList = null;
		
		dataList = mapper.readValue(yearAimJson, new TypeReference<List<DataEntity>>(){});  
		List<TYearTermGoals> yearAimList = generateYearAimFromDataEntity(dataList);
		if (yearAimList != null && yearAimList.size() > 0) {
			if (project.getFProId() != null) deleteGoalByProject(project.getFProId(),yearAimList);
			saveYearAimByProject(project, user, yearAimList);
		}
		
	}

}
