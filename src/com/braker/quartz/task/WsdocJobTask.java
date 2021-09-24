package com.braker.quartz.task;


import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.quartz.SchedulerException;
import org.springframework.context.ApplicationContext;

import com.braker.common.util.SpringContextUtil;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexDetail;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.entity.TIndexReleasePlan;
import com.braker.icontrol.budget.manager.manager.BudgetIndexDetailMng;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.manager.manager.IndexReleasePlanMng;
import com.braker.icontrol.budget.manager.manager.TransmitMng;
import com.braker.icontrol.budget.release.entity.TIndexDetail;
import com.braker.icontrol.cgmanage.cgconfplan.mananger.CgConPlanMng;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlan;
import com.braker.quartz.service.WsdocService;
 
 
public class WsdocJobTask{  
	
 private ApplicationContext appCtx = SpringContextUtil.getApplicationContext();
 
 	/**
 	 * 采购计划统计调用
 	 * @throws SchedulerException
 	 */
	public void cgConPlanrun() throws SchedulerException{
		try {
			 System.out.println("采购计划管理开始统计"+new Date());
			
			//从spring容器里获取实例
			 CgConPlanMng cgConPlanMng = appCtx.getBean(CgConPlanMng.class);
			 //调用方法
			 List<ProcurementPlan> list=cgConPlanMng.findAll();
			 System.out.println("统计数量:"+list.size());
			 
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
    	
     }
	
	/**
	 * 指标计划下达任务
	 * @author 叶崇晖
	 * @param arg0s arg0s[0]是下达计划的id,arg0s[1]是下达人的id,arg0s[2]是下达时间的String型
	 * @throws SchedulerException
	 */
	public void indexReleaserun(Object[] arg0s) throws SchedulerException{
		try {
			IndexReleasePlanMng indexReleasePlanMng = appCtx.getBean(IndexReleasePlanMng.class);
			BudgetIndexMgrMng budgetIndexMgrMng = appCtx.getBean(BudgetIndexMgrMng.class);
			BudgetIndexDetailMng budgetIndexDetailMng = appCtx.getBean(BudgetIndexDetailMng.class);
			WsdocService wsdocService = appCtx.getBean(WsdocService.class);
			
			/* 第一步查询到相应的下达计划修改计划的下达状态并保存  */
			TIndexReleasePlan plan = indexReleasePlanMng.findById(Integer.valueOf(arg0s[0].toString()));//根据传过来的pid查询计划
			plan.setType("1");//下达状态1、已执行
			indexReleasePlanMng.saveOrUpdate(plan);//修改计划的下达状态并保存
			
			/* 第二步查询相应的指标信息 修改指标的下达金额和剩余金额修改下达状态和下达方式 */
			TBudgetIndexMgr index = budgetIndexMgrMng.findByIndexCode(plan.getIndexCode());//根据指标编码查询指标
			
			DecimalFormat df = new DecimalFormat("0.000000");//保留6位小数
			
			BigDecimal releaseAmount=plan.getReleaseAmount();//获得计划下达的金额
			index.setXdAmount(index.getXdAmount().add(releaseAmount));//修改指标的下达金额
			index.setSyAmount(index.getSyAmount().add(releaseAmount));//修改指标的剩余金额
			index.setReleaseStauts("1");//指标状态改为已下达
			index.setReleaseType("3");//下达方式为3、定时自动下达
			budgetIndexMgrMng.saveOrUpdate(index);//保存指标的改动信息
			
			/* 第三步新建下达的流水信息  */
			TBudgetIndexDetail detailBean= new TBudgetIndexDetail();//建立新的指标下达流水信息
			detailBean.setbId(index.getbId());//下达明细设置关联预算指标管理的副键
			detailBean.setReleaseType("3");//下达方式为3、定时自动下达
			detailBean.setReleaseUser(arg0s[1].toString());//写入下达人
			
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = format.parse((String) arg0s[2]);
			detailBean.setReleaseTime(date);//写入下达时间
			
			detailBean.setBcReleaseAmount(plan.getReleaseAmount());//本次下达金额=计划信息中的下达金额
			budgetIndexDetailMng.merge(detailBean);//保存流水信息
			
			/* 第四步删除定时任务  */
			if(arg0s[3]!=null){
				wsdocService.deleteTargerByTriggerName(arg0s[3].toString());
			}
			 
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
    	
     }
}

