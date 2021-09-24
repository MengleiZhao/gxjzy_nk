package com.braker.icontrol.budget.knot.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.budget.knot.entity.TPorjectKnot;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.contract.Formulation.model.ExecuteProject;
import com.braker.workflow.entity.TProcessCheck;
/**
 * 
 * <p>Description: 结项申请接口</p>
 * @author:安达
 * @date： 2019年6月11日下午9:23:53
 */
public interface PorjectKnotMng extends BaseManager<TPorjectKnot> {

	/**
	 * 
	* @author:安达
	* @Title: saveProject 
	* @Description: 结项申请送审和保存
	* @param bean
	* @param user
	* @param opeType
	* @param files
	* @return
	* @throws Exception
	* @return TProBasicInfo    返回类型 
	* @date： 2019年6月11日下午9:24:08 
	* @throws
	 */
	public void  save(TPorjectKnot bean, User user, String opeType, String files) throws Exception;
	
	/**
	 * 
	* @author:安达
	* @Title: check 
	* @Description: 审批
	* @param checkBean 
	* @param bean
	* @param user
	* @throws Exception
	* @return void    返回类型 
	* @date： 2019年6月11日下午9:47:56 
	* @throws
	 */
	void check(TProcessCheck checkBean,TProBasicInfo bean,ExecuteProject executeproject,User user,String files)  throws Exception;
	
	/**
	 * 分页查询
	 * @param bean 实体对象，存放查询条件
	 * @param user 操作人
	 * @param pageNo 当前页码
	 * @param pageSize 每页显示行数
	 * @return
	 */
	public Pagination pageList(TProBasicInfo bean, User user, int pageNo, int pageSize);
	

}
