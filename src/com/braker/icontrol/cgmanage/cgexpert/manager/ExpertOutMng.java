package com.braker.icontrol.cgmanage.cgexpert.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertOutInfo;
import com.braker.workflow.entity.TProcessCheck;


/**
 * 专家库 出库的service抽象类
 * @author 焦广兴
 * @createtime 2019-06-19
 * @updatetime 2019-06-19
 */
public interface ExpertOutMng  extends BaseManager<ExpertOutInfo> {

	//出库审核信息
	public void saveCheckOut(TProcessCheck checkBean, ExpertOutInfo bean, User user,String files ) throws Exception;
	
	//获取要审核的出库
	public List<ExpertOutInfo> findCheckOut(String feId,User user);
	
	public List<ExpertOutInfo> findByExpertOut(String feId,String recId,String status,String checkType);
	//只允许删除 被退回的记录
	public void deleteOutExpert(Integer feId,Integer foId);
	public String outRecall(Integer id)  throws Exception ;
}
