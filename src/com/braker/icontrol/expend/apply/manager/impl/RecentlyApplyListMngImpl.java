package com.braker.icontrol.expend.apply.manager.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.core.model.Lookups;
import com.braker.core.model.MyAssetsModel;
import com.braker.core.model.RecentlyApplyVoIn;
import com.braker.icontrol.assets.storage.model.AssetBasicInfo;
import com.braker.icontrol.expend.apply.manager.RecentlyApplyMng;
import com.braker.icontrol.expend.reimburse.model.DirectlyReimbAppliBasicInfo;


@Service
@Transactional
public class RecentlyApplyListMngImpl extends BaseManagerImpl<DirectlyReimbAppliBasicInfo> implements RecentlyApplyMng{

	/*
	 * 查询最近报销事项
	 */
	@Override
	public List<RecentlyApplyVoIn> getRecentlyApply(ModelMap model,String user,String dName) {
		String sql  = "select fReqTime,fAmount,dName ,id,applyName from "
				+ " (select t1.F_REQ_TIME fReqTime,t1.F_AMOUNT fAmount,t2.F_APP_TYPE dName,t1.F_R_ID id,t1.f_ext_1 applyName from t_reimb_appli_basic_info t1 left join  t_application_basic_info t2 on t1.F_G_CODE=t2.F_G_CODE WHERE t1.F_G_CODE!='' and t2.F_G_CODE!='' and t2.F_USER='"+user+"' and t1.F_FLOW_STAUTS='"+dName+"' "
				+ " union all select F_REQ_TIME ReqTime,F_AMOUNT fAmount,0 dName ,F_DR_ID id,t3.f_ext_1 applyName from t_directly_reimb_appli_basic_info t3 "
				+ " where  t3.F_USER='"+user+"' and t3.F_FLOW_STAUTS='"+dName+"') tab ORDER BY fReqTime DESC limit 8";
		Query query = getSession().createSQLQuery(sql);
		List<RecentlyApplyVoIn> newList = new ArrayList<RecentlyApplyVoIn>();
		List<Object[]> list = query.list();
		for (int i = 0; i < list.size(); i++) {
			RecentlyApplyVoIn bean = new RecentlyApplyVoIn();
			/*bean.set*/
			bean.setfReqTime(String.valueOf(list.get(i)[0]));
			bean.setfAmount(Double.valueOf(String.valueOf(list.get(i)[1]==null?0.00:list.get(i)[1])));
			bean.setdName(String.valueOf(list.get(i)[2]));
			bean.setId(String.valueOf(list.get(i)[3]));
			bean.setApplyName(String.valueOf(list.get(i)[4]));
			newList.add(bean);
		}
		return newList;
	}
	/*
	 * 查询报销总额
	 */
	@Override
	public List<RecentlyApplyVoIn> getCountAndSumApply(ModelMap model,String user, String dName) {
		String sql  = "select count(id) aumId,IFNULL(sum(F_AMOUNT),0) sunAmount from "
				+ " (select t1.F_REQ_TIME,t1.F_AMOUNT,t2.F_APP_TYPE dName,t1.F_R_ID id "
				+ " from t_reimb_appli_basic_info t1 left join  t_application_basic_info t2 on t1.F_G_CODE=t2.F_G_CODE"
				+ " WHERE t1.F_G_CODE!='' and t2.F_G_CODE!='' and t2.F_USER='"+user+"' "
				+ " and t1.F_FLOW_STAUTS='"+dName+"' and YEAR(t2.F_CREATE_TIME)=YEAR(NOW())"
				+ " union all select F_REQ_TIME,F_AMOUNT,0 dName ,F_DR_ID id"
				+ " from t_directly_reimb_appli_basic_info t3 "
				+ " where t3.F_USER='"+user+"' and t3.F_FLOW_STAUTS='"+dName+"' "
				+ " and YEAR(t3.F_CREATE_TIME)=YEAR(NOW())) tab";
		Query query = getSession().createSQLQuery(sql);
		List<RecentlyApplyVoIn> newList = new ArrayList<RecentlyApplyVoIn>();
		List<Object[]> list = query.list();
		for (int i = 0; i < list.size(); i++) {
			RecentlyApplyVoIn bean = new RecentlyApplyVoIn();
			/*bean.set*/
			bean.setCountId(list.get(i)[0].toString());
			bean.setSumAmount(list.get(i)[1].toString());
			newList.add(bean);
		}
		return newList;
	}
	/*
	 * 查询我的资产
	 */

