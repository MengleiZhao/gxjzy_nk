package com.braker.icontrol.contract.enforcing.manager.Impl;

import java.text.SimpleDateFormat;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.enforcing.manager.ChangeMng;

@Service
@Transactional
public class ChangeMngImpl extends BaseManagerImpl<ContractBasicInfo> implements ChangeMng{

	@Override
	public Pagination queryList(ContractBasicInfo contractBasicInfo, User user, Integer pageNo, Integer pageSize) {
		Finder finder = Finder.create(" FROM ContractBasicInfo WHERE fFlowStauts='9' AND fContStauts in('3','9','7','11') ");
		finder.append(" AND fOperatorId =:fOperatorId ");
		finder.setParam("fOperatorId", user.getId());
		finder.append("AND fDeptName =:fDeptName ");
		finder.setParam("fDeptName", user.getDepart().getName());
		if(!StringUtil.isEmpty(contractBasicInfo.getFcCode())){
			finder.append("AND fcCode LIKE :fcCode ");
			finder.setParam("fcCode", "%"+contractBasicInfo.getFcCode()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcTitle())){
			finder.append("AND fcTitle LIKE :fcTitle ");
			finder.setParam("fcTitle", "%"+contractBasicInfo.getFcTitle()+"%");
		}
		if(contractBasicInfo.getfReqtIME()!=null){
			finder.append("AND datediff(fReqtIME,'"+contractBasicInfo.getfReqtIME()+"')=0");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcAmount())){
			finder.append("AND fcAmount LIKE :fcAmount ");
			finder.setParam("fcAmount", "%"+contractBasicInfo.getFcAmount()+"%");
		}
		finder.append("order by updateTime desc");
		return super.find(finder,pageNo,pageSize);
	}

	
}
