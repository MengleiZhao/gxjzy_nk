package com.braker.quartz.task;

import java.util.Date;

import javax.transaction.Transactional;

import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;

import com.braker.common.util.SpringContextUtil;
import com.braker.core.manager.PersonalWorkMng;

/**
 * 首页的定时器
 * @author 陈睿超
 *
 */
@Service
@Transactional
public class HomePageTask {

	private PersonalWorkMng personalWork;
	
	public void personalWorkInfo(){
		System.out.println("首页代办超过30天提醒"+new Date());
		ApplicationContext slc = SpringContextUtil.getApplicationContext();
		personalWork = slc.getBean(PersonalWorkMng.class);
		personalWork.findAlltaskStauts0();
		
		
	}
	
}
