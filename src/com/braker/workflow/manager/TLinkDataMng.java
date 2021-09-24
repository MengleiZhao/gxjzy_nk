package com.braker.workflow.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.workflow.entity.TLinkData;
import com.braker.workflow.entity.TNodeData;

public interface TLinkDataMng extends BaseManager<TLinkData>{
	
	
	/**
	 * 保存流程图的流程跳转信息
	 * @param flowJson	
	 * @return
	 */
	String saveLink(Integer flowId,List<TLinkData> list)throws Exception;
	
	/**
	 * 根据流程id删除流程下的所有节点
	 * @param id
	 */
	void deleteByFlowId(Integer flowId) throws Exception;
	
	/**
	 * 根据流程id查询流程下的所有流程
	 * @param flowId
	 * @return
	 */
	List<TLinkData> findByFlowId(Integer flowId)throws Exception;
	
	/**
	 * 根据流程id和节点的key查询指定流程
	 * @param flowId
	 * @param key
	 * @return
	 */
	 List<TLinkData>  getByFlowIdAndKey(Integer flowId,Integer key)throws Exception;
	
}
