package com.braker.quartz.task;


import java.util.Date;
import java.util.List;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.util.SpringContextUtil;
import com.braker.icontrol.cgmanage.cgconfplan.mananger.CgConPlanMng;
 
 
@Service
@Transactional
public class ISCSynAllData {  
	public void run(Object[] arg0s)  throws SchedulerException{
		try {
			Date d=new Date();
			 System.out.println("开始执行测试"+d);
			
			 for(Object obj:arg0s){
				 System.out.println(obj.toString());
			 }
			 Thread.sleep(5000);
			 System.out.println(d+"创建的任务执行结束"+new Date());
			/* ApplicationContext appCtx = SpringContextUtil.getApplicationContext();
			 SchedulerFactoryBean schedulerFactoryBean=appCtx.getBean(SchedulerFactoryBean.class);
			 //得到正在执行的所有任务
			 List<JobExecutionContext> jobContexts = schedulerFactoryBean.getScheduler().getCurrentlyExecutingJobs();
			for(int i=0;i<jobContexts.size();i++){
				String key=jobContexts.get(i).getJobDetail().getKey().getName();
				 System.out.println(key);
			 }*/
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
    	
     }

}

