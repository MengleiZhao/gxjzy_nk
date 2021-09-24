package com.braker.icontrol.budget.control.manager.impl;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.budget.control.entity.TProExpend;
import com.braker.icontrol.budget.control.manager.TProExpendMng;

@Service
@Transactional
public class TProExpendMngImpl extends BaseManagerImpl<TProExpend> implements TProExpendMng {

	@Override
	public void saveProOuts(User user, List<TProExpend> outcomeList) {

		if (outcomeList != null && outcomeList.size() > 0) {
			for (TProExpend bean: outcomeList) {
				super.saveOrUpdate(bean);
			}
		}
	}

	@Override
	public List<TProExpend> getYearProOuts(Integer numId, String departName) {
		
		Finder f = Finder.create(" from TProExpend where 1=1");
		if (numId != null) {
			f.append(" and fCId.fCId=:numId ").setParam("numId", numId);
		}
		if (!StringUtil.isEmpty(departName)) {
			f.append(" and fProAppliDepart=:departName ").setParam("departName", departName);
		}
		return super.find(f);
	}

	@Override
	public List<TProExpend> getLeastProOuts(Integer numId, String departName) {
		
		Finder f = Finder.create(" from TProExpend where FType=2 ");
		if (numId != null) {
			f.append(" and FBCId.FBCId=:numId ").setParam("numId", numId);
		}
		if (!StringUtil.isEmpty(departName)) {
			f.append(" and FProId.FProAppliDepart=:departName ").setParam("departName", departName);
		}
		return super.find(f);
	}
	
	
}
