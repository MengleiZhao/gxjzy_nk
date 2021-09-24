package com.braker.icontrol.budget.project.manager.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.util.StringUtil;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
/**
 * 
 * <p>Description: 项目支出明细实现类</p>
 * @author:安达
 * @date： 2019年6月13日下午7:38:50
 */
@Service
public class TProExpendDetailMngImpl extends BaseManagerImpl<TProExpendDetail> implements TProExpendDetailMng {

	
	@Override
	public int save(Integer FProId, List<TProExpendDetail> expendList)
			throws Exception {
		//先删除老的明细
		deleteByProId(FProId);
		//新增新的明细
		if(expendList!=null){
			for(TProExpendDetail expend:expendList){
					expend.setFProId(FProId);
					String expCode="ZB"+StringUtil.random8();
					expend.setExpCode(expCode);
					this.merge(expend);
			}
		}
		return 0;
	}
	/**
	* 
	* @Title: deleteByProId 
	* @Description: 根据项目id删除老的资金来源明细
	* @param proId  //项目id
	* @return void    返回类型 
	* @date： 2019年5月23日下午8:47:11 
	* @throws
	 */
	private void deleteByProId(Integer proId){
		Query query=getSession().createSQLQuery(" delete from T_PRO_EXPEND_DETAIL where F_PRO_ID="+proId);
		query.executeUpdate();
	}
	

	/**
	 * 根据项目id获取项目支出明细
	 * @author 叶崇晖
	 * @param FProId项目id
	 * @return
	 */
	@Override
	public List<TProExpendDetail> getByProId(Integer FProId) {
		Finder finder = Finder.create(" FROM TProExpendDetail WHERE FProId='"+FProId+"' and createStatus is null");
		return super.find(finder);
	}
	@Override
	public void transmitIndex(Integer FProId) {
		// TODO Auto-generated method stub
		Query query=getSession().createSQLQuery(" update  T_PRO_EXPEND_DETAIL set F_XD_AMOUNT=F_APPLI_AMOUNT,F_SY_AMOUNT=F_APPLI_AMOUNT,F_DJ_AMOUNT=0 where F_PRO_ID="+FProId);
		query.executeUpdate();
	}
	
	@Override
	public Map<String, Integer> getPidMap(String parentCodes) {
		Map<String,Integer> pidMap=new HashMap<String,Integer>();
		List<Integer> pidList=getPidListByparentCodes(parentCodes);
		if(pidList!=null && pidList.size()>0){
			for(Integer pid:pidList){
				pidMap.put(pid+"", pid);
			}
		}
		return pidMap;
		
	}					

	public List<Integer> getPidListByparentCodes(String parentCodes){
		
		String sql = " SELECT F_PRO_ID FROM T_PRO_EXPEND_DETAIL WHERE 1=1 ";
		
		if (!StringUtil.isEmpty(parentCodes)) {//父节点
			sql = sql + " and F_PRO_ID in (" + parentCodes+" )";
		}
		
		SQLQuery query = getSession().createSQLQuery(sql);
		return query.list();
	}

}
