package com.braker.icontrol.cgmanage.cgprocess.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgprocess.model.BiddingRegist;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;

/**
 * 采购招标登记的service抽象类
 * @author 冉德茂
 * @createtime 2018-07-23
 * @updatetime 2018-07-23
 */
public interface CgProcessMng extends BaseManager<BiddingRegist>{
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-07-23
	 * @updatetime 2018-07-23
	 */
	public Pagination pageList(BiddingRegist bean, String timea, String timeb, Integer pageNo, Integer pageSize);
	/*
	 * 获取所有的已审批的基本信息进行招标
	 * @author 冉德茂
	 * @createtime 2018-07-23
	 * @updatetime 2018-07-23
	 */	
	public List<PurchaseApplyBasic> pageBasicInfoList(PurchaseApplyBasic bean);
	/*
	 * 中标页面选择  开标日期小于当前系统时间的数据进行中标登记
	 * @author 冉德茂
	 * @createtime 2018-10-17
	 * @updatetime 2018-10-17
	 */
	public List<BiddingRegist> pickZBPage(BiddingRegist bean);
	
	
	/*
	 * 招标保存
	 * @author 冉德茂
	 * @createtime 2018-07-24
	 * @updatetime 2018-07-24
	 */
	
	public void save(String fbidStauts, BiddingRegist bean, String form, String files, User user) throws Exception;
	
	/*
	 * 根据ID删除
	 * @author 冉德茂
	 * @createtime 2018-07-24
	 * @updatetime 2018-07-24
	 */
	public void delete(Integer id);
	

	
	/**
	 * 
	 * @Description 根据采购申请表id查询采购过程登记表数据
	 * @author 汪耀
	 * @param pid
	 * @return
	 * @return BiddingRegist
	 * @throws
	 * @date 2020年1月9日
	 */
	public BiddingRegist getBiddingRegistByPId(Integer pId);
}
