package com.braker.icontrol.budget.declare.manager.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.JpushClientUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.budget.declare.manager.DeclareMng;
import com.braker.icontrol.budget.project.entity.PerformanceIndicatorModel;
import com.braker.icontrol.budget.project.entity.TGovernmentPurchaseDetail;
import com.braker.icontrol.budget.project.entity.TProBasicFunds;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.entity.TPurchaseManyYearsPro;
import com.braker.icontrol.budget.project.manager.TProBasicFundsMng;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.budget.project.manager.TProGoalDetailMng;
import com.braker.icontrol.budget.project.manager.TProGoalMng;
import com.braker.icontrol.budget.project.manager.TProPlanMng;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 上报库的service实现类
 * @author 叶崇晖
 * @createtime 2018-09-20
 * @updatetime 2018-09-20
 */
@Service
@Transactional
public class DeclareMngImpl extends BaseManagerImpl<TProBasicInfo> implements DeclareMng {
	
	@Autowired
	private TProGoalMng tProGoalMng;
	@Autowired
	private TProExpendDetailMng tProExpendDetailMng;
	@Autowired
	private TProPlanMng tProPlanMng;
	@Autowired
	private UserMng userMng ;
	@Autowired
	private TProGoalDetailMng tProGoalDetailMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private TNodeDataMng tNodeDataMng;
	
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private TProBasicFundsMng tProBasicFundsMng;
	
	@Autowired
	private PrivateInforMng privateInforMng;
	
	/*
	 * 一上申报列表数据查询
	 * @author 叶崇晖
	 * @createtime 2018-09-21
	 * @updatetime 2018-09-21
	 */
	@Override
	public List<TProBasicInfo> yssbPageList(TProBasicInfo bean, int pageNo, int pageSize, User user) {
		Finder finder = Finder.create(" from TProBasicInfo where (FExt1 IS NULL OR FExt1!='0') ");
		finder.append(" and FProLibType='2' and FFlowStauts in('19','21','29','-21') and FExt4 in('10','11') and FProAppliDepart='"+user.getDepartName()+"'");
		//执行年份查询
		if(bean.getPlanStartYear() != null) {
			String y = bean.getPlanStartYear();
			finder.append(" and planStartYear='"+y+"'");
		} else {
			String y = new Date().toString();
			y = y.substring(y.length()-4);
			finder.append(" and planStartYear='"+(Integer.valueOf(y)+1)+"'");
		}
		if (!StringUtil.isEmpty(bean.getFProCode())) {
			finder.append(" and FProCode like :FProCode").setParam("FProCode", "%" + bean.getFProCode() + "%");
		}
		if (!StringUtil.isEmpty(bean.getFProName())) {
			finder.append(" and FProName like :FProName").setParam("FProName", "%" + bean.getFProName() + "%");
		}
		finder.append(" order by FExt4 desc");
		return super.find(finder);
	}

