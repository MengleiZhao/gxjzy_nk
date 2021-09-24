package com.braker.common.util;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;

/**
 * poi的工具类
 * @author 叶崇晖
 * @createtime 2018-09-12
 * @updatetime 2018-09-12
 */
public class PoiUtil {
	
	public static String getCellValue(Cell cell) {
		if (cell == null) {
			return "";
		}
		String value = "";
		switch (cell.getCellType()) {
		case Cell.CELL_TYPE_STRING: 
			value = cell.getRichStringCellValue().getString();
			break;
		case Cell.CELL_TYPE_NUMERIC: 
			if (DateUtil.isCellDateFormatted(cell)) { 
				if (cell.getDateCellValue() != null) {
					value = new SimpleDateFormat("yyyy-MM-dd").format(cell
							.getDateCellValue());
				} else {
					value = "";
				}
			} else {
				DecimalFormat df = new DecimalFormat("0.00"); 	//需要保留几位消失就填多少入（0.0保留一位，0.00保留两位）
				value = String.valueOf(df.format(cell.getNumericCellValue()));
			}
			break;
		case Cell.CELL_TYPE_BOOLEAN: 
			value = String.valueOf(cell.getBooleanCellValue());
			break;
		case Cell.CELL_TYPE_FORMULA: 
			try {
				value = String.valueOf(cell.getStringCellValue());
			} catch (IllegalStateException e) {
				try {
					value = String.valueOf(cell.getNumericCellValue());
				} catch (Exception e2) {
					value = "0.00";
				}
			}
			break;
		case Cell.CELL_TYPE_BLANK:
			value = "";
			break;
		default:
			value = "";
			break;
		}
		return value;
	}
}
