package com.braker.common.web;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.braker.common.entity.Combobox;
import com.braker.common.entity.ComboboxType;
import com.braker.common.page.ComboboxJson;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.util.RequestUtils;
import com.braker.common.util.StringUtil;
import com.braker.core.model.Function;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.exception.BaseException;

/**
 * action基类 提供一些常用方法和变量
 *
 */
@SuppressWarnings({"serial"})
public class BaseController implements Serializable{
	protected static final Logger log=LoggerFactory.getLogger(BaseController.class);
	@Autowired  
	protected  HttpServletRequest request;
	
	public String getIp(){
		return RequestUtils.getIpAddr(request);
	}
	/**
	 * 从session获取当前登陆者的用户信息
	 * @return User
	 */
	public User getUser(){
		return (User)request.getSession(false).getAttribute("currentUser");
	}
	
	/**
	 * 从session获取登录选择的年份
	 * @return User
	 */
	public String getYear(){
		return (String) request.getSession(false).getAttribute("year");
	}
	
	/**
	 * 从session获取当前登陆者的用户信息
	 * @return User
	 */
	public Set<String> getFunctionItems(){
		return (Set<String>) request.getSession(false).getAttribute(Function.RIGHTS_KEY);
	}
	/**
	 * 
	* @author:安达
	* @Title: hasFuncs 
	* @Description: 判断是否拥有某个权限
	* @return
	* @return boolean    返回类型 
	* @date： 2019年5月27日下午3:27:56 
	* @throws
	 */
	public boolean hasFuncs(String funStr){
		Set<String> funcSet=getFunctionItems();
		for(String str:funcSet){
			if(funStr.equals(str)){
				return true;
			}
		}
		return false;
	}
	/**
	 * 判断用户是否是“街镇角色”
	 * @return
	 */
	public boolean isStreetRole(){
		boolean flag=false;
		List<Role> listRole=getUser().getRoles();
		if(null!=listRole && listRole.size()>0){
			for(Role r:listRole){
				if("STREET_ROLE".equals(r.getCode())){
					flag=true;
					break;
				}
			}
		}
		return flag;
	}
	
	/**
	 * 判断用户是否有某个角色
	 * @param roleCode 角色代码
	 * @return
	 */
	public boolean hasRole(String roleCode){
		boolean flag=false;
		List<Role> listRole=getUser().getRoles();
		if(null!=listRole && listRole.size()>0 && !StringUtil.isEmpty(roleCode)){
			for(Role r:listRole){
				if(roleCode.equals(r.getCode())){
					flag=true;
					break;
				}
			}
		}
		return flag;
	}
	
	public JsonPagination getJsonPagination(Pagination p,int curPage){
		JsonPagination jp=new JsonPagination(); 
		jp.setTotal(p.getTotalCount());
		jp.setCurPage(curPage);
		jp.setRows(p.getList());
		jp.setFooter(p.getFooter());
		return jp;
	}
	
	public Result getJsonResult(boolean success,String info){
		Result result=new Result();
		result.setSuccess(success);
		result.setInfo(info);
		return result;
	}
	
	public JsonPagination paginationJson(Pagination p,int curPage){
		JsonPagination jp=new JsonPagination(); 
		jp.setTotal(p.getTotalCount());
		jp.setCurPage(curPage);
		jp.setRows(p.getList());
		return jp;
	}
	
	public List<ComboboxJson> getComboboxJson(List<?> list){
		List<ComboboxJson> listCombobox=new ArrayList<ComboboxJson>();
		ComboboxJson comboboxJson=null;
		if(null!=list && list.size()>0){
			int t=list.size();
			for (int i = 0; i < t; i++) {
				comboboxJson=new ComboboxJson();
				Combobox combobox=(Combobox)list.get(i);
				comboboxJson.setId(combobox.getId());
    			comboboxJson.setText(combobox.getText());
    			if(i==0){//默认选中第一个
    				comboboxJson.setSelected(true);
    			}
    			listCombobox.add(comboboxJson);
			}
    	}
		return listCombobox;
	}
	
