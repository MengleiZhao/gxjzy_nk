package com.braker.icontrol.incomemanage.register.manager.impl;



import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
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
import com.braker.icontrol.budget.data.entity.BudgetData1;
import com.braker.icontrol.budget.data.entity.BudgetData2;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.release.manager.TBasicItfMng;
import com.braker.icontrol.budget.release.manager.TProItfMng;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.apply.model.ReceptionObservePlan;
import com.braker.icontrol.incomemanage.accountsCurrent.model.ReceiveMoneyDetail;
import com.braker.icontrol.incomemanage.businessService.manager.BusinessServiceMng;
import com.braker.icontrol.incomemanage.businessService.model.BusinessServiceInfo;
import com.braker.icontrol.incomemanage.register.manager.RegisterMng;
import com.braker.icontrol.incomemanage.register.model.IncomeInfo;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;



/**
 *收入登記的的service实现类
 * @author 冉德茂
 * @createtime 2018-08-07
 * @updatetime 2018-08-07
 */
@Service
@Transactional
public class RegisterMngImpl extends BaseManagerImpl<IncomeInfo> implements RegisterMng {
	@Autowired
	private TBasicItfMng basicItfMng;
	
	@Autowired
	private TProItfMng proItfMng; 
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
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private AttachmentMng attachmentMng;
	@Autowired
	private BusinessServiceMng businessServiceMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	
	/*
	 * 分页查询
	 * @author 冉德茂
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 */
	@Override
	public Pagination pageList(IncomeInfo bean, int pageNo, int pageSize,User user,String fCode,String fProName,String fDeptName,String fType) {
		//查询条件
		StringBuilder sbf = new StringBuilder("SELECT * FROM T_INCOME_INFO WHERE F_STAUTS<>99 ");
		//审批成功后审批页面不可见
		if(!StringUtil.isEmpty(bean.getfFlowStauts())){
			if("2".equals(bean.getfFlowStauts())){	
				sbf.append(" and F_NEXT_USER_CODE = '" + user.getId() + "'");
			}
		}else{
			sbf.append(" and F_INCOME_USER_ID='"+user.getId()+"'");
		}
//		if(!StringUtil.isEmpty(bean.getFincomeNum())){
//			sbf.append(" and (concat(F_INCOME_NUM,',',F_PRO_NAME,',',F_REGISTER_DEPART,',',F_REGISTER_PERSON,',',F_REGISTER_TIME) LIKE '%"+bean.getFincomeNum()+"%')");
//		}
		if(!StringUtil.isEmpty(fCode)){
			sbf.append(" and F_INCOME_NUM like '%"+fCode+"%'");
		}
		if(!StringUtil.isEmpty(fProName)){
			sbf.append(" and F_PRO_NAME like '%"+fProName+"%'");
		}
		if(!StringUtil.isEmpty(fDeptName)){
			sbf.append(" and F_REGISTER_DEPART like '%"+fDeptName+"%'");
		}
		if(!StringUtil.isEmpty(fType)){
			sbf.append(" and F_FLOW_STAUTS like '%"+fType+"%'");
		}
		sbf.append(" order by F_REGISTER_TIME desc ");
		String str=sbf.toString();
		Pagination p = super.findBySql(new IncomeInfo(), str, pageNo, pageSize);
		return p;
	}
	
	@Override
	public Pagination confirmPageList(IncomeInfo bean, int pageNo, int pageSize,User user) {
		//查询条件
		StringBuilder sbf = new StringBuilder("SELECT * FROM T_INCOME_INFO WHERE F_STAUTS<>99 AND F_FLOW_STAUTS='9' ");
		if(user.getRoleName().contains("出纳岗")){
			
		}else{
			String deptIdStr=departMng.getDeptIdStrByUser(user);
			if("".equals(deptIdStr)){ //普通岗位只能查看自己的
				sbf.append(" and F_INCOME_USER_ID='"+user.getId()+"'");
			}else if("all".equals(deptIdStr)){//校长可以查看所有人的
				
			}else{//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
				sbf.append(" and F_REGISTER_DEPART_ID in ("+deptIdStr+")");
			}
			//sbf.append(" and F_INCOME_USER_ID='"+user.getId()+"'");
		}
		if(!StringUtil.isEmpty(bean.getFincomeNum())){
			sbf.append(" and (concat(F_INCOME_NUM,',',F_PRO_NAME,',',F_REGISTER_DEPART,',',F_REGISTER_PERSON,',',F_REGISTER_TIME,',',F_CONFIRM_AMOUNT,',',F_REGISTERED_AMOUNT) LIKE '%"+bean.getFincomeNum()+"%')");
		}
		sbf.append(" order by F_REGISTER_TIME desc ");
		String str=sbf.toString();
		Pagination p = super.findBySql(new IncomeInfo(), str, pageNo, pageSize);
		return p;
	}
	/*
	 * 保存收入信息
	 * @author 冉德茂
	 * @createtime 2018-08-08
	 * @updatetime 2018-08-08
	 */

