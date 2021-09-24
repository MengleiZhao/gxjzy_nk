package com.braker.icontrol.cgmanage.cgsupplier.manager.impl;


import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
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
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.cgmanage.cginquiries.model.InqWinningRef;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierMng;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierBlackInfo;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierOut;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;

/**
 * 供应商管理的service实现类
 * @author 冉德茂
 * @createtime 2018-09-11
 * @updatetime 2018-09-11
 */
@Service
@Transactional
public class SupplierMngImpl extends BaseManagerImpl<WinningBidder> implements SupplierMng {
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
	
	@Autowired
	private SupplierMng supplierMng;
	
	/*
	 * 分页查询(供应商申请页面)
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	@Override
	public Pagination pageList(WinningBidder bean, int pageNo, int pageSize) {

		Finder finder =Finder.create("  FROM WinningBidder WHERE fstauts <>99");
		
		if(!StringUtil.isEmpty(bean.getFwCode())){ //按供应商编码模糊查询
			finder.append(" AND fwCode LIKE :fwCode");
			finder.setParam("fwCode", "%"+bean.getFwCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFwName())){ //按供应商名称模糊查询
			finder.append(" AND fwName LIKE :fwName");
			finder.setParam("fwName", "%"+bean.getFwName()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFcheckStauts())){ //按状态 所有未审核通过的
			finder.append(" AND (fcheckStauts=0 or fcheckStauts=-1 or fcheckStauts=-4 or fcheckStauts=1 or fcheckStauts=9 OR fisBlackStatus=1 OR fisBlackStatus=-1 OR fisBlackStatus=-4 OR fisOutStatus=1 OR fisOutStatus=-1 OR fisOutStatus=-2 OR fisOutStatus=-4)");
		}
		if(!StringUtil.isEmpty(bean.getFcheckType())){
			finder.append("	AND fcheckStauts=9");
			if(bean.getFcheckType().equals("in")){	//入库申请 列出所有 已出库的
				finder.append(" AND fcheckType='out' AND (fisOutStatus=9 or fisOutStatus=-2 or fisOutStatus=-4)"); //-2：出库后在入库 被退回的
			//}else if(bean.getFcheckType().equals("out")||bean.getFcheckType().equals("black")){ //出库申请 列出所有在库的、黑名单申请 列出所有在库的
			}else{	//finder.append("	AND fcheckStauts=9 AND fcheckType='in' AND ( fisOutStatus=9 or fisOutStatus =-1 or fisOutStatus=0) AND (fisBlackStatus=0 or fisBlackStatus=-1)"); 
				finder.append(" AND fcheckType='in' AND fisOutStatus in(0,-1,-4,9) AND fisBlackStatus in(0,-1,-4)"); 
			}
		}
		finder.append(" order by fwId desc ");
		return super.find(finder,pageNo,pageSize);
	}
	/*
	 * 中标登记选择供应商页面，供应商统计展示供应商列表
	 * @author 冉德茂
	 * @createtime 2018-10-19
	 * @updatetime 2018-10-19
	 */
	@Override
	public List<WinningBidder> getWhiteSupplier(WinningBidder bean){
		//选择未删除  不是黑名单  并且通过审核的供应商  
		Finder finder =Finder.create(" FROM WinningBidder WHERE fstauts <>"+99+" AND fcheckStauts = "+9+" AND fisBlack = "+0+" ");
		
		if(!StringUtil.isEmpty(bean.getFwCode())){ //按供应商编码模糊查询
			finder.append(" AND fwCode LIKE :fwCode");
			finder.setParam("fwCode", "%"+bean.getFwCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFwName())){ //按供应商名称模糊查询
			finder.append(" AND fwName LIKE :fwName");
			finder.setParam("fwName", "%"+bean.getFwName()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFwuserName())){ //按供应商名称模糊查询
			finder.append(" AND fwuserName LIKE :fwuserName");
			finder.setParam("fwuserName", "%"+bean.getFwuserName()+"%");
		}
		//加这一行，是新增询价对比的商家，去掉同一个采购批次下的供应商。 
		if(!StringUtil.isEmpty(bean.getFpId())){
			String ids=getIdsFromInqWinningRef(bean.getFpId());
			if(ids.length()>0){
				finder.append(" and fwId not in ("+ids+")");
			}
		}
		return super.find(finder);
	}
	/**
	 * 查询出同一采购批次下的供应商 id
	 * @author 安达
	 * @createtime 2018-11-01
	 * @updatetime 2018-11-01
	 * @param fpid
	 * @return
	 */
	public String getIdsFromInqWinningRef(String fpid){
		Finder finder =Finder.create(" FROM InqWinningRef WHERE fpId="+fpid);
		List<InqWinningRef> list=super.find(finder);
		String ids="";
		for(int i=0;i<list.size();i++){
			if("".equals(ids)){
				ids=list.get(i).getFwId()+"";
			}else{
				ids=ids+","+list.get(i).getFwId();
			}
		}
		return ids;
	}
	/*
	 * 新增供应商的保存和审核
	 * @author 冉德茂
	 * @createtime 2018-09-11
	 * @updatetime 2018-09-11
	 */
	@Override
	@Transactional(propagation=Propagation.REQUIRED)//事务处理
	public void save(WinningBidder bean, User user)  throws Exception{

		Date d = new Date();
		if (bean.getFwId()==null) {
			//创建人、创建时间、发布时间  设置验收状态
			bean.setCreator(user.getName());
			bean.setCreateTime(d);
			bean.setfRecDept(user.getDepartName());
			bean.setfRecDeptId(user.getDpID());
			bean.setfRecTime(d);
		} else {
			//修改人、修改时间
			bean.setUpdator(user.getAccountNo());
			bean.setUpdateTime(d);
		}
		//保存公司规模和 公司性质  字典表
		bean.setFcompanySize(bean.getFcompanySize());
		bean.setFcompanyNature(bean.getFcompanyNature());
		bean.setFcompanySize(economicMng.findLookupsByCode(bean.getFcompanySize().getCode(), "COMPANY_SIZE"));
		bean.setFcompanyNature(economicMng.findLookupsByCode(bean.getFcompanyNature().getCode(), "COMPANY_NATURE"));
		//设置供应商的黑名单和数据的删除状态
		bean.setFisBlackStatus("0");//黑名单默认审批状态
		bean.setFisOutStatus("0");//出库默认审批状态
		bean.setFisBlack("0");//默认0  拉黑为1
		bean.setFstauts("1");//默认1  删除改为99
		bean.setFaccFreq(0);//新增  默认拉黑次数是0
		
		/**叶添加**/
		bean.setfRecUserId(user.getId());
			
		//以下为工作流的节点配置（如果点送审则设置进入工作流1为提交2为审核中）
		if(bean.getFcheckStauts().equals("1") || bean.getFcheckStauts().equals("2")){
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(), bean.getBeanCodeField(),bean.getBeanCode(),"CGFWSQ", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("CGFWSQ", user.getDpID());
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
			if(bean.getFwId()==null){
				bean = (WinningBidder) super.saveOrUpdate(bean); //新增
			}else{
				super.updateDefault(bean);//修改
			}
			
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getFwId());//供应商申请单ID
			work.setTaskCode(bean.getFwCode());//为供应商的编号
			//判断审批类型
			String taskName = bean.getFwName();
			if("in".equals(bean.getFcheckType())){
				taskName = "[供应商]" + taskName + "入库申请";
			} else if("out".equals(bean.getFcheckType())){
				taskName = "[供应商]" + taskName + "出库申请";
			} else if("black".equals(bean.getFcheckType())){
				taskName = "[供应商]" + taskName + "黑名单申请";
			}
			work.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/suppliercheck/check?checkType=in&id="+bean.getFwId());//为审批页面内容显示的url,需要将数据传入不然无法访问
			work.setUrl1("/suppliergl/detail?checkType=in&id="+bean.getFwId());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(d);//任务提交时间
			personalWorkMng.merge(work);
			
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(bean.getFwId());//申请单ID
			work2.setTaskCode(bean.getFwCode());//为申请单的单号
			work2.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/suppliergl/edit?id="+ bean.getFwId()+"&checkType=in");//退回修改url
			work2.setUrl1("/suppliergl/detail?checkType=in&id="+ bean.getFwId());//查看url
			work2.setUrl2("/suppliergl/delete?id="+ bean.getFwId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work2.setBeforeTime(d);//任务提交时间
			work2.setFinishTime(d);
			personalWorkMng.merge(work2);
		} else {
			//保存基本信息
			if(bean.getFwId()==null){
				bean = (WinningBidder) super.saveOrUpdate(bean); //新增
			}else{
				super.updateDefault(bean);//修改
			}
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
		WinningBidder bean = super.findById(id);
		bean.setFstauts("99");
		super.saveOrUpdate(bean);
	}
	/*
	 * 移入黑名单
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */
	@Override
	public void moveintoblack(WinningBidder bean, User user) {

		WinningBidder nowbean = super.findById(Integer.valueOf(bean.getFwId()));
		int count = nowbean.getFaccFreq();
		nowbean.setFisBlack("1");//黑名单状态
		nowbean.setFblackTime(new Date());//拉黑时间
		nowbean.setFaccFreq(count+1);//拉黑次数+1
		nowbean.setFblackDesc(bean.getFblackDesc());//拉黑原因
		nowbean.setFopName(user.getName());//拉黑人  当前操作人
		nowbean = (WinningBidder) super.saveOrUpdate(nowbean);

	}
	/*
	 * 移出黑名单
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */
	@Override
	public void moveoutblack(Integer id) {
		WinningBidder bean = super.findById(id);
		bean.setFisBlack("0");
		bean.setFisBlackStatus("0");
		bean.setFcheckType("in");
		bean = (WinningBidder) super.saveOrUpdate(bean);
	}
	/*
	 * 分页查询（黑名单页面）
	 * @author 冉德茂
	 * @createtime 2018-09-12
	 * @updatetime 2018-09-12
	 */
	@Override
	public Pagination blackpageList(WinningBidder bean,String timea,String timeb, int pageNo, int pageSize) {
		//选择未删除  是黑名单  并且通过审核的供应商  
		Finder finder =Finder.create(" FROM WinningBidder WHERE fstauts <>"+99+" AND fcheckStauts = "+9+" AND fisBlack = "+1+" ");
		if(!StringUtil.isEmpty(bean.getFwCode())){ //按供应商编码模糊查询
			finder.append(" AND fwCode LIKE :fwCode");
			finder.setParam("fwCode", "%"+bean.getFwCode()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFwName())){ //按供应商名称模糊查询
			finder.append(" AND fwName LIKE :fwName");
			finder.setParam("fwName", "%"+bean.getFwName()+"%");
		}
		if(!StringUtil.isEmpty(String.valueOf(timea)) && !StringUtil.isEmpty(String.valueOf(timeb))){
			finder.append(" AND DATE_FORMAT(fblackTime,'%Y-%m-%d') >='"+timea+"' AND DATE_FORMAT(fblackTime,'%Y-%m-%d') <= '"+timeb+"'");//日期去时分秒函数
		}else if(!StringUtil.isEmpty(String.valueOf(timea)) ){
			finder.append(" AND DATE_FORMAT(fblackTime,'%Y-%m-%d') >='"+timea+"' ");//日期去时分秒函数
		}else if(!StringUtil.isEmpty(String.valueOf(timeb))){
			finder.append(" AND  DATE_FORMAT(fblackTime,'%Y-%m-%d') <= '"+timeb+"'");//日期去时分秒函数
		}
		finder.append(" order by fwId desc");
		return super.find(finder,pageNo,pageSize);
	}
	/*
	 * 分页查询（白名单页面）
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */
	@Override
	public Pagination whitepageList(WinningBidder bean,String amounta,String amountb, int pageNo, int pageSize) {
		//选择未删除   并且通过审核的供应商  
		Finder finder =Finder.create(" FROM WinningBidder WHERE fstauts <>99 AND fcheckStauts = 9 AND fisBlackStatus <>1 and fisOutStatus <>1");
		/*if(!StringUtil.isEmpty(bean.getFwRemark()) && bean.getFwRemark().equals("out")){	//出库申请列表 只列出在库
			finder.append(" AND fisBlack=0 AND fisBlackStatus=0"); //不是黑名单的
		}
		if(!StringUtil.isEmpty(bean.getFwRemark()) && bean.getFwRemark().equals("black")){	//黑名单申请列表 只列出在库
			finder.append(" AND fstauts=1 AND fisOutStatus=0"); //不是已出库的
		}*/
		if(!StringUtil.isEmpty(bean.getFwName())){ //按供应商名称模糊查询
			finder.append(" AND fwName LIKE :fwName");
			finder.setParam("fwName", "%"+bean.getFwName()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFindustry())){ //按行业模糊查询
			finder.append(" AND findustry LIKE :findustry");
			finder.setParam("findustry", "%"+bean.getFindustry()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFcheckType())){ //按供应商状态查询
			if(bean.getFcheckType().equals("out")){
				finder.append(" AND fcheckType ='out' AND (fisOutStatus=9 or fisOutStatus=-2)");
			}else if(bean.getFcheckType().equals("black")){
				finder.append(" AND fcheckType ='black' AND fisBlackStatus=9");
			}else{
				finder.append(" AND fcheckType ='in'");
			}
		}
		if(!StringUtil.isEmpty(String.valueOf(amounta)) && !StringUtil.isEmpty(String.valueOf(amountb))){
			finder.append(" AND fregistCapital >="+amounta+" AND fregistCapital <= "+amountb+" ");//日期去时分秒函数
		}else if(!StringUtil.isEmpty(String.valueOf(amounta))){
			finder.append(" AND fregistCapital >="+amounta+"  ");//日期去时分秒函数
		}else if( !StringUtil.isEmpty(String.valueOf(amountb))){
			finder.append(" AND fregistCapital <= "+amountb+" ");//日期去时分秒函数
		}
		finder.append(" order by fwId desc");
		return super.find(finder,pageNo,pageSize);
	}
	/*
	 * 移入/移出黑名单
	 * @author 李安达
	 * @createtime 2019-02-27
	 * @updatetime 2019-02-27
	 */
	@Override
	public void moveblack(SupplierBlackInfo bean, User user) {
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
				WinningBidder nowbean = super.findById(Integer.valueOf(bean.getFwId()));
				nowbean.setFcheckType("black");
				nowbean.setFblackTime(bean.getFblackTime());
				nowbean.setFblackDesc(bean.getFblackDesc());
				//nowbean.setFwId(bean.getFwId());
				nowbean.setFopName(bean.getFopName());
				nowbean.setFisBlackStatus("1");	//审批状态 	1待审批，2已审批
				//nowbean.setFisBlack(bean.getfFlag()+"");//黑名单状态
				super.saveOrUpdate(nowbean);
				
				bean.setFwCode(nowbean.getFwCode());//供应商编码
				bean.setFwName(nowbean.getFwName());//供应商名称
				
				//得到第一个审批节点key
				Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), "GYSHMD", user);
				//根据资源名称和当前登陆者所属部门查询对应工作流
				TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("GYSHMD", user.getDpID());
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
				
