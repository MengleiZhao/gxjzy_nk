package com.braker.icontrol.contract.goldpay.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.goldpay.model.GoldPay;

public interface GoldPayMng extends BaseManager<GoldPay>{

	/**
	 * 显示保证金管理主页面数据，查询已审核已备案的合同
	 * @param contractBasicInfo
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-07-04
	 */
	Pagination find(ContractBasicInfo contractBasicInfo,User user,Integer pageNo,Integer pageSize);
	
	/**
	 * 新增一条付款信息
	 * @param contractBasicInfo
	 * @param user
	 * @param GoldPay
	 * @author 陈睿超
	 * @createtime 2018-07-04
	 */
	void save(ContractBasicInfo contractBasicInfo,User user,GoldPay goldPay,String fhtbzjFiles);
	
	/**
	 * 根據合同的id查詢
	 * @param id
	 * @return
	 */
	List<GoldPay> findByContId(String id);
	
	
	
}
