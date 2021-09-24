package com.braker.icontrol.budget.control.manager.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.hql.internal.ast.tree.Node;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.DataEntity;
import com.braker.common.entity.TreeEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.budget.control.entity.TBasicExpend;
import com.braker.icontrol.budget.control.manager.TBasicExpendMng;

@Service
@Transactional
public class TBasicExpendMngImpl extends BaseManagerImpl<TBasicExpend> implements TBasicExpendMng {

	@Override
	public void saveBasicOuts(User user, List<TBasicExpend> personOutList) {

		if (personOutList != null && personOutList.size() > 0) {
			for (TBasicExpend bean: personOutList) {
				if (bean.getFPId() == null) {
					bean.setFCreateUser(user.getAccountNo());
					bean.setFCreateTime(new Date());
				} else {
					bean.setFUpdateUser(user.getAccountNo());
					bean.setFUpdateTime(new Date());
				}
				super.saveOrUpdate(bean);
			}
		}
	}


	@Override
	public List<TBasicExpend> getPersonOutListEdit(User user,Integer numId, String departName) {

		Finder f = Finder.create(" from TBasicExpend where FType=1 ");  //FType类型 1-人员基本支出 2-公用基本支出
		if (numId != null) {
			f.append(" and TBudgetControlNum.FBCId =:numId  ").setParam("numId", numId);
		}
		if (!StringUtil.isEmpty(departName)) {
			f.append(" and FDepartment =:departName  ").setParam("departName", departName);
		}
		f.append(" order by code asc ");
		return super.find(f);
	}
	
	@Override
	public List<TBasicExpend> getPersonOutListEdit(String parentId, String departName){
		Finder f = Finder.create(" from TBasicExpend where FType=1 "); //FType类型 1-人员基本支出 2-公用基本支出
		if (!StringUtil.isEmpty(departName)) {
			f.append(" and FDepartment =:departName  ").setParam("departName", departName);
		}
		if ("0".equals(parentId)) {
			f.append(" and parentNode.FPId is null");
		} else if (!StringUtil.isEmpty(parentId)) {
			f.append(" and parentNode.FPId =:parentId ").setParam("parentId", Integer.valueOf(parentId));
		}
		f.append(" order by code asc ");
//		Finder f = Finder.create(" from TBasicExpend where parentNode.FPId is null and FType=1 ");
		return super.find(f);
	}
	
	@Override
	public List<TBasicExpend> getCommOutListEdit(User user,Integer numId, String departName) {
		
		Finder f = Finder.create(" from TBasicExpend where FType=2 ");  //FType类型 1-人员基本支出 2-公用基本支出
		if (numId != null) {
			f.append(" and TBudgetControlNum.FBCId =:numId  ").setParam("numId", numId);
		}
		if (!StringUtil.isEmpty(departName)) {
			f.append(" and FDepartment =:departName  ").setParam("departName", departName);
		}
		f.append(" order by code asc ");
		return super.find(f);
	}

	@Override
	public List<DataEntity> getDepartList(String subjectName, String departName, String year, String outType) {
		
		//查询数据库获得数据
		Finder finder = Finder.create(" select a.name,a.FDepartment,a.FExt1,sum(a.FControl),"
				+ " (" 
				+ " select sum(b.FControl) from TBasicExpend b "
				+ " where b.name = a.name and b.FExt1 = a.FExt1 "
				+ " ), "
				+ " a.FUpdateUser,substring(a.FUpdateTime,1,10)");
		
		finder.append(" from TBasicExpend a where a.parentNode.FPId is not NULL ");
		if (!StringUtil.isEmpty(subjectName)) {
			finder.append(" and a.name like:name").setParam("name", "%" + subjectName + "%");
		}
		if (!StringUtil.isEmpty(departName)) {
			finder.append(" and a.FDepartment like:FDepartment").setParam("FDepartment", "%" + departName + "%");
		}
		if (!StringUtil.isEmpty(year)) {
			finder.append(" and a.FExt1=:year ").setParam("year", year);
		}
		if (!StringUtil.isEmpty(outType)) {
			finder.append(" and a.FType=:FType").setParam("FType", outType); 
		}
		finder.append(" group by a.name,a.FDepartment,a.FExt1 ");
		finder.append(" order by a.FDepartment,a.name,a.FExt1 ");
		List<Object[]> dbResultList = super.find(finder);
		
		//拼接后返回
		if (dbResultList != null && dbResultList.size() > 0) {
			List<DataEntity> resultList = new ArrayList<>();
			for (Object[] array: dbResultList) {
				DataEntity entity = new DataEntity();
				entity.setCol1(String.valueOf(array[1]));//科目名称
				entity.setCol2(String.valueOf(array[0]));//部门名称
				entity.setCol3(String.valueOf(array[2]));//年度
				entity.setCol4(String.valueOf(array[3]));//部门控制数
				entity.setCol5(String.valueOf(array[4]));//本年度本科目控制数
				entity.setCol6(String.valueOf(array[5]!=null? array[5]:""));//操作人
				entity.setCol7(String.valueOf(array[6]!=null? array[6]:""));//操作日期
				resultList.add(entity);
			}
			return resultList;
		}
		
		return new ArrayList<DataEntity>();
	}

