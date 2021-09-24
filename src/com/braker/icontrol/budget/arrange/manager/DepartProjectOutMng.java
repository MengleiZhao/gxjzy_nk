package com.braker.icontrol.budget.arrange.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.budget.arrange.entity.DepartProjectOut;

public interface DepartProjectOutMng extends BaseManager<DepartProjectOut>  {

	/**
	 * 保存
	 * @param bean
	 * @param user
	 * @return
	 */
	public DepartProjectOut save(DepartProjectOut bean, User user);
	
	/**
	 * 
	 * @param list
	 * @param user
	 * @return 总金额
	 */
	public void save(List<DepartProjectOut> list, User user);
	
	/**
	 * 获取部门预算编制的当年的项目支出
	 * @param arrangeId 预算编制id
	 * @param 类型 1-当年 2-往年
	 */
	public List<DepartProjectOut> getProjectOutByArrange(Integer arrangeId, Integer type);
}
