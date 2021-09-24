package com.braker.common.web;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.braker.common.util.StringUtil;

/**
 * 记录用户访问“在线帮助”日志
 * @author administrator
 *
 */
public class HelpLogFilter implements Filter {
	protected final Logger log = LoggerFactory.getLogger(HelpLogFilter.class);

	public void destroy() {
	}

	public void doFilter(ServletRequest servletRequest,ServletResponse servletResponse, FilterChain chain)throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		String requestURI=request.getRequestURI();
		String queryString=request.getQueryString();
		if(requestURI.contains("onlinehelp") && StringUtil.isEmpty(queryString)){
			response.sendRedirect(request.getContextPath()+"/log/help?requestURI="+requestURI.substring(request.getContextPath().length()));
		}
		chain.doFilter(request,response);
	}

	public void init(FilterConfig filterConfig) throws ServletException {
	}
}
