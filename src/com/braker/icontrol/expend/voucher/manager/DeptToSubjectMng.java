package com.braker.icontrol.expend.voucher.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.expend.voucher.entity.DeptToSubject;

public interface DeptToSubjectMng extends BaseManager<DeptToSubject> {
	/**
	 * 
	* @author:安达
	* @Title: getFirstRowSubjectCode
	* @Description: 返回第一行的对应费用科目编码
	* @param fSummary 摘要
	* @param fDeptId   部门id
	* @return
	* @return String    返回类型 
	* @date： 2019年7月2日下午7:10:58 
	* @throws
	 */
	public String getFirstRowSubjectCode(String fSummary, String fDeptId,String sourcesfunds);
	
	/**
	 * 
	* @author:安达
	* @Title: getFirstRowSubjectCodeAndName 
	* @Description: 返回第一行的对应费用科目名称
	* @param fSummary 摘要
	* @param fDeptId   部门id
	* @return
	* @return String    返回类型 
	* @date： 2019年7月2日下午7:10:58 
	* @throws
	 */
	public String getFirstRowSubjectName(String fSummary, String fDeptId,String sourcesfunds);
	
	/**
	 * 
	* @author:安达
	* @Title: getFirstRowSubjectCodeAndName 
	* @Description: 返回第一行的对应费用科目名称
	* @param fSummary 摘要
	* @param fDeptId   部门id
	* @param sourcesfunds   资金来源  0,1,2,3
	* @return
	* @return String    返回类型 
	* @date： 2019年7月2日下午7:10:58 
	* @throws
	 */
	public String getThirdRowSubjectName(String fSummary, String fDeptId,String sourcesfunds);
}
