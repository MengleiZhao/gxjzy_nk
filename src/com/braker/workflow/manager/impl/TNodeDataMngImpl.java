package com.braker.workflow.manager.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Query;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.UserMng;
import com.braker.core.model.User;
import com.braker.workflow.entity.TLinkData;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.manager.TLinkDataMng;
import com.braker.workflow.manager.TLinkRuleMng;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;


/**
 * 流程节点处理逻辑
 * @author 安达
 * 2019-4-23
 */
@Service
@Transactional
public class TNodeDataMngImpl  extends BaseManagerImpl<TNodeData> implements TNodeDataMng {
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private TLinkRuleMng tLinkRuleMng;
	@Autowired
	private TLinkDataMng tLinkDataMng;
	@Autowired
	private UserMng userMng;
	/**
	 * 循环集合，把所有对象存入数据库
	 * @param flowId
	 * @param list
	 * @return
	 */
	public String saveNode(Integer flowId,List<TNodeData> list) throws Exception{
		for(TNodeData node:list){
			node.setFPId(flowId);
			node.setKeyId(node.getKey());
			if("Start".equals(node.getCategory())){
				node.setKeyId(0);  //开始节点的id 默认为0
			}
			
			node.setCustom(null);
			List<TLinkData>  linkDataList=tLinkDataMng.getByFlowIdAndKey(flowId,node.getKey());
			for(TLinkData linkData:linkDataList){
				if( StringUtils.isNotEmpty(linkData.getCustom())){
					if(node.getCustom()==null){
						node.setCustom(linkData.getCustom()+","+linkData.getTo());
					}else{
						node.setCustom(node.getCustom()+";"+linkData.getCustom()+","+linkData.getTo());
					}
					
				}
			}
			
			this.saveOrUpdate(node);
		}
		return null;
	}
	
	/**
	 * 根据流程id删除流程下的所有节点
	 * @param id
	 */
	@Override
	public void deleteByFlowId(Integer flowId) throws Exception{
		Query query=getSession().createSQLQuery(" delete from T_NODE_DATA where F_P_ID ="+flowId);
		query.executeUpdate();
	}
	
	/**
	 * 根据流程id查询流程下的所有节点
	 * @param flowId
	 * @return
	 */
	@Override
	public List<TNodeData> findByFlowId(Integer flowId) throws Exception{
		// TODO Auto-generated method stub
		//Finder finder=Finder.create(" from TNodeData where FPId ="+flowId+"");
		List<TNodeData> list = super.findByProperty("FPId", flowId);
		List<TNodeData> listNew = new ArrayList<TNodeData>();
		for (int i = 0; i < list.size(); i++) {
			TNodeData data = new TNodeData();
			BeanUtils.copyProperties(list.get(i), data);
			listNew.add(data);
		}
		return listNew;
	}
	
	/**
	 * 根据流程id和节点的key查询指定节点
	 * @param flowId
	 * @param key
	 * @return
	 */
	@Override
	public TNodeData getByFlowIdAndKey(Integer flowId, Integer key) throws Exception{
		// TODO Auto-generated method stub
		Finder finder=Finder.create(" from TNodeData where FPId =:FPId and keyId=:keyId");
		finder.setParam("FPId", flowId);
		finder.setParam("keyId", key);
		List<TNodeData> list=super.find(finder);
		if(list.size()>0){
			return list.get(0);
		}
		return null;
	}

