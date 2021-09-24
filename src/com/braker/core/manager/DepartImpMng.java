package com.braker.core.manager;

import java.io.File;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.DepartImp;
import com.braker.core.model.User;

/**
 * 数据库控制接口
 * @author zhang_xun
 */
public interface DepartImpMng extends BaseManager<DepartImp>{

	DepartImp findByCode(String code);
	
	void impData(File file);
	
	void impMdjf(File file, User user);

	void updateVersion();
}
