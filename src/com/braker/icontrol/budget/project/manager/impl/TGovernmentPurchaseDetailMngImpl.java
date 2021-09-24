package com.braker.icontrol.budget.project.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.budget.project.entity.TGovernmentPurchaseDetail;
import com.braker.icontrol.budget.project.manager.TGovernmentPurchaseDetailMng;

/**
 * 政府采购明细表service
* <p>Title:TGovernmentPurchaseDetailMngImpl </p>
* <p>Description: </p>
* <p>Company: </p> 
* @author zml
* @date 2021年6月1日
 */
@Service
@Transactional
public class TGovernmentPurchaseDetailMngImpl  extends BaseManagerImpl<TGovernmentPurchaseDetail>  implements TGovernmentPurchaseDetailMng {

	@Override
	public List<TGovernmentPurchaseDetail> getByProId(Integer FProId,String fIfSoftware) {
		Finder finder = Finder.create(" FROM TGovernmentPurchaseDetail WHERE fProId='"+FProId+"' and fIfSoftware='"+fIfSoftware+"'");
		return super.find(finder);
	}

}
