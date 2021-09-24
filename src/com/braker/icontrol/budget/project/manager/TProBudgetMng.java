package com.braker.icontrol.budget.project.manager;

import java.io.IOException;
import java.util.List;

import com.braker.common.entity.DataEntity;
import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProBudget;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;

public interface TProBudgetMng extends BaseManager<TProBudget>{

	/**
	 * 保存支出科目
	 * @param project 关联项目
	 * @param user 操作人
	 * @param list 科目集合
	 * @return
	 */
	public void saveBudgetByProject(TProBasicInfo project, User user, List<TProBudget> list);
	
	/**
	 * 保存支出科目
	 * @param project 关联项目
	 * @param user 操作人
	 * @param outcomeJson 需要保存的科目
	 * @throws IOException 
	 * @throws JsonMappingException 
	 * @throws JsonParseException 
	 */
	public void saveBudgetByProject(TProBasicInfo project, User user, String outcomeJson) throws JsonParseException, JsonMappingException, IOException;
	
	/**
	 * 解析数据集合，获得支出科目
	 * @param dataList 数据集合
	 * @return
	 */
	public List<TProBudget> generateBudgetFromDataEntity(List<DataEntity> dataList);
	
	/**
	 * 获得项目支出科目
	 * @param proId 项目id
	 * @return
	 */
	public List<TProBudget> getBudgetsByPro(String proId);

	/**
	 * 删除项目支出科目
	 * @param proId 项目id
	 * @return editList 不能删除的科目列表
	 */
	public void deletebudgetByProject(Integer fProId, List<TProBudget> editList);

	
}
