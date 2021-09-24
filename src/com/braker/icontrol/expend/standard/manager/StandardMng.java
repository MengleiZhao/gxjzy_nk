package com.braker.icontrol.expend.standard.manager;

import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.braker.common.entity.DataEntity;
import com.braker.common.hibernate.BaseManager;
import com.braker.common.page.ComboboxJson;
import com.braker.common.page.Pagination;
import com.braker.core.model.User;
import com.braker.icontrol.expend.standard.entity.AboardStandard;
import com.braker.icontrol.expend.standard.entity.HotelStandard;
import com.braker.icontrol.expend.standard.entity.MeetStandard;
import com.braker.icontrol.expend.standard.entity.RecepStandard;
import com.braker.icontrol.expend.standard.entity.Standard;
import com.braker.icontrol.expend.standard.entity.TrainStandard;

public interface StandardMng extends BaseManager<Standard> {

	/**
	 * 保存
	 */
	public Standard saveHotelStandard(Standard bean, User user);
	/**
	 * 查找配置项
	 */
	public Standard findConfigByClassAndId(String className, Integer configId);
	/**
	 * 获取默认配置项
	 */
	public Standard getDefaultConfig(String className);
	
	//差旅费配置分页
	public Pagination pageListTravel(HotelStandard bean, User user, int pageNo, int pageSize);
	//会议配置分页
	public Pagination pageListMeet(MeetStandard bean, User user, int pageNo, int pageSize);
	//培训配置分页
	public Pagination pageListTrain(TrainStandard bean, User user, int pageNo, int pageSize);
	//接待配置分页
	public Pagination pageListRecep(RecepStandard bean, User user, int pageNo, int pageSize);
	//出国配置分页
	public Pagination pageListAboard(AboardStandard bean, User user, int pageNo, int pageSize);
	
	/**
	 * 删除
	 */
	public HotelStandard deleteStandard(Standard bean, User user);
	
	//计算差旅费
	public List<Object> calcCostTravel(Integer configId, Date travelDates, Date travelDatee);
	//计算接待费
	public List<Object> calcCostRecep(Integer configId, Integer recep_personNum, Integer recep_num);
	//计算会议费
	public List<Object> calcCostMeet(Integer configId, Integer meet_personNum, Integer meet_num);
	//计算培训费
	public List<Object> calcCostTrain(Integer configId, String train_teachLevel, Integer train_personNum, Integer train_num);
	//计算出国经费
	public List<Object> calcCostAboard(Integer configId, Integer aboard_num);
	//计算公务用车费
	public List<Object> calcCostCar(Integer configId, Integer car_num);
	
	/**
	 * 获得差旅费明细列表（空）
	 */
	public List<Object> getEmptyTravelDetail();
	
	/**
	 * 计算差旅住宿费
	 * @param configId	差旅配置id
	 * @param travelDates	开始时间
	 * @param travelDatee	结束时间
	 * @return
	 */
		public Double calcHotelCost(Integer configId, Date travelDates, Date travelDatee);
	
	public List<Object> calcCostTravel1(Integer configId, String travelDays,
			String hotelDays,String userId,String day1,String day2) throws ParseException;
	/**
	 * 参加培训获取住宿费标准
	* <p>Description: </p>
	* <p>Company: </p> 
	* @author zml
	* @date 2021年5月19日
	 */
	public List<Object> calcCostTravel12(Integer configId, String travelDays,
			String hotelDays,String userId,String day1,String day2) throws ParseException;
	/**
	 * 举办培训获取教师住宿费标准
	 * <p>Description: </p>
	 * <p>Company: </p> 
	 * @author zml
	 * @date 2021年5月19日
	 */
	public List<DataEntity> calcCostTravel13(Integer configId,String level,String day1,String day2) throws ParseException;

	/**
	 * 获取会议费标准
	 * @param meetType
	 * @return
	 */
	public Map<String,Double> getMeetStd(String meetType, Integer meet_personNum, Integer meet_num,Integer configId);
	
	/**
	 * 获取培训费标准
	 * <p>Title: getTrainStd</p>  
	 * <p>Description: </p>  
	 * @param trainType
	 * @param meet_personNum
	 * @param meet_num
	 * @param configId
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年3月30日
	 * @updator 陈睿超
	 * @updatetime 2020年3月30日
	 */
	public Map<String, Double> getTrainStd(String trainType, Integer train_personNum, Integer train_num,Integer configId);
}
