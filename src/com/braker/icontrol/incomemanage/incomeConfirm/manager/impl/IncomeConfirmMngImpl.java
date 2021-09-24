package com.braker.icontrol.incomemanage.incomeConfirm.manager.impl;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
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
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgreveive.model.AcceptCheck;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.incomemanage.accountsCurrent.model.ReceiveMoneyDetail;
import com.braker.icontrol.incomemanage.incomeConfirm.manager.IncomeConfirmMng;
import com.braker.icontrol.incomemanage.incomeConfirm.model.IncomeConfirmInfo;
import com.braker.icontrol.incomemanage.register.manager.RegisterMng;
import com.braker.icontrol.incomemanage.register.model.IncomeInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;


@Service
@Transactional
public class IncomeConfirmMngImpl extends BaseManagerImpl<IncomeConfirmInfo> implements IncomeConfirmMng {
	@Autowired
	private DepartMng departMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private RegisterMng registerMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	@Autowired
	private IncomeConfirmMng incomeConfirmMng;
	
	@Override
	public Pagination confirmPageList(IncomeConfirmInfo bean, Integer pageNo, Integer pageSize,User user) {
		Finder finder = Finder.create(" FROM IncomeConfirmInfo WHERE status <> '99'");
		finder.append(" and fReqUserid = '"+user.getId()+"'");
		finder.append(" order by confirmTime desc ");
		//设置其他属性
		Pagination p = super.find(finder, pageNo, pageSize);
		return p;
	}

