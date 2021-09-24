package com.braker.icontrol.expend.apply.manager;

import java.util.List;
import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.expend.apply.model.InternationalTravelingExpense;

/**
 * 国际旅费service层
 * @author 赵孟雷
 *
 */
public interface InternationalTravelingExpenseInfoMng extends BaseManager<InternationalTravelingExpense>{

	/**
	 * 
	 * @param gId
	 * @return
	 * @author 赵孟雷
	 * @createtime 2020年5月20日
	 * @updator 赵孟雷
	 * @updatetime 2020年5月20日
	 */
	List<InternationalTravelingExpense> findbygId(Integer gId);
	/**
	 * 
	 * @param rId
	 * @return
	 * @author 赵孟雷
	 * @createtime 2020年5月20日
	 * @updator 赵孟雷
	 * @updatetime 2020年5月20日
	 */
	List<InternationalTravelingExpense> rfindbygId(Integer rId);
}
