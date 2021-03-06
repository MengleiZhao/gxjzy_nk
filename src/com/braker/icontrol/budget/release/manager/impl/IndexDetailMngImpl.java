package com.braker.icontrol.budget.release.manager.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Depart;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.release.entity.TIndexDetail;
import com.braker.icontrol.budget.release.manager.IndexDetailMng;

@Service
@Transactional
public class IndexDetailMngImpl extends BaseManagerImpl<TIndexDetail> implements IndexDetailMng {
	@Autowired
	private UserMng userMng;
	
	@Override
	public List<TIndexDetail> findByIndexCode(String indexCode) {
		Finder finder = Finder.create(" FROM TIndexDetail WHERE indexCode='"+indexCode+"'");
		return super.find(finder);
	}
	
	@Override
	public Pagination searchByIndexCode(String indexCode,String userName,String time1,String time2,int pageNo, int pageSize) {
		StringBuilder sb=new StringBuilder("select * FROM T_INDEX_DETAIL WHERE F_INDEX_CODE='"+indexCode+"'");
		if(!StringUtil.isEmpty(userName)){
			sb.append(" AND F_USER_ID in (select pid from sys_user where name LIKE('%"+userName+"%'))");
		}
		if(!StringUtil.isEmpty(time1)){
			sb.append(" AND DATE_FORMAT(F_TIME,'%Y-%m-%d')>='"+time1+"'");
		}
		if(!StringUtil.isEmpty(time2)){
			sb.append(" AND DATE_FORMAT(F_TIME,'%Y-%m-%d')<='"+time2+"'");
		}
		sb.append(" order by f_time desc");
		String str=sb.toString();
		Pagination p = super.findBySql(new TIndexDetail(), str, pageNo, pageSize);
			List<TIndexDetail> dataList = (List<TIndexDetail>) p.getList();
			if (dataList != null && dataList.size() > 0) {
				int i = 0;
				for (TIndexDetail log: dataList) {
					log.setNum(pageNo * pageSize + i - (pageSize-1));
					i++;
				}
			}
		return p;
	}
	

