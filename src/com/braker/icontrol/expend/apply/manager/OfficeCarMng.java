package com.braker.icontrol.expend.apply.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.icontrol.expend.apply.model.OfficeCar;


/**
  * 公车运维的service抽象类
  * @author 赵孟雷
  * @createtime 2020-05-07
  * @updatetime 2020-05-07
  */
public interface OfficeCarMng extends BaseManager<OfficeCar>{

	Pagination carPageList(int pageNo, int pageSize,Integer rId);
}
