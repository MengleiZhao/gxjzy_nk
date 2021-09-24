package com.braker.icontrol.expend.standard.manager.impl;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.record.chart.BeginRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.braker.common.entity.DataEntity;
import com.braker.common.hibernate.BaseManagerImpl;
import com.braker.common.hibernate.Finder;
import com.braker.common.page.ComboboxJson;
import com.braker.common.page.Pagination;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.core.manager.UserMng;
import com.braker.core.model.DefaultCombobox;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.expend.apply.model.ApplicationDetail;
import com.braker.icontrol.expend.standard.entity.AboardStandard;
import com.braker.icontrol.expend.standard.entity.HotelStandard;
import com.braker.icontrol.expend.standard.entity.MeetStandard;
import com.braker.icontrol.expend.standard.entity.RecepStandard;
import com.braker.icontrol.expend.standard.entity.Region;
import com.braker.icontrol.expend.standard.entity.Standard;
import com.braker.icontrol.expend.standard.entity.TrainStandard;
import com.braker.icontrol.expend.standard.manager.AboardStandardMng;
import com.braker.icontrol.expend.standard.manager.HotelStandardMng;
import com.braker.icontrol.expend.standard.manager.MeetStandardMng;
import com.braker.icontrol.expend.standard.manager.RecepStandardMng;
import com.braker.icontrol.expend.standard.manager.RegionMng;
import com.braker.icontrol.expend.standard.manager.StandardMng;
import com.braker.icontrol.expend.standard.manager.TrainStandardMng;

@Service
public class StandardMngImpl extends BaseManagerImpl<Standard> implements StandardMng {

	@Autowired
	private HotelStandardMng hotelStandardMng;
	@Autowired
	private AboardStandardMng aboardStandardMng;
	@Autowired
	private MeetStandardMng meetStandardMng;
	@Autowired
	private RecepStandardMng recepStandardMng;
	@Autowired
	private TrainStandardMng trainStandardMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	private RegionMng regionMng;
	
	
	@Override
	public Standard saveHotelStandard(Standard bean, User user) {

		if (StringUtil.isEmpty(bean.getId())) {
			bean.setFlag(1);
			bean.setCreatetime(new Date());
			bean.setCreator(user);
			return (Standard)saveOrUpdate(bean);
		} else {
			bean.setUpdator(user);
			bean.setUpdateTime(new Date());
		}
		return (Standard) updateDefault(bean);
	}

