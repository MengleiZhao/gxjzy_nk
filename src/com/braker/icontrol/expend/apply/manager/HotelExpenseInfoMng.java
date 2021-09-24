package com.braker.icontrol.expend.apply.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.expend.apply.model.FoodAllowanceInfo;
import com.braker.icontrol.expend.apply.model.HotelExpenseInfo;


/**
 * 住宿费service层
 * @author 赵孟雷
 *
 */
public interface HotelExpenseInfoMng extends BaseManager<HotelExpenseInfo> {

	/**
	 * 根据事前申请id单查询
	 * @param gId   ApplicationBasicInfo 的主键ID
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年4月18日
	 * @updator 陈睿超
	 * @updatetime 2020年4月18日
	 */
	List<HotelExpenseInfo> findbygId(Integer gId,String travelType);
	/**
	 * 根据报销id单查询
	 * @param gId   ReimbAppliBasicInfo 的主键ID
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年4月18日
	 * @updator 陈睿超
	 * @updatetime 2020年4月18日
	 */
	List<HotelExpenseInfo> rfindbygId(Integer rId,String travelType);
}