	/**
	 * easyui 下拉框
	 * @param list 数据集合
	 * @param selected 要选中的值
	 * @return
	 */
	public List<ComboboxJson> getComboboxJson(List<?> list,String selected){
		List<ComboboxJson> listCombobox=new ArrayList<ComboboxJson>();
		ComboboxJson comboboxJson=null;
		ComboboxJson comboboxJsonDefault=new ComboboxJson();
		comboboxJsonDefault.setId("");
		comboboxJsonDefault.setCode("");
		comboboxJsonDefault.setText("--请选择--");
		if(StringUtil.isEmpty(selected)){
			comboboxJsonDefault.setSelected(true);
		}
		listCombobox.add(comboboxJsonDefault);
		if(null!=list && list.size()>0){
			int t=list.size();
			for (int i = 0; i < t; i++) {
				comboboxJson=new ComboboxJson();
				Combobox combobox=(Combobox)list.get(i);
				comboboxJson.setId(combobox.getId());
				comboboxJson.setCode(combobox.getCode());
    			comboboxJson.setText(combobox.getText());
    			if(!StringUtil.isEmpty(selected)){
    				if(selected.equals(combobox.getId()) || selected.equals(combobox.getCode()) 
    				|| selected.equals(combobox.getText())){
    					comboboxJson.setSelected(true);
    				}
    			}
    			listCombobox.add(comboboxJson);
			}
    	}
		return listCombobox;
	}
	
	
	public List<ComboboxJson> getComboboxJsonNoDefault(List<?> list,String selected){
		List<ComboboxJson> listCombobox=new ArrayList<ComboboxJson>();
		ComboboxJson comboboxJson=null;
		if(null!=list && list.size()>0){
			int t=list.size();
			for (int i = 0; i < t; i++) {
				comboboxJson=new ComboboxJson();
				Combobox combobox=(Combobox)list.get(i);
				comboboxJson.setId(combobox.getId());
				comboboxJson.setCode(combobox.getCode());
				comboboxJson.setText(combobox.getText());
				if(!StringUtil.isEmpty(selected)){
					if(selected.equals(combobox.getId()) || selected.equals(combobox.getCode()) 
							|| selected.equals(combobox.getText())){
						comboboxJson.setSelected(true);
					}
				}
				listCombobox.add(comboboxJson);
			}
    	}
		return listCombobox;
	}
	/**
	 * easyui 下拉框
	 * @param list 数据集合
	 * @param selected 要选中的值
	 * @return
	 */
	public List<ComboboxJson> getComboboxJsonAsst(List<?> list,String selected){
		List<ComboboxJson> listCombobox=new ArrayList<ComboboxJson>();
		ComboboxJson comboboxJson=null;
		ComboboxJson comboboxJsonDefault=new ComboboxJson();
		comboboxJsonDefault.setId("");
		comboboxJsonDefault.setCode("");
		comboboxJsonDefault.setText("--请选择--");
		comboboxJsonDefault.setSftjCode("");
		/*if(StringUtil.isEmpty(selected)){
			comboboxJsonDefault.setSelected(true);
		}*/
		listCombobox.add(comboboxJsonDefault);
		if(null!=list && list.size()>0){
			int t=list.size();
			for (int i = 0; i < t; i++) {
				comboboxJson=new ComboboxJson();
				Combobox combobox=(Combobox)list.get(i);
				comboboxJson.setId(combobox.getId());
				comboboxJson.setCode(combobox.getCode());
				comboboxJson.setText(combobox.getText());
				comboboxJson.setSftjCode(combobox.getSftjCode());
				if(!StringUtil.isEmpty(selected)){
					if(selected.equals(combobox.getId()) || selected.equals(combobox.getCode()) 
							|| selected.equals(combobox.getText())){
						comboboxJson.setSelected(true);
					}
				}
				listCombobox.add(comboboxJson);
			}
			ComboboxJson comboboxJsonAdd=new ComboboxJson();
			if(StringUtil.isEmpty(selected)){
				comboboxJsonAdd.setSelected(true);
			}
			comboboxJsonAdd.setId("");
			comboboxJsonAdd.setCode("  ");
			comboboxJsonAdd.setText("新增");
			comboboxJsonAdd.setSftjCode("");
			listCombobox.add(comboboxJsonAdd);
		}
		return listCombobox;
	}
	
