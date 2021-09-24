package com.braker.icontrol.budget.arrange.manager.impl;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.core.model.User;
import com.braker.icontrol.budget.arrange.entity.DepartBasicOut;
import com.braker.icontrol.budget.arrange.manager.DepartBasicOutMng;

@Service
@Transactional
public class DepartBasicOutMngImpl extends BaseManagerImpl<DepartBasicOut> implements DepartBasicOutMng {

	@Override
	public DepartBasicOut save(DepartBasicOut bean, User user) {

		Date date = new Date();
		if (bean.getFPId() == null) {
			bean.setFCreateUser(user.getAccountNo());
			bean.setFCreateTime(date);
			bean.setFUpdateUser(user.getAccountNo());
			bean.setFUpdateTime(date);
		} else {
			bean.setFUpdateUser(user.getAccountNo());
			bean.setFUpdateTime(date);
		}
		return (DepartBasicOut) super.saveOrUpdate(bean);
	}

	@Override
	public void save(List<DepartBasicOut> list, User user) {
		
		if (list != null && list.size() > 0) {
			for (DepartBasicOut bean: list) {
				save(bean,user);
			}
		}
	}

}
