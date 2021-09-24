package com.braker.icontrol.budget.manager.manager.impl;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.model.Depart;
import com.braker.core.model.User;
import com.braker.icontrol.budget.data.manager.AnalysisProBasicInfoMng;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexDetail;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.entity.TIndexReleasePlan;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.manager.manager.IndexReleasePlanMng;
import com.braker.icontrol.budget.manager.manager.TransmitMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.XmDept;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.budget.project.manager.XmDeptMng;
import com.braker.quartz.service.WsdocService;

/**
 * 指标下达的service实现类
 * @author 叶崇晖
 * @createtime 2018-10-08
 * @updatetime 2018-10-08
 */
@Service
@Transactional
public class TransmitMngImpl extends BaseManagerImpl<TBudgetIndexMgr> implements TransmitMng{
	@Autowired
	private TProBasicInfoMng tProBasicInfoMng;
	@Autowired
	private WsdocService wsdocService;
	@Autowired
	private IndexReleasePlanMng indexReleasePlanMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	@Autowired
	private TProExpendDetailMng tProExpendDetailMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	@Autowired
	private AnalysisProBasicInfoMng analysisProMng;
	@Autowired
	private XmDeptMng xmDeptMng;
	
	/*
	 * 指标分页查询
	 * @author 叶崇晖
	 * @createtime 2018-10-08
	 * @updatetime 2018-10-08
	 */
	@Override
	public Pagination pageList(TBudgetIndexMgr bean, String indexType, int pageNo, int pageSize, String orderColumn, String order, User user) {
		Finder finder = Finder.create(" FROM TBudgetIndexMgr WHERE 1=1 ");
		if (!StringUtil.isEmpty(indexType)) {
			finder.append("and indexType='" + indexType + "'");
		}
		if(!StringUtil.isEmpty(String.valueOf(bean.getXdjd1()))) {
			finder.append(" AND (xdAmount/pfAmount)>='"+bean.getXdjd1()+"'");
		}
		if(!StringUtil.isEmpty(String.valueOf(bean.getReleaseStauts()))) {
			finder.append(" AND releaseStauts = '"+bean.getReleaseStauts()+"'");
		}
		if(!StringUtil.isEmpty(String.valueOf(bean.getXdjd2()))) {
			finder.append(" AND (xdAmount/pfAmount)<='"+bean.getXdjd2()+"'");
		}	

		if (!StringUtil.isEmpty(bean.getYears())) {
			finder.append(" and years =:years").setParam("years", bean.getYears());
		}
		if (!StringUtil.isEmpty(bean.getIndexCode())) {
			finder.append(" and indexCode like:indexCode").setParam("indexCode", "%" + bean.getIndexCode() + "%");
		}
		if (!StringUtil.isEmpty(bean.getIndexName())) {
			finder.append(" and indexName like:indexName").setParam("indexName", "%" + bean.getIndexName() + "%");
		}
		if (!StringUtil.isEmpty(bean.getDeptName())) {
			finder.append(" and deptName like:deptName").setParam("deptName", "%" + bean.getDeptName() + "%");
		}
		finder.append(" AND stauts='1'");
		
		if (!StringUtil.isEmpty(orderColumn)) {
			finder.append(" order by  " + orderColumn);
		} else {
			finder.append(" order by appDate ");
		}
		if (!StringUtil.isEmpty(orderColumn)) {
			finder.append(" " + order);
		} else {
			finder.append(" desc ");
		}
		return super.find(finder, pageNo, pageSize);
	}


	/**
	 * 
	* @author:安达
	* @Title: saveIndex 
	* @Description: 指标下达
	* @param bId
	* @param user
	* @return void    返回类型 
	* @date： 2019年6月13日下午10:20:56 
	* @throws
	 */
	@Override
	public void saveIndex(Integer bId) {
		TBudgetIndexMgr newBean = super.findById(bId);
				
		newBean.setXdAmount(newBean.getPfAmount());//修改指标的下达金额
		newBean.setSyAmount(newBean.getPfAmount());//修改指标的剩余金额
		newBean.setFirstAmount(newBean.getPfAmount());
		newBean.setReleaseStauts("1");//指标状态改为已下达
		super.updateDefault(newBean);
		//默认使用部门为申报部门
		XmDept dept = new XmDept();
		dept.setFxmid(String.valueOf(newBean.getFProId()));
		dept.setFdeptid(newBean.getDeptCode());
		dept.setCreateTime(new Date());
		dept.setUpdateTime(new Date());
		xmDeptMng.saveOrUpdate(dept);
		String title=newBean.getIndexName()+"指标下达消息";
		String msg="您申请的  "+newBean.getIndexName()+"指标,指标编号：("+newBean.getIndexCode()+")已下达,请及时关注。";
		privateInforMng.setMsg(title, msg, newBean.getProCharger(),"2");
		
		//修改支出明细
		tProExpendDetailMng.transmitIndex(newBean.getFProId());
		if("1".equals(newBean.getIndexType())||"0".equals(newBean.getIndexType())){
			//为项目指标时需要修改项目的库类，由上报库到执行库
			TProBasicInfo proBean = tProBasicInfoMng.findById(Integer.valueOf(newBean.getFProId()));
			proBean.setFProLibType("3");
			super.merge(proBean);
			analysisProMng.copyProBasicInfo(proBean, 5);
		}
	}

