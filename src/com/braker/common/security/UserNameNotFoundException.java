package com.braker.common.security;

/**
 * 用户名没有找到异常
 */
@SuppressWarnings("serial")
public class UserNameNotFoundException extends AuthenticationException {
	public UserNameNotFoundException() {
	}

	public UserNameNotFoundException(String msg) {
		super(msg);
	}
}