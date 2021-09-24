package com.braker.core.manager.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

import jxl.Sheet;
import jxl.Workbook;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.core.manager.DepartImpMng;
import com.braker.core.model.DepartImp;
import com.braker.core.model.User;

@SuppressWarnings("unchecked")
@Service
@Transactional
public class DepartImpMngImpl extends BaseManagerImpl<DepartImp> implements DepartImpMng{
	
	@Override
	public void impData(File file) {
		Workbook book = null;
		FileInputStream fis = null;
		//根据文件名获得年+月+季度的数据集合
        try {
//        	if(file.exists()){
//        		System.out.println("文件存在");
//        	}
        	fis = new FileInputStream(file);
            book = Workbook.getWorkbook(fis);
            Sheet sheet = book.getSheet(0);
            int rows=sheet.getRows();
            String pid,code,shortName,fullName,parentId,orderNo;
            
            for(int i=1; i<rows; i++){
            	if(sheet.getCell(0,i).equals("")){
            		break;
            	}
            	pid = sheet.getCell(0,i).getContents();
            	code = sheet.getCell(1,i).getContents();
            	shortName = sheet.getCell(2,i).getContents();
            	fullName = sheet.getCell(3,i).getContents();
            	parentId = sheet.getCell(4,i).getContents();
            	orderNo = sheet.getCell(6,i).getContents();
            	
            	DepartImp de = new DepartImp();
            	de.setPid(pid);
            	de.setCode(code);
            	de.setShortName(shortName);
            	de.setFullName(fullName);
            	de.setParentId(parentId);
            	de.setOrderNo(orderNo);
            	
            	super.save(de);
//            	System.out.println(de.toString());
            }
        } catch (Exception e) {
        	e.printStackTrace();
        }finally{
            if(book!=null){
                book.close();
            }
            if(fis!=null){
            	try {
					fis.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
            }
  
        }
	}

	@Override
	public void impMdjf(File file, User user) {

		Workbook book = null;
		FileInputStream fis = null;
		//根据文件名获得年+月+季度的数据集合
        try {
//        	if(file.exists()){
//        		System.out.println("文件存在");
//        	}
        	/*fis = new FileInputStream(file);
            book = Workbook.getWorkbook(fis);
            Sheet sheet = book.getSheet(0);
            int rows=sheet.getRows();
            //事件编号 事件名称 报案状态 涉案（事件）人数   ,事件简要描述 ,缓解措施
            String eventNumber,eventName,reportStatus,eventPeopleNumber,eventDescribe,easeMeasures;
            
            for(int i=1; i<rows; i++){
            	if(sheet.getCell(0,i).equals("")){
            		break;
            	}
            	eventNumber = intToOrder(i);
            	eventName = sheet.getCell(1,i).getContents();
            	reportStatus = "0";
            	eventPeopleNumber = sheet.getCell(5,i).getContents();
            	eventDescribe = sheet.getCell(2,i).getContents();
            	easeMeasures = sheet.getCell(3,i).getContents();
            	
            }*/
        } catch (Exception e) {
        	e.printStackTrace();
        }finally{
            if(book!=null){
                book.close();
            }
            if(fis!=null){
            	try {
					fis.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
            }
  
        }
	
		
	}
	
	@SuppressWarnings("unused")
	private String intToOrder(int i) {
		String order = "";
		if (i<10) {
			order = "000" + i;
		}else if (10<=i && i<100) {
			order = "00" + i;
		}else{
			order = "0" + i;
		}
		return order;
	}

	@Override
	public DepartImp findByCode(String code) {
		// TODO Auto-generated method stub
		DepartImp d=null;
		List<DepartImp> list=super.find("from DepartImp Where code = ?", new Object[]{code});
		if(null!=list && list.size()>0){
			d=list.get(0);
		}
		return d;
	}

	@Override
	public void updateVersion() {
		
	}


}
