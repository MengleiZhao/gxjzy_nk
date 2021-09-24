package com.braker.icontrol.contract.approval.manager.Impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.approval.manager.CheckInfoMng;
import com.braker.icontrol.contract.approval.model.CheckInfo;
import com.braker.icontrol.contract.enforcing.model.Conclusion;

@Service
@Transactional
public class CheckInfoMngImpl extends BaseManagerImpl<CheckInfo> implements CheckInfoMng {

	@Override
	public List<CheckInfo> query(Integer fcId) {
		Finder finder = Finder.create(" FROM CheckInfo WHERE ftype='1' and fContId="+fcId );
		return super.find(finder);
	}

	@Override
	public  Pagination findByContId(ContractBasicInfo contractBasicInfo, User user, int pageNo, int pageSize) {
		Finder finder = Finder.create(" FROM CheckInfo WHERE fContId="+contractBasicInfo.getFcId());
		
		return super.find(finder,pageNo,pageSize);
	}

	@Override
	public void updateCheckStauts(Integer id) {
		Finder finder=Finder.create(" from CheckInfo where fContId="+id);
		List<CheckInfo> li = super.find(finder);
		for (int i = 0; i < li.size(); i++) {
			li.get(i).setCheckStauts("0");
			super.saveOrUpdate(li.get(i));
		}
		
	}

	@Override
	public List<CheckInfo> checkHistory(Integer id, String stauts) {
		Finder finder=Finder.create(" from CheckInfo where fContId="+id+" and CheckStauts='"+stauts+"'");
		return super.find(finder);
	}

}
