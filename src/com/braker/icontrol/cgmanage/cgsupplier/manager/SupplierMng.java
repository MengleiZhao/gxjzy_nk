package com.braker.icontrol.cgmanage.cgsupplier.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierBlackInfo;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierOut;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;

/**
 * 供应商管理的service抽象类
 * @author 冉德茂
 * @createtime 2018-09-03
 * @updatetime 2018-09-03
 */
public interface SupplierMng extends BaseManager<WinningBidder>{
	/*
	 * 分页查询(供应商申请页面)
	 * @author 冉德茂
	 * @createtime 2018-09-12
	 * @updatetime 2018-09-12
	 */
	public Pagination pageList(WinningBidder bean, int pageNo, int pageSize);
	/*
	 * 中标登记选择供应商页面  不分页
	 * @author 冉德茂
	 * @createtime 2018-10-19
	 * @updatetime 2018-10-19
	 */
	public List<WinningBidder> getWhiteSupplier(WinningBidder bean);
	/*
	 * 分页查询（黑名单页面）
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */
	public Pagination blackpageList(WinningBidder bean,String timea,String timeb, int pageNo, int pageSize);
	/*
	 * 分页查询（白名单页面）
	 * @author 冉德茂
	 * @createtime 2018-09-12
	 * @updatetime 2018-09-12
	 */
	public Pagination whitepageList(WinningBidder bean,String amounta,String amountb, int pageNo, int pageSize);

	/*
	 * 新增的保存
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	public void save(WinningBidder bean,User user) throws Exception;
	
	/*
	 * 移入黑名单
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */
	public void moveintoblack(WinningBidder bean,User user);
	/*
	 * 移出黑名单
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */
	public void moveoutblack(Integer id);
	/*
	 * 根据ID删除
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	public void delete(Integer id);
	/*
	 * 移入/移出黑名单
	 * @author 李安达
	 * @createtime 2019-02-27
	 * @updatetime 2019-02-27
	 */
	public void moveblack(SupplierBlackInfo supplierBlackInfo,User user);
	/*
	 * 移入/移出黑名单历史记录
	 * @author 李安达
	 * @createtime 2019-02-27
	 * @updatetime 2019-02-27
	 */
	public List<SupplierBlackInfo> movehistory(Integer feid);
	
	
	/*
	 * 出库 
	 * @author 焦广兴
	 * @createtime 2019-06-13
	 * @updatetime 2019-06-13
	 */
	public void outSupplier(SupplierOut supplierOut,User user);
	
	/**
	 * 
	 * @Description: 根据名称查询供应商
	 * @author 汪耀
	 * @param @param name
	 * @param @return    
	 * @return WinningBidder
	 */
	public WinningBidder findByName(String name);
}
