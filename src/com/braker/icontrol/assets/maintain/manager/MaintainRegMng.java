package com.braker.icontrol.assets.maintain.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.assets.maintain.model.MaintainReg;

public interface MaintainRegMng extends BaseManager<MaintainReg>{

	/**
	 * 加载维修登记单数据带查询
	 * @param maintainReg 查询条件
	 * @param user
	 * @param sort
	 * @param order
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination registrationJson(MaintainReg maintainReg,User user,String sort,String order,Integer pageNo, Integer pageSize);
	
	/**
	 * 保存登记信息
	 * @param maintainReg
	 * @param user
	 */
	void saveRegistration(MaintainReg maintainReg,User user);
	
	/**
	 * 逻辑删除数据
	 * @param id
	 */
	void deleteReg(String id);
	
}
