package com.braker.icontrol.budget.performancemanage.selfeval.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.budget.performancemanage.selfeval.model.BudgetResultAttac;
import com.braker.icontrol.budget.performancemanage.selfeval.model.SelfEvaluation;
import com.braker.icontrol.budget.project.entity.TActFinishTarget;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProPlan;


/**
 * 自评规则表和自评项目表
 * @author 冉德茂
 * @createtime 2018-08-29
 * @updatetime 2018-08-29
 */
public interface SelfEvaluationMng extends BaseManager<SelfEvaluation>{

	
	/*
	 * 项目自评的保存    包括预算评价和绩效评价
	 * @author 冉德茂
	 * @createtime 2018-08-31
	 * @updatetime 2018-08-31
	 */
	public void save(TProBasicInfo bean,String jxzpFiles,User user);
	
	/*
	 * 根据fcid查询映射信息
	 * @author 冉德茂
	 * @createtime 2018-08-20
	 * @updatetime 2018-08-20
	 */
	public List<SelfEvaluation> getEvaluation(Integer id);
	
	/*
	 * 修改页面加载已经规避的项目清单信息
	 * @author 冉德茂
	 * @createtime 2018-08-29
	 * @updatetime 2018-08-29
	 */
	public List<TProBasicInfo> getoldgblist(Integer id);
	/*
	 * 修改页面加载上次生成的项目清单信息
	 * @author 冉德茂
	 * @createtime 2018-08-29
	 * @updatetime 2018-08-29
	 */
	public List<TProBasicInfo> getoldeval(Integer id);
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-08-30
	 * @updatetime 2018-08-30
	 */
	public Pagination pageList(TProBasicInfo bean, int pageNo, int pageSize);
	/*
	 * 分页查询监控信息    自评项目的展示状态为1的数据
	 * @author 冉德茂
	 * @createtime 2018-08-30
	 * @updatetime 2018-08-30
	 */
	public Pagination monitorpageList(TProPlan bean, int pageNo, int pageSize);
	/*
	 * 绩效监控查询自评项目表的信息    展示信息为1的数据
	 * @author 冉德茂
	 * @createtime 2018-08-30
	 * @updatetime 2018-08-30
	 */
	List<SelfEvaluation> getEvalPro(String tableName);
	/*
	 * 查询监控信息信息    展示显示信息为1的数据
	 * @author 冉德茂
	 * @createtime 2018-08-30
	 * @updatetime 2018-08-30
	 */
	List<SelfEvaluation> getMonitorPro(String tableName);
	/*
	 * 预算评价附件信息查询根据附件名称
	 * @author 冉德茂
	 * @createtime 2018-08-30
	 * @updatetime 2018-08-30
	 */
	public List<BudgetResultAttac> getAttacByName(String filename);
	
	/*
	 * 附件信息查询根据pid
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	public List<BudgetResultAttac> getAttacbyid(Integer id);
	
	
	/*
	 * 预算评价附件信息删除
	 * @author 冉德茂
	 * @createtime 2018-08-30
	 * @updatetime 2018-08-30
	 */
	public void deleteAttac(List<BudgetResultAttac> li);
	
	/*
	 * 预算附件信息查询
	 * @author 冉德茂
	 * @createtime 2018-08-31
	 * @updatetime 2018-08-31
	 */
	public List<BudgetResultAttac> getAttac(Integer id);

	/*
	 * 通过fpoid查询自评表  更改自评状态
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	public List<SelfEvaluation> getSelfEvalbypid(Integer id);

	
}
