package com.braker.icontrol.budget.data.manager.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.util.DateUtil;
import com.braker.common.util.MatheUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.EconomicMng;
import com.braker.core.model.Depart;
import com.braker.core.model.Economic;
import com.braker.core.model.ProMgrLevel2;
import com.braker.core.model.SysDepartEconomic;
import com.braker.icontrol.assets.storage.model.AssetBasicInfo;
import com.braker.icontrol.budget.data.entity.BudgetData1;
import com.braker.icontrol.budget.data.entity.BudgetData2;
import com.braker.icontrol.budget.data.manager.BudgetData1Mng;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexDetailMng;

@Service
public class BudgetData1MngImpl extends BaseManagerImpl<BudgetData1> implements BudgetData1Mng {

	@Autowired
	private BudgetIndexDetailMng budgetIndexDetailMng;
	@Autowired
	private EconomicMng economicMng;
	@Override
	public List<BudgetData1> getYearList(List<TBudgetIndexMgr> list1, List<Object[]> list2, String[] years) {

		if (years == null || years.length != 3) {
			return null;
		}
		//组合数据
		List<BudgetData1> resList = new ArrayList<BudgetData1>();
		int i = 0;
		if (list1 != null && list1.size() > 0) {
			for (TBudgetIndexMgr mgr: list1) {
				i++;
				BudgetData1 data = new BudgetData1();
				data.setPageOrder(String.valueOf(i));
				data.setIndexId(String.valueOf(mgr.getbId()));
				data.setIndexName(mgr.getIndexName());
				data.setIndexAmount(String.valueOf(mgr.getYsAmount()));
				data.setDepartName(mgr.getDeptName());
				//加入近三年的年累值、环比、执行率数据
				if (list2 != null && list2.size() > 0) {
					for (Object[] array: list2) {
						String id = String.valueOf(array[0]);
						String year = String.valueOf(array[1]);
						String amount = String.valueOf(array[2]);
						if (id.equals(data.getIndexId()) && year.equals(years[0])) {
							data.setNum0(amount);
						} else if (id.equals(data.getIndexId()) && year.equals(years[1])) {
							data.setNum1(amount);
						} else if (id.equals(data.getIndexId()) && year.equals(years[2])) {
							data.setNum2(amount);
						}
					}
				}
				resList.add(data);
			}
		}
		
		return resList;
	}

	@Override
	public List<BudgetData2> getMonthList(List<TBudgetIndexMgr> list1,
			List<Object[]> list2, List<Object[]> list3, String[] months) {
		
		if (months == null || months.length != 12) {
			return null;
		}
		//组合数据
		List<BudgetData2> resList = new ArrayList<BudgetData2>();
		int i = 0;
		//月累值
		if (list1 != null && list1.size() > 0) {
			for (TBudgetIndexMgr mgr: list1) {
				i++;
				BudgetData2 data = new BudgetData2();
				data.setPageOrder(String.valueOf(i));
				data.setIndexCode(String.valueOf(mgr.getIndexCode()));
				data.setIndexName(mgr.getIndexName());
				data.setIndexAmount(String.valueOf(mgr.getYsAmount()));
				data.setDepartName(mgr.getDeptName());
				//加入累值和同比数据
				if (list2 != null && list2.size() > 0) {
					for (Object[] array: list2) {
						String indexCode = String.valueOf(array[0]);
						String year = String.valueOf(array[1]);
						String amount = String.valueOf(array[2]);
						if (indexCode.equals(data.getIndexId()) && year.equals(months[0])) {
							data.setNum1(amount);
						} else if (indexCode.equals(data.getIndexCode()) && year.equals(months[1])) {
							data.setNum2(amount);
						} else if (indexCode.equals(data.getIndexCode()) && year.equals(months[2])) {
							data.setNum3(amount);
						} else if (indexCode.equals(data.getIndexCode()) && year.equals(months[3])) {
							data.setNum4(amount);
						} else if (indexCode.equals(data.getIndexCode()) && year.equals(months[4])) {
							data.setNum5(amount);
						} else if (indexCode.equals(data.getIndexCode()) && year.equals(months[5])) {
							data.setNum6(amount);
						} else if (indexCode.equals(data.getIndexCode()) && year.equals(months[6])) {
							data.setNum7(amount);
						} else if (indexCode.equals(data.getIndexCode()) && year.equals(months[7])) {
							data.setNum8(amount);
						} else if (indexCode.equals(data.getIndexCode()) && year.equals(months[8])) {
							data.setNum9(amount);
						} else if (indexCode.equals(data.getIndexCode()) && year.equals(months[9])) {
							data.setNum10(amount);
						} else if (indexCode.equals(data.getIndexCode()) && year.equals(months[10])) {
							data.setNum11(amount);
						} else if (indexCode.equals(data.getIndexCode()) && year.equals(months[11])) {
							data.setNum12(amount);
						}
					}
				}
				//月环比值
				if (list3 != null && list3.size() > 0) {
					for (Object[] array: list3) {
						String indexCode = String.valueOf(array[0]);
						String year = String.valueOf(array[1]);
						String amount = String.valueOf(array[2]);
						if (indexCode.equals(data.getIndexId()) && year.equals(months[0])) {
							data.setLastNum1(amount);
						} else if (indexCode.equals(data.getIndexCode()) && year.equals(months[1])) {
							data.setLastNum2(amount);
						} else if (indexCode.equals(data.getIndexCode()) && year.equals(months[2])) {
							data.setLastNum3(amount);
						} else if (indexCode.equals(data.getIndexCode()) && year.equals(months[3])) {
							data.setLastNum4(amount);
						} else if (indexCode.equals(data.getIndexCode()) && year.equals(months[4])) {
							data.setLastNum5(amount);
						} else if (indexCode.equals(data.getIndexCode()) && year.equals(months[5])) {
							data.setLastNum6(amount);
						} else if (indexCode.equals(data.getIndexCode()) && year.equals(months[6])) {
							data.setLastNum7(amount);
						} else if (indexCode.equals(data.getIndexCode()) && year.equals(months[7])) {
							data.setLastNum8(amount);
						} else if (indexCode.equals(data.getIndexCode()) && year.equals(months[8])) {
							data.setLastNum9(amount);
						} else if (indexCode.equals(data.getIndexCode()) && year.equals(months[9])) {
							data.setLastNum10(amount);
						} else if (indexCode.equals(data.getIndexCode()) && year.equals(months[10])) {
							data.setLastNum11(amount);
						} else if (indexCode.equals(data.getIndexCode()) && year.equals(months[11])) {
							data.setLastNum12(amount);
						}
					}
				}
				resList.add(data);
			}
		}
		
		return resList;
	}


