package com.braker.icontrol.budget.researchProjects.manager.impl;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
import com.braker.icontrol.budget.researchProjects.manager.ResearchProjectsMng;
import com.braker.icontrol.budget.researchProjects.model.ResearchProjectsInfo;
import com.braker.icontrol.cgmanage.cgreveive.model.AcceptCheck;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 科研项目登记的service实现类
 * @author 方淳洲
 * @createtime 2021-06-18
 * @updatetime 2021-06-18
 */
@Service
@Transactional
public class ResearchProjectsMngImpl extends BaseManagerImpl<ResearchProjectsInfo> implements ResearchProjectsMng{
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	
	
	@Override
	public Pagination pageList(ResearchProjectsInfo bean, Integer page, Integer rows, User user) {
		Finder finder =Finder.create(" FROM ResearchProjectsInfo WHERE status <> '99' and fUser = '"+user.getId()+"'");
		if(!StringUtil.isEmpty(bean.getFpCode())) {
			finder.append(" and fpCode = :fpCode").setParam("fpCode", bean.getFpCode());
		}
		if(!StringUtil.isEmpty(bean.getProjectName())) {
			finder.append(" and projectName = :projectName").setParam("projectName", bean.getProjectName());
		}
		if(!StringUtil.isEmpty(bean.getfDeptName())) {
			finder.append(" and fDeptName = :fDeptName").setParam("fDeptName", bean.getfDeptName());
		}
		if(!StringUtil.isEmpty(bean.getFlowStatus())) {
			finder.append(" and flowStatus = :flowStatus").setParam("flowStatus", bean.getFlowStatus());
		}
		if(!StringUtil.isEmpty(bean.getResearchType())) {
			finder.append(" and researchType = :researchType").setParam("researchType", bean.getResearchType());
		}
		finder.append(" order by fReqTime desc ");
		return super.find(finder,page,rows);
	}
	
	@Override
	public Pagination getProjectUserAndProjectMemberById(ResearchProjectsInfo bean, Integer page, Integer rows, User user) {
		Finder finder =Finder.create(" FROM ResearchProjectsInfo WHERE status <> '99' and flowStatus='9' and concat_ws(',',fUserName,projectUser) like'%"+bean.getUserName()+"%'");
		if(!StringUtil.isEmpty(bean.getFpCode())) {
			finder.append(" and fpCode = : fpCode").setParam("fpCode", bean.getFpCode());
		}
		if(!StringUtil.isEmpty(bean.getProjectName())) {
			finder.append(" and projectName = : projectName").setParam("projectName", bean.getProjectName());
		}
		if(!StringUtil.isEmpty(bean.getfDeptName())) {
			finder.append(" and fDeptName = : fDeptName").setParam("fDeptName", bean.getfDeptName());
		}
		if(!StringUtil.isEmpty(bean.getResearchType())) {
			finder.append(" and researchType ='"+bean.getResearchType()+"' ");
		}
		finder.append(" order by fReqTime desc ");
		return super.find(finder,page,rows);
	}