	@Override
	public void ljxd(Integer id, User user) {
		/* 第一步查询到相应的下达计划修改计划的下达状态并保存  */
		TIndexReleasePlan plan = indexReleasePlanMng.findById(id);//根据传过来的pid查询计划
		if(!"1".equals(plan.getType())){//保证在定时器触发时页面若没有关闭，操作人又手动点击立即下达时不会重复下达
			plan.setType("1");//下达状态1、已执行
			indexReleasePlanMng.saveOrUpdate(plan);//修改计划的下达状态并保存
			
			/* 第二步查询相应的指标信息 修改指标的下达金额和剩余金额修改下达状态和下达方式 */
			TBudgetIndexMgr index = budgetIndexMgrMng.findByIndexCode(plan.getIndexCode());//根据指标编码查询指标
			
			DecimalFormat df = new DecimalFormat("0.000000");//保留6位小数
			
			BigDecimal releaseAmount=plan.getReleaseAmount();//获得计划下达的金额
			index.setXdAmount(index.getXdAmount().add(releaseAmount));//修改指标的下达金额
			index.setSyAmount(index.getSyAmount().add(releaseAmount));//修改指标的剩余金额
			index.setReleaseStauts("1");//指标状态改为已下达
			index.setReleaseType("3");//下达方式为3、定时自动下达
			budgetIndexMgrMng.saveOrUpdate(index);//保存指标的改动信息
			
			/* 第三步新建下达的流水信息  */
			TBudgetIndexDetail detailBean= new TBudgetIndexDetail();//建立新的指标下达流水信息
			detailBean.setbId(index.getbId());//下达明细设置关联预算指标管理的副键
			detailBean.setReleaseType("3");//下达方式为3、定时自动下达
			detailBean.setReleaseUser(user.getId());//写入下达人
			
			detailBean.setReleaseTime(new Date());//写入下达时间
			
			detailBean.setBcReleaseAmount(plan.getReleaseAmount());//本次下达金额=计划信息中的下达金额
			super.merge(detailBean);//保存流水信息
			
			/* 第四步删除定时任务  */
			if(!StringUtil.isEmpty(plan.getTriggerName())){
				wsdocService.deleteTargerByTriggerName(plan.getTriggerName());
			}
		}
	}
	
	
	/**
	 * 指标管理信息列表 的方法
	 * @param depart 部门
	 * @param tim 指标
	 * @param 
	 */
	@Override
	public Pagination indexMgrData1(Depart depart, String indexName, String year, int pageNo, int pageSize) {
		StringBuilder sb=new StringBuilder("SELECT * FROM T_BUDGET_INDEX_MGR WHERE 1=1 AND F_RELEASE_STAUTS='1'");
		sb.append(" AND F_YEARS='"+year+"'");
		sb.append(" AND F_STAUTS='1'"); //指标生成状态   0未生成 、1已生成
//		sb.append(" AND F_INDEX_TYPE='"+tim.getIndexType()+"'"); //条件 指标类型
		sb.append(" AND F_B_INDEX_NAME='"+indexName+"'"); // 条件 指标名字
		//验证权限
		if (depart != null) {
			String departType = depart.getType();
			if (Depart.TYPE_COM.equals(departType)) {
				//公司登录，获得所有子部门的
				sb.append(" AND F_DEPT_CODE IN (SELECT PID FROM SYS_DEPART WHERE PARENTID='" + depart.getId() + "' AND TYPE='" + Depart.TYPE_DEPT + "') ");
			} else if (Depart.TYPE_DEPT.equals(departType)) {
				//部门登录，获取所属公司下所有子部门的
				sb.append(" AND F_DEPT_CODE IN (SELECT PID FROM SYS_DEPART WHERE PARENTID='" + depart.getParent().getId() + "' AND TYPE='" + Depart.TYPE_DEPT + "') ");
			}
		}
		String str=sb.toString();
		Pagination p = super.findBySql(new TBudgetIndexMgr(), str, pageNo, pageSize);
		List<TBudgetIndexMgr> dataList = (List<TBudgetIndexMgr>) p.getList();
		if (dataList != null && dataList.size() > 0) {
			int i = 0;
			for (TBudgetIndexMgr log: dataList) {
				log.setNum(pageNo * pageSize + i - 9);
				i++;
			}
		}
		return p;
	}
	
	@Override
	public Pagination indexMgrData2(Depart depart, String indexType, String year, int pageNo, int pageSize,String searchIndexName, String searchIndexCode) {
		
		// TODO Auto-generated method stub
		StringBuilder sb=new StringBuilder("SELECT * FROM T_BUDGET_INDEX_MGR WHERE 1=1 AND F_RELEASE_STAUTS='1'");
		sb.append(" AND F_YEARS='"+year+"'");
		sb.append(" AND F_DEPT_NAME='"+depart.getName()+"'"); //按部门
		sb.append(" AND F_STAUTS='1'"); //指标生成状态   0未生成 、1已生成
		sb.append(" AND F_INDEX_TYPE='"+indexType+"'"); // 条件 指标类型
		if(searchIndexName!=null && searchIndexName.length()>0){
			sb.append(" AND F_B_INDEX_NAME LIKE ('%"+searchIndexName+"%')");
		}
		if(searchIndexCode!=null && searchIndexCode.length()>0){
			sb.append(" AND F_B_INDEX_CODE LIKE ('%"+searchIndexCode+"%')");
		}
		sb.append(" ORDER BY F_APP_DATE DESC");
		String str=sb.toString();
		Pagination p = super.findBySql(new TBudgetIndexMgr(), str, pageNo, pageSize);
		List<TBudgetIndexMgr> dataList = (List<TBudgetIndexMgr>) p.getList();
		if (dataList != null && dataList.size() > 0) {
			int i = 0;
			for (TBudgetIndexMgr log: dataList) {
				log.setNum(pageNo * pageSize + i - (pageSize-1));
				i++;
			}
		}
		return p;
	}
	
	
	/**
	 * 总预算    各类基本指标额度  数据列表	
	 * @author 焦广兴		
	 * @createtime 2019-03-?
	 * @updatetime 2019-03-28
	 */
	@Override
	public Pagination getData15(Depart depart, String year, String indexType, int pageNo, int pageSize,String searchIndexName, String searchDeptName) {
		StringBuilder sbf = new StringBuilder("SELECT * FROM T_BUDGET_INDEX_MGR WHERE 1=1 ");
		//验证权限
		if (depart != null) {
			String departType = depart.getType();
			if (Depart.TYPE_COM.equals(departType)) {
				//公司登录，获得所有子部门的
				sbf.append(" AND F_DEPT_CODE IN (SELECT PID FROM SYS_DEPART WHERE PARENTID='" + depart.getId() + "' AND TYPE='" + Depart.TYPE_DEPT + "') ");
			} else if (Depart.TYPE_DEPT.equals(departType)) {
				//部门登录，获取所属公司下所有子部门的
				sbf.append(" AND F_DEPT_CODE IN (SELECT PID FROM SYS_DEPART WHERE PARENTID='" + depart.getParent().getId() + "' AND TYPE='" + Depart.TYPE_DEPT + "') ");
			}
		}
		sbf.append(" AND F_RELEASE_STAUTS='1' ");
		sbf.append(" AND F_YEARS='" + year + "'");
		sbf.append(" AND F_INDEX_TYPE='" + indexType + "'");
		if(searchIndexName!=null && searchIndexName.length()>0){
			sbf.append(" AND F_B_INDEX_NAME LIKE ('%"+searchIndexName+"%')");
		}
		if(searchDeptName!=null && searchDeptName.length()>0){
			sbf.append(" AND F_DEPT_NAME LIKE ('%"+searchDeptName+"%')");
		}
		sbf.append(" ORDER BY F_APP_DATE DESC");
		
		String str=sbf.toString();
		Pagination p = super.findBySql(new TBudgetIndexMgr(), str, pageNo, pageSize);
		List<TBudgetIndexMgr> dataList = (List<TBudgetIndexMgr>) p.getList();
		if (dataList != null && dataList.size() > 0) {
			int i = 0;
			for (TBudgetIndexMgr log: dataList) {
				log.setNum(pageNo * pageSize + i - (pageSize-1));
				i++;
			}
		}
		return p;
	}
	
