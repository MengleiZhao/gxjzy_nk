package com.braker.icontrol.expend.apply.manager.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.SQLQuery;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.model.Depart;
import com.braker.icontrol.expend.apply.manager.TravelAppliInfoMng;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.apply.model.StudentsList;
import com.braker.icontrol.expend.apply.model.TravelAppliInfo;


/**
 * 差旅费申请信息service实现层
 * @author 赵孟雷
 * @createtime 2020-04-18
 * @updatetime 2020-04-18
 */
@Service
@Transactional
public class TravelAppliInfoMngImpl extends BaseManagerImpl<TravelAppliInfo> implements TravelAppliInfoMng {

	public Pagination travelPageList(int pageNo, int pageSize,TravelAppliInfo bean){
		
		Finder finder = Finder.create(" FROM TravelAppliInfo WHERE fStatus =0");
		if (!StringUtil.isEmpty(String.valueOf(bean.getgId()))) {
			finder.append(" AND gId="+bean.getgId()+"");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getTravelType()))) {
			finder.append(" AND travelType='"+bean.getTravelType()+"'");
		}
		finder.append(" order by travelAreaTime,travelDateStart asc");
		return super.find(finder, pageNo, pageSize);
	}
	public Pagination studentsPageList(int pageNo, int pageSize,StudentsList bean){
		
		Finder finder = Finder.create(" FROM StudentsList WHERE 1=1");	
		if (!StringUtil.isEmpty(String.valueOf(bean.getgId()))) {
			finder.append(" AND gId="+bean.getgId()+"");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getrId()))) {
			finder.append(" AND rId="+bean.getrId()+"");
		}
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public Pagination rtravelPageList(int pageNo, int pageSize,TravelAppliInfo bean) {
		Finder finder = Finder.create(" FROM TravelAppliInfo WHERE fStatus =1");	
		if (!StringUtil.isEmpty(String.valueOf(bean.getrId()))) {
			finder.append(" AND rId="+bean.getrId()+"");
		}
		if (!StringUtil.isEmpty(String.valueOf(bean.getTravelType()))) {
			finder.append(" AND travelType='"+bean.getTravelType()+"'");
		}
		finder.append(" order by travelAreaTime,travelDateStart asc");
		return super.find(finder, pageNo, pageSize);
	}
	
	@Override
	public List<TravelAppliInfo> travelPageRepetitionList(TravelAppliInfo bean) {
		String sql = "select b.F_G_ID,a.F_ATTEND_PEOPLE_ID,a.F_TRAVEL_AREA_TIME from T_TRAVEL_APPLI_INFO a left JOIN  t_application_basic_info b ON a.F_G_ID = b.F_G_ID where b.F_FLOW_STAUTS not in('0','-1','-4')";
		
		if (!StringUtil.isEmpty(String.valueOf(bean.getTravelAreaTime()))) {
			sql+=" and a.F_TRAVEL_AREA_TIME='"+DateUtil.formatDate(bean.getTravelAreaTime())+"'";
		}
		
		if (!StringUtil.isEmpty(String.valueOf(bean.getgId()))) {
			sql+=" and b.F_G_ID !="+bean.getgId()+";";
		}
		
		SQLQuery query = getSession().createSQLQuery(sql);
		List<Object[]> dataList = (List<Object[]>) query.list();
		List<TravelAppliInfo> list =new ArrayList<TravelAppliInfo>();
		if (dataList != null && dataList.size() > 0) {
			int i = 0;
			for (Object[] obj: dataList) {
				TravelAppliInfo t=new TravelAppliInfo();
				t.setgId(Integer.valueOf(String.valueOf(obj[0])));
				t.setTravelAttendPeopId(String.valueOf(obj[1]));
				t.setTravelAreaTime(DateUtil.parseDate(String.valueOf(obj[1])));
				i++;
				list.add(t);
			}
		}
		return list;
	}
	@Override
	public List<TravelAppliInfo> travelPageRepetitionListReim(TravelAppliInfo bean) {
		String sql = "select b.F_G_ID,a.F_ATTEND_PEOPLE_ID,a.F_TRAVEL_AREA_TIME from T_TRAVEL_APPLI_INFO a left JOIN  t_application_basic_info b ON a.F_G_ID = b.F_G_ID where b.F_FLOW_STAUTS not in('0','-1','-4')";
		
		if (!StringUtil.isEmpty(String.valueOf(bean.getTravelAreaTime()))) {
			sql+=" and a.F_TRAVEL_AREA_TIME='"+DateUtil.formatDate(bean.getTravelAreaTime())+"'";
		}
		
		if (!StringUtil.isEmpty(String.valueOf(bean.getrId()))) {
			sql+=" and a.F_R_ID !="+bean.getrId()+";";
		}
		
		SQLQuery query = getSession().createSQLQuery(sql);
		List<Object[]> dataList = (List<Object[]>) query.list();
		List<TravelAppliInfo> list =new ArrayList<TravelAppliInfo>();
		if (dataList != null && dataList.size() > 0) {
			int i = 0;
			for (Object[] obj: dataList) {
				TravelAppliInfo t=new TravelAppliInfo();
				t.setrId(Integer.valueOf(String.valueOf(obj[0])));
				t.setTravelAttendPeopId(String.valueOf(obj[1]));
				t.setTravelAreaTime(DateUtil.parseDate(String.valueOf(obj[1])));
				i++;
				list.add(t);
			}
		}
		return list;
	}
}
