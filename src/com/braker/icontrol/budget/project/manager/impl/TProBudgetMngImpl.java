package com.braker.icontrol.budget.project.manager.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.DataEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProBudget;
import com.braker.icontrol.budget.project.entity.TProOutcomeAttac;
import com.braker.icontrol.budget.project.manager.TProBudgetMng;
import com.braker.icontrol.budget.project.manager.TProOutcomeAttacMng;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
@Transactional
public class TProBudgetMngImpl extends BaseManagerImpl<TProBudget> implements TProBudgetMng{
	
	
	@Autowired
	private TProOutcomeAttacMng tProOutcomeAttacMng;
	
	
	@Override
	public void saveBudgetByProject(TProBasicInfo project, User user,
			List<TProBudget> list) {
		for (TProBudget budget: list) {
			budget.setTProBasicInfo(project);
			if (budget.getFPBId() == null) {
				budget.setFCreateUser(user.getAccountNo());
				budget.setFCreateTime(new Date());
			} else {
				budget.setFUpdateUser(user.getAccountNo());
				budget.setFUpdateTime(new Date());
			}
			merge(budget);
			//删除已有附件
			List<TProOutcomeAttac> delList = tProOutcomeAttacMng.findByProperty("TProBudget.FPBId", budget.getFPBId());
			if (delList != null && delList.size() > 0) {
				for (TProOutcomeAttac atta: delList) {
					tProOutcomeAttacMng.delete(atta);
				}
			}
			//保存现有附件
			tProOutcomeAttacMng.saveTProOutcomeAttac(budget.getOriginFile(), user, budget);
		}
	}
	@Override
	public List<TProBudget> generateBudgetFromDataEntity(List<DataEntity> dataList) {
		
		List<TProBudget> list = new ArrayList<TProBudget>();
		for (DataEntity data: dataList) {
			TProBudget bud = new TProBudget();
			bud.setFSubName(data.getCol1());//科目名称
			bud.setFSubNum(data.getCol2());//科目编码
			String levelCode = data.getCol3();//科目级别
			if (levelCode != null) {
				bud.setFLevel(levelCode.substring(levelCode.length() - 1));
			}
			bud.setFUpperSubNum(data.getCol4());//上级科目编码
			bud.setFAppliAmount(StringUtil.isEmpty(data.getCol5())?null:Double.valueOf(data.getCol5()));//预算额
			bud.setFAccording(data.getCol6());//测算依据
			bud.setOriginFile(data.getCol8());//附件
			if (!StringUtil.isEmpty(data.getCol7())) {
				bud.setFPBId(Integer.valueOf(data.getCol7()));
			}
			list.add(bud);
		}
		return list;
	}
	
	@Override
	public List<TProBudget> getBudgetsByPro(String proId) {
		Finder f = Finder.create(" from TProBudget where TProBasicInfo.FProId = " + proId);
		f.append(" order by FSubNum asc");
		return super.find(f);
	}
	@Override
	public void deletebudgetByProject(Integer fProId, List<TProBudget> editList) {
		
		List<Integer> editIdList = new ArrayList<>();
		for (TProBudget bud: editList) {
			editIdList.add(bud.getFPBId());
		}
		List<TProBudget> oldList = getBudgetsByPro(String.valueOf(fProId));
		for (TProBudget bud: oldList) {
			if (!editIdList.contains(bud.getFPBId())) {
				deleteById(bud.getFPBId());
			}
		}
	}
	@Override
	public void saveBudgetByProject(TProBasicInfo project, User user,
			String outcomeJson) throws JsonParseException, JsonMappingException, IOException {
		
		List<DataEntity> dataList = null;
		ObjectMapper mapper = new ObjectMapper();
		
		dataList = mapper.readValue(outcomeJson, new TypeReference<List<DataEntity>>(){});  
		List<TProBudget> budList = generateBudgetFromDataEntity(dataList);
		if (budList != null && budList.size() > 0) {
			//如果是修改，则先删除未选择的科目
			if (project.getFProId() != null) {
				deletebudgetByProject(project.getFProId(),budList);
			}
			saveBudgetByProject(project, user, budList);
		}
	}
	
	
	
	

	
}
