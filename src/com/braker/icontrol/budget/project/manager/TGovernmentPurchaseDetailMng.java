package com.braker.icontrol.budget.project.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.budget.project.entity.TGovernmentPurchaseDetail;

/**
 * 政府采购明细表service
* <p>Title:TGovernmentPurchaseDetailMngImpl </p>
* <p>Description: </p>
* <p>Company: </p> 
* @author zml
* @date 2021年6月1日
 */
public interface TGovernmentPurchaseDetailMng extends BaseManager<TGovernmentPurchaseDetail>{
	/**
	 * 根据项目id获取政府采购明细
	 * @author zml
	 * @param FProId项目id
	 * @return
	 */
	public List<TGovernmentPurchaseDetail> getByProId(Integer FProId,String fIfSoftware);
}
