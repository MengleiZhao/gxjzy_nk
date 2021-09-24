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
		//合同台账查看岗-特定用户可以查看所有部门台账的权限
		//合同管理岗可以查看所有部门的台账
		if(user.getRoleName().contains("合同台账查看岗") ||user.getRoleName().contains("合同管理岗")
				||user.getRoleName().contains("印章管理岗") || user.getRoleName().contains("合同法审岗")) {
			
		}else {
	 		if("".equals(deptIdStr)){	//普通岗位只能查看自己的
	 			finder.append(" and fOperatorId = :fOperatorId").setParam("fOperatorId", user.getId());
	 		}else if("all".equals(deptIdStr)){	//校长可以查看所有人
	 			
	 		}else{	//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
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
			Double c1 =0.00;//合同金额
			Double sumAomunt = l.get(0) == null ? 0.00:l.get(0);//已付金额
			if(StringUtil.isEmpty(String.valueOf(sumAomunt))){
				sumAomunt=0.00;
			}else{
				c1 = (Double.valueOf(li.get(i).getFcAmount()));
				DecimalFormat df = new DecimalFormat("0.00");//格式化小数   
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
		//合同台账查看岗-特定用户可以查看所有部门台账的权限
		//合同管理岗可以查看所有部门的台账
		if(user.getRoleName().contains("合同台账查看岗") ||user.getRoleName().contains("合同管理岗")
				||user.getRoleName().contains("印章管理岗") || user.getRoleName().contains("合同法审岗")) {
			
		}else {
	 		if("".equals(deptIdStr)){	//普通岗位只能查看自己的
	 			finder.append(" and fOperatorId = :fOperatorId").setParam("fOperatorId", user.getId());
	 		}else if("all".equals(deptIdStr)){	//校长可以查看所有人
	 			
	 		}else{	//部门主管，可以查看本部门的， 分管校长可以查看自己管辖的部门
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
				HSSFRow row = sheet0.getRow(1);//格式行
				for (int i = 0; i < cbi.size(); i++) {
					HSSFRow hssfRow = sheet0.createRow(2+i);
					hssfRow.setHeight(row.getHeight());
					ContractBasicInfo data = cbi.get(i);
					//序号
					HSSFCell cell0 = hssfRow.createCell(0);
					cell0.setCellValue(i + 1);
					//合同编号
					HSSFCell cell1 = hssfRow.createCell(1);
					cell1.setCellValue(data.getFcCode());
					//合同名称
					HSSFCell cell2 = hssfRow.createCell(2);
					cell2.setCellValue(data.getFcTitle());
					//合同签订日期
					HSSFCell cell3 = hssfRow.createCell(3);
					if(data.getfSignTime()!=null){
						cell3.setCellValue(df.format(data.getfSignTime()));
					}
					//合同分类
					HSSFCell cell4 = hssfRow.createCell(4);
					if("HTFL-01".equals(data.getFcType())){
						cell4.setCellValue("采购类合同");
					}else if("HTFL-02".equals(data.getFcType())){
						cell4.setCellValue("收入类合同");
					}else if("HTFL-03".equals(data.getFcType())){
						cell4.setCellValue("非经济类合同");
					}

					//合同开始日期
					HSSFCell cell5 = hssfRow.createCell(5);
					if(data.getfContStartTime()!=null){
						cell5.setCellValue(df.format(data.getfContStartTime()));
					}
					//合同结束时间
					HSSFCell cell6 = hssfRow.createCell(6);
					if(data.getfContEndTime()!=null){
						cell6.setCellValue(df.format(data.getfContEndTime()));
					}
					//合同金额
					HSSFCell cell7 = hssfRow.createCell(7);
					cell7.setCellValue(data.getFcAmount());
					//签约方名称
					HSSFCell cell8 = hssfRow.createCell(8);
					cell8.setCellValue(data.getfContractor());
					//变更状态
					HSSFCell cell9 = hssfRow.createCell(9);
					if("0".equals(data.getfUpdateStatus())){
						cell9.setCellValue("未变更");
					}else if("1".equals(data.getfUpdateStatus())){
						cell9.setCellValue("已变更");
					}else if("2".equals(data.getfUpdateStatus())){
						cell9.setCellValue("变更中");
					}
					//纠纷状态
					HSSFCell cell10 = hssfRow.createCell(10);
					if("0".equals(data.getfDisputeStatus())){
						cell10.setCellValue("没纠纷");
					}else if("1".equals(data.getfDisputeStatus())){
						cell10.setCellValue("有纠纷");
					}
					//是否归档
					HSSFCell cell11 = hssfRow.createCell(11);
					if("0".equals(data.getFgdStauts())){
						cell11.setCellValue("未归档");
					}else if("1".equals(data.getFgdStauts())){
						cell11.setCellValue("已归档");
					}
					//所属部门
					HSSFCell cell12 = hssfRow.createCell(12);
					cell12.setCellValue(data.getfDeptName());
					//申请人
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
				HSSFRow row = sheet0.getRow(1);//格式行
				for (int i = 0; i < cbi.size(); i++) {
					HSSFRow hssfRow = sheet0.createRow(2+i);
					hssfRow.setHeight(row.getHeight());
					Upt data = cbi.get(i);
					//序号
					HSSFCell cell0 = hssfRow.createCell(0);
					cell0.setCellValue(i + 1);
					//变更合同编号
					HSSFCell cell1 = hssfRow.createCell(1);
					cell1.setCellValue(data.getfUptCode());
					//变更合同名称
					HSSFCell cell2 = hssfRow.createCell(2);
					cell2.setCellValue(data.getfContName());
					//原合同编号
					HSSFCell cell3 = hssfRow.createCell(3);
					cell3.setCellValue(data.getfContCodeOld());
					//原合同名称
					HSSFCell cell4 = hssfRow.createCell(4);
					cell4.setCellValue(data.getfContNameOld());
					//合同签订日期
					HSSFCell cell5 = hssfRow.createCell(5);
					if(data.getfReqTime()!=null){
						cell5.setCellValue(df.format(data.getfReqTime()));
					}
					//合同分类
					HSSFCell cell6 = hssfRow.createCell(6);
					if("HTFL-01".equals(data.getfContUptType())){
						cell6.setCellValue("采购类合同");
					}else if("HTFL-02".equals(data.getfContUptType())){
						cell6.setCellValue("收入类合同");
					}else if("HTFL-03".equals(data.getfContUptType())){
						cell6.setCellValue("非经济类合同");
					}
					//合同金额
					HSSFCell cell7 = hssfRow.createCell(7);
					cell7.setCellValue(data.getfAmount());
					//签约方名称
					HSSFCell cell8 = hssfRow.createCell(8);
					cell8.setCellValue(data.getfContractor());
					//是否归档
					HSSFCell cell9 = hssfRow.createCell(9);
					if("0".equals(data.getFgdstatus())){
						cell9.setCellValue("未归档");
					}else if("1".equals(data.getFgdstatus())){
						cell9.setCellValue("已归档");
					}
					//所属部门
					HSSFCell cell10 = hssfRow.createCell(10);
					cell10.setCellValue(data.getfDeptName());
					//申请人
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
		//新合同号
		if(!StringUtil.isEmpty(upt.getfUptCode())){
			finder.append(" AND fUptCode LIKE :fUptCode");
			finder.setParam("fUptCode", "%"+upt.getfUptCode()+"%");
		}
		//新合同名称
		if(!StringUtil.isEmpty(upt.getfContName())){
			finder.append(" AND fContName LIKE :fContName");
			finder.setParam("fContName", "%"+upt.getfContName()+"%");
		}
		//原合同号
		if(!StringUtil.isEmpty(upt.getfContCodeOld())){
			finder.append(" AND fContCodeOld LIKE :fContCodeOld");
			finder.setParam("fContCodeOld", "%"+upt.getfContCodeOld()+"%");
		}
		//原合同名称
		if(!StringUtil.isEmpty(upt.getfContNameOld())){
			finder.append(" AND fContNameOld LIKE :fContNameOld");
			finder.setParam("fContNameOld", "%"+upt.getfContNameOld()+"%");
		}
		String deptIdStr = departMng.getDeptIdStrByUsers(user);
		//合同台账查看岗-特定用户可以查看所有部门台账的权限
		//合同管理岗可以查看所有部门的台账
		if(user.getRoleName().contains("合同台账查看岗") ||user.getRoleName().contains("合同管理岗")
				||user.getRoleName().contains("印章管理岗") || user.getRoleName().contains("合同法审岗")) {
			
		}else {
	 		if("".equals(deptIdStr)){	//普通岗位只能查看自己的
	 			finder.append(" and fOperatorID = :fOperatorID").setParam("fOperatorID", user.getId());
	 		}else if("all".equals(deptIdStr)){	//局长可以查看所有人
	 			
	 		}else{	//部门主管，可以查看本部门的， 分管局长可以查看自己管辖的部门
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
			Double c1 =0.00;//合同金额
			Double sumAomunt = l.get(0) == null ? 0.00:l.get(0);//已付金额
			if(StringUtil.isEmpty(String.valueOf(sumAomunt))){
				sumAomunt=0.00;
			}else{
				c1 = (Double.valueOf(li.get(i).getfAmount()));
				DecimalFormat df = new DecimalFormat("0.00");//格式化小数   
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
			Double c1 =0.00;//合同金额
			Double sumAomunt = l.get(0) == null ? 0.00:l.get(0);//已付金额
			if(StringUtil.isEmpty(String.valueOf(sumAomunt))){
				sumAomunt=0.00;
			}else{
				c1 = (Double.valueOf(li.get(i).getfAmount()));
				DecimalFormat df = new DecimalFormat("0.00");//格式化小数   
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
			str = "SELECT info.F_DEPT_NAME 部门,sum(CASE WHEN YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN 1 ELSE 0 END) 新签合同,sum(CASE WHEN info.F_CONT_TYPE IN ('HTFL-01','HTFL-02') AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) 新签金额,sum(CASE WHEN info.F_CONT_TYPE IN ('HTFL-01','HTFL-02') AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN 1 ELSE 0 END) 结转合同,sum(CASE WHEN info.F_CONT_TYPE IN ('HTFL-01','HTFL-02') AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) 结转金额,CONCAT(IFNULL(ROUND((sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN ("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_STAUTS='1' AND F_DATA_TYPE=1) ELSE ("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_STAUTS='1' AND F_DATA_TYPE=0) END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00)+IFNULL(ROUND((sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN ("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1') ELSE ("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0') END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),'%') 本年综合执行率,CONCAT(ROUND(IFNULL(IFNULL(ROUND((sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN IFNULL(("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=1),0) ELSE IFNULL(("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=0),0) END)+sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN IFNULL(("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1'),0) ELSE IFNULL(("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0'),0) END)+sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN (CASE WHEN info.F_UPDATE_STATUS='1' THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END)+sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN IFNULL(("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1'),0) ELSE IFNULL(("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0' AND info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW())),0) END))*100,4),0.00)/IFNULL(ROUND((sum(CASE WHEN info.F_CONT_TYPE IN ('HTFL-01','HTFL-02') AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END)+sum(CASE WHEN info.F_CONT_TYPE IN ('HTFL-01','HTFL-02') AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),0.00),4),'%') 综合执行率,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN 1 ELSE 0 END) 采购合同份数,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) 采购合同金额,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN IFNULL(("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=1),0) ELSE IFNULL(("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=0),0) END) 已付款金额,CONCAT(IFNULL(ROUND((sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN ("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_STAUTS='1' AND F_DATA_TYPE=1) ELSE ("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_STAUTS='1' AND F_DATA_TYPE=0) END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),'%') 采购执行率,sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN 1 ELSE 0 END) 收入合同份数,sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) 收入合同金额,sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN IFNULL(("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1'),0) ELSE IFNULL(("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0'),0) END) 已收入金额,CONCAT(IFNULL(ROUND((sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN ("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1') ELSE ("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0') END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),'%') 收入执行率,sum(CASE WHEN info.F_CONT_TYPE='HTFL-03' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN 1 ELSE 0 END) 非经济合同份数,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN 1 ELSE 0 END) 结转采购合同份数,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN (CASE WHEN info.F_UPDATE_STATUS='1' THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) 结转采购合同金额,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN IFNULL(("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=1),0) ELSE IFNULL(("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=0 AND info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW())),0) END) 结转已付款金额,CONCAT(IFNULL(ROUND((sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN IFNULL(("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=1),0) ELSE IFNULL(("
					+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=0 AND info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW())),0) END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN (CASE WHEN info.F_UPDATE_STATUS='1' THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),'%') 结转采购执行率,sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN 1 ELSE 0 END) 结转收入合同份数,sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) 结转收入合同金额,sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN IFNULL(("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1'),0) ELSE IFNULL(("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0' AND info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW())),0) END) 结转已收入金额,CONCAT(IFNULL(ROUND((sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN IFNULL(("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1'),0) ELSE IFNULL(("
					+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0' AND info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW())),0) END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN (CASE WHEN info.F_UPDATE_STATUS='1' THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),'%') 结转收入执行率 FROM t_contract_basic_info info LEFT JOIN t_contract_upt upt ON info.F_CONT_ID=upt.F_CONT_ID AND upt.F_UPT_STAUTS !='99' WHERE info.F_SEALED_STATUS='1' GROUP BY info.F_DEPT_NAME";
		Query query=getSession().createSQLQuery(str);
		List<Object[]> list = query.list();
		
		String str1;
			str1 = "SELECT IFNULL('合计','合计') 合计,sum(新签合同) 新签合同合计,sum(新签金额) 新签金额合计,sum(结转合同) 结转合同合计,sum(结转金额) 结转金额合计,CONCAT(IFNULL(ROUND(((sum(已付款金额)+sum(已收入金额))/(sum(采购合同金额)+sum(收入合同金额)))*100,4),0),'%') 本年综合执行率,CONCAT(IFNULL(ROUND(((sum(已付款金额)+sum(已收入金额)+sum(结转已付款金额)+sum(结转已收入金额))/(sum(采购合同金额)+sum(收入合同金额)+sum(结转采购合同金额)+sum(结转已收入金额)))*100,4),0),'%') 综合执行率,sum(采购合同份数) 采购合同份数合计,sum(采购合同金额) 采购合同金额合计,sum(已付款金额) 已付款金额合计,CONCAT(IFNULL(ROUND((sum(已付款金额)/sum(采购合同金额))*100,4),0),'%') 采购执行率合计,sum(收入合同份数) 收入合同份数合计,sum(收入合同金额) 收入合同金额合计,sum(已收入金额) 已收入金额合计,CONCAT(IFNULL(ROUND((sum(已收入金额)/sum(收入合同金额))*100,4),0),'%') 收入执行率合计,sum(非经济合同份数) 非经济合同份数合计,sum(结转采购合同份数) 结转采购合同份数合计,sum(结转采购合同金额) 结转采购合同金额合计,sum(结转已付款金额) 结转已付款金额合计,CONCAT(IFNULL(ROUND((sum(结转已付款金额)/sum(结转采购合同金额))*100,4),0),'%') 结转采购执行率合计,sum(结转收入合同份数) 结转收入合同份数合计,sum(结转收入合同金额) 结转收入合同金额合计,sum(结转已收入金额) 结转已收入金额合计,CONCAT(IFNULL(ROUND((sum(结转已收入金额)/sum(结转收入合同金额))*100,4),0),'%') 结转收入执行率合计 FROM ("
				+"SELECT sum(CASE WHEN YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN 1 ELSE 0 END) 新签合同,sum(CASE WHEN info.F_CONT_TYPE IN ('HTFL-01','HTFL-02') AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) 新签金额,sum(CASE WHEN info.F_CONT_TYPE IN ('HTFL-01','HTFL-02') AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN 1 ELSE 0 END) 结转合同,sum(CASE WHEN info.F_CONT_TYPE IN ('HTFL-01','HTFL-02') AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) 结转金额,CONCAT(IFNULL(ROUND((sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN ("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_STAUTS='1' AND F_DATA_TYPE=1) ELSE ("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_STAUTS='1' AND F_DATA_TYPE=0) END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00)+IFNULL(ROUND((sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN ("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1') ELSE ("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0') END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),'%') 本年综合执行率,CONCAT(ROUND(IFNULL(IFNULL(ROUND((sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN IFNULL(("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=1),0) ELSE IFNULL(("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=0),0) END)+sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN IFNULL(("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1'),0) ELSE IFNULL(("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0'),0) END)+sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN (CASE WHEN info.F_UPDATE_STATUS='1' THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END)+sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN IFNULL(("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1'),0) ELSE IFNULL(("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0' AND info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW())),0) END))*100,4),0.00)/IFNULL(ROUND((sum(CASE WHEN info.F_CONT_TYPE IN ('HTFL-01','HTFL-02') AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END)+sum(CASE WHEN info.F_CONT_TYPE IN ('HTFL-01','HTFL-02') AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),0.00),4),'%') 综合执行率,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN 1 ELSE 0 END) 采购合同份数,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) 采购合同金额,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN IFNULL(("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=1),0) ELSE IFNULL(("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=0),0) END) 已付款金额,CONCAT(IFNULL(ROUND((sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN ("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_STAUTS='1' AND F_DATA_TYPE=1) ELSE ("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_STAUTS='1' AND F_DATA_TYPE=0) END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),'%') 采购执行率,sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN 1 ELSE 0 END) 收入合同份数,sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) 收入合同金额,sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN IFNULL(("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1'),0) ELSE IFNULL(("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0'),0) END) 已收入金额,CONCAT(IFNULL(ROUND((sum(CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN ("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1') ELSE ("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0') END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),'%') 收入执行率,sum(CASE WHEN info.F_CONT_TYPE='HTFL-03' AND YEAR (info.F_REQ_TIME)=YEAR (NOW()) THEN 1 ELSE 0 END) 非经济合同份数,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN 1 ELSE 0 END) 结转采购合同份数,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN (CASE WHEN info.F_UPDATE_STATUS='1' THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) 结转采购合同金额,sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN IFNULL(("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=1),0) ELSE IFNULL(("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=0 AND info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW())),0) END) 结转已付款金额,CONCAT(IFNULL(ROUND((sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN IFNULL(("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=upt.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=1),0) ELSE IFNULL(("
				+"SELECT ROUND(SUM(F_RECE_PLAN_AMOUNT),4) FROM T_RECEIV_PLAN WHERE F_CONT_ID=info.F_CONT_ID AND F_PAY_STAUTS='9' AND F_DATA_TYPE=0 AND info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW())),0) END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-01' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN (CASE WHEN info.F_UPDATE_STATUS='1' THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),'%') 结转采购执行率,sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN 1 ELSE 0 END) 结转收入合同份数,sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN (CASE WHEN info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END) 结转收入合同金额,sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN IFNULL(("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1'),0) ELSE IFNULL(("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0' AND info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW())),0) END) 结转已收入金额,CONCAT(IFNULL(ROUND((sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND info.F_UPDATE_STATUS='1' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN IFNULL(("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='1'),0) ELSE IFNULL(("
				+"SELECT sum(a.F_PROCEEDS_AMOUNT) FROM t_proceeds_plan a WHERE a.F_CONT_ID=info.F_CONT_ID AND a.F_STAUTS='1' AND a.F_DATA_TYPE='0' AND info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW())),0) END)/sum(CASE WHEN info.F_CONT_TYPE='HTFL-02' AND YEAR (info.F_REQ_TIME) !=YEAR (NOW()) AND info.F_IF_REIM !='1' THEN (CASE WHEN info.F_UPDATE_STATUS='1' THEN upt.F_AMOUNT ELSE info.F_AMOUNT END) ELSE 0 END))*100,4),0.00),'%') 结转收入执行率 FROM t_contract_basic_info info LEFT JOIN t_contract_upt upt ON info.F_CONT_ID=upt.F_CONT_ID AND upt.F_UPT_STAUTS !='99' WHERE info.F_SEALED_STATUS='1' GROUP BY info.F_DEPT_NAME) a";
		Query query1=getSession().createSQLQuery(str1);
		List<Object[]> list1 = query1.list();
		list.addAll(list1);
		return list;
	}

}
