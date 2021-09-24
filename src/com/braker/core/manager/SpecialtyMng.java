package com.braker.core.manager;

import java.util.List;

import com.braker.common.entity.TreeEntity;
import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Specialty;
import com.braker.core.model.User;

public interface SpecialtyMng extends BaseManager<Specialty>{

	List<TreeEntity> getQueryTree(Specialty profess);

	List<Specialty> getRoots();

	boolean haveChild(Specialty profess);

	List<Specialty> getChild(String id);

	Pagination list(Specialty bean, String sort, String order,
			int pageIndex, int pageSize,boolean isQuRole,boolean isStreetRole, User user);
	
	void deleteSpecialty(Specialty bean, User user);

	Specialty saveSpecialty(Specialty bean, User user);

}
