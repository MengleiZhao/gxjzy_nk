package com.braker.icontrol.expend.history.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.util.SortList;
import com.braker.common.web.BaseController;
import com.braker.core.manager.UserMng;
import com.braker.icontrol.expend.history.manager.CheckHistoryMng;
import com.braker.workflow.entity.TProcessCheck;

/**
 * 支出模块审批记录查询
 * @author 叶崇辉
 */
@Controller
@RequestMapping(value = "/checkHistory")
public class CheckHistoryController extends BaseController {
	@Autowired
	private CheckHistoryMng checkHistoryMng;			
	
	@Autowired
	private UserMng userMng;

	/**
	 *  /checkHistory/history
	 * @param type
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/history")
	@ResponseBody
	public List<TProcessCheck> checkHistory(String type ,Integer id) {
		
		if(id==null || "".equals(id)) {
			return null;
		}
		String code=checkHistoryMng.getFoCodeById(type,id);
		List<TProcessCheck> list =checkHistoryMng.findCheckHistorys(type, code, null);
		SortList<TProcessCheck> sort=new SortList<TProcessCheck>();
		sort.Sort(list, "getFcheckTime", "asc","String");
		//Collections.sort(list, new SortByTime());//排序
		return list;
	}
	
/*	
	class SortByTime implements Comparator {
			public int compare(Object arg0, Object arg1) {
				// TODO Auto-generated method stub
				CheckHistory k1 = (CheckHistory) arg0;
				CheckHistory k2 = (CheckHistory) arg1;
				if (k1.getTime().compareTo(k2.getTime())>0){
					return -1;
				}else if(k1.getTime().compareTo(k2.getTime())<0){
					return 1;
				}
				else{
					return 0;
				}
			}
		}*/

}
