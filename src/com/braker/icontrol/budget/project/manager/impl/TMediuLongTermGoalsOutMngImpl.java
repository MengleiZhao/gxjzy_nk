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
import com.braker.icontrol.budget.project.entity.TMediuLongTermGoalsOut;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProPlan;
import com.braker.icontrol.budget.project.manager.TMediuLongTermGoalsOutMng;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
@Transactional
public class TMediuLongTermGoalsOutMngImpl extends BaseManagerImpl<TMediuLongTermGoalsOut> implements TMediuLongTermGoalsOutMng {

	@Override
	public void saveLongIndexByProject(TProBasicInfo project, User user,
			List<TMediuLongTermGoalsOut> indexList) {
		
		for (TMediuLongTermGoalsOut goal: indexList) {
			goal.setTProBasicInfo(project);
			if (goal.getFMLId() == null) {
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
	public List<TMediuLongTermGoalsOut> generateLongIndexFromDataEntity(
			List<DataEntity> dataList) throws ParseException {
		
		List<TMediuLongTermGoalsOut> list = new ArrayList<TMediuLongTermGoalsOut>();
		for (DataEntity data: dataList) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			TMediuLongTermGoalsOut goalOut = new TMediuLongTermGoalsOut();
			goalOut.setFNum(data.getCol1());
			goalOut.setFIndexOne(data.getCol2());
			goalOut.setFIndexTwo(data.getCol3());
			goalOut.setFIndexName(data.getCol4());
			goalOut.setFIndexNum(data.getCol5());
			goalOut.setFPerforNorm(data.getCol6());
			//主键
			if (!StringUtil.isEmpty(data.getCol7())) {
				goalOut.setFMLId(Integer.valueOf(data.getCol7()));
			}
			list.add(goalOut);
		}
		return list;
	}

	@Override
	public List<TMediuLongTermGoalsOut> getGoalOutByPro(String proId) {
		
		Finder f = Finder.create(" from TMediuLongTermGoalsOut where TProBasicInfo.FProId = " + proId);
		f.append(" order by FNum asc");
		return super.find(f);
	}

	@Override
	public void deleteGoalOutByProject(Integer fProId, List<TMediuLongTermGoalsOut> editList) {
		
		List<Integer> editIdList = new ArrayList<>();
		for (TMediuLongTermGoalsOut go: editList) {
			editIdList.add(go.getFMLId());
		}
		List<TMediuLongTermGoalsOut> oldList = getGoalOutByPro(String.valueOf(fProId));
		for (TMediuLongTermGoalsOut go: oldList) {
			if (!editIdList.contains(go.getFMLId())) {
				deleteById(go.getFMLId());
			}
		}
	}

	@Override
	public void saveLongIndexByProject(TProBasicInfo project, User user,
			String longIndexJson) throws ParseException, JsonParseException, JsonMappingException, IOException {

		ObjectMapper mapper = new ObjectMapper();  //json解析
		List<DataEntity> dataList = null;
		
		dataList = mapper.readValue(longIndexJson, new TypeReference<List<DataEntity>>(){});
		List<TMediuLongTermGoalsOut> longIndexList = generateLongIndexFromDataEntity(dataList);
		if (longIndexList != null && longIndexList.size() > 0) {
			if (project.getFProId() != null) deleteGoalOutByProject(project.getFProId(),longIndexList);
			saveLongIndexByProject(project, user, longIndexList);
		}
		
	}

}
