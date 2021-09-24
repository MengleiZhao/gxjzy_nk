package com.braker.icontrol.cgmanage.cginquiries.manager.impl;

import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.cgmanage.cginquiries.manager.CgInquiriesMng;
import com.braker.icontrol.cgmanage.cginquiries.model.InqWinningList;
import com.braker.icontrol.cgmanage.cginquiries.model.InqWinningRef;

/**
 * 询比价登记的service实现类
 * @author 冉德茂
 * @createtime 2018-08-01
 * @updatetime 2018-08-01
 */
@Service
@Transactional
public class CgInquiriesMngImpl extends BaseManagerImpl<InqWinningRef> implements CgInquiriesMng {
	
	


	@Override
	public String save(InqWinningRef bean, String mingxi, String files, User user, String fpid, String fwid, String fmainid) {
		
		//查询数据库是否已存在该采购和供应商的映射信息  若有 。。。
		if (StringUtil.isEmpty(fmainid)) {//新增
			//保存映射表的fpid和fwid  然後獲取主id  進行报价单的保存
			bean.setCreator(user.getName());
			bean.setCreateTime(new Date());
			bean.setFpId(Integer.valueOf(fpid));
			bean.setFwId(Integer.valueOf(fwid));
			bean = (InqWinningRef) super.saveOrUpdate(bean);
			
		} else {//修改

			//修改人、修改时间
			bean.setFmainId(Integer.valueOf(fmainid));//判断有没有主键
			bean.setUpdator(user.getAccountNo());
			bean.setUpdateTime(new Date());
			bean.setFpId(Integer.valueOf(fpid));
			bean.setFwId(Integer.valueOf(fwid));
			bean = (InqWinningRef) super.saveOrUpdate(bean);
		}

		//获得老的明细
		List<Object> oldmx = getMingxi("InqWinningList", "fmainId", bean.getFmainId());
		
		//获取现有的明细
		List mx = getMingXiJson(mingxi, InqWinningList.class);
		//比较新老明细的不同
		for (int i = oldmx.size()-1; i >= 0; i--) {
			InqWinningList oldgad = (InqWinningList) oldmx.get(i);
			for (int j = 0; j < mx.size(); j++) {
				InqWinningList gad = (InqWinningList) mx.get(j);
				if(gad.getFmainId()!=null){
					if(gad.getFmainId()==oldgad.getFmainId()){
						oldmx.remove(i);
					}
				}
			}
		}
		//删除在新明细中没有的老明细
		if(oldmx.size()>0){
			for (int i = 0; i < oldmx.size(); i++) {
				InqWinningList oldgad = (InqWinningList) oldmx.get(i);
				super.delete(oldgad);
			}
		}
		//保存新的明细
		for (int j = 0; j < mx.size(); j++) {
			InqWinningList gad = (InqWinningList) mx.get(j);
			gad.setFproAmount(gad.getFnum()+"");
			gad.setFproVerdsion(gad.getFspecifModel());
			gad.setFmainId(bean.getFmainId());
			gad.setCreator(user.getAccountNo());
			gad.setCreateTime(new Date());
			if(StringUtils.isEmpty(gad.getFisImpe())){
				gad.setFisImpe("否");
			}
			super.merge(gad);
		}
		
		//获取最新的报价清单信息   给映射表的最终报价赋值
		List<Object> nowmx = getMingxi("InqWinningList", "fmainId", bean.getFmainId());
		double num=0;
		for(int k=0;k<nowmx.size();k++){
			InqWinningList list = (InqWinningList)nowmx.get(k);
			String finalPrice=list.getFfinalPrice();
			if(StringUtil.isEmpty(finalPrice)){
				return "请填写供货清单价格";
				
			}
			num+=Double.parseDouble(finalPrice);
		}
		bean.setFfinalPrice(String.valueOf(num));
		super.saveOrUpdate(bean);
		return "操作成功";
		
	}

	
	/*
	 * 根据id删除
	 * @author 冉德茂
	 * @createtime 2018-08-02
	 * @updatetime 2018-08-02
	 */
	@Override
	public void delete(Integer id) {
		//id 是报价清单表的外键ID可以有多个   是采购和供应商的映射表的主键ID只有一个？？?
		//查询报价清单表  进行删除
		List<Object> baojia = getMingxi("InqWinningList", "fmainId", id);
		//删除已存在中标和供应商的映射信息
		for (int i = baojia.size()-1; i >= 0; i--) {
			InqWinningList oldgad = (InqWinningList) baojia.get(i);
			super.delete(oldgad);
		}
		
		//清除报价和供应商映射信息
		List<Object> ref = getMingxi("InqWinningRef", "fmainId", id);
		//删除已存在的中标和评标专家的映射信息
		for (int i = ref.size()-1; i >= 0; i--) {
			InqWinningRef oldexp = (InqWinningRef) ref.get(i);
			super.delete(oldexp);
		}
	}
		
	/*
	 * 报价清单查询
	 * @author 冉德茂
	 * @createtime 2018-07-13
	 * @updatetime 2018-07-13
	 */
	public List<Object> getMingxi(String tableName ,String idName ,Integer pid) {
		Finder finder = Finder.create(" FROM " + tableName + " WHERE " + idName + "="+pid);
		return super.find(finder);
	}

	/*
	 * 获取明细的Json对象
	 * @author 冉德茂
	 * @createtime 2018-08-01
	 * @updatetime 2018-08-01
	 */
	public List getMingXiJson(String mingxi, Class tableClass) {
		//获取明细的Json对象
		List mx = null;
		JSONArray array =JSONArray.fromObject("["+mingxi.toString()+"]");
		mx = (List)JSONArray.toList(array, tableClass);
		return mx;
	}


	/*
	 * 分页查询数据
	 * @author 冉德茂
	 * @createtime 2018-08-01
	 * @updatetime 2018-08-01
	 */
	@Override
	public Pagination pageList(InqWinningRef bean, Integer page, Integer rows, User user, String pid) {		
		Finder finder =Finder.create(" FROM InqWinningRef WHERE fpId='"+pid+"' ");

		return super.find(finder,page, rows);
	}



	/*
	 * 根据pid查询所有的供应商信息
	 * @author 冉德茂
	 * @createtime 2018-08-01
	 * @updatetime 2018-08-01
	 */
	@Override
	public List<InqWinningRef> findByPid(Integer pid) {
		Finder finder = Finder.create(" FROM InqWinningRef WHERE fpId="+pid+" ");
		return super.find(finder);
	}

	/*
	 * 根据wid和pid判断同一采购批次下的供应商是否登记
	 * @author 冉德茂
	 * @createtime 2018-08-04
	 * @updatetime 2018-08-04
	 */
	@Override
	public List<InqWinningRef> findByPidWid(Integer fpid, Integer fwid) {
		Finder finder = Finder.create(" FROM InqWinningRef WHERE fpId="+fpid+" AND fwId="+fwid+"  ");
		return super.find(finder);
	}
	

}

	
	
	