	@SuppressWarnings("unchecked")
	@Override
	public List<MyAssetsModel> finMyAssets(ModelMap model, String user) {
		String sql = "SELECT tarl.F_ASS_NAME tarlNmae, tarl.F_ASS_RECE_CODE tarlCode "
				+ " FROM t_asset_rece_list tarl  WHERE tarl.F_ASS_RECE_CODE IN ( "
				+ "SELECT tar.F_ASS_RECE_CODE tarCode  FROM t_asset_rece tar "
				+ " WHERE tar.F_RECE_USER_ID = '"+user+"' "
				+ " AND tar.F_ASS_TYPE = 'ZCLX-02'  AND tar.F_FLOW_STAUTS = 9);";
		Query query = getSession().createSQLQuery(sql);
		List<MyAssetsModel> newList = new ArrayList<MyAssetsModel>();
		List<Object[]> list = query.list();
		for (int i = 0; i < list.size(); i++) {
			MyAssetsModel bean = new MyAssetsModel();
			bean.setTarlNmae(String.valueOf(list.get(i)[0]));
			bean.setTarlCode(String.valueOf(list.get(i)[1]));
			newList.add(bean);
		}
		return newList;
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<MyAssetsModel> finMyAssetsNumber(ModelMap model, String user) {
		String sql = "SELECT count(tarl.F_ASS_NAME) tarlNmaeNumber "
				+ " FROM t_asset_rece_list tarl  WHERE tarl.F_ASS_RECE_CODE IN ( "
				+ "SELECT tar.F_ASS_RECE_CODE tarCode  FROM t_asset_rece tar "
				+ " WHERE tar.F_RECE_USER_ID = '"+user+"' "
				+ " AND tar.F_ASS_TYPE = 'ZCLX-02'  AND tar.F_FLOW_STAUTS = 9);";
		Query query = getSession().createSQLQuery(sql);
		List<MyAssetsModel> newList;
		try {
			newList = new ArrayList<MyAssetsModel>();
			List<Object[]> list = query.list();
			for (int i = 0; i < list.size(); i++) {
				MyAssetsModel bean = new MyAssetsModel();
				bean.setTarlNmaeNumber(String.valueOf(list.get(i)));
				newList.add(bean);
			}
			return newList;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/*
	 * 查询我的资产
	 */
	
	@SuppressWarnings("unchecked")
	@Override
	public List<AssetBasicInfo> finRecipientsOfAssets(ModelMap model, String user,
			String fAssStauts,String fAssCode) {
		String sql = "select F_ASS_NAME,F_ASS_STAUTS,F_ASS_ID,F_ASS_CODE from t_asset_basic_info ta where F_USE_NAME_ID='"+user+"' and F_ASS_STAUTS='"+fAssStauts+"'";
		Query query = getSession().createSQLQuery(sql);
		List<AssetBasicInfo> newList = new ArrayList<AssetBasicInfo>();
		List<Object[]> list = query.list();
		for (int i = 0; i < list.size(); i++) {
			AssetBasicInfo bean = new AssetBasicInfo();
			bean.setfAssName(list.get(i)[0].toString());
			Lookups lookups=new Lookups();
			lookups.setName(list.get(i)[1].toString());
			bean.setfAssStauts(lookups);
			bean.setfAssId((Integer) list.get(i)[2]);
			bean.setfAssCode( list.get(i)[3].toString());
			newList.add(bean);
		}
		return newList;
	}
}
