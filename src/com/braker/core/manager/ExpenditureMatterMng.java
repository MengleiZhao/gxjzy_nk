package com.braker.core.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.ExpenditureMatter;
import com.braker.core.model.User;

public interface ExpenditureMatterMng extends BaseManager<ExpenditureMatter>{

	/**
	 * 加载支出事项list页数据
	 * @param bean 查询条件
	 * @param sort
	 * @param order
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	Pagination list(ExpenditureMatter bean,String sort, String order, Integer pageNo, Integer pageSize);
	
	/**
	 * 保存
	 * @param bean 保存数据
	 * @param user
	 */
	void saveEM(ExpenditureMatter bean,User user);
	
	/**
	 * 根据编码查询
	 * @param code
	 * @return
	 */
	Integer findbycode(String code);
	
	List<ExpenditureMatter> findall();
	
	/**
	 * @author 叶崇晖
	 * @param type支出事项的类型
	 * @return
	 */
	public List<ExpenditureMatter> getExpenditureMatterByType(String type, User user, String meetingType, String trainingType, String placeEnd);
}
