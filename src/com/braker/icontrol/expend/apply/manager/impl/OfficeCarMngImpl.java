package com.braker.icontrol.expend.apply.manager.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.icontrol.expend.apply.manager.OfficeCarMng;
import com.braker.icontrol.expend.apply.model.OfficeCar;

/**
 * 公车运维的service抽象类
 * @author 赵孟雷
 * @createtime 2020-05-07
 * @updatetime 2020-05-07
 */
@Service
@Transactional
public class OfficeCarMngImpl extends BaseManagerImpl<OfficeCar> implements OfficeCarMng{

	/**
	 * 查询公车运维报销费用明细单
	 */
	@Override
	public Pagination carPageList(int pageNo, int pageSize, Integer rId) {
		Finder finder = Finder.create(" FROM OfficeCar WHERE fStatus =1");	
		if (!StringUtil.isEmpty(String.valueOf(rId))) {
			finder.append(" AND rId="+rId+"");
		}
		finder.append(" order by createTime desc");
		return super.find(finder, pageNo, pageSize);
	}


}
