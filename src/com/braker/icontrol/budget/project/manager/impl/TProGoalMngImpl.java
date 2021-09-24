package com.braker.icontrol.budget.project.manager.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.model.Lookups;
import com.braker.common.hibernate.Finder;
import com.braker.core.model.User;
import com.braker.icontrol.budget.data.entity.BudgetData1;
import com.braker.icontrol.budget.data.entity.BudgetData2;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProGoal;
import com.braker.icontrol.budget.project.entity.TProGoalDetail;
import com.braker.icontrol.budget.project.manager.TProGoalDetailMng;
import com.braker.icontrol.budget.project.manager.TProGoalMng;
import com.braker.workflow.entity.TProcessDefin;

@Service
public class TProGoalMngImpl extends BaseManagerImpl<TProGoal> implements TProGoalMng{

	@Autowired
	private TProGoalDetailMng tProGoalDetailMng;
	
	@Override
	public TProGoal save(TProGoal goal, TProBasicInfo project, User user) {
		
		if (goal != null) {
			goal.setProject(project);
			return (TProGoal) super.merge(goal);
		}
		return null;
	}
	/**
	 * 获得项目绩效目标计划
	 * @param proId 项目id
	 * @return
	 */
	@Override
	public List<TProGoal> getTProGoalByPro(String proId) {
		Finder finder = Finder.create(" from TProGoal where project.FProId=" + proId);
		return super.find(finder);
	}

	@Override
	public  List<TProGoal> findByproject(TProBasicInfo project) {
		Finder f=Finder.create(" from TProGoal where project.FProId="+project.getFProId());
		 List<TProGoal> pg = super.find(f);
			return pg;
	}

