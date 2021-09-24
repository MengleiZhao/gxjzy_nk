package com.braker.zzww.comm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.util.redis.RedisConstantsKeys;
import com.braker.common.util.redis.RedisUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.FunctionMng;
import com.braker.core.model.Function;
import com.braker.core.model.User;
import com.braker.zzww.comm.manager.RedisTestMng;


@SuppressWarnings("serial")
@Controller
@RequestMapping("/redisTest")
public class RedisTestController extends BaseController{
	@Autowired
	private RedisTestMng userMngImpl;
	@Autowired
	private RedisUtil redisUtil;
	@Autowired
	private FunctionMng functionMng;
	
	@RequestMapping("/hgetFromRedis")
	@ResponseBody
	public Map<String, Object> hgetFromRedis(String redisKey,String valueKey) {
		Map<String, Object> map=new HashMap<String, Object>();
		try {
			map=userMngImpl.hgetFromRedis(redisKey,valueKey);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	@RequestMapping("/getFromRedis")
	@ResponseBody
	public String getFromRedis(String key) {
		try {
			String result=userMngImpl.getFromRedis(key);
//			System.out.println("************************"+result);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * http://localhost:8080/nkgl/redisTest/getFunctionList
	 * @param key
	 * @return
	 */
	@RequestMapping("/getFunctionList")
	@ResponseBody
	public List<Function> getFunctionList(String key) {
		try {
			
			Set<String> functionKeys=redisUtil.keys(RedisConstantsKeys.GET_USER_FUNCTION_LIST_KEY+"*");
			for(String str:functionKeys){
				System.err.println(str);
				redisUtil.del(str);
			}
//			redisUtil.flushDB();
//			redisUtil.del(RedisConstantsKeys.GET_USER_FUNCTION_LIST_KEY+"474c2ee4-8346-11e8-ba6e-10e7c6129797");
			User user=getUser();
			List<Function> functionList= redisUtil.getList(RedisConstantsKeys.GET_USER_FUNCTION_LIST_KEY+"474c2ee4-8346-11e8-ba6e-10e7c6129797");
			for(Function f:functionList){
				System.out.println("************************"+f.getTreeName()+":"+f.getFuncs());
			}
//			List<Function> functionList1=functionMng.getFunctions(user.getId());
//			for(Function f:functionList1){
//				System.out.println("************************"+f.getTreeName()+":"+f.getFuncs());
//			}
//			System.out.println("************************"+result);
			return functionList;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
