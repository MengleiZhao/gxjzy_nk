package com.braker.icontrol.contract.archiving.manager.Impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.archiving.manager.ArchivingMng;
import com.braker.icontrol.contract.archiving.model.Archiving;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;

@Service
@Transactional
public class ArchivingMngImpl extends BaseManagerImpl<Archiving> implements ArchivingMng{

	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private PrivateInforMng privateInforMng;
	@Autowired
	private FormulationMng formulationMng;
	@Override
	public Pagination query_CBI(ContractBasicInfo contractBasicInfo,User user, Integer pageNo, Integer pageSize) {
			Finder finder =Finder.create(" FROM ContractBasicInfo WHERE fFlowStauts='9' AND fContStauts <>'99' AND fContStauts <>'-1' AND (fUpdateStatus IS NULL OR fUpdateStatus = '0')");
			if(!StringUtil.isEmpty(contractBasicInfo.getFcCode())){
				finder.append(" AND fcCode LIKE :fcCode ");
				finder.setParam("fcCode", "%"+contractBasicInfo.getFcCode()+"%");
			}
			if(!StringUtil.isEmpty(contractBasicInfo.getFcTitle())){
				finder.append(" AND fcTitle LIKE :fcTitle ");
				finder.setParam("fcTitle", "%"+contractBasicInfo.getFcTitle()+"%");
			}
			/*if(!StringUtil.isEmpty(contractBasicInfo.getFcAmount())){
				finder.append("AND fcAmount LIKE :fcAmount ");
				finder.setParam("fcAmount", "%"+contractBasicInfo.getFcAmount()+"%");
			}*/
			if("1".equals(contractBasicInfo.getFgdStauts())){
				finder.append(" AND fgdStauts = :fgdStauts ");
				finder.setParam("fgdStauts", contractBasicInfo.getFgdStauts());
			}else if("unfiled".equals(contractBasicInfo.getFgdStauts())){
				finder.append(" AND fgdStauts <>'1' ");
			}
			if(contractBasicInfo.getfReqtIME()!=null){
				finder.append(" AND datediff(fReqtIME,'"+contractBasicInfo.getfReqtIME()+"')=0 ");
			}
			//分部门或人来归档
			finder.append(" AND fOperatorId =:fOperatorId ");
			finder.setParam("fOperatorId", user.getId());
			finder.append("AND fDeptName =:fDeptName ");
			finder.setParam("fDeptName", user.getDepart().getName());
			finder.append(" order by updateTime desc");
		
		
		return super.find(finder,pageNo,pageSize);
		
	}
	
	
	
	@Override
	public Pagination query_CBIsp(ContractBasicInfo contractBasicInfo,User user, Integer pageNo, Integer pageSize) {
			Finder finder =Finder.create(" FROM ContractBasicInfo WHERE fFlowStauts='9' AND fContStauts <>'99' AND fContStauts <>'-1'");
			if(!StringUtil.isEmpty(contractBasicInfo.getFcCode())){
				finder.append("AND fcCode LIKE :fcCode ");
				finder.setParam("fcCode", "%"+contractBasicInfo.getFcCode()+"%");
			}
			if(!StringUtil.isEmpty(contractBasicInfo.getFcTitle())){
				finder.append("AND fcTitle LIKE :fcTitle ");
				finder.setParam("fcTitle", "%"+contractBasicInfo.getFcTitle()+"%");
			}
			/*if(!StringUtil.isEmpty(contractBasicInfo.getFcAmount())){
				finder.append("AND fcAmount LIKE :fcAmount ");
				finder.setParam("fcAmount", "%"+contractBasicInfo.getFcAmount()+"%");
			}*/
			if("1".equals(contractBasicInfo.getFgdStauts())){
				finder.append("AND fgdStauts = :fgdStauts ");
				finder.setParam("fgdStauts", contractBasicInfo.getFgdStauts());
			}else if("unfiled".equals(contractBasicInfo.getFgdStauts())){
				finder.append("AND fgdStauts <>'1' ");
			}
			if(contractBasicInfo.getfReqtIME()!=null){
				finder.append("AND datediff(fReqtIME,'"+contractBasicInfo.getfReqtIME()+"')=0 ");
			}
			finder.append("order by updateTime desc");
		//分部门或人来归档
		/*finder.append(" AND fOperatorId =:fOperatorId ");
		finder.setParam("fOperatorId", user.getId());
		finder.append("AND fDeptName =:fDeptName ");
		finder.setParam("fDeptName", user.getDepart().getName());*/
		
		
		return super.find(finder,pageNo,pageSize);
		
	}
	
