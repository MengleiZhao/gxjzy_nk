package com.braker.icontrol.budget.performancemanage.selfrule.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.icontrol.budget.performancemanage.selfeval.model.BudgetResultAttac;
import com.braker.icontrol.budget.performancemanage.selfeval.model.SelfEvaluation;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;

/**
 * 绩效目标台账的的service抽象类
 * @author 冉德茂
 * @createtime 2018-08-13
 * @updatetime 2018-08-13
 */
public interface PerformanceLendgerMng extends BaseManager<TProBasicInfo>{
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-08-07
	 * @updatetime 2018-08-07
	 */
	public Pagination pageList(TProBasicInfo bean, int pageNo, int pageSize);

	/*
	 * 显示自评的台账信息
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	List<SelfEvaluation> getEvalLendgerPro(String tableName);
	
	/*
	 * 绩效评价详细信息查询
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	public List<Object> getMingxi(String tableName ,String idName ,Integer id);

	/*
	 * 附件信息查询根据mianid
	 * @author 冉德茂
	 * @createtime 2018-09-05
	 * @updatetime 2018-09-05
	 */
	public BudgetResultAttac getAttacByMainId(Integer id);
}
