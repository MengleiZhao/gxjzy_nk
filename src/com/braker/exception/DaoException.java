package com.braker.exception;

import java.util.HashMap;

/**
 * dao层异常(截至2019-01-15，这个系统还没有dao类，逻辑代码和数据库连接都写在manager里。但是这个先留着，以后有可能会重新优化代码)
 * @author 李安达
 * @createtime 2019-01-15
 * @updatetime 2019-01-15
 */
@SuppressWarnings("serial")
public class DaoException extends BaseException {

	public DaoException() {
		super("数据库异常");

	}

	public DaoException(String msg) {
		super(msg);

	}

	public DaoException(String msg, String detail) {
		super(msg, detail);

	}

	public DaoException(String msg, HashMap<String, Object> info) {
		super(msg, info);

	}
}
