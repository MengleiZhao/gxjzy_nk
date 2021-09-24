package com.braker.icontrol.incomemanage.businessService.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Category;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.icontrol.incomemanage.businessService.model.BusinessServiceDetails;
import com.braker.icontrol.incomemanage.businessService.model.BusinessServiceInfo;
import com.braker.workflow.entity.TProcessCheck;


/**
 * 
 * @Description 经营服务性收入的抽象类
 * @author 汪耀
 * @date : 2019年11月4日 下午5:18:49
 */
public interface BusinessServiceMng extends BaseManager<BusinessServiceInfo> {
	/**
	 * 
	 * @Description: 分页查询
	 * @author 汪耀
	 * @param @param bean
	 * @param @param page
	 * @param @param rows
	 * @param @param user
	 * @param @return    
	 * @return Pagination
	 */
	public Pagination pageList(BusinessServiceInfo bean, int page, int rows, User user,String fBusiCode,String fProName,String fDeptName,String fType);
	/**
	 * 
	 * @Description: 培训收入台账分页查询
	 * @author 赵孟雷
	 * @param @param bean
	 * @param @param page
	 * @param @param rows
	 * @param @param user
	 * @param @return    
	 * @return Pagination
	 */
	public Pagination pageLedgerList(BusinessServiceInfo bean, int page, int rows, User user);
	
	/**
	 * 
	 * @Description: 保存经营服务性收入信息
	 * @author 汪耀
	 * @param @param bean
	 * @param @param files
	 * @param @param mingxi
	 * @param @param user
	 * @param @throws Exception    
	 * @return void
	 */
	public void save(BusinessServiceInfo bean, String files, String mingxi, User user) throws Exception;
	
	/**
	 * 
	 * @Description: 根据表名、字段名、id,查询详情
	 * @author 汪耀
	 * @param @param tableName
	 * @param @param column
	 * @param @param id
	 * @param @return    
	 * @return List<Object>
	 */
	public List<Object> getDetailsList(String tableName, String column, Integer id);
	
	/**
	 * 
	 * @Description: 根据id查询经营服务性收入的详情
	 * @author 汪耀
	 * @param @param id
	 * @param @return    
	 * @return List<Object[]>
	 */
	public List<Object[]> getByBusiId(Integer id);
	
	/**
	 * 
	 * @Description: 经营服务性收入的详情JSON
	 * @author 汪耀
	 * @param @param mingxi
	 * @param @param tableClass
	 * @param @return    
	 * @return List
	 */
	public List getDetailsJson(String mingxi, Class tableClass);
	
	/**
	 * 
	 * @Description: 根据id删除
	 * @author 汪耀
	 * @param @param id    
	 * @return void
	 */
	public void delete(Integer id);
	
	/**
	 * 
	 * @Description: 保存审核信息
	 * @author 汪耀
	 * @param @param checkBean
	 * @param @param bean
	 * @param @param files
	 * @param @param user
	 * @param @throws Exception    
	 * @return void
	 */
	public void saveCheck(TProcessCheck checkBean, BusinessServiceInfo bean, String files, User user) throws Exception;
	
	/**
	 * 
	 * @Description: 根据字典项编码查询该字典项中的最大排序号
	 * @author 汪耀
	 * @param @param code
	 * @param @return    
	 * @return String
	 */
	public String getOrderNoByLookUpCode(String code);
	
	/**
	 * 
	 * @Description: 根据code查询字典类型
	 * @author 汪耀
	 * @param @param code
	 * @param @return
	 * @param @throws Exception    
	 * @return Category
	 */
	public Category getByLookUpCode(String code) throws Exception;

	public void reCall(Integer id) throws Exception ;

	public List<BusinessServiceInfo> getProjectList(User user, BusinessServiceInfo bean);
}
