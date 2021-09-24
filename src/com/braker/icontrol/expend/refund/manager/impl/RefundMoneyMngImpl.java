package com.braker.icontrol.expend.refund.manager.impl;

import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;

import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.expend.refund.manager.RefundMoneyMng;
import com.braker.icontrol.expend.refund.model.RefundInfo;
import com.braker.icontrol.expend.refund.model.StudentRefundMoney;

@Service
public class RefundMoneyMngImpl extends BaseManagerImpl<StudentRefundMoney> implements RefundMoneyMng{

	@Override
	public List<StudentRefundMoney> findbyfRId(Integer fRId) {
		Finder finder = Finder.create("from StudentRefundMoney where fRId = "+fRId);
		return super.find(finder);
	}

	@Override
	public void save(RefundInfo refundInfo, String infomoneyJson, User user) {
		List<StudentRefundMoney> infomoneyList = JSONArray.toList(JSONArray.fromObject(infomoneyJson), StudentRefundMoney.class);
		for (int i = 0; i < infomoneyList.size(); i++) {
			
			
		}
		
	}


	
	
	
}