	@Override
	public void save(TProGoal pg, List<TProGoalDetail> pgd, User user) {
		TProGoal oldpg = findById(pg.getPid());
		oldpg.setfYearAmount(pg.getfYearAmount());
		oldpg.setfYearApproAmount(pg.getfYearApproAmount());
		oldpg.setfYearOtherAmount(pg.getfYearOtherAmount());
		super.saveOrUpdate(oldpg);
		for (int i = 0; i < pgd.size(); i++) {
			pgd.get(i).setUpdateTime(new Date());
			pgd.get(i).setUpdator(user);
			tProGoalDetailMng.merge(pgd.get(i));
		}
		
	}
	@Override
	public List<Lookups> getLookupsJson(String categoryCode,String blanked) {
		Finder hql=Finder.create("from Lookups Where flag='1' ");
		hql.append("  and category.code =:pcode ").setParam("pcode", categoryCode);
		if(!StringUtil.isEmpty(blanked)){
			hql.append(" and code<>:code").setParam("code", blanked);
		}
		hql.append(" order by convert(orderNo,SIGNED)");
		return super.find(hql);
	}
	@Override
	public Pagination pageList(TProGoal bean, User user, int pageNo,
			int pageSize) {
		try {
			Finder finder = Finder.create(" from TProGoal where 1=1 ");
			if (!StringUtil.isEmpty(bean.getProject().getFProCode()) ) {//项目编号
				finder.append(" and project.FProCode LIKE :FProCode");
				finder.setParam("FProCode", "%"+bean.getProject().getFProCode()+"%");
			}
			if (!StringUtil.isEmpty(bean.getProject().getFProName())) {//项目名称
				finder.append(" and project.FProName LIKE :FProName");
				finder.setParam("FProName", "%"+bean.getProject().getFProName()+"%");
			}
			return super.find(finder, pageNo, pageSize);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return null;
	}
	
	@Override
	public HSSFWorkbook exportExcel(List<TProGoal> list, String filePath) {
		FileInputStream fis =null;
		try {
			File file = new File(filePath);
			fis = new FileInputStream(file);
			HSSFWorkbook wb  = new HSSFWorkbook(fis);
			HSSFSheet sheet = wb.getSheetAt(0);
			
			//sheet0年报数据
			if (list !=null && list.size() > 0) {
				HSSFRow row = sheet.getRow(2);//格式行
				for (int i = 0 ; i < list.size(); i++) {
					HSSFRow hssfRow = sheet.createRow(2+i);
					hssfRow.setHeight(row.getHeight());
					TProGoal data = list.get(i);
					//序号
					HSSFCell cell0 = hssfRow.createCell(0);
					cell0.setCellValue(i + 1);
					cell0.setCellStyle(row.getCell(0)==null?null:row.getCell(0).getCellStyle());
					//项目编号
					HSSFCell cell1 = hssfRow.createCell(1);
					cell1.setCellValue(data.getProCode()==null?"":data.getProCode());
					cell1.setCellStyle(row.getCell(1)==null?null:row.getCell(1).getCellStyle());
					//项目名称
					HSSFCell cell2 = hssfRow.createCell(2);
					cell2.setCellValue(data.getProName()==null?"":data.getProName());
					cell2.setCellStyle(row.getCell(2)==null?null:row.getCell(2).getCellStyle());
					//年度
					HSSFCell cell3 = hssfRow.createCell(3);
					cell3.setCellValue(data.getProYear()==null?"":data.getProYear());
					cell3.setCellStyle(row.getCell(3)==null?null:row.getCell(3).getCellStyle());
					//年度目标
					HSSFCell cell4 = hssfRow.createCell(4);
					cell4.setCellValue(data.getLongGoal()==null?"":data.getLongGoal());
					cell4.setCellStyle(row.getCell(4)==null?null:row.getCell(4).getCellStyle());
					//年度资金总额[万元]
					HSSFCell cell5 = hssfRow.createCell(5);
					cell5.setCellValue(data.getLongTotal()==null?0:data.getLongTotal());
					cell5.setCellStyle(row.getCell(5)==null?null:row.getCell(5).getCellStyle());
					//年度财政拨款[万元]
					HSSFCell cell6 = hssfRow.createCell(6);
					cell6.setCellValue(data.getLongAmount1()==null?0:data.getLongAmount1());
					cell6.setCellStyle(row.getCell(6)==null?null:row.getCell(6).getCellStyle());
					//年度其他资金[万元]
					HSSFCell cell7 = hssfRow.createCell(7);
					cell7.setCellValue(data.getLongAmount2()==null?0:data.getLongAmount2());
					cell7.setCellStyle(row.getCell(7)==null?null:row.getCell(7).getCellStyle());
					//中期目标
					HSSFCell cell8 = hssfRow.createCell(8);
					cell8.setCellValue(data.getMidGoal()==null?"":data.getMidGoal());
					cell8.setCellStyle(row.getCell(8)==null?null:row.getCell(8).getCellStyle());
					//中期资金总额[万元]
					HSSFCell cell9 = hssfRow.createCell(9);
					cell9.setCellValue(data.getMidTotal()==null?0:data.getMidTotal());
					cell9.setCellStyle(row.getCell(9)==null?null:row.getCell(9).getCellStyle());
					//中期财政拨款[万元]
					HSSFCell cell10 = hssfRow.createCell(10);
					cell10.setCellValue(data.getMidAmount1()==null?0:data.getMidAmount1());
					cell10.setCellStyle(row.getCell(10)==null?null:row.getCell(10).getCellStyle());
					//中期其他资金[万元]
					HSSFCell cell11 = hssfRow.createCell(11);
					cell11.setCellValue(data.getMidAmount2()==null?0:data.getMidAmount2());
					cell11.setCellStyle(row.getCell(11)==null?null:row.getCell(11).getCellStyle());
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
	public List<TProGoal> listAll(TProGoal bean) {
		// TODO Auto-generated method stub
		String sql = "select tprobasici.F_PRO_CODE,tprobasici.F_PRO_NAME,tprobasici.F_PRO_APPLI_TIME,tprobasigoallist.F_LONG_GOAL,"
				+ "tprobasigoallist.F_LONG_AMOUNT,tprobasigoallist.F_LONG_APPRO_AMOUNT,tprobasigoallist.F_LONG_OTH_AMOUNT,"
				+ "tprobasigoallist.F_MATE_GOAL,tprobasigoallist.F_MATE_AMOUNT,tprobasigoallist.F_MATE_APPRO_AMOUNT,"
				+ "tprobasigoallist.F_MATE_OTH_AMOUNT from T_PRO_PERF_GOAL_LIST tprobasigoallist left join "
				+ "t_pro_basic_info  tprobasici on tprobasigoallist.F_PRO_ID=tprobasici.F_PRO_ID where 1=1 ";
		if (!StringUtil.isEmpty(bean.getProject().getFirstLevelName()) && !bean.getProject().getFirstLevelName().contains("请选择")) {//项目类别
			sql=sql+" and tprobasici.F_LEV_NAME_1= '"+ bean.getProject().getFirstLevelName()+"'";
		}
		if (!StringUtil.isEmpty(bean.getProject().getFProAttribute())) {//项目属性
			sql=sql+" and tprobasici.F_PRO_ATTRIBUTE= '"+ bean.getProject().getFProAttribute()+"'";
		}
		SQLQuery query=getSession().createSQLQuery(sql);
		List<Object[]> objectList = query.list();
		List<TProGoal> list =Object2List(objectList);
		return list;
	}
	
	private  List<TProGoal>  Object2List(List<Object[]> objectList){
		List<TProGoal> list=new ArrayList<TProGoal>();
		for(Object[] objects:objectList){
			TProGoal tp=new TProGoal();
			TProBasicInfo project=new TProBasicInfo();
			project.setFProCode(objects[0].toString());
			project.setFProName(objects[1].toString());
			Date proAppliTime=DateUtil.parseDate(objects[2].toString(), "yyyy-MM-dd");
			project.setFProAppliTime(proAppliTime);
			tp.setProject(project);
			tp.setLongGoal(objects[3].toString());
			tp.setLongTotal(Double.parseDouble(objects[4]==null?"0":objects[4].toString()));
			tp.setLongAmount1(Double.parseDouble(objects[5]==null?"0":objects[5].toString()));
			tp.setLongAmount2(Double.parseDouble(objects[6]==null?"0":objects[6].toString()));
			tp.setMidGoal(objects[7].toString());
			tp.setMidTotal(Double.parseDouble(objects[8]==null?"0":objects[8].toString()));
			tp.setMidAmount1(Double.parseDouble(objects[9]==null?"0":objects[9].toString()));
			tp.setMidAmount2(Double.parseDouble(objects[10]==null?"0":objects[10].toString()));
			list.add(tp);
		}
		return list;
	}

}
