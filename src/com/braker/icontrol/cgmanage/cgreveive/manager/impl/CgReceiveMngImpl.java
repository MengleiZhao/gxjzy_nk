package com.braker.icontrol.cgmanage.cgreveive.manager.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.cgmanage.cgconfplan.mananger.CgConPlanListMng;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlanList;
import com.braker.icontrol.cgmanage.cgprocess.model.BidRegist;
import com.braker.icontrol.cgmanage.cgreveive.manager.CgReceiveMng;
import com.braker.icontrol.cgmanage.cgreveive.model.AcceptCheck;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.icontrol.contract.Formulation.manager.ContractPlanListMng;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.enforcing.manager.UptMng;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.expend.apply.model.ApplicationDetail;
import com.braker.icontrol.purchase.apply.manager.PurchaseApplyMng;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;


/**
 * 采购验收的service实现类
 * @author 冉德茂
 * @createtime 2018-07-17
 * @updatetime 2018-07-17
 */
@Service
@Transactional
public class CgReceiveMngImpl extends BaseManagerImpl<AcceptCheck> implements CgReceiveMng {
	@Autowired
	private CgReceiveMng cgRecdiveMng;
	@Autowired
	private CgApplysqMng cgApplySqMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private UptMng uptMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private PurchaseApplyMng purchaseApplyMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	@Autowired
	private CgConPlanListMng cgConPlanListMng;
	@Autowired
	private FormulationMng formulationMng;
	@Autowired
	private ContractPlanListMng contractPlanListMng;
	/*
	 * 保存验收信息
	 * @author 冉德茂
	 * @createtime 2018-07-18
	 * @updatetime 2018-07-18
	 */
	@Override
	public void saveReceive(AcceptCheck acptbean, PurchaseApplyBasic bean,String file1,String file2,User user) throws Exception {
		
		Date date = new Date();
		//创建人、创建时间
		if(StringUtil.isEmpty(acptbean.getFacpCode())) {
			acptbean.setCreator(user.getName());
			acptbean.setCreateTime(date);
			//外键ID	链接PurchaseApplyBasic的fpid
			acptbean.setFpId(acptbean.getFpId());
			//验收人 	当前登陆用户姓名
			acptbean.setFacpUsername(user.getName());
			//验收人	当前登陆用户id
			acptbean.setFacpUserId(user.getId());
			//部门id
			acptbean.setfDepartId(user.getDpID());
			//部门名称
			acptbean.setfDepartName(user.getDepartName());
			
			//自动生成编号
			String str="CGYS";
			acptbean.setFacpCode(StringUtil.Random(str));
		}else {
			acptbean.setUpdator(user.getName());
			acptbean.setUpdateTime(date);
		}
		
		//查询采购计划信息
		PurchaseApplyBasic bean2 = cgApplySqMng.findById(bean.getFpId());
		
		bean2.setfIsReceive("0");//0-待验收 1验收中 2已验收
		acptbean.setCheckStauts(acptbean.getfCheckStauts());
		//保存验收信息
		acptbean=(AcceptCheck)super.saveOrUpdate(acptbean);
			//工作流的节点配置（状态1和2可以继续走审批流，该状态不会变）
			if("1".equals(acptbean.getfCheckStauts()) || "2".equals(acptbean.getfCheckStauts())){
				bean2.setfIsReceive("1");
				//得到第一个审批节点key
				Integer firstKey = null;
				//根据资源名称和当前登陆者所属部门查询对应工作流
				TProcessDefin processDefin = new TProcessDefin();
				firstKey = tProcessCheckMng.addProcessCheck(user.getDpID(), acptbean.getJoinTable(), acptbean.getBeanCodeField(), acptbean.getBeanCode(), "HWCGYS", user);
				processDefin = tProcessDefinMng.getByBusiAndDpcode("HWCGYS", user.getDpID());
				Integer flowId = processDefin.getFPId();
				TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
				User nextUser=userMng.findById(node.getUserId());
				//设置下节点处理人姓名和编号
				acptbean.setUserName2(nextUser.getName());
				acptbean.setFuserId(nextUser.getId());
				//设置下节点节点编码
				acptbean.setnCode(firstKey + "");
				//把历史审批记录全部设置为1，表示重新审批
				tProcessCheckMng.updateStauts(flowId, acptbean.getBeanCode());
				//保存验收信息
				acptbean=(AcceptCheck)super.saveOrUpdate(acptbean);
				
				//添加审批人个人首页代办信息
				PersonalWork work = new PersonalWork();
				work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
				work.setTaskId(acptbean.getFacpId());//申请单ID
				work.setTaskCode(acptbean.getFacpCode());//为申请单的单号
				work.setTaskName("[采购验收]"+bean2.getFpName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				work.setUrl("/cgreceive/check?id="+acptbean.getFacpId());//为审批页面内容显示的url,需要将数据传入不然无法访问
				work.setUrl1("/cgreceive/detail?id="+acptbean.getFacpId());//查看url
				work.setUrl2("/cgreceive/delete?id=" + bean2.getFpId());//删除url
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
				work2.setTaskId(acptbean.getFacpId());//申请单ID
				work2.setTaskCode(acptbean.getFacpCode());//为申请单的单号
				work2.setTaskName("[采购验收]"+bean2.getFpName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				work2.setUrl("/cgreceive/receive?id=" + acptbean.getFacpId());//查看url
				work2.setUrl1("/cgreceive/detail?id=" + acptbean.getFacpId());//查看url
				work2.setUrl2("/cgreceive/delete?id=" + bean2.getFpId());//删除url
				work2.setTaskStauts("2");//已办
				work2.setType("2");//任务类型（2查看）
				work2.setTaskType("0");//任务归属（0发起人）
				work2.setBeforeUser(user.getName());//任务提交人姓名
				work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
				work2.setBeforeTime(date);//任务提交时间
				work2.setFinishTime(date);
				personalWorkMng.merge(work2);
				//推送通知到app
				if(JpushClientUtil.sendToRegistrationId(nextUser.getAccountNo(),null,"您有一条待审批任务",work.getTaskName()+"\b"+"任务编号："+work.getTaskCode(),work.getTaskId().toString(), "0","cgys")==1){
		            System.out.println("推送给指定Android用户success");
		        }
			}else {
				//保存验收信息
				acptbean=(AcceptCheck)super.saveOrUpdate(acptbean);
			}	
		//保存采购计划信息
		cgApplySqMng.saveOrUpdate(bean2);
		//保存附件信息
		attachmentMng.joinEntity(acptbean,file1);
		attachmentMng.joinEntity(acptbean,file2);
	}

	

	/*
	 * 历史验收记录
	 * @author 冉德茂
	 * @createtime 2018-07-20
	 * @updatetime 2018-07-20
	 */
	@Override
	public List<AcceptCheck> checkHistory(Integer id) {
		Finder finder = Finder.create(" FROM AcceptCheck WHERE fpId="+id);
		List<AcceptCheck> li = super.find(finder);
		return li;
	}

	@Override
	public void saveCheck(TProcessCheck checkBean, AcceptCheck acptbean, PurchaseApplyBasic bean,
			String files, User user,String zjyjfiles) throws Exception {
		AcceptCheck acptb = cgRecdiveMng.findById(acptbean.getFacpId());
		CheckEntity entity = (CheckEntity)acptb;
		String checkUrl = "/cgreceive/check?id=";
		String lookUrl = "/cgreceive/detail?id=";
		PurchaseApplyBasic beans = purchaseApplyMng.findById(acptb.getFpId());
		//查询工作流
		acptb = (AcceptCheck) tProcessCheckMng.checkProcess(checkBean, entity, user, "HWCGYS", checkUrl, lookUrl, files);
		
		//当审批通过时	把采购计划的验收状态设置为 1-验收中 	2-已验收
		if("9".equals(acptb.getfCheckStauts())){
			PurchaseApplyBasic bean2 = cgApplySqMng.findById(acptb.getFpId());
			bean2.setfIsReceive("2");
			//保存采购计划信息
			cgApplySqMng.saveOrUpdate(bean2);
		}
		if("-1".equals(acptb.getfCheckStauts())){
			PurchaseApplyBasic bean2 = cgApplySqMng.findById(acptb.getFpId());
			bean2.setfIsReceive("0");
			//保存采购计划信息
			cgApplySqMng.saveOrUpdate(bean2);
		}
		//保存验收信息
		super.saveOrUpdate(acptb);
	}



	@Override
	public String reCall(Integer id) throws Exception {
		//根据id查询对象
		AcceptCheck bean = super.findById(id);
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		PurchaseApplyBasic bean2 = cgApplySqMng.findById(bean.getFpId());
		if("1".equals(bean.getfCheckStauts())){
			bean2.setfIsReceive("0");
			//保存采购计划信息
			cgApplySqMng.saveOrUpdate(bean2);
		}
		
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="采购验收申请被撤回消息";
		String msg="您待审批的  "+bean2.getFpName() +",任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean=(AcceptCheck) reCall((CheckEntity) bean);
		this.updateDefault(bean);
		return "操作成功";
	}



	@Override
	public List<Object> mingxi(PurchaseApplyBasic bean,String type) {
		List<Object> mingxiList =new ArrayList<Object>();
		if(!StringUtil.isEmpty(type)){
			mingxiList = cgConPlanListMng.findbyIdAndType("fpId", String.valueOf(bean.getFpId()), type);
		}else{
			if(bean.getfIsContract().equals("0") && !"CGLX-01".equals(bean.getFpPype())){
				mingxiList = cgConPlanListMng.findbyIdAndType("fpId", String.valueOf(bean.getFpId()), "1");
			}else{
				ContractBasicInfo contractBasicInfo = formulationMng.findAttacByFPurchNo(String.valueOf(bean.getFpId()));
				if(!StringUtil.isEmpty(String.valueOf(contractBasicInfo.getFcId()))){
					if("9".equals(String.valueOf(contractBasicInfo.getfFlowStauts()))){
						if("0".equals(contractBasicInfo.getfUpdateStatus()) || StringUtil.isEmpty(contractBasicInfo.getfUpdateStatus())){
							mingxiList = contractPlanListMng.findbyIdAndType("fconId", String.valueOf(contractBasicInfo.getFcId()),"0");
						}else{
							List<Upt> upts = uptMng.findByFContId_U(String.valueOf(contractBasicInfo.getFcId()));
							if(upts.size()>0){
								Upt upt = upts.get(0);
								if("9".equals(upt.getfUptFlowStauts())){
									mingxiList = contractPlanListMng.findbyIdAndType("fId_U", String.valueOf(upt.getfId_U()),"1");
								}
							}
						}
					}
				}
			}
		}
		
		return mingxiList;
	}

	/*
	 * 采购验收删除
	 * @author 赵孟雷
	 * @createtime 2021-02-01
	 * @updatetime 2021-02-01
	 */
	@Override
	public void delete(Integer id, User user, String fId) {
		if(fId!=null){
			personalWorkMng.deleteById(Integer.valueOf(fId));
		}
	}
}