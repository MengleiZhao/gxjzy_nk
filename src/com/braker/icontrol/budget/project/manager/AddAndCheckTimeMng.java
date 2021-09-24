/**
 * <p>Title: AddAndCheckTimeMng.java</p>  
 * <p>Description: </p>   
 * <p>Company: 天职</p>  
 * @author 陈睿超
 * @createtime 2020年9月27日
 */
package com.braker.icontrol.budget.project.manager;

import org.springframework.ui.ModelMap;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.AddAndCheckTime;

/**
 * <p>Title: AddAndCheckTimeMng</p>  
 * <p>Description: </p>  
 * @author 陈睿超
 * @date 2020年9月27日  
 */
public interface AddAndCheckTimeMng extends BaseManager<AddAndCheckTime> {

	/**
	 * <p>Title: save</p>  
	 * <p>Description: 保存</p>  
	 * @param bean
	 * @param user
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年9月27日
	 * @updator 陈睿超
	 * @updatetime 2020年9月27日
	 */
	String save(AddAndCheckTime bean ,User user);
	
	/**
	 * 
	 * <p>Title: findbyDataType</p>  
	 * <p>Description: 根据fDataType查询数据</p>  
	 * @param fDataType
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年9月27日
	 * @updator 陈睿超
	 * @updatetime 2020年9月27日
	 */
	AddAndCheckTime findbyDataType(Integer fDataType);
	
	/**
	 * 
	 * <p>Title: verifyToCheckTime</p>  
	 * <p>Description: 校验是否超过申报日期范围</p>  
	 * @param bean
	 * @return true通过,false不通过
	 * @author 陈睿超
	 * @createtime 2020年9月28日
	 * @updator 陈睿超
	 * @updatetime 2020年9月28日
	 */
	Boolean verifyToCheckTime(AddAndCheckTime bean);
	
	/**
	 * 
	 * <p>Title: verifyCheckTime</p>  
	 * <p>Description: 校验是否超过审批日期范围</p>  
	 * @param bean
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年9月28日
	 * @updator 陈睿超
	 * @updatetime 2020年9月28日
	 */
	Boolean verifyCheckTime(AddAndCheckTime bean);
	
	/**
	 * 
	 * <p>Title: verifyUpdateTime</p>  
	 * <p>Description: 校验是否超过修改日期范围</p>  
	 * @param bean
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年9月28日
	 * @updator 陈睿超
	 * @updatetime 2020年9月28日
	 */
	Boolean verifyUpdateTime(AddAndCheckTime bean);
	
	
	
}