	@Override
	public List<DataEntity> getSubjectList(String subjectName, String departName, String year) {
		
		//查询数据库获得数据
		Finder finder = Finder.create(" select a.name,"
				+ " a.FDepartment,"
				+ " a.FExt1,"
				+ " sum(a.FControl),"
				+ " (" 
				+ " select sum(b.FControl) from TBasicExpend b "
				+ " where b.name = a.name and b.FExt1 = a.FExt1 "
				+ " ), "
				+ " a.FUpdateUser,substring(a.FUpdateTime,1,10)");
		
		finder.append(" from TBasicExpend a where a.parentNode.FPId is not NULL ");
		if (!StringUtil.isEmpty(subjectName)) {
			finder.append(" and a.name like:name").setParam("name", "%" + subjectName + "%");
		}
		if (!StringUtil.isEmpty(departName)) {
			finder.append(" and a.FDepartment like:FDepartment").setParam("FDepartment", "%" + departName + "%");
		}
		if (!StringUtil.isEmpty(year)) {
			finder.append(" and FExt1=:year ").setParam("year", year);
		}
		finder.append(" group by a.name,a.FDepartment,a.FExt1 ");
		finder.append(" order by a.name,a.FDepartment,a.FExt1 ");
		List<Object[]> dbResultList = super.find(finder);
		
		//拼接后返回
		if (dbResultList != null && dbResultList.size() > 0) {
			List<DataEntity> resultList = new ArrayList<>();
			for (Object[] array: dbResultList) {
				DataEntity entity = new DataEntity();
				entity.setCol1(String.valueOf(array[0]));//科目名称
				entity.setCol2(String.valueOf(array[1]));//部门名称
				entity.setCol3(String.valueOf(array[2]));//年度
				entity.setCol4(String.valueOf(array[3]));//部门控制数
				entity.setCol5(String.valueOf(array[4]));//本年度本科目控制数
				entity.setCol6(String.valueOf(array[5]!=null? array[5]:""));//操作人
				entity.setCol7(String.valueOf(array[6]!=null? array[6]:""));//操作日期
				resultList.add(entity);
			}
			return resultList;
		}
		
		return new ArrayList<DataEntity>();
	}


	@Override
	public List<TBasicExpend> getCommOutListEdit(String parentId,
			String departName) {

		Finder f = Finder.create(" from TBasicExpend where FType=2 ");
		if (!StringUtil.isEmpty(departName)) {
			f.append(" and FDepartment =:departName  ").setParam("departName", departName);
		}
		if ("0".equals(parentId)) {
			f.append(" and parentNode.FPId is null");
		} else if (!StringUtil.isEmpty(parentId)) {
			f.append(" and parentNode.FPId =:parentId ").setParam("parentId", Integer.valueOf(parentId));
		}
		f.append(" order by code asc ");
//		Finder f = Finder.create(" from TBasicExpend where parentNode.FPId is null and FType=1 ");
		return super.find(f);
	
	}
	
	
}
