package com.braker.icontrol.expend.apply.manager.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.expend.apply.manager.ApplyAttacMng;
import com.braker.icontrol.expend.apply.manager.ApplyCheckMng;
import com.braker.icontrol.expend.apply.manager.ApplyMeetMng;
import com.braker.icontrol.expend.apply.model.AbroadPlan;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.apply.model.ApplicationDetail;
import com.braker.icontrol.expend.apply.model.MeetPlan;
import com.braker.icontrol.expend.apply.model.MeetingAppliInfo;
import com.braker.icontrol.expend.apply.model.MeetingPlan;
import com.braker.icontrol.expend.apply.model.OfficeCar;
import com.braker.icontrol.expend.apply.model.ReceptionPeopleInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 事前申请的service实现类
 * @author 叶崇晖
 * @createtime 2018-06-12
 * @updatetime 2018-06-12
 */
@Service
@Transactional
public class ApplyMeetingMngImpl extends BaseManagerImpl<ApplicationBasicInfo> implements ApplyMeetMng {
	
	
	@Autowired
	private ApplyCheckMng checkMng;
	@Autowired
	private ApplyAttacMng attacMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	@Autowired
	private TProBasicInfoMng tProBasicInfoMng;
	
	
	
	
	/*
	 * 事前申请新增和修改的保存
	 * @author 叶崇晖
	 * @createtime 2018-06-12
	 * @updatetime 2018-06-12
	 */
	@Override
	public void save(User user, ApplicationBasicInfo bean, 
			MeetingAppliInfo meetingBean, 
			String meetPlan,
			String files,String mingxi
			)  throws Exception{

		/** 保存基本属性 **/

		//设置属性
		Date d = new Date();
		bean.setReqTime(d);//申请时间
		bean.setUser(user.getId());//申请人id
		bean.setDept(user.getDepart().getId());//申请人所属部门id
		bean.setDeptName(user.getDepartName());//申请人所属部门名称
		if (bean.getgId()==null) {
			//创建人、创建时间、申请单编号
			bean.setCreator(user.getAccountNo());
			bean.setCreateTime(d);
			bean.setgCode(StringUtil.Random(""));//编码不需要加SQ
		} else {
			//修改人、修改时间
			bean.setUpdator(user.getAccountNo());
			bean.setUpdateTime(d);
		}
		

		/** 保存基本信息 **/
		//转换type选择流程
		String strType = tProcessCheckMng.JudgmentProcess(String.valueOf(bean.getType()));
		//工作流的节点配置（状态1和2可以继续走审批流，该状态不会变）
		if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
			Integer flowId =0;
			User nextUser = new User();
			
			TBudgetIndexMgr budgetIndexMgr = budgetIndexMgrMng.findById(bean.getIndexId());
			TProBasicInfo pro = tProBasicInfoMng.findById(budgetIndexMgr.getFProId());
			if(1==pro.getFProOrBasic()){//项目支出才有项目负责人
				nextUser = userMng.findById(pro.getFProHeadId());
				TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode(strType, user.getDpID());
				flowId= processDefin.getFPId();
				//设置下节点处理人姓名和编号		
				bean.setUserName2(nextUser.getName());
				bean.setFuserId(nextUser.getId());
				//设置下节点节点编码
				bean.setnCode("FProHead");	//该标识标识目前处于项目负责人审批节点
			}else if(0==pro.getFProOrBasic()){
				//得到第一个审批节点key
				Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), strType, user);
				//根据资源名称和当前登陆者所属部门查询对应工作流
				TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode(strType, user.getDpID());
				flowId= processDefin.getFPId();
				TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
				nextUser=userMng.findById(node.getUserId());
				//设置下节点处理人姓名和编号		
				bean.setUserName2(nextUser.getName());
				bean.setFuserId(nextUser.getId());
				//设置下节点节点编码
				bean.setnCode(firstKey+"");	
			}
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			//保存基本信息
			bean = (ApplicationBasicInfo) super.saveOrUpdate(bean);



			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getgId());//申请单ID
			work.setTaskCode(bean.getgCode());//为申请单的单号
			String taskName = "[会议申请]" + bean.getgName();
			work.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/applyCheck/check?id="+bean.getgId()+"&applyType="+bean.getType());//审批url
			work.setUrl1("/apply/edit?id="+ bean.getgId()+"&editType=0&applyType="+bean.getType());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setTaskType("1");//任务归属（1审批人）
			work.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work.setBeforeTime(d);//任务提交时间
			personalWorkMng.merge(work);

			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(bean.getgId());//申请单ID
			work2.setTaskCode(bean.getgCode());//为申请单的单号
			work2.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/apply/edit?id="+ bean.getgId()+"&editType=1&applyType="+bean.getType());//退回修改url
			work2.setUrl1("/apply/edit?id="+ bean.getgId()+"&editType=0&applyType="+bean.getType());//查看url
			work2.setUrl2("/apply/delete?id="+ bean.getgId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setTaskType("0");//任务归属（0发起人）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			/**----------------------------------------------------------------**/
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			/**----------------------------------------------------------------**/
			work2.setBeforeTime(d);//任务提交时间
			work2.setFinishTime(d);
			personalWorkMng.merge(work2);

			//计算明细申请金额总数
			BigDecimal num = BigDecimal.ZERO;
			num = bean.getAmount();
			budgetIndexMgrMng.addDjAmount(bean.getIndexId(),bean.getProDetailId(),num);
		} else {
			//保存基本信息
			bean = (ApplicationBasicInfo) super.saveOrUpdate(bean);
		}

		/** 保存附件 **/

		//保存附件信息
		attachmentMng.joinEntity(bean,files);

		/** 保存申请扩展信息 **/

		//保存会议信息
		if(meetingBean != null) {
			if (meetingBean.getmId()==null) {
				//创建人、创建时间、发布时间
				meetingBean.setCreator(user.getAccountNo());
				meetingBean.setCreateTime(d);
			} else {
				//修改人、修改时间
				meetingBean.setUpdator(user.getAccountNo());
				meetingBean.setUpdateTime(d);
			}
			meetingBean.setgId(bean.getgId());
			meetingBean = (MeetingAppliInfo) super.saveOrUpdate(meetingBean);
		}


		/** 保存明细信息 **/
		//删除数据库中   申请中的会议日程信息
		getSession().createSQLQuery("delete from T_MEETING_PLAN where F_G_ID ="+bean.getgId()+"").executeUpdate();
		//获得新的会议日程信息
		if(!StringUtil.isEmpty(meetPlan)){
			//获取会议日程信息的Json对象
			List<MeetingPlan> meet = JSON.parseObject("["+meetPlan.toString()+"]",new TypeReference<List<MeetingPlan>>(){});
			for (MeetingPlan meetingPlan : meet) {
				MeetingPlan info = new MeetingPlan();
				info.setgId(bean.getgId());
				info.setTimes(meetingPlan.getTimes());
				info.setTimee(meetingPlan.getTimee());
				info.setContent(meetingPlan.getContent());
				super.merge(info);
			}
		}
		//删除数据库中   申请中的费用明细信息
		getSession().createSQLQuery("delete from T_APPLI_DETAIL where F_G_ID ="+bean.getgId()+"").executeUpdate();
		//获得新的费用明细信息
