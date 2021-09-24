package com.braker.icontrol.cgmanage.cgprocess.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;

/**
 * 供应商service抽象类
 * @author 冉德茂
 * @createtime 2018-07-27
 * @updatetime 2018-07-27
 */
public interface CgSelMng extends BaseManager<WinningBidder>{
	/*
	 * 通过pid查询所有的供应商
	 * @author 冉德茂
	 * @createtime 2018-07-13
	 * @updatetime 2018-07-13
	 */
	public  List<WinningBidder> findByWid(Integer wid);

}
