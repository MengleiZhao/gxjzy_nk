package com.braker.icontrol.expend.apply.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.icontrol.expend.apply.manager.OutsideTrafficInfoMng;
import com.braker.icontrol.expend.apply.model.OutsideTrafficInfo;


/**
 * 城市间交通费service实现层
 * @author 赵孟雷
 *
 */
@Service
@Transactional
public class OutsideTrafficInfoMngImpl extends BaseManagerImpl<OutsideTrafficInfo> implements OutsideTrafficInfoMng {

/**
 * 城市间交通费查询
 */
public Pagination outsideTrafficInfoPageList(int pageNo, int pageSize,OutsideTrafficInfo bean){
		
		Finder finder = Finder.create(" FROM OutsideTrafficInfo WHERE sts =0");	
		if (!StringUtil.isEmpty(String.valueOf(bean.getgId()))) {
			finder.append(" AND gId="+bean.getgId()+"");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getTravelType()))) {
			finder.append(" AND travelType='"+bean.getTravelType()+"'");
		}
		finder.append(" order by fStartDate asc");
		return super.find(finder, pageNo, pageSize);
	}

@Override
public Pagination routsideTrafficInfoPageList(int pageNo, int pageSize,OutsideTrafficInfo bean) {
	Finder finder = Finder.create(" FROM OutsideTrafficInfo WHERE sts =1");	
	if (!StringUtil.isEmpty(String.valueOf(bean.getrId()))) {
		finder.append(" AND rId="+bean.getrId()+"");
	}
	if (!StringUtil.isEmpty(String.valueOf(bean.getTravelType()))) {
		finder.append(" AND travelType='"+bean.getTravelType()+"'");
	}
	finder.append(" order by fStartDate asc");
	return super.find(finder, pageNo, pageSize);
}

	@Override
	public Pagination getTravelWay(Integer page, Integer rows, OutsideTrafficInfo bean) {
		Finder finder = Finder.create(" FROM OutsideTrafficInfo WHERE 1=1");	
		if (!StringUtil.isEmpty(String.valueOf(bean.getgId()))) {
			finder.append(" AND gId="+bean.getgId()+"");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getTravelType()))) {
			finder.append(" AND travelType='"+bean.getTravelType()+"'");
		}
		finder.append(" order by fStartDate asc");
		return super.find(finder, page, rows);
	}

	@Override
	public List<OutsideTrafficInfo> getTravelWayById(Integer id) {
		Finder finder = Finder.create(" FROM OutsideTrafficInfo WHERE 1=1");	
		if (id != null) {
			finder.append(" AND gId="+ id +"");
		}
		finder.append(" AND travelType='GWCG'");
		finder.append(" order by fStartDate asc");
		return super.find(finder);
	}
}
