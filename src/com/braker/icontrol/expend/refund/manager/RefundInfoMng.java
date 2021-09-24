package com.braker.icontrol.expend.refund.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.expend.refund.model.RefundInfo;
import com.braker.workflow.entity.TProcessCheck;

public interface RefundInfoMng extends BaseManager<RefundInfo>{

	
	/***
	 * 加载list页面查询数据
	 * @param bean
	 * @param pageNo
	 * @param pageSize
	 * @return
	 * @author 陈睿超
	 * @createTime2019年11月28日
	 * @updateTime2019年11月28日
	 */
	public Pagination pageList(RefundInfo bean,Integer pageNo, Integer pageSize, String sign, User user);
	
	/**
	 * 保存
	 * @param bean 
	 * @param mingxi StudentRefundMoney的json
	 * @param files 附件
	 * @param user 当前登录人
	 * @author 陈睿超
	 * @createTime2019年11月28日
	 * @updateTime2019年11月28日
	 */
	public void save(RefundInfo bean, String files, String mingxi, User user) throws Exception;
	
	/**
	 * 
	 * @Description 退费明细
	 * @param @param tableName
	 * @param @param idName
	 * @param @param id
	 * @param @return
	 * @return List<Object>  
	 * @throws
	 * @author 汪耀
	 * @date 2019年12月3日
	 */
	public List<Object> getMingxi(String tableName, String idName, Integer id);
	
	/**
	 * 
	 * @Description 明细的json对象
	 * @param @param mingxi
	 * @param @param tableClass
	 * @param @return
	 * @return List  
	 * @throws
	 * @author 汪耀
	 * @date 2019年12月3日
	 */
	public List getMingXiJson(String mingxi, Class tableClass);
	
	/**
	 * 
	 * @Description 保存审核信息
	 * @param @param checkBean
	 * @param @param bean
	 * @param @param files
	 * @param @param user
	 * @param @throws Exception
	 * @return void  
	 * @throws
	 * @author 汪耀
	 * @date 2019年12月3日
	 */
	public void saveCheck(TProcessCheck checkBean, RefundInfo bean, String files, User user) throws Exception;

	public String reCall(String id);
}