	@Override
	public HSSFWorkbook exportExcel(List<BudgetData1> yearList,
			List<BudgetData2> monthList, String filePath) {
		FileInputStream fis =null;
		try {
			File file = new File(filePath);
			fis = new FileInputStream(file);
			HSSFWorkbook wb  = new HSSFWorkbook(fis);
			HSSFSheet sheet0 = wb.getSheetAt(0);
			HSSFSheet sheet1 = wb.getSheetAt(1);
			
			//sheet0年报数据
			if (yearList !=null && yearList.size() > 0) {
				HSSFRow row = sheet0.getRow(3);//格式行
				for (int i = 0 ; i < yearList.size(); i++) {
					HSSFRow hssfRow = sheet0.createRow(3+i);
					hssfRow.setHeight(row.getHeight());
					BudgetData1 data = yearList.get(i);
					//序号
					HSSFCell cell0 = hssfRow.createCell(0);
					cell0.setCellValue(i + 1);
					//名称
					HSSFCell cell1 = hssfRow.createCell(1);
					cell1.setCellValue(data.getIndexName());
					//部门
					HSSFCell cell2 = hssfRow.createCell(2);
					cell2.setCellValue(data.getDepartName());
					//额度
					HSSFCell cell3 = hssfRow.createCell(3);
					cell3.setCellValue(data.getIndexAmount());
					//年累值
					double num0 = Double.valueOf(data.getNum0());
					double num1 = Double.valueOf(data.getNum1());
					double num2 = Double.valueOf(data.getNum2());
					//执行率
					String zxl0 = "-"; 
					String zxl1 = "-"; 
					String zxl2 = "-";
					DecimalFormat df = new DecimalFormat("0.00");
					if (!StringUtil.isEmpty(data.getIndexAmount())) {
						double amount = Double.valueOf(data.getIndexAmount());
						zxl0 = String.valueOf(df.format(num0 * 100 / amount)) + "%";
						zxl1 = String.valueOf(df.format(num1 * 100 / amount)) + "%";
						zxl2 = String.valueOf(df.format(num2 * 100 / amount)) + "%";
					}
					//环比
					String hb0 = "-";
					String hb1 = "-";
					String hb2 = "-";
					if (num0 != 0) {
						hb1 = String.valueOf(df.format(num1 * 100 / num0)) + "%";
					}
					if (num1 != 0) {
						hb2 = String.valueOf(df.format(num2 * 100 / num1)) + "%";
					}
					//16年累值
					HSSFCell cell4 = hssfRow.createCell(4);
					cell4.setCellValue(String.valueOf(df.format(num0)));
					//16环比
					HSSFCell cell5 = hssfRow.createCell(5);
					cell5.setCellValue(hb0);
					//16执行率
					HSSFCell cell6 = hssfRow.createCell(6);
					cell6.setCellValue(zxl0);
					//17年累值
					HSSFCell cell7 = hssfRow.createCell(7);
					cell7.setCellValue(String.valueOf(df.format(num1)));
					//17环比
					HSSFCell cell8 = hssfRow.createCell(8);
					cell8.setCellValue(hb1);
					//17执行率
					HSSFCell cell9 = hssfRow.createCell(9);
					cell9.setCellValue(zxl1);
					//18年累值
					HSSFCell cell10 = hssfRow.createCell(10);
					cell10.setCellValue(String.valueOf(df.format(num2)));
					//18环比
					HSSFCell cell11 = hssfRow.createCell(11);
					cell11.setCellValue(hb2);
					//18执行率
					HSSFCell cell12 = hssfRow.createCell(12);
					cell12.setCellValue(zxl2);
					//sheet0格式
					cell0.setCellStyle(row.getCell(0).getCellStyle());
					cell1.setCellStyle(row.getCell(1).getCellStyle());
					cell2.setCellStyle(row.getCell(2).getCellStyle());
					cell3.setCellStyle(row.getCell(3).getCellStyle());
					cell4.setCellStyle(row.getCell(4).getCellStyle());
					cell5.setCellStyle(row.getCell(5).getCellStyle());
					cell6.setCellStyle(row.getCell(6).getCellStyle());
					cell7.setCellStyle(row.getCell(7).getCellStyle());
					cell8.setCellStyle(row.getCell(8).getCellStyle());
					cell9.setCellStyle(row.getCell(9).getCellStyle());
					cell10.setCellStyle(row.getCell(10).getCellStyle());
					cell11.setCellStyle(row.getCell(11).getCellStyle());
					cell12.setCellStyle(row.getCell(12).getCellStyle());
				}
			}
			//sheet月报数据
			if (monthList !=null && monthList.size() > 0) {
				HSSFRow row = sheet1.getRow(3);//格式行
				Integer rowNum = row.getRowNum();//起始行
				for (int i = 0 ; i < monthList.size(); i++) {
					HSSFRow hssfRow = sheet1.createRow(3+i);
					hssfRow.setHeight(row.getHeight());
					BudgetData2 data = monthList.get(i);
					//序号
					HSSFCell cell0 = hssfRow.createCell(0);
					cell0.setCellValue(i + 1);
					//名称
					HSSFCell cell1 = hssfRow.createCell(1);
					cell1.setCellValue(data.getIndexName());
					//部门
					HSSFCell cell2 = hssfRow.createCell(2);
					cell2.setCellValue(data.getDepartName());
					//额度
					HSSFCell cell3 = hssfRow.createCell(3);
					cell3.setCellValue(data.getIndexAmount());
					//月累值
					double num1 = Double.valueOf(data.getNum1())/10000;
					double num2 = Double.valueOf(data.getNum2())/10000;
					double num3 = Double.valueOf(data.getNum3())/10000;
					double num4 = Double.valueOf(data.getNum4())/10000;
					double num5 = Double.valueOf(data.getNum5())/10000;
					double num6 = Double.valueOf(data.getNum6())/10000;
					double num7 = Double.valueOf(data.getNum7())/10000;
					double num8 = Double.valueOf(data.getNum8())/10000;
					double num9 = Double.valueOf(data.getNum9())/10000;
					double num10 = Double.valueOf(data.getNum10())/10000;
					double num11 = Double.valueOf(data.getNum11())/10000;
					double num12 = Double.valueOf(data.getNum12())/10000;
					//月同比额度
					double tb1 = Double.valueOf(data.getLastNum1())/10000; 
					double tb2 = Double.valueOf(data.getLastNum2())/10000; 
					double tb3 = Double.valueOf(data.getLastNum3())/10000; 
					double tb4 = Double.valueOf(data.getLastNum4())/10000; 
					double tb5 = Double.valueOf(data.getLastNum5())/10000; 
					double tb6 = Double.valueOf(data.getLastNum6())/10000; 
					double tb7 = Double.valueOf(data.getLastNum7())/10000; 
					double tb8 = Double.valueOf(data.getLastNum8())/10000; 
					double tb9 = Double.valueOf(data.getLastNum9())/10000; 
					double tb10 = Double.valueOf(data.getLastNum10())/10000; 
					double tb11 = Double.valueOf(data.getLastNum11())/10000; 
					double tb12 = Double.valueOf(data.getLastNum12())/10000; 
					//放入数据
					HSSFCell cell4 = hssfRow.createCell(4);//1月
					HSSFCell cell5 = hssfRow.createCell(5);
					HSSFCell cell6 = hssfRow.createCell(6);//2
					HSSFCell cell7 = hssfRow.createCell(7);
					HSSFCell cell8 = hssfRow.createCell(8);//3
					HSSFCell cell9 = hssfRow.createCell(9);
					HSSFCell cell10 = hssfRow.createCell(10);//4
					HSSFCell cell11 = hssfRow.createCell(11);
					HSSFCell cell12 = hssfRow.createCell(12);//5
					HSSFCell cell13 = hssfRow.createCell(13);
					HSSFCell cell14 = hssfRow.createCell(14);//6
					HSSFCell cell15 = hssfRow.createCell(15);
					HSSFCell cell16 = hssfRow.createCell(16);//7
					HSSFCell cell17 = hssfRow.createCell(17);
					HSSFCell cell18 = hssfRow.createCell(18);//8
					HSSFCell cell19 = hssfRow.createCell(19);
					HSSFCell cell20 = hssfRow.createCell(20);//9
					HSSFCell cell21 = hssfRow.createCell(21);
					HSSFCell cell22 = hssfRow.createCell(22);//10
					HSSFCell cell23 = hssfRow.createCell(23);
					HSSFCell cell24 = hssfRow.createCell(24);//11
					HSSFCell cell25 = hssfRow.createCell(25);
					HSSFCell cell26 = hssfRow.createCell(26);//12
					HSSFCell cell27 = hssfRow.createCell(27);
					cell4.setCellValue(num1);
					cell5.setCellValue(tb1);
					cell6.setCellValue(num2);
					cell7.setCellValue(tb2);
					cell8.setCellValue(num3);
					cell9.setCellValue(tb3);
					cell10.setCellValue(num4);
					cell11.setCellValue(tb4);
					cell12.setCellValue(num5);
					cell13.setCellValue(tb5);
					cell14.setCellValue(num6);
					cell15.setCellValue(tb6);
					cell16.setCellValue(num7);
					cell17.setCellValue(tb7);
					cell18.setCellValue(num8);
					cell19.setCellValue(tb8);
					cell20.setCellValue(num9);
					cell21.setCellValue(tb9);
					cell22.setCellValue(num10);
					cell23.setCellValue(tb10);
					cell24.setCellValue(num11);
					cell25.setCellValue(tb11);
					cell26.setCellValue(num12);
					cell27.setCellValue(tb12);
					//sheet1格式
					cell1.setCellStyle(row.getCell(1).getCellStyle());
					cell2.setCellStyle(row.getCell(2).getCellStyle());
					cell3.setCellStyle(row.getCell(3).getCellStyle());
					cell4.setCellStyle(row.getCell(4).getCellStyle());
					cell5.setCellStyle(row.getCell(5).getCellStyle());
					cell6.setCellStyle(row.getCell(6).getCellStyle());
					cell7.setCellStyle(row.getCell(7).getCellStyle());
					cell8.setCellStyle(row.getCell(8).getCellStyle());
					cell9.setCellStyle(row.getCell(9).getCellStyle());
					cell10.setCellStyle(row.getCell(10).getCellStyle());
					cell11.setCellStyle(row.getCell(11).getCellStyle());
					cell12.setCellStyle(row.getCell(12).getCellStyle());
					cell13.setCellStyle(row.getCell(13).getCellStyle());
					cell14.setCellStyle(row.getCell(14).getCellStyle());
					cell15.setCellStyle(row.getCell(15).getCellStyle());
					cell16.setCellStyle(row.getCell(16).getCellStyle());
					cell17.setCellStyle(row.getCell(17).getCellStyle());
					cell18.setCellStyle(row.getCell(18).getCellStyle());
					cell19.setCellStyle(row.getCell(19).getCellStyle());
					cell20.setCellStyle(row.getCell(20).getCellStyle());
					cell21.setCellStyle(row.getCell(21).getCellStyle());
					cell22.setCellStyle(row.getCell(22).getCellStyle());
					cell23.setCellStyle(row.getCell(23).getCellStyle());
					cell24.setCellStyle(row.getCell(24).getCellStyle());
					cell25.setCellStyle(row.getCell(25).getCellStyle());
					cell26.setCellStyle(row.getCell(26).getCellStyle());
					cell27.setCellStyle(row.getCell(27).getCellStyle());
				}
			}
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
	public List<Object[]> sjfxList( List<Object[]> departEconomicList,  List<Depart> departList,  List<Economic> economicList) {
		List<Object[]> list=new ArrayList<Object[]>();
		//总金额
		Double sumAmount=0.00;
		//首行列合计
		Object [] firstObj=new Object[economicList.size()+8];
		firstObj[2]="合计";
		//循环所有部门
		for (int i = 0; i < departList.size(); i++) {
			Double sumColAmount=0.00;
			//经济分类小计
			Double sum301=0.00;
			Double sum302=0.00;
			Double sum303=0.00;
			Double sum310=0.00;
			Object [] obj=new Object[economicList.size()+8];
			//序号
			obj[0]=i+1;	
			//部门
			String deptId1=departList.get(i).getId();	
			//部门编码
			obj[1]=departList.get(i).getCode();
			//部门名称
			obj[2]=departList.get(i).getName();
			
			//循环所有的经济科目
			for (int j = 0; j < economicList.size(); j++) {
				//经济科目编码
				String subCode1=economicList.get(j).getCode();	
				
				//循环查到的所有数据
				for (int y = 0; y < departEconomicList.size(); y++) {
					String deptId2=(String) departEconomicList.get(y)[0];
					String subCode2=(String) departEconomicList.get(y)[1];
					Double amount=(Double) departEconomicList.get(y)[2];
					//科目编码是否一致
					if(subCode1.equals(subCode2)){
						String code=subCode2.substring(0, 3);
						Double d=(Double) firstObj[j+8];
						if(d==null){
							d=0.00;
						}
						if(deptId1.equals(deptId2)){
							//计算总金额
							sumAmount=MatheUtil.add(sumAmount,amount);
							firstObj[j+8]=MatheUtil.add(d, amount);
							obj[j+8]=amount;
							sumColAmount=MatheUtil.add(sumColAmount, amount);
							if("301".equals(code)){
								sum301=MatheUtil.add(sum301, amount);
								
								Double f301=(Double) firstObj[4];
								if(f301==null){
									f301=0.00;
								}
								firstObj[4]=MatheUtil.add(f301, amount);
							}else if("302".equals(code)){
								sum302=MatheUtil.add(sum302, amount);
								
								Double f302=(Double) firstObj[5];
								if(f302==null){
									f302=0.00;
								}
								firstObj[5]=MatheUtil.add(f302, amount);
							}else if("303".equals(code)){
								sum303=MatheUtil.add(sum303, amount);
								
								Double f303=(Double) firstObj[6];
								if(f303==null){
									f303=0.00;
								}
								firstObj[6]=MatheUtil.add(f303, amount);
							}else if("310".equals(code)){
								sum310=MatheUtil.add(sum310, amount);
								
								Double f310=(Double) firstObj[7];
								if(f310==null){
									f310=0.00;
								}
								firstObj[7]=MatheUtil.add(f310, amount);
							}
						}
					}
				}
			}
			obj[3]=sumColAmount;
			obj[4]=sum301;
			obj[5]=sum302;
			obj[6]=sum303;
			obj[7]=sum310;
			list.add(obj);
		}
		
		firstObj[3]=sumAmount;
		list.add(0, firstObj);
		return list;
	}
	
	@Override
	public List<Object[]> sjfxExecuteList( List<Object[]> departEconomicList,  List<Depart> departList,  List<Economic> economicList) {
		List<Object[]> list=new ArrayList<Object[]>();
		//总金额
		Double sumAmount=0.00;
		//总执行率
		Double totalAmount=0.00;
		//首行列合计
		Object [] firstObj=new Object[economicList.size()+9];
		firstObj[2]="合计";
		firstObj[3]="执行率";
		//循环所有部门
		for (int i = 0; i < departList.size(); i++) {
			Double sumColAmount=0.00;
			Double sumAppliAmount = 0.00;
			//经济分类小计
			Double sum301=0.00;
			Double sum302=0.00;
			Double sum303=0.00;
			Double sum310=0.00;
			Object [] obj=new Object[economicList.size()+9];
			//序号
			obj[0]=i+1;	
			//部门
			String deptId1=departList.get(i).getId();	
			//部门编码
			obj[1]=departList.get(i).getCode();
			//部门名称
			obj[2]=departList.get(i).getName();
			
			//循环所有的经济科目
			for (int j = 0; j < economicList.size(); j++) {
				//经济科目编码
				String subCode1=economicList.get(j).getCode();	
				
				//循环查到的所有数据
				for (int y = 0; y < departEconomicList.size(); y++) {
					String deptId2=(String) departEconomicList.get(y)[0];
					String subCode2=(String) departEconomicList.get(y)[1];
					Double amount=(Double) departEconomicList.get(y)[2];
					Double appliAmount = (Double) departEconomicList.get(y)[3];
					//科目编码是否一致
					if(subCode1.equals(subCode2)){
						String code=subCode2.substring(0, 3);
						Double d=(Double) firstObj[j+9];
						if(d==null){
							d=0.00;
						}
						if(deptId1.equals(deptId2)){
							//计算总金额
							sumAmount=MatheUtil.add(sumAmount,amount);
							totalAmount=MatheUtil.add(totalAmount, appliAmount);
							firstObj[j+9]=MatheUtil.add(d, amount);
							obj[j+9]=amount;
							sumColAmount=MatheUtil.add(sumColAmount, amount);
							sumAppliAmount = MatheUtil.add(sumAppliAmount, appliAmount);
							if("301".equals(code)){
								sum301=MatheUtil.add(sum301, amount);
								
								Double f301=(Double) firstObj[5];
								if(f301==null){
									f301=0.00;
								}
								firstObj[5]=MatheUtil.add(f301, amount);
							}else if("302".equals(code)){
								sum302=MatheUtil.add(sum302, amount);
								
								Double f302=(Double) firstObj[6];
								if(f302==null){
									f302=0.00;
								}
								firstObj[6]=MatheUtil.add(f302, amount);
							}else if("303".equals(code)){
								sum303=MatheUtil.add(sum303, amount);
								
								Double f303=(Double) firstObj[7];
								if(f303==null){
									f303=0.00;
								}
								firstObj[7]=MatheUtil.add(f303, amount);
							}else if("310".equals(code)){
								sum310=MatheUtil.add(sum310, amount);
								
								Double f310=(Double) firstObj[8];
								if(f310==null){
									f310=0.00;
								}
								firstObj[8]=MatheUtil.add(f310, amount);
							}
						}
					}
				}
			}
			obj[3]=sumColAmount;
			if (sumAppliAmount == 0.00) {
				obj[4]="0.0%";
			} else {
				obj[4]=MatheUtil.div(sumColAmount, sumAppliAmount, 2) * 100 + "%";
			}
			obj[5]=sum301;
			obj[6]=sum302;
			obj[7]=sum303;
			obj[8]=sum310;
			list.add(obj);
		}
		
		firstObj[3]=sumAmount;
		if (totalAmount == 0.00) {
			firstObj[4]="0.0%";
		} else {
			firstObj[4]=MatheUtil.div(sumAmount, totalAmount, 2) * 100 + "%";
		}
		list.add(0, firstObj);
		return list;
	}
	
	@Override
	public List<Object[]> sjfxAllList( List<Object[]> departEconomicList,  List<Depart> departList,  List<String> economicAllList) {
		List<Object[]> list=new ArrayList<Object[]>();
		//总金额
		Double sumAmount=0.00;
		//首行列合计
		Object [] firstObj=new Object[economicAllList.size()+23];
		firstObj[2]="合计";
		//循环所有部门
		for (int i = 0; i < departList.size(); i++) {
			//一上、一下、二上、二下合计
			Double sumColAmountYs=0.00;
			Double sumColAmountYx=0.00;
			Double sumColAmountEs=0.00;
			Double sumColAmountEx=0.00;
			//经济分类小计（一上、一下、二上、二下）
			Double sum301Ys=0.00;
			Double sum301Yx=0.00;
			Double sum301Es=0.00;
			Double sum301Ex=0.00;
			Double sum302Ys=0.00;
			Double sum302Yx=0.00;
			Double sum302Es=0.00;
			Double sum302Ex=0.00;
			Double sum303Ys=0.00;
			Double sum303Yx=0.00;
			Double sum303Es=0.00;
			Double sum303Ex=0.00;
			Double sum310Ys=0.00;
			Double sum310Yx=0.00;
			Double sum310Es=0.00;
			Double sum310Ex=0.00;
			Object [] obj=new Object[economicAllList.size()+23];
			//序号
			obj[0]=i+1;	
			//部门
			String deptId1=departList.get(i).getId();	
			//部门编码
			obj[1]=departList.get(i).getCode();
			//部门名称
			obj[2]=departList.get(i).getName();
			
			//循环所有的经济科目
			for (int j = 0; j < economicAllList.size(); j++) {
				//经济科目编码
				String subCode1=economicAllList.get(j);	
				
				//循环查到的所有数据
				for (int y = 0; y < departEconomicList.size(); y++) {
					String deptId2=(String) departEconomicList.get(y)[0];
					String subCode2=(String) departEconomicList.get(y)[1];
					Double amount=(Double) departEconomicList.get(y)[2];
					String anaType = String.valueOf((int) departEconomicList.get(y)[3]);
					if ("1".equals(anaType)) {
						anaType = "ys";
					} else if ("3".equals(anaType)) {
						anaType = "yx";
					} else if ("4".equals(anaType)) {
						anaType = "es";
					} else if ("5".equals(anaType)) {
						anaType = "ex";
					}
					//科目编码是否一致
					if(subCode1.equals(anaType + subCode2)){
						String code=subCode2.substring(0, 3);
						Double d=(Double) firstObj[j+23];
						if(d==null){
							d=0.00;
						}
						if(deptId1.equals(deptId2)){
							//计算总金额
							sumAmount=MatheUtil.add(sumAmount,amount);
							firstObj[j+23]=MatheUtil.add(d, amount);
							obj[j+23]=amount;
							if ("ys".equals(anaType)) {
								sumColAmountYs=MatheUtil.add(sumColAmountYs, amount);
							}
							if ("yx".equals(anaType)) {
								sumColAmountYx=MatheUtil.add(sumColAmountYx, amount);							
							}
							if ("es".equals(anaType)) {
								sumColAmountEs=MatheUtil.add(sumColAmountEs, amount);
							}
							if ("ex".equals(anaType)) {
								sumColAmountEx=MatheUtil.add(sumColAmountEx, amount);
							}
							if("301".equals(code)){
								if ("ys".equals(anaType)) {
									sum301Ys=MatheUtil.add(sum301Ys, amount);
									
									Double f301=(Double) firstObj[7];
									if(f301==null){
										f301=0.00;
									}
									firstObj[7]=MatheUtil.add(f301, amount);
								}
								if ("yx".equals(anaType)) {
									sum301Yx=MatheUtil.add(sum301Yx, amount);
									
									Double f301=(Double) firstObj[8];
									if(f301==null){
										f301=0.00;
									}
									firstObj[8]=MatheUtil.add(f301, amount);
								}
								if ("es".equals(anaType)) {
									sum301Es=MatheUtil.add(sum301Es, amount);
									
									Double f301=(Double) firstObj[9];
									if(f301==null){
										f301=0.00;
									}
									firstObj[9]=MatheUtil.add(f301, amount);
								}
								if ("ex".equals(anaType)) {
									sum301Ex=MatheUtil.add(sum301Ex, amount);
									
									Double f301=(Double) firstObj[10];
									if(f301==null){
										f301=0.00;
									}
									firstObj[10]=MatheUtil.add(f301, amount);
								}
							}else if("302".equals(code)){
								if ("ys".equals(anaType)) {
									sum302Ys=MatheUtil.add(sum302Ys, amount);
									
									Double f302=(Double) firstObj[11];
									if(f302==null){
										f302=0.00;
									}
									firstObj[11]=MatheUtil.add(f302, amount);
								}
								if ("yx".equals(anaType)) {
									sum302Yx=MatheUtil.add(sum302Yx, amount);
									
									Double f302=(Double) firstObj[12];
									if(f302==null){
										f302=0.00;
									}
									firstObj[12]=MatheUtil.add(f302, amount);
								}
								if ("es".equals(anaType)) {
									sum302Es=MatheUtil.add(sum302Es, amount);
									
									Double f302=(Double) firstObj[13];
									if(f302==null){
										f302=0.00;
									}
									firstObj[13]=MatheUtil.add(f302, amount);
								}
								if ("ex".equals(anaType)) {
									sum302Ex=MatheUtil.add(sum302Ex, amount);
									
									Double f302=(Double) firstObj[14];
									if(f302==null){
										f302=0.00;
									}
									firstObj[14]=MatheUtil.add(f302, amount);
								}
							}else if("303".equals(code)){
								if ("ys".equals(anaType)) {
									sum303Ys=MatheUtil.add(sum303Ys, amount);
									
									Double f303=(Double) firstObj[15];
									if(f303==null){
										f303=0.00;
									}
									firstObj[15]=MatheUtil.add(f303, amount);
								}
								if ("yx".equals(anaType)) {
									sum303Yx=MatheUtil.add(sum303Yx, amount);
									
									Double f303=(Double) firstObj[16];
									if(f303==null){
										f303=0.00;
									}
									firstObj[16]=MatheUtil.add(f303, amount);
								}
								if ("es".equals(anaType)) {
									sum303Es=MatheUtil.add(sum303Es, amount);
									
									Double f303=(Double) firstObj[17];
									if(f303==null){
										f303=0.00;
									}
									firstObj[17]=MatheUtil.add(f303, amount);
								}
								if ("ex".equals(anaType)) {
									sum303Ex=MatheUtil.add(sum303Ex, amount);
									
									Double f303=(Double) firstObj[18];
									if(f303==null){
										f303=0.00;
									}
									firstObj[18]=MatheUtil.add(f303, amount);
								}
							}else if("310".equals(code)){
								if ("ys".equals(anaType)) {
									sum310Ys=MatheUtil.add(sum310Ys, amount);
									
									Double f310=(Double) firstObj[19];
									if(f310==null){
										f310=0.00;
									}
									firstObj[19]=MatheUtil.add(f310, amount);
								}
								if ("yx".equals(anaType)) {
									sum310Yx=MatheUtil.add(sum310Yx, amount);
									
									Double f310=(Double) firstObj[20];
									if(f310==null){
										f310=0.00;
									}
									firstObj[20]=MatheUtil.add(f310, amount);
								}
								if ("es".equals(anaType)) {
									sum310Es=MatheUtil.add(sum310Es, amount);
									
									Double f310=(Double) firstObj[21];
									if(f310==null){
										f310=0.00;
									}
									firstObj[21]=MatheUtil.add(f310, amount);
								}
								if ("ex".equals(anaType)) {
									sum310Ex=MatheUtil.add(sum310Ex, amount);
									
									Double f310=(Double) firstObj[22];
									if(f310==null){
										f310=0.00;
									}
									firstObj[22]=MatheUtil.add(f310, amount);
								}
							}
						}
					}
				}
			}
			obj[3]=sumColAmountYs;
			obj[4]=sumColAmountYx;
			obj[5]=sumColAmountEs;
			obj[6]=sumColAmountEx;
			
			obj[7]=sum301Ys;
			obj[8]=sum301Yx;
			obj[9]=sum301Es;
			obj[10]=sum301Ex;
			
			obj[11]=sum302Ys;
			obj[12]=sum302Yx;
			obj[13]=sum302Es;
			obj[14]=sum302Ex;
			
			obj[15]=sum303Ys;
			obj[16]=sum303Yx;
			obj[17]=sum303Es;
			obj[18]=sum303Ex;
			
			obj[19]=sum310Ys;
			obj[20]=sum310Yx;
			obj[21]=sum310Es;
			obj[22]=sum310Ex;
			list.add(obj);
		}
		
		firstObj[3]=0.00;
		list.add(0, firstObj);
		return list;
	}
	
	public Map<Integer,List<Economic>> departEconomicListToMap(List<Object[]> departEconomicList){
		Map<Integer,List<Economic>> map=new HashMap<Integer,List<Economic>>();
		for(Object[] objects:departEconomicList){
			if(map.get(objects[0])==null){
				List<Economic> list=new ArrayList<Economic>();
				
				
				
			}
		}
		
		
		return map;
	}

	@Override
	public List<Object[]> twoReport(List<Object[]> data,List<Object[]> deptList, List<Economic> economicList,List<ProMgrLevel2> typeList,String deptArr) {
		List<Object[]> list=new ArrayList<Object[]>();
		//总金额
		Double sumAmount1=0.00;
		//合计总额
		Double sumAmount2=0.00;
		//小计总额
		Double sumAmount3=0.00;
		//首行列总计
		Object [] firstObj=new Object[economicList.size()+10];
		firstObj[3]="总计";
		
		//合计
		Object [] expendObj=new Object[economicList.size()+10];
		//基本/项目支出 合计 判断状态
		Boolean isFlag=true;
		int num=0;	//当前数据下标   num + count list插入了count行就  +count
		
		//小计
		Object [] subTotalObj=new Object[economicList.size()+10];
		//基本支出小计 判断状态
		Boolean isFlag2=true;
		//项目支出小计 判断状态
		int isFlag3=4001;	//默认财政项目
		int num2=0;//当前数据下标   num2 + count list插入了count行就  +count
		
		int count=0;
		//循环所有项目类型数据
		for (int i = 0; i < typeList.size(); i++) {
			//行总计金额
			Double sumColAmount=0.00;
			//经济分类小计
			Double sum301=0.00;
			Double sum302=0.00;
			Double sum303=0.00;
			Double sum310=0.00;
			Object [] obj=new Object[economicList.size()+10];
			//序号
			obj[0]=i+1;	
			//项目类型1
			String st=typeList.get(i).getPml().getfLevCode1();	//XD-01:经常性支出项目（基本支出）
			//项目类型2
			String pType1=typeList.get(i).getfProType();
			if("XD-01".equals(st)){
				if(isFlag){
					expendObj[1]="基本支出";
					expendObj[2]="合计";
					num=i;
					isFlag=false;
				}
				st="0";	
				obj[1]="基本支出";	
				if("2001".equals(pType1) || "2002".equals(pType1)){
					obj[2]="日常公用";
					if(isFlag2){
						subTotalObj[1]="基本支出";
						subTotalObj[2]="日常公用";
						subTotalObj[3]="小计";
						num2=i;
						count++;
						isFlag2=false;
					}
				}else if("2003".equals(pType1) || "2004".equals(pType1)|| "2005".equals(pType1) || "2006".equals(pType1)){
					obj[2]="运行保障";
					if(!isFlag2){
						subTotalObj[5]=sumAmount3;
						list.add(num2, subTotalObj);
						subTotalObj=new Object[economicList.size()+10];
						num2=i+count;
						count++;
						isFlag2=true;
						subTotalObj[1]="基本支出";
						subTotalObj[2]="运行保障";
						subTotalObj[3]="小计";
						sumAmount3=0.00;
					}
				}else if("2007".equals(pType1)){
					obj[2]="学生经费";
					if(isFlag2){
						subTotalObj[5]=sumAmount3;
						list.add(num2, subTotalObj);
						subTotalObj=new Object[economicList.size()+10];
						num2=i+count;
						count++;
						isFlag2=false;
						subTotalObj[1]="基本支出";
						subTotalObj[2]="学生经费";
						subTotalObj[3]="小计";
						sumAmount3=0.00;
					}
				}else{
					obj[2]="人员经费";
					if(!isFlag2){
						subTotalObj[5]=sumAmount3;
						list.add(num2, subTotalObj);
						
						subTotalObj=new Object[economicList.size()+10];
						num2=i+count;//
						count++;
						isFlag2=true;
						subTotalObj[1]="基本支出";
						subTotalObj[2]="人员经费";
						subTotalObj[3]="小计";
						sumAmount3=0.00;
					}
				}
			}else{
				if(!isFlag){
					//基本支出合计
					expendObj[5]=sumAmount2;
					list.add(num, expendObj);
					expendObj=new Object[economicList.size()+10];
					num=i+count;
					count++;
					isFlag=true;
					expendObj[1]="项目支出";
					expendObj[2]="合计";
					sumAmount2=0.00;
					
					subTotalObj[5]=sumAmount3;
					list.add(num2+1, subTotalObj);
					num2=i+count;
					count++;
					sumAmount3=0.00;
				}
				obj[1]="项目支出";
				st="1";	
				pType1=typeList.get(i).getfLevCode2();
				if("4001".equals(pType1)){
					obj[2]="财政项目";
					
					if(isFlag3==4001){
						subTotalObj=new Object[economicList.size()+10];
						isFlag3=4002;
						subTotalObj[1]="项目支出";
						subTotalObj[2]="财政项目";
						subTotalObj[3]="小计";
						sumAmount3=0.00;
					}
				}else if("4002".equals(pType1)){
					obj[2]="横向项目";
					if(isFlag3==4002){
						subTotalObj[5]=sumAmount3;
						list.add(num2, subTotalObj);
						
						subTotalObj=new Object[economicList.size()+10];
						num2=i+count;//
						count++;
						isFlag3=4003;
						subTotalObj[1]="项目支出";
						subTotalObj[2]="横向项目";
						subTotalObj[3]="小计";
						sumAmount3=0.00;
					}else if(isFlag3==4001){
						subTotalObj=new Object[economicList.size()+10];
						isFlag3=4003;
						subTotalObj[1]="项目支出";
						subTotalObj[2]="横向项目";
						subTotalObj[3]="小计";
						sumAmount3=0.00;
					}
				}else if("4003".equals(pType1)){
					obj[2]="校级分类";
					if(isFlag3==4003 || isFlag3==4002){
						subTotalObj[5]=sumAmount3;
						list.add(num2, subTotalObj);
						
						subTotalObj=new Object[economicList.size()+10];
						num2=i+count;//
						count++;
						isFlag3=-1;	//下次不执行判断（不在追加小计）
						subTotalObj[1]="项目支出";
						subTotalObj[2]="校级分类";
						subTotalObj[3]="小计";
						sumAmount3=0.00;
					}else if(isFlag3==4001){
						subTotalObj=new Object[economicList.size()+10];
						isFlag3=-1;//下次不执行判断（不在追加小计）
						subTotalObj[1]="项目支出";
						subTotalObj[2]="校级分类";
						subTotalObj[3]="小计";
						sumAmount3=0.00;
					}
				}
			}
			//项目名称
			obj[3]=typeList.get(i).getfLevName2();
			String levName1=typeList.get(i).getfLevName2();
			String levCode1=typeList.get(i).getfLevCode2();
			String proCode1=typeList.get(i).getFproCode();
			levCode1=typeList.get(i).getfLevCode2();
			//部门名称
			for (int j = 0; j < deptList.size(); j++) {
				//[0, 学生经费-奖助学金, 200704, 学生处]
				Integer tp=(Integer) deptList.get(j)[0];
				String tpCode=(String) deptList.get(j)[2];
				String tpName=(String) deptList.get(j)[1];
				if((st.equals(tp.toString()) && st.equals("0") && levCode1.equals(tpCode))||( st.equals("1")&& st.equals(tp.toString())&& levName1.equals(tpName))){
					//申报部门 
					obj[4]=deptList.get(j)[3];
				}
			}
			
			//循环所有的经济科目
			for (int j = 0; j < economicList.size(); j++) {
				//经济科目编码
				String subCode1=economicList.get(j).getCode();	
				//循环查到的所有数据
				for (int y = 0; y < data.size(); y++) {	//data:-----0	公用经费	2001	设备与安技处,财务处	30201	10001
					String levCode2=(String) data.get(y)[2];
					String levName2=(String) data.get(y)[1];
					String proCode2="";
					if(data.get(y).length>=7){
						proCode2 = (String) data.get(y)[6];
					}
					String subCode2=(String) data.get(y)[4];
					String code = "";
					if (!StringUtil.isEmpty(subCode2)) {
						code=subCode2.substring(0, 3);
					}
					//金额
					Double amount=(Double) data.get(y)[5];
						
					Integer st2=(Integer) data.get(y)[0];
					
					if((st.equals(st2.toString()) && st.equals("0") && levCode1.equals(levCode2))||( st.equals("1")&& st.equals(st2.toString())&& proCode1.equals(proCode2))){
						//科目编码是否一致
						if(subCode1.equals(subCode2)){
							//总计金额
							Double d1=(Double) firstObj[j+10];
							if(d1==null){
								d1=0.00;
							}
							//合计金额
							Double d2=(Double) expendObj[j+10];
							if(d2==null){
								d2=0.00;
							}
							//小计金额
							Double d3=(Double) subTotalObj[j+10];
							if(d3==null){
								d3=0.00;
							}
							/*if(1==st2){
								//项目支出 的 项目名称
								obj[3]=data.get(y)[1];
							}*/
							if("2001".equals(pType1) || "2002".equals(pType1)){
								if(StringUtil.isEmpty(deptArr)){
									obj[4]="所有部门";
								}
							}
							//计算金额
							sumAmount1=MatheUtil.add(sumAmount1,amount);
							sumAmount2=MatheUtil.add(sumAmount2,amount);
							sumAmount3=MatheUtil.add(sumAmount3,amount);
							firstObj[j+10]=MatheUtil.add(d1, amount);
							expendObj[j+10]=MatheUtil.add(d2, amount);
							subTotalObj[j+10]=MatheUtil.add(d3, amount);
							obj[j+10]=amount;
							sumColAmount=MatheUtil.add(sumColAmount, amount);
							if("301".equals(code)){
								sum301=MatheUtil.add(sum301, amount);
								//总计的经济分类
								Double f301=(Double) firstObj[6];
								if(f301==null){
									f301=0.00;
								}
								firstObj[6]=MatheUtil.add(f301, amount);
										
								//合计 的 经济分类
								Double e301=(Double) expendObj[6];
								if(e301==null){
									e301=0.00;
								}
								expendObj[6]=MatheUtil.add(e301, amount);
								//小计的 经济分类
								Double s301=(Double) subTotalObj[6];
								if(s301==null){
									s301=0.00;
								}
								subTotalObj[6]=MatheUtil.add(s301, amount);
							}else if("302".equals(code)){
								sum302=MatheUtil.add(sum302, amount);
								Double f302=(Double) firstObj[7];
								if(f302==null){
									f302=0.00;
								}
								firstObj[7]=MatheUtil.add(f302, amount);
								
								Double e302=(Double) expendObj[7];
								if(e302==null){
									e302=0.00;
								}
								expendObj[7]=MatheUtil.add(e302, amount);
								
								Double s302=(Double) subTotalObj[7];
								if(s302==null){
									s302=0.00;
								}
								subTotalObj[7]=MatheUtil.add(s302, amount);
							}else if("303".equals(code)){
								sum303=MatheUtil.add(sum303, amount);
								Double f303=(Double) firstObj[8];
								if(f303==null){
									f303=0.00;
								}
								firstObj[8]=MatheUtil.add(f303, amount);
								
								Double e303=(Double) expendObj[8];
								if(e303==null){
									e303=0.00;
								}
								expendObj[8]=MatheUtil.add(e303, amount);
								
								Double s303=(Double) subTotalObj[8];
								if(s303==null){
									s303=0.00;
								}
								subTotalObj[8]=MatheUtil.add(s303, amount);
							}else if("310".equals(code)){
								sum310=MatheUtil.add(sum310, amount);
								Double f310=(Double) firstObj[9];
								if(f310==null){
									f310=0.00;
								}
								firstObj[9]=MatheUtil.add(f310, amount);
								
								Double e310=(Double) expendObj[9];
								if(e310==null){
									e310=0.00;
								}
								expendObj[9]=MatheUtil.add(e310, amount);
								
								Double s310=(Double) subTotalObj[9];
								if(s310==null){
									s310=0.00;
								}
								subTotalObj[9]=MatheUtil.add(s310, amount);
							}
						}
						
					}
				}
			}
			obj[5]=sumColAmount;
			obj[6]=sum301;
			obj[7]=sum302;
			obj[8]=sum303;
			obj[9]=sum310;
			list.add(obj);
		}
		//没有项目支出
		if(!isFlag){
			//人员经费小计
			subTotalObj[5]=sumAmount3;
			list.add(num2, subTotalObj);
			//基本支出合计
			expendObj[5]=sumAmount2;
			list.add(num, expendObj);
		}else{
			//项目支出合计
			expendObj[5]=sumAmount2;
			list.add(num+1, expendObj);
			//小计
			subTotalObj[5]=sumAmount3;
			list.add(num2+1, subTotalObj);
		}
		firstObj[5]=sumAmount1;
		list.add(0, firstObj);
		return list;
	}

	@Override
	public List<Object[]> threeReport(String year,String deptArr,String sign) {
		try {
			String sql = "";
			if("0".equals(sign)){
				 sql = "SELECT COALESCE( b.DEPARTCODE, '学院总计',0 ), b.DEPARTNAME,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_1 = 'XD-01' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 richengzhichu,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4003' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 xiaojixiangmu,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4003' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 + "
						+ "SUM( CASE WHEN a.F_LEV_CODE_1 = 'XD-01' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 jibenheji,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4002' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 hengxiang,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4001' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 caizheng,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4002' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 + "
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4001' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 xiangmuheji,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4002' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 + "
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4001' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 + "
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4003' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 + "
						+ "SUM( CASE WHEN a.F_LEV_CODE_1 = 'XD-01' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 zhichuzongji" 
						+ " FROM t_pro_basic_info a LEFT JOIN sys_depart b ON a.F_PRO_APPLI_DEPART_ID = b.PID  WHERE (a.F_STAUTS <> 99 or a.F_STAUTS ='' or a.F_STAUTS is null) and a.F_EXPORT_STAUTS = 1 ";
			}else{
				 sql = "SELECT COALESCE( b.DEPARTCODE, '学院总计',0 ), b.DEPARTNAME,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_1 = 'XD-01' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 richengzhichu,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4003' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 xiaojixiangmu,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4003' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 + "
						+ "SUM( CASE WHEN a.F_LEV_CODE_1 = 'XD-01' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 jibenheji,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4002' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 hengxiang,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4001' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 caizheng,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4002' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 + "
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4001' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 xiangmuheji,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4002' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 + "
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4001' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 + "
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4003' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 + "
						+ "SUM( CASE WHEN a.F_LEV_CODE_1 = 'XD-01' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 zhichuzongji" 
						+ " FROM t_pro_basic_info a LEFT JOIN sys_depart b ON a.F_PRO_APPLI_DEPART_ID = b.PID left join t_budget_index_mgr tbim on tbim.F_PRO_ID=a.F_PRO_ID  WHERE a.F_STAUTS <> 99 AND tbim.F_RELEASE_STAUTS=1 ";
			}
			if(StringUtil.isEmpty(year)){
				year = DateUtil.getCurrentYear();
			}
			if(!StringUtil.isEmpty(deptArr)&&deptArr!="-1"){
				sql+=" and b.PID="+deptArr;
			}
			sql+=" and a.F_START_YEAR_PLAN = '"+year+"'";
			sql+=" GROUP BY b.DEPARTCODE WITH ROLLUP ";
			
			Query query = getSession().createSQLQuery(sql);
			List<Object[]> list = query.list();
			List<Object[]> newList = findDepartCodeAndName(list,year);
			List<Object[]> newList2 = new ArrayList<Object[]>();//存所有的数据
			List<Object[]> newList3 = new ArrayList<Object[]>();//存合计数据
			for(int i=newList.size()-1;i>=0;i--){
				for (int j = list.size()-1; j >= 0; j--) {
					if(String.valueOf(newList.get(i)[0]).equals(String.valueOf(list.get(j)[0]))){
						newList2.add(list.get(j));
						newList.remove(newList.get(i));
						break;
					}
				}
			}
			newList2.addAll(newList);
			
			
			Collections.sort(newList2, new Comparator<Object[]>() {//使用Collections的sort方法，并且重写compare方法
				public int compare(Object[] o1, Object[] o2) {
						return Integer.valueOf((String) o1[0]) -Integer.valueOf((String) o2[0]) ;
				}
			});
			for(Object[] list2: list){
				if("学院总计".equals(list2[0].toString())){
					list2[1] = "";
					newList3.add(list2);
				}
			}
			newList2.addAll(newList3);
			return newList2;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Object[]> threeReportByType(String year,String deptArr,String sign, String analysisType,String dataType) {
		try {
			String sql = "";
			if("0".equals(sign)){
				 sql = "SELECT COALESCE( b.DEPARTCODE, '学院总计',0 ), b.DEPARTNAME,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_1 = 'XD-01' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 richengzhichu,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4003' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 xiaojixiangmu,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4003' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 + "
						+ "SUM( CASE WHEN a.F_LEV_CODE_1 = 'XD-01' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 jibenheji,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4002' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 hengxiang,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4001' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 caizheng,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4002' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 + "
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4001' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 xiangmuheji,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4002' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 + "
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4001' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 + "
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4003' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 + "
						+ "SUM( CASE WHEN a.F_LEV_CODE_1 = 'XD-01' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 zhichuzongji" ;
				 if(dataType.equals("1")){
					 sql=sql+ " FROM t_pro_basic_info a LEFT JOIN sys_depart b ON a.F_PRO_APPLI_DEPART_ID = b.PID  WHERE (a.F_STAUTS <> 99 or a.F_STAUTS ='' or a.F_STAUTS is null) ";
				 }else{
					 sql=sql+ " FROM t_pro_basic_info_analysis a LEFT JOIN sys_depart b ON a.F_PRO_APPLI_DEPART_ID = b.PID  WHERE (a.F_STAUTS <> 99 or a.F_STAUTS ='' or a.F_STAUTS is null) ";
				 }

			}else{
				 sql = "SELECT COALESCE( b.DEPARTCODE, '学院总计',0 ), b.DEPARTNAME,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_1 = 'XD-01' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 richengzhichu,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4003' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 xiaojixiangmu,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4003' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 + "
						+ "SUM( CASE WHEN a.F_LEV_CODE_1 = 'XD-01' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 jibenheji,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4002' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 hengxiang,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4001' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 caizheng,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4002' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 + "
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4001' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 xiangmuheji,"
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4002' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 + "
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4001' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 + "
						+ "SUM( CASE WHEN a.F_LEV_CODE_2 = '4003' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 + "
						+ "SUM( CASE WHEN a.F_LEV_CODE_1 = 'XD-01' THEN a.F_PRO_BUDGET_AMOUNT ELSE 0 END )*10000 zhichuzongji" 
						+ " FROM t_pro_basic_info_analysis a LEFT JOIN sys_depart b ON a.F_PRO_APPLI_DEPART_ID = b.PID left join t_budget_index_mgr tbim on tbim.F_PRO_ID=a.F_PRO_ID  WHERE a.F_STAUTS <> 99 AND tbim.F_RELEASE_STAUTS=1 ";
			}
			if(StringUtil.isEmpty(year)){
				year = DateUtil.getCurrentYear();
			}
			if(!StringUtil.isEmpty(deptArr)&&deptArr!="-1"){
				sql+=" and b.PID="+deptArr;
			}
			sql+=" and a.F_START_YEAR_PLAN = '"+year+"'";
			if (!StringUtils.isEmpty(analysisType)) {
				if(dataType.equals("1")){
					if(analysisType.equals("1")){
						sql=sql+" and  a.F_FLOW_STAUTS ='11' ";
					}else if(analysisType.equals("3")){
						sql=sql+" and  a.F_FLOW_STAUTS ='29' and a.F_EXT_4 ='11' and a.F_EXT_5 is null";
					}else if(analysisType.equals("3")){
						sql=sql+" and  a.F_FLOW_STAUTS ='31' ";
					}else{
						sql=sql+" and  a.F_FLOW_STAUTS ='39' and a.F_PRO_ID in (select F_PRO_ID from T_BUDGET_INDEX_MGR where F_RELEASE_STAUTS ='0') ";
					}
				}else{
					sql=sql+" and a.F_ANALYSIS_TYPE='"+analysisType+"'  ";
				}
			}
			sql+=" GROUP BY b.DEPARTCODE WITH ROLLUP ";
			
			Query query = getSession().createSQLQuery(sql);
			List<Object[]> list = query.list();
			List<Object[]> newList = findDepartCodeAndName(list,year);
			List<Object[]> newList2 = new ArrayList<Object[]>();//存所有的数据
			List<Object[]> newList3 = new ArrayList<Object[]>();//存合计数据
			for(int i=newList.size()-1;i>=0;i--){
				for (int j = list.size()-1; j >= 0; j--) {
					if(String.valueOf(newList.get(i)[0]).equals(String.valueOf(list.get(j)[0]))){
						newList2.add(list.get(j));
						newList.remove(newList.get(i));
						break;
					}
				}
			}
			newList2.addAll(newList);
			
			
			Collections.sort(newList2, new Comparator<Object[]>() {//使用Collections的sort方法，并且重写compare方法
				public int compare(Object[] o1, Object[] o2) {
						return Integer.valueOf((String) o1[0]) -Integer.valueOf((String) o2[0]) ;
				}
			});
			for(Object[] list2: list){
				if("学院总计".equals(list2[0].toString())){
					list2[1] = "";
					newList3.add(list2);
				}
			}
			newList2.addAll(newList3);
			return newList2;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	@Override
	public List<Object[]> findDepartCodeAndName(List<Object[]> data,String year) {
		String sql = "SELECT DEPARTCODE as code,DEPARTNAME as  name,0  as a,0 as  b,0  as c,0  as d,0  as e,0  as f,0 as  g FROM sys_depart where PUPDATER =1 and DEPARTCODE !='10000' ORDER BY code";
		Query query = getSession().createSQLQuery(sql);
		List<Object[]> list = query.list();
		return list;
	}

	@Override
	public List<Object[]> twoExecuteReport(List<Object[]> data, List<Object[]> deptList, List<Economic> economicList,
			List<ProMgrLevel2> typeList, String deptArr) {
		List<Object[]> list=new ArrayList<Object[]>();
		//总金额
		Double sumAmount1=0.00;
		//总申请金额
		Double totalAmount=0.00;
		//合计总额
		Double sumAmount2=0.00;
		//小计总额
		Double sumAmount3=0.00;
		//首行列总计
		Object [] firstObj=new Object[economicList.size()+11];
		firstObj[3]="总计";
		
		//合计
		Object [] expendObj=new Object[economicList.size()+11];
		//基本/项目支出 合计 判断状态
		Boolean isFlag=true;
		int num=0;	//当前数据下标   num + count list插入了count行就  +count
		
		//小计
		Object [] subTotalObj=new Object[economicList.size()+11];
		//基本支出小计 判断状态
		Boolean isFlag2=true;
		//项目支出小计 判断状态
		int isFlag3=4001;	//默认财政项目
		int num2=0;//当前数据下标   num2 + count list插入了count行就  +count
		
		int count=0;
		//循环所有项目类型数据
		for (int i = 0; i < typeList.size(); i++) {
			//行总计金额
			Double sumColAmount=0.00;
			//行申请总额
			Double colAppliAmount=0.00;
			//经济分类小计
			Double sum301=0.00;
			Double sum302=0.00;
			Double sum303=0.00;
			Double sum310=0.00;
			Object [] obj=new Object[economicList.size()+11];
			//序号
			obj[0]=i+1;	
			//项目类型1
			String st=typeList.get(i).getPml().getfLevCode1();	//XD-01:经常性支出项目（基本支出）
			//项目类型2
			String pType1=typeList.get(i).getfProType();
			if("XD-01".equals(st)){
				if(isFlag){
					expendObj[1]="基本支出";
					expendObj[2]="合计";
					num=i;
					isFlag=false;
				}
				st="0";	
				obj[1]="基本支出";	
				if("2001".equals(pType1) || "2002".equals(pType1)){
					obj[2]="日常公用";
					if(isFlag2){
						subTotalObj[1]="基本支出";
						subTotalObj[2]="日常公用";
						subTotalObj[3]="小计";
						num2=i;
						count++;
						isFlag2=false;
					}
				}else if("2003".equals(pType1) || "2004".equals(pType1)|| "2005".equals(pType1) || "2006".equals(pType1)){
					obj[2]="运行保障";
					if(!isFlag2){
						subTotalObj[5]=sumAmount3;
						list.add(num2, subTotalObj);
						subTotalObj=new Object[economicList.size()+11];
						num2=i+count;
						count++;
						isFlag2=true;
						subTotalObj[1]="基本支出";
						subTotalObj[2]="运行保障";
						subTotalObj[3]="小计";
						sumAmount3=0.00;
					}
				}else if("2007".equals(pType1)){
					obj[2]="学生经费";
					if(isFlag2){
						subTotalObj[5]=sumAmount3;
						list.add(num2, subTotalObj);
						subTotalObj=new Object[economicList.size()+11];
						num2=i+count;
						count++;
						isFlag2=false;
						subTotalObj[1]="基本支出";
						subTotalObj[2]="学生经费";
						subTotalObj[3]="小计";
						sumAmount3=0.00;
					}
				}else{
					obj[2]="人员经费";
					if(!isFlag2){
						subTotalObj[5]=sumAmount3;
						list.add(num2, subTotalObj);
						
						subTotalObj=new Object[economicList.size()+11];
						num2=i+count;//
						count++;
						isFlag2=true;
						subTotalObj[1]="基本支出";
						subTotalObj[2]="人员经费";
						subTotalObj[3]="小计";
						sumAmount3=0.00;
					}
				}
			}else{
				if(!isFlag){
					//基本支出合计
					expendObj[5]=sumAmount2;
					list.add(num, expendObj);
					expendObj=new Object[economicList.size()+11];
					num=i+count;
					count++;
					isFlag=true;
					expendObj[1]="项目支出";
					expendObj[2]="合计";
					sumAmount2=0.00;
					
					subTotalObj[5]=sumAmount3;
					list.add(num2+1, subTotalObj);
					num2=i+count;
					count++;
					sumAmount3=0.00;
				}
				obj[1]="项目支出";
				st="1";	
				pType1=typeList.get(i).getfLevCode2();
				if("4001".equals(pType1)){
					obj[2]="财政项目";
					
					if(isFlag3==4001){
						subTotalObj=new Object[economicList.size()+11];
						isFlag3=4002;
						subTotalObj[1]="项目支出";
						subTotalObj[2]="财政项目";
						subTotalObj[3]="小计";
						sumAmount3=0.00;
					}
				}else if("4002".equals(pType1)){
					obj[2]="横向项目";
					if(isFlag3==4002){
						subTotalObj[5]=sumAmount3;
						list.add(num2, subTotalObj);
						
						subTotalObj=new Object[economicList.size()+11];
						num2=i+count;//
						count++;
						isFlag3=4003;
						subTotalObj[1]="项目支出";
						subTotalObj[2]="横向项目";
						subTotalObj[3]="小计";
						sumAmount3=0.00;
					}else if(isFlag3==4001){
						subTotalObj=new Object[economicList.size()+11];
						isFlag3=4003;
						subTotalObj[1]="项目支出";
						subTotalObj[2]="横向项目";
						subTotalObj[3]="小计";
						sumAmount3=0.00;
					}
				}else if("4003".equals(pType1)){
					obj[2]="校级分类";
					if(isFlag3==4003 || isFlag3==4002){
						subTotalObj[5]=sumAmount3;
						list.add(num2, subTotalObj);
						
						subTotalObj=new Object[economicList.size()+11];
						num2=i+count;//
						count++;
						isFlag3=-1;	//下次不执行判断（不在追加小计）
						subTotalObj[1]="项目支出";
						subTotalObj[2]="校级分类";
						subTotalObj[3]="小计";
						sumAmount3=0.00;
					}else if(isFlag3==4001){
						subTotalObj=new Object[economicList.size()+11];
						isFlag3=-1;//下次不执行判断（不在追加小计）
						subTotalObj[1]="项目支出";
						subTotalObj[2]="校级分类";
						subTotalObj[3]="小计";
						sumAmount3=0.00;
					}
				}
			}
			//项目名称
			obj[3]=typeList.get(i).getfLevName2();
			String levName1=typeList.get(i).getfLevName2();
			String levCode1=typeList.get(i).getfLevCode2();levCode1=typeList.get(i).getfLevCode2();
			//部门名称
			for (int j = 0; j < deptList.size(); j++) {
				//[0, 学生经费-奖助学金, 200704, 学生处]
				Integer tp=(Integer) deptList.get(j)[0];
				String tpCode=(String) deptList.get(j)[2];
				String tpName=(String) deptList.get(j)[1];
				if((st.equals(tp.toString()) && st.equals("0") && levCode1.equals(tpCode))||( st.equals("1")&& st.equals(tp.toString())&& levName1.equals(tpName))){
					//申报部门 
					obj[4]=deptList.get(j)[3];
				}
			}
			
			//循环所有的经济科目
			for (int j = 0; j < economicList.size(); j++) {
				//经济科目编码
				String subCode1=economicList.get(j).getCode();	
				//循环查到的所有数据
				for (int y = 0; y < data.size(); y++) {	//data:-----0	公用经费	2001	设备与安技处,财务处	30201	10001
					String levCode2=(String) data.get(y)[2];
					String levName2=(String) data.get(y)[1];
					String subCode2=(String) data.get(y)[4];
					String code = "";
					if (!StringUtil.isEmpty(subCode2)) {
						code=subCode2.substring(0, 3);
					}
					//金额
					Double amount=(Double) data.get(y)[5];
					
					Double appliAmount=(Double) data.get(y)[6];
						
					Integer st2=(Integer) data.get(y)[0];
					
					if((st.equals(st2.toString()) && st.equals("0") && levCode1.equals(levCode2))||( st.equals("1")&& st.equals(st2.toString())&& levName1.equals(levName2))){
						//科目编码是否一致
						if(subCode1.equals(subCode2)){
							//总计金额
							Double d1=(Double) firstObj[j+11];
							if(d1==null){
								d1=0.00;
							}
							//合计金额
							Double d2=(Double) expendObj[j+11];
							if(d2==null){
								d2=0.00;
							}
							//小计金额
							Double d3=(Double) subTotalObj[j+11];
							if(d3==null){
								d3=0.00;
							}
							/*if(1==st2){
								//项目支出 的 项目名称
								obj[3]=data.get(y)[1];
							}*/
							if("2001".equals(pType1) || "2002".equals(pType1)){
								if(StringUtil.isEmpty(deptArr)){
									obj[4]="所有部门";
								}
							}
							//计算金额
							sumAmount1=MatheUtil.add(sumAmount1,amount);
							totalAmount=MatheUtil.add(totalAmount, appliAmount);
							sumAmount2=MatheUtil.add(sumAmount2,amount);
							sumAmount3=MatheUtil.add(sumAmount3,amount);
							firstObj[j+11]=MatheUtil.add(d1, amount);
							expendObj[j+11]=MatheUtil.add(d2, amount);
							subTotalObj[j+11]=MatheUtil.add(d3, amount);
							obj[j+11]=amount;
							sumColAmount=MatheUtil.add(sumColAmount, amount);
							colAppliAmount=MatheUtil.add(colAppliAmount, appliAmount);
							if("301".equals(code)){
								sum301=MatheUtil.add(sum301, amount);
								//总计的经济分类
								Double f301=(Double) firstObj[7];
								if(f301==null){
									f301=0.00;
								}
								firstObj[7]=MatheUtil.add(f301, amount);
										
								//合计 的 经济分类
								Double e301=(Double) expendObj[7];
								if(e301==null){
									e301=0.00;
								}
								expendObj[7]=MatheUtil.add(e301, amount);
								//小计的 经济分类
								Double s301=(Double) subTotalObj[7];
								if(s301==null){
									s301=0.00;
								}
								subTotalObj[7]=MatheUtil.add(s301, amount);
							}else if("302".equals(code)){
								sum302=MatheUtil.add(sum302, amount);
								Double f302=(Double) firstObj[8];
								if(f302==null){
									f302=0.00;
								}
								firstObj[8]=MatheUtil.add(f302, amount);
								
								Double e302=(Double) expendObj[8];
								if(e302==null){
									e302=0.00;
								}
								expendObj[8]=MatheUtil.add(e302, amount);
								
								Double s302=(Double) subTotalObj[8];
								if(s302==null){
									s302=0.00;
								}
								subTotalObj[8]=MatheUtil.add(s302, amount);
							}else if("303".equals(code)){
								sum303=MatheUtil.add(sum303, amount);
								Double f303=(Double) firstObj[9];
								if(f303==null){
									f303=0.00;
								}
								firstObj[9]=MatheUtil.add(f303, amount);
								
								Double e303=(Double) expendObj[9];
								if(e303==null){
									e303=0.00;
								}
								expendObj[9]=MatheUtil.add(e303, amount);
								
								Double s303=(Double) subTotalObj[9];
								if(s303==null){
									s303=0.00;
								}
								subTotalObj[9]=MatheUtil.add(s303, amount);
							}else if("310".equals(code)){
								sum310=MatheUtil.add(sum310, amount);
								Double f310=(Double) firstObj[10];
								if(f310==null){
									f310=0.00;
								}
								firstObj[10]=MatheUtil.add(f310, amount);
								
								Double e310=(Double) expendObj[10];
								if(e310==null){
									e310=0.00;
								}
								expendObj[10]=MatheUtil.add(e310, amount);
								
								Double s310=(Double) subTotalObj[10];
								if(s310==null){
									s310=0.00;
								}
								subTotalObj[10]=MatheUtil.add(s310, amount);
							}
						}
						
					}
				}
			}
			//需要改111
			obj[5]=sumColAmount;
			if (colAppliAmount == 0.00) {
				obj[6]="0.0%";
			} else {
				obj[6]=MatheUtil.div(sumColAmount, colAppliAmount, 2) * 100 + "%";
			}
			obj[7]=sum301;
			obj[8]=sum302;
			obj[9]=sum303;
			obj[10]=sum310;
			list.add(obj);
		}
		//没有项目支出
		if(!isFlag){
			//人员经费小计
			subTotalObj[5]=sumAmount3;
			list.add(num2, subTotalObj);
			//基本支出合计
			expendObj[5]=sumAmount2;
			list.add(num, expendObj);
		}else{
			//项目支出合计
			expendObj[5]=sumAmount2;
			list.add(num+1, expendObj);
			//小计
			subTotalObj[5]=sumAmount3;
			list.add(num2+1, subTotalObj);
		}
		//需要改222
		firstObj[5]=sumAmount1;
		if (totalAmount == 0.00) {
			firstObj[6]="0.0%";
		} else {
			firstObj[6]=MatheUtil.div(sumAmount1, totalAmount, 2) * 100 + "%";
		}
		
		list.add(0, firstObj);
		return list;
	}

}
