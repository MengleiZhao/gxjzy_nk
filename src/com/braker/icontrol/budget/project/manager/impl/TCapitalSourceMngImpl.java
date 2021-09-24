package com.braker.icontrol.budget.project.manager.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.icontrol.budget.project.entity.TCapitalSource;
import com.braker.icontrol.budget.project.manager.TCapitalSourceMng;

/**
 * 资金来源service
* <p>Title:TCapitalSourceMngImpl </p>
* <p>Description: </p>
* <p>Company: </p> 
* @author zml
* @date 2021年6月1日
 */
@Service
@Transactional
public class TCapitalSourceMngImpl  extends BaseManagerImpl<TCapitalSource>  implements TCapitalSourceMng {

}