	@Override
	public Pagination query_CBIspcb(ContractBasicInfo contractBasicInfo,User user, Integer pageNo, Integer pageSize) {
				Finder finder =Finder.create(" FROM ContractBasicInfo WHERE fFlowStauts='9' AND fContStauts <>'99' AND fContStauts <>'-1'"
						+ " AND fcId in (select fContId_tofile from Archiving  where FCheckStauts = '1' AND FNextCheckUserId = '"+user.getId()+"')");
				//finder.append("AND fOperatorId = '"+user.getId()+"'");
			if(!StringUtil.isEmpty(contractBasicInfo.getFcCode())){
				finder.append(" AND fcCode LIKE :fcCode ");
				finder.setParam("fcCode", "%"+contractBasicInfo.getFcCode()+"%");
			}
			if(!StringUtil.isEmpty(contractBasicInfo.getFcTitle())){
				finder.append(" AND fcTitle LIKE :fcTitle ");
				finder.setParam("fcTitle", "%"+contractBasicInfo.getFcTitle()+"%");
			}
			/*if(!StringUtil.isEmpty(contractBasicInfo.getFcAmount())){
				finder.append("AND fcAmount LIKE :fcAmount ");
				finder.setParam("fcAmount", "%"+contractBasicInfo.getFcAmount()+"%");
			}*/
			if("1".equals(contractBasicInfo.getFgdStauts())){
				finder.append(" AND fgdStauts = :fgdStauts ");
				finder.setParam("fgdStauts", contractBasicInfo.getFgdStauts());
			}else if("unfiled".equals(contractBasicInfo.getFgdStauts())){
				finder.append(" AND fgdStauts <>'1' ");
			}
			if(contractBasicInfo.getfReqtIME()!=null){
				finder.append(" AND datediff(fReqtIME,'"+contractBasicInfo.getfReqtIME()+"')=0 ");
			}
			finder.append(" order by updateTime desc");
		return super.find(finder,pageNo,pageSize);
	}
	
	@Override
	public Pagination query_CBIupt(Upt upt,User user, Integer pageNo, Integer pageSize) {
			Finder finder =Finder.create(" FROM Upt WHERE fUptStatus='1' AND fUptFlowStauts ='9' AND fsealedStatus=1");
			 if(!StringUtil.isEmpty(upt.getfUptCode())){
					finder.append(" AND fUptCode LIKE :fUptCode ");
					finder.setParam("fUptCode", "%"+upt.getfUptCode()+"%");
				}
				if(!StringUtil.isEmpty(upt.getfContName())){
					finder.append(" AND fContName LIKE :fContName ");
					finder.setParam("fContName", "%"+upt.getfContName()+"%");
				}
				if("1".equals(upt.getFgdstatus())){
					finder.append(" AND fgdstatus = :fgdstatus ");
					finder.setParam("fgdstatus", upt.getFgdstatus());
				}else if("unfiled".equals(upt.getFgdstatus())){
					finder.append(" AND (F_GDSTATUS <>'1' or F_GDSTATUS is null) ");
				}
				finder.append(" order by updateTime desc");
			
		return super.find(finder,pageNo,pageSize);
		
	}
	
