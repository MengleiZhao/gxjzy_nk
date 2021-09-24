package com.braker.icontrol.expend.reimburse.manager.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.icontrol.expend.reimburse.manager.InvoiceCouponMng;
import com.braker.icontrol.expend.reimburse.model.InvoiceCouponInfo;

/**
 * 发票票面信息管理
 * @author 叶崇晖
 * @createtime 2019-04-03
 */
@Service
@Transactional
public class InvoiceCouponMngImpl extends BaseManagerImpl<InvoiceCouponInfo> implements InvoiceCouponMng {

	@Override
	public List<InvoiceCouponInfo> findByIID(Integer iId) {
		Finder finder = Finder.create(" FROM InvoiceCouponInfo WHERE iId='"+iId+"'");
		return super.find(finder);
	}

	@Override
	public List<InvoiceCouponInfo> findByrID(Integer rId,String fDataType) {
		Finder finder = Finder.create(" FROM InvoiceCouponInfo WHERE rId="+rId+" and fDataType='"+fDataType+"'");
		return super.find(finder);
	}

}
