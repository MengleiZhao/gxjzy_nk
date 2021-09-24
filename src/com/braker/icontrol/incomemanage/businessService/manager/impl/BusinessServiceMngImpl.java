package com.braker.icontrol.incomemanage.businessService.manager.impl;

import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import net.sf.json.JSONArray;

import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Condition;
import com.braker.common.hibernate.Finder;
import com.braker.common.hibernate.OrderBy;
import com.braker.common.hibernate.Updater;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.LookupsMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Category;
import com.braker.core.model.Lookups;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.incomemanage.businessService.manager.BusinessServiceMng;
import com.braker.icontrol.incomemanage.businessService.model.BusinessServiceDetails;
import com.braker.icontrol.incomemanage.businessService.model.BusinessServiceInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 
 * @Description 经营服务性收入的实现类
 * @author 汪耀
 * @date : 2019年11月4日 下午5:19:29
 */
@Service
@Transactional
public class BusinessServiceMngImpl extends BaseManagerImpl<BusinessServiceInfo> implements
		BusinessServiceMng {
	
	@Autowired
	private UserMng userMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private LookupsMng lookupsMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	@Autowired
	private DepartMng departMng;
	
	@Override
	public Pagination pageList(BusinessServiceInfo bean, int page,
			int rows, User user,String fBusiCode,String fProName,String fDeptName,String fType) {
		//查询条件
		StringBuilder sbf = new StringBuilder("SELECT * FROM T_BUSINESS_SERVICE_INFO WHERE F_STATUS<>99 ");
		//审批成功后审批页面不可见
		if(!StringUtil.isEmpty(bean.getfFlowStatus())){
			if("2".equals(bean.getfFlowStatus())){	
				sbf.append(" and F_NEXT_USER_ID = '" + user.getId() + "'");
			}
		}else{
			sbf.append(" and F_OPERATOR_ID='"+user.getId()+"'");
		}
//		if(!StringUtil.isEmpty(bean.getfBusiCode())){
//			sbf.append(" and (concat(F_BUSI_CODE,',',F_PRO_NAME,',',F_DEPT_NAME,',',F_OPERATOR_NAME,',',F_BUSI_TIME) LIKE '%"+bean.getfBusiCode()+"%')");
//		}
		if(!StringUtil.isEmpty(fBusiCode)){
			sbf.append(" and F_BUSI_CODE like '%"+fBusiCode+"%'");
		}
		if(!StringUtil.isEmpty(fProName)){
			sbf.append(" and F_PRO_NAME like '%"+fProName+"%'");
		}
		if(!StringUtil.isEmpty(fDeptName)){
			sbf.append(" and F_DEPT_NAME like '%"+fDeptName+"%'");
		}
		if(!StringUtil.isEmpty(fType)){
			sbf.append(" and F_FLOW_STATUS like '%"+fType+"%'");
		}
		sbf.append(" order by F_BUSI_TIME desc ");
		String str=sbf.toString();
		Pagination p = super.findBySql(new BusinessServiceInfo(), str, page, rows);
		return p;
	}
	@Override
	public Pagination pageLedgerList(BusinessServiceInfo bean, int page, int rows, User user) {
		//查询条件
		Finder finder = Finder.create(" FROM BusinessServiceInfo WHERE fStatus <> 99");
		if(user.getRoleName().contains("出纳岗")){
			
		}else{
			String deptIdStr=departMng.getDeptIdStrByUser(user);
			if("".equals(deptIdStr)){ //普通岗位只能查看自己的
				finder.append(" and fOperatorId='"+user.getId()+"'");
			}else if("all".equals(deptIdStr)){//校长可以查看所有人的
				
			}else{//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
				finder.append(" and fDeptId in ("+deptIdStr+")");
			}
			//sbf.append(" and F_INCOME_USER_ID='"+user.getId()+"'");
		}
		//根据立项单号模糊查询
		if (!StringUtil.isEmpty(String.valueOf(bean.getfBusiCode()))) {
			finder.append(" AND fBusiCode LIKE '%" + bean.getfBusiCode() + "%'");
		}
		//根据立项单号模糊查询
		if (!StringUtil.isEmpty(String.valueOf(bean.getfProName()))) {
			finder.append(" AND fProName LIKE '%" + bean.getfProName() + "%'");
		}
		//根据立项单号模糊查询
		if (!StringUtil.isEmpty(String.valueOf(bean.getfDeptName()))) {
			finder.append(" AND fDeptName LIKE '%" + bean.getfDeptName() + "%'");
		}
		//审批成功后审批页面不可见
		if(!StringUtil.isEmpty(bean.getfFlowStatus())){
			if("2".equals(bean.getfFlowStatus())){	
				finder.append(" AND fNextUserId = '" + user.getId() + "'");
			}
		}
		//按时间排序-倒序
		finder.append(" order by updateTime desc");
		Pagination p = super.find(finder, page, rows);
		List<BusinessServiceInfo> list = (List<BusinessServiceInfo>) p.getList();
		for (int i = 0; i < list.size(); i++) {
			//序号设置
			list.get(i).setNum((i + 1) + (page - 1) * rows);
		}
		return p;
	}

	@Override
	public void save(BusinessServiceInfo bean, String files, String mingxi, User user) throws Exception {
		Date date = new Date();
		//保存基本信息
		if(bean.getfBusiId() == null){//新增
			//创建人、创建时间 
			bean.setCreator(user.getName());
			bean.setCreateTime(date);
			//申请人id、申请部门id、申请部门
			bean.setfOperatorId(user.getId());
			bean.setfDeptId(user.getDpID());
			bean.setfDeptName(user.getDepartName());
			bean.setRegisterStatus("0");
		}else {//修改
			//修改人、修改时间
			bean.setUpdator(user.getName());
			bean.setUpdateTime(date);
		}
		//工作流的节点配置（状态1和2可以继续走审批流，该状态不会变）
		if("1".equals(bean.getfFlowStatus()) || "2".equals(bean.getfFlowStatus())){
			//得到第一个审批节点key
			Integer firstKey = tProcessCheckMng.addProcessCheck(user.getDpID(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getBeanCode(), "PXSRLXSQ", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin =  tProcessDefinMng.getByBusiAndDpcode("PXSRLXSQ", user.getDpID());
			Integer flowId = processDefin.getFPId();
			TNodeData node = tNodeDataMng.getByFlowIdAndKey(flowId, firstKey);
			User nextUser = userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号
			bean.setfNextUserName(nextUser.getName());
			bean.setfNextUserId(nextUser.getId());
			//设置下节点节点编码
			bean.setfNextCode(String.valueOf(firstKey));
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId, bean.getBeanCode());
			//保存基本信息
			bean = (BusinessServiceInfo) super.saveOrUpdate(bean);
					
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getfBusiId());//申请单ID
			work.setTaskCode(bean.getfBusiCode());//为申请单的单号
			work.setTaskName("[培训类收入立项申请]" + bean.getfProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/business/check?id=" + bean.getfBusiId());//为审批页面内容显示的url,需要将数据传入不然无法访问
			work.setUrl1("/business/detail?id=" + bean.getfBusiId());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型：1-审批
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(date);//任务提交时间
			personalWorkMng.merge(work);
					
			//添加一个自己的已办事项
			PersonalWork minwork = new PersonalWork();
			minwork.setUserId(user.getId());//任务处理人ID既是下节点处理人ID
			minwork.setTaskId(bean.getfBusiId());//申请单ID
			minwork.setTaskCode(bean.getfBusiCode());//为申请单的单号
			minwork.setTaskName("[培训类收入立项申请]" + bean.getfProName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			minwork.setUrl("/business/edit?id=" + bean.getfBusiId());//退回修改url
			minwork.setUrl1("/business/detail?id=" + bean.getfBusiId());//查看url
			minwork.setUrl2("/business/delete?id=" + bean.getfBusiId());//退回删除url
			minwork.setTaskStauts("2");//待办
			minwork.setType("2");//任务类型：2-查看
			minwork.setBeforeUser(user.getName());//任务提交人姓名
			minwork.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			minwork.setBeforeTime(date);//任务提交时间
			minwork.setFinishTime(date);
			personalWorkMng.merge(minwork);
		}else {
			//保存基本信息
			bean = (BusinessServiceInfo) super.saveOrUpdate(bean);
		}		
		//保存附件信息
		attachmentMng.joinEntity(bean, files);
		
		/*//保存详情表--作废
		//获得老的明细
		List<Object> oldList = getDetailsList("BusinessServiceDetails", "fbId", bean.getfBusiId());
		//获取新的明细
		List nowList = getDetailsJson(mingxi, BusinessServiceDetails.class);
		if(oldList.size() > 0){//修改明细
			//比较新老明细的不同
			for (int i = oldList.size()-1; i >= 0; i--) {
				BusinessServiceDetails old = (BusinessServiceDetails) oldList.get(i);
				for (int j = 0; j < nowList.size(); j++) {
					BusinessServiceDetails now = (BusinessServiceDetails) nowList.get(j);
					if(now.getFdId() != null){
						if(now.getFdId() == old.getFdId()){
							oldList.remove(i);
						}
					}
				}
			}
			//删除在新明细中没有的老明细
			if(oldList.size() > 0){
				for (int i = 0; i < oldList.size(); i++) {
					BusinessServiceDetails old = (BusinessServiceDetails) oldList.get(i);
					super.delete(old);
				}
			}
			//保存新的明细
			for (int i = 0; i < nowList.size(); i++) {
				BusinessServiceDetails now = (BusinessServiceDetails) nowList.get(i);
				now.setFbId(bean.getfBusiId());
				now.setUpdator(user.getName());
				now.setUpdateTime(date);
				super.merge(now);
			}
		}else {//新增明细
			//保存新的明细
			for (int i = 0; i < nowList.size(); i++) {
				BusinessServiceDetails now = (BusinessServiceDetails) nowList.get(i);
				now.setFbId(bean.getfBusiId());
				now.setCreator(user.getName());
				now.setCreateTime(date);
				super.merge(now);
			}
		}*/
	}
	
	@Override
	public List<Object> getDetailsList(String tableName, String column,
			Integer id) {
		Finder finder = Finder.create(" FROM " + tableName + " WHERE " + column + " = '" + id + "'");
		return super.find(finder);
	}
	
	@Override
	public List getDetailsJson(String mingxi, Class tableClass) {
		//获取明细的Json对象
		JSONArray array = JSONArray.fromObject("[" + mingxi.toString() + "]");
		List list = (List)JSONArray.toList(array, tableClass);
		return list;
	}
	
	@Override
	public void delete(Integer id) {
		BusinessServiceInfo bean = super.findById(id);
		bean.setfStatus("99");
		super.saveOrUpdate(bean);
	}

	@Override
	public void saveCheck(TProcessCheck checkBean, BusinessServiceInfo bean,
			String files, User user) throws Exception {
		BusinessServiceInfo busiBean = this.findById(bean.getfBusiId());
		CheckEntity entity = (CheckEntity)busiBean;
		//设置下一级审批人待办和查看路径
		String checkUrl = "/business/check?id=";
		String lookUrl = "/business/detail?id=";
		//查询审批流程
		busiBean = (BusinessServiceInfo)tProcessCheckMng.checkProcess(checkBean, entity, user, "PXSRLXSQ", checkUrl, lookUrl, files);
		
		//审批成功后将收费项目添加到字典项中
		/*if("9".equals(busiBean.getfFlowStatus())){
			//经营服务性收入的字典项中的最大排序号
			Integer orderNo = Integer.valueOf(getOrderNoByLookUpCode("JYFWXSR")) + 1;
			//经营服务性收入的字典类型
			Category category = getByLookUpCode("JYFWXSR");
			//日期
			Date date = new Date();
			
			//主表中已包含数据，详情表作废
			//经营服务性收入的详情
			List<Object[]> detailsList = getByBusiId(bean.getfBusiId());
			
			for (int i = 0; i < detailsList.size(); i++) {
				//生成随机的uuid作为字典项的pid
				String pid = UUID.randomUUID().toString();
				Lookups lookups = new Lookups();
				lookups.setId(String.valueOf(pid));
				lookups.setFlag("1");
				lookups.setCreator(user);
				lookups.setCreateTime(date);
				lookups.setCategory(category);
				lookups.setCode(category.getCode().concat("-").concat(String.valueOf(orderNo)));
				lookups.setName(String.valueOf(detailsList.get(i)[2]));
				lookups.setDescription(String.valueOf(detailsList.get(i)[4]));
				lookups.setOrderNo(String.valueOf(orderNo));
				//添加到字典项中
				lookupsMng.save(lookups);
				orderNo++;
			}
			
			//生成随机的uuid作为字典项的pid
			String pid = UUID.randomUUID().toString();
			Lookups lookups = new Lookups();
			lookups.setId(String.valueOf(pid));
			lookups.setFlag("1");
			lookups.setCreator(user);
			lookups.setCreateTime(date);
			lookups.setCategory(category);
			lookups.setCode(category.getCode().concat("-").concat(String.valueOf(orderNo)));
			lookups.setName(bean.getfProName());
			lookups.setDescription(bean.getfPlanPrice());
			lookups.setOrderNo(String.valueOf(orderNo));
			//添加到字典项中
			lookupsMng.save(lookups);
			lookupsMng.init();
		}*/
		super.saveOrUpdate(busiBean);
	}

	@Override
	public List<Object[]> getByBusiId(Integer id) {
		StringBuilder builder = new StringBuilder();
		builder.append("SELECT * FROM T_BUSINESS_SERVICE_DETAILS WHERE F_BUSI_ID = '" + id + "'" );
		SQLQuery query = getSession().createSQLQuery(builder.toString());
		List<Object[]> detailsList = query.list();
		if(detailsList != null && detailsList.size()>0){
			return detailsList;
		}
		return null;
	}

	@Override
	public String getOrderNoByLookUpCode(String code) {
		String orderNo = "";
		StringBuilder builder = new StringBuilder();
		builder.append("SELECT MAX(sls.orderNo) FROM sys_lookup sl, sys_lookups sls WHERE sl.pid = sls.lookup_Id AND sls.pflag = 1 AND sl.lookupCode = '" + code + "'");
		SQLQuery query = getSession().createSQLQuery(builder.toString());
		List<String> lookupsList = query.list();
		if(lookupsList != null && lookupsList.size()>0){
			orderNo = lookupsList.get(0);
		}
		return orderNo;
	}

	@Override
	public Category getByLookUpCode(String code) throws Exception {
		Category category = new Category();
		StringBuilder builder = new StringBuilder();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		builder.append("SELECT * FROM sys_lookup WHERE pflag = 1 AND lookupcode ='" + code + "'");
		SQLQuery query = getSession().createSQLQuery(builder.toString());
		List<Object[]> list = query.list();
		for(Object[] obj : list){
			category.setId(obj[0].toString());
			category.setFlag(obj[1].toString());
			category.setCreator(userMng.findById(obj[2].toString()));
			category.setCreateTime(sdf.parse(String.valueOf(obj[3])));
			category.setUpdateTime(sdf.parse(String.valueOf(obj[5])));
			category.setCode(obj[6].toString());
			category.setName(obj[7].toString());
			category.setDescription(obj[9].toString());
			category.setOrderNo(obj[10].toString());
		}
		return category;
	}

	public void reCall(Integer id) throws Exception{
		//根据id查询对象
		BusinessServiceInfo bean=(BusinessServiceInfo)super.findById(id);
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="申请被撤回消息";
		String msg="您待审批的  "+bean.getfProName() +",任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean=(BusinessServiceInfo) reCall((CheckEntity) bean);
		this.updateDefault(bean);
	}
	
	public List<BusinessServiceInfo> getProjectList(User user,BusinessServiceInfo bean){
		//查询条件
		Finder finder = Finder.create(" FROM BusinessServiceInfo WHERE fStatus <> 99 and fFlowStatus ='9' ");
		finder.append(" AND fOperatorId='"+user.getId()+"'");
		//根据立项单号模糊查询
		if (!StringUtil.isEmpty(String.valueOf(bean.getfBusiCode()))) {
			finder.append(" AND fBusiCode LIKE '%" + bean.getfBusiCode() + "%'");
		}
		//按时间排序-倒序
		finder.append(" order by updateTime desc");
		List<BusinessServiceInfo> list =  super.find(finder);
		return list;
	}
}
