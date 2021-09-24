package com.braker.icontrol.assets.maintain.manager.Impl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.LookupsMng;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;
import com.braker.icontrol.assets.maintain.manager.MaintainMng;
import com.braker.icontrol.assets.maintain.manager.MaintainRegMng;
import com.braker.icontrol.assets.maintain.model.Maintain;
import com.braker.icontrol.assets.maintain.model.MaintainReg;

@Service
public class MaintainRegMngImpl extends BaseManagerImpl<MaintainReg> implements MaintainRegMng{

	@Autowired
	private MaintainMng maintainMng;
	@Autowired
	private LookupsMng lookupsMng;
	
	@Override
	public Pagination registrationJson(MaintainReg maintainReg, User user,String sort, String order, Integer pageNo, Integer pageSize) {
		Finder finder =Finder.create("FROM MaintainReg WHERE fRegstauts=1 AND fMainRegUserID='"+user.getId()+"'");
		if(!StringUtil.isEmpty(maintainReg.gettMianRegCode())){
			finder.append(" AND tMianRegCode like :tMianRegCode");
			finder.setParam("tMianRegCode","%"+maintainReg.gettMianRegCode()+"%");
		}
		if(!StringUtil.isEmpty(maintainReg.getfMainRegUser())){
			finder.append(" AND fMainRegUser like :fMainRegUser");
			finder.setParam("fMainRegUser","%"+maintainReg.getfMainRegUser()+"%");
		}
		if(maintainReg.getfRegTimeStart()!=null){
			finder.append(" AND DATE_FORMAT(fRegTime,'%Y-%m-%d')<="+maintainReg.getfRegTimeStart());
		}
		if(maintainReg.getfRegTimeEnd()!=null){
			finder.append(" AND DATE_FORMAT(fRegTime,'%Y-%m-%d')>="+maintainReg.getfRegTimeEnd());
		}
		finder.append(" order by fRegTime desc");
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public void saveRegistration(MaintainReg maintainReg, User user) {
		if(StringUtil.isEmpty(maintainReg.gettMianRegCode())){
			//新增
			maintainReg.setCreateTime(new Date());
			maintainReg.setCreator(user.getAccountNo());
		}else{
			//修改
			maintainReg.setUpdateTime(new Date());
			maintainReg.setUpdator(user.getAccountNo());
		}
		maintainReg.setfMainRegID(user.getDepart().getId());
		maintainReg.setfMainRegDept(user.getDepartName());
		maintainReg.setfMainRegUserID(user.getId());
		maintainReg.setfMainRegUser(user.getName());
		maintainReg.setfRegTime(new Date());
		//查询维修单信息
		Maintain maintain = maintainMng.findById(Integer.valueOf(maintainReg.getMainID()));
		maintainReg.setMaintain(maintain);
		Lookups lookup = lookupsMng.findByLookCode(maintainReg.getMainWhether());
		maintainReg.setfMainWhether(lookup);
		maintainReg.setfRegstauts("1");
		//更改原来登记单的登记状态为“1”
		maintain.setfRegStauts("1");
		//填写原来的维修单里的维修费用，以实际登记的为准
		maintain.setfMainAmount(maintainReg.getfRegAmount());
		super.saveOrUpdate(maintainReg);
		super.merge(maintain);
	}

	@Override
	public void deleteReg(String id) {
		MaintainReg maintainReg = super.findById(Integer.valueOf(id));
		maintainReg.setfRegstauts("99");
		Maintain maintain = maintainReg.getMaintain();
		maintain.setfRegStauts("0");
		super.saveOrUpdate(maintainReg);
		super.merge(maintain);
	}

	
}
