package com.braker.icontrol.budget.manager.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;

/**
 * 控制数分解的service抽象类
 * @author 叶崇晖
 * @createtime 2018-09-26
 * @updatetime 2018-09-26
 */
public interface ResolveMng extends BaseManager<TProBasicInfo> {
	
	/*
	 * 控制数分解数据查询
	 * @author 叶崇晖
	 * @createtime 2018-09-26
	 * @updatetime 2018-09-26
	 */
	public List<TProBasicInfo> pageList(TProBasicInfo bean, int pageNo, int pageSize, User user, String type);
	
	/*
	 * 控制数分解数据保存
	 * @author 叶崇晖
	 * @createtime 2018-09-26
	 * @updatetime 2018-09-26
	 */
	public void save(String fproId, String commitAmount1, String fext12);
}