	/**
	 * 根据流程id和当前审批节点，获取右侧审批列表
	 * @param flowId
	 * @param nextKey
	 * @return
	 */
	@Override
	public List<TNodeData> findByFlowIdAndNextKey(Integer flowId,String nextKey,String  tableName,String beanCodeField,String beanCode,String checkResult) throws Exception{
		// TODO Auto-generated method stub
		//根据流程id查询流程下的所有节点
		List<TNodeData> nodeList=findByFlowId(flowId);
		//集合转换成map，使用map可以实现快速存取
		HashMap<String,TNodeData> keyNodeMap=list2KeyMap(nodeList);
		if(nodeList==null || nodeList.size()==0){
			throw new Exception("该事项还没设置审批流程");
		}
		TNodeData nowNode=null;
		for(TNodeData node: nodeList){
			//得到开始节点
			if("Start".equals(node.getCategory())){
				nowNode=node;
				break;
			}
		}
		if(nowNode==null){
			throw new Exception("获取流程节点失败");
		}
		//得到所有同意的节点集合
		List<TNodeData> agreeNodeList=new ArrayList<TNodeData>();
		agreeNodeList=findAgreeNodes(keyNodeMap,agreeNodeList,nowNode,tableName,beanCodeField,beanCode,"1");
		return agreeNodeList;
	}  
	
	
	/**
	 * 得到所有同意的节点集合  递归调用
	 * @param keyNodeMap
	 * @param agreeNodeList
	 * @param nowNode
	 * @return
	 */
	private List<TNodeData> findAgreeNodes(HashMap<String,TNodeData> keyNodeMap,List<TNodeData> agreeNodeList,TNodeData nowNode,String  tableName,String beanCodeField,String beanCode,String checkResult)throws Exception{
		if(nowNode.getAgree()==null){
			return agreeNodeList;
		}
		if(agreeNodeList.size()>100){
			throw new Exception("流程节点进入死循环，请检查流程是否配置正确");
		}
		
		//得到同意的下一个节点
		TNodeData nextNode=null;
		if(StringUtil.isEmpty(beanCode)){ //如果 beanCode 为空，说明是在新增时候，这时候获取所有默认的同意的节点
			nextNode=keyNodeMap.get(nowNode.getAgree().toString());
		}else{
			//否则 根据当前流程的是否有条件去查询下一个节点
			Integer nextKey=tProcessCheckMng.getNextKey(nowNode,tableName,beanCodeField,beanCode,checkResult);
			nextNode=getByFlowIdAndKey(nowNode.getFPId(),nextKey);
		}

		
		//如果还没到结束节点，继续递归调用得到同意的下一个节点
		if(!"End".equals(nextNode.getCategory())){
			//如果还没到结束节点，把这个节点  存入集合
			agreeNodeList.add(nextNode);
			//递归
			agreeNodeList=findAgreeNodes(keyNodeMap,agreeNodeList,nextNode,tableName,beanCodeField,beanCode,checkResult);
		}
		return agreeNodeList;
	}
	/**
	 * 集合转换成map，key是当前节点key
	 * @param nodeList
	 * @return
	 */
	private HashMap<String,TNodeData> list2KeyMap(List<TNodeData> nodeList)throws Exception{
		HashMap<String,TNodeData> map=new HashMap<String,TNodeData>();
		for(TNodeData node: nodeList){
			map.put(node.getKeyId().toString(), node);
		}
		return map;
	}
	/**
	 * 集合转换成map，key是当前节点roleid
	 * @param nodeList
	 * @return
	 */
	private HashMap<String,TNodeData> list2RoleMap(List<TNodeData> nodeList)throws Exception{
		HashMap<String,TNodeData> map=new HashMap<String,TNodeData>();
		for(TNodeData node: nodeList){
			if(node.getRoleId()==null){
				continue;
			}
			map.put(node.getRoleId().toString(), node);
		}
		return map;
	}
	/**
	 * 得到所有上一级的节点集合  递归调用
	 * @param keyNodeMap
	 * @param agreeNodeList
	 * @param nowNode
	 * @return
	 */
	private List<TNodeData> findFromNodes(List<TProcessCheck> checkHistoryList,HashMap<String,TNodeData> roleNodeMap)throws Exception{
		List<TNodeData> fromNodeList=new ArrayList<TNodeData>();
		for(TProcessCheck checkHistory:checkHistoryList){
			TNodeData node=roleNodeMap.get(checkHistory.getFroleId());
			fromNodeList.add(node);
		}
		return fromNodeList;
	}
	/**
	 * 
	 * 修改流程节点使用人和角色
	 */
	@Override
	public TNodeData getByFlowIdAndKeys(Integer flowId, Integer key) throws Exception{
		Finder finder=Finder.create(" from TNodeData where roleId is not null");
		List<TNodeData> list=super.find(finder);
		for(TNodeData node: list){
			String roleid="";
			if("部门负责人".equals(node.getText())){
				String sql = "select PID,DEPARTID from sys_role where ROLENAME='部门负责人' and departid='"+node.getDepartId()+"';";
				Query query = getSession().createSQLQuery(sql);
				List<Object[]> lists = query.list();
				roleid=lists.get(0)[0].toString();
			}else{
				roleid=node.getRoleId();
			}
			User user=userMng.getUserByRoleIdAndDepartId(roleid, node.getDepartId());
			String sqlRole = "update t_node_data set USER_ID='"+user.getId()+"',ROLE_ID='"+roleid+"'  where F_N_Id = '"+node.getFNId()+"'";
			Query queryss = getSession().createSQLQuery(sqlRole);
			queryss.executeUpdate();
		}
		return null;
	}
	
}
