package com.braker.common.web;

import java.util.Set;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.TagSupport;

import com.braker.core.model.Function;

/**
 * 权限认证
 * @author administrator 2015-03-24
 */
public class PermistionTag extends TagSupport{

	private static final long serialVersionUID = 1L;
	
	private String url;//路径
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
    public int doStartTag() throws JspTagException {  
    	Set<String> functionSet =(Set<String>)pageContext.getSession().getAttribute(Function.RIGHTS_KEY);
		if (functionSet==null || !functionSet.contains(url)) {
			return SKIP_BODY;
		}else{
			return EVAL_BODY_INCLUDE;
		}
    }  
    
	public int doEndTag() throws JspTagException {
        return EVAL_PAGE;  
    }
	
}
