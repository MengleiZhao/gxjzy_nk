package com.braker.icontrol.contract.filing.manager.Impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.filing.manager.SignInfoMng;
import com.braker.icontrol.contract.filing.model.SignInfo;

@Service
@Transactional
public class SignInfoMngImpl extends BaseManagerImpl<SignInfo> implements SignInfoMng{

	@Override
	public List<SignInfo> find_Sign(ContractBasicInfo contractBasicInfo) {
		Finder finder =Finder.create(" FROM SignInfo WHERE 1=1");
		finder.append(" AND fContId=:fContId");
		finder.setParam("fContId", contractBasicInfo.getFcId());
		return super.find(finder);
	}
	
	@Override
	public int find_Sign_number(ContractBasicInfo contractBasicInfo) {
		Finder finder =Finder.create(" FROM SignInfo WHERE 1=1");
		finder.append(" AND fContId=:fContId");
		finder.setParam("fContId", contractBasicInfo.getFcId());
		return super.find(finder).size();
	}
	
}
