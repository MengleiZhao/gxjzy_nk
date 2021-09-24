package com.braker.quartz.task;

import java.util.Date;

import javax.transaction.Transactional;

import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;

import com.braker.common.util.SpringContextUtil;
import com.braker.icontrol.expend.loan.manager.LoanMng;

@Service
@Transactional
public class LoanTask {

	private LoanMng loanMng;
	
	public void LoanRemind(){
		System.out.println("还款提醒"+new Date());
		ApplicationContext scu =  SpringContextUtil.getApplicationContext();
		loanMng = scu.getBean(LoanMng.class);
		loanMng.daysRemind();
		
	}
	
}
