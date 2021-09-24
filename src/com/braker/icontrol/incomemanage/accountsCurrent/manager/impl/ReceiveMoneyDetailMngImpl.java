package com.braker.icontrol.incomemanage.accountsCurrent.manager.impl;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.incomemanage.accountsCurrent.manager.ReceiveMoneyDetailMng;
import com.braker.icontrol.incomemanage.accountsCurrent.model.ReceiveMoneyDetail;

/**
 * 往来款立项申请实现层
 * @author 赵孟雷
 */
@Service
@Transactional
public class ReceiveMoneyDetailMngImpl extends BaseManagerImpl<ReceiveMoneyDetail> implements ReceiveMoneyDetailMng{

	@Override
	public List<ReceiveMoneyDetail> findByList(ReceiveMoneyDetail bean, User user) {
		Finder finder = Finder.create(" FROM ReceiveMoneyDetail WHERE 1=1");
		if(!StringUtil.isEmpty(bean.getfType())){
			finder.append(" and fType='"+bean.getfType()+"'");
		}
		if(!StringUtil.isEmpty(String.valueOf(bean.getfMSId()))){
			finder.append(" and fMSId = '"+bean.getfMSId()+"'");
		}
		return super.find(finder);
	}
}
