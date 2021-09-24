package com.braker.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class ConstantUtil {

	private static SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	 public static Map getauthorityMap() {
		// TODO Auto-generated method stub
		Map<String, String> authorityMap = new HashMap<String, String>();
		authorityMap.put("ROLE_GROUP_PRINTOR","文印人员");
		authorityMap.put("ROLE_GROUP_AUDITOR", "一线审计人员");
		authorityMap.put("ROLE_GROUP_AUDITOR_LEADER", "审计组长");
		authorityMap.put("ROLE_GROUP_AUDITOR_MASTER", "审计科长");
		authorityMap.put("ROLE_GROUP_AUDITOR_SECOND_MASTER", "审计科长");
		authorityMap.put("ROLE_GROUP_AUDITOR_SECRETARY", "审计局长");
		authorityMap.put("ROLE_GROUP_AUDITOR_SECOND_SECRETARY", "审计局长");
		authorityMap.put("ROLE_GROUP_SYS_ADMIN", "系统管理员");
		authorityMap.put("ROLE_GROUP_REPORT_AUDITOR", "报表审核人");
		return authorityMap;
	}
	 
	/**
	 * a string convert to date
	 * @param dateStr
	 * @return
	 */
	public static Date convertStrToDate(String dateStr){
		try {
			if(!StringUtil.isEmpty(dateStr))
				return sf.parse(dateStr);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return null;
	}
	 
}
