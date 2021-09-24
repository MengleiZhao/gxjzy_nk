/**
 * <p>Title: ContractRevenueMng.java</p>  
 * <p>Description: </p>   
 * <p>Company: 天职</p>  
 * @author 陈睿超
 * @createtime 2020年11月13日
 */
package com.braker.icontrol.incomemanage.contractRevenue.manager;

import org.springframework.ui.ModelMap;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.incomemanage.contractRevenue.model.ContractRevenue;

/**
 * <p>Title: ContractRevenueMng</p>  
 * <p>Description: 抽象层</p>  
 * @author 陈睿超
 * @date 2020年11月13日  
 */
public interface ContractRevenueMng extends BaseManager<ContractRevenue>{
	
	
	
	Pagination pagelist(ContractRevenue bean, Integer page, Integer rows, User user);
	
	
	
}
