package com.braker.workflow.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.workflow.entity.TLinkRule;
import com.braker.workflow.entity.TNodeData;

public interface TLinkRuleMng extends BaseManager<TLinkRule>{
	
	/**
	 * 
	* @author:安达
	* @Title: saveLinkRule 
	* @Description: 保存流程图的流程跳转条件信息
	* @param flowId  流程id
	* @param fromKey  出发点
	* @param toKey   到达点
	* @param list   规则集合
	* @return
	* @throws Exception
	* @return String    返回类型 
	* @date： 2019年9月19日上午10:50:13 
	* @throws
	 */
	String saveLinkRule(Integer flowId,Integer fromKey,Integer toKey,String ruleJson)throws Exception;
	
	
	/**
	 * 根据流程id,出发点，到达点 查询流程下的所有规则(查询某一条线的规则)
	 * @param flowId
	 * @return
	 */
	List<TLinkRule> findByFlowIdAndKey(Integer flowId,Integer fromKey,Integer toKey)throws Exception;
	
	/**
	 * 
	* @author:安达
	* @Title: deleteByFlowId 
	* @Description: 根据 根据流程id,出发点，到达点 删除规则 (删除某一条线的所有规则)
	* @param flowId
	* @param fromKey
	* @param toKey
	* @return void    返回类型 
	* @date： 2019年9月19日上午11:08:29 
	* @throws
	 */
	public void deleteByFlowIdAndKey(Integer flowId,Integer fromKey,Integer toKey);
}
