package com.braker.common.entity;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface Excel {
	
	/**
	 * 默认为第一页
	 * @return 页数
	 */
	public int sheet() default 1;
	
	
	/**
	 * 默认为不付值
	 * @return 行所在位子
	 */
	public int row() default -1;
	
	/**
	 * @return 列所在位子
	 */
	public int cell() ;
}