	@Override
	public void save(IncomeInfo bean, User user,String mingxiJson,String files)throws Exception  {
		Date date = new Date();
		if (bean.getFincomeId() == null) {//新增
			//创建人、创建时间、发布时间  设置验收状态
			bean.setCreator(user.getName());
			bean.setCreateTime(date);
			//保存部门   到账类型  到账方式  到账账户
			bean.setfReqTime(date);
			bean.setfReqUserid(user.getId());
			bean.setfReqUser(user.getName());
			bean.setFregisterPerson(user.getName());
			bean.setFregisterPersonId(user.getId());
			bean.setFregisterDepartId(user.getDepart().getId());
			bean.setFregisterDepart(user.getDepart().getName());
			
		} else {//修改
			//修改人、修改时间
			bean.setfReqUserid(user.getId());
			bean.setfReqUser(user.getName());
			bean.setUpdator(user.getName());
			bean.setFregisterPerson(user.getName());
			bean.setFregisterPersonId(user.getId());
			bean.setFregisterDepartId(user.getDepart().getId());
			bean.setFregisterDepart(user.getDepart().getName());
			bean.setUpdateTime(date);
		}
		//新增和修改   数据的删除状态都是0  删除是99
		bean.setFstauts("0");
		bean.setfConfirmStatus("0");
		
		bean.setFconfirmAmount(BigDecimal.ZERO);
		bean.setfRegisteredAmount(BigDecimal.ZERO);;
		//保存基本信息
		
		bean = (IncomeInfo) super.saveOrUpdate(bean);
		//工作流的节点配置（状态1和2可以继续走审批流，该状态不会变）
//		if(bean.getfFlowStauts().equals("1") || bean.getfFlowStauts().equals("2")){
//			Integer flowId =0;
//			User nextUser = new User();
//
//			//得到第一个审批节点key
//			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), "PXSRLKDJ", user);
//			//根据资源名称和当前登陆者所属部门查询对应工作流
//			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("PXSRLKDJ", user.getDpID());
//			flowId= processDefin.getFPId();
//			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
//			nextUser=userMng.findById(node.getUserId());
//			//设置下节点处理人姓名和编号		
//			bean.setfUserName(nextUser.getName());
//			bean.setfUserCode(nextUser.getId());
//			//设置下节点节点编码
//			bean.setfNCode(firstKey+"");	
//			//把历史审批记录全部设置为1，表示重新审批
//			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
//			//保存基本信息
//			bean = (IncomeInfo) super.saveOrUpdate(bean);	
//			//添加审批人个人首页代办信息
//			PersonalWork work = new PersonalWork();
//			work.setUserId(nextUser.getId());//任务处理人ID既是下节点处理人ID
//			work.setTaskId(bean.getBeanId());//申请单ID
//			work.setTaskCode(bean.getBeanCode());//为申请单的单号
//			String taskName = "[培训类收入来款登记]" + bean.getFproName();;
//			work.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
//			work.setUrl("/srregister/check?id="+bean.getBeanId());//审批url
//			work.setUrl1("/srregister/detail?id="+ bean.getBeanId());//查看url
//			work.setTaskStauts("0");//待办
//			work.setType("1");//任务类型（1审批）
//			work.setTaskType("1");//任务归属（1审批人）
//			work.setBeforeUser(user.getName());//任务提交人姓名
//			/**----------------------------------------------------------------**/
//			work.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
//			/**----------------------------------------------------------------**/
//			work.setBeforeTime(date);//任务提交时间
//			personalWorkMng.merge(work);
//
//			//添加申请人的个人首页已办信息
//			PersonalWork work2 = new PersonalWork();
//			work2.setUserId(user.getId());//任务处理人ID既是申请人的ID
//			work2.setTaskId(bean.getBeanId());//申请单ID
//			work2.setTaskCode(bean.getBeanCode());//为申请单的单号
//			work2.setTaskName(taskName);//任务名称模块（菜单）名称+操作如：合同拟定审批等格式固定
//			work2.setUrl("/srregister/edit?id="+ bean.getBeanId());//退回修改url
//			work2.setUrl1("/srregister/detail?id="+ bean.getBeanId());//查看url
//			work2.setUrl2("/srregister/delete?id="+ bean.getBeanId());//删除url
//			work2.setTaskStauts("2");//已办
//			work2.setType("2");//任务类型（2查看）
//			work2.setTaskType("0");//任务归属（0发起人）
//			work2.setBeforeUser(user.getName());//任务提交人姓名
//			/**----------------------------------------------------------------**/
//			work2.setBeforeDepart(user.getDepartName());//任务提交人所属部门名称
//			/**----------------------------------------------------------------**/
//			work2.setBeforeTime(date);//任务提交时间
//			work2.setFinishTime(date);
//			personalWorkMng.merge(work2);
//
//		} else {
//			//保存基本信息
//			bean = (IncomeInfo) super.saveOrUpdate(bean);
//		}

		/** 保存附件 **/
		//保存附件信息
		attachmentMng.joinEntity(bean,files);
		
		/** 保存明细 **/
		List<ReceiveMoneyDetail> rp = JSON.parseObject("["+mingxiJson.toString()+"]",new TypeReference<List<ReceiveMoneyDetail>>(){});
		//获得老的明细
		List<ReceiveMoneyDetail> oldrp = getMingxiList(String.valueOf(bean.getFincomeId()),null);
		for (int i = oldrp.size()-1; i >= 0; i--) {
				ReceiveMoneyDetail oldrpi =  oldrp.get(i);
				for (int j = 0; j < rp.size(); j++) {		
					ReceiveMoneyDetail rpi =  rp.get(j);
					if(rpi.getFrId()!=null){
						if(rpi.getFrId()==oldrpi.getFrId()){
							oldrp.remove(i);
						}
					}
				}
			}
		//删除在新明细中没有的老明细
		if(oldrp.size()>0){
			for (int i = 0; i < oldrp.size(); i++) {
				ReceiveMoneyDetail oldrpi = (ReceiveMoneyDetail) oldrp.get(i);
				super.delete(oldrpi);
			}
		}
		BigDecimal sum = new BigDecimal(0.00);
		for (int i = 0; i < rp.size(); i++) {		
			ReceiveMoneyDetail rpi = (ReceiveMoneyDetail) rp.get(i);
			rpi.setfMSId(bean.getFincomeId());
			rpi.setCreator(user.getAccountNo());
			rpi.setCreateTime(date);
			rpi.setfType("1");
			sum = sum.add(rpi.getPlanMoney());
			super.merge(rpi);
		}
		bean.setFregisterAmount(sum);
		if(bean.getfFlowStauts().equals("1")){
			bean.setfFlowStauts("9");
		}
		//保存基本信息
		bean = (IncomeInfo) super.saveOrUpdate(bean);
	}

