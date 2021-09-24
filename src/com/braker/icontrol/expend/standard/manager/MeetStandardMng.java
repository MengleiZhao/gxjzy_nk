package com.braker.icontrol.expend.standard.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.expend.standard.entity.MeetStandard;

public interface MeetStandardMng extends BaseManager<MeetStandard>{

	/**
	 * 根据会议类型查询
	 * <p>Title: findbyMeetType</p>  
	 * <p>Description: </p>  
	 * @param meetType 会议类型1-一类会议。2-二类会议 3-三类会议 4-四类会议
	 * @return 
	 * @author 陈睿超
	 * @createtime 2020年3月30日
	 * @updator 陈睿超
	 * @updatetime 2020年3月30日
	 */
	MeetStandard findbyMeetType(Integer meetType);
	
}
