package com.braker.icontrol.expend.standard.manager.impl;

import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.icontrol.expend.standard.entity.TrainStandard;
import com.braker.icontrol.expend.standard.manager.TrainStandardMng;

@Service
public class TrainStandardMngImpl extends BaseManagerImpl<TrainStandard> implements TrainStandardMng{

	/* 
	 * <p>Title: findbyTrainType</p>
	 * <p>Description: </p>
	 * @param trainType
	 * @return
	 * @see com.braker.icontrol.expend.standard.manager.TrainStandardMng#findbyTrainType(java.lang.Integer) 
	 * @author 陈睿超
	 * @createtime 2020年3月30日
	 * @updator 陈睿超
	 * @updatetime 2020年3月30日
	 */
	@Override
	public TrainStandard findbyTrainType(Integer trainType) {
		Finder finder = Finder.create("FROM TrainStandard WHERE 1=1");
		if(!StringUtil.isEmpty(String.valueOf(trainType))){
			finder.append(" AND fTrainType ="+trainType+" ");
		}
		return (TrainStandard) super.find(finder).get(0);
	}

}
