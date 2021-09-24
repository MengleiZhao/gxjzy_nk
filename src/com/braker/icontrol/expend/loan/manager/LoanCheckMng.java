package com.braker.icontrol.expend.loan.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;
import com.braker.icontrol.expend.loan.model.LoanCheckInfo;
import com.braker.workflow.entity.TProcessCheck;

/**
 * 借款审批的service抽象类
 * @author 叶崇晖
 * @createtime 2018-08-02
 * @updatetime 2018-08-02
 */
public interface LoanCheckMng extends BaseManager<LoanBasicInfo> {
	
	/*
	 * 保存审批信息
	 * @author 叶崇晖
	 * @createtime 2018-08-02
	 * @updatetime 2018-08-02
	 */
	public void saveCheckInfo(TProcessCheck checkBean, LoanBasicInfo bean, User user,String files) throws Exception;
	
	
	
}
