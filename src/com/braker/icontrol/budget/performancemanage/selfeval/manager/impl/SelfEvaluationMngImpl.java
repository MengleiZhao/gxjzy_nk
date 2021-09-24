package com.braker.icontrol.budget.performancemanage.selfeval.manager.impl;

import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.budget.performancemanage.selfeval.manager.SelfEvaluationMng;
import com.braker.icontrol.budget.performancemanage.selfeval.model.BudgetResultAttac;
import com.braker.icontrol.budget.performancemanage.selfeval.model.SelfEvaluation;
import com.braker.icontrol.budget.performancemanage.selfrule.model.SelfProRef;
import com.braker.icontrol.budget.project.entity.TActFinishTarget;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProGoalDetail;
import com.braker.icontrol.budget.project.entity.TProPlan;
import com.braker.icontrol.budget.project.manager.TActFinishTargetMng;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProGoalDetailMng;
import com.braker.zzww.comm.manager.AttachmentMng;


/**
 *自评表和自评项目列表的service实现类
 * @author 冉德茂
 * @createtime 2018-08-29
 * @updatetime 2018-08-29
 */
@Service
@Transactional
public class SelfEvaluationMngImpl extends BaseManagerImpl<SelfEvaluation> implements SelfEvaluationMng {
	@Autowired
	private SelfEvaluationMng selfEvaluationMng;
	@Autowired
	private TProGoalDetailMng tproGoalDetailMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private TActFinishTargetMng tActFinishTargetMng;
	@Autowired
	private TProBasicInfoMng projectMng;
	/*
	 * 绩效监控查询自评项目表的信息    展示信息为1的数据
	 * @author 冉德茂
	 * @createtime 2018-08-30
	 * @updatetime 2018-08-30
	 */
	@Override
	public Pagination monitorpageList(TProPlan bean, int pageNo, int pageSize) {

		// 查询自评项目表获取所有的项目id  展示已经启用的数据   自评一年一次 每次只有一个规则  不存在重复数据
		List<SelfEvaluation> evalprolist = getMonitorPro("SelfEvaluation");
		String proids = "";
		// 获取所有的自评项目的id
		for (int i = 0; i < evalprolist.size(); i++) {
			SelfEvaluation evalbean = (SelfEvaluation) evalprolist.get(i);
			proids += evalbean.getFproId() + ",";
		}
		// 去掉最后一个id后面的，
		proids = proids.substring(0, proids.length() - 1);
		Finder finder = Finder.create(" from TProPlan where FProId.FProId in ("+ proids + ") ");
//		if (!StringUtil.isEmpty(bean.getProName())) {//项目名称
//			finder.append(" and FProId.FProName = :proName");
//			finder.setParam("proName", bean.getProName());
//		}
//		if (!StringUtil.isEmpty(bean.getProCode())) {//项目名称
//			finder.append(" and FProId.FProCode = :proCode");
//			finder.setParam("proCode", bean.getProCode());
//		}
//		if (!StringUtil.isEmpty(bean.getFPlanName())) {//计划名称（所处阶段）
//			finder.append(" and FPlanName = :FPlanName");
//			finder.setParam("FPlanName", bean.getFPlanName());
//		}
//		if (!StringUtil.isEmpty(String.valueOf(bean.getFPlanDateStart()))) {//项目开始时间
//			finder.append(" and datediff(FPlanDateStart,'"+bean.getFPlanDateStart()+"')=0 ");//日期模糊查询
//			//finder.append(" and FPlanDateStart = :FPlanDateStart");
//			//finder.setParam("FPlanDateStart", bean.getFPlanDateStart());
//		}
		
		/*Finder f = Finder.create(" from TProPlan");
		List<TProPlan> list = super.find(f)
		TProPlan plan = list.get(0);
		plan.getFProId();*/
		return super.find(finder, pageNo, pageSize);
	}
	/**
	 * 保存预算自评  绩效自评信息
	 */
	@Override
	public void save(TProBasicInfo bean,String jxzpFiles,User user) {
		bean =projectMng.findById(bean.getFProId());
		bean.setFExt7("1");
		projectMng.updateDefault(bean);
		//保存附件信息
		attachmentMng.joinEntity(bean,jxzpFiles);
		
	}
	
	/*
	 * 获取绩效自评明细的Json对象
	 * @author 冉德茂
	 * @createtime 2018-08-31
	 * @updatetime 2018-08-91
	 */
	public List getMingXiJson(String mingxi, Class tableClass) {
		//获取明细的Json对象
		List mx = null;
		JSONArray array =JSONArray.fromObject(mingxi.toString());
		mx = (List)JSONArray.toList(array, tableClass);
		return mx;
	}
	/*
	 * 预算评价附件信息查询
	 * @author 冉德茂
	 * @createtime 2018-08-31
	 * @updatetime 2018-08-31
	 */
	@Override
	public List<BudgetResultAttac> getAttac(Integer id) {
		Finder finder = Finder.create(" FROM BudgetResultAttac WHERE fproId='"+id+"'");
		return super.find(finder);
	}

	
	/**
	 *  绩效自评
	 */
	@Override
	public Pagination pageList(TProBasicInfo bean, int pageNo, int pageSize) {
		//  FProLibType=4 已完结    FExt7 !=1  未自评
		Finder finder = Finder.create(" from TProBasicInfo where FProLibType=4   ");
		if(StringUtils.isNotEmpty(bean.getFExt7())){
			if("1".equals(bean.getFExt7())){  //已经自评
				finder.append(" and   FExt7 ='1' ");
			}else{
				finder.append(" and  (FExt7 IS NULL OR FExt7!='1') ");  //未自评
			}
		}
		if (!StringUtil.isEmpty(bean.getFProCode()) ) {//项目编号
			finder.append(" and FProCode LIKE :FProCode");
			finder.setParam("FProCode", "%"+bean.getFProCode()+"%");
		}
		if (!StringUtil.isEmpty(bean.getFProName())) {//项目名称
			finder.append(" and FProName LIKE :FProName");
			finder.setParam("FProName", "%"+bean.getFProName()+"%");
		}

		return super.find(finder, pageNo, pageSize);
	}
	
	
	
