package com.braker.icontrol.expend.reimburse.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.expend.reimburse.model.InvoiceCouponInfo;

/**
 * 发票票面信息管理接口
 * @author 叶崇晖
 * @createtime 2019-04-03
 */
public interface InvoiceCouponMng extends BaseManager<InvoiceCouponInfo> {
	
	/**
	 * 根据发票的id查询对应的所有票面信息
	 * @param iId是发票的主键
	 * @return 票面信息list
	 */
	public List<InvoiceCouponInfo> findByIID(Integer iId);
	
	/**
	 * 根据报销单rId 和数据类型查询
	 * @param rId
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年4月23日
	 * @updator 陈睿超
	 * @updatetime 2020年4月23日
	 */
	List<InvoiceCouponInfo> findByrID(Integer rId,String fDataType);
}