	/*
	 * 根据id删除
	 * @author 冉德茂
	 * @createtime 2018-08-80
	 * @updatetime 2018-08-08
	 */
	@Override
	public void delete(Integer id) {
		IncomeInfo bean = super.findById(id);
		bean.setFstauts("99");
		super.saveOrUpdate(bean);
	}

	/** 树形图-收入会计科目  start **/
	
	@Override
	public List<Object[]> getInComeSubject(String basicType,
			String parentCode, String year, String qName) {
		String sql = " select F_EC_ID,F_EC_NAME,F_EC_CODE,F_P_EC_ID "
				+ " from t_acco_tree "
				+ " inner join T_ACCO_YEAR "
				+ " on t_acco_tree.F_Y_B_ID = T_ACCO_YEAR.F_Y_B_ID "
				+ " where F_EC_TYPE='KMLX-03' "
				+ " and left(f_ec_code,1)='6' ";
		
		if (!StringUtil.isEmpty(basicType)) {
			if ("personOut".equals(basicType)) {//人员基本支出
				sql = sql + " and (F_EC_CODE like '301%' or F_EC_CODE like '303%')  ";
			} else if ("commOut".equals(basicType)) {//公用基本支出
				sql = sql + " and F_EC_CODE like '302%' ";
			}
		}
		if (!StringUtil.isEmpty(year)) {//年度
			sql = sql + " and T_ACCO_YEAR.F_PERIOD=" + year;
		}
		if (!StringUtil.isEmpty(parentCode)) {//父节点
			sql = sql + " and F_P_EC_ID=" + parentCode;
		}
		if (!StringUtil.isEmpty(qName)) {//查询-节点名称
			sql = sql + " and F_EC_NAME like '%" + qName + "%'";
		}
		
		sql = sql + " order by F_EC_CODE asc ";
		
		SQLQuery query = getSession().createSQLQuery(sql);
		return query.list();
	}
	@Override
	public Map<String, Integer> getPidMap(String basicType, String parentCodes,
			String year, String qName) {
		Map<String,Integer> pidMap=new HashMap<String,Integer>();
		List<Integer> pidList=getPidListByparentCodes(basicType,parentCodes,year,qName);
		if(pidList!=null && pidList.size()>0){
			for(Object pid:pidList){
				pidMap.put(Integer.valueOf(pid.toString())+"", Integer.valueOf(pid.toString()));
			}
		}
		return pidMap;
	}
	public List<Integer> getPidListByparentCodes(String basicType, String parentCodes, String year, String qName){
		String sql = " select F_P_EC_ID  "
				+ " from t_acco_tree "
				+ " inner join T_ACCO_YEAR "
				+ " on t_acco_tree.F_Y_B_ID = T_ACCO_YEAR.F_Y_B_ID "
				+ " where F_EC_TYPE='KMLX-03' ";
		
		if (!StringUtil.isEmpty(basicType)) {
			if ("personOut".equals(basicType)) {//人员基本支出
				sql = sql + " and (F_EC_CODE like '301%' or F_EC_CODE like '303%')  ";
			} else if ("commOut".equals(basicType)) {//公用基本支出
				sql = sql + " and F_EC_CODE like '302%' ";
			}
		}
		if (!StringUtil.isEmpty(year)) {//年度
			sql = sql + " and T_ACCO_YEAR.F_PERIOD=" + year;
		}
		if (!StringUtil.isEmpty(parentCodes)) {//父节点
			sql = sql + " and F_P_EC_ID in (" + parentCodes+")";
		}
		if (!StringUtil.isEmpty(qName)) {//查询-节点名称
			sql = sql + " and F_EC_NAME like '%" + qName + "%'";
		}
		
		sql = sql + " order by F_EC_CODE asc ";
		
		SQLQuery query = getSession().createSQLQuery(sql);
		return query.list();
	}

