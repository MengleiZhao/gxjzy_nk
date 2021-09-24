package com.braker.zzww.comm.manager.impl;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.braker.common.util.redis.RedisConstantsKeys;
import com.braker.common.util.redis.RedisUtil;
import com.braker.core.model.User;
import com.braker.zzww.comm.manager.RedisTestMng;
@Service
public class RedisTestMngImpl implements RedisTestMng{
	@Autowired
	private RedisUtil redisUtil;
	
	
	@Override
	public User getByUserName() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<User> getAllUsers() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public Map<String, Object> hgetFromRedis(String redisKey,String valueKey) {
		 String fkvalue1=redisUtil.getJedis().hget(redisKey,valueKey);
			/*//造数据
			 if(fkvalue1==null){
				 String redisValue="{\"data\":{\"jiaob\":{\"shb\":0,\"gj\":0},\"jj\":{\"shb\":0,\"gj\":0}},\"rank\":{\"group\":{\"user\":\"超级管理员\",\"num\":0,\"p_rank\":0},\"zone\":{\"user\":\"超级管理员\",\"num\":0,\"p_rank\":0},\"center\":{\"user\":\"超级管理员\",\"num\":0,\"p_rank\":1}}}";
				 JSONObject jsonObj = JSONObject.fromObject(redisValue); 
			     String fkvalue=jsonObj.toString();
				 redisUtil.getJedis().hset(RedisConstantsKeys.HGET_KEY, "test", fkvalue);
				 fkvalue1=redisUtil.getJedis().hget(RedisConstantsKeys.HGET_KEY, "test");
			 }*/
			 Map<String, Object> resultMap= JSONObject.fromObject(fkvalue1);
				
			return resultMap;
	}

	@Override
	public String getFromRedis(String key) {
		// TODO Auto-generated method stub
		String fkvalue1=redisUtil.getJedis().get(key);
		//造数据
		/* if(fkvalue1==null){
			 String redisValue="hello world";
			 redisUtil.getJedis().set(RedisConstantsKeys.GET_KEY,  redisValue);
			 fkvalue1=redisUtil.getJedis().get(RedisConstantsKeys.GET_KEY);
		 }*/
			
		return fkvalue1;
	}
	
}
