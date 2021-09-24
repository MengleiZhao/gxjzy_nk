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
import com.braker.icontrol.budget.project.entity.TProBudget;
import com.braker.icontrol.budget.project.entity.TProPlan;
import com.braker.icontrol.budget.project.manager.TProPlanMng;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
@Transactional
public class TProPlanMngImpl extends BaseManagerImpl<TProPlan> implements TProPlanMng{

	@Override
	public void save(List<TProPlan> planList, User user, TProBasicInfo project) {
		List<TProPlan> list = getTProPlansByPro(project.getFProId().toString());
		for (int i = 0; i < list.size(); i++) {
			super.delete(list.get(i));
		}
		
		if (planList != null && planList.size() > 0) {
			for (TProPlan plan: planList) {
				plan.setProject(project);
				super.merge(plan);
			}
		}
	}

	@Override
	public List<TProPlan> generatePlanFromDataEntity(List<DataEntity> dataList) throws ParseException {
		
		List<TProPlan> list = new ArrayList<TProPlan>();
//		for (DataEntity data: dataList) {
//			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//			TProPlan plan = new TProPlan();
//			plan.setFLogoNum(data.getCol1());
//			plan.setFPlanName(data.getCol2());
//			plan.setFPlanDateStart(StringUtil.isEmpty(data.getCol3())?null:sdf.parse(data.getCol3()));
//			plan.setFElapsedTime(data.getCol4());
//			plan.setFPlanDateEnd(StringUtil.isEmpty(data.getCol5())?null:sdf.parse(data.getCol5()));
//			plan.setFResourceName(data.getCol6());
//			if (!StringUtil.isEmpty(data.getCol7())) {
//				plan.setFPlanId(Integer.valueOf(data.getCol7()));//主键 区别新增修改
//			}
//			list.add(plan);
//		}
		return list;
	}

	@Override
	public List<TProPlan> getTProPlansByPro(String proId) {
		Finder finder = Finder.create(" from TProPlan where project.FProId=" + proId);
		//finder.append(" order by FLogoNum asc");
		return super.find(finder);
	}

	@Override
	public void deletePlanByProject(Integer fProId, List<TProPlan> editList) {
//		List<Integer> editIdList = new ArrayList<>();
//		for (TProPlan plan: editList) {
//			editIdList.add(plan.getFPlanId());
//		}
//		
//		List<TProPlan> oldList = getTProPlansByPro(String.valueOf(fProId));
//		for (TProPlan plan: oldList) {
//			if (!editIdList.contains(plan.getFPlanId())) {
//				deleteById(plan.getFPlanId());
//			}
//		}
	}

	@Override
	public void savePlanByProject(TProBasicInfo project, User user,
			String planJson) throws JsonParseException, JsonMappingException, IOException, ParseException {
		
		List<DataEntity> dataList = null;
		ObjectMapper mapper = new ObjectMapper();
		
		dataList = mapper.readValue(planJson, new TypeReference<List<DataEntity>>(){});  
		List<TProPlan> planList = generatePlanFromDataEntity(dataList);//生成需要保存的数据
		if (planList != null && planList.size() > 0) {
			if (project.getFProId() != null) deletePlanByProject(project.getFProId(),planList);
			save(planList, user, project);
		}
		
	}

	@Override
	public TProPlan save(TProBasicInfo project, User user, TProPlan plan) {
		
		plan.setProject(project);
		return (TProPlan) saveOrUpdate(plan);
	}

}
