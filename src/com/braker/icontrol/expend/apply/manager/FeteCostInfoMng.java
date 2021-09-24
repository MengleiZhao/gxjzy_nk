package com.braker.icontrol.expend.apply.manager;

import java.util.List;
import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.expend.apply.model.FeteCostInfo;

/**
 * 宴请费service层
 * @author 赵孟雷
 *
 */
public interface FeteCostInfoMng extends BaseManager<FeteCostInfo>{

	/**
	 * 根据事前申请id单查询
	 * @param gId   ApplicationBasicInfo 的主键ID
	 * @return
	 * @author 赵孟雷
	 * @createtime 2020年5月18日
	 * @updator 赵孟雷
	 * @updatetime 2020年5月18日
	 */
	List<FeteCostInfo> findbygId(Integer gId);
	/**
	 * 事后申请id单查询
	 * @param rId
	 * @return
	 * @author 赵孟雷
	 * @createtime 2020年5月24日
	 * @updator 赵孟雷
	 * @updatetime 2020年5月24日
	 */
	List<FeteCostInfo> rfindbygId(Integer rId);
}
