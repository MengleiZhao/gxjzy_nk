package com.braker.icontrol.budget.project.manager;

import java.util.List;
import java.util.Map;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;

public interface TProExpendDetailMng extends BaseManager<TProExpendDetail> {

	/**
	 * 
	* @author:安达
	* @Title: save 
	* @Description: 保存
	* @param FProId
	* @param expendList
	* @return
	* @throws Exception
	* @return int    返回类型 
	* @date： 2019年6月13日下午7:27:13 
	* @throws
	 */
	public int save(Integer FProId, List<TProExpendDetail> expendList) throws Exception;
	
	/**
	 * 
	* @author:安达
	* @Title: TransmitIndex 
	* @Description: 指标下达以后，修改支出明细
	* @param FProId
	* @return void    返回类型 
	* @date： 2019年6月14日上午9:38:43 
	* @throws
	 */
	public void transmitIndex(Integer FProId);
	/**
	 * 根据项目id获取项目支出明细
	 * @author 叶崇晖
	 * @param FProId项目id
	 * @return
	 */
	public List<TProExpendDetail> getByProId(Integer FProId);
	
	/**
	 * 
	* @author:安达
	* @Title: getPidMap 
	* @Description: 根据项目名称，查找有没有项目支出
	* @param parentCodes
	* @return
	* @return Map<String,Integer>    返回类型 
	* @date： 2019年6月24日上午11:30:09 
	* @throws
	 */
	Map<String, Integer> getPidMap(String parentCodes);
}
