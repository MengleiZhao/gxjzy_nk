package com.braker.icontrol.contract.ledger.manager.Impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.DepartMng;
import com.braker.core.model.User;
import com.braker.icontrol.budget.data.entity.BudgetData1;
import com.braker.icontrol.contract.Formulation.model.ContractBasicInfo;
import com.braker.icontrol.contract.enforcing.model.Upt;
import com.braker.icontrol.contract.ledger.manager.LedgerMng;

@Service
@Transactional
public class LedgerMngImpl extends BaseManagerImpl<ContractBasicInfo> implements LedgerMng{


	@Autowired
	private DepartMng departMng;
	@Override
	public Pagination findAllCBI(ContractBasicInfo contractBasicInfo,boolean selfDepart,User user,Integer pageNo, Integer pageSize) {
		Finder finder = Finder.create(" FROM ContractBasicInfo WHERE fFlowStauts='9' AND fContStauts <>'99'");
		/*if (selfDepart) {
			finder.append(" AND fDeptName ='" + user.getDepart().getName() + "' ");
		}*/
		if (!StringUtil.isEmpty(contractBasicInfo.getFcType())) {
			finder.append(" AND fcType =:fcType ").setParam("fcType", contractBasicInfo.getFcType());
		}
		if (!StringUtil.isEmpty(contractBasicInfo.getfPurchNo())) {
			finder.append(" AND fPurchNo =:fPurchNo ").setParam("fPurchNo", contractBasicInfo.getfPurchNo());
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcCode())){
			finder.append(" AND fcCode LIKE :fcCode ");
			finder.setParam("fcCode", "%"+contractBasicInfo.getFcCode()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getFcTitle())){
			finder.append(" AND fcTitle LIKE :fcTitle ");
			finder.setParam("fcTitle", "%"+contractBasicInfo.getFcTitle()+"%");
		}
		if(!StringUtil.isEmpty(contractBasicInfo.getfContStauts())){
			finder.append(" AND fContStauts = :fContStauts ");
			finder.setParam("fContStauts", contractBasicInfo.getfContStauts());
		}
		
		String deptIdStr = departMng.getDeptIdStrByUsers(user);
		//?????????????????????-???????????????????????????????????????????????????
		//????????????????????????????????????????????????
		if(user.getRoleName().contains("?????????????????????") ||user.getRoleName().contains("???????????????")
				||user.getRoleName().contains("???????????????") || user.getRoleName().contains("???????????????")) {
			
		}else {
	 		if("".equals(deptIdStr)){	//?????????????????????????????????
	 			finder.append(" and fOperatorId = :fOperatorId").setParam("fOperatorId", user.getId());
	 		}else if("all".equals(deptIdStr)){	//???????????????????????????
	 			
	 		}else{	//?????????????????????????????????????????? ?????????????????????????????????????????????
	 			finder.append(" and fDeptId in ("+deptIdStr+")");
	 		}
		}
		
		if(!StringUtil.isEmpty(String.valueOf(contractBasicInfo.getfBudgetIndexCode()))){
			finder.append(" AND fBudgetIndexCode = :fBudgetIndexCode ");
			finder.setParam("fBudgetIndexCode", contractBasicInfo.getfBudgetIndexCode());
		}
		if(contractBasicInfo.getfReqtIME()!=null){
			finder.append(" AND datediff(fReqtIME,'"+contractBasicInfo.getfReqtIME()+"')=0");
		}
		finder.append(" ORDER BY updateTime DESC");
		
