package com.braker.common.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

import com.braker.common.util.StringUtil;
import com.braker.core.manager.LookupsMng;
import com.braker.core.manager.SysLogMng;
import com.braker.core.model.Lookups;
import com.braker.core.model.SysLog;
import com.braker.core.model.User;


/**
 * 上下文信息拦截器
 * 
 * 包括登录信息、权限信息
 */
public class AdminContextInterceptor extends HandlerInterceptorAdapter {
	private static final Logger log = LoggerFactory.getLogger(AdminContextInterceptor.class);
	
	@Autowired  
    private RequestMappingHandlerMapping requestMappingHandlerMapping;
	@Autowired
	private LookupsMng lookupsMng;
	@Autowired
	private SysLogMng sysLogMng;

	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object handler) throws Exception {
		Map<RequestMappingInfo, HandlerMethod> map = requestMappingHandlerMapping.getHandlerMethods();
		String requestMapping=null;//获取对应controller方法上的@RequestMapping里面的value
        for (Map.Entry<RequestMappingInfo,HandlerMethod> m:map.entrySet()) {
            RequestMappingInfo requestMappingInfo=m.getKey().getMatchingCondition(request);
            if(null!=requestMappingInfo){
            	requestMapping=(String)requestMappingInfo.getPatternsCondition().getPatterns().toArray()[0];
            	break;
            }
        }
        //APP调用接口,校验账号和密码
        String param = request.getQueryString();
        if (param!=null && param.contains("interfaceCode=@tzapp")) {
        	return true;
        }
        if("/expendPrintDetail".equals(requestMapping)||"/createCode".equals(requestMapping)){
			//用户手机扫描支出打印单的二维码，查看数据
			return true;
		}
		// 不在验证的范围内
		if (exclude(requestMapping)) {
			request.setAttribute("logRequestMapping",requestMapping);
			//用户退出系统需要另外处理
			if("/logout.do".equals(requestMapping)){
				HttpSession session = request.getSession(false);
				if(null!=session){
//					saveOperateLog((User)session.getAttribute("currentUser"),requestMapping, request);
				}
			}
			
			return true;
		}
		HttpSession session = request.getSession(false);
		// 用户为null跳转到登陆页面
		if(null==session){
			response.sendRedirect(getLoginUrl(request));
			return false;
		}
		User user=(User)session.getAttribute("currentUser");
		if (user == null) {
			response.sendRedirect(getLoginUrl(request));
			return false;
		}
//		Set<String> functionSet =(Set<String>)session.getAttribute(Function.RIGHTS_KEY);
//		if (functionSet==null || !functionSet.contains(requestMapping)) {
//			response.sendRedirect(request.getContextPath()+"/403.jsp");
//			return false;
//		}
		request.setAttribute("logRequestMapping",requestMapping);
		return true;
	}
	
	/**
	 * 保存操作日志
	 * @param requestMapping
	 * @throws Exception 
	 */
	public void saveOperateLog(User user,String requestMapping,HttpServletRequest request) throws Exception{
			/*if(null!=user && !StringUtil.isEmpty(user.getId())){
				SysLog sysLog=new SysLog();
				sysLog.setCreator(user);
				sysLog.setOperateUrl(requestMapping);
				sysLog.setIpaddress(sysLogMng.getIpAddr(request));
				sysLog.setMacaddress(sysLogMng.getMACAddress(sysLog.getIpaddress()));
				Lookups lookup=lookupsMng.findUniqueByProperty("code",requestMapping);
				if(null!=lookup && !StringUtil.isEmpty(lookup.getId())){
					sysLog.setOperateContent(lookup.getName());
				}
				sysLogMng.save(sysLog);
			}*/
	}
	
	private String getLoginUrl(HttpServletRequest request) {
		StringBuilder buff = new StringBuilder();
		if (loginUrl.startsWith("/")) {
			String ctx = request.getContextPath();
			if (!StringUtils.isBlank(ctx)) {
				buff.append(ctx);
			}
		}
		buff.append(loginUrl);
		return buff.toString();
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler, ModelAndView mav)
			throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		//记录系统操作日志
		HttpSession session = request.getSession(false);
		if(null!=session){
//			saveOperateLog((User)session.getAttribute("currentUser"),request.getAttribute("logRequestMapping").toString(), request);
		}
	}

	private boolean exclude(String uri) {
		if (excludeUrls != null) {
			for (String exc : excludeUrls) {
				if (exc.equals(uri)) {
					return true;
				}
			}
		}
		return false;
	}

	private String getUrl(HttpServletRequest request) {
		String url = request.getRequestURI();
		String context = request.getContextPath();
		if (url.indexOf(".") != -1) {
			return url.substring(context.length(), url.indexOf("."));
		} else if (url.indexOf("?") != -1) {
			return url.substring(context.length(), url.indexOf("?"));
		} else {
			return url.substring(context.length());
		}
	}
	
	private String[] excludeUrls;
	private String loginUrl;

	public void setExcludeUrls(String[] excludeUrls) {
		this.excludeUrls = excludeUrls;
	}

	public void setLoginUrl(String loginUrl) {
		this.loginUrl = loginUrl;
	}

}