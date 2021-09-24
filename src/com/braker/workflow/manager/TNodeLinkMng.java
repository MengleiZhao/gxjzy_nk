package com.braker.workflow.manager;

public interface TNodeLinkMng {
	/**
	 * 保存流程图的节点信息
	 * @param flowJson	
	 * @return
	 */
	String saveNodeAndLink(Integer flowId,String flowJson)throws Exception;
	
	/**
	 * 根据流程id组装流程图的json
	 * @param flowJson	
	 * @return
	 */
	String getGraphLinksModelByFlowId(Integer flowId)throws Exception;
}
