package com.braker.icontrol.contract.Formulation.manager.Impl;

import java.text.SimpleDateFormat;

import javax.persistence.criteria.CriteriaBuilder.In;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.release.manager.TBasicItfMng;
import com.braker.icontrol.budget.release.manager.TProItfMng;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.contract.Formulation.manager.ApprovalMng;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.zzww.comm.manager.AttachmentMng;

@Service
@Transactional
public class ApprovalMngImpl extends BaseManagerImpl<ContractBasicInfo> implements ApprovalMng{

	@Autowired
	private TBasicItfMng basicItfMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	@Autowired
	private TProItfMng proItfMng; 
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	@Autowired
	private CgApplysqMng cgApplysqMng;
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Override
	public Pagination queryList(ContractBasicInfo contractBasicInfo,User user, int pageNo, int pageSize) {
		Finder finder=Finder.create(" FROM ContractBasicInfo WHERE fFlowStauts =1 AND fContStauts='1' and fyhtid is null ");
		finder.append("AND fUserCode=:fUserCode ");
		finder.setParam("fUserCode", user.getId());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if(!StringUtil.isEmpty(contractBasicInfo.getFcCode())){
			finder.append("AND fcCode LIKE :fcCode ");
			finder.setParam("fcCode", "%"+contractBasicInfo.getFcCode()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcTitle())){
			finder.append("AND fcTitle LIKE :fcTitle ");
			finder.setParam("fcTitle", "%"+contractBasicInfo.getFcTitle()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getfOperator())){
			finder.append("AND fOperator LIKE :fOperator ");
			finder.setParam("fOperator", "%"+contractBasicInfo.getfOperator()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcAmount())){
			finder.append("AND fcAmount LIKE :fcAmount");
			finder.setParam("fcAmount", "%"+contractBasicInfo.getFcAmount()+"%");
		}
		if(!StringUtil.isEmpty(String.valueOf(contractBasicInfo.getcAmountBegin()))){
			finder.append(" AND fcAmount >='"+contractBasicInfo.getcAmountBegin()+"'");
		}
		if(!StringUtil.isEmpty(String.valueOf(contractBasicInfo.getcAmountEnd()))){
			finder.append(" AND fcAmount <='"+contractBasicInfo.getcAmountEnd()+"'");
		}
		/*if(contractBasicInfo.getfReqtIME()!=null){
			finder.append("AND datediff(fReqtIME,'"+contractBasicInfo.getfReqtIME()+"')=0");
		}*/
		finder.append("order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public void updatefFlowStauts(String fcId,TProcessCheck checkBean,User user,String Id,String files,String fsyjsfiles)  throws Exception{
		ContractBasicInfo bean = super.findById(Integer.valueOf(fcId));
		CheckEntity entity = (CheckEntity)bean;
		
		String checkUrl = "/Approval/approveList/";
		String lookUrl = "/Formulation/detail/";
		bean = (ContractBasicInfo)tProcessCheckMng.checkProcess(checkBean,entity,user,"HTND",checkUrl,lookUrl,files);
		if(user.getRoleName().contains("合同法审岗")&&Double.valueOf(bean.getFcAmount())>=100000&&bean.getStandard()==0){
			//如果上传附件不为空
			if(!StringUtil.isEmpty(fsyjsfiles)){
				attachmentMng.joinEntity(bean,fsyjsfiles);
			}else{
				throw new ServiceException("法审意见书上传出错，请重新上传！");
			}
		}
		//审批全部通过
		if("9".equals(bean.getfFlowStauts())){
			bean.setfContStauts("9");
			bean.setfUpdateStatus("0");//合同变更状态
			bean.setfDisputeStatus("0");//合同纠纷状态
			bean.setFsealedStatus(0);//合同盖章状态
			bean.setFgdStauts("0");//合同归档状态
		}
		//审批不通过
		if("-1".equals(bean.getfFlowStauts())){
			if(bean.getFcType().equals("HTFL-01")){
				PurchaseApplyBasic applyBasic = cgApplysqMng.findById(Integer.valueOf(bean.getfPurchNo()));
				if(applyBasic!=null){
					applyBasic.setfContractSts(null);
					cgApplysqMng.saveOrUpdate(applyBasic);
				}
			}
		}
		super.saveOrUpdate(bean);
	}

	
	@Override
	public void updatefFlowStautsbg(String fcId,TProcessCheck checkBean,User user,String Id,String files,String fsyjsfiles)  throws Exception{
		ContractBasicInfo bean = super.findById(Integer.valueOf(fcId));
		CheckEntity entity = (CheckEntity)bean;
		
		String checkUrl = "/Change/approvalChange/";
		String lookUrl = "/Change/detail/";
		bean = (ContractBasicInfo)tProcessCheckMng.checkProcess(checkBean,entity,user,"HTND",checkUrl,lookUrl,files);
		if(user.getRoleName().contains("合同法审岗")&&Double.valueOf(bean.getFcAmount())>=100000&&bean.getStandard()==0){
			//如果上传附件不为空
			if(!StringUtil.isEmpty(fsyjsfiles)){
				attachmentMng.joinEntity(bean,fsyjsfiles);
			}else{
				throw new ServiceException("法审意见书上传出错，请重新上传！");
			}
		}
		//审批全部通过
		if("9".equals(bean.getfFlowStauts())){
			bean.setfContStauts("9");
			bean.setfUpdateStatus("0");//合同变更状态
			bean.setfDisputeStatus("0");//合同纠纷状态
			bean.setFsealedStatus(0);//合同盖章状态
			bean.setFgdStauts("0");//合同归档状态
		}
		//审批不通过
		if("-1".equals(bean.getfFlowStauts())){
			if(bean.getFcType().equals("HTFL-01")){
				PurchaseApplyBasic applyBasic = cgApplysqMng.findById(Integer.valueOf(bean.getfPurchNo()));
				if(applyBasic!=null){
					applyBasic.setfContractSts(null);
					cgApplysqMng.saveOrUpdate(applyBasic);
				}
			}
		}
		super.saveOrUpdate(bean);
	}
}
