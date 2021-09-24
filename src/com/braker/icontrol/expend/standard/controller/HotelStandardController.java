package com.braker.icontrol.expend.standard.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.braker.common.entity.Combobox;
import com.braker.common.entity.DataEntity;
import com.braker.common.page.ComboboxJson;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.util.DateUtil;
import com.braker.common.util.SortList;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.model.DefaultCombobox;
import com.braker.core.model.User;
import com.braker.icontrol.budget.project.entity.TProBasicInfo;
import com.braker.icontrol.expend.apply.model.AbroadPlan;
import com.braker.icontrol.expend.apply.model.ApplicationDetail;
import com.braker.icontrol.expend.apply.model.InCityTrafficInfo;
import com.braker.icontrol.expend.apply.model.TravelAppliInfo;
import com.braker.icontrol.expend.standard.entity.AboardCountryStandard;
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

@Controller
@RequestMapping("/hotelStandard")
public class HotelStandardController extends BaseController {

	@Autowired
	private StandardMng standardMng;
	@Autowired
	private AboardStandardMng aboardStandardMng;
	@Autowired
	private HotelStandardMng hotelStandardMng;
	@Autowired
	private MeetStandardMng meetStandardMng;
	@Autowired
	private RecepStandardMng recepStandardMng;
	@Autowired
	private TrainStandardMng trainStandardMng;
	@Autowired
	private PersonalWorkMng personalWorkMng;
	@Autowired
	private RegionMng regionMng;
	
	
	@RequestMapping("/list")
	public String list(String outType){
		
		/*<h2 onclick="addTabs('差旅费配置','${base}/hotelStandard/list?outType=travel');">差旅费配置</h2>
		<div></div>
		<h2 onclick="addTabs('会议费配置','${base}/hotelStandard/list?outType=meet');">会议费配置</h2>
		<div></div>
		<h2 onclick="addTabs('培训费配置','${base}/hotelStandard/list?outType=train');">培训费配置</h2>
		<div></div>
		<h2 onclick="addTabs('公务接待费用配置','${base}/hotelStandard/list?outType=recep');">公务接待费用配置</h2>
		<div></div>
		<h2 onclick="addTabs('出国经费配置','${base}/hotelStandard/list?outType=aboard');">出国经费配置</h2>
		<div></div>
		*/
		if ("travel".equals(outType)) {
			return "/WEB-INF/gwideal_core/standard/travel_list";
		} else if ("meet".equals(outType)) {
			return "/WEB-INF/gwideal_core/standard/meet_list";
		} else if ("train".equals(outType)) {
			return "/WEB-INF/gwideal_core/standard/train_list";
		} else if ("recep".equals(outType)) {
			return "/WEB-INF/gwideal_core/standard/recep_list";
		} else if ("aboard".equals(outType)) {
			return "/WEB-INF/gwideal_core/standard/aboard_list";
		}
		return null;
	}
	
	@RequestMapping("/add")
	public String add(ModelMap map, String outType){
		
		map.addAttribute("openType", "add");
		if ("travel".equals(outType)) {
			HotelStandard bean = new HotelStandard();
			map.addAttribute("bean", bean);
			return "/WEB-INF/gwideal_core/standard/travel_add";
			
		} else if ("meet".equals(outType)) {
			MeetStandard bean = new MeetStandard();
			bean.setCostLevel("1");
			map.addAttribute("bean", bean);
			return "/WEB-INF/gwideal_core/standard/meet_add";
			
		} else if ("train".equals(outType)) {
			TrainStandard bean = new TrainStandard();
			map.addAttribute("bean", bean);
			return "/WEB-INF/gwideal_core/standard/train_add";
			
		} else if ("recep".equals(outType)) {
			RecepStandard bean = new RecepStandard();
			map.addAttribute("bean", bean);
			return "/WEB-INF/gwideal_core/standard/recep_add";
			
		} else if ("aboard".equals(outType)) {
			AboardStandard bean = new AboardStandard();
			map.addAttribute("bean", bean);
			return "/WEB-INF/gwideal_core/standard/aboard_add";
		}
		return null;
	}
	
