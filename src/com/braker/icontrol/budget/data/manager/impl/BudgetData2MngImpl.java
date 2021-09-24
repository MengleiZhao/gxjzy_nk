package com.braker.icontrol.budget.data.manager.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.util.StringUtil;
import com.braker.icontrol.budget.data.entity.BudgetData1;
import com.braker.icontrol.budget.data.entity.BudgetData2;
import com.braker.icontrol.budget.data.manager.BudgetData2Mng;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;

@Service
public class BudgetData2MngImpl extends BaseManagerImpl<BudgetData2> implements BudgetData2Mng {

	@Override
	public HSSFWorkbook exportExcel(List<TBudgetIndexMgr> index_dataList,List<TBudgetIndexMgr> dept_dataList, String filePath) {
		FileInputStream fis =null;
		try {
			File file = new File(filePath);
			fis = new FileInputStream(file);
			HSSFWorkbook wb  = new HSSFWorkbook(fis);
			HSSFSheet sheet0 = wb.getSheetAt(0);
			HSSFSheet sheet1 = wb.getSheetAt(1);
			//按指标统计
			if (index_dataList != null && index_dataList.size() > 0) {
				HSSFRow row = sheet0.getRow(3);//格式行
				int index=1;	//序号
				int rowspan=1;	//合并行数
				int num=3; //记录当前行数  
				for (int i = 0 ; i < index_dataList.size(); i++) {
					HSSFRow hssfRow = sheet0.createRow(3+i);
					hssfRow.setHeight(row.getHeight());
					TBudgetIndexMgr data = index_dataList.get(i);
					
					HSSFCell cell0 = hssfRow.createCell(0);
					HSSFCell cell1 = hssfRow.createCell(1);
					HSSFCell cell2 = hssfRow.createCell(2);
					HSSFCell cell3 = hssfRow.createCell(3);
					HSSFCell cell4 = hssfRow.createCell(4);
					HSSFCell cell5 = hssfRow.createCell(5);
					HSSFCell cell6 = hssfRow.createCell(6);
					HSSFCell cell7 = hssfRow.createCell(7);
					HSSFCell cell8 = hssfRow.createCell(8);
					HSSFCell cell9 = hssfRow.createCell(9);
					HSSFCell cell10 = hssfRow.createCell(10);
					
					
					//sheet0.addMergedRegion(new CellRangeAddress(row,row,col,col)
					//  参数一 第一个单元格所在行 、 参数二 第二个单元格所在行  、参数三 第一个单元格所在列  、参数4 第二个单元格所在列
					//按指标名称
					String name1 = index_dataList.get(i).getIndexName();
					String name2="";
					if(i+1<index_dataList.size()){
						name2 = index_dataList.get(i+1).getIndexName();
					}
					
					if(name1 != null && name1.equals(name2)){
						rowspan++;
						if(index==index){
							sheet0.addMergedRegion(new CellRangeAddress(num,num+1,0,0));	//合并序号
							sheet0.addMergedRegion(new CellRangeAddress(num,num+1,1,1));	//合并序号
						}
						cell0.setCellValue(index);
					}else{
						rowspan=0;
						cell0.setCellValue(index);
						index++;
						
					}
					num++;

					cell1.setCellValue(data.getIndexName()==null?"":data.getIndexName());
					cell2.setCellValue(data.getDeptName()==null?"":data.getDeptName());
					cell3.setCellValue(data.getPfAmount()==null?0:data.getPfAmount().doubleValue());
					cell4.setCellValue(data.getXdAmount()==null?0:data.getXdAmount().doubleValue());
					cell5.setCellValue(data.getSyAmount()==null?0:data.getSyAmount().doubleValue());
					
					BigDecimal pfNum=data.getPfAmount();
					BigDecimal xdNum=data.getXdAmount();
					BigDecimal syNum=data.getSyAmount();
					BigDecimal djNum=data.getDjAmount();
					BigDecimal d=(xdNum.subtract(syNum)).subtract(djNum);//已支出金额
					cell6.setCellValue(d.toString());	//已支出金额
					
					cell7.setCellValue(data.getDjAmount().doubleValue());
					
					if(data.getXdAmount()==null){
						cell8.setCellValue("0.00%");
					}else{
					    // 执行进度/百分比  = 使用/批复
						BigDecimal b=new BigDecimal(100);	//100   数字转换 为 BigDecimal 类型 进行乘除
						cell8.setCellValue(new DecimalFormat("0.00").format(((d.multiply(b)).divide(pfNum,4,BigDecimal.ROUND_HALF_UP))) + "%");
					}
					cell9.setCellValue(data.getYears()==null?"":data.getYears());
					cell10.setCellValue(data.getIndexCode()==null?"":data.getIndexCode());
					
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
				}
			}
			//按部门统计
			if ( dept_dataList != null && dept_dataList.size() > 0) {
				HSSFRow row = sheet1.getRow(3);//格式行
				int index=1;	//序号
				int rowspan=0;	//合并行数
				int num=3;		//记录当前行数
				for (int i = 0 ; i < dept_dataList.size(); i++) {
					HSSFRow hssfRow = sheet1.createRow(3+i);
					hssfRow.setHeight(row.getHeight());
					TBudgetIndexMgr data = dept_dataList.get(i);
					
					HSSFCell cell0 = hssfRow.createCell(0);
					HSSFCell cell1 = hssfRow.createCell(1);
					HSSFCell cell2 = hssfRow.createCell(2);
					HSSFCell cell3 = hssfRow.createCell(3);
					HSSFCell cell4 = hssfRow.createCell(4);
					HSSFCell cell5 = hssfRow.createCell(5);
					HSSFCell cell6 = hssfRow.createCell(6);
					HSSFCell cell7 = hssfRow.createCell(7);
					HSSFCell cell8 = hssfRow.createCell(8);
					HSSFCell cell9 = hssfRow.createCell(9);
					HSSFCell cell10 = hssfRow.createCell(10);
					
					//按部门名称
					String name1 = dept_dataList.get(i).getDeptName();
					String name2="";
					if(i+1<dept_dataList.size()){
						name2 = dept_dataList.get(i+1).getDeptName();
					}
					
					if(name1 != null && name1.equals(name2)){
						rowspan++;
						if(index==index){
							sheet1.addMergedRegion(new CellRangeAddress(num,num+1,0,0));	//合并序号
							sheet1.addMergedRegion(new CellRangeAddress(num,num+1,1,1));	//合并序号
						}
						cell0.setCellValue(index);
					}else{
						rowspan=0;
						cell0.setCellValue(index);
						index++;
						
					}
					num++;

					cell1.setCellValue(data.getDeptName()==null?"":data.getDeptName());
					cell2.setCellValue(data.getIndexName()==null?"":data.getIndexName());
					cell3.setCellValue(data.getPfAmount().doubleValue());
					cell4.setCellValue(data.getXdAmount().doubleValue());
					cell5.setCellValue(data.getSyAmount().doubleValue());
					
					BigDecimal pfNum=data.getPfAmount();
					BigDecimal xdNum=data.getXdAmount();
					BigDecimal syNum=data.getSyAmount();
					BigDecimal djNum=data.getDjAmount();
					BigDecimal d=(xdNum.subtract(syNum)).subtract(djNum);//已支出金额
					cell6.setCellValue(d.toString());	//已支出金额
					
					cell7.setCellValue(data.getDjAmount().doubleValue());
					if(data.getXdAmount()==null){
						cell8.setCellValue("0.00%");
					}else{ 
						// 执行进度/百分比  = 使用/批复
						BigDecimal b=new BigDecimal(100);	//100   数字转换 为 BigDecimal 类型 进行乘除
						cell8.setCellValue(new DecimalFormat("0.00").format(((d.multiply(b)).divide(pfNum,4,BigDecimal.ROUND_HALF_UP))) + "%");
					}
					cell9.setCellValue(data.getYears()==null?"":data.getYears());
					cell10.setCellValue(data.getIndexCode()==null?"":data.getIndexCode());
					
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
	public HSSFWorkbook exportExcelThree(List<Object[]> list, String filePath) {
		FileInputStream fis =null;
		try {
			File file = new File(filePath);
			fis = new FileInputStream(file);
			HSSFWorkbook wb  = new HSSFWorkbook(fis);
			HSSFSheet sheet0 = wb.getSheetAt(0);
			//sheet0数据
			if (list !=null && list.size() > 0) {
				HSSFRow row = sheet0.getRow(5);//格式行
				for (int i = 0 ; i < list.size(); i++) {
					HSSFRow hssfRow = sheet0.createRow(5+i);
					hssfRow.setHeight(row.getHeight());
					Object[] data = list.get(i);
					//序号
					HSSFCell cell0 = hssfRow.createCell(0);
					cell0.setCellValue(i + 1);
					//名称
					/*HSSFCell cell1 = hssfRow.createCell(1);
					cell1.setCellValue(data[i]);
					//部门
					HSSFCell cell2 = hssfRow.createCell(2);
					cell2.setCellValue(data[].getDepartName());
					//额度
					HSSFCell cell3 = hssfRow.createCell(3);
					cell3.setCellValue(data[].getIndexAmount());
					//年累值
					double num0 = Double.valueOf(data.getNum0());
					double num1 = Double.valueOf(data.getNum1());
					double num2 = Double.valueOf(data.getNum2());
					//sheet0格式
					cell0.setCellStyle(row.getCell(0).getCellStyle());
					cell1.setCellStyle(row.getCell(1).getCellStyle());
					cell2.setCellStyle(row.getCell(2).getCellStyle());
					cell3.setCellStyle(row.getCell(3).getCellStyle());*/
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
	
	
}
