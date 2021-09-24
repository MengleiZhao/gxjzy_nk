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
import com.braker.icontrol.budget.project.entity.TYearTermGoalsOut;
import com.braker.icontrol.budget.project.manager.TYearTermGoalsOutMng;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
@Transactional
public class TYearTermGoalsOutMngImpl extends BaseManagerImpl<TYearTermGoalsOut> implements TYearTermGoalsOutMng {

	@Override
	public void saveYearIndexByProject(TProBasicInfo project, User user,
			List<TYearTermGoalsOut> indexList) {
		
		String year = new SimpleDateFormat("yyyy").format(new Date());
		for (TYearTermGoalsOut goal: indexList) {
			goal.setFProId(project);
			goal.setYear(year);
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
	public List<TYearTermGoalsOut> generateYearIndexFromDataEntity(
			List<DataEntity> dataList) throws ParseException {
		
		List<TYearTermGoalsOut> list = new ArrayList<TYearTermGoalsOut>();
		for (DataEntity data: dataList) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
			TYearTermGoalsOut goalOut = new TYearTermGoalsOut();
			goalOut.setFNum(data.getCol1());
			goalOut.setFIndexOne(data.getCol2());
			goalOut.setFIndexTwo(data.getCol3());
			goalOut.setFIndexName(data.getCol4());
			goalOut.setLastIndexNum(data.getCol5());
			goalOut.setFIndexNum(data.getCol7());
			if (!StringUtil.isEmpty(data.getCol8())) {//主键
				goalOut.setFMLId(Integer.valueOf(data.getCol8()));
			}
			goalOut.setYear(data.getCol9());//年度
			list.add(goalOut);
		}
		return list;
	}

	@Override
	public List<TYearTermGoalsOut> getGoalOutByPro(String proId, String year) {
		
		Finder f = Finder.create(" from TYearTermGoalsOut where FProId.FProId = " + proId);
		f.append(" and year=" + year);
		f.append(" order by FNum asc");
		return super.find(f);
	}

	@Override
	public void deleteGoalOutByProject(Integer fProId,
			List<TYearTermGoalsOut> editList ,String year) {
		
		List<Integer> editIdList = new ArrayList<>();
		for (TYearTermGoalsOut go: editList) {
			editIdList.add(go.getFMLId());
		}
		List<TYearTermGoalsOut> oldList = getGoalOutByPro(String.valueOf(fProId),year);
		for (TYearTermGoalsOut go: oldList) {
			if (!editIdList.contains(go.getFMLId())) {
				deleteById(go.getFMLId());
			}
		}
	}

	@Override
	public void saveYearIndexByProject(TProBasicInfo project, User user,
			String yearIndexJson) throws JsonParseException, JsonMappingException, IOException, ParseException {
		
		ObjectMapper mapper = new ObjectMapper();  //json解析
		List<DataEntity> dataList = null;
		
		dataList = mapper.readValue(yearIndexJson, new TypeReference<List<DataEntity>>(){});  
		List<TYearTermGoalsOut> yearIndexList = generateYearIndexFromDataEntity(dataList);
		if (yearIndexList != null && yearIndexList.size() > 0) {
			if (project.getFProId() != null) deleteGoalOutByProject(project.getFProId(),yearIndexList,new SimpleDateFormat("yyyy").format(new Date()));
			saveYearIndexByProject(project, user, yearIndexList);
		}
	}

}
