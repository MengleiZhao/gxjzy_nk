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
import com.braker.icontrol.budget.project.entity.TMediuLongTermGoals;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProBudget;
import com.braker.icontrol.budget.project.entity.TProPlan;
import com.braker.icontrol.budget.project.manager.TMediuLongTermGoalsMng;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
@Transactional
public class TMediuLongTermGoalsMngImpl extends BaseManagerImpl<TMediuLongTermGoals> implements TMediuLongTermGoalsMng{

	@Override
	public void saveLongAimByProject(TProBasicInfo project, User user, List<TMediuLongTermGoals> aimList) {
		
		for (TMediuLongTermGoals goal: aimList) {
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
	public List<TMediuLongTermGoals> generateLongAimFromDataEntity(
			List<DataEntity> dataList) throws ParseException {
		
		List<TMediuLongTermGoals> list = new ArrayList<TMediuLongTermGoals>();
		for (DataEntity data: dataList) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			TMediuLongTermGoals goal = new TMediuLongTermGoals();
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
	public List<TMediuLongTermGoals> getGoalByPro(String proId) {
		
		Finder f = Finder.create(" from TMediuLongTermGoals where TProBasicInfo.FProId = " + proId);
		f.append(" order by FNum asc");
		return super.find(f);
	}

	@Override
	public void deleteGoalByProject(Integer fProId, List<TMediuLongTermGoals> editList) {
		
		List<Integer> editIdList = new ArrayList<>();
		for (TMediuLongTermGoals go: editList) {
			editIdList.add(go.getFMId());
		}
		List<TMediuLongTermGoals> oldList = getGoalByPro(String.valueOf(fProId));
		for (TMediuLongTermGoals go: oldList) {
			if (!editIdList.contains(go.getFMId())) {
				deleteById(go.getFMId());
			}
		}
	}

	@Override
	public void saveLongAimByProject(TProBasicInfo project, User user,
			String longAimJson) throws JsonParseException, JsonMappingException, IOException, ParseException {
		
		ObjectMapper mapper = new ObjectMapper();  //json解析
		List<DataEntity> dataList = null;
		
		dataList = mapper.readValue(longAimJson, new TypeReference<List<DataEntity>>(){}); 
		List<TMediuLongTermGoals> longAimList = generateLongAimFromDataEntity(dataList);
		if (longAimList != null && longAimList.size() > 0) {
			if (project.getFProId() != null) deleteGoalByProject(project.getFProId(),longAimList);
			saveLongAimByProject(project, user, longAimList);
		}
	}

}