	@Override
	public void saveConfirm(IncomeInfo bean, IncomeConfirmInfo icBean,User user, String mingxiJson, String confirmFiles) throws Exception {
		Date date = new Date();
		bean = registerMng.findById(bean.getFincomeId());
		if(icBean.getFpId() == null) {
			//创建人、创建时间、发布时间  设置验收状态
			icBean.setFpCode(StringUtil.Random("FHTQR"));
			icBean.setCreator(user.getName());
			icBean.setCreateTime(date);
			icBean.setfReqDeptID(user.getDpID());
			icBean.setfReqDept(user.getDepartName());
			icBean.setfReqUserid(user.getId());
			icBean.setfReqUser(user.getName());
			icBean.setfReqTime(date);
			
			icBean.setFincomeId(bean.getFincomeId());
			icBean.setFincomeCode(bean.getFincomeNum());
			icBean.setFincomeName(bean.getFproName());
			icBean.setAmount(bean.getFregisterAmount());
			icBean.setPayAmount(bean.getFconfirmAmount());
			icBean.setNotPayAmount(icBean.getAmount().subtract(icBean.getPayAmount()));
			icBean.setConfirmTime(bean.getFregisterTime());
			
		} else {
			String status = icBean.getStatus();
			String flowStatus = icBean.getFlowStatus();
			icBean = super.findById(icBean.getFpId());
			//修改人、修改时间
			icBean.setStatus(status);
			icBean.setFlowStatus(flowStatus);
			icBean.setUpdator(user.getName());
			icBean.setUpdateTime(date);
			icBean.setfReqTime(date);
		}
		icBean=(IncomeConfirmInfo)super.saveOrUpdate(icBean);
		if("1".equals(icBean.getFlowStatus()) || "2".equals(icBean.getFlowStatus())){
			//得到第一个审批节点key
			Integer firstKey = null;
			//根据资源名称和当前登陆者所属部门查询对应工作流
			TProcessDefin processDefin = new TProcessDefin();
			firstKey = tProcessCheckMng.addProcessCheck(user.getDpID(), icBean.getJoinTable(), icBean.getBeanCodeField(), icBean.getBeanCode(), "FHTSRQR", user);
			processDefin = tProcessDefinMng.getByBusiAndDpcode("FHTSRQR", user.getDpID());
			Integer flowId = processDefin.getFPId();
			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
			User nextUser=userMng.findById(node.getUserId());
			//设置下节点处理人姓名和编号
			icBean.setfUserName(nextUser.getName());
			icBean.setfUserCode(nextUser.getId());
			//设置下节点节点编码
			icBean.setfNCode(firstKey + "");
			//把历史审批记录全部设置为1，表示重新审批
			tProcessCheckMng.updateStauts(flowId, icBean.getBeanCode());
			//保存验收信息
			icBean=(IncomeConfirmInfo)super.saveOrUpdate(icBean);
			
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
			work.setTaskId(icBean.getFpId());//申请单ID
			work.setTaskCode(icBean.getFpCode());//为申请单的单号
			work.setTaskName("[非合同收入确认]"+icBean.getFincomeName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/incomeConfirm/check?id="+icBean.getFpId());//为审批页面内容显示的url,需要将数据传入不然无法访问
			work.setUrl1("/incomeConfirm/detail?id="+icBean.getFpId());//查看url
			work.setUrl2("/incomeConfirm/delete?id=" + icBean.getFpId());//删除url
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
			work2.setTaskId(icBean.getFpId());//申请单ID
			work2.setTaskCode(icBean.getFpCode());//为申请单的单号
			work2.setTaskName("[非合同收入确认]"+icBean.getFincomeName());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work2.setUrl("/incomeConfirm/edit?id=" + icBean.getFpId());//查看url
			work2.setUrl1("/incomeConfirm/detail?id=" + icBean.getFpId());//查看url
			work2.setUrl2("/incomeConfirm/delete?id=" + icBean.getFpId());//删除url
			work2.setTaskStauts("2");//已办
			work2.setType("2");//任务类型（2查看）
			work2.setTaskType("0");//任务归属（0发起人）
			work2.setBeforeUser(user.getName());//任务提交人姓名
			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work2.setBeforeTime(date);//任务提交时间
			work2.setFinishTime(date);
			personalWorkMng.merge(work2);
			
			
			List<ReceiveMoneyDetail> rp = JSON.parseObject("["+mingxiJson.toString()+"]",new TypeReference<List<ReceiveMoneyDetail>>(){});
			
			for(int i = 0 ; i < rp.size() ; i++) {
				if("1".equals(rp.get(i).getPayStatus())) {
					rp.get(i).setFpId(icBean.getFpId());
				}
				super.merge(rp.get(i));
			}
		}else {
			List<ReceiveMoneyDetail> rp = JSON.parseObject("["+mingxiJson.toString()+"]",new TypeReference<List<ReceiveMoneyDetail>>(){});
			
			for(int i = 0 ; i < rp.size() ; i++) {
				super.merge(rp.get(i));
			}
			//保存验收信息
			icBean=(IncomeConfirmInfo)super.saveOrUpdate(icBean);
		}
		
		
		attachmentMng.joinEntity(icBean, confirmFiles);
	}

	@Override
	public void reCall(Integer id) {
		//根据id查询对象
		IncomeConfirmInfo bean=(IncomeConfirmInfo)super.findById(id);
		List<ReceiveMoneyDetail> rmdList = incomeConfirmMng.findDetailById(Integer.toString(id));
		for(int i =0;i<rmdList.size();i++) {
			rmdList.get(i).setFpId(null);
			super.merge(rmdList.get(i));
		}
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="申请被撤回消息";
		String msg="您待审批的  "+bean.getFincomeName() +",任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean=(IncomeConfirmInfo) reCall((CheckEntity) bean);
		this.updateDefault(bean);
		
	}

	@Override
	public List<ReceiveMoneyDetail> findDetailById(String Id) {
		Finder finder = Finder.create(" FROM ReceiveMoneyDetail WHERE fpId = '"+Id+"'");
		return super.find(finder);
	}

	@Override
	public void delete(Integer id) {
		IncomeConfirmInfo bean = super.findById(id);
		//根据id查询对象
		List<ReceiveMoneyDetail> rmdList = incomeConfirmMng.findDetailById(Integer.toString(id));
		for(int i =0;i<rmdList.size();i++) {
			rmdList.get(i).setFpId(null);
			super.merge(rmdList.get(i));
		}
		bean.setStatus("99");
		super.saveOrUpdate(bean);
	}

	@Override
	public Pagination confirmCheckPageList(IncomeConfirmInfo bean, Integer page, Integer rows, User user) {
		Finder finder = Finder.create(" FROM IncomeConfirmInfo WHERE status <> '99'");
		finder.append(" and fUserCode = '"+user.getId()+"'");
		finder.append(" order by confirmTime desc ");
		//设置其他属性
		Pagination p = super.find(finder, page, rows);
		return p;
	}

	@Override
	public void saveCheck(TProcessCheck checkBean, IncomeConfirmInfo bean, String spjlFile, User user) throws Exception {
		IncomeConfirmInfo busiBean = this.findById(bean.getFpId());
		CheckEntity entity = (CheckEntity)busiBean;
		//设置下一级审批人待办和查看路径
		String checkUrl = "/incomeConfirm/check?id=";
		String lookUrl = "/incomeConfirm/detail?id=";
		//查询审批流程
		busiBean = (IncomeConfirmInfo)tProcessCheckMng.checkProcess(checkBean, entity, user, "FHTSRQR", checkUrl, lookUrl, spjlFile);
		if("-1".equals(busiBean.getFlowStatus())) {
			List<ReceiveMoneyDetail> rmdList = incomeConfirmMng.findDetailById(Integer.toString(busiBean.getFpId()));
			for(int i = 0 ; i < rmdList.size() ; i++) {
				rmdList.get(i).setFpId(null);
				super.merge(rmdList.get(i));
			}
		}
		if("9".equals(busiBean.getFlowStatus())){//审批通过的时候,获取审批流程中的审批人信息
			List<ReceiveMoneyDetail> rmdList = incomeConfirmMng.findDetailById(Integer.toString(busiBean.getFpId()));
			BigDecimal sum = new BigDecimal(0);
			for(int i = 0 ; i < rmdList.size() ; i++) {
				sum = sum.add(rmdList.get(i).getPlanMoney());
			}
			IncomeInfo income = registerMng.findById(busiBean.getFincomeId());
			income.setFconfirmAmount(sum);
			income.setfRegisteredAmount(income.getFregisterAmount().subtract(sum));
			registerMng.saveOrUpdate(income);
			busiBean.setPayAmount(sum);
			busiBean.setNotPayAmount(busiBean.getAmount().subtract(sum));
		}
		super.saveOrUpdate(busiBean);
	}

	@Override
	public List<IncomeConfirmInfo> findByIncomeId(String fincomeId,String fpId) {
		Finder finder = Finder.create(" FROM IncomeConfirmInfo WHERE fincomeId = '"+fincomeId+"' and status <> '99' and fpId <> '"+fpId+"'");
		return super.find(finder);
	}
}
