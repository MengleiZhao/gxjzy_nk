package com.braker.core.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.SystemCenterAttac;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;

/**
 * 制度政策中心的service抽象类
 * @author 叶崇晖
 * @createtime 2018-07-04
 * @updatetime 2018-07-04
 */
public interface CheterMng extends BaseManager<CheterInfo>{
	
	/*
	 * 查询制度中心
	 * @author 叶崇晖
	 * @createtime 2018-07-04
	 * @updatetime 2018-07-04
	 */
	public List<CheterInfo> getCheterInfoList(String belong);
	
	/*
	 * 制度查找
	 * @author 叶崇晖
	 * @createtime 2018-07-04
	 * @updatetime 2018-07-04
	 */
	public SystemCenterAttac getSystemCenterAttac(Integer id);
	
}
