package com.braker.common.util;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
/**
 * 获取spring IOC容器内注入对象的工具类
 * @author 李安达
 * @createtime 2018-11-12
 * @updatetime 2018-11-12
 */
public class SpringContextUtil implements ApplicationContextAware {
    private static ApplicationContext applicationContext = null;

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
         this.applicationContext = applicationContext;
    }

    public static ApplicationContext  getApplicationContext(){
        return applicationContext;
    }
    
    public static <T> T getBean(String beanName) {
		if(applicationContext.containsBean(beanName)) {
			return (T) applicationContext.getBean(beanName);
		} else {
			return null;
		}
	}
  /*  public static Object getBean(String beanName){
        return applicationContext.getBean(beanName);
    }*/

    public static Object getBean(Class c){
        return applicationContext.getBean(c);
    }
}
