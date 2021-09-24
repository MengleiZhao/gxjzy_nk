package com.braker.icontrol.budget.release.manager;

import java.io.IOException;
import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.budget.arrange.entity.DepartProjectOut;
import com.braker.icontrol.budget.release.entity.TBudgetaryIndicPro;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;

/**
 * 项目预算指标下达（二下）service
 * @author 叶崇晖
 * @createtime 2018-07-25
 * @updatetime 2018-07-25
 */
public interface TProMng extends BaseManager<TBudgetaryIndicPro>{
	/*
	 * 通过明细ID查找部门名称
	 * @author 叶崇晖
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 * @param bId 明细主键
	 */
	public String findDepartNameByBId(Integer bId);
	
	/**
	 * 保存
	 * @param saveType
	 * @param proRelease
	 * @param user
	 * @param yearOutJson
	 * @param leastOutJson
	 * @throws IOException 
	 * @throws JsonMappingException 
	 * @throws JsonParseException 
	 */
	public float save(String saveType, TBudgetaryIndicPro proRelease, User user,
			String yearOutJson, String leastOutJson) throws JsonParseException, JsonMappingException, IOException;
	
	public TBudgetaryIndicPro save(TBudgetaryIndicPro bean, User user);
	
	public void save(List<TBudgetaryIndicPro> list, User user);

	/**
	 *根据项目id  查询二下信息
	 * @author 冉德茂
	 * @createtime 2018-08-30
	 * @updatetime 2018-08-30
	 */
	public TBudgetaryIndicPro getConfByFpId(Integer id);

	/**
	 * 获得指标下达数据，并转换成预算编制下的部门预算信息
	 * @param id 部门编制总信息id
	 * @param user 操作人
	 * @return
	 */
	public List<TBudgetaryIndicPro> getDataList(String id, User user);
	
}
