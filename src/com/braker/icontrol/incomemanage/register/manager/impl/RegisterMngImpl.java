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
 *??????????????????service?????????
 * @author ?????????
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
	 * ????????????
	 * @author ?????????
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 */
	@Override
	public Pagination pageList(IncomeInfo bean, int pageNo, int pageSize,User user,String fCode,String fProName,String fDeptName,String fType) {
		//????????????
		StringBuilder sbf = new StringBuilder("SELECT * FROM T_INCOME_INFO WHERE F_STAUTS<>99 ");
		//????????????????????????????????????
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
		//????????????
		StringBuilder sbf = new StringBuilder("SELECT * FROM T_INCOME_INFO WHERE F_STAUTS<>99 AND F_FLOW_STAUTS='9' ");
		if(user.getRoleName().contains("?????????")){
			
		}else{
			String deptIdStr=departMng.getDeptIdStrByUser(user);
			if("".equals(deptIdStr)){ //?????????????????????????????????
				sbf.append(" and F_INCOME_USER_ID='"+user.getId()+"'");
			}else if("all".equals(deptIdStr)){//??????????????????????????????
				
			}else{//?????????????????????????????????????????? ?????????????????????????????????????????????
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
	 * ??????????????????
	 * @author ?????????
	 * @createtime 2018-08-08
	 * @updatetime 2018-08-08
	 */

	@Override
	public void save(IncomeInfo bean, User user,String mingxiJson,String files)throws Exception  {
		Date date = new Date();
		if (bean.getFincomeId() == null) {//??????
			//???????????????????????????????????????  ??????????????????
			bean.setCreator(user.getName());
			bean.setCreateTime(date);
			//????????????   ????????????  ????????????  ????????????
			bean.setfReqTime(date);
			bean.setfReqUserid(user.getId());
			bean.setfReqUser(user.getName());
			bean.setFregisterPerson(user.getName());
			bean.setFregisterPersonId(user.getId());
			bean.setFregisterDepartId(user.getDepart().getId());
			bean.setFregisterDepart(user.getDepart().getName());
			
		} else {//??????
			//????????????????????????
			bean.setfReqUserid(user.getId());
			bean.setfReqUser(user.getName());
			bean.setUpdator(user.getName());
			bean.setFregisterPerson(user.getName());
			bean.setFregisterPersonId(user.getId());
			bean.setFregisterDepartId(user.getDepart().getId());
			bean.setFregisterDepart(user.getDepart().getName());
			bean.setUpdateTime(date);
		}
		//???????????????   ???????????????????????????0  ?????????99
		bean.setFstauts("0");
		bean.setfConfirmStatus("0");
		
		bean.setFconfirmAmount(BigDecimal.ZERO);
		bean.setfRegisteredAmount(BigDecimal.ZERO);;
		//??????????????????
		
		bean = (IncomeInfo) super.saveOrUpdate(bean);
		//?????????????????????????????????1???2????????????????????????????????????????????????
//		if(bean.getfFlowStauts().equals("1") || bean.getfFlowStauts().equals("2")){
//			Integer flowId =0;
//			User nextUser = new User();
//
//			//???????????????????????????key
//			Integer firstKey=tProcessCheckMng.addProcessCheck(user.getDpID(),bean.getJoinTable(),bean.getBeanCodeField(),bean.getBeanCode(), "PXSRLKDJ", user);
//			//?????????????????????????????????????????????????????????????????????
//			TProcessDefin processDefin=tProcessDefinMng.getByBusiAndDpcode("PXSRLKDJ", user.getDpID());
//			flowId= processDefin.getFPId();
//			TNodeData node=tNodeDataMng.getByFlowIdAndKey(flowId,firstKey);
//			nextUser=userMng.findById(node.getUserId());
//			//???????????????????????????????????????		
//			bean.setfUserName(nextUser.getName());
//			bean.setfUserCode(nextUser.getId());
//			//???????????????????????????
//			bean.setfNCode(firstKey+"");	
//			//????????????????????????????????????1?????????????????????
//			tProcessCheckMng.updateStauts(flowId,bean.getBeanCode());
//			//??????????????????
//			bean = (IncomeInfo) super.saveOrUpdate(bean);	
//			//???????????????????????????????????????
//			PersonalWork work = new PersonalWork();
//			work.setUserId(nextUser.getId());//???????????????ID????????????????????????ID
//			work.setTaskId(bean.getBeanId());//?????????ID
//			work.setTaskCode(bean.getBeanCode());//?????????????????????
//			String taskName = "[???????????????????????????]" + bean.getFproName();;
//			work.setTaskName(taskName);//????????????????????????????????????+?????????????????????????????????????????????
//			work.setUrl("/srregister/check?id="+bean.getBeanId());//??????url
//			work.setUrl1("/srregister/detail?id="+ bean.getBeanId());//??????url
//			work.setTaskStauts("0");//??????
//			work.setType("1");//???????????????1?????????
//			work.setTaskType("1");//???????????????1????????????
//			work.setBeforeUser(user.getName());//?????????????????????
//			/**----------------------------------------------------------------**/
//			work.setBeforeDepart(user.getDepartName());//?????????????????????????????????
//			/**----------------------------------------------------------------**/
//			work.setBeforeTime(date);//??????????????????
//			personalWorkMng.merge(work);
//
//			//??????????????????????????????????????????
//			PersonalWork work2 = new PersonalWork();
//			work2.setUserId(user.getId());//???????????????ID??????????????????ID
//			work2.setTaskId(bean.getBeanId());//?????????ID
//			work2.setTaskCode(bean.getBeanCode());//?????????????????????
//			work2.setTaskName(taskName);//????????????????????????????????????+?????????????????????????????????????????????
//			work2.setUrl("/srregister/edit?id="+ bean.getBeanId());//????????????url
//			work2.setUrl1("/srregister/detail?id="+ bean.getBeanId());//??????url
//			work2.setUrl2("/srregister/delete?id="+ bean.getBeanId());//??????url
//			work2.setTaskStauts("2");//??????
//			work2.setType("2");//???????????????2?????????
//			work2.setTaskType("0");//???????????????0????????????
//			work2.setBeforeUser(user.getName());//?????????????????????
//			/**----------------------------------------------------------------**/
//			work2.setBeforeDepart(user.getDepartName());//?????????????????????????????????
//			/**----------------------------------------------------------------**/
//			work2.setBeforeTime(date);//??????????????????
//			work2.setFinishTime(date);
//			personalWorkMng.merge(work2);
//
//		} else {
//			//??????????????????
//			bean = (IncomeInfo) super.saveOrUpdate(bean);
//		}

		/** ???????????? **/
		//??????????????????
		attachmentMng.joinEntity(bean,files);
		
		/** ???????????? **/
		List<ReceiveMoneyDetail> rp = JSON.parseObject("["+mingxiJson.toString()+"]",new TypeReference<List<ReceiveMoneyDetail>>(){});
		//??????????????????
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
		//???????????????????????????????????????
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
		//??????????????????
		bean = (IncomeInfo) super.saveOrUpdate(bean);
	}

	/*
	 * ??????id??????
	 * @author ?????????
	 * @createtime 2018-08-80
	 * @updatetime 2018-08-08
	 */
	@Override
	public void delete(Integer id) {
		IncomeInfo bean = super.findById(id);
		bean.setFstauts("99");
		super.saveOrUpdate(bean);
	}

	/** ?????????-??????????????????  start **/
	
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
			if ("personOut".equals(basicType)) {//??????????????????
				sql = sql + " and (F_EC_CODE like '301%' or F_EC_CODE like '303%')  ";
			} else if ("commOut".equals(basicType)) {//??????????????????
				sql = sql + " and F_EC_CODE like '302%' ";
			}
		}
		if (!StringUtil.isEmpty(year)) {//??????
			sql = sql + " and T_ACCO_YEAR.F_PERIOD=" + year;
		}
		if (!StringUtil.isEmpty(parentCode)) {//?????????
			sql = sql + " and F_P_EC_ID=" + parentCode;
		}
		if (!StringUtil.isEmpty(qName)) {//??????-????????????
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
			if ("personOut".equals(basicType)) {//??????????????????
				sql = sql + " and (F_EC_CODE like '301%' or F_EC_CODE like '303%')  ";
			} else if ("commOut".equals(basicType)) {//??????????????????
				sql = sql + " and F_EC_CODE like '302%' ";
			}
		}
		if (!StringUtil.isEmpty(year)) {//??????
			sql = sql + " and T_ACCO_YEAR.F_PERIOD=" + year;
		}
		if (!StringUtil.isEmpty(parentCodes)) {//?????????
			sql = sql + " and F_P_EC_ID in (" + parentCodes+")";
		}
		if (!StringUtil.isEmpty(qName)) {//??????-????????????
			sql = sql + " and F_EC_NAME like '%" + qName + "%'";
		}
		
		sql = sql + " order by F_EC_CODE asc ";
		
		SQLQuery query = getSession().createSQLQuery(sql);
		return query.list();
	}

	/** ?????????-??????????????????  end **/
	
	
	public List<ReceiveMoneyDetail> getMingxiList(String fincomeId,String fpId){
		//????????????
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
		//????????????
		Finder finder = null;
		finder = Finder.create(" FROM ReceiveMoneyDetail WHERE fMSId in("+fincomeId+")");
		finder.append(" AND fType='1' ");
		List<ReceiveMoneyDetail> list =  super.find(finder);
		return list;
	}
	
	public void reCall(Integer id) throws Exception{
		//??????id????????????
		IncomeInfo bean=(IncomeInfo)super.findById(id);
		//????????????
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//???????????????????????????
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="?????????????????????";
		String msg="???????????????  "+bean.getFproName() +",???????????????("+bean.getBeanCode()+")???"+sdf.format(new Date())+"??????????????????,???????????????.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//??????
		bean=(IncomeInfo) reCall((CheckEntity) bean);
		this.updateDefault(bean);
	}
	
	@Override
	public void saveCheck(TProcessCheck checkBean, IncomeInfo bean,
			String files, User user) throws Exception {
		IncomeInfo busiBean = this.findById(bean.getFincomeId());
		CheckEntity entity = (CheckEntity)busiBean;
		//?????????????????????????????????????????????
		String checkUrl = "/srregister/check?id=";
		String lookUrl = "/srregister/detail?id=";
		//??????????????????
		busiBean = (IncomeInfo)tProcessCheckMng.checkProcess(checkBean, entity, user, "PXSRLKDJ", checkUrl, lookUrl, files);
		
		super.saveOrUpdate(busiBean);
	}
	
	public void saveConfirm(IncomeInfo bean, String mingxiJson, String files) throws Exception{
		IncomeInfo busiBean = this.findById(bean.getFincomeId());
		busiBean.setfConfirmStatus(bean.getfConfirmStatus());
		/** ???????????? **/
		List<ReceiveMoneyDetail> rp = JSON.parseObject("["+mingxiJson.toString()+"]",new TypeReference<List<ReceiveMoneyDetail>>(){});
		//??????????????????
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
		//???????????????????????????????????????
		if(oldrp.size()>0){
			for (int i = 0; i < oldrp.size(); i++) {
				ReceiveMoneyDetail oldrpi = (ReceiveMoneyDetail) oldrp.get(i);
				super.delete(oldrpi);
			}
		}
		BigDecimal fconfirmAmount = BigDecimal.ZERO;//????????????
		BigDecimal fRegisteredAmount = BigDecimal.ZERO;//???????????????????????????-?????????????????????
		
		for (int i = 0; i < rp.size(); i++) {		
			ReceiveMoneyDetail rpi = (ReceiveMoneyDetail) rp.get(i);
			rpi.setfMSId(bean.getFincomeId());
			if(!StringUtil.isEmpty(rpi.getPayStatus())&&"1".equals(rpi.getPayStatus())){//?????????
				fconfirmAmount=fconfirmAmount.add(rpi.getPlanMoney());
			}
			if(!StringUtil.isEmpty(rpi.getPayStatus())&&"0".equals(rpi.getPayStatus())){// 0-????????????
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
				//????????????
						StringBuilder sbf = new StringBuilder("SELECT * FROM T_INCOME_INFO WHERE F_STAUTS<>99 and F_FLOW_STAUTS = '9'");
						//????????????????????????????????????
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