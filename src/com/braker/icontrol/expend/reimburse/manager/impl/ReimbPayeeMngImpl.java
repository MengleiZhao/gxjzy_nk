package com.braker.icontrol.expend.reimburse.manager.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.core.model.Lookups;
import com.braker.icontrol.cgmanage.cgprocess.model.BiddingRegist;
import com.braker.icontrol.expend.reimburse.manager.ReimbPayeeMng;
import com.braker.icontrol.expend.reimburse.model.ReimbPayeeInfo;


/**
 * 报销申请收款人的service实现类
 * @author 叶崇晖
 * @createtime 2018-08-10
 * @updatetime 2018-08-10
 */
@Service
@Transactional
public class ReimbPayeeMngImpl extends BaseManagerImpl<ReimbPayeeInfo> implements ReimbPayeeMng {

	/*
	 * 根据rId查询收款人信息
	 * @author 叶崇晖
	 * @createtime 2018-08-10
	 * @updatetime 2018-08-10
	 */
	@Override
	public List<ReimbPayeeInfo> getByRId(Integer rId) {
		Finder finder = Finder.create(" FROM ReimbPayeeInfo WHERE rId="+rId);
		return super.find(finder);
	}
	
	@Override
	public List<ReimbPayeeInfo> getByDrId(Integer drId) {
		Finder finder = Finder.create(" FROM ReimbPayeeInfo WHERE drId="+drId);
		return super.find(finder);
	}

	@Override
	public List<ReimbPayeeInfo> getByContId(Integer contId) {
		Finder finder = Finder.create(" FROM ReimbPayeeInfo WHERE contId="+contId);
		return super.find(finder);
	}
	
	@Override
	public List<Lookups> getpayeelookupsJson(String categoryCode,
			String blanked, String selected) {
		List<Lookups> list = new ArrayList<Lookups>();
		selected = StringUtil.isEmpty(selected)?null:selected;
		Finder finder = Finder.create(" FROM ReimbPayeeInfo GROUP BY payeeName,bank,bankAccount");
		List<ReimbPayeeInfo> brlist = super.find(finder);
		for (int i = 0; i < brlist.size(); i++) {
			Lookups lookups = new Lookups();
			ReimbPayeeInfo reimbPayeeInfo = brlist.get(i);
			lookups.setCode(String.valueOf(reimbPayeeInfo.getpId()));
			lookups.setName(reimbPayeeInfo.getPayeeName());
			list.add(lookups);
		}
		return list;
	}

}
