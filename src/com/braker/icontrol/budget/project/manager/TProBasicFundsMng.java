package com.braker.icontrol.budget.project.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.icontrol.budget.project.entity.TProBasicFunds;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;

/**
 * 
 * <p>Description: 项目资金来源接口</p>
 * @author:安达
 * @date： 2019年5月23日下午3:11:48
 */
public interface TProBasicFundsMng extends BaseManager<TProBasicFunds>{
  /**
   * 
  * @Title: save 
  * @Description: 保存资金来源明细 
  * @param  FProId  项目id
  * @param  fundsList  自己来源明细集合
  * @param 
  * @param  Exception    抛出异常
  * @return int    返回类型 
  * @throws
   */
  public int save(TProBasicInfo bean, List<TProBasicFunds> fundsList) throws Exception;
  
  /**
   * 
   * @Description: 根据项目id查询资金来源明细
   * @author 汪耀
   * @param @param FProId
   * @param @return    
   * @return List<TProBasicFunds>
   */
  public List<TProBasicFunds> getByProId(Integer FProId);
  
}
