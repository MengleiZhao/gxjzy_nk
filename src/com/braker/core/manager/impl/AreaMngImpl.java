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
import com.braker.core.manager.AreaMng;
import com.braker.core.model.AreaBasicInfo;

/**
 * 省市地区的service实现类
 * @author 叶崇晖
 * @createtime 2019-01-10
 * @updatetime 2019-01-10
 */
@Service
@Transactional
public class AreaMngImpl extends BaseManagerImpl<AreaBasicInfo> implements AreaMng {

	@Override
	public Pagination pageList(AreaBasicInfo bean, int pageNo, int pageSize,String parentCode) {
		Finder finder = Finder.create(" FROM AreaBasicInfo");
		if(parentCode != null) {
			finder.append(" WHERE parentCode='"+parentCode+"'");
		} else {
			finder.append(" WHERE parentCode is null");
		}
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public Integer getCount(String code) {
		String hql = "SELECT COUNT(*) FROM T_AREA";
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
	public void saveArea(AreaBasicInfo bean) {
		if(bean.getParentCode()==null || "".equals(bean.getParentCode())){
			bean.setParentCode(null);
		}
 		super.save(bean);
	}

	@Override
	public List<AreaBasicInfo> comboboxFind(String parentCode) {
		Finder finder = Finder.create(" FROM AreaBasicInfo");
		if(parentCode != null) {
			finder.append(" WHERE parentCode='"+parentCode+"'");
		} else {
			finder.append(" WHERE parentCode is null");
		}
		return super.find(finder);
	}

	@Override
	public List<AreaBasicInfo> findByCode(String code) {
		Finder finder = Finder.create(" FROM AreaBasicInfo");
		if(!StringUtil.isEmpty(code)) {
			finder.append(" WHERE code='"+code+"'");
		} else {
			finder.append(" WHERE code is null");
		}
		return super.find(finder);
	}

	@Override
	public void saveBatchSave(String parentCode, String firstCode, String nameList) {
		String[] names = nameList.split(",");
		
		for (int i = 0; i < names.length; i++) {
			AreaBasicInfo bean = new AreaBasicInfo();
			bean.setParentCode(parentCode);//设置统一的父节点编码
			bean.setName(names[i]);//设置各个城市地区名称
			bean.setCode(String.valueOf(Integer.valueOf(firstCode)+i));//设置编码（第一个编码加循环次数）
			super.save(bean);//保存
		}
	}

}
