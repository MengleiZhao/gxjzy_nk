package com.braker.icontrol.budget.project.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.budget.project.entity.XmDept;
import com.braker.icontrol.budget.project.manager.XmDeptMng;
@Service
@Transactional
public class XmDeptMngImpl extends BaseManagerImpl<XmDept> implements XmDeptMng{

	@Override
	public List<XmDept> xmDeptListById(String id) {
		Finder finder = Finder.create(" from XmDept where fdeptid ='"+id+"'");
		return super.find(finder);
	}
}
