package com.braker.core.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Depart;
import com.braker.core.model.Economic;
import com.braker.core.model.YearsBasic;

public interface YearsUnionBasicMng extends BaseManager<YearsBasic>{

	List yearsBasicList();
	
	List<YearsBasic> getRoots(String parentId, String year);
	
	List<Object[]> getChild(String pid);

	List<Object[]> getChildList(String fbId,String pid);
	
	Pagination list(Economic Economic,String fPeriod,String fbId,String sort,String order,Integer page,Integer rows);

	List<Object[]>  list1(Economic Economic,String fPeriod,String fbId,String sort,String order,Integer page,Integer rows);

	Pagination list_add(Economic economic,String departId,String sort,String order,Integer page,Integer rows);
	
	int ye_save(String daw,String departId,Economic economic);
	
	boolean queryID(String daw, String departId, Economic economic);
	
	boolean ye_delete(String fbId,String daw);
	
}
