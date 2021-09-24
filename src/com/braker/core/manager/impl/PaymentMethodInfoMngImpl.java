package com.braker.core.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.PayeeDao;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.core.manager.PaymentMethodInfoMng;
import com.braker.core.model.PaymentMethodInfo;
import com.braker.core.model.User;

/**
 * 个人收款方式信息的service实现类
 * @author 叶崇晖
 * @createtime 2018-11-19
 * @updatetime 2018-11-19
 */
@Service
@Transactional
public class PaymentMethodInfoMngImpl extends BaseManagerImpl<PaymentMethodInfo> implements PaymentMethodInfoMng {

	@Override
	public List<PaymentMethodInfo> findByPayeeId(String payeeId) {
		Finder finder = Finder.create(" FROM PaymentMethodInfo WHERE payeeId='"+payeeId+"'");
		return super.find(finder);
	}
	
	@Override
	public void saveInfo(PayeeDao bean, User payee) {
		List<PaymentMethodInfo> infoList = findByPayeeId(payee.getId());
		
		PaymentMethodInfo info = new PaymentMethodInfo();
		
		info.setBank(bean.getBank());//银行
		info.setBankAccount(bean.getBankAccount());//银行账户
		info.setBankName(bean.getBankName());//银行名称
		info.setZfbAccount(bean.getZfbAccount());//支付宝账户
		info.setZfbQR(bean.getZfbQR());//支付宝二维码地址
		info.setWxAccount(bean.getWxAccount());//微信账户
		info.setWxQR(bean.getWxQR());//微信二维码地址
		info.setIdCard(bean.getIdCard());//身份证号
		//新增或修改个人收款信息
		if(infoList.size()>0) {
			//修改
			info.setPayeeId(infoList.get(0).getPayeeId());//收款人id
			info.setPayeeName(infoList.get(0).getPayeeName());//收款人姓名
			info.setfId(infoList.get(0).getfId());//主键
			super.merge(info);
		} else {
			//新增
			info.setPayeeId(payee.getId());//收款人id
			info.setPayeeName(payee.getName());//收款人姓名
			super.merge(info);
		}
		
		/*for(int i=0;i<10000;i++) {
			info.setfId(i+2);
			super.merge(info);
		}*/
	}

}
