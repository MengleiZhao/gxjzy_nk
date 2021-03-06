package com.braker.icontrol.budget.adjust.manager.impl;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.entity.CheckEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.page.Pagination;
import com.braker.common.util.JpushClientUtil;
import com.braker.common.util.MatheUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.PersonalWork;
import com.braker.core.model.User;
import com.braker.exception.ServiceException;
import com.braker.icontrol.budget.adjust.entity.TIndexAdItf;
import com.braker.icontrol.budget.adjust.entity.TIndexInnerAd;
import com.braker.icontrol.budget.adjust.manager.InsideAdjustMny;
import com.braker.icontrol.budget.adjust.manager.TIndexAdItfMng;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessCheck;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
import com.braker.zzww.comm.manager.AttachmentMng;

/**
 * ?????????????????????service?????????
 * @author ?????????
 * @createtime 2018-08-10
 * @updatetime 2018-08-10
 */
@Service
@Transactional
public class InsideAdjustMnyImpl extends BaseManagerImpl<TIndexInnerAd> implements InsideAdjustMny{
	@Autowired
	private TIndexAdItfMng tIndexAdItfMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private TNodeDataMng tNodeDataMng;
	
	@Autowired
	private UserMng userMng;
	
	@Autowired
	private AttachmentMng attachmentMng;

	@Autowired
	private DepartMng departMng;
	
	@Autowired
	private PersonalWorkMng personalWorkMng;
	
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	
	@Autowired
	private TProExpendDetailMng tProExpendDetailMng;
	
