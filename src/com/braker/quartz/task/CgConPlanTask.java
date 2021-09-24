package com.braker.quartz.task;


import java.util.Date;
import java.util.List;

import org.quartz.SchedulerException;
import org.springframework.context.ApplicationContext;

import com.braker.common.util.SpringContextUtil;
import com.braker.icontrol.cgmanage.cgconfplan.mananger.CgConPlanMng;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlan;
 
 
public class CgConPlanTask{  
	
	private CgConPlanMng cgConPlanMng;
	
	public void run() throws SchedulerException{
		try {
			 System.out.println("采购计划管理开始统计"+new Date());
			 ApplicationContext appCtx = SpringContextUtil.getApplicationContext();
			//从spring容器里获取实例
			 cgConPlanMng = appCtx.getBean(CgConPlanMng.class);
			 //调用方法
			 List<ProcurementPlan> list=cgConPlanMng.findAll();
			 System.out.println("统计数量:"+list.size());
			 
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
    	
     }
}

