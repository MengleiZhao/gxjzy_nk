package com.braker.icontrol.expend.loan.manager.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.RoleMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Economic;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.expend.loan.manager.LoanCheckMng;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.workflow.manager.TProcessPrintDetailMng;

/**
 * 借款审批的service实现类
 * @author 叶崇晖
 * @createtime 2018-08-02
 * @updatetime 2018-08-02
 */
@Service
@Transactional
public class LoanCheckMngImpl extends BaseManagerImpl<LoanBasicInfo> implements LoanCheckMng {
	
	
	@Autowired
	private PersonalWorkMng personalWorkMng;
	
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private TNodeDataMng tNodeDataMng;
	
	@Autowired
	private RoleMng roleMng;
	
	@Autowired
	private TProcessPrintDetailMng tProcessPrintDetailMng;
	
	

	/*
	 * 保存审批信息
	 * @author 叶崇晖
	 * @createtime 2018-08-02
	 * @updatetime 2018-08-02
	 */
	@Override
	public void saveCheckInfo(TProcessCheck checkBean, LoanBasicInfo bean, User user,String files)  throws Exception{
		bean=this.findById(bean.getlId());
		CheckEntity entity=(CheckEntity)bean;
		String url="/loanCheck/check?cashier=0&id=";
		String url1 ="/loan/edit?editType=0&id=";
		bean=(LoanBasicInfo)tProcessCheckMng.checkProcess(checkBean, entity, user, "JKSQ", url, url1,files);
		//因为借款申请冻结指标金额是在送审的时候，所以退回的话需要将剩余金额加回来，冻结金额减掉
		/*if("-1".equals(bean.getFlowStauts())) {		//打回原点的时候，需要解冻
			//修改指标冻结金额
			Double num = bean.getlAmount();//借款金额
			budgetIndexMgrMng.deleteDjAmount(bean.getIndexId(),bean.getProDetailId(),num);
		}*/
		if("9".equals(bean.getCheckStauts())) {
			//借款报销，借款申请，在送审的时候就冻结金额，还款的时候解冻金额
			bean.setCashierType("1");
//			tProcessPrintDetailMng.arrangeLoanBasicInfoCheckDetail("0", null, bean, user);
		}
		bean = (LoanBasicInfo) super.saveOrUpdate(bean);
	}
	
}
