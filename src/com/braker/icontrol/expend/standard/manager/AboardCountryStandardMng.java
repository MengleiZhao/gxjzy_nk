package com.braker.icontrol.expend.standard.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.expend.standard.entity.AboardCountryStandard;

/**
 * 公务出国国家及地区信息
 * @author 赵孟雷
 *
 */
public interface AboardCountryStandardMng extends BaseManager<AboardCountryStandard>{

	
	/**
	 * 查询公务出国所有国家
	 * @param bean
	 * @param user
	 * @param pageNo
	 * @param pageSize
	 * @return
	 * @author 赵孟雷
	 * @createtime 2020年5月15日
	 * @updator 赵孟雷
	 * @updatetime 2020年5月15日
	 */
	public Pagination pageListAboard(AboardCountryStandard bean, User user, int pageNo, int pageSize);
}
