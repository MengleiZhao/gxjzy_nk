package com.braker.icontrol.contract.ending.manager.Impl;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.MatheUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.ending.manager.EndingMng;
import com.braker.icontrol.contract.ending.model.Ending;
import com.braker.icontrol.contract.filing.manager.ReceivPlanMng;
import com.braker.icontrol.contract.filing.model.ReceivPlan;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;

@Service
@Transactional
public class EndingMngImpl extends BaseManagerImpl<Ending> implements EndingMng{

	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private FormulationMng formulationMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	@Autowired
	private ReceivPlanMng receivPlanMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	@Autowired
	private TNodeDataMng tNodeDataMng;

	
	@Override
	public Pagination list(Ending ending, User user, Integer pageNo,Integer pageSize) {
		Finder finder=Finder.create(" FROM Ending WHERE endStauts='1' ");
		finder.append(" AND fEndUserId =:fEndUserId ");
		finder.setParam("fEndUserId", user.getId());
		if(!StringUtil.isEmpty(ending.getfEndCode())){
			finder.append("AND fEndCode LIKE :fEndCode ");
			finder.setParam("fEndCode", "%"+ending.getfEndCode()+"%");
		}
		if(!StringUtil.isEmpty(ending.getTitle())){
			finder.append("AND contractBasicInfo.fcTitle LIKE :title ");
			finder.setParam("title", "%"+ending.getTitle()+"%");
		}
		if(ending.getfEndTime()!=null){
			finder.append("AND datediff(fEndTime,'"+ending.getfEndTime()+"')=0 ");
		}
		/*if(!StringUtil.isEmpty(ending.getFcAmount())){
			finder.append("AND fcAmount LIKE :fcAmount ");
			finder.setParam("fcAmount", "%"+ending.getFcAmount()+"%");
		}*/
		finder.append("order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
		
		
		
	}

	@Override
	public void save(Ending ending, User user,String files)  throws Exception{
		
		
		ContractBasicInfo cbi = formulationMng.findById(ending.getFcontId());
		ending.setContractBasicInfo(cbi);
		//得到第一个审批节点key
		Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),ending.getJoinTable(),ending.getBeanCodeField(),ending.getBeanCode(), "HTZZ", user);
		//根据资源名称和当前登陆者所属部门查询对应工作流
		TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("HTZZ", user.getDpID());
		//工作流id
		Integer flowId= processDefin.getFPId();
		//第一个审批节点
		TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
		//下一级审批人信息
		User nextUser=userMng.findById(node.getUserId());
		//设置下一级审批人id
		ending.setfNextUserCode(nextUser.getId());
		//设置下一级审批人姓名
		ending.setfNextUserName(nextUser.getName());
		//设置下节点节点编码
		ending.setfNextCode(firstKey+"");
		ending.setCreateTime(new Date());
		ending.setCreator(user.getAccountNo());
		//把历史审批记录全部设置为1，表示重新审批
		tProcessCheckMng.updateStauts(flowId,ending.getBeanCode());
		if(StringUtil.isEmpty(String.valueOf(ending.getfEndId()))){
			ending.setfEndCode(StringUtil.Random("HTZZ"));
			ending.setfEndDept(user.getDepartName());
			ending.setfEndUser(user.getName());
			ending.setfEndUserId(user.getId());
			ending.setfEndTime(new Date());
			
		}else {
			ending.setUpdateTime(new Date());
			ending.setUpdator(user.getAccountNo());
		}
		ending.setEndStauts("1");
		ending=(Ending) super.saveOrUpdate(ending);
		attachmentMng.joinEntity(ending,files);
		if(ending.getStauts().equals("1")){
			//添加审批人个人首页代办信息
			PersonalWork work = new PersonalWork();
			work.setUserId(ending.getfNextUserCode());//任务处理人ID既是下节点处理人 ID
			work.setTaskId(ending.getfEndId());//申请单ID
			work.setTaskCode(ending.getfEndCode());//为申请单的单号
			work.setTaskName("[终止申请]"+ending.getContractBasicInfo().getFcTitle());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			work.setUrl("/ending/approval/"+ending.getfEndId());//为审批页面内容显示的url,需要将数据传入不然无法访问
			work.setUrl1("/ending/detail/"+ ending.getfEndId());//查看url
			work.setTaskStauts("0");//待办
			work.setType("1");//任务类型：1-审批
			work.setBeforeUser(ending.getfEndUser());//任务提交人姓名
			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			work.setBeforeTime(ending.getfEndTime());//任务提交时间
			personalWorkMng.merge(work);
			//添加自己的已办信息
			PersonalWork minwork = new PersonalWork();
			minwork.setUserId(ending.getfEndUserId());//任务处理人ID既是下节点处理人ID
			minwork.setTaskId(ending.getfEndId());//申请单ID
			minwork.setTaskCode(ending.getfEndCode());//为申请单的单号
			minwork.setTaskName("[终止申请]"+ending.getContractBasicInfo().getFcTitle());//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
			minwork.setUrl("/ending/edit/"+ending.getfEndId());//为审批页面内容显示的url,需要将数据传入不然无法访问
			minwork.setUrl1("/ending/detail/"+ ending.getfEndId());//查看url
			minwork.setUrl2("/ending/detail/"+ ending.getfEndId());//，没有删除按钮，不存在删除，所有填写查看路径
			minwork.setTaskStauts("2");//已办
			minwork.setType("2");//任务类型：2-查看
			minwork.setBeforeUser(user.getName());//任务提交人姓名
			minwork.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
			minwork.setBeforeTime(new Date());//任务提交时间
			minwork.setFinishTime(new Date());
			personalWorkMng.merge(minwork);
		}
	}

	@Override
	public List<Ending> find1(String condition1, String val1,String endStauts) {
		Finder finder =Finder.create("FROM Ending WHERE "+condition1+"='"+val1+"'AND endStauts ="+endStauts);
		return super.find(finder);
	}

	@Override
	public Ending findByfcId(String fcId) {
		Finder finder =Finder.create("FROM Ending WHERE contractBasicInfo.fcId ="+Integer.valueOf(fcId)+" AND endStauts='1' ");
		return (Ending) super.find(finder).get(0);
	}

	@Override
	public Pagination appList(Ending ending, User user, Integer pageNo,Integer pageSize) {
		Finder finder=Finder.create("FROM Ending WHERE stauts ='1' AND endStauts='1' AND fNextUserCode='"+user.getId()+"' ");
		if(!StringUtil.isEmpty(ending.getfEndCode())){
			finder.append("AND fEndCode LIKE :fEndCode ");
			finder.setParam("fEndCode", "%"+ending.getfEndCode()+"%");
		}
		if(!StringUtil.isEmpty(ending.getTitle())){
			finder.append("AND contractBasicInfo.fcTitle LIKE :title ");
			finder.setParam("title", "%"+ending.getTitle()+"%");
		}
		if(ending.getfEndTime()!=null){
			finder.append("AND datediff(fEndTime,'"+ending.getfEndTime()+"')=0 ");
		}
		/*if(!StringUtil.isEmpty(ending.getFcAmount())){
			finder.append("AND fcAmount LIKE :fcAmount ");
			finder.setParam("fcAmount", "%"+ending.getFcAmount()+"%");
		}*/
		finder.append("order by updateTime desc");
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public void updateCheck(String id, TProcessCheck checkBean,String endingId, User user,String files)  throws Exception{
		Ending bean = super.findById(Integer.valueOf(endingId));
		CheckEntity entity=(CheckEntity)bean;
		String checkUrl="/ending/approval/";
		String lookUrl ="/ending/edit/";
		bean=(Ending)tProcessCheckMng.checkProcess(checkBean,entity,user,"HTZZ",checkUrl,lookUrl,files);
		super.saveOrUpdate(bean);
		//退还冻结金额
		if("9".equals(bean.getStauts())){
			if( bean.getContractBasicInfo().getFcType().equals("HTFL-01")){
				//查询出相应的指标
				TBudgetIndexMgr budgetIndexMgr = budgetIndexMgrMng.findById(bean.getContractBasicInfo().getfBudgetIndexCode());
				//未付款的金额
				List<ReceivPlan> rp = receivPlanMng.queryMoney1(bean.getContractBasicInfo().getFcId());
				BigDecimal d=BigDecimal.ZERO;
				for (int i = 0; i < rp.size(); i++) {
					d=d.add(rp.get(i).getfRecePlanAmount());
				}
				//冻结/剩余金额都是万元，转换
				d=d.divide(BigDecimal.valueOf(10000));
				//冻结金额减去未付款金额
				budgetIndexMgr.setDjAmount(budgetIndexMgr.getDjAmount().subtract(d));
				//剩余金额加上无付款金额
				budgetIndexMgr.setSyAmount(budgetIndexMgr.getSyAmount().add(d));
				super.merge(budgetIndexMgr);
			}
			ContractBasicInfo cbi = bean.getContractBasicInfo();
			cbi.setfContStauts("-1");
			super.merge(cbi);
		}
		
		
	}

	@Override
	public String reCall(String id) {
		Ending bean = super.findById(Integer.valueOf(id));
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="合同终止申请被撤回消息";
		String msg="您待审批合同  "+bean.getContractBasicInfo().getFcTitle() +",任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean=(Ending) reCall((CheckEntity) bean);
		this.updateDefault(bean);
		return "操作成功";
	}
	
	
	
}
