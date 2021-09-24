package com.braker.icontrol.assets.allcoa.manager.Impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.LookupsMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Lookups;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.icontrol.assets.allcoa.manager.AllocaListMng;
import com.braker.icontrol.assets.allcoa.manager.AllocaMng;
import com.braker.icontrol.assets.allcoa.model.Alloca;
import com.braker.icontrol.assets.allcoa.model.AllocaList;
import com.braker.icontrol.assets.storage.manager.AssetBasicInfoMng;
import com.braker.icontrol.assets.storage.manager.AssetFlowMng;
import com.braker.icontrol.contract.ending.model.Ending;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;

@Service
@Transactional
public class AllocaMngImpl extends BaseManagerImpl<Alloca> implements AllocaMng{

	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private LookupsMng lookupsMng;
	@Autowired
	private AssetFlowMng assetFlowMng;
	@Autowired
	private AssetBasicInfoMng assetBasicInfoMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private AllocaListMng allocaListMng;
	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	
	@Override
	public Pagination appJsonPagination(Alloca alloca,User user, Integer pageNo,Integer pageSize) {
		Finder finder=Finder.create(" FROM Alloca WHERE fAllocaStauts<>'99'");
		if(!StringUtil.isEmpty(alloca.getfFlowStauts())){
			finder.append(" AND fFlowStauts = :fFlowStauts");
			finder.setParam("fFlowStauts", alloca.getfFlowStauts());
		}
		if(!StringUtil.isEmpty(alloca.getfAssAllcoaCode())){
			finder.append(" AND fAssAllcoaCode LIKE :fAssAllcoaCode");
			finder.setParam("fAssAllcoaCode", "%"+alloca.getfAssAllcoaCode()+"%");
		}
		/*if(!StringUtil.isEmpty(alloca.getfTransDept())){
			finder.append(" AND fTransDept LIKE :fTransDept");
			finder.setParam("fTransDept", "%"+alloca.getfTransDept()+"%");
		}
		if(!StringUtil.isEmpty(alloca.getfRecDept())){
			finder.append(" AND fRecDept LIKE :fRecDept");
			finder.setParam("fRecDept", "%"+alloca.getfRecDept()+"%");
		}*/
		if(alloca.getfReqTime()!=null){
			finder.append(" AND DATEDIFF (fReqTime,'"+alloca.getfReqTime()+"')=0");
		}
		if(alloca.getfReqTimeBegin()!=null){
			finder.append(" AND DATE_FORMAT(fReqTime,'%Y-%m-%d') >='"+alloca.getfReqTimeBegin()+"'");
		}
		if(alloca.getfReqTimeEnd()!=null){
			finder.append(" AND DATE_FORMAT(fReqTime,'%Y-%m-%d') <='"+alloca.getfReqTimeEnd()+"'");
		}
		finder.append(" AND fRecUserId='"+user.getId()+"'"); 
		finder.append(" ORDER BY updateTime DESC"); 
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public void save(Alloca alloca, User user,String allocaFlies,String planJson) throws Exception{
		if(StringUtil.isEmpty(String.valueOf(alloca.getfId_A()))){
			alloca.setCreateTime(new Date());
			alloca.setCreator(user.getAccountNo());
			alloca.setfRecUserId(user.getId());
			alloca.setfRecUser(user.getName());
			alloca.setfRecUserId(user.getId());
			alloca.setfAllocaStauts("1");
			alloca.setfReqTime(new Date());
			alloca=(Alloca) super.saveOrUpdate(alloca);
		}else{
			alloca.setUpdateTime(new Date());
			alloca.setUpdator(user.getAccountNo());
		}
		
		//转化json
		List<AllocaList> allocaList = (List<AllocaList>) JSONArray.toList(JSONArray.fromObject(planJson), AllocaList.class);
		
		//获得资产名称集合
		List nameList = new ArrayList<>();
		for(int i=0; i<allocaList.size(); i++){
			nameList.add(allocaList.get(i).getfAssName());
		}
		//调用名称拼接方法
		String name = StringUtil.nameJoint(nameList, "、", 4);
		
		if(alloca.getfFlowStauts().equals("1")){
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),alloca.getJoinTable(),alloca.getBeanCodeField(),alloca.getBeanCode(), "ZCDB", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("ZCDB", user.getDpID());
			Integer flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			User nextUser=userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号		
			alloca.setfNextUserName(nextUser.getName());
			alloca.setfNextUserCode(nextUser.getId());
			//设置下节点节点编码
			alloca.setfNextCode(firstKey+"");	
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,alloca.getBeanCode());
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(alloca.getfNextUserCode());//任务处理人ID既是下节点处理人ID
			work.setTaskId(alloca.getfId_A());//申请单ID
			work.setTaskCode(alloca.getfAssAllcoaCode());//为申请单的单号
			work.setTaskName("[资产调拨]"+name);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/Alloca/approvalAlloca/"+alloca.getfId_A());//为审批页面内容显示的url,需要将数据传入不然无法访问
			work.setUrl1("/Alloca/detail/"+ alloca.getfId_A());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型：1-审批
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(new Date());//任务提交时间
			personalWorkMng.merge(work);
			//添加申请人个人首页已办信息
			PersonalWork minwork = new PersonalWork();
			minwork.setUserId(alloca.getfRecUserId());//任务处理人ID既是下节点处理人ID
			minwork.setTaskId(alloca.getfId_A());//申请单ID
			minwork.setTaskCode(alloca.getfAssAllcoaCode());//为申请单的单号
			minwork.setTaskName("[资产调拨]"+name);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			minwork.setUrl("/Alloca/edit/"+alloca.getfId_A());//为审批页面内容显示的url,需要将数据传入不然无法访问
			minwork.setUrl1("/Alloca/detail/"+ alloca.getfId_A());//查看url
			minwork.setUrl2("/Alloca/delete/"+ alloca.getfId_A());//
			minwork.setTaskStauts("2");//已办
			minwork.setType("2");//任务类型：2-查看
			minwork.setBeforeUser(user.getName());//任务提交人姓名
			minwork.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			minwork.setBeforeTime(new Date());//任务提交时间
			minwork.setFinishTime(new Date());
			personalWorkMng.merge(minwork);
		}
		alloca=(Alloca) super.updateDefault(alloca);
		attachmentMng.joinEntity(alloca,allocaFlies);
		
