package com.braker.icontrol.budget.adjust.entity;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.braker.icontrol.budget.adjust.entity.TIndexExteAd;
import com.braker.icontrol.budget.adjust.entity.TIndexInnerAd;

public class ExportExcelLedger {

	public static HSSFWorkbook exportExcel(List<TIndexInnerAd> list,List<TIndexExteAd> list1,String filePath) {
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		FileInputStream fis =null;
		try {
			File file = new File(filePath);
			fis = new FileInputStream(file);
			HSSFWorkbook wb  = new HSSFWorkbook(fis);
			HSSFSheet sheet0 = wb.getSheetAt(0);
			HSSFSheet sheet1 = wb.getSheetAt(1);
			
			//内部台账
			if (list !=null && list.size() > 0) {
				HSSFRow row = sheet0.getRow(2);//格式行
				for (int i = 0 ; i < list.size(); i++) {
					HSSFRow hssfRow = sheet0.createRow(2+i);
					hssfRow.setHeight(row.getHeight());
					TIndexInnerAd data = list.get(i);
					//序号
					HSSFCell cell0 = hssfRow.createCell(0);
					cell0.setCellValue(i + 1);
					//操作人
					HSSFCell cell1 = hssfRow.createCell(1);
					cell1.setCellValue(data.getOpUser());
					//调出指标名称
					HSSFCell cell2 = hssfRow.createCell(2);
					cell2.setCellValue(data.getIndexNameOut());
					//调出金额[万元]
					HSSFCell cell3 = hssfRow.createCell(3);
					cell3.setCellValue(data.getChangeAmountOut().doubleValue());
					//调入指标名称
					HSSFCell cell4 = hssfRow.createCell(4);
					cell4.setCellValue(data.getIndexNameIn());
					//调入金额[万元]
					HSSFCell cell5 = hssfRow.createCell(5);
					cell5.setCellValue(data.getChangeAmountIn().doubleValue());
					//调整时间
					HSSFCell cell6 = hssfRow.createCell(6);
					cell6.setCellValue(df.format(data.getOpTime()));
					//审批状态
					HSSFCell cell7 = hssfRow.createCell(7);
					if (data.getFlowStauts().equals("0") ) {
						cell7.setCellValue("暂存");
					} else if (data.getFlowStauts().equals("-1")) {
						cell7.setCellValue("已退回");
					} else if (data.getFlowStauts().equals("9")) {
						cell7.setCellValue("已审批");
					} else {
						cell7.setCellValue("待审批");
					}
					//sheet0格式
					/*cell0.setCellStyle(row.getCell(0).getCellStyle());
					cell1.setCellStyle(row.getCell(1).getCellStyle());
					cell2.setCellStyle(row.getCell(2).getCellStyle());
					cell3.setCellStyle(row.getCell(3).getCellStyle());
					cell4.setCellStyle(row.getCell(4).getCellStyle());
					cell5.setCellStyle(row.getCell(5).getCellStyle());
					cell6.setCellStyle(row.getCell(6).getCellStyle());
					cell7.setCellStyle(row.getCell(7).getCellStyle());*/
				}
			}
			//外部调整台账
			if (list1 !=null && list1.size() > 0) {
				HSSFRow row = sheet1.getRow(2);//格式行
				for (int i = 0 ; i < list1.size(); i++) {
					HSSFRow hssfRow = sheet1.createRow(2+i);
					hssfRow.setHeight(row.getHeight());
					TIndexExteAd data = list1.get(i);
					//序号
					HSSFCell cell0 = hssfRow.createCell(0);
					cell0.setCellValue(i + 1);
					//操作人
					HSSFCell cell1 = hssfRow.createCell(1);
					cell1.setCellValue(data.getOpUser());
					//调出指标名称
					HSSFCell cell2 = hssfRow.createCell(2);
					cell2.setCellValue(data.getIndexName());
					//调整金额
					HSSFCell cell3 = hssfRow.createCell(3);
					cell3.setCellValue(data.getChangeAmount().doubleValue());
					//调整时间
					HSSFCell cell4 = hssfRow.createCell(4);
					cell4.setCellValue(df.format(data.getOpTime()));
					//审批状态
					HSSFCell cell5 = hssfRow.createCell(5);
//					cell5.setCellValue(data.getFlowStauts());
					if (data.getFlowStauts().equals("0") ) {
						cell5.setCellValue("暂存");
					} else if (data.getFlowStauts().equals("-1")) {
						cell5.setCellValue("已退回");
					} else if (data.getFlowStauts().equals("9")) {
						cell5.setCellValue("已审批");
					} else {
						cell5.setCellValue("待审批");
					}
					//sheet1格式
					/*cell1.setCellStyle(row.getCell(1).getCellStyle());
					cell2.setCellStyle(row.getCell(2).getCellStyle());
					cell3.setCellStyle(row.getCell(3).getCellStyle());
					cell4.setCellStyle(row.getCell(4).getCellStyle());
					cell5.setCellStyle(row.getCell(5).getCellStyle());*/
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
