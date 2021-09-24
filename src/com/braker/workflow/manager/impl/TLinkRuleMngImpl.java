package com.braker.workflow.manager.impl;

import java.util.List;

import net.sf.json.JSONArray;

import org.hibernate.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.budget.project.entity.TProBasicFunds;
import com.braker.workflow.entity.TLinkRule;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.manager.TLinkRuleMng;


/**
 * 
 * <p>Description:流程连线规则 处理逻辑</p>
 * @author:安达
 * @date： 2019年9月19日上午10:51:29
 */
@Service
@Transactional
public class TLinkRuleMngImpl  extends BaseManagerImpl<TLinkRule> implements TLinkRuleMng {
	
	
	/**
	 * 保存流程图的节点信息
	 * @param flowJson	
	 * @return
	 */
	@Override
	public String  saveLinkRule(Integer flowId,Integer fromKey,Integer toKey,String ruleJson) throws Exception{
		//根据流程id删除流程下的所有节点
		deleteByFlowIdAndKey(flowId,fromKey, toKey);
		JSONArray array = JSONArray.fromObject("[" + ruleJson.toString()+ "]");
		List<TLinkRule> ruleList = JSONArray.toList(array,TLinkRule.class);
		for(TLinkRule rule:ruleList){
			TLinkRule newrule=new TLinkRule();
			newrule.setFPId(flowId);
			newrule.setFromKey(fromKey);
			newrule.setToKey(toKey);
			newrule.setCustom(rule.getCustom());
			newrule.setFieldName(rule.getFieldName());
			newrule.setFieldValue(rule.getFieldValue());
			this.saveOrUpdate(newrule);
		}
		return null;
	}
	/**
	 * 根据流程id删除流程下的所有节点
	 * @param id
	 */
	@Override
	public void deleteByFlowIdAndKey(Integer flowId,Integer fromKey,Integer toKey) {
		Query query=getSession().createSQLQuery(" delete from t_link_rule where F_P_ID ="+flowId+" and FROM_KEY="+fromKey+" and TO_KEY="+toKey+"");
		query.executeUpdate();
	}
	
	/**
	 * 根据流程id查询流程下的所有节点
	 * @param flowId
	 * @return
	 */
	@Override
	public List<TLinkRule> findByFlowIdAndKey(Integer flowId,Integer fromKey,Integer toKey) {
		// TODO Auto-generated method stub
		Finder finder=Finder.create(" from TLinkRule where FPId =:FPId and  fromKey =:fromKey and  toKey =:toKey ");
		finder.setParam("FPId", flowId);
		finder.setParam("fromKey", fromKey);
		finder.setParam("toKey", toKey);
		return super.find(finder);
	}
	
	
}
