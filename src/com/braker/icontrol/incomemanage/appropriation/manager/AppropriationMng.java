package com.braker.icontrol.incomemanage.appropriation.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.incomemanage.appropriation.model.AppropriationInfo;
import com.braker.workflow.entity.TProcessCheck;

/**
 * 拨款收入Service层
 * @author wanping
 *
 */
public interface AppropriationMng extends BaseManager<AppropriationInfo> {

	/**
	 * 拨款收入列表
	 * @param bean
	 * @param page
	 * @param rows
	 * @return
	 */
	Pagination pageList(AppropriationInfo bean, Integer page, Integer rows);

	/**
	 * 拨款类收入保存
	 * @param user
	 * @param appropriationInfo
	 * @param files 
	 */
	void save(User user, AppropriationInfo appropriationInfo, String files,String registerJson) throws Exception;

	/**
	 * 拨款类收入登记撤回
	 * @param id
	 */
	void reCall(Integer id);

	/**
	 * 拨款类收入登记删除
	 * @param id
	 */
	void delete(Integer id);

	/**
	 * 登记审核
	 * @param checkBean
	 * @param bean
	 * @param spjlFile
	 * @param user
	 */
	void saveCheck(TProcessCheck checkBean, AppropriationInfo bean, String spjlFile, User user) throws Exception;

	/**
	 * 登记审核列表数据
	 * @param bean
	 * @param page
	 * @param rows
	 * @param user 
	 * @return
	 */
	Pagination checkPageList(AppropriationInfo bean, Integer page, Integer rows, User user);

	/**
	 * 来款确认数据
	 * @param bean
	 * @param page
	 * @param rows
	 * @return
	 */
	Pagination confirmPageList(AppropriationInfo bean, Integer page, Integer rows);

	/**
	 * 来款确认
	 * @param bean
	 */
	void confirmAppropriation(AppropriationInfo bean);
}