	/*
	 * 预算超额预警指标分页查询
	 * @author 沈帆
	 * @createtime 2019-4-29
	 * @updatetime 2019-4-29
	 */
	@Override
	public Pagination excesspageList(TBudgetIndexMgr bean, String indexType, int pageNo, int pageSize, String orderColumn, String order, User user) {
		Finder finder = Finder.create(" FROM TBudgetIndexMgr WHERE 1=1 AND ((F_PF_AMOUNT-F_DJ_AMOUNT-F_SY_AMOUNT)/F_PF_AMOUNT)>0.8");
		if (!StringUtil.isEmpty(indexType)) {
			finder.append("and indexType='" + indexType + "'");
		}
		if(!StringUtil.isEmpty(String.valueOf(bean.getXdjd1()))) {
			finder.append(" AND (xdAmount/pfAmount)>='"+bean.getXdjd1()+"'");
		}
		if(!StringUtil.isEmpty(String.valueOf(bean.getXdjd2()))) {
			finder.append(" AND (xdAmount/pfAmount)<='"+bean.getXdjd2()+"'");
		}	
		
		if (!StringUtil.isEmpty(bean.getYears())) {
			finder.append(" and years =:years").setParam("years", bean.getYears());
		}
		if (!StringUtil.isEmpty(bean.getIndexCode())) {
			finder.append(" and indexCode like:indexCode").setParam("indexCode", "%" + bean.getIndexCode() + "%");
		}
		if (!StringUtil.isEmpty(bean.getIndexName())) {
			finder.append(" and indexName like:indexName").setParam("indexName", "%" + bean.getIndexName() + "%");
		}
		if (!StringUtil.isEmpty(bean.getDeptName())) {
			finder.append(" and deptName like:deptName").setParam("deptName", "%" + bean.getDeptName() + "%");
		}
		finder.append(" AND stauts='1'");
		
		if (!StringUtil.isEmpty(orderColumn)) {
			finder.append(" order by  " + orderColumn);
		} else {
			finder.append(" order by indexType ");
		}
		if (!StringUtil.isEmpty(orderColumn)) {
			finder.append(" " + order);
		} else {
			finder.append(" desc ");
		}
		return super.find(finder, pageNo, pageSize);
	}
	
	/*
	 * 执行情况年报分页查询
	 * @author 沈帆
	 * @createtime 2019-7-11
	 * @updatetime 2019-7-11
	 */
	@Override
	public List<Object[]> groupByYear() {
		
		Finder finder = Finder.create(" select bId, years, sum(xdAmount-syAmount-djAmount) from TBudgetIndexMgr "
				+ " group by bId,years  ");
		return super.find(finder);
	}


	@Override
	public List<Object[]> departEconomicList(String currentYear, String[] secondLevelCode, User user) {
		//tpbi.F_EXPORT_STAUTS=1   已收报 ；0：未收报
		String sql=" select tpbi.F_PRO_APPLI_DEPART_ID as deptid,F_SUB_NUM as subnum,sum(tped.F_APPLI_AMOUNT) as amount "
				+ "from t_pro_basic_info tpbi left join t_pro_expend_detail tped on tped.F_PRO_ID=tpbi.F_PRO_ID where tpbi.F_EXPORT_STAUTS=1 and (tpbi.F_STAUTS<>99 or tpbi.F_STAUTS ='' or tpbi.F_STAUTS is null)";
		if(StringUtils.isNotEmpty(currentYear)){
			sql=sql+" and tpbi.F_START_YEAR_PLAN='"+currentYear+"' ";
		}
		if(secondLevelCode!=null && secondLevelCode.length>0){
			sql=sql+" and ( ";
			String conn="";
			for(String code:secondLevelCode){
				//基本支出
				if("XD-01".equals(code)){ 
					if("".equals(conn)){
						conn=" tpbi.F_LEV_CODE_1='"+code+"' ";
					}else{
						conn=conn+" or tpbi.F_LEV_CODE_1='"+code+"' ";
					}
				}else{
					//校内项目	财政项目	横向项目
					if("".equals(conn)){
						conn=" tpbi.F_LEV_CODE_2='"+code+"' ";
					}else{
						conn=conn+" or tpbi.F_LEV_CODE_2='"+code+"' ";
					}
				}
			}
			sql=sql+conn+")";
		}
		sql=sql+" group by tpbi.F_PRO_APPLI_DEPART_ID,tped.F_SUB_NUM  order by F_PRO_APPLI_DEPART_ID,F_SUB_NUM ";
		Query query = getSession().createSQLQuery(sql);
		List<Object[]> list = query.list();
		return list;
	}