	@Override
	public Pagination query_CBIuptsp(Upt upt,User user, Integer pageNo, Integer pageSize) {
		Finder finder =Finder.create(" FROM Upt WHERE fUptFlowStauts='9' AND fUptStatus ='1'"
				+ " AND fId_U in (select fContId_tofile from Archiving  where FCheckStauts = '1' AND FNextCheckUserId = '"+user.getId()+"')");
				/*finder.append(" AND fDeptID = :fDeptID");
				finder.setParam("fDeptID", user.getDpID());*/
			//a left join ContractBasicInfo b on a.fContCodeOld = b.F_CONT_CODE
			 if(!StringUtil.isEmpty(upt.getfUptCode())){
					finder.append(" AND fUptCode LIKE :fUptCode ");
					finder.setParam("fUptCode", "%"+upt.getfUptCode()+"%");
				}
				if(!StringUtil.isEmpty(upt.getfContName())){
					finder.append(" AND fContName LIKE :fContName ");
					finder.setParam("fContName", "%"+upt.getfContName()+"%");
				}
				if("1".equals(upt.getFgdstatus())){
					finder.append(" AND fgdstatus = :fgdstatus ");
					finder.setParam("fgdstatus", upt.getFgdstatus());
				}else if("unfiled".equals(upt.getFgdstatus())){
					finder.append(" AND fgdStauts <>'1' ");
				}
				finder.append(" order by updateTime desc");
			
		return super.find(finder,pageNo,pageSize);
		
	}
	
	@Override
	public void save(ContractBasicInfo contractBasicInfo, Archiving archiving,User user,String files) throws Exception{
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date d = new Date();
		List<Archiving> findByContId = findByContId(contractBasicInfo.getFcId().toString());
		ContractBasicInfo findById = formulationMng.findById(contractBasicInfo.getFcId());
		findById.setFsealedStatus(1);
		findById.setFgdStauts("1");
		super.merge(findById);
		Archiving archivings = new Archiving();
		if (findByContId.size()<1) {
			archivings.setFBeforeTime(d);
			archivings.setFUserId(user.getId());
			archivings.setFBeforeDepart(user.getDepartName());
			//contractBasicInfo.setfDeptId(user.getDepart().getId());
			
			//创建人、创建时间、申请单编号
			archivings.setFBeforeUser(user.getName());
			archivings.setfToCode(StringUtil.Random("HTGD"));
			archivings.setfToUser(user.getAccountNo());
			archivings.setfToTime(d);
			archivings.setfContId_tofile(contractBasicInfo.getFcId());
			archivings.setFBeforeDepartid(user.getDpID());
			archivings.setFqdTime(archiving.getFqdTime());
			//设置合同待审批
			//contractBasicInfo.setFgdStauts("0");
			//设置归档审批状态
			archivings.setFCheckStauts("1");
			//归档位置
			//archiving.setfToPosition(contractBasicInfo.getFcCode());
			
			//设置下节点节点编码
			//contractBasicInfo.setfNCode(firstKey+"");	//下节点节点编码
			//archiving.setFBeanCode(StringUtil.Random("GD"));
			//super.saveOrUpdate(archivings);
		}else {
			archivings =findByContId.get(0);
			archivings.setfToTime(d);
			archivings.setFBeforeTime(d);
			//设置归档审批状态
			archivings.setFCheckStauts("1");
			archivings.setFqdTime(archiving.getFqdTime());
			//super.saveOrUpdate(findByContId.get(0));
		}
		archivings = (Archiving) super.merge(archivings);
		/*if(("1").equals(archivings.getFCheckStauts())){
			Integer flowId =0;
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),archivings.getJoinTable(),archivings.getBeanCodeField(),archivings.getBeanCode(),"HTGD", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("HTGD", user.getDpID());
			flowId= processDefin.getFPId();
			User nextUser = new User();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			nextUser=userMng.findById(node.getUserId());
			archivings.setFNextCheckUserName(nextUser.getName());//下环节处理人 姓名
			archivings.setFNextCheckUserId(nextUser.getId());//下环节处理人 编码
			//archiving.setFUserId(nextUser.getId());//用户id
			archivings.setFNextCheckKey(String.valueOf(node.getKeyId()));
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(archivings.getFNextCheckUserId());//任务处理人ID既是下节点处理人 ID
			work.setTaskId(contractBasicInfo.getFcId());//申请单ID
			work.setTaskCode(archivings.getfToCode());//为申请单的单号
			work.setTaskName("[合同归档审批]"+contractBasicInfo.getFcTitle());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/Archiving/editsp/"+contractBasicInfo.getFcId());//为审批页面内容显示的url,需要将数据传入不然无法访问
			work.setUrl1("/Archiving/detailsp/"+ contractBasicInfo.getFcId());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型：1-审批
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(archivings.getFBeforeTime());//任务提交时间
			personalWorkMng.merge(work);
			//添加自己的已办信息
			PersonalWork minwork = new PersonalWork();
			minwork.setUserId(user.getId());//任务处理人ID既是下节点处理人ID
			minwork.setTaskId(Integer.valueOf(archivings.getfToId()));//申请单ID
			minwork.setTaskCode(archivings.getfToCode());//为申请单的单号
			minwork.setTaskName("[归档申请]"+contractBasicInfo.getFcTitle());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			minwork.setUrl("/Archiving/edit/"+contractBasicInfo.getFcId());//为审批页面内容显示的url,需要将数据传入不然无法访问
			minwork.setUrl1("/Archiving/detail/"+ contractBasicInfo.getFcId());//查看url
			minwork.setUrl2("/Archiving/detail/"+ contractBasicInfo.getFcId());//，没有删除按钮，不存在删除，所有填写查看路径
			minwork.setTaskStauts("2");//已办
			minwork.setType("2");//任务类型：2-查看
			minwork.setBeforeUser(user.getName());//任务提交人姓名
			minwork.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			minwork.setBeforeTime(new Date());//任务提交时间
			minwork.setFinishTime(new Date());
			personalWorkMng.merge(minwork);
		}*/
		attachmentMng.joinEntity(archivings,files);
	}

