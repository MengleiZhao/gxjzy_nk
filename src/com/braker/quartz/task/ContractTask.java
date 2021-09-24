package com.braker.quartz.task;

import java.util.Date;

import javax.transaction.Transactional;

import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;

import com.braker.common.util.SpringContextUtil;
import com.braker.icontrol.contract.expiration.manager.ExpirationMng;

/**
 * 合同的定时器
 * @author 陈睿超
 *
 */
@Service
@Transactional
public class ContractTask {

	private ExpirationMng expirationMng;
	
	/**
	 * 合同付款到期提醒60天、30天、20天、10天、每天
	 * 
	 * @author 陈睿超
	 * @createTime 2019年8月27日
	 * @updateTime 2019年8月27日
	 */
	public void expiration(){
		//System.out.println("合同付款提醒"+new Date());
		ApplicationContext scu = SpringContextUtil.getApplicationContext();
		expirationMng = scu.getBean(ExpirationMng.class);
		//合同付款到期提醒
		/*expirationMng.remindPayMoney();*/
	}
	
	/**
	 * 结束时间-开始时间除以2）和到期前5天进行消息提醒，内容为：您有一份XX合同正在XX状态
	 * @author 陈睿超
	 * @createTime2019年10月31日
	 * @updateTime2019年10月31日
	 */
	public void expirationContract(){
		ApplicationContext scu = SpringContextUtil.getApplicationContext();
		expirationMng = scu.getBean(ExpirationMng.class);
		//合同到期提醒
		expirationMng.remindContract();;
	}
	
	
}
