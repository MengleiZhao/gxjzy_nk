package com.braker.icontrol.cgmanage.cgexpert.manager.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cgexpert.manager.ExpertExtractMng;
import com.braker.icontrol.cgmanage.cgexpert.model.ExtractRecordInfo;

@Service
@Transactional
public class ExpertExtractMngImpl extends BaseManagerImpl<ExtractRecordInfo> implements ExpertExtractMng  {
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private PrivateInforMng privateInforMng;
	@Override
	public void save(ExtractRecordInfo bean, User user) throws Exception{
		Date d=new Date();
		bean.setfUserID(user.getId());
		bean.setfUserName(user.getName());
		bean.setfDeptID(user.getDpID());
		bean.setfDeptName(user.getDepartName());
		bean.setfRecTime(d);
		//抽取成功推送消息
		if(bean.getfFlag().equals("1")){
			//日期格式化（消息推送中使用）
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String title="专家库抽取成功";
			String msg="您于 "+sdf.format(d)+" 抽取领域为："+bean.getfField()+";抽取个数为："+bean.getfPersonNum()+"; 抽取专家成功. &nbsp;&nbsp;&nbsp;&nbsp;<a href=\"#\" onclick=\"record_detailMsg('"+bean.getfResult()+"')\">查看详情</a>";
			privateInforMng.setMsg(title, msg,user.getId(),"2");
		}
		super.saveOrUpdate(bean); //新增
	}

	@Override
	public Pagination pageList(ExtractRecordInfo bean, int pageNo, int pageSize) {
		Finder finder=Finder.create(" FROM ExtractRecordInfo where 1=1");
		if(!StringUtil.isEmpty(bean.getfUserName())){
			finder.append(" AND fUserName =:fUserName");
			finder.setParam("fUserName", bean.getfUserName());
		}
		finder.append(" ORDER BY fExId desc");
		Pagination p=super.find(finder, pageNo, pageSize);
		List<ExtractRecordInfo> list=(List<ExtractRecordInfo>)p.getList();
		if(list.size()!=0){
			for(int x=0; x<list.size(); x++) {
				//序号设置	
				list.get(x).setNum((x+1)+(pageNo-1)*pageSize);	
			}
		}
		return p;
	}

}
