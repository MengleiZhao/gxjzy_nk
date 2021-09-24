package com.braker.icontrol.expend.apply.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.icontrol.expend.apply.model.FoodAllowanceInfo;
import com.braker.icontrol.expend.apply.model.InCityTrafficInfo;

/**
 * 伙食补助费service层
 * @author 赵孟雷
 *
 */
public interface FoodAllowanceInfoMng extends BaseManager<FoodAllowanceInfo>{

	/**
	 * 根据事前申请id单查询
	 * @param gId   ApplicationBasicInfo 的主键ID
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年4月18日
	 * @updator 陈睿超
	 * @updatetime 2020年4月18日
	 */
	List<FoodAllowanceInfo> findbygId(Integer gId,String travelType);
	/**
	 * 事后报销id单查询
	 * @param rId   ReimbAppliBasicInfo 的主键ID
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年4月21日
	 * @updator 陈睿超
	 * @updatetime 2020年4月21日
	 */
	List<FoodAllowanceInfo> rfindbygId(Integer rId,String travelType);
}
