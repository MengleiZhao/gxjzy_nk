package com.braker.icontrol.cgmanage.cgexpert.manager.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.EconomicMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgexpert.manager.CgExpertMng;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertBlackInfo;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertInfo;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertOutInfo;
import com.braker.icontrol.cgmanage.cgprocess.model.BidExpertRef;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;


/**
 * 评标专家的service实现类
 * @author 冉德茂
 * @createtime 2018-07-27
 * @updatetime 2018-07-27
 */
@Service
@Transactional
public class CgExpertMngImpl extends BaseManagerImpl<ExpertInfo> implements CgExpertMng {
	
	@Autowired
	private PersonalWorkMng personalWorkMng;
	
	@Autowired
	private EconomicMng economicMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private TNodeDataMng tNodeDataMng;
	
	@Autowired
	private UserMng userMng;
	/*
	 *通过中标的主键ID查询评标专家的id
	 * @author 冉德茂
	 * @createtime 2018-07-27
	 * @updatetime 2018-07-27
	 */
	@Override
	public List<BidExpertRef> findByBidid(Integer bidid) {
		Finder finder = Finder.create(" FROM BidExpertRef WHERE fbIdId="+bidid+" ");
		return super.find(finder);
	}

	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	@Override
	public Pagination pageList(ExpertInfo bean, int pageNo, int pageSize) {

		Finder finder =Finder.create("  FROM ExpertInfo WHERE fstauts <>"+99+" ");
		if(!StringUtil.isEmpty(bean.getFcheckType())){
			if(bean.getFcheckType().equals("in")){	//入库申请 列出所有 已出库的
				finder.append(" AND fcheckStauts=9 AND fcheckType='out' AND (fisOutStatus=9 or fisOutStatus=-2 or fisOutStatus=-4)"); //-2：出库后在入库 被退回的
			}else if(bean.getFcheckType().equals("out")){ //出库申请 列出所有在库的
				finder.append("	AND fcheckStauts=9 AND fcheckType='in' AND ( fisOutStatus=9 or fisOutStatus =-1 or fisOutStatus=0 or fisOutStatus=-4) AND (fisBlackStatus=0 or fisBlackStatus=-1 or fisBlackStatus=-4)"); 
			}else if(bean.getFcheckType().equals("black")){ //黑名单申请 列出所有在库的
				finder.append(" AND fcheckStauts=9 AND fcheckType='in' AND ( fisOutStatus=9 or fisOutStatus =-1 or fisOutStatus=0 or fisOutStatus=-4) AND (fisBlackStatus=0 or fisBlackStatus=-1 or fisBlackStatus=-4)"); 
			}
		}
		if(!StringUtil.isEmpty(bean.getFcheckStauts())){ //按状态 所有未审核通过的 和暂存
			finder.append(" AND (fcheckStauts=0 OR fcheckStauts=1 OR fcheckStauts=9 OR fcheckStauts=-1 OR fcheckStauts=-4 OR fisBlackStatus=1 OR fisBlackStatus=-1 OR fisBlackStatus=-4 OR fisOutStatus=1 OR fisOutStatus=-1 OR fisOutStatus=-2 OR fisOutStatus=-4)");
		}
		
		if(!StringUtil.isEmpty(bean.getFexpertCode())){ //按专家编号模糊查询
			finder.append(" AND fexpertCode LIKE :fexpertCode");
			finder.setParam("fexpertCode", "%"+bean.getFexpertCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFexpertName())){ //按专家名称名称模糊查询
			finder.append(" AND fexpertName LIKE :fexpertName");
			finder.setParam("fexpertName", "%"+bean.getFexpertName()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFfield())){ //按擅长领域模糊查询
			finder.append(" AND ffield LIKE :ffield");
			finder.setParam("ffield", "%"+bean.getFfield()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFexpertSex()) ){//性别
			finder.append(" AND fexpertSex = :fexpertSex");
			finder.setParam("fexpertSex", bean.getFexpertSex());
		}
		finder.append(" order by feId desc ");
		
		return super.find(finder,pageNo,pageSize);
	}
	/*
	 * 新增的保存
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	@Override
	public void save(ExpertInfo bean, User user) throws Exception {
		Date d = new Date();
		if (bean.getFeId()==null) {
			//创建人、创建时间、发布时间  设置验收状态
			bean.setCreator(user.getName());
			bean.setfRecUserId(user.getId());
			bean.setCreateTime(d);
			bean.setfRecDept(user.getDepartName());
			bean.setfRecDeptId(user.getDpID());
			bean.setfRecTime(d);
		} else {
			//修改人、修改时间
			bean.setUpdator(user.getAccountNo());
			bean.setUpdateTime(d);
			bean.setfRecTime(d);
		}
		//保存职务 字典表
		bean.setFgpwPost(economicMng.findLookupsByCode(bean.getFgpwPost().getCode(), "GPW_POST"));
		bean.setFgpwPost2(economicMng.findLookupsByCode(bean.getFgpwPost2().getCode(), "GPW_POST"));
		//设置专家库的黑名单和数据的删除状态
		bean.setFisBlackStatus("0");//黑名单默认审批状态
		bean.setFisOutStatus("0");//出库默认审批状态
		bean.setFisBlack("0");//默认0  拉黑为1
		bean.setFstauts("1");//默认1  删除改为99
		bean.setFaccFreq(0);//新增  默认拉黑次数是0
			
		//以下为工作流的节点配置（如果点送审则设置进入工作流1为提交2为审核中）
		if(bean.getFcheckStauts().equals("1") || bean.getFcheckStauts().equals("2")){
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(), bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(),"CGEXSQ", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("CGEXSQ", user.getDpID());
			Integer flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			User nextUser=userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号		get(0)的原因是一个角色应该只能审批一级，所以查出来li应该只有一个数据
			bean.setUserName2(nextUser.getName());
			bean.setFuserId(nextUser.getId());
			//设置下节点节点编码
			bean.setnCode(firstKey+"");	
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			//保存基本信息
			if(bean.getFeId()==null){
				bean = (ExpertInfo) super.saveOrUpdate(bean); //新增
			}else{
				bean = (ExpertInfo) super.updateDefault(bean);//修改
			}
			
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getFeId());//专家库申请单ID
			work.setTaskCode(bean.getFexpertCode());//为供应商的编号
			//判断审批类型
			String taskName = bean.getFexpertName();
			if("in".equals(bean.getFcheckType())){
				taskName = "[专家库]" + taskName + "入库申请";
			} else if("out".equals(bean.getFcheckType())){
				taskName = "[专家库]" + taskName + "出库申请";
			} else if("black".equals(bean.getFcheckType())){
				taskName = "[专家库]" + taskName + "黑名单申请";
			}
			work.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/expertcheck/check?checkType=in&id="+bean.getFeId());//为审批页面内容显示的url,需要将数据传入不然无法访问
			work.setUrl1("/expertgl/detail?checkType=in&id="+bean.getFeId());
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(d);//任务提交时间
			personalWorkMng.merge(work);
			
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(bean.getFeId());//申请单ID
			work2.setTaskCode(bean.getFexpertCode());//为申请单的单号
			work2.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/expertgl/edit?checkType="+bean.getFcheckType()+"&id="+bean.getFeId());
			work2.setUrl1("/expertgl/detail?checkType="+bean.getFcheckType()+"&id="+bean.getFeId());
			work2.setUrl2("/expertgl/delete?id="+bean.getFeId());
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work2.setBeforeTime(d);//任务提交时间
			work2.setFinishTime(d);
			personalWorkMng.merge(work2);
		} else {
			//保存基本信息
			bean = (ExpertInfo) super.saveOrUpdate(bean);
		}
	}
	/*
	 * 根据ID删除
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	@Override
	public void delete(Integer id) {
		ExpertInfo bean = super.findById(id);
		bean.setFstauts("99");
		super.saveOrUpdate(bean);
	}
	/*
	 * 分页查询（白名单页面）（专家库台账）
	 * @author 冉德茂
	 * @createtime 2018-09-26
	 * @updatetime 2018-09-26
	 */
	@Override
	public Pagination whitepageList(ExpertInfo bean, int pageNo, int pageSize) {
		//选择未删除 并且通过审核的专家
		Finder finder =Finder.create(" FROM ExpertInfo WHERE fstauts <>99 AND fcheckStauts =9 AND fisBlackStatus <>1 and fisOutStatus <>1");
		if(!StringUtil.isEmpty(bean.getFexpertCode())){ //按专家编号模糊查询
			finder.append(" AND fexpertCode LIKE :fexpertCode");
			finder.setParam("fexpertCode", "%"+bean.getFexpertCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFexpertName())){ //按专家名称名称模糊查询
			finder.append(" AND fexpertName LIKE :fexpertName");
			finder.setParam("fexpertName", "%"+bean.getFexpertName()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFcheckType())){ //按专家状态查询
			if(bean.getFcheckType().equals("out")){
				finder.append(" AND fcheckType ='out' AND (fisOutStatus=9 or fisOutStatus=-2)");
			}else if(bean.getFcheckType().equals("black")){
				finder.append(" AND fcheckType ='black' AND fisBlackStatus=9");
			}else{
				finder.append(" AND fcheckType ='in'");
			}
		}
		if(!StringUtil.isEmpty(bean.getFfield())){ //按擅长领域模糊查询
			finder.append(" AND ffield LIKE :ffield");
			finder.setParam("ffield", "%"+bean.getFfield()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFexpertSex()) ){//性别
			finder.append(" AND fexpertSex = :fexpertSex");
			finder.setParam("fexpertSex", bean.getFexpertSex());
		}
		finder.append(" order by feId desc ");
		return super.find(finder,pageNo,pageSize);
	}
	/*
	 * 分页查询（黑名单页面）
	 * @author 冉德茂
	 * @createtime 2018-09-26
	 * @updatetime 2018-09-26
	 */
	@Override
	public Pagination blackpageList(ExpertInfo bean, int pageNo, int pageSize) {
		//选择未删除  是黑名单  并且通过审核的专家
		Finder finder =Finder.create(" FROM ExpertInfo WHERE fstauts <>"+99+" AND fcheckStauts = "+9+" AND fisBlack = "+1+" ");
		if(!StringUtil.isEmpty(bean.getFexpertCode())){ //按专家编号模糊查询
			finder.append(" AND fexpertCode LIKE :fexpertCode");
			finder.setParam("fexpertCode", "%"+bean.getFexpertCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFexpertName())){ //按专家名称名称模糊查询
			finder.append(" AND fexpertName LIKE :fexpertName");
			finder.setParam("fexpertName", "%"+bean.getFexpertName()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFfield())){ //按擅长领域模糊查询
			finder.append(" AND ffield LIKE :ffield");
			finder.setParam("ffield", "%"+bean.getFfield()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFexpertSex()) ){//性别
			finder.append(" AND fexpertSex = :fexpertSex");
			finder.setParam("fexpertSex", bean.getFexpertSex());
		}
		finder.append(" order by feId desc ");
		return super.find(finder,pageNo,pageSize);
	}
	/*
	 * 移入/移出黑名单
	 * @author 李安达
	 * @createtime 2019-02-27
	 * @updatetime 2019-02-27
	 */
	@Override
	public void moveblack(ExpertBlackInfo bean, User user) {
		try {
			Date d=new Date();
			bean.setFblackTime(d);//操作时间
			bean.setFopName(user.getName());// 当前操作人
			bean.setfRecUser(user.getName());
			bean.setfRecUserId(user.getId());
			bean.setfRecDept(user.getDepartName());
			bean.setfRecDeptId(user.getDpID());
			
			//保存基本信息	//移入
			if(bean.getfFlag()==2){
				ExpertInfo nowbean = super.findById(Integer.valueOf(bean.getFeId()));
				nowbean.setFcheckType("black");
				nowbean.setFblackTime(bean.getFblackTime());
				nowbean.setFblackDesc(bean.getFblackDesc());
				//nowbean.setFwId(bean.getFwId());
				nowbean.setFopName(bean.getFopName());
				nowbean.setFisBlackStatus("1");	//审批状态 	1待审批，2已审批
				//nowbean.setFisBlack(bean.getfFlag()+"");//黑名单状态
				super.saveOrUpdate(nowbean);
				
				bean.setFeCode(nowbean.getFexpertCode());//专家编码
				bean.setFeName(nowbean.getFexpertName());//专家名称
				
				//得到第一个审批节点key
				Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), "ZJKHMD", user);
				//根据资源名称和当前登陆者所属部门查询对应工作流
				TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("ZJKHMD", user.getDpID());
				Integer flowId= processDefin.getFPId();
				TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
				User nextUser=userMng.findById(node.getUserId());
				//设置下节点处理人姓名和编号		get(0)的原因是一个角色应该只能审批一级，所以查出来li应该只有一个数据
				bean.setfUserName(nextUser.getName());
				bean.setfUserId(nextUser.getId());
				//设置下节点节点编码
				bean.setfNcode(firstKey+"");	
				//把历史审批记录全部设置为1，表示重新审批
				tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
				
				String str="HMD"+StringUtil.random8();
				bean.setFwBCode(str);
				bean.setfCheckStatus("1");
				bean = (ExpertBlackInfo) super.saveOrUpdate(bean); //新增
				
				//添加审批人个人首页代办信息
				PersonalWork work = new PersonalWork();
				work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
				work.setTaskId(bean.getFeId());//专家申请单ID
				work.setTaskCode(bean.getFeBCode());//为专家黑名单的编号
				work.setTaskName(nowbean.getFexpertName()+"专家黑名单审批");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				work.setUrl("/expertcheck/check?id="+bean.getFeId()+"&checkType=black");//为审批页面内容显示的url,需要将数据传入不然无法访问
				work.setUrl1("/expertgl/detail?id="+bean.getFeId()+"&checkType=black");//查看url
				work.setTaskStauts("0");//待办
				work.setType("1");//任务类型（1审批）
				work.setBeforeUser(user.getName());//任务提交人姓名
				work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
				work.setBeforeTime(d);//任务提交时间
				personalWorkMng.merge(work);
				
				//添加申请人的个人首页已办信息
				PersonalWork work2 = new PersonalWork();
				work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
				work2.setTaskId(bean.getFeId());//申请单ID
				work2.setTaskCode(bean.getFeBCode());//为供应商黑名单的编号
				work2.setTaskName(nowbean.getFexpertName()+"专家黑名单审批");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				work2.setUrl("/blackexpertgl/inblack?id="+bean.getFeId());//退回修改url
				work2.setUrl1("/expertgl/detail?id="+bean.getFeId()+"&checkType=black");//查看url
				work2.setUrl2("/blackexpertgl/deleteBlack?feBId="+bean.getFeBId());//删除url
				work2.setTaskStauts("2");//已办
				work2.setType("2");//任务类型（2查看）
				work2.setBeforeUser(user.getName());//任务提交人姓名
				work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
				work2.setBeforeTime(d);//任务提交时间
				work2.setFinishTime(d);
				personalWorkMng.merge(work2);
			}else{
				//移除
				ExpertInfo nowbean = super.findById(Integer.valueOf(bean.getFeId()));
				nowbean.setFcheckType("in");
				nowbean.setFblackTime(bean.getFblackTime());
				nowbean.setFblackDesc(bean.getFblackDesc());
				nowbean.setFopName(bean.getFopName());
				nowbean.setFisBlackStatus("0");	//审批状态  	0默认，1待审批，2已审批
				nowbean.setFisBlack("0");//黑名单状态
				super.saveOrUpdate(nowbean);
				
				String str="HMD"+StringUtil.random8();
				bean.setFwBCode(str);
				bean.setfCheckStatus("9");
				bean.setFeCode(nowbean.getFexpertCode());//专家编码
				bean.setFeName(nowbean.getFexpertName());//专家名称
				
				bean = (ExpertBlackInfo) super.saveOrUpdate(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 历史审批记录
	 * @author 冉德茂
	 * @createtime 2018-09-26
	 * @updatetime 2018-09-26
	 */
	@Override
	public List<ExpertBlackInfo> movehistory(Integer feid) {
		Finder finder = Finder.create(" FROM ExpertBlackInfo WHERE feId="+feid);
		List<ExpertBlackInfo> li = super.find(finder);
		return li;
	}

	/**
	 * 出库 
	 * @author 焦广兴
	 * @createtime 2019-06-19
	 * @updatetime 2019-06-19
	 */
	@Override
	public void outExpert(ExpertOutInfo e, User user) {
		try {
			Date d=new Date();
			e.setfRecTime(d);;//申请时间
			e.setfRecUser(user.getName());//当前申请人
			e.setfCheckStatus("1");	//审核状态
			e.setfRecUserId(user.getId());
			e.setfRecDept(user.getDepartName());
			e.setfRecDeptId(user.getDpID());
			String str="CK"+StringUtil.random8();
			e.setFoCode(str);
			//super.saveOrUpdate(bean);
			ExpertInfo nowbean = super.findById(Integer.valueOf(e.getFeId()));
			nowbean.setFoutTime(e.getfRecTime());
			nowbean.setFoutMsg(e.getFoutMsg());
			nowbean.setFisOutStatus("1");	//审批状态 	1待审批，2已审批
			
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),nowbean.getJoinTable(),nowbean.getBeanCodeField(),nowbean.getBeanCode(), "ZJKCK", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("ZJKCK", user.getDpID());
			Integer flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			User nextUser=userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号		get(0)的原因是一个角色应该只能审批一级，所以查出来li应该只有一个数据
			e.setfUserName(nextUser.getName());
			e.setfUserId(nextUser.getId());
			//设置下节点节点编码
			e.setfNcode(firstKey+"");	
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,e.getBeanCode());
			
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(Integer.valueOf(e.getFeId()));//供应商申请单ID
			work.setTaskCode(e.getFoCode());//为供应商出库编号
			
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(Integer.valueOf(e.getFeId()));//供应商ID
			work2.setTaskCode(e.getFoCode());//为供应商出库编号
			
			if(e.getFflag().equals("1")){//出库
				nowbean.setFcheckType("out");
				work.setTaskName(nowbean.getFexpertName()+"专家出库审批");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				work.setUrl1("/expertgl/detail?checkType=out&id="+e.getFeId());//查看url
				work2.setTaskName(nowbean.getFexpertName()+"专家出库审批");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				work2.setUrl1("/expertgl/detail?checkType=out&id="+e.getFeId());//查看url
				
			}else{ //入库
				nowbean.setFcheckType("in");
				work.setTaskName(nowbean.getFexpertName()+"专家入库审批");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				work.setUrl1("/expertgl/detail?checkType=in&id="+e.getFeId());//查看url
				work2.setTaskName(nowbean.getFexpertName()+"专家入库审批");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				work2.setUrl1("/expertgl/detail?checkType=in&id="+e.getFeId());//查看url
			}
			super.saveOrUpdate(nowbean);
			//保存基本信息
			e = (ExpertOutInfo) super.saveOrUpdate(e); 
			
			
			work.setUrl("/expertcheck/check?checkType=out&id="+e.getFeId());//为审批页面内容显示的url,需要将数据传入不然无法访问
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(d);//任务提交时间
			personalWorkMng.merge(work);
			
			work2.setUrl("/expertOutIn/outJsp?type="+e.getFflag()+"&id="+e.getFeId());//退回修改url
			work2.setUrl2("/expertOutIn/deleteOut?foId="+e.getFoId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work2.setBeforeTime(d);//任务提交时间
			work2.setFinishTime(d);
			personalWorkMng.merge(work2);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	/**
	 * 专家库抽取
	 * @author 焦广兴
	 * @createtime 2019-06-19
	 * @updatetime 2019-06-19
	 */
	@Override
	public List<ExpertInfo> expertExtract(ExpertInfo bean, String num, String label) {
		StringBuffer sbf =new StringBuffer("SELECT F_E_ID,F_E_CODE,F_E_NAME,F_HIGH_EDUCATION,F_STUDY_MAJOR,F_NOW_WORK,F_M_TEL,F_FIELD,F_BIRTHDAY,F_E_SEX,F_CHECK_TYPE FROM T_EXPERT_INFO WHERE F_STAUTS=1 AND (F_CHECK_STAUTS = 9 or F_EXT_2=-1 or F_EXT_3=-1) AND F_CHECK_TYPE='in'");
		if(!StringUtil.isEmpty(label)){ 
			String[] labArr=label.split(",");
			for (String string : labArr) {
				sbf.append(" AND F_FIELD LIKE '%"+string+"%'");
			}
		}
		if(!StringUtil.isEmpty(num)){
			sbf.append(" ORDER BY RAND() LIMIT "+num+"");
		}
		List<ExpertInfo> list=new ArrayList<>();
		List<Object[]> dataList = getSession().createSQLQuery(sbf.toString()).list();
		if (dataList != null && dataList.size() > 0) {
			int i = 0;
			 String[]str=new String[dataList.size()];	//拼接抽取的ID
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			for (Object[] obj: dataList) {
				ExpertInfo t=new ExpertInfo();
				String feId=String.valueOf(obj[0]);
				//拼接ID
				str[i]=feId;
				t.setFeId(Integer.valueOf(feId));
				t.setFexpertCode(String.valueOf(obj[1]));
				t.setFexpertName(String.valueOf(obj[2]));
				t.setFeducation(String.valueOf(obj[3]));
				t.setFstudyMajor(String.valueOf(obj[4]));
				t.setFnowWork(String.valueOf(obj[5]));
				t.setFmTel(String.valueOf(obj[6]));		
				t.setFfield(String.valueOf(obj[7]));
				String s=String.valueOf(obj[8]);
				try {
					t.setFbirthday(sdf.parse(s));
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				t.setFexpertSex(String.valueOf(obj[9]));
				t.setFcheckType(String.valueOf(obj[10]));
				t.setNum(i+1);
				i++;
				list.add(t);
			}
			String s=StringUtil.join(str);	//转换id 为字符串 用，分开
			list.get(0).setFremark(s);	//存入第一个对象里面
		}
		
		return list;            
	}

}

	
	
	


