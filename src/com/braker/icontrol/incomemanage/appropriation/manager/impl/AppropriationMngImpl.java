package com.braker.icontrol.incomemanage.appropriation.manager.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Category;
import com.braker.core.model.Lookups;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.apply.model.ApplicationDetail;
import com.braker.icontrol.expend.apply.model.MeetingAppliInfo;
import com.braker.icontrol.expend.apply.model.MeetingPlan;
import com.braker.icontrol.incomemanage.accountsCurrent.model.ReceiveMoneyDetail;
import com.braker.icontrol.incomemanage.appropriation.manager.AppropriationMng;
import com.braker.icontrol.incomemanage.appropriation.model.AppropriationInfo;
import com.braker.icontrol.incomemanage.businessService.model.BusinessServiceInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 拨款收入Service实现层
 * @author wanping
 *
 */
@Service
@Transactional
public class AppropriationMngImpl extends BaseManagerImpl<AppropriationInfo> implements AppropriationMng {
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private TNodeDataMng tNodeDataMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private PersonalWorkMng personalWorkMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private PrivateInforMng privateInforMng;

	@Override
	public Pagination pageList(AppropriationInfo bean, Integer page, Integer rows) {
		Finder finder =Finder.create("  FROM AppropriationInfo WHERE fStatus <> 99");
		if(!StringUtil.isEmpty(bean.getRegisterCode())){
			finder.append(" AND registerCode LIKE '%"+bean.getRegisterCode()+"%'");
		}
		if(!StringUtil.isEmpty(bean.getProjectName())){
			finder.append(" AND projectName LIKE '%"+bean.getProjectName()+"%'");
		}
		if(!StringUtil.isEmpty(bean.getUnitName())){
			finder.append(" AND unitName LIKE '%"+bean.getUnitName()+"%'");
		}
		finder.append(" order by updateTime desc");
		Pagination p = super.find(finder, page, rows);
		List<AppropriationInfo> list = (List<AppropriationInfo>) p.getList();
    	for (int i = 0; i < list.size(); i++) {
			//序号设置
    		list.get(i).setNum((i + 1) + (page - 1) * rows);
		}
		return p;
	}