	@Override
	public List<Object[]> departEconomicListByType(String currentYear, String[] secondLevelCode, User user, String analysisType,String dataType) {
		String sql=" select tpbi.F_PRO_APPLI_DEPART_ID as deptid,F_SUB_NUM as subnum,sum(tped.F_APPLI_AMOUNT) as amount ";
		if(dataType.equals("1")){
			sql=sql+ "from t_pro_basic_info tpbi left join t_pro_expend_detail tped on tped.F_PRO_ID=tpbi.F_PRO_ID where 1=1 and (tpbi.F_STAUTS<>99 or tpbi.F_STAUTS ='' or tpbi.F_STAUTS is null)";
		}else{
			sql=sql+ "from t_pro_basic_info_analysis tpbi left join t_pro_expend_detail_analysis tped on tped.F_PRO_ID=tpbi.F_PRO_ID where 1=1 and (tpbi.F_STAUTS<>99 or tpbi.F_STAUTS ='' or tpbi.F_STAUTS is null)";
		}
		if(StringUtils.isNotEmpty(currentYear)){
			sql=sql+" and tpbi.F_START_YEAR_PLAN='"+currentYear+"' ";
		}
		//报表分析时数据类型
		if (!StringUtils.isEmpty(analysisType)) {
			if(dataType.equals("1")){
				if(analysisType.equals("1")){
					sql=sql+" and  tpbi.F_FLOW_STAUTS ='11' ";
				}else if(analysisType.equals("3")){
					sql=sql+" and  tpbi.F_FLOW_STAUTS ='29' and tpbi.F_EXT_4 ='11' and tpbi.F_EXT_5 is null";
				}else if(analysisType.equals("3")){
					sql=sql+" and  tpbi.F_FLOW_STAUTS ='31' ";
				}else{
					sql=sql+" and  tpbi.F_FLOW_STAUTS ='39' and tpbi.F_PRO_ID in (select F_PRO_ID from T_BUDGET_INDEX_MGR where F_RELEASE_STAUTS ='0') ";
				}
			}else{
				sql=sql+" and tpbi.F_ANALYSIS_TYPE='"+analysisType+"' and tped.F_ANALYSIS_TYPE='" + analysisType + "' ";
			}
		}
		if(secondLevelCode!=null && secondLevelCode.length>0){
			sql=sql+" and ( ";
			String conn="";
			for(String code:secondLevelCode){
				//基本支出
				if("XD-01".equals(code)){ 
					if("".equals(conn)){
						conn=" tpbi.F_LEV_CODE_1='"+code+"' ";
					}else{
						conn=conn+" or tpbi.F_LEV_CODE_1='"+code+"' ";
					}
				}else{
					//校内项目	财政项目	横向项目
					if("".equals(conn)){
						conn=" tpbi.F_LEV_CODE_2='"+code+"' ";
					}else{
						conn=conn+" or tpbi.F_LEV_CODE_2='"+code+"' ";
					}
				}
			}
			sql=sql+conn+")";
		}
		sql=sql+" group by tpbi.F_PRO_APPLI_DEPART_ID,tped.F_SUB_NUM  order by F_PRO_APPLI_DEPART_ID,F_SUB_NUM ";
		Query query = getSession().createSQLQuery(sql);
		List<Object[]> list = query.list();
		return list;
	}
	
	@Override
	public List<Object[]> departEconomicAllList(String currentYear, String[] secondLevelCode, User user) {
		String sql=" select tpbi.F_PRO_APPLI_DEPART_ID as deptid,F_SUB_NUM as subnum,sum(tped.F_APPLI_AMOUNT) as amount,tpbi.F_ANALYSIS_TYPE AS analysisType "
				+ "from t_pro_basic_info_analysis tpbi left join t_pro_expend_detail_analysis tped on tped.F_PRO_ID=tpbi.F_PRO_ID where 1=1 and (tpbi.F_STAUTS<>99 or tpbi.F_STAUTS ='' or tpbi.F_STAUTS is null)";
		if(StringUtils.isNotEmpty(currentYear)){
			sql=sql+" and tpbi.F_START_YEAR_PLAN='"+currentYear+"' ";
		}
		if(secondLevelCode!=null && secondLevelCode.length>0){
			sql=sql+" and ( ";
			String conn="";
			for(String code:secondLevelCode){
				//基本支出
				if("XD-01".equals(code)){ 
					if("".equals(conn)){
						conn=" tpbi.F_LEV_CODE_1='"+code+"' ";
					}else{
						conn=conn+" or tpbi.F_LEV_CODE_1='"+code+"' ";
					}
				}else{
					//校内项目	财政项目	横向项目
					if("".equals(conn)){
						conn=" tpbi.F_LEV_CODE_2='"+code+"' ";
					}else{
						conn=conn+" or tpbi.F_LEV_CODE_2='"+code+"' ";
					}
				}
			}
			sql=sql+conn+")";
		}
		sql=sql+" group by tpbi.F_PRO_APPLI_DEPART_ID,tpbi.F_ANALYSIS_TYPE,tped.F_SUB_NUM  order by F_PRO_APPLI_DEPART_ID,F_SUB_NUM ";
		Query query = getSession().createSQLQuery(sql);
		List<Object[]> list = query.list();
		return list;
	}

	@Override
	public List<Object[]> firstStatementExecute(String currentYear, String appStartTime, String appEndTime, String[] secondLevelCode, User user) {
		//tbim.F_RELEASE_STAUTS=1 已下达
		String sql=" select tpbi.F_PRO_APPLI_DEPART_ID as deptid,F_SUB_NUM as subnum,sum(tped.F_XD_AMOUNT-tped.F_SY_AMOUNT-tped.F_DJ_AMOUNT) as amount, "
		+ "sum(tped.F_XD_AMOUNT) AS appli_amount "
		+ "from t_pro_basic_info tpbi left join t_pro_expend_detail tped on tped.F_PRO_ID=tpbi.F_PRO_ID left join t_budget_index_mgr tbim on tbim.F_PRO_ID=tpbi.F_PRO_ID"
		+ " where tbim.F_RELEASE_STAUTS=1 and (tpbi.F_STAUTS<>99 or tpbi.F_STAUTS ='' or tpbi.F_STAUTS is null) ";
		
		if(StringUtils.isNotEmpty(currentYear)){
			sql=sql+" and tpbi.F_START_YEAR_PLAN='"+currentYear+"' ";
		}
		//申请开始时间
		if(StringUtils.isNotEmpty(appStartTime)) {
			sql=sql+" and DATE_FORMAT(tpbi.F_PRO_APPLI_TIME,'%Y-%m-%d') >= '" + appStartTime + "' ";
		}
		//申请结束时间
		if(StringUtils.isNotEmpty(appEndTime)) {
			sql=sql+" and DATE_FORMAT(tpbi.F_PRO_APPLI_TIME,'%Y-%m-%d') <= '" + appEndTime + "' ";
		}
		
		if(secondLevelCode!=null && secondLevelCode.length>0){
			sql=sql+" and ( ";
			String conn="";
			for(String code:secondLevelCode){
				//基本支出
				if("XD-01".equals(code)){ 
					if("".equals(conn)){
						conn=" tpbi.F_LEV_CODE_1='"+code+"' ";
					}else{
						conn=conn+" or tpbi.F_LEV_CODE_1='"+code+"' ";
					}
				}else{
					//校内项目	财政项目	横向项目
					if("".equals(conn)){
						conn=" tpbi.F_LEV_CODE_2='"+code+"' ";
					}else{
						conn=conn+" or tpbi.F_LEV_CODE_2='"+code+"' ";
					}
				}
			}
			sql=sql+conn+")";
		}
		sql=sql+" group by tpbi.F_PRO_APPLI_DEPART_ID,tped.F_SUB_NUM  order by F_PRO_APPLI_DEPART_ID,F_SUB_NUM ";
		Query query = getSession().createSQLQuery(sql);
		List<Object[]> list = query.list();
		return list;
	}

