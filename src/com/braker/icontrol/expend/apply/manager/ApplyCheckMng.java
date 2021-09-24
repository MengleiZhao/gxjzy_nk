package com.braker.icontrol.expend.apply.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.workflow.entity.TProcessCheck;


/**
 * 事前申请审批的service抽象类
 * @author 叶崇晖
 * @createtime 2018-06-29
 * @updatetime 2018-06-29
 */
public interface ApplyCheckMng extends BaseManager<ApplicationBasicInfo>{
	
	/*
	 * 保存审批信息
	 * @author 叶崇晖
	 * @createtime 2018-07-05
	 * @updatetime 2018-07-05
	 */
	public void saveCheckInfo(TProcessCheck checkBean, ApplicationBasicInfo bean, List<Object> mingxi,User user, Role role,String files) throws Exception;
	
	
}
