package com.braker.icontrol.expend.standard.manager.impl;

import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.icontrol.expend.standard.entity.MeetStandard;
import com.braker.icontrol.expend.standard.manager.MeetStandardMng;

@Service
public class MeetStandardMngImpl extends BaseManagerImpl<MeetStandard> implements MeetStandardMng{

	/* 
	 * <p>Title: findbyMeetType</p>
	 * <p>Description: </p>
	 * @param meetType
	 * @return
	 * @see com.braker.icontrol.expend.standard.manager.MeetStandardMng#findbyMeetType(java.lang.Integer) 
	 * @author 陈睿超
	 * @createtime 2020年3月30日
	 * @updator 陈睿超
	 * @updatetime 2020年3月30日
	 */
	@Override
	public MeetStandard findbyMeetType(Integer meetType) {
		if(meetType==4){
			meetType=3;
		}
		Finder finder = Finder.create("FROM MeetStandard WHERE 1=1 ");
		if(!StringUtil.isEmpty(String.valueOf(meetType))){
			finder.append("AND costLevel ='"+meetType+"' ");
		}
		return (MeetStandard) super.find(finder).get(0);
	}

}
