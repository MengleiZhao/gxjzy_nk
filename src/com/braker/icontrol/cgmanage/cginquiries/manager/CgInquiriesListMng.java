package com.braker.icontrol.cgmanage.cginquiries.manager;


import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.cgmanage.cginquiries.model.InqWinningList;

/**
 * 采购 和供应商清单的映射表
 * @author 冉德茂
 * @createtime 2018-08-01
 * @updatetime 2018-08-01
 */
public interface CgInquiriesListMng extends BaseManager<InqWinningList>{


	/*
	 * 通过mainid查询报价清单信息  mainid是外键
	 * @author 冉德茂
	 * @createtime 2018-08-01
	 * @updatetime 2018-08-01
	 */
	public List<InqWinningList> getQingdan(Integer mainid);

	



}
