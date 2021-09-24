package com.braker.icontrol.expend.apply.manager.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.Depart;
import com.braker.icontrol.expend.apply.manager.ApplicationBasicInfoMng;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.apply.model.MeetingAppliInfo;

/**
 * 事前申请基本信息的service实现类
 * @author 叶崇晖
 * @createtime 2018-08-13
 * @updatetime 2018-08-13
 */
@Service
@Transactional
public class ApplicationBasicInfoMngImpl extends BaseManagerImpl<ApplicationBasicInfo> implements ApplicationBasicInfoMng {

	/*
	 * 根据gCode（直接申请流水号）查询基本信息
	 * @author 叶崇晖
	 * @createtime 2018-08-13
	 * @updatetime 2018-08-13
	 */
	@Override
	public ApplicationBasicInfo getByGCode(String gCode) {
		Finder finder = Finder.create(" FROM ApplicationBasicInfo WHERE gCode='"+gCode+"'");
		List<ApplicationBasicInfo> li = super.find(finder);
		return li.get(0);
	}

	

	/*
	 * 培训部门列表信息
	 * @author 焦广兴
	 * @createtime 2019-03-21
	 */
	@Override
	public Pagination getData24(Depart depart,String year, int pageNo,int pageSize,String searchName,String searchContent) {
		try{
		StringBuilder sbf = new StringBuilder("select a.* FROM t_application_basic_info a right join t_reimb_appli_basic_info b "
				+ "on a.f_g_code =b.f_g_code where a.F_APP_TYPE='3' and b.F_CASHIER_TYPE='1' and b.F_STAUTS=1");
		//权限
		if (depart != null) {
			String departType = depart.getType();
			if (Depart.TYPE_COM.equals(departType)) {
				//公司登录，获得所有子部门的
				sbf.append(" AND b.F_DEPT IN (SELECT PID FROM SYS_DEPART WHERE PARENTID='" + depart.getId() + "' AND TYPE='" + Depart.TYPE_DEPT + "') ");
			} else if (Depart.TYPE_DEPT.equals(departType)) {
				//部门登录，获取所属公司下所有子部门的
				sbf.append(" AND b.F_DEPT IN (SELECT PID FROM SYS_DEPART WHERE PARENTID='" + depart.getParent().getId() + "' AND TYPE='" + Depart.TYPE_DEPT + "') ");
			}
		}
		sbf.append(" AND year(a.F_REQ_TIME)='"+year+"'");
		//按培训名称模糊搜索
		if(!StringUtil.isEmpty(searchName)){
			sbf.append(" AND a.F_G_NAME LIKE('%"+searchName+"%')");
		}
		//按培训内容模糊搜索
		if(!StringUtil.isEmpty(searchContent)){
			sbf.append(" AND a.F_REASON LIKE('%"+searchContent+"%')");
		}
		sbf.append(" order by a.F_REQ_TIME desc");
		String str=sbf.toString();
		Pagination p = super.findBySql(new ApplicationBasicInfo(), str, pageNo, pageSize);
		List<ApplicationBasicInfo> dataList = (List<ApplicationBasicInfo>) p.getList();
		if (dataList != null && dataList.size() > 0) {
			int i = 0;
			for (ApplicationBasicInfo log: dataList) {
				log.setNum(pageNo * pageSize + i - (pageSize-1));
				i++;
			}
		}
			return p;
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 某项目差旅列表记录
	 * @author 焦广兴
	 * @createtime 2019-03-21
	 * @updatetime 2019-04-03
	 */
	@Override
	public Pagination getData25(Depart depart,String year,int pageNo, int pageSize,String searchGCode, String searchGName) {
		StringBuffer sbf = new StringBuffer("select a.* FROM t_application_basic_info a right join t_reimb_appli_basic_info b "
				+ "on a.f_g_code =b.f_g_code where b.F_DEPT = '"+depart.getId()+"' and a.F_APP_TYPE='4' and b.F_CASHIER_TYPE='1' ");
		//sbf.append(" and a.F_INDEX_ID='"+indexType+"'");
		if(searchGCode!=null && searchGCode.length()>0){
			sbf.append(" AND a.F_G_CODE LIKE ('%"+searchGCode+"%')");
		}
		if(searchGName!=null && searchGName.length()>0){
			sbf.append(" AND a.F_G_NAME LIKE ('%"+searchGName+"%')");
		}
		sbf.append(" AND DATE_FORMAT(a.f_req_time,'%Y-%m')='"+year+"'");
		sbf.append(" order by a.F_REQ_TIME desc");
		String str=sbf.toString();
		
		Pagination p = super.findBySql(new ApplicationBasicInfo(), str, pageNo, pageSize);
		List<ApplicationBasicInfo> dataList = (List<ApplicationBasicInfo>) p.getList();
		if (dataList != null && dataList.size() > 0) {
			int i = 0;
			for (ApplicationBasicInfo log: dataList) {
				log.setNum(pageNo * pageSize + i - (pageSize-1));
				i++;
			}
		}
		return p;
	}
}