		//保存资产调拨清单表
		allocaListMng.saveList(alloca, allocaList);
		
	}

	@Override
	public void deleteById(Integer id,User user) {
		Alloca alloca = findById(Integer.valueOf(id));
		alloca.setfAllocaStauts("99");
		alloca.setUpdateTime(new Date());
		alloca.setUpdator(user.getAccountNo());
		super.saveOrUpdate(alloca);
		//删除工作台信息
		List<PersonalWork> workLost = personalWorkMng.findByCodeAndUser(alloca.getfAssAllcoaCode(), userMng.findById(alloca.getfRecUserId()));
		if(workLost.size()>0){
			for (int i = 0; i < workLost.size(); i++) {
				personalWorkMng.deleteById(workLost.get(i).getfId());
			}
		}
		
	}

	@Override
	public Pagination approvalJsonPagination(Alloca alloca,User user, Integer pageNo,Integer pageSize) {
		Finder finder=Finder.create(" FROM Alloca WHERE fAllocaStauts<>'99' AND fFlowStauts in('1','9','-1') AND fNextUserCode='"+user.getId()+"'");
		if(!StringUtil.isEmpty(alloca.getfAssAllcoaCode())){
			finder.append(" AND fAssAllcoaCode LIKE :fAssAllcoaCode");
			finder.setParam("fAssAllcoaCode", "%"+alloca.getfAssAllcoaCode()+"%");
		}
		/*if(!StringUtil.isEmpty(alloca.getfTransDept())){
			finder.append(" AND fTransDept LIKE :fTransDept");
			finder.setParam("fTransDept", "%"+alloca.getfTransDept()+"%");
		}
		if(!StringUtil.isEmpty(alloca.getfRecDept())){
			finder.append(" AND fRecDept LIKE :fRecDept");
			finder.setParam("fRecDept", "%"+alloca.getfRecDept()+"%");
		}*/
		if(alloca.getfReqTime()!=null){
			finder.append(" AND DATEDIFF (fReqTime,'"+alloca.getfReqTime()+"')=0");
		}
		if(alloca.getfReqTimeBegin()!=null){
			finder.append(" AND DATE_FORMAT(fReqTime,'%Y-%m-%d') >='"+alloca.getfReqTimeBegin()+"'");
		}
		if(alloca.getfReqTimeEnd()!=null){
			finder.append(" AND DATE_FORMAT(fReqTime,'%Y-%m-%d') <='"+alloca.getfReqTimeEnd()+"'");
		}
		finder.append(" ORDER BY updateTime DESC"); 
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public void updateStauts(Alloca bean, User user, String stauts,TProcessCheck checkBean,String file)  throws Exception {
		bean=this.findById(bean.getfId_A());
		CheckEntity entity=(CheckEntity)bean;
		String checkUrl="/Alloca/approvalAlloca/";
		String lookUrl ="/Alloca/detail/";
		bean=(Alloca)tProcessCheckMng.checkProcess(checkBean,entity,user,"ZCDB",checkUrl,lookUrl,file);
		super.saveOrUpdate(bean);
		
	}
	
	@Override
	public List<Lookups> getLookupsJson(String categoryCode,String blanked) {
		Finder hql=Finder.create("from Lookups Where flag='1' ");
		hql.append("  and category.code =:pcode ").setParam("pcode", categoryCode);
		if(!StringUtil.isEmpty(blanked)){
			hql.append(" and code<>:code").setParam("code", blanked);
		}
		hql.append(" order by convert(orderNo,SIGNED)");
		return super.find(hql);
	}

	@Override
	public Alloca findbyCondition(String condition, String val) {
		Finder finder=Finder.create(" FROM Alloca WHERE "+condition+"='"+val+"'");
		return (Alloca) super.find(finder).get(0);
	}

	@Override
	public String reCall(String id) {
		// TODO Auto-generated method stub
		Alloca bean = super.findById(Integer.valueOf(id));
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="资产调拨申请被撤回消息";
		String msg="您待审批调拨任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean=(Alloca) reCall((CheckEntity) bean);
		this.updateDefault(bean);
		return "操作成功";
		
	}
	
}
