package com.braker.common.web.init;

import java.io.Serializable;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.braker.common.util.Executor.ExecutorProcessPool;
import com.braker.common.util.redis.RedisConstantsKeys;
import com.braker.common.util.redis.RedisUtil;
import com.braker.core.manager.FunctionMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Function;
import com.braker.core.model.User;
/**
 * 用户信息加载类
 * @author 李安达
 * @createtime 2018-11-09
 * @updatetime 2018-11-09
 */

@Service
public class InitUser {
	@Autowired
	private UserMng userMng;
	@Autowired
	private RedisUtil redisUtil;
	@Autowired
	private FunctionMng functionMng;


	/**
	 * 加载用户信息和用户的权限信息
	 * @author 李安达
	 * @createtime 2018-11-09
	 * @updatetime 2018-11-09
	 */
	public void loadUserAndFunction(boolean delKey){
		//使用线程池进行管理,因为如果有两百个用户，不使用线程池得话，会同时抢200个jdbc连接，可是jdbc连接只设置了100个连接池。会导致无法获得连接
		ExecutorProcessPool pool = ExecutorProcessPool.getInstance();
		List<User> userList=userMng.getALL();
		for(User user:userList){
			 pool.execute(new loadUserAndFunctionThread(user,delKey));
		}
		/*Thread thread = new Thread( new MyThread());  
		thread.start(); */
	}

	/**
	 * 使用线程向redis存储用户信息和用户的权限信息
	 * @author 李安达
	 * @createtime 2018-11-09
	 * @updatetime 2018-11-09
	 */
	public class loadUserAndFunctionThread implements Runnable {
		private boolean delKey;//是否先把所有key清理掉，重新加载数据到redis
		private User user;
		public loadUserAndFunctionThread(User user,boolean delKey){
			this.user=user;
			this.delKey=delKey;
		}
		public  void run() { 
			//如果delKey为true，先把所有key清理掉，重新加载数据到redis
			if(delKey){
				redisUtil.del(RedisConstantsKeys.GET_USER_KEY+user.getAccountNo());
				redisUtil.del(RedisConstantsKeys.GET_USER_FUNCTION_LIST_KEY+user.getId());
			}
			//把每个用户信息存入redis里，以登录名作为key
			redisUtil.setObject(RedisConstantsKeys.GET_USER_KEY+user.getAccountNo(), user);
			//获得每个用户的权限信息集合
			List<Function> functionList=functionMng.getFunctions(user.getId());
			redisUtil.setList(RedisConstantsKeys.GET_USER_FUNCTION_LIST_KEY+user.getId(), functionList);
		}
	}
	
	/**
	 * 加载一个用户信息
	 * @author 李安达
	 * @createtime 2018-11-09
	 * @updatetime 2018-11-09
	 */
	public void loadUser(String accountNo,boolean delKey){
		//如果delKey为true，先把所有key清理掉，重新加载数据到redis
		if(delKey){
			redisUtil.del(RedisConstantsKeys.GET_USER_KEY+accountNo);
		}
		User user=userMng.getByAccount(accountNo);
	}
	
}
