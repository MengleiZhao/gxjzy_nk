package com.braker.icontrol.budget.knot.manager.Impl;

import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.socket.TextMessage;

import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.icontrol.budget.knot.entity.TPorjectKnot;
import com.braker.icontrol.budget.knot.manager.PorjectKnotMng;
import com.braker.icontrol.budget.project.entity.TProBasicFunds;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.manager.ExecuteProjectMng;
import com.braker.icontrol.budget.project.manager.TProBasicInfoMng;
import com.braker.icontrol.cgmanage.cgconfplan.mananger.CgConPlanMng;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlan;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlanList;
import com.braker.icontrol.cgmanage.cginquiries.model.InqWinningRef;
import com.braker.icontrol.contract.Formulation.model.ExecuteProject;
import com.braker.icontrol.contract.enforcing.model.ContPay;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;

@Service
@Transactional
public class PorjectKnotMngImpl extends BaseManagerImpl<TPorjectKnot> implements PorjectKnotMng{
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProBasicInfoMng projectMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private ExecuteProjectMng executeProjectMng;
	
	@Autowired
	private UserMng userMng;
	
	@Override
	public void save(TPorjectKnot bean, User user, String opeType, String files) throws Exception {
		Date d = new Date();
		if (bean.getFkId()==null) {
			//创建人、创建时间、发布时间  
			bean.setFreqDeptId(user.getDpID());
			bean.setFreqDept(user.getDepartName());
			bean.setCreator(user.getName());
			bean.setCreateTime(d);
			bean.setFreqTime(d);;
		} else {
			//修改人、修改时间
			bean.setUpdator(user.getAccountNo());
			bean.setUpdateTime(d);
			bean.setFreqTime(d);;
		}
		TProBasicInfo pro = projectMng.findById(bean.getFProId());
		pro.setFProStauts(bean.getFlowStauts());//修改项目结项状态
		projectMng.updateDefault(pro);
		//以下为工作流的节点配置（如果点送审则设置进入工作流1为提交2为审核中）
		if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(), bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(),"JXSQ", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("JXSQ", user.getDpID());
			Integer flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			User nextUser=userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号		get(0)的原因是一个角色应该只能审批一级，所以查出来li应该只有一个数据
			bean.setFuserName(nextUser.getName());
			bean.setFuserId(nextUser.getId());
			//设置下节点节点编码
			bean.setnCode(firstKey+"");	
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			//保存基本信息
			
			if(bean.getFkId()==null){
				bean.setFreqUserId(user.getId());
				bean = (TPorjectKnot) super.saveOrUpdate(bean); //新增
			}else{
				super.updateDefault(bean);//修改
			}
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getFkId());//申请单ID
			work.setTaskCode(bean.getFKnotCode());//为申请单的单号
			work.setTaskName("[结项申请]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/projectknot/check?id="+bean.getFkId());//为审批页面内容显示的url,需要将数据传入不然无法访问
			work.setUrl1("/projectknot/detail?id="+work.getTaskId());
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(d);//任务提交时间
			personalWorkMng.merge(work);
			
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(bean.getFkId());//申请单ID
			work2.setTaskCode(bean.getFKnotCode());//为申请单的单号
			work.setTaskName("[结项申请]"+bean.getFProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/projectknot/edit?id="+work.getTaskId());//退回修改url
			work2.setUrl1("/projectknot/detail?id="+work.getTaskId());
			work2.setUrl2("/projectknot/delete?id="+work.getTaskId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work2.setBeforeTime(d);//任务提交时间
			work2.setFinishTime(d);
			personalWorkMng.merge(work2);
			
		} else {
			//保存基本信息
			bean.setFreqUserId(user.getId());
			//保存基本信息
			if(bean.getFkId()==null){
				bean = (TPorjectKnot) super.saveOrUpdate(bean); //新增
			}else{
				bean = (TPorjectKnot) super.updateDefault(bean);//修改
			}
		}
		//保存附件信息
		attachmentMng.joinEntity(bean,files);
	}
	
	@Override
	public void check(TProcessCheck checkBean,TProBasicInfo tprobasicinfo,ExecuteProject bean,User user,String files)  throws Exception {
		bean = (ExecuteProject)executeProjectMng.findById(bean.getFprojectId());
		CheckEntity entity=(CheckEntity)bean;
		//String checkUrl="/projectknot/check?id="+tprobasicinfo.getFProId();
		String checkUrl="/projectknot/check?id="+tprobasicinfo.getFProId()+"&fid=";
		String lookUrl ="/projectknot/detail?id="+tprobasicinfo.getFProId()+"&fid=";
		bean=(ExecuteProject) tProcessCheckMng.checkProcess(checkBean,entity,user,"zxxm",checkUrl,lookUrl,files);
		TProBasicInfo pro = projectMng.findById(Integer.valueOf(bean.getFzxxmId()));
		pro.setFjzspzt(bean.getCheckStauts());//修改项目结项状态
		pro.setFjzclrbm(bean.getZxxmclrbm());//修改项目结项状态
		/*if("9".equals(bean.getJzspzt())){
			pro.setFProLibType("4");
		}*/
		projectMng.updateDefault(pro);
		super.saveOrUpdate(bean);
	}

	@Override
	public Pagination pageList(TProBasicInfo bean, User user,  int pageNo, int pageSize) {
		try {
			Finder finder = Finder.create(" FROM TProBasicInfo where fjzspzt ='1' and fjzclrbm='"+user.getId()+"' ");
			//查询条件
			if (!StringUtil.isEmpty(bean.getFProCode())) {//项目编码
				finder.append(" and FProCode like :FProCode").setParam("FProCode", "'%" + bean.getFProCode() + "%'");
			}
			if (!StringUtil.isEmpty(bean.getFProName())) {//名称
				finder.append(" and FProName like :name").setParam("name", "'%" + bean.getFProName() + "%'");
			}
			finder.append(" order by updateTime desc");
			return super.find(finder, pageNo, pageSize);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
 		
	}






	
	
}