	@Override
	public List<Object[]> basicExpendData(String currentYear, String dept, User user) {
		//select a.PROORBASIC as 'type',a.F_LEV_NAME_2,a.F_LEV_CODE_2,a.F_PRO_APPLI_DEPART,b.F_SUB_NUM as subnum ,sum(b.F_APPLI_AMOUNT) as amount from t_pro_basic_info a left join t_pro_expend_detail b on b.F_PRO_ID=a.F_PRO_ID where a.F_EXPORT_STAUTS=1 and (a.F_STAUTS<>99 or a.F_STAUTS ='' or a.F_STAUTS is null) group by a.F_LEV_CODE_2,b.F_SUB_NUM order by a.PROORBASIC,a.F_LEV_CODE_2,b.F_SUB_NUM 
		//select a.PROORBASIC,CONCAT_WS('/',a.F_LEV_CODE_2,a.F_LEV_NAME_2),a.F_LEV_CODE_2,a.F_PRO_APPLI_DEPART,b.F_SUB_NUM,sum(b.F_APPLI_AMOUNT) from t_pro_basic_info a left join t_pro_expend_detail b on b.F_PRO_ID=a.F_PRO_ID where a.F_EXPORT_STAUTS=1 and (a.F_STAUTS<>99 or a.F_STAUTS ='' or a.F_STAUTS is null) and a.F_LEV_CODE_2 in(2001,2002) group by b.F_SUB_NUM  order by a.PROORBASIC,a.F_LEV_CODE_2,b.F_SUB_NUM
		
		//基本支出数据sql
		StringBuilder sql=new StringBuilder("select a.PROORBASIC,a.F_LEV_NAME_2,a.F_LEV_CODE_2,group_concat(a.F_PRO_APPLI_DEPART),b.F_SUB_NUM as subnum ,"
				+ "sum(b.F_APPLI_AMOUNT) from t_pro_basic_info a left join t_pro_expend_detail b on b.F_PRO_ID=a.F_PRO_ID"
				+ " where a.PROORBASIC=0");
		if(StringUtils.isNotEmpty(currentYear)){
			sql.append(" and a.F_START_YEAR_PLAN='"+currentYear+"' ");
		}
		//部门
		if(!StringUtil.isEmpty(dept) && !dept.equals("-1")){
			sql.append(" and a.F_PRO_APPLI_DEPART_ID in("+dept+")");
		}
		//2001/公用经费，2002/设备购置
//		if(!StringUtil.isEmpty(ejCode)){
//			sql.append(" and a.F_LEV_CODE_2 in("+ejCode+")");
//		} 
		sql.append(" and a.F_EXPORT_STAUTS=1 and (a.F_STAUTS<>99 or a.F_STAUTS ='' or a.F_STAUTS is null)");
		sql.append(" group by a.F_LEV_CODE_2,b.F_SUB_NUM order by a.PROORBASIC,a.F_LEV_CODE_2,b.F_SUB_NUM ");
		Query query = getSession().createSQLQuery(sql.toString());
		List<Object[]> list = query.list();
		return list;
	}

	@Override
	public List<Object[]> basicExpendDataByType(String currentYear, String dept, User user, String analysisType, String dataType) {
		//基本支出数据sql
		StringBuilder sql=new StringBuilder("select a.PROORBASIC,a.F_LEV_NAME_2,a.F_LEV_CODE_2,group_concat(a.F_PRO_APPLI_DEPART),b.F_SUB_NUM as subnum ,sum(b.F_APPLI_AMOUNT)");
		if(dataType.equals("1")){
			sql.append( " from t_pro_basic_info a left join t_pro_expend_detail b on b.F_PRO_ID=a.F_PRO_ID"
					+ " where a.PROORBASIC=0");
		}else{
			sql.append( " from t_pro_basic_info_analysis a left join t_pro_expend_detail_analysis b on b.F_PRO_ID=a.F_PRO_ID"
					+ " where a.PROORBASIC=0");
		}
		if(StringUtils.isNotEmpty(currentYear)){
			sql.append(" and a.F_START_YEAR_PLAN='"+currentYear+"' ");
		}
		//报表分析时数据类型
		if (!StringUtils.isEmpty(analysisType)) {
			if(dataType.equals("1")){
				if(analysisType.equals("1")){
					sql.append(" and  a.F_FLOW_STAUTS ='11' ");
				}else if(analysisType.equals("3")){
					sql.append(" and  a.F_FLOW_STAUTS ='29' and a.F_EXT_4 ='11' and a.F_EXT_5 is null");
				}else if(analysisType.equals("3")){
					sql.append(" and  a.F_FLOW_STAUTS ='31' ");
				}else{
					sql.append(" and  a.F_FLOW_STAUTS ='39' and a.F_PRO_ID in (select F_PRO_ID from T_BUDGET_INDEX_MGR where F_RELEASE_STAUTS ='0') ");
				}
			}else{
				sql.append(" and a.F_ANALYSIS_TYPE='"+analysisType+"' and b.F_ANALYSIS_TYPE='" + analysisType + "' ");
			}
		}
		//部门
		if(!StringUtil.isEmpty(dept) && !dept.equals("-1")){
			sql.append(" and a.F_PRO_APPLI_DEPART_ID in("+dept+")");
		}
		//2001/公用经费，2002/设备购置
//		if(!StringUtil.isEmpty(ejCode)){
//			sql.append(" and a.F_LEV_CODE_2 in("+ejCode+")");
//		} 
		sql.append(" and (a.F_STAUTS<>99 or a.F_STAUTS ='' or a.F_STAUTS is null)");
		sql.append(" group by a.F_LEV_CODE_2,b.F_SUB_NUM order by a.PROORBASIC,a.F_LEV_CODE_2,b.F_SUB_NUM ");
		Query query = getSession().createSQLQuery(sql.toString());
		List<Object[]> list = query.list();
		return list;
	}

