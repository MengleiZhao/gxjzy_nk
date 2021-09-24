package com.braker.icontrol.budget.performancemanage.selfrule.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.icontrol.budget.performancemanage.selfeval.model.BudgetResultAttac;
import com.braker.icontrol.budget.performancemanage.selfeval.model.SelfEvaluation;
import com.braker.icontrol.budget.performancemanage.selfrule.manager.PerformanceLendgerMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;


/**
 *绩效台账的service实现类
 * @author 冉德茂
 * @createtime 2018-09-03
 * @updatetime 2018-09-03
 */
@Service
@Transactional
public class PerformanceLendgerMngImpl extends BaseManagerImpl<TProBasicInfo> implements PerformanceLendgerMng {
	
	/*
	 * 绩效评价的详细信息查看
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	public List<Object> getMingxi(String tableName ,String idName ,Integer pid) {
		Finder finder = Finder.create(" FROM " + tableName + " WHERE " + idName + "="+pid);
		return super.find(finder);
	}
	
	
	/*
	 * 自评台账的分页查询
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	@Override
	public Pagination pageList(TProBasicInfo bean, int pageNo, int pageSize) {

		// 查询自评项目表获取所有的项目id  展示已经启用的数据   自评一年一次 每次只有一个规则  不存在重复数据
		List<SelfEvaluation> evalprolist = getEvalLendgerPro("SelfEvaluation");
		String proids = "";
		// 获取所有的自评项目的id
		for (int i = 0; i < evalprolist.size(); i++) {
			SelfEvaluation evalbean = (SelfEvaluation) evalprolist.get(i);
			proids += evalbean.getFproId() + ",";
		}
		// 去掉最后一个id后面的，
		proids = proids.substring(0, proids.length() - 1);
		Finder finder = Finder.create(" from TProBasicInfo where FProId in ("+ proids + ") ");
		if (!StringUtil.isEmpty(bean.getFirstLevelName()) && !bean.getFirstLevelName().contains("请选择")) {//项目类别
			finder.append(" and firstLevelName = :typeName").setParam("typeName", bean.getFirstLevelName());
		}
		if (!StringUtil.isEmpty(bean.getFProAttribute())) {//项目属性
			finder.append(" and FProAttribute = :FProAttribute").setParam("FProAttribute", bean.getFProAttribute());
		}
		

		return super.find(finder, pageNo, pageSize);
	}

	/*
	 * 查询自评台账的信息    展示显示信息为1自评状态为1的数据
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	@Override
	public List<SelfEvaluation> getEvalLendgerPro(String tableName) {
		Finder finder = Finder.create(" FROM " + tableName + " WHERE fisShow='1'  AND fisEval='1' " );
		return super.find(finder);
	}

	/*
	 * 附件信息查询根据mianid
	 * @author 冉德茂
	 * @createtime 2018-09-05
	 * @updatetime 2018-09-05
	 */
	@Override
	public BudgetResultAttac getAttacByMainId(Integer id) {
		Finder finder = Finder.create(" FROM BudgetResultAttac WHERE noticeAttacId='"+id+"'");
		List<BudgetResultAttac> li =  super.find(finder);
		return li.get(0);
	}
	
	
	
	
	
	
	
}


