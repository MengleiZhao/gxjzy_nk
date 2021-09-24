package com.braker.icontrol.expend.cashier.manager.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.expend.cashier.manager.CashierCollectMng;
import com.braker.icontrol.expend.cashier.model.CashierCollectInfo;

/**
 * 出纳采集的service实现类
 * @author 叶崇晖
 * @createtime 2018-08-27
 * @updatetime 2018-08-27
 */
@Service
@Transactional
public class CashierCollectMngImpl extends BaseManagerImpl<CashierCollectInfo> implements CashierCollectMng {

	/*
	 * 出纳采集分页查询
	 * @author 叶崇晖
	 * @createtime 2018-08-27
	 * @updatetime 2018-08-27
	 */
	@Override
	public Pagination pageList(CashierCollectInfo bean, int pageNo, int pageSize, User user) {
		Finder finder = Finder.create(" FROM CashierCollectInfo WHERE status<>99");	
		if(!StringUtil.isEmpty(String.valueOf(bean.getAmount1()))) {
			finder.append(" AND amount >= '"+bean.getAmount1()+"'");
		}
		if(!StringUtil.isEmpty(String.valueOf(bean.getAmount2()))) {
			finder.append(" AND amount <= '"+bean.getAmount2()+"'");
		}
		if(!StringUtil.isEmpty(bean.getUser())) {
			finder.append(" AND user LIKE '%"+bean.getUser()+"%'");
		}
		
		return super.find(finder, pageNo, pageSize);
	}

	/*
	 * 保存出纳采集信息
	 * @author 叶崇晖
	 * @createtime 2018-08-27
	 * @updatetime 2018-08-27
	 */
	@Override
	public void saveCashierCollect(File file) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		FileInputStream fis = null;
		Workbook workBook = null;
		if (file.exists()) {
			try {
				fis = new FileInputStream(file);
				workBook = WorkbookFactory.create(fis);
				int numberOfSheets = workBook.getNumberOfSheets();
				for (int s = 0; s < numberOfSheets; s++) { // sheet工作表
					org.apache.poi.ss.usermodel.Sheet sheetAt = workBook.getSheetAt(s);
//	                String sheetName = sheetAt.getSheetName(); //获取工作表名称
					int rowsOfSheet = sheetAt.getPhysicalNumberOfRows(); // 获取当前Sheet的总列数
					/*System.out.println("当前表格的总行数:" + rowsOfSheet);*/
					for (int r = 1; r < rowsOfSheet; r++) { // 总行
						Row row = sheetAt.getRow(r);
						if (row == null) {
							continue;
						} else {
							int rowNum = row.getRowNum();
							/*System.out.println("当前行:" + rowNum);*/
							int numberOfCells = row.getPhysicalNumberOfCells();
							CashierCollectInfo info = new CashierCollectInfo();
							for (int c = 0; c < numberOfCells; c++) { // 总列(格)
								Cell cell = row.getCell(c);
								if (cell == null) {
									continue;
								} else {
									int cellType = cell.getCellType();
									switch (cellType) {
									case Cell.CELL_TYPE_STRING: // 代表文本
										String stringCellValue = cell.getStringCellValue();
										/*System.out.print(stringCellValue + "\t");*/
										info = setInfo(info, c, stringCellValue);
										break;
									case Cell.CELL_TYPE_BLANK: // 空白格
										String stringCellBlankValue = cell.getStringCellValue();
										/*System.out.print(stringCellBlankValue + "\t");*/
										info = setInfo(info, c, stringCellBlankValue);
										break;
									case Cell.CELL_TYPE_BOOLEAN: // 布尔型
										boolean booleanCellValue = cell.getBooleanCellValue();
										/*System.out.print(booleanCellValue + "\t");*/
										info = setInfo(info, c, booleanCellValue);
										break;
									case Cell.CELL_TYPE_NUMERIC: // 数字||日期
										boolean cellDateFormatted = DateUtil.isCellDateFormatted(cell);
										if (cellDateFormatted) {
											Date dateCellValue = cell.getDateCellValue();
											/*System.out.print(sdf.format(dateCellValue) + "\t");*/
											info = setInfo(info, c, dateCellValue);
										} else {
											double numericCellValue = cell.getNumericCellValue();
											/*System.out.print(numericCellValue + "\t");*/
											info = setInfo(info, c, numericCellValue);
										}
										break;
									case Cell.CELL_TYPE_ERROR: // 错误
										byte errorCellValue = cell.getErrorCellValue();
										/*System.out.print(errorCellValue + "\t");*/
										info = setInfo(info, c, errorCellValue);
										break;
									case Cell.CELL_TYPE_FORMULA: // 公式
										int cachedFormulaResultType = cell.getCachedFormulaResultType();
										/*System.out.print(cachedFormulaResultType + "\t");*/
										info = setInfo(info, c, cachedFormulaResultType);
										break;
									}
								}
							}
							/*System.out.println(" \t ");*/
							System.out.println(info);
							info.setStatus("1");
							super.saveOrUpdate(info);
						}
						System.out.println("");
					}
				}
				
				file.delete();//删除临时文件
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				if (fis != null) {
					try {
						fis.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		} else {
			System.out.println("文件不存在!");
		}
	}

	public CashierCollectInfo setInfo(CashierCollectInfo info, int c, Object obj) {
		if(c==0) {
			info.setUser((String)obj);
		}
		if(c==1) {
			info.setTime((Date)obj);
		}
		if(c==2) {
			info.setPayee((String)obj);
		}
		if(c==3) {
			info.setIdCard(((String)obj));
		}
		if(c==4) {
			info.setBank((String)obj);
		}
		if(c==5) {
			info.setAccount(((String)obj));
		}
		if(c==6) {
			info.setAmount((Double)obj);
		}
		if(c==7) {
			info.setSettleMent((String)obj);
		}
		return info;
	}
	
}
