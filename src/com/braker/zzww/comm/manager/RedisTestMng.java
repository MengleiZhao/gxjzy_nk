package com.braker.zzww.comm.manager;

import java.util.List;
import java.util.Map;

import com.braker.core.model.User;

public interface RedisTestMng {
	public User getByUserName();
	public List<User> getAllUsers();
	public Map<String, Object> hgetFromRedis(String redisKey,String valueKey);
	public String getFromRedis(String key);
	
}
