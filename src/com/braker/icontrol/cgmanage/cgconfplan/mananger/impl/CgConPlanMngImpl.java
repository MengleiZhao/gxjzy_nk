package com.braker.icontrol.cgmanage.cgconfplan.mananger.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.CheckEntity;
import com.braker.common.entity.TreeEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgconfplan.mananger.CgConPlanMng;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlan;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlanList;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * 采购计划配置的service实现类
 * @author 冉德茂
 * @createtime 2018-10-11
 * @updatetime 2018-10-11
 */
@Service
@Transactional
public class CgConPlanMngImpl extends BaseManagerImpl<ProcurementPlan> implements CgConPlanMng {
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private CgConPlanMng confplanMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private DepartMng departMng;
	
	@Override
	public Pagination pageList(ProcurementPlan bean, Integer pageNo, Integer pageSize, User user) {
		Finder finder = Finder.create("  FROM ProcurementPlan WHERE fstauts <> 99");
		//查询条件
		if(!StringUtil.isEmpty(bean.getFreqDept())){ //按部门名称模糊查询
			finder.append(" AND freqDept LIKE :freqDept");
			finder.setParam("freqDept", "%"+bean.getFreqDept()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFlistNum())){ //按部门名称模糊查询
			finder.append(" AND flistNum LIKE :flistNum");
			finder.setParam("flistNum", "%"+bean.getFlistNum()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFprocurType())){//采购类型
			finder.append(" AND fprocurType = :fprocurType");
			finder.setParam("fprocurType", bean.getFprocurType());
		}
		
		if(!StringUtil.isEmpty(String.valueOf(bean.getFreportStage()))){//上报阶段
			if ("essb".equals(bean.getSblx())){//二上申报
				finder.append(" AND firstIssuedStatus = 1");//已一下的数据
			}else {
				finder.append(" AND freportStage = '"+bean.getFreportStage()+"'");
			}
		}
		
		//台账查看权限
		String deptIdStr = departMng.getDeptIdStrByUser(user);
		if("".equals(deptIdStr)) { //普通岗位只能查看自己的
			finder.append(" AND freqUserId = :freqUserId").setParam("freqUserId", user.getId());
		}else if("all".equals(deptIdStr)) {//校长可以查看所有人的
			
		}else {//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
			finder.append(" AND freqDeptId in ("+deptIdStr+")");
		}
		finder.append(" order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}
	
	@Override
	public Pagination checkPageList(ProcurementPlan bean, Integer page, Integer rows, User user) {
		Finder finder = Finder.create(" FROM ProcurementPlan WHERE fstauts <> 99 AND fuserId = '"+ user.getId() +"'");
		//查询条件
		if(!StringUtil.isEmpty(bean.getFreqDept())){ //按部门名称模糊查询
			finder.append(" AND freqDept LIKE :freqDept");
			finder.setParam("freqDept", "%"+bean.getFreqDept()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFlistNum())){ //按部门名称模糊查询
			finder.append(" AND flistNum LIKE :flistNum");
			finder.setParam("flistNum", "%"+bean.getFlistNum()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFprocurType())){ //采购类型
			finder.append(" AND fprocurType = :fprocurType");
			finder.setParam("fprocurType", bean.getFprocurType());
		}
		
		//判断一下审核部门
		if(user.getRoleName().contains("部门负责人") && "总务处".equals(user.getDepartName())){
			finder.append(" AND fprocurType = 'A40'");					//办公用品及耗材
		}else if(user.getRoleName().contains("部门负责人") && "设备与安技处".equals(user.getDepartName())){
			finder.append(" AND fprocurType in('A10', 'A20', 'A30')");	//货物、工程、服务
		}
		if(!StringUtil.isEmpty(String.valueOf(bean.getFreportStage()))){ //上报阶段
			finder.append(" AND freportStage = :freportStage");
			finder.setParam("freportStage", bean.getFreportStage());
		}
		finder.append(" order by updateTime desc");//排序
		return super.find(finder, page, rows);
	}
	
	@Override
	public Pagination resolvePageList(ProcurementPlan bean, String status, Integer pageNo, Integer pageSize, User user) {
		Finder finder = Finder.create("  FROM ProcurementPlan WHERE fstauts <> 99 ");
		//查询条件
		if(!StringUtil.isEmpty(bean.getFreqDept())){ //按部门名称模糊查询
			finder.append(" AND freqDept LIKE :freqDept");
			finder.setParam("freqDept", "%"+bean.getFreqDept()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFlistNum())){ //按部门名称模糊查询
			finder.append(" AND flistNum LIKE :flistNum");
			finder.setParam("flistNum", "%"+bean.getFlistNum()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFprocurType())){//采购类型
			finder.append(" AND fprocurType = :fprocurType");
			finder.setParam("fprocurType", bean.getFprocurType());
		}
		if(!StringUtil.isEmpty(bean.getFcheckStauts())){//审批状态
			finder.append(" AND fcheckStauts = :fcheckStauts");
			finder.setParam("fcheckStauts", bean.getFcheckStauts());
		}
		
		//判断部门负责人
		if(user.getRoleName().contains("部门负责人") && "总务处".equals(user.getDepartName())){
			finder.append(" AND fprocurType = 'A40'");					//办公用品及耗材
		}else if(user.getRoleName().contains("部门负责人") && "设备与安技处".equals(user.getDepartName())){
			finder.append(" AND fprocurType in('A10', 'A20', 'A30')");	//货物、工程、服务
		}
		if(!StringUtil.isEmpty(String.valueOf(bean.getFreportStage()))){//上报阶段
			finder.append(" AND freportStage = :freportStage");
			finder.setParam("freportStage", bean.getFreportStage());
		}
		if(!StringUtil.isEmpty(String.valueOf(bean.getSecondIssuedStatus()))){//是否二下
			finder.append(" AND secondIssuedStatus = :secondIssuedStatus");
			finder.setParam("secondIssuedStatus", bean.getSecondIssuedStatus());
		}
		if("0".equals(status)){//未下达
			if("1".equals(String.valueOf(bean.getFreportStage()))){
				finder.append(" AND firstIssuedStatus = '"+status+"'");
			}else if("2".equals(String.valueOf(bean.getFreportStage()))){
				finder.append(" AND secondIssuedStatus = '"+status+"'");
			}
		}else if("1".equals(status)){//已下达
			if("1".equals(String.valueOf(bean.getFreportStage()))){
				finder.append(" AND firstIssuedStatus = '"+status+"'");
			}else if("2".equals(String.valueOf(bean.getFreportStage()))){
				finder.append(" AND secondIssuedStatus = '"+status+"'");
			}
		}
		finder.append(" order by updateTime desc");//排序
		return super.find(finder, pageNo, pageSize);
	}
	
	@Override
	public Pagination ledgerPageList(ProcurementPlan bean, Integer pageNo, Integer pageSize, User user) {
		Finder finder = Finder.create("  FROM ProcurementPlan WHERE fstauts <> 99 AND secondIssuedStatus = 1");
		//查询条件
		if(!StringUtil.isEmpty(bean.getFreqDept())){ //按部门名称模糊查询
			finder.append(" AND freqDept LIKE :freqDept");
			finder.setParam("freqDept", "%"+bean.getFreqDept()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFlistNum())){ //按部门名称模糊查询
			finder.append(" AND flistNum LIKE :flistNum");
			finder.setParam("flistNum", "%"+bean.getFlistNum()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFprocurType())){//采购类型
			finder.append(" AND fprocurType = :fprocurType");
			finder.setParam("fprocurType", bean.getFprocurType());
		}
		
		//判断部门负责人
		if(user.getRoleName().contains("部门负责人") && "总务处".equals(user.getDepartName())){
			finder.append(" AND fprocurType = 'A40'");					//办公用品及耗材
		}else if(user.getRoleName().contains("部门负责人") && "设备与安技处".equals(user.getDepartName())){
			finder.append(" AND fprocurType in('A10', 'A20', 'A30')");	//货物、工程、服务
		}
		if(!StringUtil.isEmpty(String.valueOf(bean.getFreportStage()))){//上报阶段
			finder.append(" AND freportStage = :freportStage");
			finder.setParam("freportStage", bean.getFreportStage());
		}
		
		//台账查看权限
		if(user.getRoleName().contains("采购计划台账查看岗")){
			//采购计划台账查看岗可以查看所有部门的台账
		}else {
			String deptIdStr = departMng.getDeptIdStrByUser(user);
			if("".equals(deptIdStr)) { //普通岗位只能查看自己的
				finder.append(" AND freqUserId = :freqUserId").setParam("freqUserId", user.getId());
			}else if("all".equals(deptIdStr)) {//校长可以查看所有人的
						
			}else {//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
				finder.append(" AND freqDeptId in ("+deptIdStr+")");
			}
		}
		finder.append(" order by updateTime desc");//排序
		return super.find(finder, pageNo, pageSize);
	}
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED)//事务处理
	public void save(ProcurementPlan bean, String mingxi, String files, User user)  throws Exception {
		//日期
		Date date = new Date();
		if(bean.getFplId() == null){//新增
			//创建人、创建时间
			bean.setCreator(user.getName());
			bean.setCreateTime(date);
			
		}else {//修改
			//修改人、修改时间
			bean.setUpdator(user.getName());
			bean.setUpdateTime(date);
		}
		bean.setFirstIssuedStatus(0);					//一下状态			0-未下达	1-已下达
		bean.setSecondIssuedStatus(0);					//二下状态			0-未下达	1-已下达
		bean.setFisChecked("0");						//设置采购是否已选择		0-未选择	1-已选择
			
		//以下为工作流的节点配置（如果点送审则设置进入工作流1为提交）
		if("1".equals(bean.getFcheckStauts())){
			//业务范围
			String busiArea = null;
			if("A40".equals(bean.getFprocurType())){
				busiArea = "CGPLANOFFICESQ";		//办公用品及耗材
			}else {
				busiArea = "CGPLANSQ";				//货物、工程、服务
			}
			//得到第一个审批节点key
			Integer firstKey = tProcessCheckMng.addProcessCheck(user.getDpID(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getBeanCode(), busiArea, user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin = tProcessDefinMng.getByBusiAndDpcode(busiArea, user.getDpID());
			Integer flowId = processDefin.getFPId();
			TNodeData node = tNodeDataMng.getByFlowIdAndKey(flowId, firstKey);
			User nextUser = userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号		get(0)的原因是一个角色应该只能审批一级，所以查出来li应该只有一个数据
			bean.setUserName2(nextUser.getName());
			bean.setFuserId(nextUser.getId());
			//设置下节点节点编码
			bean.setnCode(firstKey+"");	
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId, bean.getBeanCode());
			//保存基本信息
			bean = (ProcurementPlan) super.saveOrUpdate(bean); 
				
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getFplId());//申请单ID
			work.setTaskCode(bean.getFlistNum());//为申请单的单号
			work.setTaskName("[采购预算一上]"+"申请审批");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/cgconfplan/check?id="+bean.getFplId());//为审批页面内容显示的url,需要将数据传入不然无法访问
			work.setUrl1("/cgconfplan/detail?id="+bean.getFplId());
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(date);//任务提交时间
			personalWorkMng.merge(work);
				
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(bean.getFplId());//申请单ID
			work2.setTaskCode(bean.getFlistNum());//为申请单的单号
			work2.setTaskName("[采购预算一上]"+"申请审批");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/cgconfplan/edit?id="+bean.getFplId());//退回修改url
			work2.setUrl1("/cgconfplan/detail?id="+bean.getFplId());//查看url
			work2.setUrl2("/cgconfplan/delete?id="+bean.getFplId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work2.setBeforeTime(date);//任务提交时间
			work2.setFinishTime(date);
			personalWorkMng.merge(work2);
		}else {
			bean = (ProcurementPlan) super.saveOrUpdate(bean);
		}
		//保存附件信息
		attachmentMng.joinEntity(bean, files);
		
		//获取现有的明细
		List mxList = getMingXiJson(mingxi, ProcurementPlanList.class);
		//获得老的明细
		List<Object> oldmxList = getMingxi("ProcurementPlanList", "fplId", bean.getFplId());
		//比较新老明细的不同
		for (int i = oldmxList.size() - 1; i >= 0; i--) {
			ProcurementPlanList oldgad = (ProcurementPlanList) oldmxList.get(i);
			for (int j = 0; j < mxList.size(); j++) {
				ProcurementPlanList gad = (ProcurementPlanList) mxList.get(j);
				if(gad.getFpId() != null){
					if(gad.getFpId() == oldgad.getFpId()){
						oldmxList.remove(i);
					}
				}
			}
		}
		//删除在新明细中没有的老明细
		if(oldmxList.size() > 0){
			for (int i = 0; i < oldmxList.size(); i++) {
				ProcurementPlanList oldgad = (ProcurementPlanList) oldmxList.get(i);
				super.delete(oldgad);
			}
		}
		//保存新的明细
		for (int j = 0; j < mxList.size(); j++) {
			ProcurementPlanList gad = (ProcurementPlanList) mxList.get(j);
			gad.setFplId(bean.getFplId());
			super.merge(gad);
		}
	}
	
	@Override
	public void delete(Integer id) {
		ProcurementPlan bean = super.findById(id);
		//设置数据状态	99删除
		bean.setFstauts("99");
		
		//一上删除时取消与项目支出明细的关联
		bean.setPid(null);
		bean.setExpCode(null);
		bean.setSubCode(null);
		bean.setSubName(null);
		bean.setOutAmount(null);
		super.saveOrUpdate(bean);
	}
	
	@Override
	public List<Object> getMingxi(String tableName ,String idName ,Integer pid) {
		Finder finder = Finder.create(" FROM " + tableName + " WHERE " + idName + "=" + pid);
		return super.find(finder);
	}
	
	@Override
	public List getMingXiJson(String mingxi, Class tableClass) {
		//获取明细的Json对象
		List mx = null;
		JSONArray array =JSONArray.fromObject("["+mingxi.toString()+"]");
		mx = (List)JSONArray.toList(array, tableClass);
		return mx;
	}
	
	@Override
	public List<Integer> getPidList() {
		Finder finder = Finder.create(" from ProcurementPlan where fstauts <> 99 and pid is not null");
		List<ProcurementPlan> planList = super.find(finder);
		List<Integer> pidList = new ArrayList<>();
		for (int i = 0; i < planList.size(); i++) {
			Integer pid = planList.get(i).getPid();
			pidList.add(pid);
		}
		return pidList;
	}

	@Override
	public void saveCheck(TProcessCheck checkBean, ProcurementPlan bean, String files, User user)  throws Exception {
		bean = this.findById(bean.getFplId());
		CheckEntity entity = (CheckEntity)bean;
		
		String checkUrl = "/cgconfplan/check?id=";
		String lookUrl = "/cgconfplan/detail?id=";
		
		//业务范围
		String busiArea = null;
		if("A40".equals(bean.getFprocurType())){
			busiArea = "CGPLANOFFICESQ";		//办公用品及耗材
		}else {
			busiArea = "CGPLANSQ";				//货物、工程、服务
		}
		bean = (ProcurementPlan)tProcessCheckMng.checkProcess(checkBean, entity, user, busiArea, checkUrl, lookUrl, files);
		//审批不通过
		if("0".equals(checkBean.getFcheckResult())){
			//取消与项目支出明细的关联
			bean.setPid(null);
			bean.setExpCode(null);
			bean.setSubCode(null);
			bean.setSubName(null);
			bean.setOutAmount(null);
		}
		super.saveOrUpdate(bean);
	}
	
	@Override
	public void resolveSave(ProcurementPlan bean) {
		ProcurementPlan planBean = confplanMng.findById(bean.getFplId());
		if("1".equals(String.valueOf(bean.getFreportStage()))){		//上报阶段	1-一上	2-二上
			planBean.setFirstIssuedStatus(1);		//修改一下状态
		}else if("2".equals(String.valueOf(bean.getFreportStage()))){
			planBean.setSecondIssuedStatus(1);		//修改二下状态
		}
		//审核人、审核时间、审核意见
		planBean.setFapproveUserName(bean.getFapproveUserName());
		planBean.setFapproveTime(bean.getFapproveTime());
		planBean.setFapproveIdea(bean.getFapproveIdea());
		super.saveOrUpdate(planBean);
	}

	@Override
	public List<TreeEntity> getIndexTreeOne(String indexType, User user) {
		//初始化
		List<TreeEntity> treeList = new ArrayList<>();
		List<Object[]> objList = null;
		
		//获得一级指标
		objList = confplanMng.getFirstIndex(indexType, user.getDpID());
		if (objList != null && objList.size() > 0) {
			//查询是否有下级节点
			String nodeIds = "";
			for (Object[] array : objList) {
				if("".equals(nodeIds)) {
					//设置节点id为项目主键id
					nodeIds = String.valueOf(array[3]);
				} else {
					nodeIds = nodeIds + "," + String.valueOf(array[3]);
				}
			}
			//获得存在对应支出明细（子节点）的项目主键proId
			Map<String, Integer> proIdMap = confplanMng.getProIdMap(nodeIds);
			//整合生成tree
			for (Object[] array : objList) {
				//节点id 节点名称
				String nodeId = String.valueOf(array[3]);
				String nodeName = (String) array[1];
				
				TreeEntity node = new TreeEntity();
				node.setText(nodeName);//名称
				node.setId(nodeId);//节点id
				
				if (proIdMap.get(nodeId) != null) {
					node.setState("closed");
				} else {
					node.setLeaf(true);
				}
				treeList.add(node);
			}
		}
		return treeList;
	}

	@Override
	public List<Object[]> getFirstIndex(String indexType, String departId) {
		String sql = " SELECT B.F_PRO_CODE, A.F_B_INDEX_NAME, A.F_B_INDEX_CODE, B.F_PRO_ID "
				+ " FROM T_BUDGET_INDEX_MGR A"
				+ " INNER JOIN T_PRO_BASIC_INFO B"
				+ " ON A.F_B_INDEX_CODE = B.F_PRO_CODE"
				+ " WHERE A.F_RELEASE_STAUTS = '1'"
				+ " AND A.F_B_ID NOT IN (SELECT F_INDEX_ID FROM T_PROCUREMENT_PLAN WHERE F_INDEX_ID IS NOT NULL)"//未跟采购年度计划关联的
				+ " AND A.F_YEARS = '" + DateUtil.getCurrentYear() + "'";//当年的
			if("0".equals(indexType)){
			   sql += " AND A.F_INDEX_TYPE = '0'";//基本支出
			}else if("1".equals(indexType)){
			   sql += " AND A.F_INDEX_TYPE = '1'";//项目支出
			}
			if(!StringUtil.isEmpty(departId)){
				sql += " AND A.F_DEPT_CODE = '" + departId +"'";//本部门申报的
			}
		SQLQuery query = getSession().createSQLQuery(sql);
		return query.list();
	}
	
	@Override
	public Map<String, Integer> getProIdMap(String parentCodes) {
		Map<String, Integer> proIdMap = new HashMap<String, Integer>();
		List<Integer> proIdList = getProIdsByparentCodes(parentCodes);
		if(proIdList != null && proIdList.size() > 0){
			for(Integer proId:proIdList){
				proIdMap.put(String.valueOf(proId), proId);
			}
		}
		return proIdMap;
	}

	@Override
	public List<Integer> getProIdsByparentCodes(String parentCodes) {
		String sql = "SELECT F_PRO_ID FROM T_PRO_EXPEND_DETAIL WHERE 1=1";
		if (!StringUtil.isEmpty(parentCodes)) {//父节点
			sql = sql + " and F_PRO_ID in (" + parentCodes + ")";
		}
		SQLQuery query = getSession().createSQLQuery(sql);
		return query.list();
	}

	@Override
	public List<TreeEntity> getIndexTreeTwo(String id) {
		//初始化
		List<TreeEntity> treeList = new ArrayList<>();
		List<Object[]> objList = null;
		
		//查询二级指标数据
		objList = confplanMng.getOutDetailByProId(id);
		//放入tree值
		if (objList != null && objList.size() > 0) {
			for (Object[] array : objList) {
				//节点id 节点名称 节点代码 父节点代码
				String nodeId = String.valueOf(array[0]);//节点id
				String nodeName = (String) array[1];//节点名称
				String nodeCode = (String) array[2];//节点代码
				
				String indexId = String.valueOf(array[5]);//指标-id
				String indexCode = String.valueOf(array[11]);//指标编码
				String indexName = String.valueOf(array[10]);//指标名称
				
				String fzrName = (String) array[3];//项目-负责人
				String mainDepart = String.valueOf(array[8]);//指标-使用部门
				String pfDate = String.valueOf(array[7]);//指标-批复日期
				String pfAmount = String.valueOf(array[6]);//明细-批复金额
				String syAmount = String.valueOf(array[4]);//明细-剩余金额 
				String djAmonut = String.valueOf(array[9]);//明细-冻结金额
				
				//实体树不存数据库，将sql中需要的字段set到col中，目前最多10项
				TreeEntity node = new TreeEntity();
				node.setId(nodeId);//节点id
				node.setCode(nodeCode);//节点代码
				node.setText(nodeName);//名称
				
				node.setCol1(indexId);//指标id
				node.setCol2(indexCode);//指标编码
				node.setCol3(indexName);//指标名称
				
				node.setCol4(fzrName);//项目负责人
				node.setCol5(mainDepart);//使用部门
				node.setCol6(pfDate);//批复时间
				node.setCol7(pfAmount);//批复金额
				node.setCol8(syAmount);//可用金额
				node.setCol9(djAmonut);//冻结金额
				
				node.setLeaf(true);
				treeList.add(node);
			}
		}
		return treeList;
	}

	@Override
	public List<Object[]> getOutDetailByProId(String proId) {
		String sql = "SELECT a.F_EXP_ID,"	//明细-id
				+ " a.F_SUB_NAME,"			//明细-名称
				+ " a.F_SUB_NUM,"			//明细-编码
				+ " pro.f_pro_head,"		//项目-负责人
				+ " a.F_SY_AMOUNT,"			//明细-剩余金额
				+ " ind.f_b_id,"			//指标-id
				+ " a.F_APPLI_AMOUNT,"		//明细-批复金额						
				+ " ind.F_APP_DATE,"		//指标-批复日期
				+ " ind.F_DEPT_NAME,"		//指标-使用部门
				+ " a.F_DJ_AMOUNT,"			//指标-冻结金额
				+ " ind.F_B_INDEX_NAME,"	//指标名称
				+ " ind.F_B_INDEX_CODE"		//指标编码
				+ " FROM T_PRO_EXPEND_DETAIL a"
				+ " inner join t_pro_basic_info pro on a.F_PRO_ID = pro.F_PRO_ID"
				+ " inner join t_budget_index_mgr ind on ind.F_B_INDEX_CODE = pro.f_pro_code"
				+ " WHERE 1=1"
				+ " AND a.F_PRO_ID = '" + proId + "'";
		SQLQuery query = getSession().createSQLQuery(sql);
		return query.list();	
	}

	@Override
	public ProcurementPlan setPurSecondAmount(Integer id, Double amount) {
		ProcurementPlan bean = confplanMng.findById(id);
		bean.setPurSecondAmount(amount);
		bean = (ProcurementPlan) super.saveOrUpdate(bean);
		return bean;
	}

	@Override
	public void secondSaveCheck(TProcessCheck checkBean, ProcurementPlan bean, String files, User user) throws Exception {
		bean = this.findById(bean.getFplId());
		CheckEntity entity = (CheckEntity)bean;
		
		String checkUrl = "/cgconfplan/secondCheck?id=";
		String lookUrl = "/cgconfplan/secondDetail?id=";
		
		//业务范围
		String busiArea = null;
		if("A40".equals(bean.getFprocurType())){
			busiArea = "CGPLANOFFICEESSQ";		//办公用品及耗材
		}else {
			busiArea = "CGPLANESSQ";			//货物、工程、服务
		}
		bean = (ProcurementPlan)tProcessCheckMng.checkProcess(checkBean, entity, user, busiArea, checkUrl, lookUrl, files);
		//审批不通过
		if("0".equals(checkBean.getFcheckResult())){
			//取消与预算指标的关联
			bean.setIndexId(null);
			bean.setIndexCode(null);
			bean.setIndexName(null);
			bean.setSyAmount(null);
		}
		super.saveOrUpdate(bean);
	}

	@Override
	public void secondSave(ProcurementPlan planBean, String mingxi, String files, User user) throws Exception {
		//通过主键一下下达后查询完整数据
		ProcurementPlan bean = confplanMng.findById(planBean.getFplId());
		//设置日期
		Date date = new Date();
		//设置二上修改人、修改时间
		bean.setUpdator(user.getName());
		bean.setUpdateTime(date);
		
		//设置上报状态
		bean.setFreportStage(planBean.getFreportStage());
		//设置审批状态
		bean.setFcheckStauts(planBean.getFcheckStauts());
		
		//设置预算指标id
		bean.setIndexId(planBean.getIndexId());
		//设置预算指标编码
		bean.setIndexCode(planBean.getIndexCode());
		//设置预算指标名称
		bean.setIndexName(planBean.getIndexName());
		//设置指标可用金额
		bean.setSyAmount(planBean.getSyAmount());
		
		//送审
		//业务范围
		String busiArea = null;
		if("A40".equals(bean.getFprocurType())){
			busiArea = "CGPLANOFFICEESSQ";		//办公用品及耗材
		}else {
			busiArea = "CGPLANESSQ";			//货物、工程、服务
		}
		//得到第一个审批节点key
		Integer firstKey = tProcessCheckMng.addProcessCheck(user.getDpID(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getBeanCode(), busiArea, user);
		//根据资源名称和当前登陆者所属部门查询对应工作流
		TProcessDefin processDefin = tProcessDefinMng.getByBusiAndDpcode(busiArea, user.getDpID());
		Integer flowId = processDefin.getFPId();
		TNodeData node = tNodeDataMng.getByFlowIdAndKey(flowId, firstKey);
		User nextUser = userMng.findById(node.getUserId());
		//设置下节点处理人姓名和编号		get(0)的原因是一个角色应该只能审批一级，所以查出来li应该只有一个数据
		bean.setUserName2(nextUser.getName());
		bean.setFuserId(nextUser.getId());
		//设置下节点节点编码
		bean.setnCode(firstKey+"");	
		//把历史审批记录全部设置为1，表示重新审批
		tProcessCheckMng.updateStauts(flowId, bean.getBeanCode());
		//保存基本信息
		bean = (ProcurementPlan) super.saveOrUpdate(bean); 
			
		//添加审批人个人首页代办信息
		PersonalWork work = new PersonalWork();
		work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
		work.setTaskId(bean.getFplId());//申请单ID
		work.setTaskCode(bean.getFlistNum());//为申请单的单号
		work.setTaskName("[采购预算二上]"+"申请审批");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
		work.setUrl("/cgconfplan/secondCheck?id="+bean.getFplId());//为审批页面内容显示的url,需要将数据传入不然无法访问
		work.setUrl1("/cgconfplan/secondDetail?id="+bean.getFplId());//查看url
		work.setTaskStauts("0");//待办
		work.setType("1");//任务类型（1审批）
		work.setBeforeUser(user.getName());//任务提交人姓名
		work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
		work.setBeforeTime(date);//任务提交时间
		personalWorkMng.merge(work);
			
		//添加申请人的个人首页已办信息
		PersonalWork work2 = new PersonalWork();
		work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
		work2.setTaskId(bean.getFplId());//申请单ID
		work2.setTaskCode(bean.getFlistNum());//为申请单的单号
		work2.setTaskName("[采购预算二上]"+"申请审批");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
		work2.setUrl("/cgconfplan/secondEdit?id="+bean.getFplId());//退回修改url
		work2.setUrl1("/cgconfplan/secondDetail?id="+bean.getFplId());//查看url
		work2.setTaskStauts("2");//已办
		work2.setType("2");//任务类型（2查看）
		work2.setBeforeUser(user.getName());//任务提交人姓名
		work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
		work2.setBeforeTime(date);//任务提交时间
		work2.setFinishTime(date);
		personalWorkMng.merge(work2);
		
		//获取现有的明细
		List mxList = getMingXiJson(mingxi, ProcurementPlanList.class);
		//获得老的明细
		List<Object> oldmxList = getMingxi("ProcurementPlanList", "fplId", bean.getFplId());
		//比较新老明细的不同
		for (int i = oldmxList.size() - 1; i >= 0; i--) {
			ProcurementPlanList oldgad = (ProcurementPlanList) oldmxList.get(i);
			for (int j = 0; j < mxList.size(); j++) {
				ProcurementPlanList gad = (ProcurementPlanList) mxList.get(j);
				if(gad.getFpId() != null){
					if(gad.getFpId() == oldgad.getFpId()){
						oldmxList.remove(i);
					}
				}
			}
		}
		//删除在新明细中没有的老明细
		if(oldmxList.size() > 0){
			for (int i = 0; i < oldmxList.size(); i++) {
				ProcurementPlanList oldgad = (ProcurementPlanList) oldmxList.get(i);
				super.delete(oldgad);
			}
		}
		//保存新的明细
		for (int j = 0; j < mxList.size(); j++) {
			ProcurementPlanList gad = (ProcurementPlanList) mxList.get(j);
			gad.setFplId(bean.getFplId());
			super.merge(gad);
		}		
	}

	
	

}