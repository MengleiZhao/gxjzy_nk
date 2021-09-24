package com.braker.icontrol.purchase.apply.manager.Impl;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;
import com.braker.icontrol.assets.storage.model.AssetStock;
import com.braker.icontrol.purchase.apply.manager.PurchaseApplyMng;
import com.braker.icontrol.purchase.apply.manager.PurchaseItemsMng;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.icontrol.purchase.apply.model.PurchaseItemsDetail;

@Service
@Transactional
public class PurchaseItemsMngImpl extends BaseManagerImpl<PurchaseItemsDetail> implements PurchaseItemsMng{

	/*
	 * 采购细目分页查询
	 * @author 沈帆
	 * @createtime 2020-12-10
	 * @updatetime 2020-12-10
	 */
	@Override
	public Pagination ItemsPageList(PurchaseItemsDetail purchaseItemsDetail,Integer pageNo, Integer pageSize, String item, User user) {
		Finder finder =Finder.create(" FROM PurchaseItemsDetail WHERE fItem =  '"+item+"' ");
		if(!StringUtil.isEmpty(purchaseItemsDetail.getfName())){ //按采购编号模糊查询
			finder.append(" AND fName LIKE :fName");
			finder.setParam("fName", "%"+purchaseItemsDetail.getfName()+"%");
		}
		/*
		 * if(!"35".equals(user.getDpID())){//只有总务处能够看到复印纸细目
		 * finder.append("and pId<>'34'"); }
		 */
		return super.find(finder,pageNo,pageSize);
	}
}