	@Override
	public List<Object[]> proExpendData(String currentYear, String dept, User user) {
		//项目支出数据sql
		StringBuilder xmSql=new StringBuilder("select a.PROORBASIC,a.F_PRO_NAME,a.F_LEV_CODE_2,a.F_PRO_APPLI_DEPART,b.F_SUB_NUM as subnum ,sum(b.F_APPLI_AMOUNT)"
				+ " from t_pro_basic_info a left join t_pro_expend_detail b on b.F_PRO_ID=a.F_PRO_ID"
				+ " where a.PROORBASIC=1 ");
		if(StringUtils.isNotEmpty(currentYear)){
			xmSql.append(" and a.F_START_YEAR_PLAN='"+currentYear+"' ");
		}
		//部门
		if(!StringUtil.isEmpty(dept) && !dept.equals("-1")){
			xmSql.append(" and a.F_PRO_APPLI_DEPART_ID in("+dept+")");
		}
		xmSql.append(" and a.F_EXPORT_STAUTS=1 and (a.F_STAUTS<>99 or a.F_STAUTS ='' or a.F_STAUTS is null)");
		xmSql.append(" GROUP BY F_PRO_NAME,b.F_SUB_NUM order by a.PROORBASIC,a.F_LEV_CODE_2,a.F_PRO_APPLI_DEPART,b.F_SUB_NUM");
		Query query2 = getSession().createSQLQuery(xmSql.toString());
		List<Object[]> list = query2.list();
		return list;
	}

	@Override
	public List<Object[]> proExpendDataByType(String currentYear, String dept, User user, String analysisType, String dataType) {
		//项目支出数据sql
		StringBuilder xmSql=new StringBuilder("select a.PROORBASIC,a.F_PRO_NAME,a.F_LEV_CODE_2,a.F_PRO_APPLI_DEPART,b.F_SUB_NUM as subnum ,sum(b.F_APPLI_AMOUNT),a.F_PRO_CODE ");
		if(dataType.equals("1")){
			xmSql.append( "from t_pro_basic_info a left join t_pro_expend_detail b on b.F_PRO_ID=a.F_PRO_ID"
					+ " where a.PROORBASIC=1 ");
		}else{
			xmSql.append( "from t_pro_basic_info_analysis a left join t_pro_expend_detail_analysis b on b.F_PRO_ID=a.F_PRO_ID"
					+ " where a.PROORBASIC=1 ");
		}
		if(StringUtils.isNotEmpty(currentYear)){
			xmSql.append(" and a.F_START_YEAR_PLAN='"+currentYear+"' ");
		}
		//报表分析时数据类型
		if (!StringUtils.isEmpty(analysisType)) {
			if(dataType.equals("1")){
				if(analysisType.equals("1")){
					xmSql.append(" and  a.F_FLOW_STAUTS ='11' ");
				}else if(analysisType.equals("3")){
					xmSql.append(" and  a.F_FLOW_STAUTS ='29' and a.F_EXT_4 ='11' and a.F_EXT_5 is null");
				}else if(analysisType.equals("3")){
					xmSql.append(" and  a.F_FLOW_STAUTS ='31' ");
				}else{
					xmSql.append(" and  a.F_FLOW_STAUTS ='39' and a.F_PRO_ID in (select F_PRO_ID from T_BUDGET_INDEX_MGR where F_RELEASE_STAUTS ='0') ");
				}
			}else{
				xmSql.append(" and a.F_ANALYSIS_TYPE='"+analysisType+"' and b.F_ANALYSIS_TYPE='" + analysisType + "' ");
			}
		}
		//部门
		if(!StringUtil.isEmpty(dept) && !dept.equals("-1")){
			xmSql.append(" and a.F_PRO_APPLI_DEPART_ID in("+dept+")");
		}
		xmSql.append(" and (a.F_STAUTS<>99 or a.F_STAUTS ='' or a.F_STAUTS is null)");
		xmSql.append(" GROUP BY a.F_PRO_CODE,b.F_SUB_NUM order by a.PROORBASIC,a.F_LEV_CODE_2,a.F_PRO_APPLI_DEPART,b.F_SUB_NUM");
		Query query2 = getSession().createSQLQuery(xmSql.toString());
		List<Object[]> list = query2.list();
		return list;
	}
	
	@Override
	public List<Object[]> proNameData(String currentYear, String dept, User user) {
		StringBuilder xmNameSql=new StringBuilder("select a.PROORBASIC,a.F_PRO_NAME,a.F_LEV_CODE_2,a.F_PRO_APPLI_DEPART"
				+ " from t_pro_basic_info a where a.PROORBASIC=1 ");
		if(StringUtils.isNotEmpty(currentYear)){
			xmNameSql.append(" and a.F_START_YEAR_PLAN='"+currentYear+"' ");
		}
		//部门
		if(!StringUtil.isEmpty(dept) && !dept.equals("-1")){
			xmNameSql.append(" and a.F_PRO_APPLI_DEPART_ID in("+dept+")");
		}
		xmNameSql.append(" and a.F_EXPORT_STAUTS=1 and (a.F_STAUTS<>99 or a.F_STAUTS ='' or a.F_STAUTS is null)");
		xmNameSql.append(" group by a.F_PRO_NAME order by a.PROORBASIC,a.F_LEV_CODE_2,a.F_PRO_APPLI_DEPART");
		Query query = getSession().createSQLQuery(xmNameSql.toString());
		List<Object[]> list = query.list();
		return list;
	}

	@Override
	public List<Object[]> proNameDataByType(String currentYear, String dept, User user, String analysisType, String dataType) {
		StringBuilder xmNameSql=new StringBuilder("select a.PROORBASIC,a.F_PRO_NAME,a.F_LEV_CODE_2,a.F_PRO_APPLI_DEPART,a.F_PRO_CODE");
		if(dataType.equals("1")){
			xmNameSql.append( " from t_pro_basic_info a where a.PROORBASIC=1 ");
		}else{
			xmNameSql.append( " from t_pro_basic_info_analysis a where a.PROORBASIC=1 ");
		}
		if(StringUtils.isNotEmpty(currentYear)){
			xmNameSql.append(" and a.F_START_YEAR_PLAN='"+currentYear+"' ");
		}
		//报表分析时数据类型
		if (!StringUtils.isEmpty(analysisType)) {
			if(dataType.equals("1")){
				if(analysisType.equals("1")){
					xmNameSql.append(" and  a.F_FLOW_STAUTS ='11' ");
				}else if(analysisType.equals("3")){
					xmNameSql.append(" and  a.F_FLOW_STAUTS ='29' and a.F_EXT_4 ='11' and a.F_EXT_5 is null");
				}else if(analysisType.equals("3")){
					xmNameSql.append(" and  a.F_FLOW_STAUTS ='31' ");
				}else{
					xmNameSql.append(" and  a.F_FLOW_STAUTS ='39' and a.F_PRO_ID in (select F_PRO_ID from T_BUDGET_INDEX_MGR where F_RELEASE_STAUTS ='0') ");
				}
			}else{
				xmNameSql.append(" and a.F_ANALYSIS_TYPE='"+analysisType+"' ");
			}
		}
		//部门
		if(!StringUtil.isEmpty(dept) && !dept.equals("-1")){
			xmNameSql.append(" and a.F_PRO_APPLI_DEPART_ID in("+dept+")");
		}
		xmNameSql.append(" and (a.F_STAUTS<>99 or a.F_STAUTS ='' or a.F_STAUTS is null)");
		xmNameSql.append(" group by a.F_PRO_CODE order by a.PROORBASIC,a.F_LEV_CODE_2,a.F_PRO_APPLI_DEPART");
		Query query = getSession().createSQLQuery(xmNameSql.toString());
		List<Object[]> list = query.list();
		return list;
	}