	/**
	 * easyui 下拉框
	 * @param list 数据集合
	 * @param selected 要选中的值
	 * @return
	 */
	public List<ComboboxJson> getComboboxJsonType(List<?> list,String type,String selected){
		List<ComboboxJson> listCombobox=new ArrayList<ComboboxJson>();
		ComboboxJson comboboxJson=null;
		ComboboxJson comboboxJsonDefault=new ComboboxJson();
		comboboxJsonDefault.setId("");
		comboboxJsonDefault.setCode("");
		comboboxJsonDefault.setText("--请选择--");
		comboboxJsonDefault.setSelected(true);
		listCombobox.add(comboboxJsonDefault);
		if(null!=list && list.size()>0){
			int t=list.size();
			for (int i = 0; i < t; i++) {
				comboboxJson=new ComboboxJson();
				ComboboxType combobox=(ComboboxType)list.get(i);
				comboboxJson.setId(combobox.getsId());
				if("specialty".equals(type)){
					comboboxJson.setText(combobox.getText());
				}else if("bigType".equals(type)){
					comboboxJson.setText(combobox.getText2());
				}else if("smallType".equals(type)){
					comboboxJson.setText(combobox.getText3());
				}
				comboboxJson.setCode(comboboxJson.getText());
				if(!StringUtil.isEmpty(selected)){
    				if(selected.equals(combobox.getsId()) || selected.equals(combobox.getCode()) ){
    					comboboxJson.setSelected(true);
    				}
    				if("specialty".equals(type) && selected.equals(combobox.getText())){
    					comboboxJson.setSelected(true);
    				}else if("bigType".equals(type) && selected.equals(combobox.getText2())){
    					comboboxJson.setSelected(true);
    				}else if("smallType".equals(type) && selected.equals(combobox.getText3())){
    					comboboxJson.setSelected(true);
    				}
    			}
    			listCombobox.add(comboboxJson);
			}
    	}
		return listCombobox;
	}
	
	/***
	 * 返回前台不分页的json
	 * @param list
	 * @return
	 */
	public JsonPagination listJson(List<?> list){
		JsonPagination jp=new JsonPagination(); 
		jp.setTotal(list.size());
		jp.setCurPage(1);
		jp.setRows(list);
		return jp;
	}
	/***
	 * 返回前台分页的json
	 * @param list
	 * @return
	 */
	public JsonPagination pageListJson(List<?> list,int total,int curPage){
		JsonPagination jp=new JsonPagination(); 
		jp.setTotal(total);
		jp.setCurPage(curPage);
		jp.setRows(list);
		return jp;
	}
	/**
	 * 返回布尔
	 * @param ajax
	 * @return
	 */
	public Boolean getAjaxJson(Boolean ajax){
		return ajax;
	}
	
	/**
	 * 返回String
	 */
	public String getStrJson(String str){
		return str;
	}
	