	/** 树形图-收入会计科目  end **/
	
	
	public List<ReceiveMoneyDetail> getMingxiList(String fincomeId,String fpId){
		//查询条件
		Finder finder = null;
		if(!StringUtil.isEmpty(fpId)) {
			finder = Finder.create(" FROM ReceiveMoneyDetail WHERE fMSId in("+fincomeId+") and fpId = '"+fpId+"'");
		}else {
			finder = Finder.create(" FROM ReceiveMoneyDetail WHERE fMSId in("+fincomeId+") and fpId is null");
		}
		finder.append(" AND fType='1' ");
		List<ReceiveMoneyDetail> list =  super.find(finder);
		return list;
	}
	public List<ReceiveMoneyDetail> getMingxiRegisterList(String fincomeId){
		//查询条件
		Finder finder = null;
		finder = Finder.create(" FROM ReceiveMoneyDetail WHERE fMSId in("+fincomeId+")");
		finder.append(" AND fType='1' ");
		List<ReceiveMoneyDetail> list =  super.find(finder);
		return list;
	}
	
	public void reCall(Integer id) throws Exception{
		//根据id查询对象
		IncomeInfo bean=(IncomeInfo)super.findById(id);
		//删除待办
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//给待审批人发送消息
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="申请被撤回消息";
		String msg="您待审批的  "+bean.getFproName() +",任务编号：("+bean.getBeanCode()+")于"+sdf.format(new Date())+"被申请人撤回,请及时关注.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//撤回
		bean=(IncomeInfo) reCall((CheckEntity) bean);
		this.updateDefault(bean);
	}
	
	@Override
	public void saveCheck(TProcessCheck checkBean, IncomeInfo bean,
			String files, User user) throws Exception {
		IncomeInfo busiBean = this.findById(bean.getFincomeId());
		CheckEntity entity = (CheckEntity)busiBean;
		//设置下一级审批人待办和查看路径
		String checkUrl = "/srregister/check?id=";
		String lookUrl = "/srregister/detail?id=";
		//查询审批流程
		busiBean = (IncomeInfo)tProcessCheckMng.checkProcess(checkBean, entity, user, "PXSRLKDJ", checkUrl, lookUrl, files);
		
		super.saveOrUpdate(busiBean);
	}
	