	/*
	 * 一上批量上报
	 * @author 叶崇晖
	 * @createtime 2018-09-20
	 * @updatetime 2018-09-20
	 */
	@Override
	public void firstUpApply(String fproIdLi, User user)  throws Exception{
		
		String[] strarray1 = fproIdLi.split(","); 
		for (int i = 0; i < strarray1.length; i++) {
			//把历史审批记录全部设置为1，表示重新审批
			TProBasicInfo info = super.findById(Integer.parseInt(strarray1[i]));
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),info.getJoinTable(),info.getBeanCodeField(),info.getBeanCode(), "YSSB", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("YSSB", user.getDpID());
			Integer flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			User nextUser=userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号		get(0)的原因是一个角色应该只能审批一级，所以查出来li应该只有一个数据
			//改变下环节处理人，下环节处理人编码（id），下节点处理编码
			String userName = nextUser.getName();
			String userCode = nextUser.getId();
			String code = firstKey+"";
			//需要添加待办信息
			tProcessCheckMng.updateStauts(flowId,info.getBeanCode());
			//修改申报状态为11,填写一上申报数F_CB_1为项目申报金额
			getSession().createSQLQuery("UPDATE t_pro_basic_info SET F_CB_1=F_PRO_BUDGET_AMOUNT,F_EXT_4='11',F_FLOW_STAUTS='21',F_USER_NAME='"+userName+"',F_USER_CODE='"+userCode+"',F_EXT_11='"+code+"',F_NEXT_ASSIGNER_ID='"+userCode+"' WHERE F_PRO_ID='"+strarray1[i]+"'").executeUpdate();
		}
	}

	
	/*
	 * 一上审批列表数据查询
	 * @author 叶崇晖
	 * @createtime 2018-09-21
	 * @updatetime 2018-09-21
	 */
	@Override
	public Pagination ysspPageList(TProBasicInfo bean, int pageNo, int pageSize, User user) {
		Finder finder = Finder.create(" from TProBasicInfo where (FExt1 IS NULL OR FExt1!='0') and nextAssignerCode='"+user.getId()+"'");
		finder.append(" and FProLibType ='2' and FFlowStauts in('21') and FExt4 in('11')");
		//执行年份查询
		if(bean.getPlanStartYear() != null) {
			String y = bean.getPlanStartYear();
			finder.append(" and planStartYear='"+y+"'");
		} else {
			String y = new Date().toString();
			y = y.substring(y.length()-4);
			finder.append(" and planStartYear='"+(Integer.valueOf(y)+1)+"'");
		}
		if (!StringUtil.isEmpty(bean.getFProCode())) {
			finder.append(" and FProCode like :FProCode").setParam("FProCode", "%" + bean.getFProCode() + "%");
		}
		if (!StringUtil.isEmpty(bean.getFProName())) {
			finder.append(" and FProName like :FProName").setParam("FProName", "%" + bean.getFProName() + "%");
		}
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}
	
	
	
	
	/*
	 * 二上申报列表数据查询
	 * @author 叶崇晖
	 * @createtime 2018-09-27
	 * @updatetime 2018-09-27
	 */
	@Override
	public Pagination essbPageList(TProBasicInfo bean, int pageNo, int pageSize, User user) {
		Finder finder = Finder.create(" from TProBasicInfo where (FExt1 IS NULL OR FExt1!='0')");
		finder.append(" and FProLibType ='2' and  FExt5 ='0'");
		finder.append(" and FProAppliPeopleId='"+user.getId()+"'");
		//执行年份查询
 		if(!StringUtil.isEmpty(bean.getPlanStartYear())) {//预算年度
 			finder.append(" and planStartYear like :planStartYear").setParam("planStartYear", "%" + bean.getPlanStartYear() + "%");
 		}
		if (!StringUtil.isEmpty(bean.getFProCode())) {
			finder.append(" and FProCode like :FProCode").setParam("FProCode", "%" + bean.getFProCode() + "%");
		}
		if (!StringUtil.isEmpty(bean.getFProName())) {
			finder.append(" and FProName like :FProName").setParam("FProName", "%" + bean.getFProName() + "%");
		}
		if (bean.getFProOrBasic()!=null) {
			finder.append(" and FProOrBasic = '"+bean.getFProOrBasic()+"'");
		}
		if(!StringUtil.isEmpty(bean.getFProAppliPeople())){//人
			finder.append(" and FProAppliPeople=:FProAppliPeople").setParam("FProAppliPeople", bean.getFProAppliPeople());
		}
		if(!StringUtil.isEmpty(bean.getFProAppliDepart())){//部门
			finder.append(" and FProAppliDepart like :FProAppliDepart").setParam("FProAppliDepart","%" + bean.getFProAppliDepart()+"%");
		}
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}

	
	/*
	 * 二上申报数据保存
	 * @author 叶崇晖
	 * @createtime 2018-09-28
	 * @updatetime 2018-09-28
	 */
	@Override
	public TProBasicInfo secondUpApply(TProBasicInfo bean, User user, String saveType, String outcomeJson,String purchaseJson,String purchaseJsonSE,
			String fundsJson, String lxyjFiles, String ssfaFiles,String totalityPerformanceJson,String purManyYearsProJson,String purManyYearsProJsonSE) throws Exception {

		//设置所属库
		bean.setFProLibType("2");
		bean.setFExt5("0");
		//设置日期
		Date date = new Date();
		//设置常规信息
		if (bean.getFProId()==null) {//新增
			//创建人、 创建时间、申请人、申请部门
			bean.setCreator(user.getName());
			bean.setCreateTime(date);
			bean.setFProAppliTime(date);
			bean.setFProAppliPeopleId(user.getId());
			bean.setFProAppliPeople(user.getName());
			bean.setFProAppliDepartId(user.getDpID());
			bean.setFProAppliDepart(user.getDepartName());
			
			//保存常规信息--获取项目id
			bean = (TProBasicInfo) super.saveOrUpdate(bean);
			
			//项目编码
			
			String proCode=StringUtil.autoGenericCode(String.valueOf(bean.getFProId()), 6);
			//String proCode=bean.getFirstLevelCode()+"-"+bean.getSecondLevelCode()+"-"+user.getDepart().getCode()+"-"+idCode;     //一级编码+二级编码+部门+ID自增的6位数
			bean.setFProCode(proCode);
			if(bean.getFProOrBasic()==2){
				proCode="ZXM"+StringUtil.Random("");
				bean.setFProCode(proCode);
			}
			
			//更新常规信息
			bean = (TProBasicInfo) super.saveOrUpdate(bean);
		}else {//修改
			//修改人、修改时间
			bean.setUpdator(user.getName());
			bean.setUpdateTime(date);
			
			bean.setFProAppliTime(date);
			bean.setFProAppliPeopleId(user.getId());
			bean.setFProAppliPeople(user.getName());
			bean.setFProAppliDepartId(user.getDpID());
			bean.setFProAppliDepart(user.getDepartName());
			
			//保存修改后的信息
			super.updateDefault(bean);
		}
		
		
		//送审
		if ("31".equals(bean.getFFlowStauts())){
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), "ESSB", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("ESSB", user.getDpID());
			Integer flowId=processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			User nextUser=userMng.findById(node.getUserId());
			//设置下节点处理人
			bean.setNextAssignerName(nextUser.getName());
			bean.setNextAssignerCode(nextUser.getId());
			bean.setFExt11(firstKey+"");//设置下节点编码
			
			bean.setFFlowStauts("31");//审批状态  二上待审批
			bean.setFExt4("21");//上报状态   10、一上未申报   11、一上已申报    20、二上未申报   21、二上已申报
			bean.setCommitAmount2(bean.getFProBudgetAmount());//二上申报数
			
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			
			//更新常规信息
			super.saveOrUpdate(bean);
			
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(bean.getNextAssignerCode());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getFProId());//项目ID
			work.setTaskCode(bean.getFProCode());//项目编号
			work.setTaskName("[二上申报]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/declare/verdict2/"+bean.getFProId());//审批地址
			work.setUrl1("/project/detail/"+ bean.getFProId());//查看地址（审批完成时使用）
			work.setTaskStauts("0");//待办
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(date);//任务提交时间
			work.setType("1");//任务类型（1审批）
			work.setTaskType("1");//任务归属（1审批人）
			personalWorkMng.merge(work);
			
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(bean.getFProId());//项目ID
			work2.setTaskCode(bean.getFProCode());//项目编号
			work2.setTaskName("[二上申报]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/project/esedit/"+ bean.getFProId());//退回修改地址（被退回时使用）
			work2.setUrl1("/project/detail/"+ bean.getFProId());//查看地址
			work2.setUrl2("/project/delete/"+ bean.getFProId());//删除地址（被退回时使用）
			work2.setTaskStauts("2");//已办
			work2.setBeforeUser(user.getName());//任务提交人姓名
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work2.setBeforeTime(date);//任务提交时间
			work2.setFinishTime(bean.getCreateTime());
			work2.setType("2");//任务类型（1查看）
			work2.setTaskType("0");//任务归属（0发起人）
			personalWorkMng.merge(work2);
		}

		//保存附件信息
		attachmentMng.joinEntity(bean, lxyjFiles);
		attachmentMng.joinEntity(bean, ssfaFiles);
		
		//删除数据库中申请中的基本支出明细
		getSession().createSQLQuery("delete from T_PRO_EXPEND_DETAIL where F_PRO_ID ="+bean.getFProId()+"").executeUpdate();
		if(!StringUtil.isEmpty(outcomeJson)){
			//获取基本支出明细的Json对象
			List<TProExpendDetail> proExpendDetail = JSON.parseObject("["+outcomeJson+"]",new TypeReference<List<TProExpendDetail>>(){});
			for (TProExpendDetail infos : proExpendDetail) {
				TProExpendDetail info = new TProExpendDetail();
				info.setFProId(bean.getFProId());
				info.setActivity(infos.getActivity());
				info.setFunSubName(infos.getFunSubName());
				info.setFunSubCode(infos.getFunSubCode());
				info.setSubName(infos.getSubName());
				info.setSubCode(infos.getSubCode());
				info.setCapitalSourceName(infos.getCapitalSourceName());
				info.setCapitalSourceCode(infos.getCapitalSourceCode());
				info.setOutAmount(infos.getOutAmount());
				info.setActDesc(infos.getActDesc());
				super.merge(info);
			}
		}
		//删除数据库中申请中的政府采购明细
		getSession().createSQLQuery("delete from T_GOVERNMENT_PURCHASE_DETAIL where F_PRO_ID ="+bean.getFProId()+" and F_IF_SOFTWARE='0'").executeUpdate();
		if(!StringUtil.isEmpty(purchaseJson)){
			//获取政府采购明细的Json对象
			List<TGovernmentPurchaseDetail> governmentPurchaseDetail = JSON.parseObject("["+purchaseJson+"]",new TypeReference<List<TGovernmentPurchaseDetail>>(){});
			for (TGovernmentPurchaseDetail infos : governmentPurchaseDetail) {
				TGovernmentPurchaseDetail info = new TGovernmentPurchaseDetail();
				info.setfProId(bean.getFProId());
				info.setfItemsDetail(infos.getfItemsDetail());
				info.setfItemsCodeName(infos.getfItemsCodeName());
				info.setfItemsCode(infos.getfItemsCode());
				info.setfItemsName(infos.getfItemsName());
				info.setSubName(infos.getSubName());
				info.setSubCode(infos.getSubCode());
				info.setfIfThreeAssets(infos.getfIfThreeAssets());
				info.setfProcurementNum(infos.getfProcurementNum());
				info.setfMeasurement(infos.getfMeasurement());
				info.setfUnitPrice(infos.getfUnitPrice());
				info.setfAmount(infos.getfAmount());
				info.setfPlanDate(infos.getfPlanDate());
				info.setfRefiningExplain(infos.getfRefiningExplain());
				info.setfAllocationStandard(infos.getfAllocationStandard());
				info.setfIfSoftware("0");
				super.merge(info);
			}
		}
		//删除数据库中申请中的政府采购软件明细
		getSession().createSQLQuery("delete from T_GOVERNMENT_PURCHASE_DETAIL where F_PRO_ID ="+bean.getFProId()+" and F_IF_SOFTWARE='1'").executeUpdate();
		if(!StringUtil.isEmpty(purchaseJsonSE)){
			//获取政府采购软件明细的Json对象
			List<TGovernmentPurchaseDetail> governmentPurchaseDetail = JSON.parseObject("["+purchaseJsonSE+"]",new TypeReference<List<TGovernmentPurchaseDetail>>(){});
			for (TGovernmentPurchaseDetail infos : governmentPurchaseDetail) {
				TGovernmentPurchaseDetail info = new TGovernmentPurchaseDetail();
				info.setfProId(bean.getFProId());
				info.setfItemsDetail(infos.getfItemsDetail());
				info.setfItemsCodeName(infos.getfItemsCodeName());
				info.setfItemsCode(infos.getfItemsCode());
				info.setfItemsName(infos.getfItemsName());
				info.setSubName(infos.getSubName());
				info.setSubCode(infos.getSubCode());
				info.setfIfThreeAssets(infos.getfIfThreeAssets());
				info.setfProcurementNum(infos.getfProcurementNum());
				info.setfMeasurement(infos.getfMeasurement());
				info.setfUnitPrice(infos.getfUnitPrice());
				info.setfAmount(infos.getfAmount());
				info.setfPlanDate(infos.getfPlanDate());
				info.setfRefiningExplain(infos.getfRefiningExplain());
				info.setfAllocationStandard(infos.getfAllocationStandard());
				info.setfIfSoftware("1");
				super.merge(info);
			}
		}
		
		//删除数据库中申请中的绩效明细
		getSession().createSQLQuery("delete from T_PERFORMANCE_INDICATOR where F_PRO_ID ="+bean.getFProId()).executeUpdate();
		if(!StringUtil.isEmpty(totalityPerformanceJson)){
			//获取绩效明细的Json对象
			List<PerformanceIndicatorModel> performanceIndicatorModelList = JSON.parseObject("["+totalityPerformanceJson+"]",new TypeReference<List<PerformanceIndicatorModel>>(){});
			for (PerformanceIndicatorModel infos : performanceIndicatorModelList) {
				PerformanceIndicatorModel info = new PerformanceIndicatorModel();
				info.setfProId(bean.getFProId());
				info.settOneCode(infos.gettOneCode());
				info.settOneName(infos.gettOneName());
				info.settTwoCode(infos.gettTwoCode());
				info.settTwoName(infos.gettTwoName());
				info.settIndexVal(infos.gettIndexVal());
				info.setIndexContent(infos.getIndexContent());
				super.merge(info);
			}
		}
		//删除数据库中申请中的政府采购明细中的一采多年明细
		getSession().createSQLQuery("delete from T_PURCHASE_MANY_YEARS_PRO where F_PRO_ID ="+bean.getFProId()+" and F_IF_SOFTWARE='0'").executeUpdate();
		if(!StringUtil.isEmpty(purManyYearsProJson)){
			//获取政府采购明细中的一采多年明细的Json对象
			List<TPurchaseManyYearsPro> TPurchaseManyYearsProList = JSON.parseObject("["+purManyYearsProJson+"]",new TypeReference<List<TPurchaseManyYearsPro>>(){});
			for (TPurchaseManyYearsPro infos : TPurchaseManyYearsProList) {
				TPurchaseManyYearsPro info = new TPurchaseManyYearsPro();
				info.setfProId(bean.getFProId());
				info.setPurYear(infos.getPurYear());
				info.setYearAmount(infos.getYearAmount());
				info.setfExplain(infos.getfExplain());
				info.setfIfSoftware("0");
				super.merge(info);
			}
		}
		//删除数据库中申请中的政府软件采购明细中的一采多年明细
		getSession().createSQLQuery("delete from T_PURCHASE_MANY_YEARS_PRO where F_PRO_ID ="+bean.getFProId()+" and F_IF_SOFTWARE='1'").executeUpdate();
		if(!StringUtil.isEmpty(purManyYearsProJsonSE)){
			//获取政府软件采购明细中的一采多年明细的Json对象
			List<TPurchaseManyYearsPro> TPurchaseManyYearsProList = JSON.parseObject("["+purManyYearsProJsonSE+"]",new TypeReference<List<TPurchaseManyYearsPro>>(){});
			for (TPurchaseManyYearsPro infos : TPurchaseManyYearsProList) {
				TPurchaseManyYearsPro info = new TPurchaseManyYearsPro();
				info.setfProId(bean.getFProId());
				info.setPurYear(infos.getPurYear());
				info.setYearAmount(infos.getYearAmount());
				info.setfExplain(infos.getfExplain());
				info.setfIfSoftware("1");
				super.merge(info);
			}
		}
		return bean;
	}

	/*
	 * 二上审批列表数据查询
	 * @author 叶崇晖
	 * @createtime 2018-09-28
	 * @updatetime 2018-09-28
	 */
	@Override
	public Pagination esspPageList(TProBasicInfo bean, int pageNo, int pageSize, User user) {
		Finder finder = Finder.create(" from TProBasicInfo where (FExt1 IS NULL OR FExt1!='0')");
		finder.append(" and FProLibType ='2' and FFlowStauts in('31') and FExt4 in('21') and FExt5 ='0'");
		finder.append(" and nextAssignerCode='"+user.getId()+"'");
		//执行年份查询
		/*if(bean.getPlanStartYear() != null) {
			String y = bean.getPlanStartYear();
			finder.append(" and planStartYear='"+y+"'");
		} else {
			String y = new Date().toString();
			y = y.substring(y.length()-4);
			finder.append(" and planStartYear='"+(Integer.valueOf(y)+1)+"'");
		}*/
 		if(!StringUtil.isEmpty(bean.getPlanStartYear())) {//预算年度
 			finder.append(" and planStartYear like :planStartYear").setParam("planStartYear", "%" + bean.getPlanStartYear() +"%");
 		}
		if(!StringUtil.isEmpty(bean.getFProAppliPeople())){//人
			finder.append(" and FProAppliPeople=:FProAppliPeople").setParam("FProAppliPeople", bean.getFProAppliPeople());
		}
		if(!StringUtil.isEmpty(bean.getFProAppliDepart())){//部门
			finder.append(" and FProAppliDepart like :FProAppliDepart").setParam("FProAppliDepart","%" + bean.getFProAppliDepart()+"%");
		}
		if (!StringUtil.isEmpty(bean.getFProCode())) {
			finder.append(" and FProCode like :FProCode").setParam("FProCode", "%" + bean.getFProCode() + "%");
		}
		if (!StringUtil.isEmpty(bean.getFProName())) {
			finder.append(" and FProName like :FProName").setParam("FProName", "%" + bean.getFProName() + "%");
		}
		if (bean.getFProOrBasic()!=null) {
			finder.append(" and FProOrBasic = '"+bean.getFProOrBasic()+"'");
		}
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}


	@Override
	public String reCall(Integer id) throws Exception {
		//根据id查询对象
		TProBasicInfo bean=(TProBasicInfo)super.findById(id);
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="[二上申报]申请被撤回消息";
		String msg="您待审批的  "+bean.getFProName() +",任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean.setCheckStauts("-34");//已撤回
		bean.setStauts("0");//暂存
		bean.setNextCheckKey("0");//设置到初始节点
		bean.setNextCheckUserId("");
		bean.setNextCheckUserName("");
		this.updateDefault(bean);
		return "操作成功";
	}
}
