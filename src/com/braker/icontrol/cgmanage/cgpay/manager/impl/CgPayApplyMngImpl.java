package com.braker.icontrol.cgmanage.cgpay.manager.impl;


import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgpay.manager.CgPayApplyMng;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;

/**
 * 付款申请审批的的service实现类
 * @author 冉德茂
 * @createtime 2018-08-16
 * @updatetime 2018-08-16
 */
@Service
@Transactional
public class CgPayApplyMngImpl extends BaseManagerImpl<PurchaseApplyBasic> implements CgPayApplyMng {
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private TNodeDataMng tNodeDataMng;
	
	@Autowired
	private UserMng userMng;
	/**
	 * 验收完成付款   发起审批申请
	 * @author 冉德茂
	 * @createtime 2018-08-16
	 * @updatetime 2018-08-16
	 */
	@Override
	@Transactional(propagation=Propagation.REQUIRED)//事务处理
	public void save(PurchaseApplyBasic bean,User user)  throws Exception{
		//以下为工作流的节点配置（如果点送审则设置进入工作流1为提交2为审核中）
		Date d = new Date();
		if(bean.getFpayStauts().equals("1") || bean.getFpayStauts().equals("2")){
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), "CGPAY", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("CGPAY", user.getDpID());
			Integer flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			User nextUser=userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号		get(0)的原因是一个角色应该只能审批一级，所以查出来li应该只有一个数据
			bean.setUserName2(nextUser.getName());
			bean.setFuserId(nextUser.getId());
			//设置下节点节点编码
			bean.setnCode(firstKey+"");	
			bean = (PurchaseApplyBasic) super.updateDefault(bean);
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			
			//以下为叶修改**********************************************************
			
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getFpId());//申请单ID
			work.setTaskCode(bean.getFpCode());//为申请单的单号
			work.setTaskName(bean.getFpName()+"采购付款申请审批");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/cgpayforcheck/check?id="+bean.getFpId());//审批url
			work.setUrl1("/cgpayfor/checkdetail?id="+bean.getFpId());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(new Date());//任务提交时间
			personalWorkMng.merge(work);
		
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(bean.getFpId());//申请单ID
			work2.setTaskCode(bean.getFpCode());//为申请单的单号
			work2.setTaskName("采购付款申请审批");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/cgpayfor/checkreceive?id="+bean.getFpId());//付款申请不存在修改，即被退回也是送审页面的url
			work2.setUrl1("/cgpayfor/checkdetail?id="+bean.getFpId());//查看url
			work2.setUrl2(null);//付款审批不可以被删除
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work2.setBeforeTime(d);//任务提交时间
			work2.setFinishTime(d);
			personalWorkMng.merge(work2);
		} else {
			//保存基本信息
			bean = (PurchaseApplyBasic) super.updateDefault(bean);
		}
	}
	/*
	 * 保存采购审定信息
	 * @author 李安达
	 * @createtime 2019-05-7
	 * @updatetime 2019-05-7
	 */
	@Override
	public void savePurchaseAuditInfo(TProcessCheck checkBean, PurchaseApplyBasic bean, User user,String files)  throws Exception{
		bean=this.findById(bean.getFpId());
		CheckEntity entity=(CheckEntity)bean;
		String url="/cgpayforcheck/check?id=";
		String url1 ="/cgpayfor/checkdetail?id=";
		//String url2 ="/audit/auditPurchase?cashier=1&id=";
		bean=(PurchaseApplyBasic)tProcessCheckMng.checkProcess(checkBean, entity, user, "CGPAY", url, url1,files);
		super.saveOrUpdate(bean);
	}
	
}

	
	
	


