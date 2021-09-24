package com.braker.quartz;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.BeanFactoryAware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.CronTriggerBean;
import org.springframework.scheduling.quartz.MethodInvokingJobDetailFactoryBean;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.util.StringUtil;
import com.braker.quartz.model.Wsdoc;
import com.braker.quartz.service.WsdocService;
/**
 * 定时器任务计划管理模块
 * @author 安达
 * @createtime 2019-03-11
 * @updatetime 22019-03-11
 */
@Service
@Transactional
public class QuartzManager implements BeanFactoryAware {
	private Logger log = Logger.getLogger(QuartzManager.class);
	//private Scheduler scheduler;
	@Autowired
	SchedulerFactoryBean schedulerFactoryBean;
	@Autowired
	private WsdocService wsdocService;

	private static BeanFactory beanFactory = null;
	
	@SuppressWarnings("unused")
	public void reScheduleJob() throws Exception, ParseException {
		// 通过查询数据库里计划任务来配置计划任务
		try {
			List<Wsdoc> quartzList = wsdocService.getAllTarger(); //从数据库中获取所有的配置信息
			if (quartzList != null && quartzList.size() > 0) {
				for (Wsdoc wsdoc1 : quartzList) {
					configQuatrz(wsdoc1);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
	}

	public boolean configQuatrz(Wsdoc wsdoc) {
		boolean result = false;
		try {
			// 运行时可通过动态注入的scheduler得到trigger
			CronTriggerBean trigger = (CronTriggerBean) schedulerFactoryBean.getScheduler().getTrigger(
					wsdoc.getTriggername(), Scheduler.DEFAULT_GROUP);
			// 如果计划任务不存在并且数据库里的任务状态为可用时,则创建计划任务
			if (wsdoc.getState().equals("1")) {
				if (trigger != null) {
					//如果计划任务已存在则先停止
					stop(trigger);
					Thread.sleep(5000);
				}
				this.createCronTriggerBean(wsdoc);
			}else{
				stop(trigger);
			}
			result = true;
		} catch (Exception e) {
			result = false;
			e.printStackTrace();
		}

		return result;
	}
	/**
	 * 任务计划修改,这个只修改任务的时间表达式
	 * @param wsdoc
	 * @param trigger
	 * @throws Exception
	 */
	public void change(Wsdoc wsdoc, CronTriggerBean trigger)
			throws Exception {
		// 如果任务为可用
		if (wsdoc.getState().equals("1")) {
			// 判断从DB中取得的任务时间和现在的quartz线程中的任务时间是否相等
			// 如果相等，则表示用户并没有重新设定数据库中的任务时间，这种情况不需要重新rescheduleJob
			if (!trigger.getCronExpression().equalsIgnoreCase(
					wsdoc.getCronexpression())) {
				// 新建一个基于Spring的管理Job类
				JobDetail jobDetail=getJobDetail(wsdoc);
				trigger.setJobDetail(jobDetail);// 注入Job
				trigger.setCronExpression(wsdoc.getCronexpression());
				schedulerFactoryBean.getScheduler().rescheduleJob(wsdoc.getTriggername(),
						Scheduler.DEFAULT_GROUP, trigger);//刷新管理类
				log.info(new Date() + ": 更新" + wsdoc.getTriggername() + "计划任务");
			}
		} else {
			// 设置任务不可用
			stop(trigger);
		}

	}
	
	/**
	 * 停止任务
	 * @param trigger
	 * @throws Exception
	 */
	public void stop(CronTriggerBean trigger)throws Exception {
		// 设置任务不可用
		if(trigger!=null){
			schedulerFactoryBean.getScheduler().pauseTrigger(trigger.getName(), trigger.getGroup());// 停止触发器
			schedulerFactoryBean.getScheduler().unscheduleJob(trigger.getName(), trigger.getGroup());// 移除触发器
			schedulerFactoryBean.getScheduler().deleteJob(trigger.getJobName(), trigger.getJobGroup());// 删除任务
		}
		
	}
	/**
	 *  新建一个基于Spring的管理Job类
	 * @param wsdoc
	 * @return
	 */
	public  JobDetail getJobDetail(Wsdoc wsdoc) throws Exception {
		// 新建一个基于Spring的管理Job类
		MethodInvokingJobDetailFactoryBean mjdfb = new MethodInvokingJobDetailFactoryBean();
		mjdfb.setName(wsdoc.getJobdetailname());// 设置Job名称
		//直接new对象
		mjdfb.setTargetObject(Class.forName(wsdoc.getTargetobject()).newInstance());// 设置任务类
		//如果有动态的传参数，就转换成数组对象传入
		if(!StringUtils.isEmpty(wsdoc.getArguments())){
			String[] strs=wsdoc.getArguments().split(",");
			mjdfb.setArguments(strs);//动态的参数
		}
		mjdfb.setTargetMethod(wsdoc.getMethodname());// 设置任务方法
		mjdfb.setConcurrent(wsdoc.getConcurrent().equals("0") ? false : true); // 设置是否并发启动任务
		mjdfb.afterPropertiesSet();// 将管理Job类提交到计划管理类
		// 将Spring的管理Job类转为Quartz管理Job类
		JobDetail jobDetail = new JobDetail();
		jobDetail = (JobDetail) mjdfb.getObject();
		jobDetail.setName(wsdoc.getJobdetailname());
		return 	jobDetail;
	}
	/**
	 * 创建/添加计划任务
	 * 
	 * @param wsdoc
	 *            计划任务配置对象
	 * @throws Exception
	 */
	public void createCronTriggerBean(Wsdoc wsdoc) throws Exception {
		// 新建一个基于Spring的管理Job类
		JobDetail jobDetail=getJobDetail(wsdoc);
		schedulerFactoryBean.getScheduler().addJob(jobDetail, true); // 将Job添加到管理类
		// 新一个基于Spring的时间类
		CronTriggerBean trigger = new CronTriggerBean();
		trigger.setCronExpression(wsdoc.getCronexpression());// 设置时间表达式
		trigger.setName(wsdoc.getTriggername());// 设置名称
		trigger.setJobDetail(jobDetail);// 注入Job
		trigger.setJobName(wsdoc.getJobdetailname());// 设置Job名称
		schedulerFactoryBean.getScheduler().scheduleJob(trigger);// 注入到管理类
		schedulerFactoryBean.getScheduler().rescheduleJob(wsdoc.getTriggername(), Scheduler.DEFAULT_GROUP,
				trigger);// 刷新管理类
		log.info(new Date() + ": 新建" + wsdoc.getTriggername() + "计划任务");
	}


	public void setBeanFactory(BeanFactory factory) throws BeansException {
		this.beanFactory = factory;

	}

	public BeanFactory getBeanFactory() {
		return beanFactory;
	}

}
