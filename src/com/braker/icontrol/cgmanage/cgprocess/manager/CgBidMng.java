package com.braker.icontrol.cgmanage.cgprocess.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgprocess.model.BidRegist;

/**
 * 中标登记的service抽象类
 * @author 冉德茂
 * @createtime 2018-07-24
 * @updatetime 2018-07-24
 */
public interface CgBidMng extends BaseManager<BidRegist>{
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-07-23
	 * @updatetime 2018-07-23
	 */
	public Pagination pageList(BidRegist bean, int pageNo, int pageSize);

	
	/*
	 * 中标保存
	 * @author 冉德茂
	 * @createtime 2018-07-27
	 * @updatetime 2018-07-27
	 */
	
	public void save(BidRegist bean, String files, User user,String org, String pid,String wid,String eids,String wCode);
	
	
	/*
	 * 根据ID删除
	 * @author 冉德茂
	 * @createtime 2018-07-30
	 * @updatetime 2018-07-30
	 */
	public void delete(Integer id);
	
	
	/*
	 * 根据pid查询中标的的登记信息
	 * @author 冉德茂
	 * @createtime 2018-08-16
	 * @updatetime 2018-08-16
	 */
	public BidRegist getBidRegistByPId(Integer pid);
}
