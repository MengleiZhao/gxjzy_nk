package com.braker.icontrol.expend.reimburse.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.expend.reimburse.manager.ReimbAttacMng;
import com.braker.icontrol.expend.reimburse.model.ReimbAttac;

/**
 * 报销附件的service实现类
 * @author 叶崇晖
 * @createtime 2018-08-13
 * @updatetime 2018-08-13
 */
@Service
@Transactional
public class ReimbAttacMngImpl extends BaseManagerImpl<ReimbAttac> implements ReimbAttacMng {

	/*
	 * 根据rId（报销ID）附件查询
	 * @author 叶崇晖
	 * @createtime 2018-08-13
	 * @updatetime 2018-08-13
	 */
	@Override
	public List<ReimbAttac> getByRId(Integer rId) {
		Finder finder = Finder.create(" FROM ReimbAttac WHERE rId='"+rId+"'");
		return super.find(finder);
	}

	/*
	 * 附件信息查询根据附件名称
	 * @author 叶崇晖
	 * @createtime 2018-08-13
	 * @updatetime 2018-08-13
	 */
	@Override
	public List<ReimbAttac> getAttacByName(String filename) {
		Finder finder = Finder.create(" FROM ReimbAttac WHERE attacName='"+filename+"'");
		return super.find(finder);
	}

}
