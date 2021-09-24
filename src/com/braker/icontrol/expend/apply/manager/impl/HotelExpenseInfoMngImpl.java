package com.braker.icontrol.expend.apply.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.icontrol.expend.apply.manager.HotelExpenseInfoMng;
import com.braker.icontrol.expend.apply.model.FoodAllowanceInfo;
import com.braker.icontrol.expend.apply.model.HotelExpenseInfo;

/**
 * 住宿费service实现层
 * @author 赵孟雷
 *
 */
@Service
@Transactional
public class HotelExpenseInfoMngImpl extends BaseManagerImpl<HotelExpenseInfo> implements HotelExpenseInfoMng {

	@Override
	public List<HotelExpenseInfo> findbygId(Integer gId,String travelType) {
		Finder finder = Finder.create("FROM HotelExpenseInfo WHERE sts=0");
		if(!StringUtil.isEmpty(String.valueOf(gId))){
			finder.append(" AND gId = "+gId);
		}
		if(!StringUtil.isEmpty(String.valueOf(travelType))){
			finder.append(" AND travelType = '"+travelType+"'");
		}
		return super.find(finder);
	}

	@Override
	public List<HotelExpenseInfo> rfindbygId(Integer rId,String travelType) {
		Finder finder = Finder.create("FROM HotelExpenseInfo WHERE sts=1");
		if(!StringUtil.isEmpty(String.valueOf(rId))){
			finder.append(" AND rId = "+rId);
		}
		if(!StringUtil.isEmpty(String.valueOf(travelType))){
			finder.append(" AND travelType = '"+travelType+"'");
		}
		return super.find(finder);
	}
	
}