	/*
	 * 根据fcid查询映射信息
	 * @author 冉德茂
	 * @createtime 2018-08-20
	 * @updatetime 2018-08-20
	 */
	@Override
	public List<SelfEvaluation> getEvaluation(Integer id) {
		Finder finder = Finder.create(" FROM SelfEvaluation WHERE fcId='"+id+"'");
		return super.find(finder);
	}
	

	/*
	 * 修改页面加载已经规避的项目清单信息
	 * @author 冉德茂
	 * @createtime 2018-08-29
	 * @updatetime 2018-08-29
	 */
	@Override
	public List<TProBasicInfo> getoldgblist(Integer id) {
		//通过id获取所有的项目表id
		List<Object> evalprolist= getMingxi("SelfProRef", "fcId", id);
		String proids = "";
    	//获取所有的自评项目的id
		for(int i=0;i<evalprolist.size();i++){
			SelfProRef bean = (SelfProRef) evalprolist.get(i);
			proids +=bean.getFproId()+",";
		}
		//去掉最后一个id后面的，
		proids = proids.substring(0,proids.length()-1);
		Finder finder = Finder.create(" from TProBasicInfo where FProId in ("+proids+") ");
		return super.find(finder);
	}
	/*
	 * 修改页面加载生成的自评项目的信息
	 * @author 冉德茂
	 * @createtime 2018-08-29
	 * @updatetime 2018-08-29
	 */
	@Override
	public List<TProBasicInfo> getoldeval(Integer id) {
		//通过id获取所有的项目表id
		List<Object> evalprolist= getMingxi("SelfEvaluation", "fcId", id);
		String proids = "";
		//获取所有的自评项目的id
		for(int i=0;i<evalprolist.size();i++){
			SelfEvaluation bean = (SelfEvaluation) evalprolist.get(i);
			proids +=bean.getFproId()+",";
		}
		//去掉最后一个id后面的，
		proids = proids.substring(0,proids.length()-1);
		Finder finder = Finder.create(" from TProBasicInfo where FProId in ("+proids+") ");
		return super.find(finder);
	}
	/*
	 *查询
	 * @author 冉德茂
	 * @createtime 2018-08-29
	 * @updatetime 2018-08-29
	 */
	public List<Object> getMingxi(String tableName ,String idName ,Integer pid) {
		Finder finder = Finder.create(" FROM " + tableName + " WHERE " + idName + "="+pid);
		return super.find(finder);
	}

	/*
	 * 查询自评项目表的信息    展示显示信息为1自评状态为0的数据
	 * @author 冉德茂
	 * @createtime 2018-08-30
	 * @updatetime 2018-08-30
	 */
	@Override
	public List<SelfEvaluation> getEvalPro(String tableName) {
		Finder finder = Finder.create(" FROM " + tableName + " WHERE fisShow='1'  AND fisEval='0' " );
		return super.find(finder);
	}
	/*
	 * 查询监控信息信息    展示显示信息为1的数据
	 * @author 冉德茂
	 * @createtime 2018-08-30
	 * @updatetime 2018-08-30
	 */
	@Override
	public List<SelfEvaluation> getMonitorPro(String tableName) {
		Finder finder = Finder.create(" FROM " + tableName + " WHERE fisShow='1'" );
		return super.find(finder);
	}
	/*
	 * 预算评价附件信息查询根据附件名称
	 * @author 冉德茂
	 * @createtime 2018-08-30
	 * @updatetime 2018-08-30
	 */
	@Override
	public List<BudgetResultAttac> getAttacByName(String filename) {
		Finder finder = Finder.create(" FROM BudgetResultAttac WHERE attacName='"+filename+"'");
		return super.find(finder);
	}
	/*
	 * 预算评价附件信息删除
	 * @author 冉德茂
	 * @createtime 2018-08-30
	 * @updatetime 2018-08-30
	 */
	@Override
	public void deleteAttac(List<BudgetResultAttac> li) {
		for (int i = 0; i < li.size(); i++) {
			super.delete(li.get(i));
		}
	}

	/*
	 * 通过fpoid查询自评表  更改自评状态
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	@Override
	public List<SelfEvaluation> getSelfEvalbypid(Integer id) {
		Finder finder = Finder.create(" FROM SelfEvaluation WHERE fproId="+id+" ");
		return super.find(finder);
	}
	/*
	 * 附件信息查询根据bid
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	@Override
	public List<BudgetResultAttac> getAttacbyid(Integer id) {
		Finder finder = Finder.create(" FROM BudgetResultAttac WHERE fproId='"+id+"'");
		return super.find(finder);
	}








}	
	


























	

	



