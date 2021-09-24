package com.braker.icontrol.cgmanage.cgprocess.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.cgmanage.cgprocess.model.BidWinningRef;

/**
 * 中标 和供应商的映射类   
 * @author 冉德茂
 * @createtime 2018-07-27
 * @updatetime 2018-07-27
 */
public interface CgBidWinRefMng extends BaseManager<BidWinningRef>{


	/*
	 *保存中标和供应商的对应关系
	 * @author 冉德茂
	 * @createtime 2018-07-27
	 * @updatetime 2018-07-27
	 */
	
	public void save(BidWinningRef bwbean, Integer mainid,Integer wid);
	/*
	 *通过中标的主键ID查询供应商的id
	 * @author 冉德茂
	 * @createtime 2018-07-27
	 * @updatetime 2018-07-27
	 */
	public List<BidWinningRef> findByBidid(Integer bidid);
	
	

}
