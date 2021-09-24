package com.braker.icontrol.budget.researchProjects.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.budget.researchProjects.model.ResearchProjectsInfo;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TProcessCheck;

/**
 * 科研项目登记的service抽象类
 * @author 方淳洲
 * @createtime 2021-06-18
 * @updatetime 2021-06-18
 */
public interface ResearchProjectsMng extends BaseManager<ResearchProjectsInfo>{

	Pagination pageList(ResearchProjectsInfo bean, Integer page, Integer rows, User user);

	void save(ResearchProjectsInfo bean, String files, User user) throws Exception;
	
	public void delete(Integer id);

	String reCall(Integer id);

	Pagination checkPageList(ResearchProjectsInfo bean, Integer page, Integer rows, User user);
	
	Pagination getProjectUserAndProjectMemberById(ResearchProjectsInfo bean, Integer page, Integer rows, User user);

	void saveCheck(TProcessCheck checkBean, ResearchProjectsInfo bean, User user, String spjlFile) throws Exception;

}
