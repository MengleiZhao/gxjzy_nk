package com.braker.quartz.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.quartz.QuartzManager;
import com.braker.quartz.model.Wsdoc;
import com.braker.quartz.service.WsdocService;
@Service
@Transactional
public class WsdocServiceImpl  extends BaseManagerImpl<Wsdoc>  implements WsdocService{
	@Autowired
	QuartzManager quartzManager;
	/*
	 * 分页查询
	 * @author 安达
	 * @createtime 2019-03-11
	 * @updatetime 2019-03-11
	 */
	@Override
	public Pagination pageList(Wsdoc bean, int pageNo, int pageSize) {

		Finder finder =Finder.create("  FROM Wsdoc WHERE 1=1 ");
		if(!StringUtil.isEmpty(bean.getJobdetailname())){ //按Job名称模糊查询
			finder.append(" AND jobdetailname LIKE :jobdetailname");
			finder.setParam("jobdetailname", "%"+bean.getJobdetailname()+"%");
		}
		if(!StringUtil.isEmpty(bean.getState())){ //如果计划任务不存则为1 存在则为0
			finder.append(" AND state = :state");
			finder.setParam("state", bean.getState());
		}
		finder.append(" order by id desc ");
		return super.find(finder,pageNo,pageSize);
	}
	
	@Override
	public List<Wsdoc> getAllTarger() {
		Finder finder = Finder.create(" FROM Wsdoc ");
		List<Wsdoc> li = super.find(finder);
		return li;
	}

	@Override
	public List<Wsdoc> getTargerByProperty(Wsdoc wsdoc) {
		// TODO Auto-generated method stub
		Finder f = Finder.create(" from Wsdoc where triggername = '" + wsdoc.getTriggername()+"'");
		f.append(" order by id desc");
		return super.find(f);
	}

	@Override
	public void saveTarger(Wsdoc wsdoc) {
		//如果没有传过来ID，说明是插入操作
		if(StringUtil.isEmpty(wsdoc.getId())){
			if(StringUtil.isEmpty(wsdoc.getTriggername())){
				String triggername=UUID.randomUUID().toString().replace("-", "");
				wsdoc.setTriggername(triggername);
			}
			if(wsdoc.getState()==null){
				wsdoc.setState("1");
			}
			if(wsdoc.getConcurrent()==null){
				wsdoc.setConcurrent("1");
			}
			super.save(wsdoc);
		}else{
			//修改操作
			super.updateDefault(wsdoc);
		}
		// TODO Auto-generated method stub
		quartzManager.configQuatrz(wsdoc);
	}

	@Override
	public void deleteTargerByProperty(Wsdoc wsdoc) {
		Wsdoc bean=findById(wsdoc.getId());
		bean.setState("0");
		super.delete(bean);
		quartzManager.configQuatrz(bean);
		// TODO Auto-generated method stub
		
	}

	@Override
	public Wsdoc findById(String id) {
		// TODO Auto-generated method stub
		try {
			Wsdoc bean=	(Wsdoc)super.findUniqueByProperty("id",id);
			return bean;
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return null;
	}

	@Override
	public void deleteTargerByTriggerName(String triggername) {
		Finder f = Finder.create(" from Wsdoc where triggername = '" + triggername+"'");
		f.append(" order by id desc");
		
		List<Wsdoc> list = super.find(f);
		for(Wsdoc wsdoc:list){
			deleteTargerByProperty(wsdoc);
		}
	}

}
