package com.braker.icontrol.cgmanage.cgexpert.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertBlackInfo;
import com.braker.workflow.entity.TProcessCheck;


/**
 * 专家库黑名单的service抽象类
 * @author 焦广兴
 * @createtime 2019-06-19
 * @updatetime 2019-06-19
 */
public interface ExpertBlackMng extends BaseManager<ExpertBlackInfo>{
	
	
	//黑名单审核信息
	public void saveCheckBlack(TProcessCheck checkBean, ExpertBlackInfo bean, User user,String files ) throws Exception;
	
	//获取要审核的黑名单
	public List<ExpertBlackInfo> findCheckBlack(String feId,User user);
	
	public List<ExpertBlackInfo> findByExpertBlack(String feId,String status);
	
	public void deleteBlackExpert(String feId,String feBId);
		
	public String blackRecall(Integer id)  throws Exception ;
}
