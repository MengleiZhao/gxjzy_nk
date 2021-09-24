package com.braker.workflow.manager.impl;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.workflow.entity.TLinkData;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.manager.TLinkDataMng;


/**
 * 流程节点处理逻辑 
 * @author 安达
 * 2019-4-23
 */
@Service
@Transactional
public class TLinkDataMngImpl  extends BaseManagerImpl<TLinkData> implements TLinkDataMng {
	
	
	/**
	 * 保存流程图的节点信息 
	 * @param flowJson
	 * @return
	 */
	@Override
	public String saveLink(Integer flowId,List<TLinkData> list) {
		for(TLinkData link:list){
			if(link.getFrom()==null && link.getTo()==null){
				continue;
			}
			link.setFPId(flowId);
			link.setFromKey(link.getFrom());
			link.setToKey(link.getTo());
			this.saveOrUpdate(link);
		}
		return null;
	}
	/**
	 * 根据流程id删除流程下的所有节点
	 * @param id
	 */
	@Override
	public void deleteByFlowId(Integer flowId) {
		Query query=getSession().createSQLQuery(" delete from T_LINK_DATA where F_P_ID ="+flowId);
		query.executeUpdate();
	}
	
	/**
	 * 根据流程id查询流程下的所有节点
	 * @param flowId
	 * @return
	 */
	@Override
	public List<TLinkData> findByFlowId(Integer flowId) {
		// TODO Auto-generated method stub
		Finder finder=Finder.create(" from TLinkData where FPId =:FPId");
		finder.setParam("FPId", flowId);
		return super.find(finder);
	}
	
	/**
	 * 根据流程id和节点的key查询指定节点
	 * @param flowId
	 * @param key
	 * @return
	 */
	@Override
	public List<TLinkData> getByFlowIdAndKey(Integer flowId, Integer key) {
		// TODO Auto-generated method stub
		Finder finder=Finder.create(" from TLinkData where FPId =:FPId and fromKey=:fromKey");
		finder.setParam("FPId", flowId);
		finder.setParam("fromKey", key);
		List<TLinkData> list=super.find(finder);
		return list;
	}  
}