	@Override
	public void save(User user, AppropriationInfo appropriationInfo, String files,String registerJson) throws Exception {

		Date date = new Date();
		appropriationInfo.setfApplyDate(date);//登记时间
		appropriationInfo.setfOperatorId(user.getId());//登记人id
		appropriationInfo.setfDeptId(user.getDepart().getId());//登记人所属部门id
		appropriationInfo.setfDeptName(user.getDepartName());//登记人所属部门名称
		if (appropriationInfo.getaId()==null) {
			//创建人、创建时间、确认状态
			appropriationInfo.setCreator(user.getAccountNo());
			appropriationInfo.setCreateTime(date);
			appropriationInfo.setfConfirmStatus("0");
			appropriationInfo.setfStatus("0");
		} else {
			//修改人、修改时间
			appropriationInfo.setUpdator(user.getAccountNo());
			appropriationInfo.setUpdateTime(date);
		}
		
		//工作流的节点配置（状态1和2可以继续走审批流，该状态不会变）
		if("1".equals(appropriationInfo.getfFlowStatus()) || "2".equals(appropriationInfo.getfFlowStatus())){
			//得到第一个审批节点key
			Integer firstKey = tProcessCheckMng.addProcessCheck(user.getDpID(), appropriationInfo.getJoinTable(), appropriationInfo.getBeanCodeField(), appropriationInfo.getBeanCode(), "BKLSRDJ", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin =  tProcessDefinMng.getByBusiAndDpcode("BKLSRDJ", user.getDpID());
			Integer flowId = processDefin.getFPId();
			TNodeData node = tNodeDataMng.getByFlowIdAndKey(flowId, firstKey);
			User nextUser = userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号
			appropriationInfo.setfNextUserName(nextUser.getName());
			appropriationInfo.setfNextUserId(nextUser.getId());
			//设置下节点节点编码
			appropriationInfo.setfNextCode(String.valueOf(firstKey));
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId, appropriationInfo.getBeanCode());
			//保存基本信息
			appropriationInfo = (AppropriationInfo) super.saveOrUpdate(appropriationInfo);
					
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(appropriationInfo.getaId());
			work.setTaskCode(appropriationInfo.getRegisterCode());
			work.setTaskName("[拨款类收入]" + appropriationInfo.getProjectName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/appropriation/check?id=" + appropriationInfo.getaId());//为审批页面内容显示的url,需要将数据传入不然无法访问
			work.setUrl1("/appropriation/detail?id=" + appropriationInfo.getaId());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型：1-审批
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(date);//任务提交时间
			personalWorkMng.merge(work);
					
			//添加一个自己的已办事项
			PersonalWork minwork = new PersonalWork();
			minwork.setUserId(user.getId());//任务处理人ID既是下节点处理人ID
			minwork.setTaskId(appropriationInfo.getaId());
			minwork.setTaskCode(appropriationInfo.getRegisterCode());
			minwork.setTaskName("[拨款类收入]" + appropriationInfo.getProjectName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			minwork.setUrl("/appropriation/edit?id=" + appropriationInfo.getaId());//退回修改url
			minwork.setUrl1("/appropriation/detail?id=" + appropriationInfo.getaId());//查看url
			minwork.setUrl2("/appropriation/delete?id=" + appropriationInfo.getaId());//退回删除url
			minwork.setTaskStauts("2");//待办
			minwork.setType("2");//任务类型：2-查看
			minwork.setBeforeUser(user.getName());//任务提交人姓名
			minwork.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			minwork.setBeforeTime(date);//任务提交时间
			minwork.setFinishTime(date);
			personalWorkMng.merge(minwork);
		} else {
			//保存基本信息
			appropriationInfo = (AppropriationInfo) super.saveOrUpdate(appropriationInfo);
		}

		/** 保存附件 **/

		//保存附件信息
		attachmentMng.joinEntity(appropriationInfo, files);
		/** 保存明细信息 **/
		//删除数据库中   申请中
		getSession().createSQLQuery("delete from T_RECEIVE_MONEY_DETAIL where F_M_S_ID ="+appropriationInfo.getaId()+" and F_TYPE='3'").executeUpdate();
		if(!StringUtil.isEmpty(registerJson)){
			//获取Json对象
			List<ReceiveMoneyDetail> receiveMoneyDetailList = JSON.parseObject("["+registerJson.toString()+"]",new TypeReference<List<ReceiveMoneyDetail>>(){});
			for (ReceiveMoneyDetail receiveMoneyDetail: receiveMoneyDetailList) {
				ReceiveMoneyDetail info = new ReceiveMoneyDetail();
				info.setfMSId(appropriationInfo.getaId());
				info.setOppositeUnit(receiveMoneyDetail.getOppositeUnit());
				info.setPlanMoney(receiveMoneyDetail.getPlanMoney());
				info.setPlanTime(receiveMoneyDetail.getPlanTime());
				info.setInvoiceKind(receiveMoneyDetail.getInvoiceKind());
				info.setInvoiceKindShow(receiveMoneyDetail.getInvoiceKindShow());
				info.setfType("3");
				super.merge(info);
			}
		}
	}

	@Override
	public void reCall(Integer id) {
		//根据id查询对象
		AppropriationInfo bean=(AppropriationInfo)super.findById(id);
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="申请被撤回消息";
		String msg="您待审批的  "+bean.getProjectName() +",任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean=(AppropriationInfo) reCall((CheckEntity) bean);
		this.updateDefault(bean);
	}

	@Override
	public void delete(Integer id) {
		AppropriationInfo bean = super.findById(id);
		bean.setfStatus("99");
		super.saveOrUpdate(bean);
	}

	@Override
	public Pagination checkPageList(AppropriationInfo bean, Integer page, Integer rows, User user) {
		Finder finder =Finder.create("  FROM AppropriationInfo WHERE fStatus <> 99 AND fNextUserId=" + user.getId());
		if(!StringUtil.isEmpty(bean.getRegisterCode())){
			finder.append(" AND registerCode LIKE '%"+bean.getRegisterCode()+"%'");
		}
		if(!StringUtil.isEmpty(bean.getProjectName())){
			finder.append(" AND projectName LIKE '%"+bean.getProjectName()+"%'");
		}
		if(!StringUtil.isEmpty(bean.getUnitName())){
			finder.append(" AND unitName LIKE '%"+bean.getUnitName()+"%'");
		}
		finder.append(" order by updateTime desc");
		Pagination p = super.find(finder, page, rows);
		List<AppropriationInfo> list = (List<AppropriationInfo>) p.getList();
    	for (int i = 0; i < list.size(); i++) {
			//序号设置
    		list.get(i).setNum((i + 1) + (page - 1) * rows);
		}
		return p;
	}
	
	@Override
	public void saveCheck(TProcessCheck checkBean, AppropriationInfo bean, String spjlFile, User user) throws Exception {
		AppropriationInfo appropriationInfo = this.findById(bean.getaId());
		CheckEntity entity = (CheckEntity)appropriationInfo;
		//设置下一级审批人待办和查看路径
		String checkUrl = "/appropriation/check?id=";
		String lookUrl = "/appropriation/detail?id=";
		//查询审批流程
		appropriationInfo = (AppropriationInfo)tProcessCheckMng.checkProcess(checkBean, entity, user, "BKLSRDJ", checkUrl, lookUrl, spjlFile);
		super.saveOrUpdate(appropriationInfo);
	}

	@Override
	public Pagination confirmPageList(AppropriationInfo bean, Integer page, Integer rows) {
		Finder finder =Finder.create("  FROM AppropriationInfo WHERE fStatus <> 99 AND fFlowStatus='9'");
		if(!StringUtil.isEmpty(bean.getRegisterCode())){
			finder.append(" AND registerCode LIKE '%"+bean.getRegisterCode()+"%'");
		}
		if(!StringUtil.isEmpty(bean.getProjectName())){
			finder.append(" AND projectName LIKE '%"+bean.getProjectName()+"%'");
		}
		if(!StringUtil.isEmpty(bean.getUnitName())){
			finder.append(" AND unitName LIKE '%"+bean.getUnitName()+"%'");
		}
		finder.append(" order by fConfirmStatus asc, updateTime desc");
		Pagination p = super.find(finder, page, rows);
		List<AppropriationInfo> list = (List<AppropriationInfo>) p.getList();
    	for (int i = 0; i < list.size(); i++) {
			//序号设置
    		list.get(i).setNum((i + 1) + (page - 1) * rows);
		}
		return p;
	}

	@Override
	public void confirmAppropriation(AppropriationInfo bean) {
		AppropriationInfo appropriationInfo = super.findById(bean.getaId());
		appropriationInfo.setPaymentActualDate(bean.getPaymentActualDate());
		appropriationInfo.setAccountingDocument(bean.getAccountingDocument());
		appropriationInfo.setfConfirmStatus("1");
		super.merge(appropriationInfo);
	}

}
