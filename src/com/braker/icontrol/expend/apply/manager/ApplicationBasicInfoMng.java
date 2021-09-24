package com.braker.icontrol.expend.apply.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Depart;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;

/**
 * 事前申请基本信息的service抽象类
 * @author 叶崇晖
 * @createtime 2018-08-13
 * @updatetime 2018-08-13
 */
public interface ApplicationBasicInfoMng extends BaseManager<ApplicationBasicInfo> {
	/*
	 * 根据gCode（直接申请流水号）查询基本信息
	 * @author 叶崇晖
	 * @createtime 2018-08-13
	 * @updatetime 2018-08-13
	 */
	public ApplicationBasicInfo getByGCode(String gCode);
	
	public Pagination getData24(Depart depart,String year,int pageNo, int pageSize,String searchName,String searchContent);
	public Pagination getData25(Depart depart,String year,int pageNo, int pageSize,String searchGCode, String searchGName);

}