//		if(!StringUtil.isEmpty(mingxi)){
//			//获取费用明细信息的Json对象
//			List<ApplicationDetail> app = JSON.parseObject("["+mingxi.toString()+"]",new TypeReference<List<ApplicationDetail>>(){});
//			for (ApplicationDetail applicationDetail : app) {
//				ApplicationDetail info = new ApplicationDetail();
//				info.setgId(bean.getgId());
//				info.setCostDetail(applicationDetail.getCostDetail());
//				info.setStandard(applicationDetail.getStandard());
//				info.setTotalStandard(applicationDetail.getTotalStandard());
//				info.setApplySum(applicationDetail.getApplySum());
//				info.setfStatus(0);
//				super.merge(info);
//			}
//		}
		
		//住宿费
		if (meetingBean.getHotelMoney() != null) {
			ApplicationDetail info = new ApplicationDetail();
			info.setgId(bean.getgId());
			info.setCostDetail("住宿费");
			info.setStandard(String.valueOf(meetingBean.getHotelStdSingle()));
			info.setTotalStandard(String.valueOf(meetingBean.getHotelStd()));
			info.setApplySum(meetingBean.getHotelMoney()); 
			info.setfStatus(0);
			super.merge(info);
		}
		//伙食费
		if (meetingBean.getFoodMoney() != null) {
			ApplicationDetail info = new ApplicationDetail();
			info.setgId(bean.getgId());
			info.setCostDetail("伙食费");
			info.setStandard(String.valueOf(meetingBean.getFoodStdSingle()));
			info.setTotalStandard(String.valueOf(meetingBean.getFoodStd()));
			info.setApplySum(meetingBean.getFoodMoney()); 
			info.setfStatus(0);
			super.merge(info);
		}
		//文件印刷费
		if (meetingBean.getPrintingMoney() != null) {
			ApplicationDetail info = new ApplicationDetail();
			info.setgId(bean.getgId());
			info.setCostDetail("文件印刷费");
			//info.setTotalStandard(String.valueOf(meetingBean.getPrintingStd()));
			info.setApplySum(meetingBean.getPrintingMoney()); 
			info.setfStatus(0);
			super.merge(info);
		}
		//会议场租金
		if (meetingBean.getRentMoney() != null) {
			ApplicationDetail info = new ApplicationDetail();
			info.setgId(bean.getgId());
			info.setCostDetail("会议场租金");
			info.setApplySum(meetingBean.getRentMoney()); 
			info.setfStatus(0);
			super.merge(info);
		}
		//交通费
		if (meetingBean.getTrafficMoney() != null) {
			ApplicationDetail info = new ApplicationDetail();
			info.setgId(bean.getgId());
			info.setCostDetail("交通费");
			info.setApplySum(meetingBean.getTrafficMoney()); 
			info.setfStatus(0);
			super.merge(info);
		}
		//其他
		if (meetingBean.getOtherMoney() != null) {
			ApplicationDetail info = new ApplicationDetail();
			info.setgId(bean.getgId());
			info.setCostDetail("其他");
			info.setStandard(String.valueOf(meetingBean.getOtherStdSingle()));
			info.setTotalStandard(String.valueOf(meetingBean.getOtherStd()));
			info.setApplySum(meetingBean.getOtherMoney()); 
			info.setfStatus(0);
			super.merge(info);
		}


	}
		
	public List getMingXiJson(String mingxi, Class tableClass) {
		//获取明细的Json对象
		List mx = null;
		JSONArray array =JSONArray.fromObject("["+mingxi.toString()+"]");
		mx = (List)JSONArray.toList(array, tableClass);
		return mx;
	}
	public List<Object> getMingxi(String tableName ,String idName ,Integer id) {
		Finder finder = Finder.create(" FROM " + tableName + " WHERE " + idName + "="+id);
		return super.find(finder);
	}
	public List<Object> getObjectList(String tableName, String idName, Integer id) {
		Finder finder = Finder.create(" FROM " + tableName + " WHERE " + idName + "="+id);
		return super.find(finder);
	}
	
}
