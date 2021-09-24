package com.braker.icontrol.expend.history.manager.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.expend.apply.manager.ApplyMng;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.history.manager.CheckHistoryMng;
import com.braker.icontrol.expend.loan.manager.LoanMng;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbMng;
import com.braker.icontrol.expend.reimburse.manager.ReimbAppliMng;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbAppliBasicInfo;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;


@Service
@Transactional
public class CheckHistoryMngImpl  extends BaseManagerImpl<TProcessCheck> implements CheckHistoryMng {
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private ApplyMng applyMng;			//事前申请
	@Autowired
	private LoanMng loanMng;				//借款申请
	@Autowired
	private DirectlyReimbMng directlyReimbMng;	//直接报销申请
	@Autowired
	private ReimbAppliMng reimbAppliMng;	//申请报销
	@Autowired
	private FormulationMng formulationMng;	//合同
	
	
	@Override
	public List<TProcessCheck> findCheckHistorys(String type,String foCode, String stauts) {
		//根据类型获取流程审批id
		String fpids=getFpidsByType(type);
		Finder finder = Finder.create(" FROM TProcessCheck WHERE foCode="+foCode+" and FPId in ("+fpids+") ");
		if(stauts != null) {
			finder.append(" AND stauts="+stauts);
		}
		return super.find(finder);
	}
	/**
	 * 根据类型的到fpid 拼接好的字符串
	 * @param type
	 * @return
	 */
	private String getFpidsByType(String type){
		List<TProcessDefin> tProcessDefinList= new ArrayList<TProcessDefin>();
		if("loan".equals(type)){//借款申请审批信息查询
			tProcessDefinList=tProcessDefinMng.findTProcessDefinsByFBusiArea("JKSQ");
		}else if("directly".equals(type)){//直接报销申请审批信息查询
			tProcessDefinList=tProcessDefinMng.findTProcessDefinsByFBusiArea("BXSQ");
		}else{
			//转换type选择流程
			String strType = tProcessCheckMng.JudgmentProcess(String.valueOf(type));
			tProcessDefinList=tProcessDefinMng.findTProcessDefinsByFBusiArea(strType);
		}
		String fpids=list2string(tProcessDefinList);
		return fpids;
	}
	/**
	 * list转换成string
	 * @param tProcessDefinList
	 * @return
	 */
	private String list2string(List<TProcessDefin> tProcessDefinList){
		String fpids="";
		for(TProcessDefin process: tProcessDefinList){
			if("".equals(fpids)){
				fpids=process.getFPId()+"";
			}else{
				fpids=fpids+","+process.getFPId();
			}
		}
		return fpids;
		
	}
	@Override
	public String getFoCodeById(String type, Integer id) {
		// TODO Auto-generated method stub
		if("apply".equals(type)){////事前申请审批信息查询
			ApplicationBasicInfo info=applyMng.findById(id);
			return info.getBeanCode();
		}
		if("loan".equals(type)){//借款
			LoanBasicInfo info=loanMng.findById(id);
			return info.getBeanCode();
		}
		if("directly".equals(type)){//直接报销
			DirectlyReimbAppliBasicInfo info=directlyReimbMng.findById(id);
			return info.getBeanCode();
		}
		if("reimburse".equals(type)){//报销申请
			ReimbAppliBasicInfo info=reimbAppliMng.findById(id);
			return info.getBeanCode();
		}
		if("contCheck".equals(type)){//合同
			ContractBasicInfo info=formulationMng.findById(id);
			return info.getBeanCode();
		}
		
		return null;
	}
}