	@Override
	public HSSFWorkbook exportExcel(List<TIndexDetail> index_dataList, String filePath) {
		FileInputStream fis =null;
		try {
			File file = new File(filePath);
			fis = new FileInputStream(file);
			HSSFWorkbook wb  = new HSSFWorkbook(fis);
			HSSFSheet sheet0 = wb.getSheetAt(0);
			//???????????????
			if (index_dataList != null && index_dataList.size() > 0) {
				HSSFRow row = sheet0.getRow(2);//?????????
				for (int i = 0 ; i < index_dataList.size(); i++) {
					HSSFRow hssfRow = sheet0.createRow(2+i);
					hssfRow.setHeight(row.getHeight());
					TIndexDetail data = index_dataList.get(i);
					
					HSSFCell cell0 = hssfRow.createCell(0);
					HSSFCell cell1 = hssfRow.createCell(1);
					HSSFCell cell2 = hssfRow.createCell(2);
					HSSFCell cell3 = hssfRow.createCell(3);
					HSSFCell cell4 = hssfRow.createCell(4);
					HSSFCell cell5 = hssfRow.createCell(5);
					HSSFCell cell6 = hssfRow.createCell(6);
					HSSFCell cell7 = hssfRow.createCell(7);
					
					cell0.setCellValue(i + 1);
					cell1.setCellValue((data.getTime()==null?0:data.getTime()).toString());
					User user = userMng.findById(data.getUserId());
					cell2.setCellValue(user.getName()==null?"":user.getName());
					cell3.setCellValue(data.getAmount().doubleValue());
					if ("1".equals(data.getfType())) {
						cell4.setCellValue("??????");
					} else if ("2".equals(data.getfType())) {
						cell4.setCellValue("??????");
					}else if ("3".equals(data.getfType())) {
						cell4.setCellValue("????????????");
					}else if ("4".equals(data.getfType())) {
						cell4.setCellValue("????????????");
					}else if ("5".equals(data.getfType())) {
						cell4.setCellValue("??????");
					}else if ("6".equals(data.getfType())) {
						cell4.setCellValue("????????????");
					}else if ("7".equals(data.getfType())) {
						cell4.setCellValue("????????????");
					}
					cell5.setCellValue(data.getDepartment()==null?"":data.getDepartment());
					cell6.setCellValue(data.getIndexCode()==null?"":data.getIndexCode());
					cell7.setCellValue(data.getIndexName()==null?"":data.getIndexName());
					
					cell0.setCellStyle(row.getCell(0).getCellStyle());
					cell1.setCellStyle(row.getCell(1).getCellStyle());
					cell2.setCellStyle(row.getCell(2).getCellStyle());
					cell3.setCellStyle(row.getCell(3).getCellStyle());
					cell4.setCellStyle(row.getCell(4).getCellStyle());
					cell5.setCellStyle(row.getCell(5).getCellStyle());
					cell6.setCellStyle(row.getCell(6).getCellStyle());
					cell7.setCellStyle(row.getCell(7).getCellStyle());
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


	
	
	//fType:????????????     1?????????	2?????????	3???????????????	4???????????????	5?????????	6???????????????	7???????????????
	@Override
	public Pagination indexDetailData1(Depart depart, String year,String fType,String type, int pageNo, int pageSize,String searchIndexName, String searchDeptName) {
		StringBuilder sb=new StringBuilder("SELECT t1.* FROM T_INDEX_DETAIL t1 WHERE");
		sb.append(" t1.F_AMOUNT>0 AND t1.F_TYPE!=1 and t1.F_TYPE!=2");
		
		if(!StringUtil.isEmpty(fType)){
			sb.append(" AND t1.F_TYPE='"+fType+"'"); //???????????????
		}
		if(!StringUtil.isEmpty(type)){
			sb.append(" AND t1.F_INDEX_TYPE='"+type+"'"); //??????????????? F_INDEX_TYPE
		}
		//???????????? ???????????? ????????? ????????????
		if(year.length()<5){
			sb.append(" AND year(t1.F_TIME)='"+year+"'");
		}else{
			sb.append(" AND DATE_FORMAT(t1.F_TIME,'%Y-%m')='"+year+"'");
		}
		//????????????
		if (depart != null) {
			String departType = depart.getType();
			if (Depart.TYPE_COM.equals(departType)) {
				//???????????????????????????????????????
				sb.append(" AND t1.F_DEPT_CODE IN (SELECT PID FROM SYS_DEPART WHERE PARENTID='" + depart.getId() + "' AND TYPE='" + Depart.TYPE_DEPT + "') ");
			} else if (Depart.TYPE_DEPT.equals(departType)) {
				//??????????????????????????????????????????????????????
				sb.append(" AND t1.F_DEPT_CODE IN (SELECT PID FROM SYS_DEPART WHERE PARENTID='" + depart.getParent().getId() + "' AND TYPE='" + Depart.TYPE_DEPT + "') ");
			}
		}
		if(searchIndexName!=null && searchIndexName.length()>0){
			sb.append(" AND t1.F_INDEX_NAME LIKE ('%"+searchIndexName+"%')");
		}
		if(searchDeptName!=null && searchDeptName.length()>0){
			sb.append(" AND t1.F_DEPARTMENT LIKE ('%"+searchDeptName+"%')");
		}
		sb.append(" ORDER BY t1.F_TIME DESC");
		String str=sb.toString();
		Pagination p = super.findBySql(new TIndexDetail(), str, pageNo, pageSize);
			List<TIndexDetail> dataList = (List<TIndexDetail>) p.getList();
			if (dataList != null && dataList.size() > 0) {
				int i = 0;
				for (TIndexDetail log: dataList) {
					log.setNum(pageNo * pageSize + i - (pageSize-1));
					i++;
				}
			}
		return p;
	}
	@Override
	public Pagination searchByFtype(String indexCode,String userName,String time1,String time2,int pageNo, int pageSize,String fType ) {
		StringBuilder sb=new StringBuilder("select * FROM T_INDEX_DETAIL WHERE F_INDEX_CODE='"+indexCode+"' and F_TYPE ='"+fType+"'" );
		if(!StringUtil.isEmpty(userName)){
			sb.append(" AND F_USER_ID in (select pid from sys_user where name LIKE('%"+userName+"%'))");
		}
		if(!StringUtil.isEmpty(time1)){
			sb.append(" AND DATE_FORMAT(F_TIME,'%Y-%m-%d')>='"+time1+"'");
		}
		if(!StringUtil.isEmpty(time2)){
			sb.append(" AND DATE_FORMAT(F_TIME,'%Y-%m-%d')<='"+time2+"'");
		}
		sb.append(" order by f_time desc");
		String str=sb.toString();
		Pagination p = super.findBySql(new TIndexDetail(), str, pageNo, pageSize);
			List<TIndexDetail> dataList = (List<TIndexDetail>) p.getList();
			if (dataList != null && dataList.size() > 0) {
				int i = 0;
				for (TIndexDetail log: dataList) {
					log.setNum(pageNo * pageSize + i - (pageSize-1));
					i++;
				}
			}
		return p;
	}
}
