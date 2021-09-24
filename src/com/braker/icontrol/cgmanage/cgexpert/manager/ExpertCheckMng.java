package com.braker.icontrol.cgmanage.cgexpert.manager;


import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertBlackInfo;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertInfo;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierBlackInfo;
import com.braker.workflow.entity.TProcessCheck;

/**
 * 专家库审核的service抽象类
 * @author 冉德茂
 * @createtime 2018-09-26
 * @updatetime 2018-09-26
 */
public interface ExpertCheckMng extends BaseManager<ExpertInfo>{
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-09-26
	 * @updatetime 2018-09-26
	 */
	public Pagination pageList(ExpertInfo bean, int pageNo, int pageSize, User user);
	
	
	
	/*
	 * 保存审核信息
	 * @author 冉德茂
	 * @createtime 2018-09-26
	 * @updatetime 2018-09-26
	 */
	public void saveCheckInfo(TProcessCheck checkBean, ExpertInfo bean, User user, Role role,String files) throws Exception ;
	
	public String inRecall(Integer id)  throws Exception ;
}
