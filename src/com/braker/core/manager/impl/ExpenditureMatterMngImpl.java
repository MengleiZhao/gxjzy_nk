package com.braker.core.manager.impl;

import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.AreaMng;
import com.braker.core.manager.ExpenditureMatterMng;
import com.braker.core.model.AreaBasicInfo;
import com.braker.core.model.ExpenditureMatter;
import com.braker.core.model.Role;
import com.braker.core.model.User;
import com.braker.workflow.entity.TProcessDefin;

@Service
@Transactional
public class ExpenditureMatterMngImpl extends BaseManagerImpl<ExpenditureMatter> implements ExpenditureMatterMng{
	@Autowired
	private AreaMng areaMng;

	@Override
	public Pagination list(ExpenditureMatter bean, String sort, String order,Integer pageNo, Integer pageSize) {
		Finder finder=Finder.create(" FROM ExpenditureMatter WHERE 1=1");
		if(!StringUtil.isEmpty(bean.getFeType())){
			finder.append(" and feType = :feType").setParam("feType", bean.getFeType());
		}
		if(!StringUtil.isEmpty(bean.getFeName())){
			finder.append(" and feName like :feName").setParam("feName", "%"+bean.getFeName()+"%");
		}
		if(!StringUtil.isEmpty(bean.getFeStandard())){
			finder.append(" and feStandard like :feStandard").setParam("feStandard", "%"+bean.getFeStandard()+"%");
		}
		finder.append(" order by feType");
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public void saveEM(ExpenditureMatter bean,User user) {
		if(StringUtil.isEmpty(String.valueOf(bean.getFeId()))){
			bean.setCreateTime(new Date());
			bean.setCreator(user.getAccountNo());
		}else {
			bean.setUpdateTime(new Date());
			bean.setUpdator(user.getAccountNo());
		}
		super.saveOrUpdate(bean);
		
	}

	@Override
	public Integer findbycode(String code) {
		Finder finder=Finder.create(" from ExpenditureMatter where feCode='"+code+"'");
		return super.find(finder).size();
	}

	@Override
	public List<ExpenditureMatter> findall() {
		Finder finder=Finder.create(" from ExpenditureMatter ");
		return super.find(finder);
	}

	/**
	 * @author 叶崇晖
	 * @param type支出事项的类型
	 * @return
	 */
	@Override
	public List<ExpenditureMatter> getExpenditureMatterByType(String type, User user, String meetingType, String trainingType, String placeEnd) {
		Finder finder = Finder.create(" FROM ExpenditureMatter WHERE feType='"+type+"'");
		
		if("2".equals(type)) {				//会议
			/*当type=2（会议）时fext2储存值有（1、代表一类会议  2、代表二类会议  3、代表三四类会议）四种会议类型对应会议申请中的会议类型下拉框中的4个值。若有修改需要在expenditureMatter_add.jsp中修改代码。*/
			if(!StringUtil.isEmpty(meetingType)) {
				meetingType = "4".equals(meetingType)?"3":meetingType;//meetType为前台会议信息信息中的会议类型返回后台的值，因国家标准3类4类会议的开支标准相同所以当返回4时修改为3统一查询
				finder.append(" AND fext2='"+meetingType+"'");
			}
		}
		if("3".equals(type)) {				//培训
			/*当type=3（培训）时fext2储存值有（1、代表一类培训  2、代表二类培训  3、代表三类培训）三种培训类型对应培训申请中的培训类型下拉框中的3个值。若有修改需要在expenditureMatter_add.jsp中修改代码。*/
			if(!StringUtil.isEmpty(trainingType)) {
				finder.append(" AND fext2='"+trainingType+"'");
			}
		}
		if("4".equals(type)) {				//差旅
			/*当type=4(差旅)时fext2储存的值为城市的等级（城市地区类见AreaBasicInfo）由前台返回后台的目的地id(placeEnd)查询到相应的城市，得到城市的等级*/
			if(!StringUtil.isEmpty(placeEnd)) {
				List<AreaBasicInfo> areaList = areaMng.findByCode(placeEnd);//根据placeEnd（目的地id）查询城市
				if(areaList.size()>0) {
					String level = areaList.get(0).getLevel();
					finder.append(" AND (fext2='"+level+"' OR fext2='')");
				}
			}
		}
		
		
		if(!"2".equals(type)&&!"3".equals(type)&&!"5".equals(type)&&!"6".equals(type)&&!"7".equals(type)) {
			List<Role> roleList = user.getRoles();
			String roleIds = "";
			for (int i = 0; i < roleList.size(); i++) {
				if(i==0 && roleList.size() !=1) {
					roleIds = roleIds + " AND (roleIds='*' OR roleIds like '%"+roleList.get(i).getId()+"%'";
				} else if(i==0 && roleList.size() ==1) {
					roleIds = roleIds + " AND (roleIds='*' OR roleIds like '%"+roleList.get(i).getId()+"%')";
				} else if(i==(roleList.size()-1)) {
					roleIds = roleIds + " OR roleIds like '%"+roleList.get(i).getId()+"%')";
				} else {
					roleIds = roleIds + " OR roleIds like '%"+roleList.get(i).getId()+"%'";
				}
			}
			finder.append(roleIds);
		}
		return super.find(finder);
	}

}
