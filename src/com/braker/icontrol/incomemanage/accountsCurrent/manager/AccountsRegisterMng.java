package com.braker.icontrol.incomemanage.accountsCurrent.manager;
import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.incomemanage.accountsCurrent.model.AccountsRegister;
import com.braker.workflow.entity.TProcessCheck;
public interface AccountsRegisterMng extends BaseManager<AccountsRegister>{

	/*
	 * 分页查询来款登记
	 * @author 赵孟雷
	 * @createtime 2020-11-12
	 * @updatetime 2020-11-12
	 */
	public Pagination pageList(AccountsRegister bean, int pageNo, int pageSize, Integer type, User user);
	/*
	 * 分页查询来款登记审批
	 * @author 赵孟雷
	 * @createtime 2020-11-12
	 * @updatetime 2020-11-12
	 */
	public Pagination pageCheckList(AccountsRegister bean, int pageNo, int pageSize, Integer type, User user);
	/*
	 * 新增
	 * @author 赵孟雷
	 * @createtime 2020-11-12
	 * @updatetime 2020-11-12
	 */
	public void save(AccountsRegister bean,String files,User user,String registerJson) throws Exception;
	/*
	 * 审核
	 * @author 赵孟雷
	 * @createtime 2020-11-12
	 * @updatetime 2020-11-12
	 */
	public void check(TProcessCheck checkBean,AccountsRegister bean, String files, User user) throws Exception;
	
	/*
	 * 删除
	 * @author 赵孟雷
	 * @createtime 2020-11-12
	 * @updatetime 2020-11-12
	 */
	public void delete(Integer id,User user,String fId);
	/*
	 * 分页查询来款登记审批
	 * @author 赵孟雷
	 * @createtime 2020-11-12
	 * @updatetime 2020-11-12
	 */
	public Pagination registerAffirmPage(AccountsRegister bean, int pageNo, int pageSize, Integer type, User user);
	
	/*
	 * 来款确认修改数据
	 * @author 赵孟雷
	 * @createtime 2020-11-13
	 * @updatetime 2020-11-13
	 */
	public void saveRegisterAffirm(AccountsRegister bean,User user) throws Exception;
	/*
	 * 来款登记撤回
	 * @author 赵孟雷
	 * @createtime 2020-11-13
	 * @updatetime 2020-11-13
	 */
	public String registerAffirmReCall(Integer id) throws Exception;
	/*
	 * 查询来款登记中的已确认的单子
	 * @author 赵孟雷
	 * @createtime 2020-11-13
	 * @updatetime 2020-11-13
	 */
	public List<AccountsRegister> registerList(AccountsRegister bean,User user) throws Exception;
}
