package com.braker.icontrol.expend.reimburse.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.expend.reimburse.manager.DirectlyReimbAttacMng;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbAttac;

/**
 * 直接报销单据附件的service实现类
 * @author 叶崇晖
 * @createtime 2018-08-08
 * @updatetime 2018-08-08
 */
@Service
@Transactional
public class DirectlyReimbAttacMngImpl extends BaseManagerImpl<DirectlyReimbAttac> implements DirectlyReimbAttacMng{

	/*
	 * 根据drId（直接报销ID）附件查询
	 * @author 叶崇晖
	 * @createtime 2018-08-04
	 * @updatetime 2018-08-04
	 */
	@Override
	public List<DirectlyReimbAttac> getByDrId(Integer drId) {
		Finder finder = Finder.create(" FROM DirectlyReimbAttac WHERE drId='"+drId+"'");
		return super.find(finder);
	}
	
	/*
	 * 附件信息查询根据附件名称
	 * @author 叶崇晖
	 * @createtime 2018-08-08
	 * @updatetime 2018-08-08
	 */
	@Override
	public List<DirectlyReimbAttac> getAttacByName(String filename) {
		Finder finder = Finder.create(" FROM DirectlyReimbAttac WHERE attacName='"+filename+"'");
		return super.find(finder);
	}


}
