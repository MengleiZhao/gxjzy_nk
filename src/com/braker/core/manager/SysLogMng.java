package com.braker.core.manager;

import java.net.SocketException;
import java.net.UnknownHostException;

import javax.servlet.http.HttpServletRequest;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.SysLog;

public interface SysLogMng extends BaseManager<SysLog>{
	
	public Pagination list(SysLog log,String sort,String order,int pageIndex,int pageSize);
	
	/**
	 * 日志归档，归档日期之前的记录都移动到日志历史表
	 * @param archiveTime 归档日期
	 */
	public void archive(String archiveDate);
	
	/**
	 * 
	 * <p>Title: getLocalMac</p>  
	 * <p>Description: 获得本地Mac地址</p>  
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年12月3日
	 * @updator 陈睿超
	 * @updatetime 2020年12月3日
	 */
	String getLocalMac() throws UnknownHostException,SocketException;
	
	/**
	 * 
	 * <p>Title: getIpAddr</p>  
	 * <p>Description: 返回IP地址</p>  
	 * @param request
	 * @return
	 * @throws Exception
	 * @author 陈睿超
	 * @createtime 2020年12月4日
	 * @updator 陈睿超
	 * @updatetime 2020年12月4日
	 */
	String getIpAddr(HttpServletRequest request) throws Exception;
	
	/**
	 * 
	 * <p>Title: getMACAddress</p>  
	 * <p>Description: 通过IP地址获取MAC地址</p>  
	 * @param ip
	 * @return
	 * @throws Exception
	 * @author 陈睿超
	 * @createtime 2020年12月4日
	 * @updator 陈睿超
	 * @updatetime 2020年12月4日
	 */
	String getMACAddress(String ip) throws Exception;
	
}