	@Override
	public void save(ResearchProjectsInfo bean, String files, User user) throws Exception {
		Date date = new Date();
		if (bean.getFpId()==null) {
			//创建人、创建时间、发布时间  设置验收状态
			bean.setCreator(user.getName());
			bean.setCreateTime(date);
			bean.setfDeptId(user.getDpID());
			bean.setfDeptName(user.getDepartName());
			bean.setfUser(user.getId());
			bean.setfReqTime(date);
		} else {
			//修改人、修改时间
			bean.setUpdator(user.getName());
			bean.setUpdateTime(date);
			bean.setfReqTime(date);
		}
		
		//工作流的节点配置（状态1和2可以继续走审批流，该状态不会变）
		if("1".equals(bean.getFlowStatus()) || "2".equals(bean.getFlowStatus())){
			//得到第一个审批节点key
			Integer firstKey = null;
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin = new TProcessDefin();
			firstKey = tProcessCheckMng.addProcessCheck(user.getDpID(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getBeanCode(), "KYXMDJ", user);
			processDefin = tProcessDefinMng.getByBusiAndDpcode("KYXMDJ", user.getDpID());
			Integer flowId = processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			User nextUser=userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号
			bean.setNextUserName(nextUser.getName());
			bean.setNextUserId(nextUser.getId());
			//设置下节点节点编码
			bean.setnCode(firstKey + "");
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId, bean.getBeanCode());
			//保存验收信息
			bean=(ResearchProjectsInfo)super.saveOrUpdate(bean);
			
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getFpId());//申请单ID
			work.setTaskCode(bean.getFpCode());//为申请单的单号
			work.setTaskName("[科研项目登记]"+bean.getProjectName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/researchProjects/check?id="+bean.getFpId());//为审批页面内容显示的url,需要将数据传入不然无法访问
			work.setUrl1("/researchProjects/detail?id="+bean.getFpId());//查看url
			work.setUrl2("/researchProjects/delete?id=" + bean.getFpId());//删除url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setTaskType("1");//任务归属（1审批人）
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(date);//任务提交时间
			personalWorkMng.merge(work);
			
			/**叶添加**/
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(bean.getFpId());//申请单ID
			work2.setTaskCode(bean.getFpCode());//为申请单的单号
			work2.setTaskName("[科研项目登记]"+bean.getProjectName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/researchProjects/edit?id=" + bean.getFpId());//查看url
			work2.setUrl1("/researchProjects/detail?id=" + bean.getFpId());//查看url
			work2.setUrl2("/researchProjects/delete?id=" + bean.getFpId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setTaskType("0");//任务归属（0发起人）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work2.setBeforeTime(date);//任务提交时间
			work2.setFinishTime(date);
			personalWorkMng.merge(work2);
		}else {
			//保存验收信息
			bean=(ResearchProjectsInfo)super.saveOrUpdate(bean);
		}
		
		attachmentMng.joinEntity(bean,files);
	}

	@Override
	public void delete(Integer id) {
		ResearchProjectsInfo bean = super.findById(id);
		bean.setStatus("99");
		super.saveOrUpdate(bean);
	}

	@Override
	public String reCall(Integer id) {
		//根据id查询对象
		ResearchProjectsInfo bean=(ResearchProjectsInfo)super.findById(id);
		if(bean.getCheckStauts().equals("-4")){
			throw new ServiceException("该单据已被撤回，请勿重复操作！");
		}
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="科研项目登记被撤回消息";
		String msg="您待审批的  "+bean.getProjectName() +",任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean=(ResearchProjectsInfo) reCall((CheckEntity) bean);
		this.updateDefault(bean);
		return "操作成功";
	}

	@Override
	public Pagination checkPageList(ResearchProjectsInfo bean, Integer page, Integer rows, User user) {
		Finder finder =Finder.create(" FROM ResearchProjectsInfo WHERE status <> '99' and nextUserId = '"+user.getId()+"' and flowStatus = '1'");
		if(!StringUtil.isEmpty(bean.getFpCode())) {
			finder.append(" and fpCode = :fpCode").setParam("fpCode", bean.getFpCode());
		}
		if(!StringUtil.isEmpty(bean.getProjectName())) {
			finder.append(" and projectName = :projectName").setParam("projectName", bean.getProjectName());
		}
		if(!StringUtil.isEmpty(bean.getfDeptName())) {
			finder.append(" and fDeptName = :fDeptName").setParam("fDeptName", bean.getfDeptName());
		}
		if(!StringUtil.isEmpty(bean.getFlowStatus())) {
			finder.append(" and flowStatus = :flowStatus").setParam("flowStatus", bean.getFlowStatus());
		}
		if(!StringUtil.isEmpty(bean.getResearchType())) {
			finder.append(" and researchType = :researchType").setParam("researchType", bean.getResearchType());
		}
		finder.append(" order by fReqTime desc ");
		return super.find(finder,page,rows);
	}

	@Override
	public void saveCheck(TProcessCheck checkBean, ResearchProjectsInfo bean, User user, String spjlFile) throws Exception {
		//保存采购类型和采购方式
		bean = this.findById(bean.getFpId());
		CheckEntity entity=(CheckEntity)bean;
		String checkUrl="/cgcheck/check?id=";
		String lookUrl ="/cgsqsp/detail?id=";
		//查询工作流
			bean=(ResearchProjectsInfo)tProcessCheckMng.checkProcess(checkBean,entity,user,"KYXMDJ",checkUrl,lookUrl,spjlFile);
		if("-1".equals(bean.getFlowStatus())){//审批不通过的时候
			
		}
		if("9".equals(bean.getFlowStatus())){//审批通过的时候
			
		}
		super.saveOrUpdate(bean);
		
	}

}
