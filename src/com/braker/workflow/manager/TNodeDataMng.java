package com.braker.workflow.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;

public interface TNodeDataMng extends BaseManager<TNodeData>{
	
	
	/**
	 * 保存流程图的流程跳转信息
	 * @param flowJson	
	 * @return
	 */
	String saveNode(Integer flowId,List<TNodeData> list) throws Exception;
	
	/**
	 * 根据流程id删除流程下的所有节点
	 * @param id
	 */
	void deleteByFlowId(Integer flowId) throws Exception;
	
	/**
	 * 根据流程id查询流程下的所有节点
	 * @param flowId
	 * @return
	 */
	List<TNodeData> findByFlowId(Integer flowId)throws Exception;
	
	/**
	 * 根据流程id和节点的key查询指定节点
	 * @param flowId
	 * @param key
	 * @return
	 */
	TNodeData getByFlowIdAndKey(Integer flowId,Integer key)throws Exception;
	
	/**
	 * 根据流程id和当前审批节点，获取右侧审批列表
	 * @param flowId
	 * @param nowKey
	 * @return
	 */
	List<TNodeData> findByFlowIdAndNextKey(Integer flowId,String nowKey,String  tableName,String beanCodeField,String beanCode,String checkResult)throws Exception;
	
	/**
	 * 
	 * @Description: 修改流程节点使用人和角色
	 * @param @param flowId
	 * @param @param key
	 * @param @return
	 * @param @throws Exception   
	 * @return TNodeData  
	 * @throws
	 * @author 赵孟雷
	 * @date 2019年9月26日
	 */
	public TNodeData getByFlowIdAndKeys(Integer flowId, Integer key) throws Exception;
}
