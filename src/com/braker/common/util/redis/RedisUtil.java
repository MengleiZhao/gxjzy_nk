package com.braker.common.util.redis;


import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.connection.jedis.JedisConnectionFactory;
import org.springframework.stereotype.Service;

import redis.clients.jedis.Jedis;

/**
 * 封装redis 缓存服务器服务接口
 * @author 安达
 * @createtime 2018-11-07
 * @updatetime 2018-11-07
 */
@Service
public class RedisUtil {
	private static final Logger log = Logger.getLogger(RedisUtil.class);
	//操作redis客户端
	public static Jedis jedis;
	@Autowired
	private JedisConnectionFactory jedisConnectionFactory;
	/**
	 * 获取一个jedis 客户端
	 * @return
	 */
	public Jedis getJedis(){
		if(jedis == null){
			synchronized(this){
				if(jedis == null){
					return jedisConnectionFactory.getShardInfo().createResource();
				}
			}
		}
		return jedis;
	}


    /**
	 * 从redis里获取list集合
	 * @author andalee
	 * @createtime 2018-11-12
	 * @updatetime 2018-11-12
	 */
	public   <T> List<T>  getList(String key){  
		byte[] in = this.getJedis().get(key.getBytes());
		return SerializeUtil.unserializeForList(in);
	}
    /**
	 * 把list集合存入redis
	 * @author andalee
     * @return 
	 * @createtime 2018-11-12
	 * @updatetime 2018-11-12
	 */
	public  <T>  void setList(String key,List<T> list){  
		this.getJedis().set(key.getBytes(), SerializeUtil.serialize(list));  
	}
	/**
	 * 把Object对象序列化，再存入redis
	 * @author andalee
	 * @createtime 2018-11-12
	 * @updatetime 2018-11-12
	 */
	public  void setObject(String key,Object object){  
		this.getJedis().set(key.getBytes(), SerializeUtil.serialize(object));
	}
	/**
	 * @author 根据key取到数据流，然后转换成list，再存入Object
	 * @author andalee
	 * @createtime 2018-11-12
	 * @updatetime 2018-11-12
	 * @param key
	 * @return
	 */
	public Object getObject(String key){
		byte[] in =  this.getJedis().get(key.getBytes());  
		Object value =(Object) SerializeUtil.unserialize(in);
		return value;
	}
	
	/**
	 * 添加key value
	 * @param key
	 * @param value
	 */
	public void set(String key,String value){
		this.getJedis().set(key, value);
	}
	/**添加key value (字节)(序列化)
	 * @param key
	 * @param value
	 */
	public void set(byte [] key,byte [] value){
		this.getJedis().set(key, value);
	}

	/**添加key  hashMap 
	 * @param key
	 * @param value
	 */
	public  void setHashMap(String key,HashMap<String, String> value){  
		this.getJedis().hmset(key, value);
	}
	/**添加hash值
	 * @param key
	 * @param value
	 */
	public  void hset(String key,String dbkey ,String value){  
		this.getJedis().hset(key,dbkey, value);
	}


	/**
	 * 获取redis value (String)
	 * @param key
	 * @return
	 */
	public String get(String key){
		String value = this.getJedis().get(key);
		return value;
	}
	/**
	 * 获取redis value (byte [] )(反序列化)
	 * @param key
	 * @return
	 */
	public byte[] get(byte [] key){
		return this.getJedis().get(key);
	}
	/**
	 * @author andalee 20170407 
	 * 获取redis value (String)
	 * @param key
	 * @return
	 */
	public HashMap<String, String>  getHashMap(String key){
		// 	//迭代redis的key取出所有key和值，再重新装入HashMap
		HashMap value=new HashMap();
		Iterator<String> iter=this.getJedis().hkeys(key).iterator();  
		while (iter.hasNext()){  
			String map_key = iter.next();  
			value.put(map_key, this.getJedis().hmget(key,map_key));  
		} 
		// 	byte[] in = get(key.getBytes());  
		// 	HashMap<String,Object> value =(HashMap<String,Object>) deserialize(in);

		return value;
	}
	/**
	 * @author andalee 20181107 
	 * 获取redis value (String)
	 * @param key
	 * @return
	 */
	public String hget(String key,String map_key){

		return  this.getJedis().hget(key, map_key);
	}   
	/**
	 * 通过key删除（字节）
	 * @param key
	 */
	public void del(byte [] key){
		this.getJedis().del(key);
	}
	/**
	 * 通过key删除
	 * @param key
	 */
	public void del(String key){
		this.getJedis().del(key);
	}

	/**
	 * 添加key value 并且设置存活时间(byte)
	 * @param key
	 * @param value
	 * @param liveTime
	 */
	public void set(byte [] key,byte [] value,int liveTime){
		this.set(key, value);
		this.getJedis().expire(key, liveTime);
	}
	/**
	 * 添加key value 并且设置存活时间
	 * @param key
	 * @param value
	 * @param liveTime
	 */
	public void set(String key,String value,int liveTime){
		this.set(key, value);
		this.getJedis().expire(key, liveTime);
	}
	/**
	 * 通过正则匹配keys
	 * @param pattern
	 * @return
	 */
	public Set<String> keys(String pattern){
		return this.getJedis().keys(pattern);
	}

	/**
	 * 检查key是否已经存在
	 * @param key
	 * @return
	 */
	public boolean exists(String key){
		return this.getJedis().exists(key);
	}
	/**
	 * 清空redis 所有数据
	 * @return
	 */
	public String flushDB(){
		return this.getJedis().flushDB();
	}
	/**
	 * 查看redis里有多少数据
	 */
	public long dbSize(){
		return this.getJedis().dbSize();
	}
	/**
	 * 检查是否连接成功
	 * @return
	 */
	public String ping(){
		return this.getJedis().ping();
	}

	private RedisUtil (){

	}

}