				String str="MD"+StringUtil.random8();
				bean.setFwBCode(str);
				bean.setfCheckStatus("1");
				bean = (SupplierBlackInfo) super.saveOrUpdate(bean); //新增
				
				//添加审批人个人首页代办信息
				PersonalWork work = new PersonalWork();
				work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
				work.setTaskId(bean.getFwId());//供应商申请单ID
				work.setTaskCode(bean.getFwBCode());//为供应商黑名单的编号
				work.setTaskName(nowbean.getFwName()+"供应商黑名单审批");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				work.setUrl("/suppliercheck/check?checkType=black&id="+bean.getFwId());//为审批页面内容显示的url,需要将数据传入不然无法访问
				work.setUrl1("/suppliergl/detail?checkType=black&id="+bean.getFwId());//查看url
				work.setTaskStauts("0");//待办
				work.setType("1");//任务类型（1审批）
				work.setBeforeUser(user.getName());//任务提交人姓名
				work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
				work.setBeforeTime(d);//任务提交时间
				personalWorkMng.merge(work);
				
				//添加申请人的个人首页已办信息
				PersonalWork work2 = new PersonalWork();
				work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
				work2.setTaskId(bean.getFwId());//申请单ID
				work2.setTaskCode(bean.getFwBCode());//为供应商黑名单的编号
				work2.setTaskName(nowbean.getFwName()+"供应商黑名单审批");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				work2.setUrl("/blacksuppliergl/inblack?id="+ bean.getFwId());//退回修改url,重新申请
				work2.setUrl1("/suppliergl/detail?checkType=black&id="+ bean.getFwId());//查看url
				work2.setUrl2("/blacksuppliergl/deleteBlack?fwBId="+ bean.getFwBId());//删除url 删除黑名单实体记录
				work2.setTaskStauts("2");//已办
				work2.setType("2");//任务类型（2查看）
				work2.setBeforeUser(user.getName());//任务提交人姓名
				work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
				work2.setBeforeTime(d);//任务提交时间
				work2.setFinishTime(d);
				personalWorkMng.merge(work2);
			}else{
				//移除
				WinningBidder nowbean = super.findById(Integer.valueOf(bean.getFwId()));
				nowbean.setFcheckType("in");
				nowbean.setFblackTime(bean.getFblackTime());
				nowbean.setFblackDesc(bean.getFblackDesc());
				nowbean.setFopName(bean.getFopName());
				nowbean.setFisBlackStatus("0");	//审批状态  	0默认，1待审批，2已审批
				nowbean.setFisBlack("0");//黑名单状态
				super.saveOrUpdate(nowbean);
				
				String str="MD"+StringUtil.random8();
				bean.setFwBCode(str);
				bean.setfCheckStatus("9");
				bean.setFwCode(nowbean.getFwCode());//供应商编码
				bean.setFwName(nowbean.getFwName());//供应商名称
				
				bean = (SupplierBlackInfo) super.saveOrUpdate(bean);
			}
			
		//}
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
	}

	/*
	 * 历史审批记录
	 * @author 冉德茂
	 * @createtime 2018-09-26
	 * @updatetime 2018-09-26
	 */
	@Override
	public List<SupplierBlackInfo> movehistory(Integer fwid) {
		Finder finder = Finder.create(" FROM SupplierBlackInfo WHERE fwId="+fwid+" and fCheckStatus=9");
		List<SupplierBlackInfo> li = super.find(finder);
		return li;
	}
	
	/*
	 * 出库 
	 * @author 焦广兴
	 * @createtime 2019-06-13
	 * @updatetime 2019-06-13
	 */
	@Override
	public void outSupplier(SupplierOut supplierOut, User user) {
		try {
			Date d=new Date();
			supplierOut.setfRecTime(d);;//申请时间
			supplierOut.setfRecUser(user.getName());//当前申请人
			supplierOut.setfCheckStatus("1");	//审核状态
			supplierOut.setfRecUserId(user.getId());
			supplierOut.setfRecDept(user.getDepartName());
			supplierOut.setfRecDeptId(user.getDpID());
			String str="CK"+StringUtil.random8();
			supplierOut.setFoCode(str);
			//super.saveOrUpdate(bean);
			WinningBidder nowbean = super.findById(Integer.valueOf(supplierOut.getFwId()));
			nowbean.setFoutTime(supplierOut.getfRecTime());
			nowbean.setFoutMsg(supplierOut.getFoutMsg());
			nowbean.setFisOutStatus("1");	//审批状态 	1待审批，2已审批
			
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),nowbean.getJoinTable(),nowbean.getBeanCodeField(),nowbean.getBeanCode(), "GYSCK", user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("GYSCK", user.getDpID());
			Integer flowId= processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			User nextUser=userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号		get(0)的原因是一个角色应该只能审批一级，所以查出来li应该只有一个数据
			supplierOut.setfUserName(nextUser.getName());
			supplierOut.setfUserId(nextUser.getId());
			//设置下节点节点编码
			supplierOut.setfNcode(firstKey+"");	
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,supplierOut.getBeanCode());
			
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(Integer.valueOf(supplierOut.getFwId()));//供应商申请单ID
			work.setTaskCode(supplierOut.getFoCode());//为供应商出库编号
			
			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(Integer.valueOf(supplierOut.getFwId()));//供应商ID
			work2.setTaskCode(supplierOut.getFoCode());//为供应商出库编号
			
			if(supplierOut.getFflag().equals("1")){//出库
				nowbean.setFcheckType("out");
				work.setTaskName(nowbean.getFwName()+"供应商出库审批");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				work.setUrl1("/suppliergl/detail?checkType=out&id="+supplierOut.getFwId());//查看url
				work2.setTaskName(nowbean.getFwName()+"供应商出库审批");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				work2.setUrl1("/suppliergl/detail?checkType=out&id="+ supplierOut.getFwId());//查看url
			}else{ //入库
				nowbean.setFcheckType("in");
				work.setTaskName(nowbean.getFwName()+"供应商入库审批");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				work.setUrl1("/suppliergl/detail?checkType=in&id="+supplierOut.getFwId());//查看url
				work2.setTaskName(nowbean.getFwName()+"供应商入库审批");//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
				work2.setUrl1("/suppliergl/detail?checkType=in&id="+ supplierOut.getFwId());//查看url
			}
			
			super.saveOrUpdate(nowbean);
			//保存基本信息
			supplierOut = (SupplierOut) super.saveOrUpdate(supplierOut); 
			
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型（1审批）
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(d);//任务提交时间
			work.setUrl("/suppliercheck/check?checkType=out&id="+supplierOut.getFwId());//为审批页面内容显示的url,需要将数据传入不然无法访问
			personalWorkMng.merge(work);
			
			work2.setUrl("/supplierglOut/outJsp?type="+supplierOut.getFflag()+"&id="+ supplierOut.getFwId());//退回修改url
			work2.setUrl2("/supplierglOut/deleteOut?foId="+ supplierOut.getFoId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work2.setBeforeTime(d);//任务提交时间
			work2.setFinishTime(d);
			personalWorkMng.merge(work2);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
	}
	
	@Override
	public WinningBidder findByName(String name) {
		Finder finder = Finder.create(" FROM WinningBidder WHERE fwName='"+name+"'");
		List<WinningBidder> list = super.find(finder);
		if(list==null || list.size()==0){
			return new WinningBidder();
		}
		return (WinningBidder) super.find(finder).get(0);
	}


	

}

	
	
	