	/**
	 * 保存変更数据
	 * @param contractBasicInfo
	 * @param archiving
	 * @param user
	 * @throws Exception
	 */
	@Override
	public void savebg(ContractBasicInfo contractBasicInfo, Archiving archiving,User user,Upt upt,String files) throws Exception{
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date d = new Date();
		List<Archiving> findByContId = findByContId(upt.getfId_U().toString());
		Archiving archivings = new Archiving();
		if (findByContId.size()<1) {
			
			archivings.setFBeforeTime(d);
			archivings.setFUserId(user.getId());
			archivings.setFBeforeDepart(user.getDepartName());
			//contractBasicInfo.setfDeptId(user.getDepart().getId());
			//创建人、创建时间、申请单编号
			archivings.setFBeforeUser(user.getName());
			archivings.setfToCode(StringUtil.Random("HTGD"));
			archivings.setfToUser(user.getAccountNo());
			archivings.setfToTime(d);
			archivings.setfContId_tofile(upt.getfId_U());
			archivings.setFBeforeDepartid(user.getDpID());
			archivings.setFqdTime(archivings.getFqdTime());
			//设置合同待审批
			//contractBasicInfo.setFgdStauts("0");
			//设置归档审批状态
			archivings.setFCheckStauts("1");
			//归档位置
			//archiving.setfToPosition(contractBasicInfo.getFcCode());
			//archiving.setFBeanCode(StringUtil.Random("GD"));
		}else {
			archivings =findByContId.get(0);
			archivings.setfToTime(d);
			archivings.setFBeforeTime(d);
			//设置归档审批状态
			archivings.setFCheckStauts("1");
			archivings.setFqdTime(archiving.getFqdTime());
			//super.saveOrUpdate(findByContId.get(0));
		}
		archivings = (Archiving) super.merge(archivings);
		if(("1").equals(archivings.getFCheckStauts())){
			Integer flowId =0;
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),archivings.getJoinTable(),archivings.getBeanCodeField(),archivings.getBeanCode(),"HTGD", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("HTGD", user.getDpID());
			flowId= processDefin.getFPId();
			User nextUser = new User();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			nextUser=userMng.findById(node.getUserId());
			archivings.setFNextCheckUserName(nextUser.getName());//下环节处理人 姓名
			archivings.setFNextCheckUserId(nextUser.getId());//下环节处理人 编码
			archivings.setFNextCheckKey(String.valueOf(node.getKeyId()));
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(archivings.getFNextCheckUserId());//任务处理人ID既是下节点处理人 ID
			work.setTaskId(upt.getfId_U());//申请单ID
			work.setTaskCode(archivings.getfToCode());//为申请单的单号
			work.setTaskName("[合同归档审批]"+upt.getfContName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/Archiving/editbgsp/"+upt.getfId_U());//为审批页面内容显示的url,需要将数据传入不然无法访问
			work.setUrl1("/Archiving/detailbgsp/"+ upt.getfId_U());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型：1-审批
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(archivings.getFBeforeTime());//任务提交时间
			personalWorkMng.merge(work);
			//添加自己的已办信息
			PersonalWork minwork = new PersonalWork();
			minwork.setUserId(user.getId());//任务处理人ID既是下节点处理人ID
			minwork.setTaskId(Integer.valueOf(archivings.getfToId()));//申请单ID
			minwork.setTaskCode(archivings.getfToCode());//为申请单的单号
			minwork.setTaskName("[归档申请]"+upt.getfContName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			minwork.setUrl("/Archiving/editbg/"+upt.getfId_U());//为审批页面内容显示的url,需要将数据传入不然无法访问
			minwork.setUrl1("/Archiving/detailbg/"+ upt.getfId_U());//查看url
			minwork.setUrl2("/Archiving/detailbg/"+ upt.getfId_U());//，没有删除按钮，不存在删除，所有填写查看路径
			minwork.setTaskStauts("2");//已办
			minwork.setType("2");//任务类型：2-查看
			minwork.setBeforeUser(user.getName());//任务提交人姓名
			minwork.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			minwork.setBeforeTime(new Date());//任务提交时间
			minwork.setFinishTime(new Date());
			personalWorkMng.merge(minwork);
		}
		attachmentMng.joinEntity(archivings,files);
	}
	
	@Override
	public List<Archiving> findByContId(String id) {
		Finder finder = Finder.create(" FROM Archiving WHERE fContId_tofile="+Integer.valueOf(id));
		return super.find(finder);
	}

	@Override
	public Pagination query_CBI_Archiving(ContractBasicInfo contractBasicInfo,User user, Integer pageNo, Integer pageSize) {
		Finder finder =Finder.create(" FROM ContractBasicInfo WHERE fFlowStauts='9' AND fContStauts='3' ");
		//分部门或人来归档
		/*finder.append("AND fOperator =:fOperator ");
		finder.setParam("fOperator", user.getAccountNo());
		finder.append("AND fDeptName =:fDeptName ");
		finder.setParam("fDeptName", user.getDepart().getName());
		*/
		if(!StringUtil.isEmpty(contractBasicInfo.getFcCode())){
			finder.append("AND fcCode LIKE :fcCode ");
			finder.setParam("fcCode", "%"+contractBasicInfo.getFcCode()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcTitle())){
			finder.append("AND fcTitle LIKE :fcTitle ");
			finder.setParam("fcTitle", "%"+contractBasicInfo.getFcTitle()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getfOperator())){
			finder.append("AND fOperator LIKE :fOperator ");
			finder.setParam("fOperator", "%"+contractBasicInfo.getfOperator()+"%");
		}
		if(contractBasicInfo.getfReqtIME()!=null){
			finder.append("AND fReqtIME = :fReqtIME ");
			finder.setParam("fReqtIME", contractBasicInfo.getfReqtIME());
		}
		return super.find(finder,pageNo,pageSize);
	}
	@Override
	public List<ContractBasicInfo> findByContIds(String id) {
		Finder finder = Finder.create(" FROM ContractBasicInfo WHERE fcId="+Integer.valueOf(id));
		return super.find(finder);
	}

	@Override
	public void saveCheckInfo(TProcessCheck checkBean, Archiving bean,User user,String files,String stauts,String type) throws Exception {
		bean = this.findById(bean.getfToId());
		CheckEntity entity=(CheckEntity)bean;
		String checkUrl="/Archiving/editbgsp?id=";
		String lookUrl ="/Archiving/detailbgsp?id=";
		bean=(Archiving)tProcessCheckMng.checkProcess(checkBean,entity,user,"HTGD",checkUrl,lookUrl,files);
		
		if (("9").equals(bean.getCheckStauts())) {
			String sql="";
			if(StringUtil.isEmpty(type)){
				sql="update T_CONTRACT_BASIC_INFO set F_GDSTATUS='1' where F_CONT_ID ="+bean.getfContId_tofile();
			}else{
				sql="update T_CONTRACT_UPT set F_GDSTATUS='1' where F_UPT_STAUTS<>99 and F_ID ="+bean.getfContId_tofile();
			}
			Query query=getSession().createSQLQuery(sql);
			query.executeUpdate();
		}
		super.saveOrUpdate(bean);
		
	}

	
	@Override
	public void saveCheckInfobg(TProcessCheck checkBean, Archiving bean,User user,String files,String stauts) throws Exception {
		bean = this.findById(bean.getfToId());
		CheckEntity entity=(CheckEntity)bean;
		String checkUrl="/Archiving/editsp?id=";
		String lookUrl ="/Archiving/detailsp?id=";
		//转换type选择流程
		//String strType = tProcessCheckMng.JudgmentProcess(String.valueOf(bean.getType()));
		/*if("GWCX".equals(bean.getTravelType())){
			strType = "CXSQ";
		}*/
		/*if(bean.getType().equals("5")){
			ReceptionAppliInfo	receptionBean = (ReceptionAppliInfo) applyMng.getObject("ReceptionAppliInfo", "gId", bean.getgId());
			if(receptionBean.getReceptionLevel1().equals("2")){
				if(receptionBean.getIsForeign().equals("1")){
					strType = "GWJDSQ-WB";
				}else{
					strType = "GWJDSQ-YJYX";
				}
			}
		}*/
			bean=(Archiving)tProcessCheckMng.checkProcess(checkBean,entity,user,"HTGD",checkUrl,lookUrl,files);
		
			if (("9").equals(bean.getCheckStauts())) {
				String sql="update T_CONTRACT_BASIC_INFO set F_GDSTATUS='1' where F_CONT_ID ="+bean.getfContId_tofile();
				Query query=getSession().createSQLQuery(sql);
				query.executeUpdate();
			}
		super.saveOrUpdate(bean);
		
	}



	@Override
	public void delete_CBI(String id, User user) {
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String sql="delete FROM T_CONTRACT_TOFILE WHERE F_CONT_ID ='"+id+"'";
		Query  contStauts=getSession().createSQLQuery(sql);
		contStauts.executeUpdate();
		//删除相关工作台信息
		/*Archiving findById = findById(Integer.valueOf(id));
		List<PersonalWork> worklost = personalWorkMng.findByCodeAndUser(findById.getfToCode(), userMng.findById(findById.getFBeforeDepartid()));
		if(worklost.size()>0){
			for (int i = 0; i < worklost.size(); i++) {
				personalWorkMng.deleteById(Integer.valueOf(worklost.get(i).getfId()));
			}
		}*/
	}
	
	@Override
	public String reCall(String id) {
		List<Archiving> findByContId = findByContId(id);
		//删除待办
		personalWorkMng.deleteDb(findByContId.get(0).getNextCheckUserId() , findByContId.get(0).getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="合同归档申请被撤回消息";
		String msg="您待审批合同  "+findByContId.get(0).getfToCode() +",任务编号：("+findByContId.get(0).getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, findByContId.get(0).getNextCheckUserId(), "3");
		//撤回
		Archiving archiving = (Archiving) reCall((CheckEntity) findByContId.get(0));
		this.updateDefault(archiving);
		return "操作成功";
		
		
	}
	
}
