package com.braker.icontrol.cgmanage.cgsupplier.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierEvaluaInfo;

/**
 * 供应商评价的service抽象类
 * @author 冉德茂
 * @createtime 2018-09-21
 * @updatetime 2018-09-21
 */
public interface EvalSupplierMng extends BaseManager<SupplierEvaluaInfo>{

	/*
	 * 保存供应商的评价信息
	 * @author 冉德茂
	 * @createtime 2018-09-21
	 * @updatetime 2018-09-21
	 */
	public void save(SupplierEvaluaInfo bean,User user,String fpid,String fwid,String fpcode,String fpname,String zonghe,String price,String rate,String quality,String service,String fremark,String isniming);
	/*
	 *通过fpid查询供应商的评价信息
	 * @author 冉德茂
	 * @createtime 2018-09-21
	 * @updatetime 2018-09-21
	 */
	public  List<SupplierEvaluaInfo> findEvalSupplierbyFpid(Integer pid);
	/*
	 * 分页查询(查询供应商的评价记录信息  只读  评价在采购验收时操作)
	 * @author 冉德茂
	 * @createtime 2018-09-25
	 * @updatetime 2018-09-25
	 */
	public Pagination pageList(SupplierEvaluaInfo bean,String wid, int pageNo, int pageSize);
	/*
	 *通过fwid查询该供应商的所有评价信息
	 * @author 冉德茂
	 * @createtime 2018-09-21
	 * @updatetime 2018-09-21
	 */
	public  List<SupplierEvaluaInfo> findEvalSupplierbyFwid(Integer wid);
	

	
}
