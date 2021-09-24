/**
 * <p>Title: AnalysisProBasicInfoMngImpl.java</p>  
 * <p>Description: </p>   
 * <p>Company: 天职</p>  
 * @author 陈睿超
 * @createtime 2020年2月27日
 */
package com.braker.icontrol.budget.data.manager.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.icontrol.budget.data.entity.AnalysisProBasicInfo;
import com.braker.icontrol.budget.data.entity.AnalysisProExpendDetail;
import com.braker.icontrol.budget.data.manager.AnalysisProBasicInfoMng;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;

/**
 * <p>Title: AnalysisProBasicInfoMngImpl</p>  
 * <p>Description: </p>  
 * @author 陈睿超
 * @date 2020年2月27日  
 */
@Service
@Transactional
public class AnalysisProBasicInfoMngImpl extends BaseManagerImpl<AnalysisProBasicInfo> implements AnalysisProBasicInfoMng{

	
	@Autowired
	private TProExpendDetailMng proExpendDetail;
	
	
	/* 
	 * <p>Title: copyProBasicInfo</p>
	 * <p>Description: </p>
	 * @param tProBasicInfo
	 * @param aanalysisType
	 * @see AnalysisProBasicInfoMng#copyProBasicInfo(com.braker.icontrol.budget.project.entity.TProBasicInfo, java.lang.Integer) 
	 * @author 陈睿超
	 * @createtime 2020年2月27日
	 * @updator 陈睿超
	 * @updatetime 2020年03月02日
	 */
	@Override
	public void copyProBasicInfo(TProBasicInfo tProBasicInfo,Integer aanalysisType) {
		//保存一条数据到数据分析的项目信息表里
		AnalysisProBasicInfo abean = new AnalysisProBasicInfo();
		BeanUtils.copyProperties(tProBasicInfo, abean);
		abean.setFAnalysisType(aanalysisType);
		//根据预算主键查询支出明细
		//proExpendDetail.getByProId(tProBasicInfo.getFProId());
		List<TProExpendDetail> list = proExpendDetail.getByProId(tProBasicInfo.getFProId());
		List<AnalysisProExpendDetail> Alist = new ArrayList<AnalysisProExpendDetail>();
		for (int i = 0; i < list.size(); i++) {//保存支出明细信息
			TProExpendDetail pbean = list.get(i);
			AnalysisProExpendDetail aEbean = new AnalysisProExpendDetail();
			BeanUtils.copyProperties(pbean, aEbean);
			aEbean.setFAnalysisType(aanalysisType);
			Alist.add(aEbean);
			super.merge(aEbean);
		}
		abean.setExpendList(Alist);
		super.merge(abean);//保存预算信息
	}

}
