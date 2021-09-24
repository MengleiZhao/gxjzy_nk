package com.braker.icontrol.expend.apply.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.icontrol.expend.apply.manager.FoodAllowanceInfoMng;
import com.braker.icontrol.expend.apply.model.FoodAllowanceInfo;

/**
 * 伙食补助费service实现层
 * @author 赵孟雷
 *
 */
@Service
@Transactional
public class FoodAllowanceInfoMngImpl extends BaseManagerImpl<FoodAllowanceInfo> implements FoodAllowanceInfoMng {

	@Override
	public List<FoodAllowanceInfo> findbygId(Integer gId,String travelType) {
		Finder finder = Finder.create("FROM FoodAllowanceInfo WHERE fStatus =0");
		if(!StringUtil.isEmpty(String.valueOf(gId))){
			finder.append(" AND gId = "+gId);
		}
		if(!StringUtil.isEmpty(String.valueOf(travelType))){
			finder.append(" AND travelType = '"+travelType+"'");
		}
		return super.find(finder);
	}

	@Override
	public List<FoodAllowanceInfo> rfindbygId(Integer rId,String travelType) {
		Finder finder = Finder.create("FROM FoodAllowanceInfo WHERE fStatus =1");
		if(!StringUtil.isEmpty(String.valueOf(rId))){
			finder.append(" AND rId = "+rId);
		}
		if(!StringUtil.isEmpty(String.valueOf(travelType))){
			finder.append(" AND travelType = '"+travelType+"'");
		}
		return super.find(finder);
	}


}
