package com.braker.core.manager;

import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.SysParam;

public interface SysParamMng extends BaseManager<SysParam>{
	public SysParam findByKey(String key);
}
