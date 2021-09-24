package com.braker.icontrol.expend.voucher.manager.Impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.expend.voucher.entity.Voucher;
import com.braker.icontrol.expend.voucher.entity.VoucherList;
import com.braker.icontrol.expend.voucher.manager.VoucherListMng;
import com.braker.icontrol.expend.voucher.manager.VoucherMng;

@Service
public class VoucherMngImpl extends BaseManagerImpl<Voucher> implements VoucherMng{
	
	@Autowired
	private VoucherListMng voucherListMng;
	@Override
	public Pagination list(Voucher voucher, User user, Integer pageNo,Integer pageSize) {
		Finder finder = Finder.create(" FROM Voucher WHERE 1=1");
		if (!StringUtil.isEmpty(voucher.getfVoucherSummary())) {
			finder.append(" and fVoucherSummary LIKE :fVoucherSummary");
			finder.setParam("fVoucherSummary", "%"+voucher.getfVoucherSummary()+"%");
		}
		if (!StringUtil.isEmpty(voucher.getfVoucher())) {
			finder.append(" and fVoucher LIKE :fVoucher");
			finder.setParam("fVoucher", "%"+voucher.getfVoucher()+"%");
		}
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}

	/**
	 * 
	* @author:安达
	* @Title: addVoucher 
	* @Description: 添加凭证库
	* @param beanCode   各种申请单编码
	* @param fSummary  摘要
	* @param fDeptName  部门Id
	* @param fDeptName  部门名称
	* @param fProjectName 项目名称
	* @param fEconomicName  预算指标体系的最末级指标
	* @param amount   发生金额
	* @param contPayTotal  合同付款总金额。  如果为0，说明是直接报销
	* @param sourcesfunds  根据预算指标选取到的资金来源
	* @param bankText  出纳受理后选取的对应银行进行付款
	* @return
	* @return String    返回类型 
	* @date： 2019年7月1日下午9:34:25 
	* @throws
	 */
	@Override
	public String addVoucher(String beanCode, String fSummary, String fDeptId,
			String fDeptName, String fProjectName, String fEconomicName,
			Double amount,Double contPayTotal,String sourcesfunds,String bankText) {
		if(contPayTotal>0){ //如果是合同付款
			//先查询是否第一次
			List<Voucher> voucherLists=super.findByProperty("fBeanCode", beanCode);
			if(voucherLists ==null ||voucherLists.size()==0){//查不到，说明是第一次
				//添加凭证表
				Voucher voucher=addVoucher( beanCode,  fSummary, amount);
				//第一行 返回凭证清单对象，获取计算好的凭证号
				VoucherList voucherList= voucherListMng.addVoucherList(fSummary, fDeptId, fDeptName, fProjectName, fEconomicName, contPayTotal,sourcesfunds,bankText, 1, voucher);
				//第二行
				 voucherListMng.addVoucherList(fSummary, fDeptId, fDeptName, fProjectName, fEconomicName, contPayTotal,sourcesfunds,bankText, 2, voucher);
				//重新把凭证号设置进凭证表里
				 voucher.setfVoucher(voucherList.getfListVoucher());
				 super.updateDefault(voucher);
				 
				 //第二张
				//添加凭证表
				Voucher voucher2=addVoucher( beanCode,  fSummary, amount);
				//添加凭证清单
				//第一行 返回凭证清单对象，获取计算好的凭证号
				VoucherList voucherList2=voucherListMng.addVoucherList(fSummary, fDeptId, fDeptName, fProjectName, fEconomicName, amount,sourcesfunds,bankText, 1, voucher2);
				//第二行
				 voucherListMng.addVoucherList(fSummary, fDeptId, fDeptName, fProjectName, fEconomicName, amount,sourcesfunds,bankText, 2, voucher2);
				//第三行
				 voucherListMng.addVoucherList(fSummary, fDeptId, fDeptName, fProjectName, fEconomicName, amount,sourcesfunds,bankText, 3, voucher2);
				//第四行
				 voucherListMng.addVoucherList(fSummary, fDeptId, fDeptName, fProjectName, fEconomicName, amount,sourcesfunds,bankText, 4, voucher2);
				//重新把凭证号设置进凭证表里
				 voucher.setfVoucher(voucherList2.getfListVoucher());
				 super.updateDefault(voucher2);
					 
			}else{ //否则，之前已经生成过凭证表，只填写一张
				//添加凭证表
				Voucher voucher=addVoucher( beanCode,  fSummary, amount);
				//添加凭证清单
				//第一行 返回凭证清单对象，获取计算好的凭证号
				VoucherList voucherList=voucherListMng.addVoucherList(fSummary, fDeptId, fDeptName, fProjectName, fEconomicName, amount,sourcesfunds,bankText, 1, voucher);
				//第二行
				 voucherListMng.addVoucherList(fSummary, fDeptId, fDeptName, fProjectName, fEconomicName, amount,sourcesfunds,bankText, 2, voucher);
				//第三行
				 voucherListMng.addVoucherList(fSummary, fDeptId, fDeptName, fProjectName, fEconomicName, amount,sourcesfunds,bankText, 3, voucher);
				//第四行
				 voucherListMng.addVoucherList(fSummary, fDeptId, fDeptName, fProjectName, fEconomicName, amount,sourcesfunds,bankText, 4, voucher);
				//重新把凭证号设置进凭证表里
				 voucher.setfVoucher(voucherList.getfListVoucher());
				 super.updateDefault(voucher);
			}
			
			
		}else{//如果不是合同付款
			//添加凭证表
			Voucher voucher=addVoucher( beanCode,  fSummary, amount);
			//添加凭证清单
			//第一行  返回凭证清单对象，获取计算好的凭证号
			VoucherList voucherList=voucherListMng.addVoucherList(fSummary, fDeptId, fDeptName, fProjectName, fEconomicName, amount,sourcesfunds,bankText, 1, voucher);
			//第二行
			 voucherListMng.addVoucherList(fSummary, fDeptId, fDeptName, fProjectName, fEconomicName, amount,sourcesfunds,bankText, 2, voucher);
			//第三行
			 voucherListMng.addVoucherList(fSummary, fDeptId, fDeptName, fProjectName, fEconomicName, amount,sourcesfunds,bankText, 3, voucher);
			//第四行
			 voucherListMng.addVoucherList(fSummary, fDeptId, fDeptName, fProjectName, fEconomicName, amount,sourcesfunds,bankText, 4, voucher);
		
			//重新把凭证号设置进凭证表里
			 voucher.setfVoucher(voucherList.getfListVoucher());
			 super.updateDefault(voucher);
		}

		
		return null;
	}

	/**
	 * 
	 * @author:安达
	 * @Title: addVoucher 
	 * @Description: 这里用一句话描述这个方法的作用 
	 * @param beanCode   各种申请单编码
	 * @param fSummary  摘要
	 * @param amount  发生金额
	 * @return
	 * @return Voucher    返回类型 
	 * @date： 2019年7月2日下午4:30:18 
	 * @throws
	 */
	@Override
	public Voucher addVoucher(String beanCode, String fSummary, Double amount) {
		//记账凭证表
		Voucher voucher=new Voucher();
		voucher.setfBeanCode(beanCode);//各种申请单编码
		voucher.setfVoucherSummary(fSummary);//摘要
		voucher.setfDebitAllAMount(amount*2);//合计借方金额
		voucher.setfCreditAllAmoount(amount*2);//合计贷方金额
		voucher.setCreateTime(new Date());
		voucher=(Voucher) super.saveOrUpdate(voucher);
		return voucher;	}
	
	@Override
	public Voucher findbyproperties(String name, String val) {
		Finder finder = Finder.create(" FROM Voucher WHERE "+name+"='"+val+"' ");
		return (Voucher) super.find(finder).get(0);
	}
	
}
