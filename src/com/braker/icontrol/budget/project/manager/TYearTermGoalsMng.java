package com.braker.icontrol.budget.project.manager;

import java.io.IOException;
import java.text.ParseException;
import java.util.List;

import com.braker.common.entity.DataEntity;
import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TYearTermGoals;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;

public interface TYearTermGoalsMng extends BaseManager<TYearTermGoals>{

	/**
	 * 保存年度目标信息
	 * @param project
	 * @param user
	 * @param list
	 */
	public void saveYearAimByProject(TProBasicInfo project, User user,List<TYearTermGoals> aimList);
	
	/**
	 * 保存年度目标信息
	 * @param project
	 * @param user
	 * @param yearAimJson
	 * @throws IOException 
	 * @throws JsonMappingException 
	 * @throws JsonParseException 
	 * @throws ParseException 
	 */
	public void saveYearAimByProject(TProBasicInfo project, User user, String yearAimJson) throws JsonParseException, JsonMappingException, IOException, ParseException;
	
	/**
	 * 解析数据集合生成年度目标集合
	 * @param dataList 数据集合
	 * @return
	 * @throws ParseException 
	 */
	public List<TYearTermGoals> generateYearAimFromDataEntity(List<DataEntity> dataList) throws ParseException;

	/**
	 * 获得某项目的所有年度目标
	 * @param proId 项目id
	 * @return
	 */
	public List<TYearTermGoals> getGoalByPro(String proId);

	/**
	 * 删除某项目的年度目标
	 * @param proId 项目id
	 * @return editList 不能删除的目标列表
	 */
	public void deleteGoalByProject(Integer fProId, List<TYearTermGoals> editList);

	

}
