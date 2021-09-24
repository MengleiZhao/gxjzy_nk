package com.braker.icontrol.expend.refund.manager.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.icontrol.contract.archiving.model.Archiving;
import com.braker.icontrol.expend.refund.manager.RefundInfoMng;
import com.braker.icontrol.expend.refund.model.RefundInfo;
import com.braker.icontrol.expend.refund.model.StudentRefundMoney;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;

@Service
@Transactional
public class RefundInfoMngImpl extends BaseManagerImpl<RefundInfo> implements RefundInfoMng{

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
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	
	@Autowired
	private PrivateInforMng privateInforMng;
	
	@Override
	public Pagination pageList(RefundInfo bean, Integer pageNo, Integer pageSize, String sign, User user) {
		Finder finder = Finder.create(" FROM RefundInfo WHERE 1=1");
		if(!StringUtil.isEmpty(bean.getfInfoCode())){//申请单编码
			finder.append(" and fInfoCode like :fInfoCode");
			finder.setParam("fInfoCode", "%"+ bean.getfInfoCode() +"%");
		}
		if(!StringUtil.isEmpty(bean.getfDeptName())){//申请部门
			finder.append(" and fDeptName like :fDeptName");
			finder.setParam("fDeptName", "%"+ bean.getfDeptName() +"%");
		}
		if(!StringUtil.isEmpty(String.valueOf(bean.getfNewOrOld()))){//新生老生
			finder.append(" and fNewOrOld = :fNewOrOld");
			finder.setParam("fNewOrOld", bean.getfNewOrOld());
		}
		if(!StringUtil.isEmpty(bean.getFlowStauts())){//审批状态
			finder.append(" and flowStauts = :flowStauts");
			finder.setParam("flowStauts", bean.getFlowStauts());
		}
		
		if(!StringUtil.isEmpty(sign)){
			//审批成功后审批页面不可见
			if("sp".equals(sign)){	
				finder.append(" and fUserId2 = '"+ user.getId() +"'");
			}
			//台账
			if("tz".equals(sign)){
				finder.append(" and flowStauts not in('0', '-1')");
				//台账查看权限
				if(user.getRoleName().contains("退费台账查看岗")){
					//退费台账查看岗可以查看所有部门的台账
				}else {
					String deptIdStr = departMng.getDeptIdStrByUser(user);
					if("".equals(deptIdStr)){ //普通岗位只能查看自己的
						finder.append(" and fUserId = :fUserId").setParam("fUserId", user.getId());
					}else if("all".equals(deptIdStr)){//校长可以查看所有人的
						
					}else {//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
						finder.append(" and fDeptId in ("+deptIdStr+")");
					}
				}
			}
		}
		finder.append(" order by flowStauts,updateTime desc");
		Pagination p = super.find(finder, pageNo, pageSize);
		List<RefundInfo> list = (List<RefundInfo>) p.getList();
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setNum(i+1);
		}
		p.setList(list);
		return p;
	}

	@Override
	public void save(RefundInfo bean, String files, String mingxi, User user) throws Exception {
		//日期 
		Date date = new Date();
		
		if(bean.getfRID()==null){	//新增
			//创建人、创建时间
			bean.setCreator(user.getName());
			bean.setCreateTime(date);
		}else {	//修改
			//修改人、修改时间
			bean.setUpdator(user.getName());
			bean.setUpdateTime(date);
		}
		
		//送审
		if("1".equals(bean.getFlowStauts())){
			//储存业务范围
			String busiArea = null;	
			if(bean.getfNewOrOld()==0){
				busiArea = "XSTF";	//新生退费
			}else if(bean.getfNewOrOld()==1){
				busiArea = "LSTF";	//老生退费
			}
			
			//得到第一个审批节点key
			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(),busiArea,user);
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode(busiArea,user.getDpID());
			Integer flowId=processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			User nextUser=userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号		get(0)的原因是一个角色应该只能审批一级，所以查出来li应该只有一个数据
			bean.setUserName2(nextUser.getName());
			bean.setfUserId2(nextUser.getId());
			//设置下节点节点编码
			bean.setnCode(firstKey+"");	
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
			
			//保存基本信息
			bean = (RefundInfo) super.saveOrUpdate(bean);
			
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(bean.getfUserId2());//任务处理人ID既是下节点处理人ID
			work.setTaskId(bean.getfRID());//项目ID
			work.setTaskCode(bean.getfInfoCode());//项目编号
			if(bean.getfNewOrOld()==0){
				work.setTaskName("[新生退费申请]"+bean.getfInfoCode());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			}else if(bean.getfNewOrOld()==1){
				work.setTaskName("[老生退费申请]"+bean.getfInfoCode());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			}
			work.setUrl("/refund/check/"+bean.getfRID());//审批地址
			work.setUrl1("/refund/detail/"+bean.getfRID());//查看地址（审批完成时使用）
			work.setTaskStauts("0");//待办
			work.setBeforeUser(user.getName());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(date);//任务提交时间
			work.setType("1");//任务类型（1审批）
			personalWorkMng.merge(work);

			//添加申请人的个人首页已办信息
			PersonalWork work2 = new PersonalWork();
			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
			work2.setTaskId(bean.getfRID());//项目ID
			work2.setTaskCode(bean.getfInfoCode());//项目编号
			if(bean.getfNewOrOld()==0){
				work.setTaskName("[新生退费申请]"+bean.getfInfoCode());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			}else if(bean.getfNewOrOld()==1){
				work.setTaskName("[老生退费申请]"+bean.getfInfoCode());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			}
			work2.setUrl("/refund/edit/"+bean.getfRID());//退回修改地址（被退回时使用）
			work2.setUrl1("/refund/detail/"+bean.getfRID());//查看地址
			work2.setUrl2("/refund/delete/"+bean.getfRID());//删除地址（被退回时使用）
			work2.setTaskStauts("2");//已办
			work2.setBeforeUser(user.getName());//任务提交人姓名
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work2.setBeforeTime(date);//任务提交时间
			work2.setFinishTime(bean.getCreateTime());
			work2.setType("2");//任务类型（1查看）
			personalWorkMng.merge(work2);
		}else {
			//保存基本信息
			bean = (RefundInfo) super.saveOrUpdate(bean);
		}
		//保存附件
		attachmentMng.joinEntity(bean, files);
		
		//保存详情表
		//获得老的明细
		List<Object> oldList = getMingxi("StudentRefundMoney", "fRId", bean.getfRID());
		//获取新的明细
		List nowList = getMingXiJson(mingxi, StudentRefundMoney.class);
		if(oldList.size() > 0){//修改明细
			//比较新老明细的不同
			for (int i = oldList.size()-1; i >= 0; i--) {
				StudentRefundMoney old = (StudentRefundMoney) oldList.get(i);
				for (int j = 0; j < nowList.size(); j++) {
					StudentRefundMoney now = (StudentRefundMoney) nowList.get(j);
					if(now.getfId() != null){
						if(now.getfId() == old.getfId()){
							oldList.remove(i);
						}
					}
				}
			}
			//删除在新明细中没有的老明细
			if(oldList.size() > 0){
				for (int i = 0; i < oldList.size(); i++) {
					StudentRefundMoney old = (StudentRefundMoney) oldList.get(i);
					super.delete(old);
				}
			}
			//保存新的明细
			for (int i = 0; i < nowList.size(); i++) {
				StudentRefundMoney now = (StudentRefundMoney) nowList.get(i);
				now.setfRId(bean.getfRID());
				now.setUpdator(user.getName());
				now.setUpdateTime(date);
				Double refundRoom = now.getRefundRoom() != null?now.getRefundRoom():0;
				Double refundTuition = now.getRefundTuition() != null?now.getRefundTuition():0;
				now.setSumMoney( refundRoom + refundTuition);
				super.merge(now);
			}
		}else {//新增明细
			//保存新的明细
			for (int i = 0; i < nowList.size(); i++) {
				StudentRefundMoney now = (StudentRefundMoney) nowList.get(i);
				now.setfRId(bean.getfRID());
				now.setCreator(user.getName());
				now.setCreateTime(date);
				Double refundRoom = String.valueOf(now.getRefundRoom()) != null?now.getRefundRoom():0;
				Double refundTuition = String.valueOf(now.getRefundTuition()) != null?now.getRefundTuition():0;
				now.setSumMoney( refundRoom + refundTuition);
				super.merge(now);
			}
		}
	}

	@Override
	public List<Object> getMingxi(String tableName, String idName, Integer id) {
		Finder finder = Finder.create(" FROM " + tableName + " WHERE " + idName + "=" +id);
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
	public void saveCheck(TProcessCheck checkBean, RefundInfo bean,
			String files, User user) throws Exception {
		
		bean = this.findById(bean.getfRID());
		CheckEntity entity = (CheckEntity)bean;
		String checkUrl = "/refund/check/";
		String lookUrl = "/refund/detail/";
		
		//储存业务范围
		String busiArea = null;	
		if(bean.getfNewOrOld() == 0){
			busiArea = "XSTF";	//新生退费
		}else if(bean.getfNewOrOld() == 1){
			busiArea = "LSTF";	//老生退费
		}
		bean = (RefundInfo) tProcessCheckMng.checkProcess(checkBean, entity, user, busiArea, checkUrl, lookUrl, files);
		super.saveOrUpdate(bean);
	}

	@Override
	public String reCall(String id) {
		RefundInfo findById = this.findById(Integer.valueOf(id));
		//删除待办
		personalWorkMng.deleteDb(findById.getNextCheckUserId() , findById.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="老生退费申请被撤回消息";
		String msg="您待审批合同  "+findById.getfInfoCode() +",任务编号：("+findById.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, findById.getNextCheckUserId(), "3");
		//撤回
		RefundInfo refundInfo = (RefundInfo) reCall((CheckEntity) findById);
		this.updateDefault(refundInfo);
		return "操作成功";
	}
	
	
	
}
