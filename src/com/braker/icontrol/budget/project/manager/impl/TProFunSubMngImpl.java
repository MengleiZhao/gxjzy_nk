package com.braker.icontrol.budget.project.manager.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.icontrol.budget.project.entity.TProFunSub;
import com.braker.icontrol.budget.project.manager.TProFunSubMng;

/**
 * 功能分类科目service
* <p>Title:TProFunSubMngImpl </p>
* <p>Description: </p>
* <p>Company: </p> 
* @author zml
* @date 2021年6月1日
 */
@Service
@Transactional
public class TProFunSubMngImpl  extends BaseManagerImpl<TProFunSub>  implements TProFunSubMng {

}
