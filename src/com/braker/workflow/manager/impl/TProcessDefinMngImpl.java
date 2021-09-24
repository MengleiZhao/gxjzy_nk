package com.braker.workflow.manager.impl;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.Pagination;
import com.braker.common.util.StringUtil;
import com.braker.core.model.Lookups;
import com.braker.core.model.User;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeDataMng;
import com.braker.workflow.manager.TNodeLinkMng;
import com.braker.workflow.manager.TProcessDefinMng;

@Service
@Transactional
public class TProcessDefinMngImpl extends BaseManagerImpl<TProcessDefin> implements TProcessDefinMng {

	@Autowired
	private TNodeDataMng tNodeDataMng;
	@Autowired
	private TNodeLinkMng tNodeLinkMng;
	@Override
	public Pagination list(TProcessDefin tProcessDefin, Integer pageNo,Integer pageSize) {
		try {
			Finder finder=Finder.create(" FROM TProcessDefin WHERE 1=1");
			if(!StringUtil.isEmpty(tProcessDefin.getFPName())){
				finder.append(" AND FPName LIKE :FPName");
				finder.setParam("FPName", "%"+tProcessDefin.getFPName()+"%");
			} 
			if(!StringUtil.isEmpty(tProcessDefin.getDepartCode())){
				finder.append(" AND departCode = :departCode");
				finder.setParam("departCode", tProcessDefin.getDepartCode());
			}
			Pagination p = super.find(finder, pageNo, pageSize);
			List<TProcessDefin> li = (List<TProcessDefin>) p.getList();
			for (int i = 0; i < li.size(); i++) {
				List<TNodeData> nodeList=tNodeDataMng.findByFlowId(li.get(i).getFPId());
				if(nodeList.size()>0){
					//有节点，已经配置了
					li.get(i).setHaveChildrenDate(1);
				}else if(nodeList.size()<=0){
					li.get(i).setHaveChildrenDate(0);
				}
			}
			p.setList(li);
			return p;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
			// TODO: handle exception
		}
		
	}
	
	@Override
	public List<Lookups> getLookupsJson(String categoryCode,String blanked) {
		Finder hql=Finder.create("from Lookups Where flag='1' ");
		hql.append("  and category.code =:pcode ").setParam("pcode", categoryCode);
		if(!StringUtil.isEmpty(blanked)){
			hql.append(" and code<>:code").setParam("code", blanked);
		}
		hql.append(" order by convert(orderNo,DECIMAL)");
		return super.find(hql);
	}

	@Override
	public void save(TProcessDefin tProcessDefin, User user) {
		if(StringUtil.isEmpty(String.valueOf(tProcessDefin.getFPId()))){
			Query query=getSession().createSQLQuery(" select max(F_ORDER_NUM) from T_PROCESS_DEFIN ");
			List<Integer> number = query.list();
			if(number == null || number.size()<=0  || number.get(0)==null){
				tProcessDefin.setFOrderNum(1);
			}else{
				tProcessDefin.setFOrderNum(Integer.valueOf(number.get(0)+1));
			}
			
		}else {	
			
		}
		//tProcessDefin.setFCreateUser(user.getAccountNo());
		tProcessDefin.setFUpdateTime(new Date());
		
		super.merge(tProcessDefin);
	}

	@Override
	public void deleteById(String id) throws Exception{
		tNodeDataMng.deleteByFlowId(Integer.parseInt(id));
		deleteById(Integer.valueOf(id));
	}

	@Override
	public Pagination PMlist(TProcessDefin tProcessDefin, Integer pageNo,Integer pageSize) throws Exception{
		Finder finder=Finder.create(" FROM TProcessDefin WHERE 1=1");
		if(!StringUtil.isEmpty(tProcessDefin.getFPName())){
			finder.append(" AND FPName LIKE :FPName");
			finder.setParam("FPName", "%"+tProcessDefin.getFPName()+"%");
		}else if(!StringUtil.isEmpty(tProcessDefin.getFPCode())){
			finder.append(" AND FPCode LIKE :FPCode");
			finder.setParam("FPCode", "%"+tProcessDefin.getFPCode()+"%");
		}
		return super.find(finder, pageNo, pageSize);
	}
	
	@Override
	public TProcessDefin getByBusiAndDpcode(String FBusiArea, String departCode) {
		String sql = "SELECT * FROM t_process_defin WHERE F_BUSI_AREA='"+FBusiArea+"' AND DEPART_CODE='"+departCode+"'";
		Query query = getSession().createSQLQuery(sql).addEntity(TProcessDefin.class);
		List<TProcessDefin> list = query.list();
		if(list==null || list.size()==0){
			return new TProcessDefin();
		}
		TProcessDefin trd = list.get(0);			//每个工作的流程只有一个所以get(0)
		return trd;
	}
	/**
	 * 根据资源名称获得流程集合
	 */
	@Override
	public List<TProcessDefin> findTProcessDefinsByFBusiArea(String FBusiArea) {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM t_process_defin WHERE F_BUSI_AREA='"+FBusiArea+"' ";
		Query query = getSession().createSQLQuery(sql).addEntity(TProcessDefin.class);
		List<TProcessDefin> list = query.list();
		return list;
	}

	/**
	 * 根据多個资源名称获得流程集合
	 */
	@Override
	public List<TProcessDefin> findTProcessDefinsByFBusiAreas(String FBusiAreas) {
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM t_process_defin WHERE F_BUSI_AREA in("+FBusiAreas+") ";
		Query query = getSession().createSQLQuery(sql).addEntity(TProcessDefin.class);
		List<TProcessDefin> list = query.list();
		return list;
	}


}