	@Override
	public List<Object[]> deptNameData(String currentYear, String dept, User user) {
		StringBuilder sql=new StringBuilder("select c.PROORBASIC,c.F_LEV_NAME_2,c.F_LEV_CODE_2,group_concat(c.F_PRO_APPLI_DEPART) from"
				+ " (select a.PROORBASIC,a.F_LEV_NAME_2,a.F_LEV_CODE_2,a.F_PRO_APPLI_DEPART from t_pro_basic_info a where a.PROORBASIC=0");
		if(StringUtils.isNotEmpty(currentYear)){
			sql.append(" and a.F_START_YEAR_PLAN='"+currentYear+"' ");
		}
		//部门
		if(!StringUtil.isEmpty(dept) && !dept.equals("-1")){
			sql.append(" and a.F_PRO_APPLI_DEPART_ID in("+dept+")");
		}
		sql.append(" and a.F_EXPORT_STAUTS=1 and (a.F_STAUTS<>99 or a.F_STAUTS ='' or a.F_STAUTS is null)");
		sql.append(" group by a.F_LEV_CODE_2,a.F_PRO_APPLI_DEPART order by a.PROORBASIC,a.F_LEV_CODE_2)");
		sql.append(" as c group by c.F_LEV_CODE_2 order by c.PROORBASIC,c.F_LEV_CODE_2");
		Query query = getSession().createSQLQuery(sql.toString());
		List<Object[]> list = query.list();
		return list;
	}

	@Override
	public List<Object[]> deptNameDataByType(String currentYear, String dept, User user, String analysisType, String dataType) {
		StringBuilder sql=new StringBuilder("select c.PROORBASIC,c.F_LEV_NAME_2,c.F_LEV_CODE_2,group_concat(c.F_PRO_APPLI_DEPART),F_PRO_CODE from");
		if(dataType.equals("1")){
			sql.append( " (select a.PROORBASIC,a.F_LEV_NAME_2,a.F_LEV_CODE_2,a.F_PRO_APPLI_DEPART,a.F_PRO_CODE from t_pro_basic_info a where a.PROORBASIC=0");
		}else{
			
			sql.append( " (select a.PROORBASIC,a.F_LEV_NAME_2,a.F_LEV_CODE_2,a.F_PRO_APPLI_DEPART,a.F_PRO_CODE from t_pro_basic_info_analysis a where a.PROORBASIC=0");
			
		}
		if(StringUtils.isNotEmpty(currentYear)){
			sql.append(" and a.F_START_YEAR_PLAN='"+currentYear+"' ");
		}
		//报表分析时数据类型
		if (!StringUtils.isEmpty(analysisType)) {
			if(dataType.equals("1")){
				if(analysisType.equals("1")){
					sql.append(" and  a.F_FLOW_STAUTS ='11' ");
				}else if(analysisType.equals("3")){
					sql.append(" and  a.F_FLOW_STAUTS ='29' and a.F_EXT_4 ='11' and a.F_EXT_5 is null");
				}else if(analysisType.equals("3")){
					sql.append(" and  a.F_FLOW_STAUTS ='31' ");
				}else{
					sql.append(" and  a.F_FLOW_STAUTS ='39' and a.F_PRO_ID in (select F_PRO_ID from T_BUDGET_INDEX_MGR where F_RELEASE_STAUTS ='0') ");
				}
			}else{
				sql.append(" and a.F_ANALYSIS_TYPE='"+analysisType+"'  ");
			}
		}
		//部门
		if(!StringUtil.isEmpty(dept) && !dept.equals("-1")){
			sql.append(" and a.F_PRO_APPLI_DEPART_ID in("+dept+")");
		}
		sql.append(" and (a.F_STAUTS<>99 or a.F_STAUTS ='' or a.F_STAUTS is null)");
		sql.append(" group by a.F_LEV_CODE_2,a.F_PRO_APPLI_DEPART order by a.PROORBASIC,a.F_LEV_CODE_2)");
		sql.append(" as c group by c.F_LEV_CODE_2 order by c.PROORBASIC,c.F_LEV_CODE_2");
		Query query = getSession().createSQLQuery(sql.toString());
		List<Object[]> list = query.list();
		return list;
	}

	@Override
	public List<Object[]> basicExpendDataExecute(String currentYear, String dept, User user, String appStartTime, String appEndTime) {
		//基本支出数据sql
		StringBuilder sql=new StringBuilder("select a.PROORBASIC,a.F_LEV_NAME_2,a.F_LEV_CODE_2,group_concat(a.F_PRO_APPLI_DEPART),b.F_SUB_NUM as subnum ,"
				+ "sum(b.F_XD_AMOUNT-b.F_SY_AMOUNT-b.F_DJ_AMOUNT), sum(b.F_XD_AMOUNT) from t_pro_basic_info a left join t_pro_expend_detail b on b.F_PRO_ID=a.F_PRO_ID"
				+ " left join t_budget_index_mgr c on c.F_PRO_ID=a.F_PRO_ID where a.PROORBASIC=0");
		if(StringUtils.isNotEmpty(currentYear)){
			sql.append(" and a.F_START_YEAR_PLAN='"+currentYear+"' ");
		}
		//申请开始时间
		if(StringUtils.isNotEmpty(appStartTime)) {
			sql.append(" and DATE_FORMAT(a.F_PRO_APPLI_TIME,'%Y-%m-%d') >= '" + appStartTime + "' ");
		}
		//申请结束时间
		if(StringUtils.isNotEmpty(appEndTime)) {
			sql.append(" and DATE_FORMAT(a.F_PRO_APPLI_TIME,'%Y-%m-%d') <= '" + appEndTime + "' ");
		}
		//部门
		if(!StringUtil.isEmpty(dept) && !dept.equals("-1")){
			sql.append(" and a.F_PRO_APPLI_DEPART_ID in("+dept+")");
		}
		sql.append(" and c.F_RELEASE_STAUTS=1 and (a.F_STAUTS<>99 or a.F_STAUTS ='' or a.F_STAUTS is null)");
		sql.append(" group by a.F_LEV_CODE_2,b.F_SUB_NUM order by a.PROORBASIC,a.F_LEV_CODE_2,b.F_SUB_NUM ");
		Query query = getSession().createSQLQuery(sql.toString());
		List<Object[]> list = query.list();
		return list;
	}


