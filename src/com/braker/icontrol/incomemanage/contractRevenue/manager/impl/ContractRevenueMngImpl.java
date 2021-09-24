/**
 * <p>Title: ContractRevenueMngImpl.java</p>  
 * <p>Description: </p>   
 * <p>Company: 天职</p>  
 * @author 陈睿超
 * @createtime 2020年11月13日
 */
package com.braker.icontrol.incomemanage.contractRevenue.manager.impl;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.incomemanage.contractRevenue.manager.ContractRevenueMng;
import com.braker.icontrol.incomemanage.contractRevenue.model.ContractRevenue;

/**
 * <p>Title: ContractRevenueMngImpl</p>  
 * <p>Description: 合同类收入方法</p>  
 * @author 陈睿超
 * @date 2020年11月13日  
 */
@Service
@Transactional
public class ContractRevenueMngImpl extends BaseManagerImpl<ContractRevenue> implements ContractRevenueMng{

	/* 
	 * <p>Title: pagelist</p>
	 * <p>Description: </p>
	 * @param bean
	 * @param page
	 * @param rows
	 * @param user
	 * @return
	 * @see com.braker.icontrol.incomemanage.contractRevenue.manager.ContractRevenueMng#pagelist(com.braker.icontrol.incomemanage.contractRevenue.model.ContractRevenue, java.lang.Integer, java.lang.Integer, com.braker.core.model.User) 
	 * @author 陈睿超
	 * @createtime 2020年11月13日
	 * @updator 陈睿超
	 * @updatetime 2020年11月13日
	 */
	@Override
	public Pagination pagelist(ContractRevenue bean, Integer page,
			Integer rows, User user) {
		Finder finder = Finder.create("FROM ContractRevenue WHERE 1=1");
		if(!StringUtil.isEmpty(bean.getCrCode())){
			finder.append(" AND crCode LIKE :crCode").setParam("crCode", "%"+bean.getCrCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFcCode())){//合同编码
			finder.append(" AND fcCode LIKE :fcCode").setParam("fcCode", "%"+bean.getFcCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFcTitle())){//合同名称
			finder.append(" AND fcTitle LIKE :fcTitle").setParam("fcTitle", "%"+bean.getFcTitle()+"%");
		}
		
		return super.find(finder, page, rows);
	}

	
	
	
	
}
