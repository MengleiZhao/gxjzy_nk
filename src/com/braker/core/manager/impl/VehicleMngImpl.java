package com.braker.core.manager.impl;

import java.math.BigInteger;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.VehicleMng;
import com.braker.core.model.Vehicle;

/**
 * 交通工具的service实现类
 * @author 叶崇晖
 * @createtime 2019-01-09
 * @updatetime 2019-01-09
 */
@Service
@Transactional
public class VehicleMngImpl extends BaseManagerImpl<Vehicle> implements VehicleMng {

	@Override
	public Pagination pageList(Vehicle bean, int pageNo, int pageSize, String parentCode) {
		Finder finder = Finder.create(" FROM Vehicle");
		if(parentCode != null) {
			finder.append(" WHERE parentCode='"+parentCode+"'");
		} else {
			finder.append(" WHERE parentCode is null");
		}
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public Integer getCount(String code) {
		String hql = "SELECT COUNT(*) FROM T_VEHICLE";
		if(code!=null && !"undefined".equals(code)){
			hql = hql +" WHERE F_PARENT_CODE='"+code+"'";
		} else {
			hql = hql + " WHERE F_PARENT_CODE IS NULL";
		}
		Query query = getSession().createSQLQuery(hql);
		List<BigInteger> li = query.list();
        return Integer.valueOf(li.get(0).toString());
	}

	@Override
	public void saveVehicle(Vehicle bean) {
		if(bean.getParentCode()==null || "".equals(bean.getParentCode())){
			bean.setParentCode(null);
		}
 		super.save(bean);
		
	}

	@Override
	public List<Vehicle> findByParentCode(String parentCode) {
		Finder finder = Finder.create(" FROM Vehicle");
		if(parentCode != null) {
			finder.append(" WHERE parentCode='"+parentCode+"'");
		} else {
			finder.append(" WHERE parentCode is null");
		}
		return super.find(finder);
	}
	
	@Override
	public List<Vehicle> findByParentCodes(String parentCode,String level) {
		Finder finder = Finder.create(" FROM Vehicle");
		if(parentCode != null) {
			finder.append(" WHERE parentCode='"+parentCode+"'");
			if(!StringUtil.isEmpty(level)){
				
				finder.append(" and fUseLevel like'%"+level+"%'");
			}
		} else {
			finder.append(" WHERE parentCode is null");
		}
		return super.find(finder);
	}

	@Override
	public List<Vehicle> findByCode(String code) {
		Finder finder = Finder.create(" FROM Vehicle WHERE code='"+code+"'");
		return super.find(finder);
	}

}
