package com.braker.icontrol.assets.maintain.manager.Impl;

import java.util.Date;
import java.util.List;

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
import com.braker.core.manager.UserMng;
import com.braker.core.model.Lookups;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.icontrol.assets.maintain.manager.MaintainMng;
import com.braker.icontrol.assets.maintain.model.Maintain;
import com.braker.icontrol.assets.storage.manager.AssetBasicInfoMng;
import com.braker.icontrol.assets.storage.manager.AssetFlowMng;
import com.braker.icontrol.assets.storage.model.AssetBasicInfo;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;

@Service
@Transactional
public class MaintainMngImpl extends BaseManagerImpl<Maintain> implements MaintainMng{

	@Autowired
	private LookupsMng lookupsMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	@Autowired
	private AssetFlowMng assetFlowMng;
	@Autowired
	private AssetBasicInfoMng assetBasicInfoMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private TNodeDataMng tNodeDataMng;
	
	@Autowired
	private UserMng userMng;
	
	@Override
	public Pagination list(Maintain maintain,User user, String sort, String order,Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create( "FROM Maintain WHERE fMainStauts=1 and fMainUserID='"+user.getId()+"'");
		if(!StringUtil.isEmpty(maintain.getfAssName())){
			finder.append(" AND fAssName LIKE :fAssName");
			finder.setParam("fAssName", "%"+maintain.getfAssName()+"%");
		}
		if(!StringUtil.isEmpty(maintain.getfAssCode())){
			finder.append(" AND fAssCode LIKE :fAssCode");
			finder.setParam("fAssCode", "%"+maintain.getfAssCode()+"%");
		}
		if(maintain.getfRepairTimeStart()!=null){
			finder.append(" AND DATE_FORMAT(fRepairTime,'%Y-%m-%d') >= "+maintain.getfRepairTimeStart());
		}
		if(maintain.getfRepairTimeEnd()!=null){
			finder.append(" AND DATE_FORMAT(fRepairTime,'%Y-%m-%d') <= "+maintain.getfRepairTimeEnd());
		}
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
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
	public void save(Maintain maintain, String files, String storageFiles,User user) throws Exception{
		
		if(StringUtil.isEmpty(String.valueOf(maintain.getfID()))){
			//新增
			maintain.setCreateTime(new Date());
			maintain.setCreator(user.getAccountNo());
			maintain.setfRegStauts("0");
			maintain.setfMainTime(new Date());
			Lookups mainWhether = lookupsMng.findByLookCode(maintain.getMainWhether());
			maintain.setfMainWhether(mainWhether);
			maintain.setfMainStauts("1");
		}else {
			//暂存更新
			Lookups mainWhether = lookupsMng.findByLookCode(maintain.getMainWhether());
			maintain.setfMainWhether(mainWhether);
			maintain.setUpdateTime(new Date());
			maintain.setUpdator(user.getAccountNo());
		}
		/*//如果产生费用则需要保存指标信息主键等
		if("sfcswxfy-01".equals(maintain.getMainWhether())){
			maintain.setBudgetIndexMgr(budgetIndexMgrMng.findById(maintain.getbId()));
		}*/
		//如果是送审状态则需要添加代办事项
		if("1".equals(maintain.getfFlowStauts())){
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),maintain.getJoinTable(),maintain.getBeanCodeField(),maintain.getBeanCode(), "GDZCWX", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("GDZCWX", user.getDpID());
			Integer flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			User nextUser=userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号		get(0)的原因是一个角色应该只能审批一级，所以查出来li应该只有一个数据
			maintain.setfNextUserName(nextUser.getName());
			maintain.setfNextUserCode(nextUser.getId());
			//设置下节点节点编码
			maintain.setfNextCode(firstKey+"");	
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,maintain.getBeanCode());
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(maintain.getfNextUserCode());//任务处理人ID既是下节点处理人ID
			work.setTaskId(maintain.getfID());//申请单ID
			work.setTaskCode(maintain.gettAssetMainCode());//为申请单的单号
			work.setTaskName(maintain.getfAssName()+"维修审批");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/Maintain/approvalMaintain/"+maintain.getfID());//为审批页面内容显示的url,需要将数据传入不然无法访问
			work.setUrl1("/Maintain/detail/"+ maintain.getfID());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型：1-审批
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(new Date());//任务提交时间
			personalWorkMng.merge(work);
			//添加一个自己的已办事项
			PersonalWork minwork = new PersonalWork();
			minwork.setUserId(user.getId());//任务处理人ID既是下节点处理人ID
			minwork.setTaskId(maintain.getfID());//申请单ID
			minwork.setTaskCode(maintain.gettAssetMainCode());//为申请单的单号
			minwork.setTaskName(maintain.getfAssName()+"维修申请");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			minwork.setUrl("/Maintain/edit/"+maintain.getfID());//退回修改url
			minwork.setUrl1("/Maintain/detail/"+ maintain.getfID());//查看url
			minwork.setUrl2("/Maintain/delete/"+ maintain.getfID());//退回删除url
			minwork.setTaskStauts("2");//待办
			minwork.setType("2");//任务类型：2-查看
			minwork.setBeforeUser(user.getName());//任务提交人姓名
			minwork.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			minwork.setBeforeTime(new Date());//任务提交时间
			minwork.setFinishTime(new Date());
			personalWorkMng.merge(minwork);
		}
		maintain=(Maintain) super.saveOrUpdate(maintain);
		attachmentMng.joinEntity(maintain,files);
	}

	@Override
	public void delete(Integer id) {
		Maintain m = super.findById(Integer.valueOf(id));
		m.setfMainStauts("99");
		super.saveOrUpdate(m);
	}

	@Override
	public Pagination approvalList(Maintain maintain,User user, String sort,String order, Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create( "FROM Maintain WHERE fMainStauts=1 and fFlowStauts=1 and fNextUserCode='"+user.getId()+"'");
		if(!StringUtil.isEmpty(maintain.getfAssName())){
			finder.append(" AND fAssName LIKE :fAssName");
			finder.setParam("fAssName", "%"+maintain.getfAssName()+"%");
		}
		if(!StringUtil.isEmpty(maintain.getfAssCode())){
			finder.append(" AND fAssCode LIKE :fAssCode");
			finder.setParam("fAssCode", "%"+maintain.getfAssCode()+"%");
		}
		if(maintain.getfRepairTimeStart()!=null){
			finder.append(" AND DATE_FORMAT(fRepairTime,'%Y-%m-%d') >= "+maintain.getfRepairTimeStart());
		}
		if(maintain.getfRepairTimeEnd()!=null){
			finder.append(" AND DATE_FORMAT(fRepairTime,'%Y-%m-%d') <= "+maintain.getfRepairTimeEnd());
		}
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public void approveMaintain(String id, User user,TProcessCheck checkBean,String files)  throws Exception{
		Maintain bean=this.findById(Integer.parseInt(id));
		CheckEntity entity=(CheckEntity)bean;
		String checkUrl="/Maintain/approvalMaintain/";
		String lookUrl ="/Maintain/detail/";
		bean=(Maintain)tProcessCheckMng.checkProcess(checkBean,entity,user,"GDZCWX",checkUrl,lookUrl,files);
		super.saveOrUpdate(bean);
		if(bean.getfFlowStauts().equals("9")){
			//资产流水操作类型
			Lookups zclsczlx = lookupsMng.findByLookCode("ZCLSCZLX-05");
			//资产类型
			Lookups zclx = lookupsMng.findByLookCode("ZCLX-02");
			List<AssetBasicInfo> abi = assetBasicInfoMng.findbycode(bean.getfAssCode());
			//更改资产状态、使用人和使用部门
			Lookups zczt = lookupsMng.findByLookCode("ZCZT-04");
			//添加一条流水记录
			assetFlowMng.addFlow(user, zclsczlx, bean.gettAssetMainCode(), bean.getfAssCode(), bean.getfAssName(), zclx, abi.get(0).getfMeasUnit(), 1);
			abi.get(0).setfAssStauts(zczt);
			assetBasicInfoMng.merge(abi.get(0));
		}
	}

	@Override
	public Pagination regList(Maintain maintain, User user, String sort,String order, Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create( "FROM Maintain WHERE fMainStauts=1 and fRegStauts=0 and fMainUserID='"+user.getId()+"'");
		if(!StringUtil.isEmpty(maintain.getfAssName())){
			finder.append(" AND fAssName LIKE :fAssName");
			finder.setParam("fAssName", "%"+maintain.getfAssName()+"%");
		}
		if(!StringUtil.isEmpty(maintain.getfAssCode())){
			finder.append(" AND fAssCode LIKE :fAssCode");
			finder.setParam("fAssCode", "%"+maintain.getfAssCode()+"%");
		}
		if(maintain.getfRepairTimeStart()!=null){
			finder.append(" AND DATE_FORMAT(fRepairTime,'%Y-%m-%d') >= "+maintain.getfRepairTimeStart());
		}
		if(maintain.getfRepairTimeEnd()!=null){
			finder.append(" AND DATE_FORMAT(fRepairTime,'%Y-%m-%d') <= "+maintain.getfRepairTimeEnd());
		}
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}
	
	
}
