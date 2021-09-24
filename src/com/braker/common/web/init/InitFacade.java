package com.braker.common.web.init;

import java.io.Serializable;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 外观设计模式， 管理调用各种加载信息到redis的方法
 * @author 李安达
 * @createtime 2018-11-13
 * @updatetime 2018-11-13
 */
@Service
public class InitFacade {

	@Autowired
	private InitUser initUser;
	
	/**
	 * 加载用户信息和用户的权限信息
	 * @author 李安达
	 * @createtime 2018-11-13
	 * @updatetime 2018-11-13
	 */
	public void loadUserAndFunction(boolean delKey){
		//20181228 李安达注释掉，优化了sql语句查询，速度提高了，暂时没必要使用redis
		// initUser.loadUserAndFunction(delKey);
	}
	/**
	 * 加载一个用户信息
	 * @author 李安达
	 * @createtime 2018-11-09
	 * @updatetime 2018-11-09
	 */
	public void loadUser(String accountNo,boolean delKey){
		initUser.loadUser(accountNo,delKey);
	}
}
