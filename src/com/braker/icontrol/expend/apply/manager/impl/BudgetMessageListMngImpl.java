package com.braker.icontrol.expend.apply.manager.impl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.icontrol.expend.apply.manager.BudgetMessageListMng;
import com.braker.icontrol.expend.apply.model.BudgetMessageList;

@Service
@Transactional
public class BudgetMessageListMngImpl extends BaseManagerImpl<BudgetMessageList> implements BudgetMessageListMng{

}
