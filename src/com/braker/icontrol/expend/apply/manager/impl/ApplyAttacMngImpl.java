package com.braker.icontrol.expend.apply.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.expend.apply.manager.ApplyAttacMng;
import com.braker.icontrol.expend.apply.model.ApplicationAttac;

/**
 * 事前申请附件的service实现类
 * @author 叶崇晖
 * @createtime 2018-06-29
 * @updatetime 2018-06-29
 */
@Service
@Transactional
public class ApplyAttacMngImpl extends BaseManagerImpl<ApplicationAttac> implements ApplyAttacMng{

	/*
	 * 根据gId（直接申请ID）附件信息
	 * @author 叶崇晖
	 * @createtime 2018-07-07
	 * @updatetime 2018-07-07
	 */
	@Override
	public List<ApplicationAttac> getByGId(Integer gId) {
		Finder finder = Finder.create(" FROM ApplicationAttac WHERE gId='"+gId+"'");
		return super.find(finder);
	}

	/*
	 * 附件信息查询根据附件名称
	 * @author 叶崇晖
	 * @createtime 2018-07-09
	 * @updatetime 2018-07-09
	 */
	@Override
	public List<ApplicationAttac> getAttacByName(String filename) {
		Finder finder = Finder.create(" FROM ApplicationAttac WHERE attacName='"+filename+"'");
		return super.find(finder);
	}

}
