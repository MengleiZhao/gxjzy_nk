package com.braker.icontrol.expend.audit.manager.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.RoleMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.enforcing.manager.ContPayMng;
import com.braker.icontrol.contract.enforcing.model.ContPay;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.icontrol.expend.audit.manager.AuditInfoMng;
import com.braker.icontrol.expend.audit.model.AuditInfo;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbPayeeMng;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
/**
 * 财务审定的service实现类
 * @author 叶崇晖
 * @createtime 2018-08-16
 * @updatetime 2018-08-16
 */
@Service
@Transactional
public class AuditInfoMngImpl extends BaseManagerImpl<AuditInfo> implements AuditInfoMng {
	@Autowired
	private ContPayMng contPayMng;

	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	
	@Autowired
	private DirectlyReimbPayeeMng directlyReimbPayeeMng;
	
	@Autowired
	private PersonalWorkMng personalWorkMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private FormulationMng formulationMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private RoleMng roleMng;
	/*
	 * 保存报销审定信息
	 * @author 叶崇晖
	 * @createtime 2018-08-16
	 * @updatetime 2018-08-16
	 */
	@Override
	public void saveReimburseAuditInfo(AuditInfo auditBean, DirectlyReimbAppliBasicInfo drBean, ReimbAppliBasicInfo rBean,User user, Role role) {
		
	}

	/*
	 * 查询历史审定记录
	 * @author 叶崇晖
	 * @createtime 2018-08-16
	 * @updatetime 2018-08-16
	 */
	@Override
	public List<AuditInfo> auditHistory(Integer id, String auditType, String stauts) {
		Finder finder = null;
		if(auditType.equals("0")){
			finder = Finder.create(" FROM AuditInfo WHERE drId="+id);
		} else if(auditType.equals("1")) {
			finder = Finder.create(" FROM AuditInfo WHERE rId="+id);
		} else if(auditType.equals("2")) {
			finder = Finder.create(" FROM AuditInfo WHERE pId="+id);
		} else if(auditType.equals("3")) {
			finder = Finder.create(" FROM AuditInfo WHERE contId="+id);
		}
		if(stauts != null) {
			finder.append(" AND stauts="+stauts);
		}
		finder.append(" order by F_CREATE_TIME desc");
		List<AuditInfo> li = super.find(finder);
		return li;
	}


	/*
	 * 保存合同支付审定信息
	 * @author 叶崇晖
	 * @createtime 2018-08-22
	 * @updatetime 2018-08-22
	 */
	@Override
	public void saveContractAuditInfo(AuditInfo auditBean, ContPay bean, ReceivPlan receivPlanBean, User user, String result) {
		
	}

}
