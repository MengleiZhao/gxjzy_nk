package com.braker.icontrol.cgmanage.cgapply.manager.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.icontrol.cgmanage.cgapply.manager.PurchaseUpdateMng;
import com.braker.icontrol.purchase.apply.model.PurchaseUpdateInfo;

@Service
@Transactional
public class PurchaseUpdateMngImpl  extends BaseManagerImpl<PurchaseUpdateInfo> implements PurchaseUpdateMng {

}
