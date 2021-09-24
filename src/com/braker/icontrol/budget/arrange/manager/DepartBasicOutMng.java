package com.braker.icontrol.budget.arrange.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.budget.arrange.entity.DepartBasicOut;

public interface DepartBasicOutMng extends BaseManager<DepartBasicOut>  {

	/**
	 * 保存
	 * @param bean
	 * @param user
	 * @return
	 */
	public DepartBasicOut save(DepartBasicOut bean, User user);
	public void save(List<DepartBasicOut> list, User user);
}
