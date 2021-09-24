package com.braker.icontrol.incomemanage.accountsCurrent.manager;
import java.util.List;
import com.braker.common.hibernate.BaseManager;
import com.braker.core.model.User;
import com.braker.icontrol.incomemanage.accountsCurrent.model.ReceiveMoneyDetail;
public interface ReceiveMoneyDetailMng extends BaseManager<ReceiveMoneyDetail>{

	/**
	 * 通过登记ID和类型查询数据
	 * @author 赵孟雷
	 * @createtime 2020-11-12
	 * @updatetime 2018-11-12
	 */
	public List<ReceiveMoneyDetail> findByList(ReceiveMoneyDetail bean, User user);
}
