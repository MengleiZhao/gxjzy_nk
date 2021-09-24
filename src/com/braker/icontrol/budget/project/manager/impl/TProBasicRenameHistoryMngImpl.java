package com.braker.icontrol.budget.project.manager.impl;

import java.util.Date;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProBasicRenameHistory;
import com.braker.icontrol.budget.project.manager.TProBasicRenameHistoryMng;

@Service
@Transactional
public class TProBasicRenameHistoryMngImpl extends BaseManagerImpl<TProBasicRenameHistory> implements  TProBasicRenameHistoryMng{

	@Override
	public void saveHistory(TProBasicInfo bean, String newName,User user) {
		// TODO Auto-generated method stub
		TProBasicRenameHistory tbrh=new TProBasicRenameHistory();
		tbrh.setNewValue(newName);
		tbrh.setOldValue(bean.getFProName());
		tbrh.setProId(bean.getFProId());
		tbrh.setUpdateTime(new Date());
		tbrh.setOperator(user.getName());
		tbrh.setOperatorId(user.getId());
		super.save(tbrh);
	}
	
	@Override
	public Pagination pageList(TProBasicRenameHistory bean,User user,  int pageNo, int pageSize) {

		Finder finder =Finder.create("  FROM TProBasicRenameHistory where 1=1 ");
		finder.append(" order by rId desc");
		return super.find(finder,pageNo,pageSize);
	}
	
}
