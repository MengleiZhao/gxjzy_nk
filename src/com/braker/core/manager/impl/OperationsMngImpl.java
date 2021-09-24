package com.braker.core.manager.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.OperationsMng;
import com.braker.core.model.SysLog;

@SuppressWarnings("unchecked")
@Transactional
@Service
public class OperationsMngImpl extends BaseManagerImpl<SysLog> implements OperationsMng{

	@Override
	public List<Object[]> countDzzf(String dates, String datee) {
		
		Finder finder = Finder.create("select  personLiable.jwh.id,count(*) from Huzfqk where flag='1'  and logType=10");
		finder.append(" and personLiable.street.id = 'bb7c769d-9459-4851-96ab-151eec7c564'");
		
		if (!StringUtil.isEmpty(dates)) {
			finder.append(" and convert(nvarchar(15),lksj,23) >= :dates").setParam("dates", dates);
		}
		if (!StringUtil.isEmpty(datee)) {
			finder.append(" and convert(nvarchar(15),lksj,23) <= :datee").setParam("datee", datee);
		}
		finder.append(" group by  personLiable.jwh.id");
		return super.find(finder);
	}

	@Override
	public List<Object[]> countDzxc(String dates, String datee) {
		
		Finder finder = Finder.create("select commJwh.jwhCode ,count(*) from InspectTaskLog Where flag='1' and logType in (10,20)");
		finder.append(" and commStreet.id='bb7c769d-9459-4851-96ab-151eec7c564'");
		
		if(!StringUtil.isEmpty(dates)){
			finder.append(" and convert(nvarchar(15),createDate,23) >= :dates ");
			finder.setParam("dates", dates);
		}
		if(!StringUtil.isEmpty(datee)){
			finder.append(" and convert(nvarchar(15),createDate,23) <= :datee ");
			finder.setParam("datee", datee);
		}
		finder.append(" group by commJwh.jwhCode ");
		return super.find(finder);
	}

	@Override
	public List<Object[]> countSyrk(String dates, String datee) {
		
		Finder finder = Finder.create("select jwhId.id,count(*) from PopuInfo where flag='1' and data_status='10' ");
		finder.append("and (streetId.id = 'bb7c769d-9459-4851-96ab-151eec7c564' or hjdStreet.id='bb7c769d-9459-4851-96ab-151eec7c564')");
		
		if(!StringUtil.isEmpty(dates)){
			finder.append(" and convert(nvarchar(15),updateTime,23) >= :dates ");
			finder.setParam("dates", dates);
		}
		if(!StringUtil.isEmpty(datee)){
			finder.append(" and convert(nvarchar(15),updateTime,23) <= :datee ");
			finder.setParam("datee", datee);
		}
		
		finder.append(" group by jwhId.id");
		return super.find(finder);
	}

	@Override
	public List<Object[]> countSqmy(String dates, String datee) {
		
		Finder finder = Finder.create("select jwhId.id,count(*) from OpinionsReport where flag='1' ");
		finder.append(" and streetId.id = 'bb7c769d-9459-4851-96ab-151eec7c564'");
		
		if(!StringUtil.isEmpty(dates)){
			finder.append(" and convert(nvarchar(15),opDate,23) >= :dates ");
			finder.setParam("dates", dates);
		}
		if(!StringUtil.isEmpty(datee)){
			finder.append(" and convert(nvarchar(15),opDate,23) <= :datee ");
			finder.setParam("datee", datee);
		}
		finder.append(" group by jwhId.id");
		return super.find(finder);
	}

	@Override
	public List<Object[]> countYhdl(String dates, String datee) {
		
		Finder finder = Finder.create("select creator.jwh.id,count(*) from SysLog Where flag='1' ");
		finder.append(" and operateContent = '登录' ");
		if(!StringUtil.isEmpty(dates)){
			finder.append(" and convert(nvarchar(15),createTime,23) >= :dates ");
			finder.setParam("dates", dates);
		}
		if(!StringUtil.isEmpty(datee)){
			finder.append(" and convert(nvarchar(15),createTime,23) <= :datee ");
			finder.setParam("datee", datee);
		}
		finder.append("group by creator.jwh.id");
		return super.find(finder);
	}

}
