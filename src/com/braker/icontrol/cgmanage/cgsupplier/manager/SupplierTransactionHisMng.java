package com.braker.icontrol.cgmanage.cgsupplier.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierTransactionHis;

/**
 * 供应商成交记录的service抽象类
 * @author 冉德茂
 * @createtime 2018-09-13
 * @updatetime 2018-09-13
 */
public interface SupplierTransactionHisMng extends BaseManager<SupplierTransactionHis>{
	/*
	 * 根据中标登记的主键id查询供应商的成交记录
	 * @author 冉德茂
	 * @createtime 2018-09-13
	 * @updatetime 2018-09-13
	 */	
	public SupplierTransactionHis getTrbyBidid(Integer bid);
	/*
	 * 分页查询(查询供应商成交记录信息  用于供应商评价)
	 * @author 冉德茂
	 * @createtime 2018-09-12
	 * @updatetime 2018-09-12
	 */
	public Pagination pageList(SupplierTransactionHis bean, int pageNo, int pageSize);
	
	
	/*
	 * 根据供应商id查询每个月的总成交金额
	 * @author 冉德茂
	 * @createtime 2018-09-13
	 * @updatetime 2018-09-13
	 */	
	public List<SupplierTransactionHis> getTrbyfwid(Integer fwid);
	/*
	 * 根据供应商id查询每个月的成交次数
	 * @author 冉德茂
	 * @createtime 2018-09-13
	 * @updatetime 2018-09-13
	 */	
	public List<SupplierTransactionHis> getsupamountbyfwid(Integer fwid);
	/*
	 * 根据供应商id和月份查询当月的成交信息
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */	
	public List<SupplierTransactionHis> getTrSup(Integer fwid,String month);
	/*
	 * 导出供应商id和月份查询当月的成交信息
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */	
	public List<SupplierTransactionHis> getoutputTrSup(int pageSize, int page,String sort, String order,Integer fwid,String month);

	
}
