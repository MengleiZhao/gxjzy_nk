package com.braker.icontrol.expend.voucher.manager.Impl;

import java.util.List;
import java.util.Set;

import org.springframework.stereotype.Service;

import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.util.Config;
import com.braker.icontrol.expend.voucher.entity.DeptToSubject;
import com.braker.icontrol.expend.voucher.manager.DeptToSubjectMng;

@Service
public class DeptToSubjectMngImpl  extends BaseManagerImpl<DeptToSubject> implements DeptToSubjectMng{
	
	
	
	
	/**
	 * 
	* @author:安达
	* @Title: getFirstRowSubjectCode
	* @Description: 返回第一行的对应费用科目编码
	* @param fSummary 摘要
	* @param fDeptId   部门id
	* @return
	* @return String    返回类型 
	* @date： 2019年7月2日下午7:10:58 
	* @throws
	 */
	@Override
	public String getFirstRowSubjectCode(String fSummary, String fDeptId,String sourcesfunds){
		//①根据申请部门判断费用科目前半段（详见表2），
		//特殊费用归口如下：银行手续费-财务；硒鼓、公车、水电-总务处；招待费-校办；出国差旅-国际交流处；日常设`备-设备安技处（不包括项目中的设备）
		Set<String> set=Config.getSet();
		for(String key:set){
			if(fSummary.contains(key)){ //只要包含有这几个字的，都当作是特殊归口部门
				String dept=Config.getString(key);
				if(dept.split(",").length>1){
					fDeptId=dept.split(",")[1];
				}
			}
		}
		//根据部门id获得部门对应费用科目 对象
		List<DeptToSubject> deptToSubjectList=super.findByProperty("fDeptId", fDeptId);
		String subjectCode="";//对应费用科目编码
		if(deptToSubjectList!=null && deptToSubjectList.size()>0){
			//对应费用科目编码
			subjectCode=deptToSubjectList.get(0).getfSubjectCode();
			if("0".equals(sourcesfunds)){
				//财政拨款
				subjectCode=subjectCode+"01";
			}else {
				//非财政拨款
				subjectCode=subjectCode+"02";
			}
		}
		return subjectCode;
	}
	
	/**
	 * 
	* @author:安达
	* @Title: getFirstRowSubjectCodeAndName 
	* @Description: 返回第一行的对应费用科目名称
	* @param fSummary 摘要
	* @param fDeptId   部门id
	* @return
	* @return String    返回类型 
	* @date： 2019年7月2日下午7:10:58 
	* @throws
	 */
	@Override
	public String getFirstRowSubjectName(String fSummary, String fDeptId,String sourcesfunds){
		//①根据申请部门判断费用科目前半段（详见表2），
		//特殊费用归口如下：银行手续费-财务；硒鼓、公车、水电-总务处；招待费-校办；出国差旅-国际交流处；日常设`备-设备安技处（不包括项目中的设备）
		Set<String> set=Config.getSet();
		for(String key:set){
			if(fSummary.contains(key)){ //只要包含有这几个字的，都当作是特殊归口部门
				String dept=Config.getString(key);
				if(dept.split(",").length>1){
					fDeptId=dept.split(",")[1];
				}
			}
		}
		//根据部门id获得部门对应费用科目 对象
		List<DeptToSubject> deptToSubjectList=super.findByProperty("fDeptId", fDeptId);
		String subjectName="";//对应费用科目名称
		if(deptToSubjectList!=null && deptToSubjectList.size()>0){
			//对应费用科目编码
			String subjectCode=deptToSubjectList.get(0).getfSubjectCode();
			if("0".equals(sourcesfunds)){
				//财政拨款
				subjectCode=subjectCode+"01";
				subjectName=subjectCode+ "\n" +deptToSubjectList.get(0).getfSubjectName()+"_财政拨款费用";
			}else {
				//非财政拨款
				subjectCode=subjectCode+"02";
				subjectName=subjectCode+ "\n" +deptToSubjectList.get(0).getfSubjectName()+"_非财政拨款费用";
			}
			
		}
		return subjectName;
	}
	/**
	 * 
	* @author:安达
	* @Title: getFirstRowSubjectCodeAndName 
	* @Description: 返回第一行的对应费用科目名称
	* @param fSummary 摘要
	* @param fDeptId   部门id
	* @return
	* @return String    返回类型 
	* @date： 2019年7月2日下午7:10:58 
	* @throws
	 */
	@Override
	public String getThirdRowSubjectName(String fSummary, String fDeptId,String sourcesfunds){
		//①根据申请部门判断费用科目前半段（详见表2），
		//特殊费用归口如下：银行手续费-财务；硒鼓、公车、水电-总务处；招待费-校办；出国差旅-国际交流处；日常设`备-设备安技处（不包括项目中的设备）
		Set<String> set=Config.getSet();
		for(String key:set){
			if(fSummary.contains(key)){ //只要包含有这几个字的，都当作是特殊归口部门
				String dept=Config.getString(key);
				if(dept.split(",").length>1){
					fDeptId=dept.split(",")[1];
				}
			}
		}
		//根据部门id获得部门对应费用科目 对象
		List<DeptToSubject> deptToSubjectList=super.findByProperty("fDeptId", fDeptId);
		String subjectName="";//对应费用科目名称
		if(deptToSubjectList!=null && deptToSubjectList.size()>0){
			//对应费用科目编码
			String subjectCode=deptToSubjectList.get(0).getfSubjectCode();
			if("0".equals(sourcesfunds)){
				//财政拨款
				subjectCode=subjectCode+"01";
				subjectName=subjectCode+ "\n" +deptToSubjectList.get(0).getfSubjectName()+"_财政拨款费用";
			}else {
				//非财政拨款
				subjectCode=subjectCode+"02";
				subjectName=subjectCode+ "\n" +deptToSubjectList.get(0).getfSubjectName()+"_非财政拨款费用";
			}
			
		}
		return subjectName;
	}
	
}
