package com.braker.icontrol.expend.apply.manager;

import java.util.List;

import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.Pagination;
import com.braker.core.model.Depart;
import com.braker.icontrol.expend.apply.model.StudentsList;
import com.braker.icontrol.expend.apply.model.TravelAppliInfo;
/**
 * 差旅费申请信息service
 * @author 赵孟雷
 * @createtime 2020-04-18
 * @updatetime 2020-04-18
 */
public interface TravelAppliInfoMng extends BaseManager<TravelAppliInfo>{

	
	public Pagination travelPageList(int pageNo, int pageSize,TravelAppliInfo bean);
	
	public Pagination studentsPageList(int pageNo, int pageSize,StudentsList bean);
	/**
	 * 事后报销查询
	 * @param pageNo
	 * @param pageSize
	 * @param gId
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年4月21日
	 * @updator 陈睿超
	 * @updatetime 2020年4月21日
	 */
	Pagination rtravelPageList(int pageNo, int pageSize,TravelAppliInfo bean);
	
	
	
	public List<TravelAppliInfo> travelPageRepetitionList(TravelAppliInfo bean);
	
	public List<TravelAppliInfo> travelPageRepetitionListReim(TravelAppliInfo bean);
}
