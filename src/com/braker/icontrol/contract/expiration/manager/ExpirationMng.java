package com.braker.icontrol.contract.expiration.manager;

import java.text.ParseException;
import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.ComboboxJson;
import com.braker.common.page.Pagination;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.filing.model.ReceivPlan;

public interface ExpirationMng extends BaseManager<ContractBasicInfo> {

	/**
	 * 查出最近要到期付款的合同
	 * @param contractBasicInfo
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 * @author 陈睿超
	 * @throws ParseException 
	 * @createtime 2018-07-03
	 */
	List<ContractBasicInfo> find(ContractBasicInfo contractBasicInfo, User user,Integer pageNo, Integer pageSize) throws ParseException;
	
	/**
	 * 查询字典付款性质
	 * @param parentCode
	 * @param selected
	 * @param blanked
	 * @return
	 */
	List<Lookups> getLookupsJson(String parentCode,String blanked);
	
	/**
	 * 根据时间提醒合同付款
	 * @param str 时间
	 * @author 陈睿超
	 * @createTime 2019年8月27日
	 * @updateTime 2019年8月27日
	 */
	void remindPayMoney();
	
	/**
	 * 根据（结束时间-开始时间除以2）和到期前5天进行消息提醒，内容为：您有一份XX合同正在XX状态
	 * @author 陈睿超
	 * @createTime2019年10月31日
	 * @updateTime2019年10月31日
	 */
	void remindContract();
	
	
}
