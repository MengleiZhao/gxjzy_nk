package com.braker.icontrol.budget.release.manager.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.SQLQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.TreeEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.budget.release.entity.TBudgetaryIndicBasicItf;
import com.braker.icontrol.budget.release.manager.TBasicItfMng;

/**
 * 基本支出预算指标下达明细service实现类
 * @author 叶崇晖
 * @createtime 2018-07-13
 * @updatetime 2018-07-13
 */
@Service
@Transactional
public class TBasicItfMngImpl extends BaseManagerImpl<TBudgetaryIndicBasicItf> implements TBasicItfMng{
	/*
	 * 获得基本支出列表
	 * @author 叶崇晖
	 * @createtime 2018-07-06
	 * @updatetime 2018-07-06
	 * @param basicType 基本支出类型 1-人员支出 2-公用支出
	 * @param type  类型：收入9/支出1
	 * @param parentCode  父节点代码
	 * @param year  年度
	 * @param @param depart 部门名称
	 */
	@Override
	public List<Object[]> getIndexTree(String basicType, String type, String parentId, String year, String depart) {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT t1.F_B_I_ID,t1.F_BUDGET_SUB_NAME,t1.F_SUB_ARRIVAL_AMOUNT,t1.F_SUB_RESID_AMOUNT,t2.F_DEPT_NAME "+
				   "FROM t_budgetary_indic_basic_itf t1 INNER JOIN t_budgetary_indic_basic t2 "+
				   "WHERE t1.F_B_B_ID =t2.F_B_B_ID");
/*		if (!StringUtil.isEmpty(basicType)) {
			
		}
		if (!StringUtil.isEmpty(type)) {
		
		}
		if (!StringUtil.isEmpty(year)) {
			sql.append(" AND t2.F_BUDGET_YEAR ='"+year+"'");
		}*/
		if (!StringUtil.isEmpty(parentId)) {
			sql.append(" AND t1.F_PARENT_ID='"+parentId+"'");
		} else {
			sql.append(" AND t1.F_PARENT_ID is null");
		}
		if (!StringUtil.isEmpty(depart)) {
			sql.append(" AND t2.F_DEPT_NAME='"+depart+"'");
		}
		String s =sql.toString();
		SQLQuery query = getSession().createSQLQuery(s);
		return query.list();
	}

	@Override
	public TBudgetaryIndicBasicItf save(TBudgetaryIndicBasicItf bean, User user) {
		
		if (bean != null) {
			if (bean.getBiId() == null) {
				
			} else {
				
			}
		}
		return (TBudgetaryIndicBasicItf)super.saveOrUpdate(bean);
	}

	@Override
	public void save(List<TBudgetaryIndicBasicItf> list, User user) {
		
		if (list != null && list.size() > 0) {
			for (TBudgetaryIndicBasicItf bean: list) {
				save(bean, user);
			}
		}
	}

	@Override
	public Pagination pageList(TBudgetaryIndicBasicItf bean, User user,
			Integer pageNo, Integer pageSize) {
		
		Finder f = Finder.create(" from TBudgetaryIndicBasicItf where 1=1 ");
		if (bean != null) {
			//编号 名称 年度 下达人
			if (!StringUtil.isEmpty(bean.getqCode())) {
				f.append(" and indexCode=:indexCode").setParam("indexCode", bean.getqCode());
			}
			if (!StringUtil.isEmpty(bean.getqName())) {
				f.append(" and indexName=:indexName").setParam("indexName", bean.getqName());
			}
			if (!StringUtil.isEmpty(bean.getqYear())) {
				f.append(" and YEAR(bbId.opTime)=:qYear").setParam("qYear", Integer.valueOf(bean.getqYear()));
			}
			if (!StringUtil.isEmpty(bean.getqPerson())) {
				f.append(" and bbId.userId.name=:person").setParam("person", bean.getqPerson());
			}
		}
		Pagination p = super.find(f, pageNo, pageSize);
		//加入排序号
		List<TBudgetaryIndicBasicItf> list = (List<TBudgetaryIndicBasicItf>) p.getList();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				TBudgetaryIndicBasicItf tf = list.get(i);
				tf.setPageOrder(pageNo * pageSize + i -9);
			}
		}
		return p;
	}

	@Override
	public List<TreeEntity> getTreeList(String parentId, String type, User user) {
		
		List<TreeEntity> treeList = new ArrayList<TreeEntity>();
		
		Finder f = Finder.create(" from TBudgetaryIndicBasicItf ");
		f.append(" and parentId.biId =:parentId ").setParam("parentId", parentId);
		f.append(" and bbId.departName =:departName").setParam("departName", user.getDepartName());
		if (!StringUtil.isEmpty(type)) {
			f.append(" and type=:type").setParam("type", type);
		}
		List<TBudgetaryIndicBasicItf> list = super.find(f);
		
		if (list != null && list.size() > 0) {
			for (TBudgetaryIndicBasicItf li: list) {
				TreeEntity node = new TreeEntity();
				//节点名称
				node.setText(li.getIndexName());
				//节点代码
				node.setCode(li.getIndexCode());
				//节点id
				node.setId(String.valueOf(li.getBiId()));
				//归口部门
				node.setCol1(li.getBbId()!=null? li.getBbId().getDepartName():"");
				//控制数
				node.setCol2(String.valueOf(li.getAmount()));
				//类型
				node.setCol3(li.getType());
				
				treeList.add(node);
			}
		}
		return treeList;
	}
}