	@Autowired
	private PrivateInforMng privateInforMng;
	/*
	 * ????????????
	 * @author ?????????
	 * @createtime 2018-07-10
	 * @updatetime 2018-07-10
	 */
	@Override
	public Pagination pageList(TIndexInnerAd bean, int pageNo, int pageSize, User user, String type) {
		try {
			StringBuilder builder=new StringBuilder();
			builder.append("select * FROM  T_INDEX_INNER_AD tii where  F_STAUTS in('0','1') ");
			if(!StringUtil.isEmpty(bean.getIndexNameIn())){ //???????????????????????????
				builder.append(" AND  EXISTS (select tia.F_IN_ID FROM   T_INDEX_AD_ITF tia  where  tii.F_IN_ID= tia.F_IN_ID  and tia.F_B_INDEX_NAME like '%"+bean.getIndexNameIn()+"%' and F_AD_TYPE='IN') ");
			}
			if(!StringUtil.isEmpty(bean.getIndexNameOut())){ //???????????????????????????
				builder.append(" and EXISTS (select tia.F_IN_ID from   T_INDEX_AD_ITF tia where  tii.F_IN_ID=tia.F_IN_ID  and tia.F_B_INDEX_NAME like  '%"+bean.getIndexNameOut()+"%' and F_AD_TYPE='OUT') ");
			}
			if(!StringUtil.isEmpty(bean.getFlowStauts()) ){//????????????
				if("2".equals(bean.getFlowStauts())){	
					builder.append(" AND F_USER_ID = '" + user.getId() + "'");
				}
			}else{
				//??????????????????
				String deptIdStr=departMng.getDeptIdStrByUser(user);
				if(user.getRoleName().contains("?????????????????????")){
					//?????????????????????????????????????????????????????????????????????
				}else {
					if("".equals(deptIdStr)){ //?????????????????????????????????
						builder.append(" and tii.F_APP_USER ="+ user.getId()+"");
					}else if("all".equals(deptIdStr)){//??????????????????????????????
						
					}else{//?????????????????????????????????????????? ?????????????????????????????????????????????
						builder.append(" and tii.F_DEPT_CODE in ("+deptIdStr+")");
					}
				}
			}
			
			if(type != null) {
				builder.append(" AND F_FLOW_STAUTS='9'");
			}
			builder.append(" order by F_IN_ID desc");
			
			return super.findBySql( bean,builder.toString(), pageNo, pageSize);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/*
	 * ????????????????????????
	 * @author ?????????
	 * @createtime 2018-07-23
	 * @updatetime 2018-07-23
	 */
	@Override
	public String save(TIndexInnerAd bean, User user, List<TIndexAdItf> dcList, List<TIndexAdItf> drList,String files) throws Exception {
		//?????????????????????????????????????????????????????????,?????????????????????????????????????????????????????????false
		boolean checkResult=duplicationCheck(dcList,drList);
		if(!checkResult){
			return "?????????????????????????????????";
		}
		//??????????????????
		Date d = new Date();
		bean.setOpTime(d);
		bean.setDeptCode(user.getDepart().getId());
		bean.setAppUser(user.getId());
		//??????????????????????????????????????????????????????????????????1?????????2???????????????
		if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
			Integer firstKey = null;
			Integer flowId = null;
			User nextUser = null;
			String strType ="";
			if("WBYSZBTZ".equals(bean.getChangeType())){
				strType ="WBZBDZ";
			}else{
				strType ="NBZBDZ";
			}
			//???????????????????????????key
			firstKey = tProcessCheckMng.addProcessCheck(user.getDpID(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getBeanCode(), strType, user);
			//?????????????????????????????????????????????????????????????????????
			TProcessDefin processDefin = tProcessDefinMng.getByBusiAndDpcode(strType, user.getDpID());
			flowId = processDefin.getFPId();
			TNodeData node = tNodeDataMng.getByFlowIdAndKey(flowId, firstKey);
			nextUser = userMng.findById(node.getUserId());
			
			//???????????????????????????????????????		get(0)??????????????????????????????????????????????????????????????????li????????????????????????
			bean.setFuserName(nextUser.getName());
			bean.setFuserId(nextUser.getId());
			//???????????????????????????
			bean.setnCode(String.valueOf(firstKey));
			
			//????????????????????????????????????1?????????????????????
			tProcessCheckMng.updateStauts(flowId, bean.getBeanCode());
			
			//????????????????????????????????????
			bean = (TIndexInnerAd) super.saveOrUpdate(bean);
			
			//????????????????????????????????????????????????
			if("1".equals(bean.getFlowStauts())){
				bean.setFuserName(nextUser.getName());
				bean.setFuserId(nextUser.getId());
				//???????????????????????????
				bean.setnCode(firstKey+"");
				
				//????????????
				//????????????????????????
				List nameList = new ArrayList<>();
				for(int i=0; i<dcList.size(); i++){
					nameList.add(dcList.get(i).getActivity());
				}
				//????????????????????????
				String name2 = StringUtil.nameJoint(nameList, "???", 3);
				
				//????????????
				//????????????????????????
				List nameList1 = new ArrayList<>();
				for(int i=0; i<drList.size(); i++){
					nameList1.add(drList.get(i).getActivity());
				}
				//????????????????????????
				String name1 = StringUtil.nameJoint(nameList1, "???", 3);
				
				String name =name1+"|"+name2;
				
				//???????????????????????????????????????
				PersonalWork work = new PersonalWork();
				work.setUserId(nextUser.getId());//???????????????ID????????????????????????ID
				work.setTaskId(bean.getInId());//?????????ID
				work.setTaskCode(bean.getInCode());//?????????????????????
				work.setTaskName("[????????????]"+name);//????????????????????????????????????+?????????????????????????????????????????????
				work.setUrl("/insideCheck/check?id="+bean.getInId());//??????????????????????????????url,???????????????????????????????????????
				work.setUrl1("/insideAdjust/detail?id="+ bean.getInId());//??????url
				work.setTaskStauts("0");//??????
				work.setType("1");//???????????????1-??????
				work.setTaskType("1");//???????????????1????????????
				work.setBeforeUser(user.getName());//?????????????????????
				work.setBeforeDepart(user.getDepartName());//?????????????????????????????????
				work.setBeforeTime(new Date());//??????????????????
				personalWorkMng.merge(work);
				//?????????????????????????????????
				PersonalWork minwork = new PersonalWork();
				minwork.setUserId(user.getId());//???????????????ID????????????????????????ID
				minwork.setTaskId(bean.getInId());//?????????ID
				minwork.setTaskCode(bean.getInCode());//?????????????????????
				minwork.setTaskName("[????????????]"+name);//????????????????????????????????????+?????????????????????????????????????????????
				minwork.setUrl("/insideAdjust/edit?id="+bean.getInId());//????????????url
				minwork.setUrl1("/insideAdjust/detail?id="+ bean.getInId());//??????url
				minwork.setUrl2("/insideAdjust/delete?id="+ bean.getInId());//????????????url
				minwork.setTaskStauts("2");//??????
				minwork.setType("2");//???????????????2-??????
				minwork.setTaskType("0");//???????????????0????????????
				minwork.setBeforeUser(user.getName());//?????????????????????
				minwork.setBeforeDepart(user.getDepartName());//?????????????????????????????????
				minwork.setBeforeTime(new Date());//??????????????????
				minwork.setFinishTime(new Date());
				personalWorkMng.merge(minwork);
				//???????????????app
				if(JpushClientUtil.sendToRegistrationId(nextUser.getAccountNo(),null,"???????????????????????????",work.getTaskName(),bean.getInId().toString(), "0","zbtz")==1){
		            System.out.println("???????????????Android??????success");
		        }
			}
		} else {
			//????????????????????????????????????
			bean = (TIndexInnerAd) super.saveOrUpdate(bean);
		}
			
		//?????????????????????
		tIndexAdItfMng.deleteByInId(bean.getInId());
		
		//??????????????????
		for (int i = 0; i < dcList.size(); i++) {
			TIndexAdItf itf = dcList.get(i);
			//?????????????????????????????????ID
			itf.setInId(bean.getInId());
			//????????????????????????
			itf.setEffecTime(d);
			//????????????IN-?????????OUT-??????
			itf.setAdType("OUT");
			BigDecimal changeAmountCount = itf.getChangeAmount().multiply(BigDecimal.valueOf(-1));
			itf.setChangeAmountCount(changeAmountCount);
			//?????????????????????????????????  ???????????????????????????????????????????????????????????????
			if(bean.getFlowStauts().equals("1") || bean.getFlowStauts().equals("2")){
				//?????????????????????????????????
				frozenAmount(itf);
				
			}
			//????????????????????????
			tIndexAdItfMng.save(itf);
		}
		for (int i = 0; i < drList.size(); i++) {
			
			TIndexAdItf itf = drList.get(i);
			//?????????????????????????????????ID
			itf.setInId(bean.getInId());
			//????????????????????????
			itf.setEffecTime(d);
			//????????????IN-?????????OUT-??????
			itf.setAdType("IN");
			itf.setChangeAmountCount(itf.getChangeAmount());
			//????????????????????????
			tIndexAdItfMng.save(itf);
			
		}
		//??????????????????
		attachmentMng.joinEntity(bean,files);
		//??????????????????????????????
		return "????????????";
	}
	
	/**
	 * 
	* @author:??????
	* @Title: duplicationCheck 
	* @Description: ?????????????????????????????????????????????????????????
	* @param dcli
	* @param drli
	* @return
	* @return boolean    ???????????? 
	* @date??? 2019???6???26?????????10:28:57 
	* @throws
	 */
	private boolean duplicationCheck(List<TIndexAdItf> dcList, List<TIndexAdItf> drList){
		
		HashMap<Integer,Integer>  map=List2Map(dcList);
		for(TIndexAdItf index:drList){
			//?????????????????????????????????????????????????????????false
			if(map.get(index.getBid())!=null){
				return false;
			}
		}
		return true;
	}
	
	/**
	 * 
	* @author:??????
	* @Title: List2Map 
	* @Description: ????????????????????????map
	* @param list
	* @return
	* @return HashMap<Integer,Integer>    ???????????? 
	* @date??? 2019???6???26?????????10:35:04 
	* @throws
	 */
	private HashMap<Integer,Integer> List2Map(List<TIndexAdItf> list){
		HashMap<Integer,Integer> map=new HashMap<Integer,Integer>();
		for(TIndexAdItf index:list){
			map.put(index.getBid(), index.getBid());
		}
		return map;
	}
	/*
	 * ?????????????????????????????????????????????
	 * @author ?????????
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 */
	@Override
	public TProBasicInfo findByIndexCode(String indexCode) {
		String sql = "SELECT * FROM t_pro_basic_info WHERE F_PRO_ID="
				+ "(SELECT F_PRO_ID FROM t_budgetary_indic_pro WHERE F_B_ID="
				+ "(SELECT F_B_ID from t_budgetary_indic_pro_itf WHERE F_B_I_ID='"+indexCode+"'))";
		Query q = getSession().createSQLQuery(sql).addEntity(TProBasicInfo.class);
		List<TProBasicInfo> li = q.list();
		return li.get(0);
	}
	/*
	 * ????????????????????????
	 * @author ??????
	 * @createtime 2019-03-13
	 * @updatetime 2019-03-13
	 */
	@Override
	public void delete(Integer id) {
		TIndexInnerAd bean = super.findById(id);
		List<TIndexAdItf> indexAditfList=tIndexAdItfMng.findByInId(id+"", null);
		for(TIndexAdItf ndexAditf:indexAditfList){
			if("IN".equals(ndexAditf.getAdType())){
				getSession().createSQLQuery("delete from T_PRO_EXPEND_DETAIL where F_EXP_ID ="+ndexAditf.getPid()+"").executeUpdate();
			}
		}
		bean.setStauts("99");
		super.saveOrUpdate(bean);
	}
	/**
	 * ??????
	 */
	@Override
	public void saveCheckInfo(TProcessCheck checkBean, TIndexInnerAd insideBean, User user, String files)  throws Exception{
		insideBean = this.findById(insideBean.getInId());
		checkBean.setCheckDeptId(insideBean.getInsideDeptId());
		CheckEntity entity = (CheckEntity)insideBean;
		String lookUrl = "/insideAdjust/detail?id=";
		String checkUrl = "/insideCheck/check?id=";
		String strType ="";
		if("WBYSZBTZ".equals(insideBean.getChangeType())){
			strType ="WBZBDZ";
		}else{
			strType ="NBZBDZ";
		}
		//???????????????id???????????????????????????????????????????????????????????????
		insideBean = (TIndexInnerAd)tProcessCheckMng.checkProcess(checkBean, entity, user, strType, checkUrl, lookUrl, files);
		super.saveOrUpdate(insideBean);
		if("-1".equals(insideBean.getFlowStauts())) {		//????????????????????????????????????
			getBackAmount(insideBean.getInId());
		}else if("9".equals(insideBean.getFlowStauts())) {		//??????????????????,???????????????????????????????????????????????????????????????
			addAmount(insideBean.getInId());
		}
	}
	/**
	 * 
	* @author:??????
	* @Title: frozenAmount 
	* @Description: ??????????????????????????????????????????
	* @param itf
	* @return void    ???????????? 
	* @date??? 2019???6???19?????????7:10:18 
	* @throws
	 */
	private void frozenAmount(TIndexAdItf itf){
		TBudgetIndexMgr bim = budgetIndexMgrMng.findById(itf.getBid());
		//????????????????????????
		bim.setSyAmount(bim.getSyAmount().subtract(itf.getChangeAmount()));
		//????????????????????????
		bim.setDjAmount(bim.getDjAmount().add(itf.getChangeAmount()));
		super.merge(bim);
		
		if(itf.getPid() !=null && itf.getPid()>0){
			TProExpendDetail expendDetail = tProExpendDetailMng.findById(itf.getPid());
			//????????????????????????
			expendDetail.setSyAmount(expendDetail.getSyAmount().subtract(itf.getChangeAmount()));
			//????????????????????????
			expendDetail.setDjAmount(expendDetail.getDjAmount().add(itf.getChangeAmount()));
			super.merge(expendDetail);
		}
	}
	/**
	 * 
	* @author:??????
	* @Title: getBackAmount 
	* @Description: ?????????????????????????????? 
	* @return void    ???????????? 
	* @date??? 2019???6???18?????????9:09:39 
	* @throws
	 */
	private void  getBackAmount(Integer inId){
		List<TIndexAdItf> indexAditfList=tIndexAdItfMng.findByInId(inId+"", null);
		for(TIndexAdItf ndexAditf:indexAditfList){
			//???????????????????????????????????????????????????????????????
			if("OUT".equals(ndexAditf.getAdType())){
				TBudgetIndexMgr bim = budgetIndexMgrMng.findById(ndexAditf.getBid());
				//????????????????????????
				bim.setSyAmount(bim.getSyAmount().add(ndexAditf.getChangeAmount()));
				//????????????????????????
				bim.setDjAmount(bim.getDjAmount().add(ndexAditf.getChangeAmount()));
				super.merge(bim);
				
				if(ndexAditf.getPid() !=null && ndexAditf.getPid()>0){
					TProExpendDetail expendDetail = tProExpendDetailMng.findById(ndexAditf.getPid());
					//????????????????????????
					expendDetail.setSyAmount(expendDetail.getSyAmount().add(ndexAditf.getChangeAmount()));
					//????????????????????????
					expendDetail.setDjAmount(expendDetail.getDjAmount().subtract(ndexAditf.getChangeAmount()));
					super.merge(expendDetail);
				}
				
			}
		}
	}
	
	/**
	 * 
	* @author:??????
	* @Title: addAmount 
	* @Description: ??????????????????,???????????????????????????????????????????????????????????????
	* @return void    ???????????? 
	* @date??? 2019???6???18?????????9:09:39 
	* @throws
	 */
	private void  addAmount(Integer inId){
		List<TIndexAdItf> indexAditfList=tIndexAdItfMng.findByInId(inId+"", null);
		for(TIndexAdItf ndexAditf:indexAditfList){
			if("OUT".equals(ndexAditf.getAdType())){
				TBudgetIndexMgr bim = budgetIndexMgrMng.findById(ndexAditf.getBid());
				//?????????????????????
				//bim.setPfzAmount(MatheUtil.sub(bim.getPfzAmount(), Double.valueOf(ndexAditf.getChangeAmount())));
				bim.setXdAmount(bim.getXdAmount().subtract(ndexAditf.getChangeAmount()));
				bim.setPfAmount(bim.getPfAmount().subtract(ndexAditf.getChangeAmount()));
				//????????????????????????
				bim.setDjAmount(bim.getDjAmount().subtract(ndexAditf.getChangeAmount()));
				super.merge(bim);
				if(ndexAditf.getPid() !=null && ndexAditf.getPid()>0){
					//????????????????????????
					TProExpendDetail expendDetail = tProExpendDetailMng.findById(ndexAditf.getPid());
					expendDetail.setDjAmount(expendDetail.getDjAmount().subtract(ndexAditf.getChangeAmount()));
					
					expendDetail.setXdAmount(expendDetail.getXdAmount().subtract(ndexAditf.getChangeAmount()));
					super.merge(expendDetail);
				}
				
			} else if("IN".equals(ndexAditf.getAdType())){
				//????????????????????????
				TBudgetIndexMgr bim = budgetIndexMgrMng.findById(ndexAditf.getBid());
				bim.setSyAmount(bim.getSyAmount().add(ndexAditf.getChangeAmount()));
				//?????????????????????
				//bim.setPfzAmount(MatheUtil.add(bim.getPfzAmount(), Double.valueOf(ndexAditf.getChangeAmount())));
				bim.setXdAmount(bim.getXdAmount().add(ndexAditf.getChangeAmount()));
				bim.setPfAmount(bim.getPfAmount().add(ndexAditf.getChangeAmount()));
				if(ndexAditf.getPid() !=null && ndexAditf.getPid()>0){
					//????????????expendDetail
					TProExpendDetail expendDetail = tProExpendDetailMng.findById(ndexAditf.getPid());
					expendDetail.setSyAmount(expendDetail.getSyAmount().add(ndexAditf.getChangeAmount()));
					expendDetail.setXdAmount(expendDetail.getXdAmount().add(ndexAditf.getChangeAmount()));
					if("1".equals(expendDetail.getCreateStatus())) {
						expendDetail.setCreateStatus(null);
						bim.setSyAmount(bim.getSyAmount().add(expendDetail.getXdAmount()));
						bim.setXdAmount(bim.getXdAmount().add(expendDetail.getXdAmount()));
						bim.setPfAmount(bim.getPfAmount().add(expendDetail.getXdAmount()));
					}
					super.merge(expendDetail);
				}
				super.merge(bim);
				
				
			}
			
		}
	}
	
	@Override
	public List<Object[]> adjustEconomicList() {
		String sql=" SELECT a.F_B_ID, b.F_SUB_NUM,b.F_SUB_NAME,sum(F_INDEX_AMOUNT_COUNT) "
				+ "FROM T_INDEX_AD_ITF a LEFT JOIN T_PRO_EXPEND_DETAIL b ON a.F_EXP_ID = b.F_EXP_ID "
				+ "LEFT JOIN T_INDEX_INNER_AD c ON a.F_IN_ID = c.F_IN_ID where c.F_FLOW_STAUTS ='9' and year(c.F_OP_TIME)  = year(NOW())"
				+ " GROUP BY b.F_SUB_NUM ";
		
		Query query = getSession().createSQLQuery(sql);
		List<Object[]> list = query.list();
		return list;
	}
	
	@Override
	public List<Object[]> departList() {
		String sql="SELECT d.F_DEPT_CODE,d.F_DEPT_NAME, b.F_SUB_NUM,b.F_SUB_NAME,sum(d.F_FIRST_AMOUNT),sum(F_INDEX_AMOUNT_COUNT),sum(d.F_PF_AMOUNT)"
				+ " FROM T_INDEX_AD_ITF a LEFT JOIN T_PRO_EXPEND_DETAIL b ON a.F_EXP_ID = b.F_EXP_ID"
				+ " LEFT JOIN T_INDEX_INNER_AD c ON a.F_IN_ID = c.F_IN_ID  "
				+ "left join T_BUDGET_INDEX_MGR d on a.F_B_ID=d.F_B_ID  "
				+ "where c.F_FLOW_STAUTS ='9' and year(F_OP_TIME)  = year(NOW())"
				+ " GROUP BY d.F_DEPT_CODE ";
		
		Query query = getSession().createSQLQuery(sql);
		List<Object[]> list = query.list();
		return list;
	}
	
	@Override
	public List<Object[]> prolist(String deptCode) {
		String sql="SELECT d.F_B_ID,d.F_B_INDEX_NAME, b.F_SUB_NUM,b.F_SUB_NAME,d.F_FIRST_AMOUNT,sum(F_INDEX_AMOUNT_COUNT),d.F_PF_AMOUNT"
				+ " FROM T_INDEX_AD_ITF a LEFT JOIN T_PRO_EXPEND_DETAIL b ON a.F_EXP_ID = b.F_EXP_ID "
				+ "LEFT JOIN T_INDEX_INNER_AD c ON a.F_IN_ID = c.F_IN_ID "
				+ " left join T_BUDGET_INDEX_MGR d on a.F_B_ID=d.F_B_ID  "
				+ "where c.F_FLOW_STAUTS ='9' and year(F_OP_TIME)  = year(NOW())"
				+ " and  d.F_DEPT_CODE ='"+deptCode+"' group by d.F_B_ID ORDER  BY d.F_INDEX_TYPE  ";
		
		Query query = getSession().createSQLQuery(sql);
		List<Object[]> list = query.list();
		return list;
	}
	
	public List<Object[]> departAndEconomicList(String deptCode,String subCode) {
		String sql="select sum(col1), sum(col2), sum(col3) from ( SELECT d.F_FIRST_AMOUNT as col1 ,sum(F_INDEX_AMOUNT_COUNT) as col2,d.F_PF_AMOUNT as col3"
				+ " FROM T_INDEX_AD_ITF a LEFT JOIN T_PRO_EXPEND_DETAIL b ON a.F_EXP_ID = b.F_EXP_ID "
				+ "LEFT JOIN T_INDEX_INNER_AD c ON a.F_IN_ID = c.F_IN_ID "
				+ " left join T_BUDGET_INDEX_MGR d on a.F_B_ID=d.F_B_ID  "
				+ "where c.F_FLOW_STAUTS ='9' and year(F_OP_TIME)  = year(NOW())"
				+ " and  d.F_DEPT_CODE ='"+deptCode+"' "
				+ " and b.F_SUB_NUM ='"+subCode+"' "
				+ "  GROUP BY a.F_B_ID ) as t1";
		Query query = getSession().createSQLQuery(sql);
		List<Object[]> list = query.list();
		return list;
	}
	
	public List<Object[]> indexAndEconomicList(String indexId,String subCode) {
		String sql="select sum(col1), sum(col2), sum(col3) from ( SELECT d.F_FIRST_AMOUNT as col1 ,sum(F_INDEX_AMOUNT_COUNT) as col2,d.F_PF_AMOUNT as col3"
				+ " FROM T_INDEX_AD_ITF a LEFT JOIN T_PRO_EXPEND_DETAIL b ON a.F_EXP_ID = b.F_EXP_ID "
				+ "LEFT JOIN T_INDEX_INNER_AD c ON a.F_IN_ID = c.F_IN_ID "
				+ " left join T_BUDGET_INDEX_MGR d on a.F_B_ID=d.F_B_ID  "
				+ "where c.F_FLOW_STAUTS ='9' and year(F_OP_TIME)  = year(NOW())"
				+ " and  d.F_B_ID ='"+indexId+"' "
				+ " and b.F_SUB_NUM ='"+subCode+"' "
				+ "  GROUP BY a.F_B_ID ) as t1";
		Query query = getSession().createSQLQuery(sql);
		List<Object[]> list = query.list();
		return list;
	}
	
	@Override
	public List<Object[]> getDataList(List<Object[]> adjustEconomicList,
			List<Object[]> departAndProlist){
		List<Object[]> list=new ArrayList<Object[]>();
		for (int i = 0; i < departAndProlist.size(); i++) {
			Object [] obj=new Object[adjustEconomicList.size()*3+5];
			
			obj[0]=departAndProlist.get(i)[1];
			for (int j = 0; j < adjustEconomicList.size(); j++) {
				String subCode=(String) adjustEconomicList.get(j)[1];
				if(departAndProlist.get(i)[7].equals("depart")){
					List<Object[]> departAndEconomicList =departAndEconomicList((String) departAndProlist.get(i)[0],subCode);
					obj[1+j*3]=departAndEconomicList.get(0)[0];
					obj[2+j*3]=departAndEconomicList.get(0)[1];
					obj[3+j*3]=departAndEconomicList.get(0)[2];
					obj[4+adjustEconomicList.size()*3]="depart";
				}
				if(departAndProlist.get(i)[7].equals("index")){
					List<Object[]> indexAndEconomicList =indexAndEconomicList( departAndProlist.get(i)[0].toString(),subCode);
					obj[1+j*3]=indexAndEconomicList.get(0)[0];
					obj[2+j*3]=indexAndEconomicList.get(0)[1];
					obj[3+j*3]=indexAndEconomicList.get(0)[2];
					obj[4+adjustEconomicList.size()*3]="index";
				}
			}
			obj[1+adjustEconomicList.size()*3]=departAndProlist.get(i)[4];
			obj[2+adjustEconomicList.size()*3]=departAndProlist.get(i)[5];
			obj[3+adjustEconomicList.size()*3]=departAndProlist.get(i)[6];
			list.add(obj);
		}
		Object [] totalobj=new Object[adjustEconomicList.size()*3+5];
		totalobj[0]="??????";
		if(list.size()>0){
			for (int i = 0; i < totalobj.length-1; i++) {
				Double num = 0.00;
				for (int y = 0; y < list.size(); y++) {
					Object [] obj =list.get(y);
					if(obj[4+adjustEconomicList.size()*3].equals("depart")){
						if(i!=0){
							if(obj[i]!=null){
								num=num+(Double) obj[i];
							}
						}
					}
					
				}
				if(i!=0){
					totalobj[i]=num;
				}
			}
		}
		list.add(totalobj);
		return list;
	}

	@Override
	public String reCall(Integer id) {
		TIndexInnerAd bean=(TIndexInnerAd)super.findById(id);
		if(bean.getCheckStauts().equals("-4")){
			throw new ServiceException("?????????????????????????????????????????????");
		}
		//????????????
		personalWorkMng.deleteDb(bean.getNextCheckUserId() , bean.getBeanCode(), "0");
		//???????????????????????????
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String title="???????????????????????????";
		String msg="?????????????????????????????????,???????????????("+bean.getBeanCode()+")???"+sdf.format(new Date())+"??????????????????,???????????????.";
		privateInforMng.setMsg(title, msg, bean.getNextCheckUserId(), "3");
		//??????
		bean=(TIndexInnerAd) reCall((CheckEntity) bean);
		this.updateDefault(bean);
		return "????????????";
	}

}
