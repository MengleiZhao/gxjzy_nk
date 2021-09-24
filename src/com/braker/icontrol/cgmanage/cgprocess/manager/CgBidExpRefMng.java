package com.braker.icontrol.cgmanage.cgprocess.manager;

import com.braker.common.hibernate.BaseManager;

import com.braker.icontrol.cgmanage.cgprocess.model.BidExpertRef;

/**
 * 中标 和评标专家的映射类   
 * @author 冉德茂
 * @createtime 2018-07-27
 * @updatetime 2018-07-27
 */
public interface CgBidExpRefMng extends BaseManager<BidExpertRef>{


	/*
	 *保存中标和供应商的对应关系
	 * @author 冉德茂
	 * @createtime 2018-07-27
	 * @updatetime 2018-07-27
	 */
	
	public void save(Integer mainid,Integer eid);

}