	/**
	 * 街道 easyui 下拉框
	 * @param list 数据集合
	 * @param selected 要选中的值
	 * @return
	 */
	public List<ComboboxJson> getStreetComboboxJson(List<?> list,String selected){
		List<ComboboxJson> listCombobox=new ArrayList<ComboboxJson>();
		ComboboxJson comboboxJson=null;
		ComboboxJson comboboxJsonDefault=new ComboboxJson();
		if(!StringUtil.isEmpty(selected)){
			
		}else{
			comboboxJsonDefault.setId("");
			comboboxJsonDefault.setCode("");
			comboboxJsonDefault.setText("--请选择--");
		}
		if(StringUtil.isEmpty(selected)){
			comboboxJsonDefault.setSelected(true);
		}
		listCombobox.add(comboboxJsonDefault);
		if(null!=list && list.size()>0){
			int t=list.size();
			for (int i = 0; i < t; i++) {
				comboboxJson=new ComboboxJson();
				Combobox combobox=(Combobox)list.get(i);
				comboboxJson.setId(combobox.getId());
				comboboxJson.setCode(combobox.getCode());
    			comboboxJson.setText(combobox.getText());
    			if(!StringUtil.isEmpty(selected)){
    				if(selected.equals(combobox.getId()) || selected.equals(combobox.getCode()) 
    				|| selected.equals(combobox.getText())){
    					comboboxJson.setSelected(true);
    				}
    			}
    			listCombobox.add(comboboxJson);
			}
    	}
		return listCombobox;
	}
	/**
	 * 街道 easyui 下拉框不带请选择默认值
	 * @param list 数据集合
	 * @param selected 要选中的值
	 * @return
	 */
	public List<ComboboxJson> getAllStreetComboboxJson(List<?> list,String selected){
		List<ComboboxJson> listCombobox=new ArrayList<ComboboxJson>();
		ComboboxJson comboboxJson=null;
	/*	ComboboxJson comboboxJsonDefault=new ComboboxJson();
		if(!StringUtil.isEmpty(selected)){
			
		}else{
			comboboxJsonDefault.setId("");
			comboboxJsonDefault.setCode("");
			comboboxJsonDefault.setText("--请选择--");
		}
		if(StringUtil.isEmpty(selected)){
			comboboxJsonDefault.setSelected(true);
		}
		listCombobox.add(comboboxJsonDefault);*/
		if(null!=list && list.size()>0){
			int t=list.size();
			for (int i = 0; i < t; i++) {
				comboboxJson=new ComboboxJson();
				Combobox combobox=(Combobox)list.get(i);
				comboboxJson.setId(combobox.getId());
				comboboxJson.setCode(combobox.getCode());
    			comboboxJson.setText(combobox.getText());
    			if(!StringUtil.isEmpty(selected)){
    				if(selected.equals(combobox.getId()) || selected.equals(combobox.getCode()) 
    				|| selected.equals(combobox.getText())){
    					comboboxJson.setSelected(true);
    				}
    			}else{
    				if(i==0){
    					comboboxJson.setSelected(true);
    				}
    			}
    			listCombobox.add(comboboxJson);
			}
    	}
		return listCombobox;
	}
	
	protected String getException(Exception e) {
		String msg = "系统错误";
		if (e instanceof BaseException) {
			msg = e.getMessage();
		} else {
			e.printStackTrace();
		}
		return msg;
	}
	
	/**
	 * easyui 下拉框
	 * @param list 数据集合
	 * @param selected 要选中的值
	 * @return
	 */
	public List<ComboboxJson> getComboboxJson1(List<?> list,String selected){
		List<ComboboxJson> listCombobox=new ArrayList<ComboboxJson>();
		ComboboxJson comboboxJson=null;
		ComboboxJson comboboxJsonDefault=new ComboboxJson();
		comboboxJsonDefault.setId("");
		comboboxJsonDefault.setCode("");
		comboboxJsonDefault.setText("");
		if(StringUtil.isEmpty(selected)){
			comboboxJsonDefault.setSelected(true);
		}
		listCombobox.add(comboboxJsonDefault);
		if(null!=list && list.size()>0){
			int t=list.size();
			for (int i = 0; i < t; i++) {
				comboboxJson=new ComboboxJson();
				Combobox combobox=(Combobox)list.get(i);
				comboboxJson.setId(combobox.getId());
				comboboxJson.setCode(combobox.getCode());
    			comboboxJson.setText(combobox.getText());
    			if(!StringUtil.isEmpty(selected)){
    				if(selected.equals(combobox.getId()) || selected.equals(combobox.getCode()) 
    				|| selected.equals(combobox.getText())){
    					comboboxJson.setSelected(true);
    				}
    			}
    			listCombobox.add(comboboxJson);
			}
    	}
		return listCombobox;
	}
}
