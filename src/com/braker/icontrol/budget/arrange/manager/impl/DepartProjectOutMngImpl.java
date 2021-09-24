package com.braker.icontrol.budget.arrange.manager.impl;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.budget.arrange.entity.DepartProjectOut;
import com.braker.icontrol.budget.arrange.manager.DepartProjectOutMng;

@Service
@Transactional
public class DepartProjectOutMngImpl extends BaseManagerImpl<DepartProjectOut> implements DepartProjectOutMng {

	@Override
	public DepartProjectOut save(DepartProjectOut bean, User user) {
		
		Date date = new Date();
		if (bean.getFPpId() == null) {
			bean.setFCreateUser(user.getAccountNo());
			bean.setFCreateTime(date);
			bean.setFUpdateUser(user.getAccountNo());
			bean.setFUpdateTime(date);
		} else {
			bean.setFUpdateUser(user.getAccountNo());
			bean.setFUpdateTime(date);
		}
		return (DepartProjectOut)super.saveOrUpdate(bean);
	}

	@Override
	public void save(List<DepartProjectOut> list, User user) {

		double total = 0;
		if (list != null && list.size() > 0) {
			for (DepartProjectOut bean: list) {
				save(bean,user);
			}
		}
	}

	@Override
	public List<DepartProjectOut> getProjectOutByArrange(Integer arrangeId, Integer type) {
		
 		Finder f = Finder.create(" from DepartProjectOut where 1=1 ");
		
		if (arrangeId != null){
			f.append(" and arrange.FDCId=:arrangeId ").setParam("arrangeId", arrangeId);
		}
		if (type != null){
			f.append(" and  FType=:type ").setParam("type", type);
		}
		
		f.append(" order by FProId.FProCode asc ");
		return super.find(f);
	}

	
}
