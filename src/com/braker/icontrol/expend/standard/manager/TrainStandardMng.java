package com.braker.icontrol.expend.standard.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.expend.standard.entity.TrainStandard;

public interface TrainStandardMng extends BaseManager<TrainStandard>{

	/**
	 * 
	 * <p>Title: findbyTrainType</p>  
	 * <p>Description: 根据培训类型查询</p>  
	 * @param trainType 1-一类培训 2-二类培训 3-三类培训
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年3月30日
	 * @updator 陈睿超
	 * @updatetime 2020年3月30日
	 */
	TrainStandard findbyTrainType(Integer trainType);
}
