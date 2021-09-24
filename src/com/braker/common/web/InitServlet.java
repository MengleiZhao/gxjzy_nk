package com.braker.common.web;

import javax.servlet.http.HttpServlet;

import org.springframework.context.ApplicationContext;

import com.braker.common.util.SpringContextUtil;
import com.braker.common.web.init.InitFacade;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.EconomicMng;
import com.braker.core.manager.FunctionMng;
import com.braker.core.manager.LookupsMng;
import com.braker.quartz.QuartzManager;

/**
 * 服务器启动时候，初始化加载一些信息
 * @author 李安达
 * @createtime 2018-11-09
 * @updatetime 2018-11-09
 */
public class InitServlet  extends HttpServlet{
//	private InitFacade initFacade;
	private QuartzManager quartzManager;
	private FunctionMng functionMng;
	private DepartMng departMng;
	private LookupsMng lookupsMng;
	private EconomicMng economicMng;
	public void init() {
		try {
			//从ioc容器里获取被注入的bean对象
			ApplicationContext appCtx = SpringContextUtil.getApplicationContext();
//			initFacade = appCtx.getBean(InitFacade.class);
			//初始化用户信息和用户权限
//			initFacade.loadUserAndFunction(false);
			
			//初始化调度器任务
			quartzManager = appCtx.getBean(QuartzManager.class);
			quartzManager.reScheduleJob();
			
			//初始权限数据
			functionMng = appCtx.getBean(FunctionMng.class);
			functionMng.init();;
			
			//初始部门数据
			departMng = appCtx.getBean(DepartMng.class);
			departMng.init();
			
			//初始数据字典数据
			lookupsMng = appCtx.getBean(LookupsMng.class);
			lookupsMng.init();
			
			//初始经济科目分类数据
			economicMng = appCtx.getBean(EconomicMng.class);
			economicMng.init();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