	@RequestMapping("/edit/{id}")
	public String edit(@PathVariable Integer id, ModelMap map, String outType){
		
		map.addAttribute("openType", "edit");
		
		if ("travel".equals(outType)) {
			Standard bean = standardMng.findConfigByClassAndId("HotelStandard", id);
			map.addAttribute("bean", bean);
			return "/WEB-INF/gwideal_core/standard/travel_add";
			
		} else if ("meet".equals(outType)) {
			Standard bean = standardMng.findConfigByClassAndId("MeetStandard", id);
			map.addAttribute("bean", bean);
			return "/WEB-INF/gwideal_core/standard/meet_add";
			
		} else if ("train".equals(outType)) {
			Standard bean = standardMng.findConfigByClassAndId("TrainStandard", id);
			map.addAttribute("bean", bean);
			return "/WEB-INF/gwideal_core/standard/train_add";
			
		} else if ("recep".equals(outType)) {
			Standard bean = standardMng.findConfigByClassAndId("RecepStandard", id);
			map.addAttribute("bean", bean);
			return "/WEB-INF/gwideal_core/standard/recep_add";
			
		} else if ("aboard".equals(outType)) {
			Standard bean = standardMng.findConfigByClassAndId("AboardStandard", id);
			map.addAttribute("bean", bean);
			return "/WEB-INF/gwideal_core/standard/aboard_add";
		}
		return null;
	}

	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable Integer id, ModelMap map, String outType){
		
		if ("travel".equals(outType)) {
			Standard bean = standardMng.findConfigByClassAndId("HotelStandard", id);
			map.addAttribute("bean", bean);
			return "/WEB-INF/gwideal_core/standard/detail/travel_detail";
			
		} else if ("meet".equals(outType)) {
			Standard bean = standardMng.findConfigByClassAndId("MeetStandard", id);
			map.addAttribute("bean", bean);
			return "/WEB-INF/gwideal_core/standard/detail/meet_detail";
			
		} else if ("train".equals(outType)) {
			Standard bean = standardMng.findConfigByClassAndId("TrainStandard", id);
			map.addAttribute("bean", bean);
			return "/WEB-INF/gwideal_core/standard/detail/train_detail";
			
		} else if ("recep".equals(outType)) {
			Standard bean = standardMng.findConfigByClassAndId("RecepStandard", id);
			map.addAttribute("bean", bean);
			return "/WEB-INF/gwideal_core/standard/detail/recep_detail";
			
		} else if ("aboard".equals(outType)) {
			Standard bean = standardMng.findConfigByClassAndId("AboardStandard", id);
			map.addAttribute("bean", bean);
			return "/WEB-INF/gwideal_core/standard/detail/aboard_detail";
		}
		return null;
	}
	
	/**
	 * 跳转到选择出差地方页面
	 * @param map
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年4月20日
	 * @updator 陈睿超
	 * @updatetime 2020年4月20日
	 */
	@RequestMapping("/choose")
	public String choose(ModelMap model,String index,String editType,String tabId){
		model.addAttribute("index", index);
		model.addAttribute("editType", editType);
		model.addAttribute("tabId", tabId);
		return "/WEB-INF/gwideal_core/hotelstd/hotelstd_choose";
	}
	/**
	 * 跳转到选择出差人员页面
	 * @param model
	 * @param index
	 * @param editType
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年4月20日
	 * @updator 陈睿超
	 * @updatetime 2020年4月20日
	 */
	@RequestMapping("/chooseUser")
	public String chooseUser(ModelMap model,String index,String editType,String tabId){
		model.addAttribute("index", index);
		model.addAttribute("editType", editType);
		model.addAttribute("tabId", tabId);
		return "/WEB-INF/view/expend/apply/add/choose_userrole";
	}

	@RequestMapping("/save")
	@ResponseBody
	public Result save(String outType, MeetStandard meetBean, TrainStandard trainBean, RecepStandard recepBean, AboardStandard aboardBean, HotelStandard travelBean){//可以写上所有的实现类试试
		try {
			if ("travel".equals(outType)) {
				standardMng.saveHotelStandard(travelBean, getUser());
			} else if ("meet".equals(outType)) {
				standardMng.saveHotelStandard(meetBean, getUser());
			} else if ("train".equals(outType)) {
				standardMng.saveHotelStandard(trainBean, getUser());
			} else if ("recep".equals(outType)) {
				standardMng.saveHotelStandard(recepBean, getUser());
			} else if ("aboard".equals(outType)) {
				standardMng.saveHotelStandard(aboardBean, getUser());
			}
			return getJsonResult(true, Result.saveSuccessMessage);
		} catch (NumberFormatException e) {
			e.printStackTrace();
			return getJsonResult(true, Result.saveSuccessMessage);
		}
	}
	
	@RequestMapping("/delete/{id}")
	@ResponseBody
	public Result delete(@PathVariable Integer id,String fId,String outType){
		try{
			if ("travel".equals(outType)) {
				hotelStandardMng.deleteById(id);
			} else if ("meet".equals(outType)) {
				meetStandardMng.deleteById(id);
			} else if ("train".equals(outType)) {
				trainStandardMng.deleteById(id);
			} else if ("recep".equals(outType)) {
				recepStandardMng.deleteById(id);
			} else if ("aboard".equals(outType)) {
				aboardStandardMng.deleteById(id);
			}
			personalWorkMng.deleteById(Integer.valueOf(fId));
			personalWorkMng.sendMessageToUser(getUser().getId(),0);
			return getJsonResult(true, Result.deleteSuccessMessage);
		} catch (NumberFormatException e) {
			e.printStackTrace();
			return getJsonResult(false, Result.deleteSuccessMessage);
		}
	}
	
	@RequestMapping("/pageList")
	@ResponseBody
	public JsonPagination pageList(String outType,  ModelMap model, Integer page, Integer rows, String travel_area, String meet_level, String train_level, String recep_, String aboard_){
		
		if (page == null) page = 1;
		if (rows == null) rows = 10;
		Pagination p = null;
		if ("travel".equals(outType)) {
			HotelStandard bean = new HotelStandard();
			bean.setArea(travel_area);
			p = standardMng.pageListTravel(bean, getUser(), page, rows);
			
		} else if ("meet".equals(outType)) {
			MeetStandard bean = new MeetStandard();
			p = standardMng.pageListMeet(bean, getUser(), page, rows);
			
		} else if ("train".equals(outType)) {
			TrainStandard bean = new TrainStandard();
			p = standardMng.pageListTrain(bean, getUser(), page, rows);
			
		} else if ("recep".equals(outType)) {
			RecepStandard bean = new RecepStandard();
			p = standardMng.pageListRecep(bean, getUser(), page, rows);
			
		} else if ("aboard".equals(outType)) {
			AboardStandard bean = new AboardStandard();
			p = standardMng.pageListAboard(bean, getUser(), page, rows);
		}
		return getJsonPagination(p, page);
	}
	
	/**
	 * 计算的各项费用
	 */
	@RequestMapping("/calcCost")
	@ResponseBody
	public List<Object> calcCost(Integer configId, String outType, 
			String travelDays, String hotelDays, 
			Integer meet_personNum, Integer meet_num,
			String train_teachLevel, Integer train_personNum, Integer train_num,
			Integer recep_personNum, Integer recep_num,
			Integer car_num,
			Integer aboard_num,String userId,String day1,String day2){
		try {
			List<Object> resList = new ArrayList<Object>();
			if ("travel".equals(outType)) {
				resList = standardMng.calcCostTravel1(configId, travelDays, hotelDays,userId,day1,day2);
			} else if ("meet".equals(outType)) {
				resList = standardMng.calcCostMeet(configId, meet_personNum, meet_num);
			} else if ("train".equals(outType)) {
				resList = standardMng.calcCostTrain(configId, train_teachLevel, train_personNum, train_num);
			} else if ("recep".equals(outType)) {
				resList = standardMng.calcCostRecep(configId, recep_personNum, recep_num);
			} else if ("aboard".equals(outType)) {
				resList = standardMng.calcCostAboard(configId, aboard_num);
			} else if ("car".equals(outType)) {
				resList = standardMng.calcCostCar(configId, car_num);
			}
			return resList;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 计算的各项费用
	 */
	@RequestMapping("/calcCostAbroad")
	@ResponseBody
	public List<Object> calcCostAbroad(Integer configId){
		try {
			List<Object> resList = new ArrayList<Object>();
				AboardCountryStandard config = (AboardCountryStandard) standardMng.findConfigByClassAndId("AboardCountryStandard",configId);			//出差配置
				resList.add(config);
			return resList;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 获取费用标准
	 */
	@RequestMapping("/getStd")
	@ResponseBody
	public Object getStd(String applyType,Integer train_trainingType, Integer configId,String meetType,Integer meet_personNum, Integer meet_num){
		if ("meet".equals(applyType)) {
			return standardMng.getMeetStd(meetType, meet_personNum,  meet_num, configId);
		}else if ("train".equals(applyType)) {
			return standardMng.getTrainStd(meetType, meet_personNum, meet_num, configId);
		}
		return null;
	}
	/**
	 * 获取城市间交通费出行人乘坐标准
	 */
	@RequestMapping("/outAtandard")
	@ResponseBody
	public boolean outAtandard(String vehicleLevel,Integer userId){
		
		return true;
	}
	/**
	 * 获取住宿费出行人住宿标准
	 */
	@RequestMapping("/hotelAtandard")
	@ResponseBody
	public boolean hotelAtandard(String checkInTime,String checkOUTTime,String userId,String CityId){
		
		return true;
	}
	/**
	 * 
	 * @param applyType
	 * @param train_trainingType
	 * @param configId
	 * @param meetType
	 * @param meet_personNum
	 * @param meet_num
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年4月23日
	 * @updator 陈睿超
	 * @updatetime 2020年4月23日
	 */
	@ResponseBody
	@RequestMapping("/getStandard")
	public List<Object[]> getStandard(String list){
		//页面列表行程清单数据
		try {
			List<TravelAppliInfo> lists = JSON.parseObject(list,new TypeReference<List<TravelAppliInfo>>(){});
			//按人分为每条数据
			List<TravelAppliInfo> listInfo = new ArrayList<TravelAppliInfo>();
			for (TravelAppliInfo travelAppliInfo : lists) {
				String[] peopId = travelAppliInfo.getTravelAttendPeopId().split(",");
				String[] peop = travelAppliInfo.getTravelAttendPeop().split(",");
				if(peopId.length>1){
					for (int i = 0; i < peopId.length; i++) {
						TravelAppliInfo appliInfo = new TravelAppliInfo();
						appliInfo.setTravelAttendPeopId(peopId[i]);
						appliInfo.setTravelAttendPeop(peop[i]);
						appliInfo.setTravelArea(travelAppliInfo.getTravelArea());
						appliInfo.setTravelDateStart(travelAppliInfo.getTravelDateStart());
						appliInfo.setTravelDateEnd(travelAppliInfo.getTravelDateEnd());
						listInfo.add(appliInfo);
					}
				}else{
					TravelAppliInfo appliInfo = new TravelAppliInfo();
					appliInfo.setTravelAttendPeopId(peopId[0]);
					appliInfo.setTravelAttendPeop(peop[0]);
					appliInfo.setTravelArea(travelAppliInfo.getTravelArea());
					appliInfo.setTravelDateStart(travelAppliInfo.getTravelDateStart());
					appliInfo.setTravelDateEnd(travelAppliInfo.getTravelDateEnd());
					listInfo.add(appliInfo);
				}
			}
			for (TravelAppliInfo travelAppliInfo : lists) {
				if(!StringUtil.isEmpty(travelAppliInfo.getfIdentityNumber())){
					String[] fIdentityNumber = travelAppliInfo.getfIdentityNumber().split(",");
					String[] fName = travelAppliInfo.getfName().split(",");
					if(fIdentityNumber.length>1){
						for (int i = 0; i < fIdentityNumber.length; i++) {
							TravelAppliInfo appliInfo = new TravelAppliInfo();
							appliInfo.setTravelAttendPeopId(fIdentityNumber[i]);
							appliInfo.setTravelAttendPeop(fName[i]);
							appliInfo.setTravelArea(travelAppliInfo.getTravelArea());
							appliInfo.setTravelDateStart(travelAppliInfo.getTravelDateStart());
							appliInfo.setTravelDateEnd(travelAppliInfo.getTravelDateEnd());
							listInfo.add(appliInfo);
						}
					}else{
						TravelAppliInfo appliInfo = new TravelAppliInfo();
						appliInfo.setTravelAttendPeopId(fIdentityNumber[0]);
						appliInfo.setTravelAttendPeop(fName[0]);
						appliInfo.setTravelArea(travelAppliInfo.getTravelArea());
						appliInfo.setTravelDateStart(travelAppliInfo.getTravelDateStart());
						appliInfo.setTravelDateEnd(travelAppliInfo.getTravelDateEnd());
						listInfo.add(appliInfo);
					}
				}
			}
			
				HashSet<String> hashSet  = new HashSet<String>();
				for (int i =0; i<listInfo.size(); i++){ //外循环是循环的次数 
					hashSet.add(listInfo.get(i).getTravelAttendPeopId());
					}
				//声明一个list
				List<Object[]> obj = new ArrayList<Object[]>(); 
				//通过hashSet取到去重后的值
				for (String string : hashSet) {
					List<TravelAppliInfo> listInfoss = new ArrayList<TravelAppliInfo>();
					for (int i = 0; i < listInfo.size(); i++) {
						//通过人员id取到一个人所有的数据
						if(listInfo.get(i).getTravelAttendPeopId().equals(string)){
							listInfoss.add(listInfo.get(i));
						}
					}
					int dayNum = 0;//一个人的总天数
					int stdDayNum = 0;//上一次循环的总天数
					Double foodNum = 0.00;//一个人的总伙食补助
					Double cityNum = 0.00;//一个人的总市内交通费
					Double cityNumStd = 0.00;//一个人的总市内交通费标准
					Double foodNumStd = 0.00;//一个人的总伙食费标准
					String[] arr = new String[7];
					SortList<TravelAppliInfo> l = new SortList<>();
					l.Sort(listInfoss, "getTravelDateStartSort", "asc", "date");
					//循环第一个人的所有行程单
					for (int i = 0; i < listInfoss.size(); i++) {
						//一条数据的天数
						int days =0;
						//如果是最后一行
						if(i==listInfoss.size()-1){
							//147代表天津
							if("13".equals(String.valueOf(listInfoss.get(i).getTravelAreaId()))||"38".equals(String.valueOf(listInfoss.get(i).getTravelAreaId()))){
								days = DateUtil.getDaySpan(listInfoss.get(i).getTravelDateStart(), listInfoss.get(i).getTravelDateEnd())+1;
							}else{
								days = DateUtil.getDaySpan(listInfoss.get(i).getTravelDateStart(), listInfoss.get(i).getTravelDateEnd());
							}
						}else{//非最后一行
							days = DateUtil.getDaySpan(listInfoss.get(i).getTravelDateStart(), listInfoss.get(i).getTravelDateEnd());
						}
						dayNum =dayNum+days;
						//根据地区ID查询每个地区的交通补助和伙食补助
						HotelStandard config = (HotelStandard) standardMng.findConfigByClassAndId("HotelStandard",listInfoss.get(i).getTravelAreaId());			//出差配置
						if(dayNum<=8){
							//伙食补助标准
							foodNum = foodNum + (config.getCostFood()*days);
							//伙食补助标准
							cityNum = cityNum+ (config.getCostTrafficShort()*days);
							//交通费标准
							cityNumStd = config.getCostTrafficShort();
							//伙食费标准
							foodNumStd = config.getCostFood();
						}else if(dayNum>8&&dayNum<=30){
							if(stdDayNum<=8){//横跨0-8和8-30天的情况
								//伙食补助标准
								foodNum = foodNum + (config.getCostFood()*(8-stdDayNum))+(config.getCostFood()*(dayNum-8)*0.5);
								//伙食补助标准
								cityNum = cityNum+ (config.getCostTrafficShort()*(8-stdDayNum))+(config.getCostTrafficShort()*(dayNum-8)*0.5);
							}else{
								foodNum = foodNum + (config.getCostFood()*days*0.5);
								cityNum = cityNum+ (config.getCostTrafficShort()*days*0.5);
							}
							/*//伙食补助标准
							cityNum = cityNum+ (config.getCostTrafficShort()*8)+(config.getCostTrafficShort()*(dayNum-8)*0.5);*/
							//交通费标准
							cityNumStd = config.getCostTrafficShort();
							//伙食费标准
							foodNumStd = config.getCostFood();
						}else{
							if(stdDayNum<=8){//横跨0-8 8-30 >30天  三种情况
								//伙食补助标准
								foodNum = foodNum + (config.getCostFood()*8)+(config.getCostFood()*22*0.5)+25*(dayNum-30);
								//交通费标准
								cityNum = cityNum + (config.getCostTrafficShort()*8)+(config.getCostTrafficShort()*22*0.5)+25*(dayNum-30);
							}else if(stdDayNum>8&&stdDayNum<=30){//横跨 8-30 >30 天 两种情况
								//伙食补助标准
								foodNum = foodNum + (config.getCostFood()*(30-stdDayNum)*0.5)+(25*(dayNum-30));
								//交通费标准
								cityNum = cityNum + (config.getCostTrafficShort()*(30-stdDayNum)*0.5);
							}else{
								foodNum =foodNum+25*days;
							}
							
							//伙食补助标准
							cityNum = cityNum+ (config.getCostTrafficShort()*8)+(config.getCostTrafficShort()*22*0.5);
							//交通费标准
							cityNumStd = config.getCostTrafficShort();
							//伙食费标准
							foodNumStd = config.getCostFood();
						}
						stdDayNum =stdDayNum+days;
					}
					boolean flag =true;
					for (int f = 0; f < lists.size(); f++) {
						String[] fIdentityNumber = lists.get(f).getfIdentityNumber().split(",");
						boolean flag1 =true;
						for (String string2 : fIdentityNumber) {
							if(string2.equals(string)){
								flag1 =false;
								break;
							}
						}
						if(!flag1){
							flag =false;
							break;
						}
					}
					if(flag){
						arr[0]=listInfoss.get(0).getTravelAttendPeop();
						arr[1]=String.valueOf(dayNum);
						arr[2]=String.valueOf(cityNum);
						arr[3]=String.valueOf(foodNum);
						arr[4]=String.valueOf(cityNumStd);
						arr[5]=String.valueOf(foodNumStd);
						arr[6]="teacher";
					}else{
						arr[0]=listInfoss.get(0).getTravelAttendPeop();
						arr[1]=String.valueOf(dayNum);
						arr[2]=String.valueOf(cityNum/2);
						arr[3]=String.valueOf(foodNum/2);
						arr[4]=String.valueOf(cityNumStd/2);
						arr[5]=String.valueOf(foodNumStd/2);
						arr[6]="student";
					}
					obj.add(arr);
				}
			return obj;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 
	 * @param applyType
	 * @param train_trainingType
	 * @param configId
	 * @param meetType
	 * @param meet_personNum
	 * @param meet_num
	 * @return
	 * @author 陈睿超
	 * @createtime 2020年4月23日
	 * @updator 陈睿超
	 * @updatetime 2020年4月23日
	 */
	@ResponseBody
	@RequestMapping("/getStandardAbroad")
	public List<Object[]> getStandardAbroad(String list){
		//页面列表行程清单数据
		try {
			list =StringUtil.setUTF8(list);
			List<AbroadPlan> lists = JSON.parseObject(list,new TypeReference<List<AbroadPlan>>(){});
			AbroadPlan abroadPlan = lists.get(lists.size()-1);
			SortList<AbroadPlan> l = new SortList<>();
			l.Sort(lists, "getTimeEndSort", "asc", "date");
			HashSet<String> hashSet  = new HashSet<String>();
			for (int i =0; i<lists.size(); i++){ //外循环是循环的次数 
				hashSet.add(String.valueOf(lists.get(i).getArriveCountryId()));
			}
			//声明一个list
			List<Object[]> obj = new ArrayList<Object[]>(); 
			//通过hashSet取到去重后的值
			for (String string : hashSet) {
				List<AbroadPlan> listInfoss = new ArrayList<AbroadPlan>();
				for (int i = 0; i < lists.size(); i++) {
					//通过人员id取到一个人所有的数据
					if(String.valueOf(lists.get(i).getArriveCountryId()).equals(string)){
						listInfoss.add(lists.get(i));
					}
				}
				int dayNum = 0;//一个城市的住宿费总天数
				int feeNum = 0;//一个城市的公杂费总天数
				Double foodStu = 0.00;//一个城市的总伙食补助
				Double feeStu = 0.00;//一个城市的总公杂费
				String currency =""; //币种
				String[] arr = new String[6];
				//循环第一个人的所有行程单
				for (int i = 0; i < listInfoss.size(); i++) {
					//一条数据的天数
					int daysFood =0;
					int daysFee =0;
					if(i==listInfoss.size()-1){
						daysFood = DateUtil.getDaySpan(listInfoss.get(i).getAbroadDate(), listInfoss.get(i).getTimeEnd())+1;
						daysFee = DateUtil.getDaySpan(listInfoss.get(i).getAbroadDate(), listInfoss.get(i).getTimeEnd())+1;
					}else{
						daysFood = DateUtil.getDaySpan(listInfoss.get(i).getAbroadDate(), listInfoss.get(i).getTimeEnd());
						daysFee = DateUtil.getDaySpan(listInfoss.get(i).getAbroadDate(), listInfoss.get(i).getTimeEnd());
					}
					dayNum =dayNum+daysFood;
					feeNum =feeNum+daysFee;
					//根据地区ID查询每个地区的交通补助和伙食补助
					AboardCountryStandard config = (AboardCountryStandard) standardMng.findConfigByClassAndId("AboardCountryStandard",listInfoss.get(i).getArriveCountryId());			//出差配置
					//伙食费标准
					foodStu = config.getFoodMoney();
					//公杂费标准
					feeStu = config.getTrafficMoney();
					//币种
					currency = config.getCurrency();
				}
				arr[0]=listInfoss.get(0).getArriveCountry()+"("+listInfoss.get(0).getArriveCity()+")";  //所在国家加城市
				arr[1]=String.valueOf(dayNum);             //住宿天数
				arr[2]=String.valueOf(feeNum);             //公杂费天数
				arr[3]=String.valueOf(foodStu);            //一个城市的总伙食补助
				arr[4]=String.valueOf(feeStu);             //一个城市的总公杂费
				arr[5]=String.valueOf(currency);           //币种
				obj.add(arr);
			}
			return obj;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	@ResponseBody
	@RequestMapping("/getStandardTravel")
	public List<Object[]> getStandardTravel(String list){
		//页面列表行程清单数据
		try {
			List<TravelAppliInfo> lists = JSON.parseObject(list,new TypeReference<List<TravelAppliInfo>>(){});
			//按人分为每条数据
			List<TravelAppliInfo> listInfo = new ArrayList<TravelAppliInfo>();
			for (TravelAppliInfo travelAppliInfo : lists) {
				String[] peopId = travelAppliInfo.getTravelAttendPeopId().split(",");
				String[] peop = travelAppliInfo.getTravelAttendPeop().split(",");
				if(peopId.length>1){
					for (int i = 0; i < peopId.length; i++) {
						TravelAppliInfo appliInfo = new TravelAppliInfo();
						appliInfo.setTravelAttendPeopId(peopId[i]);
						appliInfo.setTravelAttendPeop(peop[i]);
						appliInfo.setTravelAreaId(travelAppliInfo.getTravelAreaId());
						appliInfo.setTravelDateStart(travelAppliInfo.getTravelDateStart());
						appliInfo.setTravelDateEnd(travelAppliInfo.getTravelDateEnd());
						listInfo.add(appliInfo);
					}
				}else{
					TravelAppliInfo appliInfo = new TravelAppliInfo();
					appliInfo.setTravelAttendPeopId(peopId[0]);
					appliInfo.setTravelAttendPeop(peop[0]);
					appliInfo.setTravelAreaId(travelAppliInfo.getTravelAreaId());
					appliInfo.setTravelDateStart(travelAppliInfo.getTravelDateStart());
					appliInfo.setTravelDateEnd(travelAppliInfo.getTravelDateEnd());
					listInfo.add(appliInfo);
				}
			}
			
				HashSet<String> hashSet  = new HashSet<String>();
				for (int i =0; i<listInfo.size(); i++){ //外循环是循环的次数 
					hashSet.add(listInfo.get(i).getTravelAttendPeopId());
					}
				//声明一个list
				List<Object[]> obj = new ArrayList<Object[]>(); 
				//通过hashSet取到去重后的值
				for (String string : hashSet) {
					List<TravelAppliInfo> listInfoss = new ArrayList<TravelAppliInfo>();
					for (int i = 0; i < listInfo.size(); i++) {
						//通过人员id取到一个人所有的数据
						if(listInfo.get(i).getTravelAttendPeopId().equals(string)){
							listInfoss.add(listInfo.get(i));
						}
					}
					int dayNum = 0;//一个人的总天数
					Double foodNum = 0.00;//一个人的总伙食补助
					Double cityNum = 0.00;//一个人的总市内交通费
					String[] arr = new String[4];
					//循环第一个人的所有行程单
					for (int i = 0; i < listInfoss.size(); i++) {
						//一条数据的天数
						int days =0;
						//如果是最后一行
						if(i==listInfoss.size()-1){
							//147代表天津
							if("147".equals(String.valueOf(listInfoss.get(i).getTravelAreaId()))||"148".equals(String.valueOf(listInfoss.get(i).getTravelAreaId()))){
								days = DateUtil.getDaySpan(listInfoss.get(i).getTravelDateStart(), listInfoss.get(i).getTravelDateEnd())+1;
							}else{
								days = DateUtil.getDaySpan(listInfoss.get(i).getTravelDateStart(), listInfoss.get(i).getTravelDateEnd());
							}
						}else{//非最后一行
							days = DateUtil.getDaySpan(listInfoss.get(i).getTravelDateStart(), listInfoss.get(i).getTravelDateEnd());
						}
						dayNum =dayNum+days;
						//根据地区ID查询每个地区的交通补助和伙食补助
						HotelStandard config = (HotelStandard) standardMng.findConfigByClassAndId("HotelStandard",listInfoss.get(i).getTravelAreaId());			//出差配置
						//伙食补助标准
						foodNum = foodNum + (config.getCostFood()*days);
						//伙食补助标准
						cityNum = cityNum+ (config.getCostTrafficShort()*days);
					}
					arr[0]=listInfoss.get(0).getTravelAttendPeop();
					arr[1]=String.valueOf(dayNum);
					arr[2]=String.valueOf(cityNum);
					arr[3]=String.valueOf(foodNum);
					obj.add(arr);
				}
			return obj;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	@ResponseBody
	@RequestMapping("/getHotelStandardRegionId")
	public String getHotelStandardRegionId(String id,String level){
		String hintStringAll = "";
		if(StringUtils.isNotEmpty(id)){
			String[] ids = id.split(",");
			for (int i = 0; i < ids.length; i++) {
				//根据地区ID查询每个地区的交通补助和伙食补助
				List<HotelStandard> config = hotelStandardMng.findByProperty("areaId", Integer.valueOf(ids[i]));			//出差配置
				HotelStandard hotelStandard = new HotelStandard();
				Region region = new Region();
				if(config.size()==0){
					region = regionMng.findById(Integer.valueOf(ids[i]));
					config = hotelStandardMng.findByProperty("areaId", region.getCode());		
					if(config.size()==0){
						region = regionMng.findById(region.getpCode());
						hotelStandard = hotelStandardMng.findByProperty("areaId", region.getCode()).get(0);		
					}else{
						hotelStandard = config.get(0);
					}
				}else{
					hotelStandard = config.get(0);
				}
				
				String hintString = hotelStandard.getArea()+"差旅标准：";
				String lead = "党委书记或校长住宿费限额标准"+hotelStandard.getNormalPriceMid()+"（元/人·天）";
				String staff = "其他人员住宿费限额标准"+hotelStandard.getNormalPriceMin()+"（元/人·天）";
				String leads = "党委书记或校长住宿费限额标准"+hotelStandard.getBusyPriceMid()+"（元/人·天）,";
				String staffs = "其他人员住宿费限额标准"+hotelStandard.getBusyPriceMin()+"（元/人·天）";
				if(StringUtils.isNotEmpty(level)){
					level+=","+getUser().getRoleslevel();
				}else{
					level=String.valueOf(getUser().getRoleslevel());
				}
				String[] a = level.split(",");
				HashSet<String> set  = new HashSet<String>();
				  for(int y=0;y<a.length;y++){
				   set.add(a[y]);
				 }
				if(set.size()==1){
					for (String string : set) {
						if("2".equals(string)){
							hintString+=lead;
						}
						if("3".equals(string)){
							hintString+=staff;
						}
					}
				}else{
					for (String string : set) {
						if("2".equals(string)){
							hintString+=lead;
						}
						if("3".equals(string)){
							hintString+=staff;
						}
					}
				}
				
				if("1".equals(String.valueOf(hotelStandard.getHasBusy()))){
					hintString+="淡旺季浮动差旅标准：";
					if(set.size()==1){
						for (String string : set) {
							if("2".equals(string)){
								hintString+=leads;
							}
							if("3".equals(string)){
								hintString+=staffs;
							}
						}

					}else{
						for (String string : set) {
							if("2".equals(string)){
								hintString+=leads;
							}
							if("3".equals(string)){
								hintString+=staffs;
							}
						}
					}
				}
				hintStringAll+=hintString+"<br/>";
			}
			}
		return hintStringAll;
	}
	
	@ResponseBody
	@RequestMapping("/getHotelStandardByRegionId")
	public List<ComboboxJson> getHotelStandardByRegionId(String id,String level,String day1,String day2){
		try {
			List<DataEntity> hintStringAll = new ArrayList<DataEntity>();
			List<DefaultCombobox> comboboxs = new ArrayList<DefaultCombobox>();
			Integer configId = 0;
			if(StringUtils.isNotEmpty(id)){
				//根据地区ID查询每个地区的交通补助和伙食补助
				List<HotelStandard> config = hotelStandardMng.findByProperty("areaId", Integer.valueOf(id));			//出差配置
				Region region = new Region();
				if(config.size()==0){
					region = regionMng.findById(Integer.valueOf(id));
					region = regionMng.findById(region.getpCode());
					config = hotelStandardMng.findByProperty("areaId", region.getCode());		
					if(config.size()==0){
						region = regionMng.findById(region.getpCode());
						configId = region.getCode();
					}else{
						configId = region.getCode();
					}
				}else{
					configId = Integer.valueOf(id);
				}
					hintStringAll = standardMng.calcCostTravel13(configId, level, day1, day2);
			}
			for (DataEntity info : hintStringAll) {
				DefaultCombobox combobox = new DefaultCombobox();
				combobox.setId(info.getId());
				combobox.setCode(info.getCol1());
				combobox.setName(info.getCol1());
				comboboxs.add(combobox);
			}
			
			List<ComboboxJson> listCombobox=new ArrayList<ComboboxJson>();
			ComboboxJson comboboxJson=null;
			for (int i = 0; i < comboboxs.size(); i++) {
				comboboxJson=new ComboboxJson();
				Combobox combobox=(Combobox)comboboxs.get(i);
				comboboxJson.setId(combobox.getId());
				comboboxJson.setCode(combobox.getCode());
    			comboboxJson.setText(combobox.getText());
    			listCombobox.add(comboboxJson);
			}
			return listCombobox;
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@ResponseBody
	@RequestMapping("/getStandardHotelAttend")
	public List<Object> getStandardHotelAttend(Integer configId, String travelDays, String hotelDays, String userId,String day1,String day2){
		try {
			List<Object> resList = standardMng.calcCostTravel12(configId, travelDays, hotelDays,userId,day1,day2);
			return resList;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
