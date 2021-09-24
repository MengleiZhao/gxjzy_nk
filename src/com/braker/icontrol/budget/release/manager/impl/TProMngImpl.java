package com.braker.icontrol.budget.release.manager.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.core.model.User;
import com.braker.icontrol.budget.arrange.entity.DepartProjectOut;
import com.braker.icontrol.budget.performancemanage.selfrule.model.SelfEvalConf;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.budget.release.entity.TBudgetaryIndicPro;
import com.braker.icontrol.budget.release.entity.TBudgetaryIndicProItf;
import com.braker.icontrol.budget.release.manager.TProMng;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;


/**
 * 基本支出预算指标下达（二下）service的实现类
 * @author 叶崇晖
 * @createtime 2018-07-25
 * @updatetime 2018-07-25
 */
@Service
@Transactional
public class TProMngImpl extends BaseManagerImpl<TBudgetaryIndicPro> implements TProMng{
	
	/*
	 * 通过明细ID查找部门名称
	 * @author 叶崇晖
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 * @param bId 明细主键
	 */
	@Override
	public String findDepartNameByBId(Integer bId) {
		Finder finder = Finder.create(" FROM TProBasicInfo WHERE FProId=(SELECT proId FROM TBudgetaryIndicPro WHERE bId=(SELECT bId FROM TBudgetaryIndicProItf WHERE biId='"+bId+"'))");
		List<TProBasicInfo> li = super.find(finder);
		return li.get(0).getFProAppliDepart();
	}

	@Override
	public TBudgetaryIndicPro save(TBudgetaryIndicPro bean, User user) {
		
		bean.setUserId(user.getId());
		bean.setOpTime(new Date());
		return (TBudgetaryIndicPro)super.saveOrUpdate(bean);
	}
	
	@Override
	public void save(List<TBudgetaryIndicPro> list, User user) {
		
		if (list != null && list.size() > 0) {
			for (TBudgetaryIndicPro pro: list) {
				save(pro, user);
			}
		}
	}

	@Override
	public float save(String saveType, TBudgetaryIndicPro proRelease, User user,
			String yearOutJson, String leastOutJson) throws JsonParseException, JsonMappingException, IOException {

		//初始化
		List<TBudgetaryIndicPro> yearContainer = new ArrayList<>();
		List<TBudgetaryIndicPro> leastContainer = new ArrayList<>();
		ObjectMapper mapper = new ObjectMapper();
//		//保存指标下达
//		TBudgetaryIndicPro xmzb = save(proRelease, user);
		//保存年度支出
		List<DepartProjectOut> yearList = mapper.readValue(yearOutJson, new TypeReference<List<DepartProjectOut>>(){});
		analysisAndAdd(proRelease,yearContainer,yearList);
		save(yearContainer,user);
		//保存历年支出
		List<DepartProjectOut> leastList = mapper.readValue(leastOutJson, new TypeReference<List<DepartProjectOut>>(){});
		analysisAndAdd(proRelease,leastContainer,leastList);
		save(yearContainer,user);
		
		return 0;
	}
	
	/**
	 * 生成需要保存的项目支出下达明细
	 * @param container 容器
	 * @param list 需要解析的数据
	 */
	private void analysisAndAdd(TBudgetaryIndicPro proRelease, List<TBudgetaryIndicPro> container,
			List<DepartProjectOut> list) {
		
		if (list != null && list.size() > 0) {
			for (DepartProjectOut out: list) {
				TBudgetaryIndicPro bean = new TBudgetaryIndicPro();
				//年度
				bean.setYaers(proRelease.getYaers());
				//下达方式
				bean.setArrivalType(proRelease.getArrivalType());
				//该部门下达金额
				if (!StringUtil.isEmpty(out.getPro_money()))
					bean.setAmount(Double.valueOf(out.getPro_money()));
				//下达人id
				bean.setUserId(proRelease.getUserId());
				//下达时间
				bean.setOpTime(proRelease.getOpTime());
				//关联项目
				bean.setProId(out.getFProId());
				container.add(bean);
			}
		}
	}
	

	
	/**
	 *根据项目fpid  查询二下信息
	 * @author 冉德茂
	 * @createtime 2018-08-30
	 * @updatetime 2018-08-30
	 */
	@Override
	public TBudgetaryIndicPro getConfByFpId(Integer id) {
		Finder finder = Finder.create(" FROM TBudgetaryIndicPro WHERE proId='"+id+"'");
		List<TBudgetaryIndicPro> li =  super.find(finder);
		return li.get(0);
	}

	@Override
	public List<TBudgetaryIndicPro> getDataList(String id, User user) {

		List<TBudgetaryIndicPro> resList = new ArrayList<>();
		
		Finder f = Finder.create(" from TBudgetaryIndicPro where info.pid=:infoId ").setParam("infoId", id);
		List<TBudgetaryIndicPro> list = super.find(f);
		
		return list;
	}

	
	
	
}