	@Override
	public List<Object[]> proExpendDataExecute(String currentYear, String dept, User user, String appStartTime, String appEndTime) {
		//项目支出数据sql
		StringBuilder xmSql=new StringBuilder("select a.PROORBASIC,a.F_PRO_NAME,a.F_LEV_CODE_2,a.F_PRO_APPLI_DEPART,b.F_SUB_NUM as subnum ,(b.F_XD_AMOUNT-b.F_SY_AMOUNT-b.F_DJ_AMOUNT),"
				+ " (b.F_XD_AMOUNT) from t_pro_basic_info a left join t_pro_expend_detail b on b.F_PRO_ID=a.F_PRO_ID"
				+ " left join t_budget_index_mgr c on c.F_PRO_ID=a.F_PRO_ID where a.PROORBASIC=1 ");
		if(StringUtils.isNotEmpty(currentYear)){
			xmSql.append(" and a.F_START_YEAR_PLAN='"+currentYear+"' ");
		}
		//申请开始时间
		if(StringUtils.isNotEmpty(appStartTime)) {
			xmSql.append(" and DATE_FORMAT(a.F_PRO_APPLI_TIME,'%Y-%m-%d') >= '" + appStartTime + "' ");
		}
		//申请结束时间
		if(StringUtils.isNotEmpty(appEndTime)) {
			xmSql.append(" and DATE_FORMAT(a.F_PRO_APPLI_TIME,'%Y-%m-%d') <= '" + appEndTime + "' ");
		}
		//部门
		if(!StringUtil.isEmpty(dept) && !dept.equals("-1")){
			xmSql.append(" and a.F_PRO_APPLI_DEPART_ID in("+dept+")");
		}
		xmSql.append(" and c.F_RELEASE_STAUTS=1 and (a.F_STAUTS<>99 or a.F_STAUTS ='' or a.F_STAUTS is null)");
		xmSql.append(" order by a.PROORBASIC,a.F_LEV_CODE_2,a.F_PRO_APPLI_DEPART,b.F_SUB_NUM");
		Query query2 = getSession().createSQLQuery(xmSql.toString());
		List<Object[]> list = query2.list();
		return list;
	}


	@Override
	public List<Object[]> proNameDataExecute(String currentYear, String dept, User user, String appStartTime, String appEndTime) {
		StringBuilder xmNameSql=new StringBuilder("select a.PROORBASIC,a.F_PRO_NAME,a.F_LEV_CODE_2,a.F_PRO_APPLI_DEPART"
				+ " from t_pro_basic_info a left join t_budget_index_mgr c on c.F_PRO_ID=a.F_PRO_ID where a.PROORBASIC=1 ");
		if(StringUtils.isNotEmpty(currentYear)){
			xmNameSql.append(" and a.F_START_YEAR_PLAN='"+currentYear+"' ");
		}
		//申请开始时间
		if(StringUtils.isNotEmpty(appStartTime)) {
			xmNameSql.append(" and DATE_FORMAT(a.F_PRO_APPLI_TIME,'%Y-%m-%d') >= '" + appStartTime + "' ");
		}
		//申请结束时间
		if(StringUtils.isNotEmpty(appEndTime)) {
			xmNameSql.append(" and DATE_FORMAT(a.F_PRO_APPLI_TIME,'%Y-%m-%d') <= '" + appEndTime + "' ");
		}
		//部门
		if(!StringUtil.isEmpty(dept) && !dept.equals("-1")){
			xmNameSql.append(" and a.F_PRO_APPLI_DEPART_ID in("+dept+")");
		}
		xmNameSql.append(" and c.F_RELEASE_STAUTS=1 and (a.F_STAUTS<>99 or a.F_STAUTS ='' or a.F_STAUTS is null)");
		xmNameSql.append(" group by a.F_PRO_NAME order by a.PROORBASIC,a.F_LEV_CODE_2,a.F_PRO_APPLI_DEPART");
		Query query = getSession().createSQLQuery(xmNameSql.toString());
		List<Object[]> list = query.list();
		return list;
	}


	@Override
	public List<Object[]> deptNameDataExecute(String currentYear, String dept, User user, String appStartTime, String appEndTime) {
		StringBuilder sql=new StringBuilder("select c.PROORBASIC,c.F_LEV_NAME_2,c.F_LEV_CODE_2,group_concat(c.F_PRO_APPLI_DEPART) from"
				+ " (select a.PROORBASIC,a.F_LEV_NAME_2,a.F_LEV_CODE_2,a.F_PRO_APPLI_DEPART from t_pro_basic_info a left join t_budget_index_mgr d on d.F_PRO_ID=a.F_PRO_ID where a.PROORBASIC=0");
		if(StringUtils.isNotEmpty(currentYear)){
			sql.append(" and a.F_START_YEAR_PLAN='"+currentYear+"' ");
		}
		//申请开始时间
		if(StringUtils.isNotEmpty(appStartTime)) {
			sql.append(" and DATE_FORMAT(a.F_PRO_APPLI_TIME,'%Y-%m-%d') >= '" + appStartTime + "' ");
		}
		//申请结束时间
		if(StringUtils.isNotEmpty(appEndTime)) {
			sql.append(" and DATE_FORMAT(a.F_PRO_APPLI_TIME,'%Y-%m-%d') <= '" + appEndTime + "' ");
		}
		//部门
		if(!StringUtil.isEmpty(dept) && !dept.equals("-1")){
			sql.append(" and a.F_PRO_APPLI_DEPART_ID in("+dept+")");
		}
		sql.append(" and d.F_RELEASE_STAUTS=1 and (a.F_STAUTS<>99 or a.F_STAUTS ='' or a.F_STAUTS is null)");
		sql.append(" group by a.F_LEV_CODE_2,a.F_PRO_APPLI_DEPART order by a.PROORBASIC,a.F_LEV_CODE_2)");
		sql.append(" as c group by c.F_LEV_CODE_2 order by c.PROORBASIC,c.F_LEV_CODE_2");
		Query query = getSession().createSQLQuery(sql.toString());
		List<Object[]> list = query.list();
		return list;
	}
}
