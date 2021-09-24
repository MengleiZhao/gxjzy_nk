package com.braker.icontrol.expend.reimburse.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.expend.reimburse.model.AppInvoiceInfo;
import com.braker.icontrol.expend.reimburse.model.InvoiceInfo;
import com.braker.icontrol.expend.reimburse.model.InvoiceQuery;

/**
 * 发票管理接口
 * @author 张迅
 * @createtime 2019-03-22
 */
public interface InvoiceMng extends BaseManager<AppInvoiceInfo>{


	/**
	 * 请求接口，查询发票信息
	 * @param invoiceQuery 查询发票信息
	 * @return 发票信息（json字符串）
	 */
	public String verify(InvoiceQuery invoiceQuery);
	
	
	/**
	 * 根据指定的类型通过单据主键查询发票信息
	 * @param type是发票的类型
	 * @param id是发票所属单据的主键
	 * @return 发票信息list
	 */
	public List<AppInvoiceInfo> findByRID(String type, Integer id);


	public List<AppInvoiceInfo> findByCode(String code, String userId);


	public void deleteInvoice(String id);


	List<AppInvoiceInfo> findByCostType(String type, Integer id, String costType);
}
