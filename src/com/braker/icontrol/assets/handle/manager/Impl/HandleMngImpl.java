package com.braker.icontrol.assets.handle.manager.Impl;

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
import com.braker.icontrol.assets.allcoa.model.Alloca;
import com.braker.icontrol.assets.handle.manager.AssetFixedRegMng;
import com.braker.icontrol.assets.handle.manager.AssetLowRegMng;
import com.braker.icontrol.assets.handle.manager.HandleMng;
import com.braker.icontrol.assets.handle.model.AssetLowRegistration;
import com.braker.icontrol.assets.handle.model.AssetRegistration;
import com.braker.icontrol.assets.handle.model.Handle;
import com.braker.icontrol.assets.storage.manager.AssetBasicInfoMng;
import com.braker.icontrol.assets.storage.manager.AssetFlowMng;
import com.braker.icontrol.assets.storage.manager.AssetStockMng;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;

@Service
@Transactional
public class HandleMngImpl extends BaseManagerImpl<Handle> implements HandleMng{

	@Autowired
	private AssetStockMng assetStockMng;
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
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private AssetLowRegMng assetLowRegMng;
	@Autowired
	private AssetFixedRegMng assetFixedRegMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	
	
	@Override
	public Pagination applicationList(Handle handle, User user, Integer pageNo,Integer pageSize) {
		Finder finder=Finder.create(" FROM Handle WHERE fHandleStauts !='99' AND fFlowStauts IN(0,1,9,-1,-4)");
		if(!StringUtil.isEmpty(handle.getfAssHandleCode())){
			finder.append(" AND fAssHandleCode LIKE :fAssHandleCode");
			finder.setParam("fAssHandleCode", "%"+handle.getfAssHandleCode()+"%");
		}
		if(!StringUtil.isEmpty(handle.getfReqUser())){
			finder.append(" AND fReqUser LIKE :fReqUser");
			finder.setParam("fReqUser", "%"+handle.getfReqUser()+"%");
		}
		if(!StringUtil.isEmpty(handle.getfRecDept())){
			finder.append(" AND fRecDept LIKE :fRecDept");
			finder.setParam("fRecDept", "%"+handle.getfRecDept()+"%");
		}
		if(handle.getfReqTime()!=null){
			finder.append("AND DATEDIFF(fReqTime,'"+handle.getfReqTime()+"')=0");
		}
		if(!StringUtil.isEmpty(handle.getfAssType().getCode())){
			finder.append(" AND fAssType.code = :fAssType");
			finder.setParam("fAssType", handle.getfAssType().getCode());
		}
		finder.append(" AND fReqUserid ='"+user.getId()+"'");		
		finder.append(" AND fRecDeptID ='"+user.getDpID()+"'");
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
	public void save(String planJson, Handle handle, User user,String LowHandleFlies)  throws Exception{
		//保存更新资产处置信息
		if(StringUtil.isEmpty(String.valueOf(handle.getfId()))){
			handle.setCreateTime(new Date());
			handle.setCreator(user.getAccountNo());
			handle.setfReqTime(new Date());
			handle.setfHandleStauts("1");
			handle.setfRecDept(user.getDepartName());
			handle.setfReqUser(user.getName());
			handle.setfReqUserid(user.getId());
		}else {
			handle.setUpdateTime(new Date());
			handle.setUpdator(user.getAccountNo());
		}
		//资产类型
		Lookups assType = lookupsMng.findByLookCode(handle.getfAssType().getCode());
		handle.setfAssType(assType);
		handle.setfRecDeptID(user.getDpID());
		handle=(Handle) super.saveOrUpdate(handle);
		
		List<AssetLowRegistration> lowRegList = null;
		List<AssetRegistration> regList = null;
		if(handle.getfAssType().getCode().equals("ZCLX-01")){
			//低值易耗品
			lowRegList= JSONArray.toList(JSONArray.fromObject(planJson), AssetLowRegistration.class);
		}else if(handle.getfAssType().getCode().equals("ZCLX-02")){
			//固定资产
			regList= JSONArray.toList(JSONArray.fromObject(planJson), AssetRegistration.class);
		}
		//资产名称集合
		List nameList = new ArrayList<>();
		
		if(handle.getfFlowStauts().equals("1")){
			String str = null;
			if("ZCLX-01".equals(handle.getfAssType().getCode())){
				str="DZYHPCZ";
			}else if("ZCLX-02".equals(handle.getfAssType().getCode())){
				str="GDZCCZ";
			}
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),handle.getJoinTable(),handle.getBeanCodeField(),handle.getBeanCode(), str, user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode(str, user.getDpID());
			Integer flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			User nextUser=userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号		get(0)的原因是一个角色应该只能审批一级，所以查出来li应该只有一个数据
			handle.setfNextUserName(nextUser.getName());
			handle.setfNextUserCode(nextUser.getId());
			//设置下节点节点编码
			handle.setfNextCode(firstKey+"");	
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,handle.getBeanCode());
			
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(handle.getfNextUserCode());//任务处理人ID既是下节点处理人ID
			work.setTaskId(handle.getfId());//申请单ID
			work.setTaskCode(handle.getfAssHandleCode());//为申请单的单号
			if(handle.getfAssType().getCode().equals("ZCLX-01")){
				//获得低值易耗品处置清单的资产名称集合
				for(int i=0; i<lowRegList.size(); i++){
					nameList.add(lowRegList.get(i).getfAssName());
				}
				String name = StringUtil.nameJoint(nameList, "、", 4);
				work.setTaskName("[处置申请]"+name);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			}else if(handle.getfAssType().getCode().equals("ZCLX-02")){
				//获得固定资产处置清单的资产名称集合
				for(int i=0; i<regList.size(); i++){
					nameList.add(regList.get(i).getfAssName());
				}
				String name = StringUtil.nameJoint(nameList, "、", 4);
				work.setTaskName("[资产处置]"+name);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			}
			work.setUrl("/Handle/approvalHandle/"+handle.getfId());//为审批页面内容显示的url,需要将数据传入不然无法访问
			work.setUrl1("/Handle/approvalDetail/"+ handle.getfId());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型：1-审批
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(new Date());//任务提交时间
			personalWorkMng.merge(work);
			//添加已办信息
			PersonalWork minwork = new PersonalWork();
			minwork.setUserId(handle.getfReqUserid());//任务处理人ID当前申请人
			minwork.setTaskId(handle.getfId());//申请单ID
			minwork.setTaskCode(handle.getfAssHandleCode());//为申请单的单号
			if(handle.getfAssType().getCode().equals("ZCLX-01")){
				//获得低值易耗品处置清单的资产名称集合
				for(int i=0; i<lowRegList.size(); i++){
					nameList.add(lowRegList.get(i).getfAssName());
				}
				String name = StringUtil.nameJoint(nameList, "、", 4);
				minwork.setTaskName("[处置申请]"+name);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			}else if(handle.getfAssType().getCode().equals("ZCLX-02")){
				//获得固定资产处置清单的资产名称集合
				for(int i=0; i<regList.size(); i++){
					nameList.add(regList.get(i).getfAssName());
				}
				String name = StringUtil.nameJoint(nameList, "、", 4);
				minwork.setTaskName("[资产处置]"+name);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			}
			minwork.setUrl("/Handle/edit/"+handle.getfId());//为审批页面内容显示的url,需要将数据传入不然无法访问
			minwork.setUrl1("/Handle/approvalDetail/"+ handle.getfId());//查看url
			minwork.setUrl2("/Handle/delete/"+ handle.getfId());//查看url
			minwork.setTaskStauts("2");//待办
			minwork.setType("2");//任务类型：2-查看
			minwork.setBeforeUser(user.getName());//任务提交人姓名
			minwork.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			minwork.setBeforeTime(new Date());//任务提交时间
			minwork.setFinishTime(new Date());
			personalWorkMng.merge(minwork);
		}
		handle=(Handle) super.saveOrUpdate(handle);
		//保存附件
		attachmentMng.joinEntity(handle, LowHandleFlies);
		//保存处置清单
		if("ZCLX-01".equals(handle.getfAssType().getCode())){
			for (int i = 0; i < lowRegList.size(); i++) {
				lowRegList.get(i).setHandle(handle);
				lowRegList.get(i).setfAssHandleRegCode(handle.getfAssHandleCode());
				super.merge(lowRegList.get(i));
			}
		
		}else if("ZCLX-02".equals(handle.getfAssType().getCode())){
			for (int i = 0; i < regList.size(); i++) {
				regList.get(i).setHandle(handle);
				regList.get(i).setfAssHandleRegCode(handle.getfAssHandleCode());
				super.merge(regList.get(i));
			}
		}
		
	}


	@Override
	public Pagination approvalList(Handle handle, User user, Integer pageNo,Integer pageSize) {
		Finder finder=Finder.create(" FROM Handle WHERE fHandleStauts !='99' AND fFlowStauts =1");
		if(!StringUtil.isEmpty(handle.getfAssHandleCode())){
			finder.append(" AND fAssHandleCode LIKE :fAssHandleCode");
			finder.setParam("fAssHandleCode", "%"+handle.getfAssHandleCode()+"%");
		}
		if(!StringUtil.isEmpty(handle.getfReqUser())){
			finder.append(" AND fReqUser LIKE :fReqUser");
			finder.setParam("fReqUser", "%"+handle.getfReqUser()+"%");
		}
		if(!StringUtil.isEmpty(handle.getfRecDept())){
			finder.append(" AND fRecDept LIKE :fRecDept");
			finder.setParam("fRecDept", "%"+handle.getfRecDept()+"%");
		}
		if(handle.getfReqTime()!=null){
			finder.append("AND DATEDIFF(fReqTime,'"+handle.getfReqTime()+"')=0");
		}
		if(!StringUtil.isEmpty(handle.getfAssType().getCode())){
			finder.append(" AND fAssType.code = :fAssType");
			finder.setParam("fAssType", handle.getfAssType().getCode());
		}
		finder.append(" AND fNextUserCode ='"+user.getId()+"'");		
		finder.append(" order by updateTime desc");	
		return super.find(finder, pageNo, pageSize);
	}


	@Override
	public void updateStauts(String stauts, Handle handle, TProcessCheck checkBean,User user,String files)  throws Exception{
		handle=this.findById(handle.getfId());
		CheckEntity entity=(CheckEntity)handle;
		String checkUrl="/Handle/approvalHandle/";
		String lookUrl ="/Handle/detail/";
		String str = null;
		if("ZCLX-01".equals(handle.getfAssType().getCode())){
			str="DZYHPCZ";
		}else if("ZCLX-02".equals(handle.getfAssType().getCode())){
			str="GDZCCZ";
		}
		handle=(Handle)tProcessCheckMng.checkProcess(checkBean,entity,user,str,checkUrl,lookUrl,files);
		super.updateDefault(handle);
		
	}


	@Override
	public Pagination handleRegList(Handle handle, User user,Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create(" FROM Handle WHERE fHandleStauts !='99'  AND fFlowStauts=9");
	/*	if(!StringUtil.isEmpty(handle.getfAssHandleCode())){
			finder.append(" AND fAssHandleCode LIKE :fAssHandleCode");
			finder.setParam("fAssHandleCode", "%"+handle.getfAssHandleCode()+"%");
		}
		if(!StringUtil.isEmpty(handle.getfAssName())){
			finder.append(" AND fAssName LIKE :fAssName");
			finder.setParam("fAssName", "%"+handle.getfAssName()+"%");
		}
		if(!StringUtil.isEmpty(handle.getfHandleKind())){
			finder.append(" AND fHandleKind LIKE :fHandleKind");
			finder.setParam("fHandleKind", "%"+handle.getfHandleKind()+"%");
		}*/
		finder.append(" order by updateTime desc");		
		return super.find(finder, pageNo, pageSize);
	}


	@Override
	public void delete(String id, User user) {
		Handle handle = findById(Integer.valueOf(id));
		handle.setfHandleStauts("99");
		handle.setUpdateTime(new Date());
		handle.setUpdator(user.getAccountNo());
		super.merge(handle);
		//删除工作台信息
		List<PersonalWork> workLost = personalWorkMng.findByCodeAndUser(handle.getfAssHandleCode(),  userMng.findById(handle.getfReqUserid()));
		if(workLost.size()>0){
			for (int i = 0; i < workLost.size(); i++) {
				personalWorkMng.deleteById(workLost.get(i).getfId());
			}
		}
		
	}


	@Override
	public Handle findbyCode(String code) {
		Finder finder =Finder.create(" from Handle where fAssHandleCode='"+code+"'");
		return (Handle) super.find(finder).get(0);
	}


	@Override
	public Pagination lowAndFixedHandle(String fId, String fAssType) {
		//通过主键查找处置单
		Handle handle = super.findById(Integer.valueOf(fId));
		Pagination p =new Pagination();
		p.setPageNo(1);
		//区分是低值易耗品还是固定资产的处置清单表
		if("ZCLX-01".equals(fAssType)){
			//低值易耗品
			List<AssetLowRegistration> lowList = assetLowRegMng.findbyfId(handle.getfId());
			p.setList(lowList);
			p.setPageSize(lowList.size());
			p.setTotalCount(lowList.size());
			return p;
		}else if("ZCLX-02".equals(fAssType)){
			//固定资产
			List<AssetRegistration> fixedList = assetFixedRegMng.findbyfId(handle.getfId());
			p.setList(fixedList);
			p.setPageSize(fixedList.size());
			p.setTotalCount(fixedList.size());
			return p;
		}
		return null;
	}


	@Override
	public Pagination ledgerPagination(Handle handle, User user,
			Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create(" FROM Handle WHERE fHandleStauts !='99' AND fFlowStauts IN(9)");
		if(!StringUtil.isEmpty(handle.getfAssHandleCode())){
			finder.append(" AND fAssHandleCode LIKE :fAssHandleCode");
			finder.setParam("fAssHandleCode", "%"+handle.getfAssHandleCode()+"%");
		}
		if(!StringUtil.isEmpty(handle.getfReqUser())){
			finder.append(" AND fReqUser LIKE :fReqUser");
			finder.setParam("fReqUser", "%"+handle.getfReqUser()+"%");
		}
		if(!StringUtil.isEmpty(handle.getfRecDept())){
			finder.append(" AND fRecDept LIKE :fRecDept");
			finder.setParam("fRecDept", "%"+handle.getfRecDept()+"%");
		}
		if(handle.getfReqTime()!=null){
			finder.append("AND DATEDIFF(fReqTime,'"+handle.getfReqTime()+"')=0");
		}
		if(!StringUtil.isEmpty(handle.getfAssType().getCode())){
			finder.append(" AND fAssType.code = :fAssType");
			finder.setParam("fAssType", handle.getfAssType().getCode());
		}
		finder.append(" order by updateTime desc");		
		return super.find(finder, pageNo, pageSize);
	}


	@Override
	public String reCall(String id) {
		// TODO Auto-generated method stub
		Handle bean = super.findById(Integer.valueOf(id));
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="资产处置申请被撤回消息";
		String msg="您待审批处置任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean=(Handle) reCall((CheckEntity) bean);
		this.updateDefault(bean);
		return "操作成功";
	}
}
