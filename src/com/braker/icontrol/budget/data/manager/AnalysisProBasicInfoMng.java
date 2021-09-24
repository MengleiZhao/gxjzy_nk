/**
 * <p>Title: AnalysisProBasicInfoMng.java</p>  
 * <p>Description: </p>  
 * <p>Copyright: Copyright (c) 2018</p>  
 * <p>Company: www.baidudu.com</p>  
 * @author 陈睿超
 * @createtime 2020年2月27日
 */
package com.braker.icontrol.budget.data.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.budget.data.entity.AnalysisProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;

/**
 * <p>Title: AnalysisProBasicInfoMng</p>  
 * <p>Description: 项目数据分析使用</p>  
 * @author 陈睿超
 * @date 2020年2月27日  
 */
public interface AnalysisProBasicInfoMng extends BaseManager<AnalysisProBasicInfo>{

	
	/**
	 * <p>Title: copyProBasicInfo</p>  
	 * <p>Description: 保存不同状态（一上，一下，二上，二下）项目信息数据</p>  
	 * @param tProBasicInfo
	 * @param aanalysisType
	 * @author 陈睿超
	 * @createtime 2020年2月27日
	 * @updator 陈睿超
	 * @updatetime 2020年2月27日
	 */
	void copyProBasicInfo(TProBasicInfo tProBasicInfo,Integer aanalysisType); 
}