	@Override
	public Pagination pageListTravel(HotelStandard bean, User user, int pageNo, int pageSize) {
		
		//查询
		Finder finder = Finder.create(" from HotelStandard WHERE flag=1  ");
		if (!StringUtil.isEmpty(bean.getArea())) {
			finder.append(" AND area LIKE '%"+bean.getArea()+"%'");
		}
		//排序
		Pagination p = super.find(finder, pageNo, pageSize);
		List<HotelStandard> list = (List<HotelStandard>) p.getList();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				list.get(i).setPageOrder(pageNo * pageSize + i - 9);
			}
		}
		p.setList(list);
		
		return super.find(finder, pageNo, pageSize);
	}
	
	@Override
	public Pagination pageListMeet(MeetStandard bean, User user, int pageNo,
			int pageSize) {
		
		//查询
		Finder finder = Finder.create(" from MeetStandard WHERE flag=1  ");
		if (true) {
			finder.append("");
		}
		//排序
		Pagination p = super.find(finder, pageNo, pageSize);
		List<MeetStandard> list = (List<MeetStandard>) p.getList();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				list.get(i).setPageOrder(pageNo * pageSize + i - 9);
			}
		}
		p.setList(list);		
		
		return p;
	}

	@Override
	public Pagination pageListTrain(TrainStandard bean, User user, int pageNo,
			int pageSize) {
		//查询
		Finder finder = Finder.create(" from TrainStandard WHERE flag=1  ");
		if (true) {
			finder.append("");
		}
		//排序
		Pagination p = super.find(finder, pageNo, pageSize);
		List<TrainStandard> list = (List<TrainStandard>) p.getList();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				list.get(i).setPageOrder(pageNo * pageSize + i - 9);
			}
		}
		p.setList(list);		
		
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public Pagination pageListRecep(RecepStandard bean, User user, int pageNo,
			int pageSize) {
		//查询
		Finder finder = Finder.create(" from RecepStandard WHERE flag=1  ");
		if (true) {
			finder.append("");
		}
		//排序
		Pagination p = super.find(finder, pageNo, pageSize);
		List<RecepStandard> list = (List<RecepStandard>) p.getList();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				list.get(i).setPageOrder(pageNo * pageSize + i - 9);
			}
		}
		p.setList(list);		
		
		return super.find(finder, pageNo, pageSize);
	}

	@Override
	public Pagination pageListAboard(AboardStandard bean, User user,
			int pageNo, int pageSize) {
		//查询
		Finder finder = Finder.create(" from AboardStandard WHERE flag=1  ");
		if (true) {
			finder.append("");
		}
		//排序
		Pagination p = super.find(finder, pageNo, pageSize);
		List<AboardStandard> list = (List<AboardStandard>) p.getList();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				list.get(i).setPageOrder(pageNo * pageSize + i - 9);
			}
		}
		p.setList(list);		
		
		return super.find(finder, pageNo, pageSize);
	}


	@Override
	public HotelStandard deleteStandard(Standard bean, User user) {

		if (bean == null) return null;
		bean.setFlag(0);
		bean.setUpdator(user);
		bean.setUpdateTime(new Date());
		return (HotelStandard) saveOrUpdate(bean);
	}

	@Override
	public List<Object> calcCostTravel(Integer configId, Date travelDates,
			Date travelDatee) {

		int workDaysNum = DateUtil.getDaySpan(travelDates, travelDatee) + 1;//出差天数
		HotelStandard config = (HotelStandard) findConfigByClassAndId("HotelStandard",configId);			//出差配置
		List<Object> resList = new ArrayList<Object>();
		
		if (travelDates == null || travelDatee == null || configId == null) return null;
		
		
		//住宿费
		ApplicationDetail bean = new ApplicationDetail();
		bean.setCostDetail("住宿费");
		if (config.getHasBusy() == 1) {
			double cost = calcHotelCost(configId, travelDates, travelDatee);
			bean.setStandard(String.valueOf(cost));
		} else {
			double price = config.getNormalPriceMin();
			double cost = price * workDaysNum;
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);
		//伙食补助费
		bean = new ApplicationDetail();
		bean.setCostDetail("伙食补助费");
		if (config.getCostFood() != null) {
			double price = config.getCostFood();
			double cost = price * workDaysNum;
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);
		//长途交通费
		bean = new ApplicationDetail();
		bean.setCostDetail("长途交通费");
		if (config.getCostTrafficLong() != null) {
			double price = config.getCostFood();
			double cost = price * workDaysNum;
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);
		//市内交通费
		bean = new ApplicationDetail();
		bean.setCostDetail("市内交通费");
		if (config.getCostTrafficShort() != null) {
			double price = config.getCostTrafficShort();
			double cost = price * workDaysNum;
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);
		//杂费
		bean = new ApplicationDetail();
		bean.setCostDetail("杂费");
		if (config.getCostExtras() != null) {
			double price = config.getCostExtras();
			double cost = price * workDaysNum;
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);
		
		return resList;
	}
	
	@Override
	public List<Object> calcCostTravel1(Integer configId, String travelDays,
			String hotelDays,String userId,String day1,String day2)  throws ParseException {

		List<HotelStandard>  hotelStandard= hotelStandardMng.findByProperty("areaId", configId);			//出差配置
		HotelStandard config = new HotelStandard();
		Region region = new Region();
		if(hotelStandard.size()==0){
			region = regionMng.findById(configId);
			region = regionMng.findById(region.getpCode());
			hotelStandard = hotelStandardMng.findByProperty("areaId", region.getCode());		
			if(hotelStandard.size()==0){
				region = regionMng.findById(region.getpCode());
				region = regionMng.findById(region.getpCode());
				config = hotelStandardMng.findByProperty("areaId", region.getCode()).get(0);		
			}else{
				config = hotelStandard.get(0);
			}
		}else{
			config = hotelStandard.get(0);
		}
		List<Object> resList = new ArrayList<Object>();
		if (travelDays == null || hotelDays == null || configId == null) return null;
		
		int normalday = 0;//淡季时长
		int busyday = 0;//旺季时长
		if(!StringUtil.isEmpty(day1) || !StringUtil.isEmpty(day2)){
			if(config.getHasBusy()==0){//判断该地区是否存在淡季旺季  0是不存在  1是存在
				long date1 = new Long(day1);
				long date2 = new Long(day2);
				Calendar c1 = Calendar.getInstance();
				Calendar c2 = Calendar.getInstance();
				c1.setTimeInMillis(date1);
				c2.setTimeInMillis(date2);
				Date time1 = c1.getTime();//行程开始时间
		        Date time2 = c2.getTime();//行程结束时间
		        normalday = DateUtil.getDaySpan(time1, time2);//结束时间减去开始时间
			}else{
				if(config.getHasBusy()==1){
					long date1 = new Long(day1);
					long date2 = new Long(day2);
					Calendar c1 = Calendar.getInstance();
					Calendar c2 = Calendar.getInstance();
					c1.setTimeInMillis(date1);
					c2.setTimeInMillis(date2);
					Date time1 = c1.getTime();//行程开始时间
			        Date time2 = c2.getTime();//行程结束时间
					Boolean bstart =  DateUtil.isEffectiveDate(time1, config.getBusyDateStart(), config.getBusyDateEnd());//开始时间是否在旺季区间
					Boolean bend =  DateUtil.isEffectiveDate(time2, config.getBusyDateStart(), config.getBusyDateEnd());//开始时间是否在旺季区间
					if(bstart && bend){//开始时间和结束时间都在旺季中
						busyday = DateUtil.getDaySpan(time1, time2);
					}else if(bstart && !bend){//开始时间在旺季中，结束时间不在旺季中
						busyday = DateUtil.getDaySpan(time1, config.getBusyDateEnd())+1;//旺季结束时间减去开始时间
						normalday = DateUtil.getDaySpan(config.getBusyDateEnd(), time2);//结束时间减去旺季结束时间
					}else if(!bstart && bend){//开始时间不在旺季中，结束时间在旺季中
						busyday = DateUtil.getDaySpan(config.getBusyDateStart(), time2)+1;//旺季开始时间减去开始时间
						normalday = DateUtil.getDaySpan(time1, config.getBusyDateStart());//结束时间减去旺季开始时间
					}else if(!bstart && !bend){//开始时间不在旺季中，结束时间不在旺季中
						normalday = DateUtil.getDaySpan(time1, time2);
					}
				}
			}
		}
		//住宿费
		ApplicationDetail bean = new ApplicationDetail();
		bean.setCostDetail("住宿费");
		String[] userIds = userId.split(",");
		//根据人员级别计算费用标准
		Double costLevel = 0.00;
		for (int i = 0; i < userIds.length; i++) {
			User user = userMng.findById(userIds[i]);
			if(user!=null){
				if (config.getHasBusy() ==1) {//1代表旺季
					if(1==user.getRoleslevel()){
						costLevel =costLevel+( config.getBusyPriceMax()*busyday+normalday*config.getNormalPriceMax());
					}
					if(2==user.getRoleslevel()){
						costLevel = costLevel+( config.getBusyPriceMid()*busyday+normalday*config.getNormalPriceMid());
					}
					if(3==user.getRoleslevel()){
						costLevel = costLevel+( config.getBusyPriceMin()*busyday+normalday*config.getNormalPriceMin());
					}
				}else{
					if (config.getHasBusy() ==0) {//0代表淡季
						if(1==user.getRoleslevel()){
							costLevel =costLevel+(  normalday*config.getNormalPriceMax());
						}
						if(2==user.getRoleslevel()){
							costLevel = costLevel+( normalday*config.getNormalPriceMid());
						}
						if(3==user.getRoleslevel()){
							costLevel = costLevel+( normalday*config.getNormalPriceMin());
						}
					}
				}
			}else{
				if (config.getHasBusy() ==1) {//1代表旺季
					costLevel = costLevel+( config.getBusyPriceMin()*busyday+normalday*config.getNormalPriceMin());
				}else{
					costLevel = costLevel+( normalday*config.getNormalPriceMin());
				}
			}
		}
		bean.setStandard(String.valueOf(costLevel));
		resList.add(bean);
		//伙食补助费
		bean = new ApplicationDetail();
		bean.setCostDetail("伙食补助费");
		if (config.getCostFood() != null) {
			double price = config.getCostFood();
			double cost = price * Double.valueOf(travelDays);
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);
		//长途交通费
		bean = new ApplicationDetail();
		bean.setCostDetail("长途交通费");
		if (config.getCostFood() != null) {
			double price = config.getCostFood();
			double cost = price * Double.valueOf(travelDays);
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);
		//市内交通费
		/*bean = new ApplicationDetail();
		bean.setCostDetail("市内交通费");
		if (config.getCostFood() != null) {
			double price = config.getCostTrafficShort();
			double cost = price * Double.valueOf(travelDays);
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);*/
		
		return resList;
	}
	@Override
	public List<Object> calcCostTravel12(Integer configId, String travelDays,
			String hotelDays,String userId,String day1,String day2)  throws ParseException {
		
		List<HotelStandard>  hotelStandard= hotelStandardMng.findByProperty("areaId", configId);			//出差配置
		HotelStandard config = new HotelStandard();
		Region region = new Region();
		if(hotelStandard.size()==0){
			region = regionMng.findById(configId);
			region = regionMng.findById(region.getpCode());
			hotelStandard = hotelStandardMng.findByProperty("areaId", region.getCode());		
			if(hotelStandard.size()==0){
				region = regionMng.findById(region.getpCode());
				config = hotelStandardMng.findByProperty("areaId", region.getCode()).get(0);		
			}else{
				config = hotelStandard.get(0);
			}
		}else{
			config = hotelStandard.get(0);
		}
		
		List<Object> resList = new ArrayList<Object>();
		if (travelDays == null || hotelDays == null || configId == null) return null;
		
		int normalday = 0;//淡季时长
		int busyday = 0;//旺季时长
		if(!StringUtil.isEmpty(day1) || !StringUtil.isEmpty(day2)){
			if(config.getHasBusy()==0){//判断该地区是否存在淡季旺季  0是不存在  1是存在
				long date1 = new Long(day1);
				long date2 = new Long(day2);
				Calendar c1 = Calendar.getInstance();
				Calendar c2 = Calendar.getInstance();
				c1.setTimeInMillis(date1);
				c2.setTimeInMillis(date2);
				Date time1 = c1.getTime();//行程开始时间
				Date time2 = c2.getTime();//行程结束时间
				normalday = DateUtil.getDaySpan(time1, time2);//结束时间减去开始时间
			}else{
				if(config.getHasBusy()==1){
					long date1 = new Long(day1);
					long date2 = new Long(day2);
					Calendar c1 = Calendar.getInstance();
					Calendar c2 = Calendar.getInstance();
					c1.setTimeInMillis(date1);
					c2.setTimeInMillis(date2);
					Date time1 = c1.getTime();//行程开始时间
					Date time2 = c2.getTime();//行程结束时间
					Boolean bstart =  DateUtil.isEffectiveDate(time1, config.getBusyDateStart(), config.getBusyDateEnd());//开始时间是否在旺季区间
					Boolean bend =  DateUtil.isEffectiveDate(time2, config.getBusyDateStart(), config.getBusyDateEnd());//开始时间是否在旺季区间
					if(bstart && bend){//开始时间和结束时间都在旺季中
						busyday = DateUtil.getDaySpan(time1, time2);
					}else if(bstart && !bend){//开始时间在旺季中，结束时间不在旺季中
						busyday = DateUtil.getDaySpan(time1, config.getBusyDateEnd())+1;//旺季结束时间减去开始时间
						normalday = DateUtil.getDaySpan(config.getBusyDateEnd(), time2);//结束时间减去旺季结束时间
					}else if(!bstart && bend){//开始时间不在旺季中，结束时间在旺季中
						busyday = DateUtil.getDaySpan(config.getBusyDateStart(), time2)+1;//旺季开始时间减去开始时间
						normalday = DateUtil.getDaySpan(time1, config.getBusyDateStart());//结束时间减去旺季开始时间
					}else if(!bstart && !bend){//开始时间不在旺季中，结束时间不在旺季中
						normalday = DateUtil.getDaySpan(time1, time2);
					}
				}
			}
		}
		//住宿费
		ApplicationDetail bean = new ApplicationDetail();
		bean.setCostDetail("住宿费");
		String[] userIds = userId.split(",");
		//根据人员级别计算费用标准
		Double costLevel = 0.00;
		for (int i = 0; i < userIds.length; i++) {
			User user = userMng.findById(userIds[i]);
			if(user!=null){
				if (config.getHasBusy() ==1) {//1代表旺季
					if(1==user.getRoleslevel()){
						costLevel =costLevel+( config.getBusyPriceMax()*busyday+normalday*config.getNormalPriceMax());
					}
					if(2==user.getRoleslevel()){
						costLevel = costLevel+( config.getBusyPriceMid()*busyday+normalday*config.getNormalPriceMid());
					}
					if(3==user.getRoleslevel()){
						costLevel = costLevel+( config.getBusyPriceMin()*busyday+normalday*config.getNormalPriceMin());
					}
				}else{
					if (config.getHasBusy() ==0) {//0代表淡季
						if(1==user.getRoleslevel()){
							costLevel =costLevel+(  normalday*config.getNormalPriceMax());
						}
						if(2==user.getRoleslevel()){
							costLevel = costLevel+( normalday*config.getNormalPriceMid());
						}
						if(3==user.getRoleslevel()){
							costLevel = costLevel+( normalday*config.getNormalPriceMin());
						}
					}
				}
			}else{
				if (config.getHasBusy() ==1) {//1代表旺季
					costLevel = costLevel+( config.getBusyPriceMin()*busyday+normalday*config.getNormalPriceMin());
				}else{
					costLevel = costLevel+( normalday*config.getNormalPriceMin());
				}
			}
		}
		bean.setStandard(String.valueOf(costLevel));
		resList.add(bean);
		//伙食补助费
		bean = new ApplicationDetail();
		bean.setCostDetail("伙食补助费");
		if (config.getCostFood() != null) {
			double price = config.getCostFood();
			double cost = price * Double.valueOf(travelDays);
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);
		//长途交通费
		bean = new ApplicationDetail();
		bean.setCostDetail("长途交通费");
		if (config.getCostTrafficLong() != null) {
			double price = config.getCostTrafficLong();
			double cost = price * Double.valueOf(travelDays);
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);
		//市内交通费
		bean = new ApplicationDetail();
		bean.setCostDetail("市内交通费");
		if (config.getCostTrafficShort() != null) {
			double price = config.getCostTrafficShort();
			double cost = price * Double.valueOf(travelDays);
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);
		
		return resList;
	}
	@Override
	public List<DataEntity> calcCostTravel13(Integer configId, String level,String day1,String day2)  throws ParseException {
		List<DataEntity> comboboxs = new ArrayList<DataEntity>();
		HotelStandard  config= hotelStandardMng.findByProperty("areaId", configId).get(0);			//出差配置
		if(!StringUtil.isEmpty(day1) || !StringUtil.isEmpty(day2)){
			if(config.getHasBusy()==0){//判断该地区是否存在淡季旺季  0是不存在  1是存在
				if("ZWJBJD-01".equals(level)){
					DataEntity combobox1 = new DataEntity();
					combobox1.setId(config.getNormalPriceMax().toString());
					combobox1.setCol1(config.getNormalPriceMax().toString());
					comboboxs.add(combobox1);
				}
				if("ZWJBJD-02".equals(level)){
					DataEntity combobox1 = new DataEntity();
					combobox1.setId(config.getNormalPriceMid().toString());
					combobox1.setCol1(config.getNormalPriceMid().toString());
					comboboxs.add(combobox1);
				}
				if("ZWJBJD-03".equals(level)){
					DataEntity combobox1 = new DataEntity();
					combobox1.setId(config.getNormalPriceMin().toString());
					combobox1.setCol1(config.getNormalPriceMin().toString());
					comboboxs.add(combobox1);
				}
			}else{
				if(config.getHasBusy()==1){
					long date1 = new Long(day1);
					long date2 = new Long(day2);
					Calendar c1 = Calendar.getInstance();
					Calendar c2 = Calendar.getInstance();
					c1.setTimeInMillis(date1);
					c2.setTimeInMillis(date2);
					Date time1 = c1.getTime();//行程开始时间
					Date time2 = c2.getTime();//行程结束时间
					Boolean bstart =  DateUtil.isEffectiveDate(time1, config.getBusyDateStart(), config.getBusyDateEnd());//开始时间是否在旺季区间
					Boolean bend =  DateUtil.isEffectiveDate(time2, config.getBusyDateStart(), config.getBusyDateEnd());//开始时间是否在旺季区间
					if(bstart && bend){//开始时间和结束时间都在旺季中
						
						if("ZWJBJD-01".equals(level)){
							DataEntity combobox = new DataEntity();
							combobox.setId(config.getBusyPriceMax().toString());
							combobox.setCol1(config.getBusyPriceMax().toString());
							comboboxs.add(combobox);
						}
						if("ZWJBJD-02".equals(level)){
							DataEntity combobox = new DataEntity();
							combobox.setId(config.getBusyPriceMid().toString());
							combobox.setCol1(config.getBusyPriceMid().toString());
							comboboxs.add(combobox);
						}
						if("ZWJBJD-03".equals(level)){
							DataEntity combobox = new DataEntity();
							combobox.setId(config.getBusyPriceMin().toString());
							combobox.setCol1(config.getBusyPriceMin().toString());
							comboboxs.add(combobox);
						}

					}else if(bstart && !bend){//开始时间在旺季中，结束时间不在旺季中
						if("ZWJBJD-01".equals(level)){
							DataEntity combobox = new DataEntity();
							combobox.setId(config.getBusyPriceMax().toString());
							combobox.setCol1(config.getBusyPriceMax().toString());
							comboboxs.add(combobox);
							DataEntity combobox1 = new DataEntity();
							combobox1.setId(config.getNormalPriceMax().toString());
							combobox1.setCol1(config.getNormalPriceMax().toString());
							comboboxs.add(combobox1);
						}
						if("ZWJBJD-02".equals(level)){
							DataEntity combobox = new DataEntity();
							combobox.setId(config.getBusyPriceMid().toString());
							combobox.setCol1(config.getBusyPriceMid().toString());
							comboboxs.add(combobox);
							DataEntity combobox1 = new DataEntity();
							combobox1.setId(config.getNormalPriceMid().toString());
							combobox1.setCol1(config.getNormalPriceMid().toString());
							comboboxs.add(combobox1);
						}
						if("ZWJBJD-03".equals(level)){
							DataEntity combobox = new DataEntity();
							combobox.setId(config.getBusyPriceMin().toString());
							combobox.setCol1(config.getBusyPriceMin().toString());
							comboboxs.add(combobox);
							DataEntity combobox1 = new DataEntity();
							combobox1.setId(config.getNormalPriceMin().toString());
							combobox1.setCol1(config.getNormalPriceMin().toString());
							comboboxs.add(combobox1);
						}
					}else if(!bstart && bend){//开始时间不在旺季中，结束时间在旺季中
						if("ZWJBJD-01".equals(level)){
							DataEntity combobox = new DataEntity();
							combobox.setId(config.getBusyPriceMax().toString());
							combobox.setCol1(config.getBusyPriceMax().toString());
							comboboxs.add(combobox);
							DataEntity combobox1 = new DataEntity();
							combobox1.setId(config.getNormalPriceMax().toString());
							combobox1.setCol1(config.getNormalPriceMax().toString());
							comboboxs.add(combobox1);
						}
						if("ZWJBJD-02".equals(level)){
							DataEntity combobox = new DataEntity();
							combobox.setId(config.getBusyPriceMid().toString());
							combobox.setCol1(config.getBusyPriceMid().toString());
							comboboxs.add(combobox);
							DataEntity combobox1 = new DataEntity();
							combobox1.setId(config.getNormalPriceMid().toString());
							combobox1.setCol1(config.getNormalPriceMid().toString());
							comboboxs.add(combobox1);
						}
						if("ZWJBJD-03".equals(level)){
							DataEntity combobox = new DataEntity();
							combobox.setId(config.getBusyPriceMin().toString());
							combobox.setCol1(config.getBusyPriceMin().toString());
							comboboxs.add(combobox);
							DataEntity combobox1 = new DataEntity();
							combobox1.setId(config.getNormalPriceMin().toString());
							combobox1.setCol1(config.getNormalPriceMin().toString());
							comboboxs.add(combobox1);
						}
					}else if(!bstart && !bend){//开始时间不在旺季中，结束时间不在旺季中
						if("ZWJBJD-01".equals(level)){
							DataEntity combobox1 = new DataEntity();
							combobox1.setId(config.getNormalPriceMax().toString());
							combobox1.setCol1(config.getNormalPriceMax().toString());
							comboboxs.add(combobox1);
						}
						if("ZWJBJD-02".equals(level)){
							DataEntity combobox1 = new DataEntity();
							combobox1.setId(config.getNormalPriceMid().toString());
							combobox1.setCol1(config.getNormalPriceMid().toString());
							comboboxs.add(combobox1);
						}
						if("ZWJBJD-03".equals(level)){
							DataEntity combobox1 = new DataEntity();
							combobox1.setId(config.getNormalPriceMin().toString());
							combobox1.setCol1(config.getNormalPriceMin().toString());
							comboboxs.add(combobox1);
						}
					}
				}
			}
		}
		return comboboxs;
	}
	
	@Override
	public List<Object> getEmptyTravelDetail() {

		List<Object> resList = new ArrayList<>();
		ApplicationDetail bean = new ApplicationDetail();
		bean.setCostDetail("住宿费");
		resList.add(bean);
		
		bean = new ApplicationDetail();
		bean.setCostDetail("伙食补助费");
		resList.add(bean);
		
		bean = new ApplicationDetail();
		bean.setCostDetail("长途交通费");
		resList.add(bean);
		
		bean = new ApplicationDetail();
		bean.setCostDetail("市内交通费");
		resList.add(bean);
		
		bean = new ApplicationDetail();
		bean.setCostDetail("杂费");
		resList.add(bean);
		
		return resList;
	}

	@Override
	public Double calcHotelCost(Integer configId, Date travelDates,
			Date travelDatee) {

		//数据校验
		if (configId == null || travelDates == null || travelDatee == null) {
			return 0.0;
		}
		//如果是同一天，则住宿天数为0，住宿费返回0
		Calendar cal1 = Calendar.getInstance();
		Calendar cal2 = Calendar.getInstance();
		cal1.setTime(travelDates);
		cal2.setTime(travelDatee);
		if (cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR) && cal1.get(Calendar.DAY_OF_YEAR) == cal2.get(Calendar.DAY_OF_YEAR)) {
			return 0.0;
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		try {
			
			//获取住宿支出标准
			HotelStandard bean = (HotelStandard) hotelStandardMng.findById(configId);
			Double price = bean.getNormalPriceMin();
			Double priceHigh = bean.getBusyPriceMin();
			//计算旺季时间段
			cal1.setTime(bean.getBusyDateStart());
			cal2.setTime(bean.getBusyDateEnd());
			cal1.set(Calendar.YEAR, Integer.valueOf(DateUtil.getCurrentYear()));
			cal2.set(Calendar.YEAR, Integer.valueOf(DateUtil.getCurrentYear()));
			/*//住宿天数 = 出差天数 - 1
			Calendar calTemp = Calendar.getInstance();
			calTemp.setTime(travelDatee);
			calTemp.add(Calendar.DAY_OF_YEAR, -1);
			travelDatee = calTemp.getTime();*/
			// 计算开支：根据住宿天数、旺季时间、支出标准
			SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
			if (cal1.before(cal2)) {
				//非跨年
				int[] array = DateUtil.calcRepeatDate(travelDates, travelDatee, cal1.getTime(), cal2.getTime());
				Double totalCost = array[0] * price + array[1] * priceHigh;
				return totalCost;
			} else {
				//跨年 把年初和年尾都进行计算
				String currentYear = DateUtil.getCurrentYear();//2019-12-1  2019-01-01
				cal1.set(Calendar.YEAR, Integer.valueOf(currentYear) - 1);	//2018-12-1
				cal2.set(Calendar.YEAR, Integer.valueOf(currentYear));		//2019-01-01
				int[] array1 = DateUtil.calcRepeatDate(travelDates, travelDatee, cal1.getTime(), cal2.getTime());
				
				cal1.add(Calendar.YEAR, 1);//2019-12-01  
				cal2.add(Calendar.YEAR, 1);//2020-01-01
				int[] array2 = DateUtil.calcRepeatDate(travelDates, travelDatee, cal1.getTime(), cal2.getTime());
				
				Double totalCost = array1[0] * price + array1[1] * priceHigh + array2[0] * price + array2[1] * priceHigh;
				return totalCost;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	
	}

	/*@Override
	public List<Object> calcCostRecep(Integer configId, Integer recep_personNum, Integer recep_num) {

		List<Object> resList = new ArrayList<>();
		//获取支出标准
		RecepStandard config = null;
		if (configId == null) {
			config = (RecepStandard) getDefaultConfig("RecepStandard");
		} else {
			config = (RecepStandard) recepStandardMng.findById(configId);
		}
		//正餐
		ApplicationDetail bean = new ApplicationDetail();
		bean.setCostDetail("正餐");
		if (config.getCostFood1() != null) {
			double price = config.getCostFood1();
			double cost = price * recep_personNum * recep_num;
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);
		//早餐
		bean = new ApplicationDetail();
		bean.setCostDetail("早餐");
		if (config.getCostFood1() != null) {
			double price = config.getCostFood2();
			double cost = price * recep_personNum * recep_num;
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);
		//宴请
		bean = new ApplicationDetail();
		bean.setCostDetail("宴请");
		if (config.getCostFood1() != null) {
			double price = config.getCostFood3();
			double cost = price * recep_personNum * recep_num;
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);
		return resList;
	}*/
	@Override
	public List<Object> calcCostRecep(Integer configId, Integer recep_personNum, Integer recep_num) {

		List<Object> resList = new ArrayList<>();
		//获取支出标准
		RecepStandard config = null;
		if (configId == null) {
			config = (RecepStandard) getDefaultConfig("RecepStandard");
		} else {
			config = (RecepStandard) recepStandardMng.findById(configId);
		}
		//正餐
		ApplicationDetail bean = new ApplicationDetail();
		bean.setCostDetail("正餐");
		if (config.getCostFood1() != null) {
			double price = config.getCostFood1();
			bean.setStandard(String.valueOf(price));
		}
		resList.add(bean);
		//早餐
		bean = new ApplicationDetail();
		bean.setCostDetail("早餐");
		if (config.getCostFood2() != null) {
			double price = config.getCostFood2();
			bean.setStandard(String.valueOf(price));
		}
		resList.add(bean);
		//宴请
		bean = new ApplicationDetail();
		bean.setCostDetail("宴请");
		if (config.getCostFood3() != null) {
			double price = config.getCostFood3();
			bean.setStandard(String.valueOf(price));
		}
		resList.add(bean);
		//正、副部长级人员出面举办的宴会
		bean = new ApplicationDetail();
		bean.setCostDetail("正、副部长级人员出面举办的宴会");
		if (config.getCostFood4() != null) {
			double price = config.getCostFood4();
			bean.setStandard(String.valueOf(price));
		}
		resList.add(bean);
		//厅局级及以人员出面举办的宴会
		bean = new ApplicationDetail();
		bean.setCostDetail("厅局级及以下人员出面举办的宴会");
		if (config.getCostFood5() != null) {
			double price = config.getCostFood5();
			bean.setStandard(String.valueOf(price));
		}
		resList.add(bean);
		//冷餐
		bean = new ApplicationDetail();
		bean.setCostDetail("冷餐");
		if (config.getCostFood6() != null) {
			double price = config.getCostFood6();
			bean.setStandard(String.valueOf(price));
		}
		resList.add(bean);
		//酒会
		bean = new ApplicationDetail();
		bean.setCostDetail("酒会");
		if (config.getCostFood7() != null) {
			double price = config.getCostFood7();
			bean.setStandard(String.valueOf(price));
		}
		resList.add(bean);
		//茶会
		bean = new ApplicationDetail();
		bean.setCostDetail("茶会");
		if (config.getCostFood8() != null) {
			double price = config.getCostFood8();
			bean.setStandard(String.valueOf(price));
		}
		resList.add(bean);
		//日常伙食
		bean = new ApplicationDetail();
		bean.setCostDetail("日常伙食");
		if (config.getCostFood9() != null) {
			double price = config.getCostFood9();
			bean.setStandard(String.valueOf(price));
		}
		resList.add(bean);
		return resList;
	}

	
	
	
	
	@Override
	public List<Object> calcCostMeet(Integer configId, Integer meet_personNum, Integer meet_num) {

		List<Object> resList = new ArrayList<>();
		//获取支出标准
		MeetStandard config = null;
		if (configId == null) {
			config = (MeetStandard) getDefaultConfig("MeetStandard");
		} else {
			config = (MeetStandard) meetStandardMng.findById(configId);
		}
		//住宿费
		ApplicationDetail bean = new ApplicationDetail();
		bean.setCostDetail("住宿费");
		if (config.getCostHotel() != null) {
			double price = config.getCostHotel();
			double cost = price * meet_personNum * meet_num;
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);
		//伙食费
		bean = new ApplicationDetail();
		bean.setCostDetail("伙食费");
		if (config.getCostFood() != null) {
			double price = config.getCostFood();
			double cost = price * meet_personNum * meet_num;
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);
		//其他费用
		bean = new ApplicationDetail();
		bean.setCostDetail("其他费用");
		if (config.getCostOther() != null) {
			double price = config.getCostOther();
			double cost = price * meet_personNum * meet_num;
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);
		return resList;
	}

	@Override
	public List<Object> calcCostTrain(Integer configId, String train_teachLevel, Integer train_personNum, Integer train_num) {
		// TODO Auto-generated method stub
		List<Object> resList = new ArrayList<>();
		//获取支出标准
		TrainStandard config = null;
		if (configId == null) {
			config = (TrainStandard) getDefaultConfig("TrainStandard");
		} else {
			config = (TrainStandard) trainStandardMng.findById(configId);
		}
		//住宿费
		ApplicationDetail bean = new ApplicationDetail();
		bean.setCostDetail("住宿费");
		if (config.getCostHotel() != null) {
			double price = config.getCostHotel();
			double cost = price * train_personNum * train_num;
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);
		//伙食费
		bean = new ApplicationDetail();
		bean.setCostDetail("伙食费");
		if (config.getCostFood() != null) {
			double price = config.getCostFood();
			double cost = price * train_personNum * train_num;
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);
		//资料、交通费
		bean = new ApplicationDetail();
		bean.setCostDetail("资料、交通费");
		if (config.getCostBook() != null) {
			double price = config.getCostBook();
			double cost = price * train_personNum * train_num;
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);
		//其他费用
		bean = new ApplicationDetail();
		bean.setCostDetail("其他费用");
		if (config.getCostOther() != null) {
			double price = config.getCostOther();
			double cost = price * train_personNum * train_num;
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);
		//师资费
		bean = new ApplicationDetail();
		bean.setCostDetail("师资费");//按一天8个学时计算
		double price = 0;
		if (config.getCostOther() != null) {
			if ("1".equals(train_teachLevel)) {
				price = config.getCostTeach1();
			} else if ("2".equals(train_teachLevel)) {
				price = config.getCostTeach2();
			} else if ("3".equals(train_teachLevel)) {
				price = config.getCostTeach3();
			}
			double cost = price * train_personNum * train_num * 8;
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);
		return resList;
	}

	@Override
	public List<Object> calcCostAboard(Integer configId, Integer aboard_num) {

		List<Object> resList = new ArrayList<>();
		//获取支出标准
		AboardStandard config = null;
		if (configId == null) {
			config = (AboardStandard) getDefaultConfig("AboardStandard");
		} else {
			config = (AboardStandard) aboardStandardMng.findById(configId);
		}
		//国外交通补助
		ApplicationDetail bean = new ApplicationDetail();
		bean.setCostDetail("国外交通补助");
		if (config.getCostTraffic() != null) {
			double price = config.getCostTraffic();
			double cost = price * aboard_num;
			bean.setStandard(String.valueOf(cost));
		}
		resList.add(bean);
		//零用费（10天内）
		bean = new ApplicationDetail();
		bean.setCostDetail("零用费（10天内）");
		if (aboard_num <= 10) {
			double price = config.getCostPocket1();
			double cost = price * aboard_num;
			bean.setStandard(String.valueOf(cost));
			resList.add(bean);
		} else {
			double price = config.getCostPocket1();
			double cost = price * 10;
			bean.setStandard(String.valueOf(cost));
			resList.add(bean);
		}
		//零用费（10天以后）
		if (aboard_num > 10) {
			bean = new ApplicationDetail();
			bean.setCostDetail("零用费（10天后）");
			aboard_num = aboard_num - 10;
			double price = config.getCostPocket2();
			double cost = price * aboard_num;
			bean.setStandard(String.valueOf(cost));
			resList.add(bean);
		}
		return resList;
	}

	@Override
	public Standard findConfigByClassAndId(String className, Integer configId) {

		if (!StringUtil.isEmpty(className) && configId != null) {
			Finder finder = Finder.create(" from " + className );
			finder.append(" where id=" + configId);
			List<Object> list = super.find(finder);
			if (list != null && list.size() > 0) {
				return (Standard) list.get(0);
			}
		}
		return null;
	}

	@Override
	public Standard getDefaultConfig(String className) {
		
		if (!StringUtil.isEmpty(className)) {
			Finder finder = Finder.create(" from " + className );
			List<Object> list = super.find(finder);
			if (list != null && list.size() > 0) {
				return (Standard) list.get(0);
			}
		}
		return null;
	}

	@Override
	public List<Object> calcCostCar(Integer configId, Integer car_num) {
		List<Object> resList = new ArrayList<>();
		/*//获取支出标准
		RecepStandard config = null;
		if (configId == null) {
			config = (RecepStandard) getDefaultConfig("CarStandard");
		} else {
			config = (RecepStandard) findById(configId);
		}*/
		//据实列支
		ApplicationDetail bean = new ApplicationDetail();
		bean.setCostDetail("公务用车费用");
		bean.setStandard("据实列支");
		resList.add(bean);
		return resList;
	}

	@Override
	public Map<String,Double> getMeetStd(String meetType,Integer meet_personNum, Integer meet_num,Integer configId) {
		Map<String,Double> map = new HashMap<>();
		map.put("hotel", 0.0d);
		map.put("food", 0.0d);
		map.put("other", 0.0d);
		//获取支出标准
		MeetStandard config = null;
		if (StringUtil.isEmpty(meetType)) {
			config = (MeetStandard) getDefaultConfig("MeetStandard");
		} else {
			config = (MeetStandard) meetStandardMng.findbyMeetType(Integer.valueOf(meetType));
		}
		//住宿费
		if (config.getCostHotel() != null) {
			double price = config.getCostHotel();
			double cost = price ;
			map.put("hotel", cost);
		}
		if (config.getCostFood() != null) {
			double price = config.getCostFood();
			double cost = price ;
			map.put("food", cost);
		}
		if (config.getCostOther() != null) {
			double price = config.getCostOther();
			double cost = price ;
			map.put("other", cost);
		}
		
		
		/*Map<String,Double> map = new HashMap<>();
		map.put("hotel", 0.0d);
		map.put("food", 0.0d);
		map.put("other", 0.0d);
		if ("1".equals(meetType)) {
			map.put("hotel", 400d);
			map.put("food", 140d);
			map.put("other", 110d);
		} else if ("2".equals(meetType)) {
			map.put("hotel", 300d);
			map.put("food", 140d);
			map.put("other", 110d);
		} else if ("3".equals(meetType)) {
			map.put("hotel", 280d);
			map.put("food", 130d);
			map.put("other", 90d);
		}*/
		return map;
	}

	@Override
	public Map<String,Double> getTrainStd(String trainType, Integer train_personNum, Integer train_num,Integer configId) {
		Map<String,Double> map = new HashMap<>();
		
		//获取支出标准
		TrainStandard config = null;
		if (StringUtil.isEmpty(trainType)) {
			config = (TrainStandard) getDefaultConfig("TrainStandard");
		} else {
			config = (TrainStandard) trainStandardMng.findbyTrainType(Integer.valueOf(trainType));
		}
		//住宿费
		if (config.getCostHotel() != null) {
			Double price = config.getCostHotel();
			map.put("hotel", price);
		}
		//伙食费
		if (config.getCostFood() != null) {
			Double price = config.getCostFood();
			map.put("food", price);
		}
		//资料、交通费
		if (config.getCostBook() != null) {
			Double price = config.getCostBook();
			map.put("zonghe", price);
		}
		//其他费用
		if (config.getCostOther() != null) {
			Double price = config.getCostOther();
			map.put("other", price);
		}
		//住宿费
		if (config.getCostExternalHotel() != null) {
			Double price = config.getCostExternalHotel();
			map.put("externalHotel", price);
		}
		//伙食费
		if (config.getCostExternalFood() != null) {
			Double price = config.getCostExternalFood();
			map.put("externalFood", price);
		}
		//资料、交通费
		if (config.getCostExternalBook() != null) {
			Double price = config.getCostExternalBook();
			map.put("externalZonghe", price);
		}
		//其他费用
		if (config.getCostExternalOther() != null) {
			Double price = config.getCostExternalOther();
			map.put("externalOther", price);
		}
		//师资费
		Double price = 0.00;
		if (config.getCostOther() != null) {
			price = config.getCostTeach1();
			map.put("lesson1", price);
			price = config.getCostTeach2();
			map.put("lesson2", price);
			price = config.getCostTeach3();
			map.put("lesson3", price);
		}
		return map;
	}
}
