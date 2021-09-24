package com.braker.icontrol.expend.refund.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.expend.refund.model.RefundInfo;
import com.braker.icontrol.expend.refund.model.StudentRefundMoney;

public interface RefundMoneyMng extends BaseManager<StudentRefundMoney>{

	/**
	 * 根据外键查询相关明细单据
	 * @param fRId
	 * @return
	 * @author 陈睿超
	 * @createTime2019年11月28日
	 * @updateTime2019年11月28日
	 */
	List<StudentRefundMoney> findbyfRId(Integer fRId);

	/**
	 * 保存StudentRefundMoney
	 * @param infomoneyJson
	 * @param user
	 * @param refundInfo 
	 * @author 陈睿超
	 * @createTime2019年11月28日
	 * @updateTime2019年11月28日
	 */
	void save(RefundInfo refundInfo,String infomoneyJson,User user);
	
	
}
