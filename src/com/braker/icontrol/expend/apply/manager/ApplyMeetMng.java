package com.braker.icontrol.expend.apply.manager;

import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Notice;
import com.braker.core.model.NoticeAttac;
import com.braker.core.model.SystemCenterAttac;
import com.braker.core.model.User;
import com.braker.icontrol.expend.apply.model.AbroadAppliInfo;
import com.braker.icontrol.expend.apply.model.ApplicationAttac;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.apply.model.ApplicationDetail;
import com.braker.icontrol.expend.apply.model.MeetingAppliInfo;
import com.braker.icontrol.expend.apply.model.OfficeCar;
import com.braker.icontrol.expend.apply.model.ReceptionAppliInfo;
import com.braker.icontrol.expend.apply.model.TrainingAppliInfo;
import com.braker.icontrol.expend.apply.model.TravelAppliInfo;

/**
 * 事前申请-会议的service抽象类
 * @author 张迅
 * @createtime 2020-02-13
 * @updatetime 2020-02-13
 */
public interface ApplyMeetMng extends BaseManager<ApplicationBasicInfo>{
	
	public void save(User user, ApplicationBasicInfo bean, 
			MeetingAppliInfo meetingBean, 
			String meetPlan,
			String files, String mingxi
			) throws Exception;
	
}
