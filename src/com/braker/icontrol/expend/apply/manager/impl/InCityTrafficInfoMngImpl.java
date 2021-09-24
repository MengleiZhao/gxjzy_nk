package com.braker.icontrol.expend.apply.manager.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.icontrol.expend.apply.manager.InCityTrafficInfoMng;
import com.braker.icontrol.expend.apply.model.InCityTrafficInfo;

@Service
@Transactional
public class InCityTrafficInfoMngImpl extends BaseManagerImpl<InCityTrafficInfo> implements InCityTrafficInfoMng {

	/**
	 * 市内交通费查询
	 */
	public Pagination inCityInfoPageList(int pageNo, int pageSize, InCityTrafficInfo bean) {
			
			Finder finder = Finder.create(" FROM InCityTrafficInfo WHERE fStatus =0");	
			if (!StringUtil.isEmpty(String.valueOf(bean.getgId()))) {
				finder.append(" AND gId="+bean.getgId()+"");
			}
			if (!StringUtil.isEmpty(String.valueOf(bean.getTravelType()))) {
				finder.append(" AND travelType='"+bean.getTravelType()+"'");
			}
			finder.append(" order by fArrivalsDate desc");
			return super.find(finder, pageNo, pageSize);
	}

	@Override
	public Pagination rinCityInfoPageList(int pageNo, int pageSize, InCityTrafficInfo bean) {
		Finder finder = Finder.create(" FROM InCityTrafficInfo WHERE fStatus =1");	
		if (!StringUtil.isEmpty(String.valueOf(bean.getrId()))) {
			finder.append(" AND rId="+bean.getrId()+"");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getTravelType()))) {
			finder.append(" AND travelType='"+bean.getTravelType()+"'");
		}
		finder.append(" order by fArrivalsDate desc");
		return super.find(finder, pageNo, pageSize);
	}

}