		Pagination p = super.find(finder, pageNo, pageSize);
		List<ContractBasicInfo> li = (List<ContractBasicInfo>) p.getList();
		for (int i = 0; i < li.size(); i++) {
			String dataType ="0";
			if("1".equals(li.get(i).getfUpdateStatus())){
				dataType ="1";
			}
			String str;
			// AND F_DATA_TYPE ="+dataType+" 
			if("HTFL-02".equals(li.get(i).getFcType())){
				str = "SELECT ROUND(SUM(F_PROCEEDS_AMOUNT_SJ),2) FROM T_PROCEEDS_PLAN WHERE F_CONT_ID="+li.get(i).getFcId()+" AND F_STAUTS='1' AND F_DATA_TYPE ="+dataType+" ";
			}else{
				str="SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),2) FROM T_RECEIV_PLAN WHERE F_CONT_ID="+li.get(i).getFcId()+" AND F_STAUTS='1'";
			}
			Query query=getSession().createSQLQuery(str);
			List<Double> l = query.list();
			Double c1 =0.00;//????????????
			Double sumAomunt = l.get(0) == null ? 0.00:l.get(0);//????????????
			if(StringUtil.isEmpty(String.valueOf(sumAomunt))){
				sumAomunt=0.00;
			}else{
				c1 = (Double.valueOf(li.get(i).getFcAmount()));
				DecimalFormat df = new DecimalFormat("0.00");//???????????????   
				String percentage=df.format((sumAomunt/c1)*100)+"%";
				li.get(i).setPercentage(percentage);
				li.get(i).setfAllAmount(String.valueOf(sumAomunt));
				li.get(i).setfNotAllAmountL(String.valueOf(c1-sumAomunt));
			}
			if(StringUtil.isEmpty(String.valueOf(c1))||(c1==0.0)){
				c1=0.00;
				li.get(i).setPercentage("0.00%");
			}
			if(StringUtil.isEmpty(li.get(i).getfAllAmount())){
				li.get(i).setfAllAmount("0.00");
			}
			if(StringUtil.isEmpty(li.get(i).getfNotAllAmountL())){
				li.get(i).setfNotAllAmountL(String.valueOf(c1-sumAomunt));
			}
		}
		p.setList(li);
		return p;
	}

	@Override
	public List<ContractBasicInfo> ledger(ContractBasicInfo cb,User user) {
		Finder finder =Finder.create(" FROM ContractBasicInfo WHERE fFlowStauts='9' AND fContStauts <>'99' ");
		if(!StringUtil.isEmpty(cb.getFcCode())){
			finder.append(" AND fcCode LIKE('%"+cb.getFcCode()+"%')");
		}
		if(!StringUtil.isEmpty(cb.getFcTitle())){
			finder.append(" AND fcTitle LIKE('%"+cb.getFcTitle()+"%')");
		}
		if(!StringUtil.isEmpty(cb.getfContStauts())){
			finder.append(" AND fContStauts ="+cb.getfContStauts()+"");
		}
		if(!StringUtil.isEmpty(String.valueOf(cb.getfBudgetIndexCode()))){
			finder.append("AND fBudgetIndexCode = :fBudgetIndexCode ");
			finder.setParam("fBudgetIndexCode", cb.getfBudgetIndexCode());
		}
		String deptIdStr = departMng.getDeptIdStrByUsers(user);
		//?????????????????????-???????????????????????????????????????????????????
		//????????????????????????????????????????????????
		if(user.getRoleName().contains("?????????????????????") ||user.getRoleName().contains("???????????????")
				||user.getRoleName().contains("???????????????") || user.getRoleName().contains("???????????????")) {
			
		}else {
	 		if("".equals(deptIdStr)){	//?????????????????????????????????
	 			finder.append(" and fOperatorId = :fOperatorId").setParam("fOperatorId", user.getId());
	 		}else if("all".equals(deptIdStr)){	//???????????????????????????
	 			
	 		}else{	//?????????????????????????????????????????? ?????????????????????????????????????????????
	 			finder.append(" and fDeptId in ("+deptIdStr+")");
	 		}
		}
		finder.append(" ORDER BY updateTime DESC");
		return super.find(finder);
	}
	
	@Override
	public List<ContractBasicInfo> ledgerExport(ContractBasicInfo cb,User user) {
		Finder finder =Finder.create(" FROM ContractBasicInfo WHERE fcId in ("+cb.getfCIds()+") ");
		finder.append(" ORDER BY updateTime DESC");
		return super.find(finder);
	}

	@Override
	public HSSFWorkbook exportExcel(List<ContractBasicInfo> cbi, String filePath) {
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		FileInputStream fis =null;
		try {
			File file = new File(filePath);
			fis = new FileInputStream(file);
			HSSFWorkbook wb  = new HSSFWorkbook(fis);
			HSSFSheet sheet0 = wb.getSheetAt(0);
			if(cbi.size()>0&&cbi!=null){
				HSSFRow row = sheet0.getRow(1);//?????????
				for (int i = 0; i < cbi.size(); i++) {
					HSSFRow hssfRow = sheet0.createRow(2+i);
					hssfRow.setHeight(row.getHeight());
					ContractBasicInfo data = cbi.get(i);
					//??????
					HSSFCell cell0 = hssfRow.createCell(0);
					cell0.setCellValue(i + 1);
					//????????????
					HSSFCell cell1 = hssfRow.createCell(1);
					cell1.setCellValue(data.getFcCode());
					//????????????
					HSSFCell cell2 = hssfRow.createCell(2);
					cell2.setCellValue(data.getFcTitle());
					//??????????????????
					HSSFCell cell3 = hssfRow.createCell(3);
					if(data.getfSignTime()!=null){
						cell3.setCellValue(df.format(data.getfSignTime()));
					}
					//????????????
					HSSFCell cell4 = hssfRow.createCell(4);
					if("HTFL-01".equals(data.getFcType())){
						cell4.setCellValue("???????????????");
					}else if("HTFL-02".equals(data.getFcType())){
						cell4.setCellValue("???????????????");
					}else if("HTFL-03".equals(data.getFcType())){
						cell4.setCellValue("??????????????????");
					}

					//??????????????????
					HSSFCell cell5 = hssfRow.createCell(5);
					if(data.getfContStartTime()!=null){
						cell5.setCellValue(df.format(data.getfContStartTime()));
					}
					//??????????????????
					HSSFCell cell6 = hssfRow.createCell(6);
					if(data.getfContEndTime()!=null){
						cell6.setCellValue(df.format(data.getfContEndTime()));
					}
					//????????????
					HSSFCell cell7 = hssfRow.createCell(7);
					cell7.setCellValue(data.getFcAmount());
					//???????????????
					HSSFCell cell8 = hssfRow.createCell(8);
					cell8.setCellValue(data.getfContractor());
					//????????????
					HSSFCell cell9 = hssfRow.createCell(9);
					if("0".equals(data.getfUpdateStatus())){
						cell9.setCellValue("?????????");
					}else if("1".equals(data.getfUpdateStatus())){
						cell9.setCellValue("?????????");
					}else if("2".equals(data.getfUpdateStatus())){
						cell9.setCellValue("?????????");
					}
					//????????????
					HSSFCell cell10 = hssfRow.createCell(10);
					if("0".equals(data.getfDisputeStatus())){
						cell10.setCellValue("?????????");
					}else if("1".equals(data.getfDisputeStatus())){
						cell10.setCellValue("?????????");
					}
					//????????????
					HSSFCell cell11 = hssfRow.createCell(11);
					if("0".equals(data.getFgdStauts())){
						cell11.setCellValue("?????????");
					}else if("1".equals(data.getFgdStauts())){
						cell11.setCellValue("?????????");
					}
					//????????????
					HSSFCell cell12 = hssfRow.createCell(12);
					cell12.setCellValue(data.getfDeptName());
					//?????????
					HSSFCell cell13 = hssfRow.createCell(13);
					cell13.setCellValue(data.getfOperator());

					
				}
				return wb;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(fis!=null){
				try {
					fis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}
	@Override
	public HSSFWorkbook exportExcelUpt(List<Upt> cbi, String filePath) {
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		FileInputStream fis =null;
		try {
			File file = new File(filePath);
			fis = new FileInputStream(file);
			HSSFWorkbook wb  = new HSSFWorkbook(fis);
			HSSFSheet sheet0 = wb.getSheetAt(0);
			if(cbi.size()>0&&cbi!=null){
				HSSFRow row = sheet0.getRow(1);//?????????
				for (int i = 0; i < cbi.size(); i++) {
					HSSFRow hssfRow = sheet0.createRow(2+i);
					hssfRow.setHeight(row.getHeight());
					Upt data = cbi.get(i);
					//??????
					HSSFCell cell0 = hssfRow.createCell(0);
					cell0.setCellValue(i + 1);
					//??????????????????
					HSSFCell cell1 = hssfRow.createCell(1);
					cell1.setCellValue(data.getfUptCode());
					//??????????????????
					HSSFCell cell2 = hssfRow.createCell(2);
					cell2.setCellValue(data.getfContName());
					//???????????????
					HSSFCell cell3 = hssfRow.createCell(3);
					cell3.setCellValue(data.getfContCodeOld());
					//???????????????
					HSSFCell cell4 = hssfRow.createCell(4);
					cell4.setCellValue(data.getfContNameOld());
					//??????????????????
					HSSFCell cell5 = hssfRow.createCell(5);
					if(data.getfReqTime()!=null){
						cell5.setCellValue(df.format(data.getfReqTime()));
					}
					//????????????
					HSSFCell cell6 = hssfRow.createCell(6);
					if("HTFL-01".equals(data.getfContUptType())){
						cell6.setCellValue("???????????????");
					}else if("HTFL-02".equals(data.getfContUptType())){
						cell6.setCellValue("???????????????");
					}else if("HTFL-03".equals(data.getfContUptType())){
						cell6.setCellValue("??????????????????");
					}
					//????????????
					HSSFCell cell7 = hssfRow.createCell(7);
					cell7.setCellValue(data.getfAmount());
					//???????????????
					HSSFCell cell8 = hssfRow.createCell(8);
					cell8.setCellValue(data.getfContractor());
					//????????????
					HSSFCell cell9 = hssfRow.createCell(9);
					if("0".equals(data.getFgdstatus())){
						cell9.setCellValue("?????????");
					}else if("1".equals(data.getFgdstatus())){
						cell9.setCellValue("?????????");
					}
					//????????????
					HSSFCell cell10 = hssfRow.createCell(10);
					cell10.setCellValue(data.getfDeptName());
					//?????????
					HSSFCell cell11 = hssfRow.createCell(11);
					cell11.setCellValue(data.getfOperator());
				}
				return wb;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(fis!=null){
				try {
					fis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}

	@Override
	public Pagination uptList(Upt upt, User user, Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create(" FROM Upt WHERE fUptFlowStauts=9 ");
		//????????????
		if(!StringUtil.isEmpty(upt.getfUptCode())){
			finder.append(" AND fUptCode LIKE :fUptCode");
			finder.setParam("fUptCode", "%"+upt.getfUptCode()+"%");
		}
		//???????????????
		if(!StringUtil.isEmpty(upt.getfContName())){
			finder.append(" AND fContName LIKE :fContName");
			finder.setParam("fContName", "%"+upt.getfContName()+"%");
		}
		//????????????
		if(!StringUtil.isEmpty(upt.getfContCodeOld())){
			finder.append(" AND fContCodeOld LIKE :fContCodeOld");
			finder.setParam("fContCodeOld", "%"+upt.getfContCodeOld()+"%");
		}
		//???????????????
		if(!StringUtil.isEmpty(upt.getfContNameOld())){
			finder.append(" AND fContNameOld LIKE :fContNameOld");
			finder.setParam("fContNameOld", "%"+upt.getfContNameOld()+"%");
		}
		String deptIdStr = departMng.getDeptIdStrByUsers(user);
		//?????????????????????-???????????????????????????????????????????????????
		//????????????????????????????????????????????????
		if(user.getRoleName().contains("?????????????????????") ||user.getRoleName().contains("???????????????")
				||user.getRoleName().contains("???????????????") || user.getRoleName().contains("???????????????")) {
			
		}else {
	 		if("".equals(deptIdStr)){	//?????????????????????????????????
	 			finder.append(" and fOperatorID = :fOperatorID").setParam("fOperatorID", user.getId());
	 		}else if("all".equals(deptIdStr)){	//???????????????????????????
	 			
	 		}else{	//?????????????????????????????????????????? ?????????????????????????????????????????????
	 			finder.append(" and fDeptID in ("+deptIdStr+")");
	 		}
		}
		finder.append(" order by fReqTime desc");
		
		Pagination p = super.find(finder, pageNo, pageSize);
		List<Upt> li = (List<Upt>) p.getList();
		for (int i = 0; i < li.size(); i++) {
			String str;
			if("HTFL-02".equals(li.get(i).getfContUptType())){
				str = "SELECT ROUND(SUM(F_PROCEEDS_AMOUNT),2) FROM T_PROCEEDS_PLAN WHERE F_UPT_ID="+li.get(i).getfId_U()+" AND F_STAUTS='1' AND F_DATA_TYPE = '1' ";
			}else{
				str="SELECT ROUND(SUM(F_RECE_AMOUNT),2) FROM T_RECEIV_PLAN WHERE F_UPT_ID="+li.get(i).getfId_U()+" AND F_STAUTS='1' AND F_DATA_TYPE ='1' ";
			}
			Query query=getSession().createSQLQuery(str);
			List<Double> l = query.list();
			Double c1 =0.00;//????????????
			Double sumAomunt = l.get(0) == null ? 0.00:l.get(0);//????????????
			if(StringUtil.isEmpty(String.valueOf(sumAomunt))){
				sumAomunt=0.00;
			}else{
				c1 = (Double.valueOf(li.get(i).getfAmount()));
				DecimalFormat df = new DecimalFormat("0.00");//???????????????   
				String percentage=df.format((sumAomunt/c1)*100)+"%";
				li.get(i).setPercentage(percentage);
				li.get(i).setfAllAmount(String.valueOf(sumAomunt));
				li.get(i).setfNotAllAmountL(String.valueOf(c1-sumAomunt));
			}
			if(StringUtil.isEmpty(String.valueOf(c1))||(c1==0.0)){
				c1=0.00;
				li.get(i).setPercentage("0.00%");
			}
			if(StringUtil.isEmpty(li.get(i).getfAllAmount())){
				li.get(i).setfAllAmount("0.00");
			}
			if(StringUtil.isEmpty(li.get(i).getfNotAllAmountL())){
				li.get(i).setfNotAllAmountL(String.valueOf(c1-sumAomunt));
			}
		}
		p.setList(li);
		return p;
	}
	
	@Override
	public List<Upt> uptListExport(Upt upt, User user, Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create(" FROM Upt WHERE fId_U in("+upt.getfId_Us()+") ");
		
		List<Upt> li = super.find(finder);
		for (int i = 0; i < li.size(); i++) {
			String str;
			if("HTFL-02".equals(li.get(i).getfContUptType())){
				str = "SELECT ROUND(SUM(F_PROCEEDS_AMOUNT),2) FROM T_PROCEEDS_PLAN WHERE F_UPT_ID="+li.get(i).getfId_U()+" AND F_STAUTS='1' AND F_DATA_TYPE = '1' ";
			}else{
				str="SELECT ROUND(SUM(F_RECE_AMOUNT),2) FROM T_RECEIV_PLAN WHERE F_UPT_ID="+li.get(i).getfId_U()+" AND F_STAUTS='1' AND F_DATA_TYPE ='1' ";
			}
			Query query=getSession().createSQLQuery(str);
			List<Double> l = query.list();
			Double c1 =0.00;//????????????
			Double sumAomunt = l.get(0) == null ? 0.00:l.get(0);//????????????
			if(StringUtil.isEmpty(String.valueOf(sumAomunt))){
				sumAomunt=0.00;
			}else{
				c1 = (Double.valueOf(li.get(i).getfAmount()));
				DecimalFormat df = new DecimalFormat("0.00");//???????????????   
				String percentage=df.format((sumAomunt/c1)*100)+"%";
				li.get(i).setPercentage(percentage);
				li.get(i).setfAllAmount(String.valueOf(sumAomunt));
				li.get(i).setfNotAllAmountL(String.valueOf(c1-sumAomunt));
			}
			if(StringUtil.isEmpty(String.valueOf(c1))||(c1==0.0)){
				c1=0.00;
				li.get(i).setPercentage("0.00%");
			}
			if(StringUtil.isEmpty(li.get(i).getfAllAmount())){
				li.get(i).setfAllAmount("0.00");
			}
			if(StringUtil.isEmpty(li.get(i).getfNotAllAmountL())){
				li.get(i).setfNotAllAmountL(String.valueOf(c1-sumAomunt));
			}
		}
	return li;
	}

	@Override
	public List<Object[]> findAllStatistics(ContractBasicInfo contractBasicInfo,
			boolean selfDepart, User user, Integer pageNo, Integer pageSize) {
		String str;
			str = "SELECT info.F_DEPT_NAME ??????,sum(CASE WHEN YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN 1 ELSE 0 END) ????????????,sum(CASE WHEN info.F_CONT_TYPE IN ('HTFL-01','HTFL-02') AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) ????????????,sum(CASE WHEN info.F_CONT_TYPE IN ('HTFL-01','HTFL-02') AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN 1 ELSE 0 END) ????????????,sum(CASE WHEN info.F_CONT_TYPE IN ('HTFL-01','HTFL-02') AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) ????????????,CONCAT(IFNULL(ROUND((sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN ("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_STAUTS='1' AND F_DATA_TYPE=1) ELSE ("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_STAUTS='1' AND F_DATA_TYPE=0) END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00)+IFNULL(ROUND((sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN ("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1') ELSE ("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0') END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),'%') ?????????????????????,CONCAT(ROUND(IFNULL(IFNULL(ROUND((sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN IFNULL(("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=1),0) ELSE IFNULL(("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=0),0) END)+sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN IFNULL(("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1'),0) ELSE IFNULL(("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0'),0) END)+sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN (CASE WHEN info.F_UPDATE_STATUS='1' THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END)+sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN IFNULL(("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1'),0) ELSE IFNULL(("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0' AND info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW())),0) END))*100,4),0.00)/IFNULL(ROUND((sum(CASE WHEN info.F_CONT_TYPE IN ('HTFL-01','HTFL-02') AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END)+sum(CASE WHEN info.F_CONT_TYPE IN ('HTFL-01','HTFL-02') AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),0.00),4),'%') ???????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN 1 ELSE 0 END) ??????????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) ??????????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN IFNULL(("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=1),0) ELSE IFNULL(("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=0),0) END) ???????????????,CONCAT(IFNULL(ROUND((sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN ("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_STAUTS='1' AND F_DATA_TYPE=1) ELSE ("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_STAUTS='1' AND F_DATA_TYPE=0) END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),'%') ???????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN 1 ELSE 0 END) ??????????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) ??????????????????,sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN IFNULL(("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1'),0) ELSE IFNULL(("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0'),0) END) ???????????????,CONCAT(IFNULL(ROUND((sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN ("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1') ELSE ("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0') END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),'%') ???????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-03' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN 1 ELSE 0 END) ?????????????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN 1 ELSE 0 END) ????????????????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN (CASE WHEN info.F_UPDATE_STATUS='1' THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) ????????????????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN IFNULL(("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=1),0) ELSE IFNULL(("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=0 AND info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW())),0) END) ?????????????????????,CONCAT(IFNULL(ROUND((sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN IFNULL(("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=1),0) ELSE IFNULL(("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=0 AND info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW())),0) END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN (CASE WHEN info.F_UPDATE_STATUS='1' THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),'%') ?????????????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN 1 ELSE 0 END) ????????????????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) ????????????????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN IFNULL(("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1'),0) ELSE IFNULL(("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0' AND info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW())),0) END) ?????????????????????,CONCAT(IFNULL(ROUND((sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN IFNULL(("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1'),0) ELSE IFNULL(("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0' AND info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW())),0) END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN (CASE WHEN info.F_UPDATE_STATUS='1' THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),'%') ????????????????????? FROM t_contract_basic_info info LEFT JOIN t_contract_upt upt ON info.F_CONT_ID=upt.F_CONT_ID AND upt.F_UPT_STAUTS !='99' WHERE info.F_SEALED_STATUS='1' GROUP BY info.F_DEPT_NAME";
		Query query=getSession().createSQLQuery(str);
		List<Object[]> list = query.list();
		
		String str1;
			str1 = "SELECT IFNULL('??????','??????') ??????,sum(????????????) ??????????????????,sum(????????????) ??????????????????,sum(????????????) ??????????????????,sum(????????????) ??????????????????,CONCAT(IFNULL(ROUND(((sum(???????????????)+sum(???????????????))/(sum(??????????????????)+sum(??????????????????)))*100,4),0),'%') ?????????????????????,CONCAT(IFNULL(ROUND(((sum(???????????????)+sum(???????????????)+sum(?????????????????????)+sum(?????????????????????))/(sum(??????????????????)+sum(??????????????????)+sum(????????????????????????)+sum(?????????????????????)))*100,4),0),'%') ???????????????,sum(??????????????????) ????????????????????????,sum(??????????????????) ????????????????????????,sum(???????????????) ?????????????????????,CONCAT(IFNULL(ROUND((sum(???????????????)/sum(??????????????????))*100,4),0),'%') ?????????????????????,sum(??????????????????) ????????????????????????,sum(??????????????????) ????????????????????????,sum(???????????????) ?????????????????????,CONCAT(IFNULL(ROUND((sum(???????????????)/sum(??????????????????))*100,4),0),'%') ?????????????????????,sum(?????????????????????) ???????????????????????????,sum(????????????????????????) ??????????????????????????????,sum(????????????????????????) ??????????????????????????????,sum(?????????????????????) ???????????????????????????,CONCAT(IFNULL(ROUND((sum(?????????????????????)/sum(????????????????????????))*100,4),0),'%') ???????????????????????????,sum(????????????????????????) ??????????????????????????????,sum(????????????????????????) ??????????????????????????????,sum(?????????????????????) ???????????????????????????,CONCAT(IFNULL(ROUND((sum(?????????????????????)/sum(????????????????????????))*100,4),0),'%') ??????????????????????????? FROM ("
				+"SELECT sum(CASE WHEN YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN 1 ELSE 0 END) ????????????,sum(CASE WHEN info.F_CONT_TYPE IN ('HTFL-01','HTFL-02') AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) ????????????,sum(CASE WHEN info.F_CONT_TYPE IN ('HTFL-01','HTFL-02') AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN 1 ELSE 0 END) ????????????,sum(CASE WHEN info.F_CONT_TYPE IN ('HTFL-01','HTFL-02') AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) ????????????,CONCAT(IFNULL(ROUND((sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN ("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_STAUTS='1' AND F_DATA_TYPE=1) ELSE ("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_STAUTS='1' AND F_DATA_TYPE=0) END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00)+IFNULL(ROUND((sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN ("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1') ELSE ("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0') END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),'%') ?????????????????????,CONCAT(ROUND(IFNULL(IFNULL(ROUND((sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN IFNULL(("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=1),0) ELSE IFNULL(("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=0),0) END)+sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN IFNULL(("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1'),0) ELSE IFNULL(("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0'),0) END)+sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN (CASE WHEN info.F_UPDATE_STATUS='1' THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END)+sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN IFNULL(("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1'),0) ELSE IFNULL(("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0' AND info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW())),0) END))*100,4),0.00)/IFNULL(ROUND((sum(CASE WHEN info.F_CONT_TYPE IN ('HTFL-01','HTFL-02') AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END)+sum(CASE WHEN info.F_CONT_TYPE IN ('HTFL-01','HTFL-02') AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),0.00),4),'%') ???????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN 1 ELSE 0 END) ??????????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) ??????????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN IFNULL(("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=1),0) ELSE IFNULL(("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=0),0) END) ???????????????,CONCAT(IFNULL(ROUND((sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN ("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_STAUTS='1' AND F_DATA_TYPE=1) ELSE ("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_STAUTS='1' AND F_DATA_TYPE=0) END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),'%') ???????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN 1 ELSE 0 END) ??????????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) ??????????????????,sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN IFNULL(("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1'),0) ELSE IFNULL(("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0'),0) END) ???????????????,CONCAT(IFNULL(ROUND((sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN ("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1') ELSE ("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0') END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),'%') ???????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-03' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN 1 ELSE 0 END) ?????????????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN 1 ELSE 0 END) ????????????????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN (CASE WHEN info.F_UPDATE_STATUS='1' THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) ????????????????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN IFNULL(("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=1),0) ELSE IFNULL(("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=0 AND info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW())),0) END) ?????????????????????,CONCAT(IFNULL(ROUND((sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN IFNULL(("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=1),0) ELSE IFNULL(("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=0 AND info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW())),0) END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN (CASE WHEN info.F_UPDATE_STATUS='1' THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),'%') ?????????????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN 1 ELSE 0 END) ????????????????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) ????????????????????????,sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN IFNULL(("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1'),0) ELSE IFNULL(("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0' AND info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW())),0) END) ?????????????????????,CONCAT(IFNULL(ROUND((sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN IFNULL(("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1'),0) ELSE IFNULL(("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0' AND info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW())),0) END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN (CASE WHEN info.F_UPDATE_STATUS='1' THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),'%') ????????????????????? FROM t_contract_basic_info info LEFT JOIN t_contract_upt upt ON info.F_CONT_ID=upt.F_CONT_ID AND upt.F_UPT_STAUTS !='99' WHERE info.F_SEALED_STATUS='1' GROUP BY info.F_DEPT_NAME) a";
		Query query1=getSession().createSQLQuery(str1);
		List<Object[]> list1 = query1.list();
		list.addAll(list1);
		return list;
	}

}
