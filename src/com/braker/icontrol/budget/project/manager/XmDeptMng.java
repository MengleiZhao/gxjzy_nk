package com.braker.icontrol.budget.project.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.budget.project.entity.XmDept;

public interface XmDeptMng extends BaseManager<XmDept>{
	
	
	
	/**
	 * 
	* <p>Description: </p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年8月18日
	 */
	public List<XmDept> xmDeptListById(String id);
}
