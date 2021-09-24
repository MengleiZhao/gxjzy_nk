package com.braker.icontrol.incomemanage.incomeConfirm.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.incomemanage.accountsCurrent.model.ReceiveMoneyDetail;
import com.braker.icontrol.incomemanage.incomeConfirm.model.IncomeConfirmInfo;
import com.braker.icontrol.incomemanage.register.model.IncomeInfo;
import com.braker.workflow.entity.TProcessCheck;

public interface IncomeConfirmMng extends BaseManager<IncomeConfirmInfo>{

	Pagination confirmPageList(IncomeConfirmInfo bean, Integer page, Integer rows,
			User user);

	void saveConfirm(IncomeInfo bean, IncomeConfirmInfo icBean,User user, String mingxiJson, String confirmFiles) throws Exception;

	void reCall(Integer id);
	void delete(Integer id);

	List<ReceiveMoneyDetail> findDetailById(String string);

	Pagination confirmCheckPageList(IncomeConfirmInfo bean, Integer page, Integer rows, User user);

	void saveCheck(TProcessCheck checkBean, IncomeConfirmInfo bean, String spjlFile, User user) throws Exception;

	List<IncomeConfirmInfo> findByIncomeId(String fincomeId,String fpId);
	
}
