package com.braker.icontrol.budget.release.manager.impl;

import java.util.List;

import org.hibernate.SQLQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.budget.release.entity.TBudgetaryIndicProItf;
import com.braker.icontrol.budget.release.manager.TProItfMng;

/**
 * 项目支出预算指标下达明细service实现类
 * @author 叶崇晖
 * @createtime 2018-07-13
 * @updatetime 2018-07-13
 */
@Service
@Transactional
public class TProItfMngImpl extends BaseManagerImpl<TBudgetaryIndicProItf> implements TProItfMng{
	
	/*
	 * 获得项目支出列表
	 * @author 叶崇晖
	 * @createtime 2018-07-13
	 * @updatetime 2018-07-13
	 * @param basicType 基本支出类型 1-人员支出 2-公用支出
	 * @param type  类型：收入9/支出1
	 * @param parentId  父节点id
	 * @param year  年度
	 * @param depart 部门名称
	 */
	@Override
	public List<Object[]> getIndexTree(String basicType, String type, String parentId, String year, String depart) {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT t1.F_B_I_ID,t1.F_BUDGET_SUB_NAME,t1.F_SUB_ARRIVAL_AMOUNT,t1.F_SUB_RESID_AMOUNT,t3.F_PRO_APPLI_DEPART"+
					" FROM t_budgetary_indic_pro_itf t1"+
					" INNER JOIN t_budgetary_indic_pro t2"+
					" INNER JOIN t_pro_basic_info T3"+
					" WHERE t1.F_B_ID =t2.F_B_ID" +
					" AND t2.F_PRO_ID=t3.F_PRO_ID");
		if (!StringUtil.isEmpty(parentId)) {
			sql.append(" AND t1.F_PARENT_ID='"+parentId+"'");
		}
		if (!StringUtil.isEmpty(depart)) {
			sql.append(" AND t3.F_PRO_APPLI_DEPART='"+depart+"'");
		} else {
			sql.append(" AND t3.F_PRO_APPLI_DEPART is null");
		}
		
		String s =sql.toString();
		SQLQuery query = getSession().createSQLQuery(s);
		
		
		return query.list();
	}

	@Override
	public TBudgetaryIndicProItf save(TBudgetaryIndicProItf bean, User user) {
		
		return null;
	}

}
