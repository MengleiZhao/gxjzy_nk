package com.braker.fckeditor;

import javax.servlet.http.HttpServletRequest;

import net.fckeditor.requestcycle.UserPathBuilder;

/**
 * @author liufang
 * 
 */
public class UserPathBuilderImpl implements UserPathBuilder {
	public String getUserFilesPath(HttpServletRequest request) {
		UploadRule rule = (UploadRule) request.getSession().getAttribute(
				UploadRule.KEY);
		return rule.getRootPath() + rule.getPathPrefix();
	}
}
