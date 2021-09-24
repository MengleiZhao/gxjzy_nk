package com.braker.core.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.core.manager.SysParamMng;
import com.braker.core.model.SysParam;
@SuppressWarnings("unchecked")
@Transactional
@Service
public class SysParamMngImpl extends BaseManagerImpl<SysParam> implements SysParamMng{
	@Override
	public SysParam findByKey(String key){
		Finder hql=Finder.create(" from SysParam where paramKey='"+key+"'");
		List<SysParam> sp=super.find(hql);
		if(sp!=null&&sp.size()>0){
			return sp.get(0);
		}
		return null;
	}
}