	public void saveConfirm(IncomeInfo bean, String mingxiJson, String files) throws Exception{
		IncomeInfo busiBean = this.findById(bean.getFincomeId());
		busiBean.setfConfirmStatus(bean.getfConfirmStatus());
		/** 保存明细 **/
		List<ReceiveMoneyDetail> rp = JSON.parseObject("["+mingxiJson.toString()+"]",new TypeReference<List<ReceiveMoneyDetail>>(){});
		//获得老的明细
		List<ReceiveMoneyDetail> oldrp = getMingxiList(String.valueOf(bean.getFincomeId()),null);
		for (int i = oldrp.size()-1; i >= 0; i--) {
				ReceiveMoneyDetail oldrpi =  oldrp.get(i);
				for (int j = 0; j < rp.size(); j++) {		
					ReceiveMoneyDetail rpi =  rp.get(j);
					if(rpi.getFrId()!=null){
						if(rpi.getFrId()==oldrpi.getFrId()){
							oldrp.remove(i);
						}
					}
				}
			}
		//删除在新明细中没有的老明细
		if(oldrp.size()>0){
			for (int i = 0; i < oldrp.size(); i++) {
				ReceiveMoneyDetail oldrpi = (ReceiveMoneyDetail) oldrp.get(i);
				super.delete(oldrpi);
			}
		}
		BigDecimal fconfirmAmount = BigDecimal.ZERO;//确认金额
		BigDecimal fRegisteredAmount = BigDecimal.ZERO;//登记金额（汇总金额-终止缴款金额）
		
		for (int i = 0; i < rp.size(); i++) {		
			ReceiveMoneyDetail rpi = (ReceiveMoneyDetail) rp.get(i);
			rpi.setfMSId(bean.getFincomeId());
			if(!StringUtil.isEmpty(rpi.getPayStatus())&&"1".equals(rpi.getPayStatus())){//已缴款
				fconfirmAmount=fconfirmAmount.add(rpi.getPlanMoney());
			}
			if(!StringUtil.isEmpty(rpi.getPayStatus())&&"0".equals(rpi.getPayStatus())){// 0-终止缴款
				fRegisteredAmount=fRegisteredAmount.add(rpi.getPlanMoney());
			}
			super.merge(rpi);
		}
		busiBean.setFconfirmAmount(fconfirmAmount);
		busiBean.setfRegisteredAmount(busiBean.getFregisterAmount().subtract(fRegisteredAmount));
		super.saveOrUpdate(busiBean);
	}

	@Override
	public List<IncomeInfo> pageLedgerList(IncomeInfo bean, User user){
		Finder finder =Finder.create("  FROM IncomeInfo WHERE fstauts <> 99 AND fFlowStauts='9' AND fBusiId='"+bean.getfBusiId()+"'");
		List<IncomeInfo> incomeInfos = super.find(finder);
		return incomeInfos;
	}
	
	
	@Override
	public HSSFWorkbook exportExcel(String filePath) {
		FileInputStream fis =null;
		try {
			File file = new File(filePath);
			fis = new FileInputStream(file);
			HSSFWorkbook wb  = new HSSFWorkbook(fis);
			return wb;
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(fis!=null){
				try {
					fis.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return null;
	}

			@Override
			public Pagination choosePageList(IncomeInfo bean, Integer page, Integer rows, User user, String fCode,
					String fProName, String fDeptName, String fType) {
				//查询条件
						StringBuilder sbf = new StringBuilder("SELECT * FROM T_INCOME_INFO WHERE F_STAUTS<>99 and F_FLOW_STAUTS = '9'");
						//审批成功后审批页面不可见
						if(!StringUtil.isEmpty(bean.getfFlowStauts())){
							if("2".equals(bean.getfFlowStauts())){	
								sbf.append(" and F_NEXT_USER_CODE = '" + user.getId() + "'");
							}
						}else{
							sbf.append(" and F_INCOME_USER_ID='"+user.getId()+"'");
						}
//						if(!StringUtil.isEmpty(bean.getFincomeNum())){
//							sbf.append(" and (concat(F_INCOME_NUM,',',F_PRO_NAME,',',F_REGISTER_DEPART,',',F_REGISTER_PERSON,',',F_REGISTER_TIME) LIKE '%"+bean.getFincomeNum()+"%')");
//						}
						if(!StringUtil.isEmpty(fCode)){
							sbf.append(" and F_INCOME_NUM like '%"+fCode+"%'");
						}
						if(!StringUtil.isEmpty(fProName)){
							sbf.append(" and F_PRO_NAME like '%"+fProName+"%'");
						}
						if(!StringUtil.isEmpty(fDeptName)){
							sbf.append(" and F_REGISTER_DEPART like '%"+fDeptName+"%'");
						}
						if(!StringUtil.isEmpty(fType)){
							sbf.append(" and F_FLOW_STAUTS like '%"+fType+"%'");
						}
						sbf.append(" order by F_REGISTER_TIME desc ");
						String str=sbf.toString();
						Pagination p = super.findBySql(new IncomeInfo(), str, page, rows);
						return p;
			}
}