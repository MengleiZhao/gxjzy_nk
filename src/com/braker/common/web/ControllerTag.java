package com.braker.common.web;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * 实现页面可以访问controller
 * @author  2017-04-19
 */
public class ControllerTag extends TagSupport{

	private static final long serialVersionUID = 1L;
	
	private String url;//路径
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
    public int doStartTag() throws JspTagException {  
    	try {
			pageContext.include(url);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return EVAL_BODY_INCLUDE;
    }  
    
	public int doEndTag() throws JspTagException {
        return EVAL_PAGE;  
    }
	
}
