package com.braker.icontrol.cockpit.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.portlet.ModelAndView;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.util.DateUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Depart;
import com.braker.core.model.User;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.entity.TOutcomeLog;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.manager.manager.TOutcomeLogMng;
import com.braker.icontrol.budget.manager.manager.TransmitMng;
import com.braker.icontrol.budget.release.entity.TIndexDetail;
import com.braker.icontrol.budget.release.manager.IndexDetailMng;
import com.braker.icontrol.cockpit.manager.CockpitMng;
import com.braker.icontrol.expend.apply.manager.ApplicationBasicInfoMng;
import com.braker.icontrol.expend.apply.manager.MeetingMng;
import com.braker.icontrol.expend.apply.manager.TrainingMng;
import com.braker.icontrol.expend.apply.model.ApplicationBasicInfo;
import com.braker.icontrol.expend.apply.model.MeetingAppliInfo;
import com.braker.icontrol.expend.reimburse.manager.ReimbAppliMng;
import com.braker.icontrol.expend.reimburse.model.ReimbAppliBasicInfo;
/**
 * 驾驶舱下钻图控制器
 */
@Controller
@RequestMapping("/cockDetail")
public class CockDetailController extends BaseController {
	
	@Autowired
	private TOutcomeLogMng tOutcomeLogMng;
	@Autowired
	private UserMng userMng;
	@Autowired
	public CockpitMng cockpitMng;
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private ApplicationBasicInfoMng applicationBasicInfoMng;
	@Autowired
	private ReimbAppliMng reimbAppliMng;
	@Autowired
	private TransmitMng transmitMng;
	@Autowired
	private IndexDetailMng indexDetailMng;
	@Autowired
	private TrainingMng trainingMng;
	@Autowired
	private MeetingMng meetingMng;
	
	
	//总预算 详情
	@RequestMapping("/tBudget")
	public String tBudget(ModelMap model, String year, String departId){

		model.addAttribute("year", year);
		model.addAttribute("departId", departId);
		return "/WEB-INF/view/cockpit-detail/total-budget";
	}
	//总支出 详情
	@RequestMapping("/tOutcome")
	public String tOutcome(ModelMap model, String year, String departId){
		
		model.addAttribute("year", year);
		model.addAttribute("departId", departId);
		return "/WEB-INF/view/cockpit-detail/total-outcome";
	}
	//剩余 详情
	@RequestMapping("/tLeast")
	public String tLeast(ModelMap model, String year, String departId){
		
		model.addAttribute("year", year);
		model.addAttribute("departId", departId);
		return "/WEB-INF/view/cockpit-detail/total-least";
	}
	
	//打开 各部门预算执行排名 的详情
	@RequestMapping("/inC1")
	public String openChart1(ModelMap model, String departName, String year){
		departName=StringUtil.setUTF8(departName);
		model.addAttribute("departName",departName);
		List<Depart> list =departMng.findByProperty("name", departName);
		String departId=list.get(0).getId();
		model.addAttribute("departId",departId);
		model.addAttribute("year",year);
		return "/WEB-INF/view/cockpit-detail/inner1";
	} 
	
	//打开 项目执行进度（前五/后五）的详情
	@RequestMapping("/inC2")
	public String openChart2(ModelMap model, String type, String indexName,String indexCode){
		
		model.addAttribute("type",type);
		/*List<TBudgetIndexMgr> list = budgetIndexMgrMng.findByProperty("indexCode", indexName);
		if (list != null && list.size() > 0) {
			model.addAttribute("indexCode",list.get(0).getIndexCode());
		}*/
		model.addAttribute("indexCode",indexCode);
		return "/WEB-INF/view/cockpit-detail/inner2";
	} 
	
	//打开 培训会议支出计划 的详情
	@RequestMapping("/inC3")
	public String openChart3(ModelMap model, String type, String year, String departId){
		
		model.addAttribute("year",year);
		model.addAttribute("departId",departId);
		if ("train".equals(type)) {	//金额
			return "/WEB-INF/view/cockpit-detail/inner3-train";
		} else if ("trainNum".equals(type)) { //数量
			return "/WEB-INF/view/cockpit-detail/inner3-train-num";
		} else if ("meeting".equals(type)) {
			return "/WEB-INF/view/cockpit-detail/inner3-meeting";
		} else if ("meetingNum".equals(type)) {
			return "/WEB-INF/view/cockpit-detail/inner3-meeting-num";
		}
		return "";
	} 
	
	//打开 各部门差旅费支出情况 的详情
	@RequestMapping("/inC4")
	public String openChart4(ModelMap model, String departName, String year){
		departName=StringUtil.setUTF8(departName);
		model.addAttribute("year",year);
		model.addAttribute("departName",departName);
		return "/WEB-INF/view/cockpit-detail/inner4";
	} 
	
	//打开 三公经费 的详情
	@RequestMapping("/inC5")
	public String openChart5(ModelMap model, String itemName, String year, String departId){
		//5 公务接待申请 6 公务用车申请 7公务出国申请
		model.addAttribute("year",year);
		model.addAttribute("departId",departId);
		model.addAttribute("itemName",itemName);
		model.addAttribute("currentYear", DateUtil.getCurrentYear());
		return "/WEB-INF/view/cockpit-detail/inner5";
	} 
	
	//数据 项目执行排名前五/后五 排名
	@RequestMapping(value = "/outLogData")
	@ResponseBody
	public JsonPagination outLogData(ModelMap model, TOutcomeLog bean, String sort,
			String order, Integer page, Integer rows,String searchUserName, String searchDeptName){
		
		if (bean != null && !StringUtil.isEmpty(bean.getIndexCode())) {
			Pagination p = tOutcomeLogMng.pageList(bean, getUser(), page, rows,searchUserName,searchDeptName);
			return getJsonPagination(p, page);
		}
		return getJsonPagination(new Pagination(), page);
	}
	//三公经费 获取ApplicationBasicInfo的ID来查看详情
	@RequestMapping("/chartApp")
	@ResponseBody
	public String chartApp(String code){
		ApplicationBasicInfo aa=applicationBasicInfoMng.findByProperty("gCode", code).get(0);
		String ss=aa.getgId().toString();
		return ss;
	}
	
	// 部门执行排名列表
		@RequestMapping(value = "/departData")
		@ResponseBody
		public JsonPagination departData(TBudgetIndexMgr bean,String departName, String year, Integer page, Integer rows){
				departName=StringUtil.setUTF8(departName);
				Pagination p = cockpitMng.getDepartData(bean,departName,year,page,rows);
				return getJsonPagination(p, page);
		}
	
	/**
	 * 一级下钻图
	 * @param model
	 * @param chartName 表名
	 * @param departName 部门，仅在前台指定部门时使用
	 * @param type 经费类型，仅在前台跳转三公经费类型时使用
	 * @param dates 查询起始时间
	 * @param datee 查询结束时间
	 * @return 
	 */
	//驾驶舱1级下钻图表
	@RequestMapping("/insideData1")
	@ResponseBody
	public Map<String,Double> insideData1(ModelMap model, String chartName, String departName,
			String itemName, String year, String departId, String dates, String datee){
		try {
			if (StringUtil.isEmpty(chartName)) return null;
			
			Map<String,Double> map = new HashMap<>();
			Depart depart = null;
			if (StringUtil.isEmpty(year)) {
				//没有查询条件，默认本年度
				year = DateUtil.getCurrentYear();
			}
			if (StringUtil.isEmpty(departId)) {
				//没有查询条件，默认本部门
				depart = getUser().getDepart();
			} else {
				depart = departMng.findById(departId);
			}
			
			
			if (chartName.contains("chart1")) {
				//单位预算概况
				if ("chart1-budget1".equals(chartName)) {
					//总预算-各类型指标额度占比
					map = cockpitMng.getData1(depart,year, getUser());
				} else if ("chart1-budget2".equals(chartName)) {
					//总预算-各部门指标额度占比
					map = cockpitMng.getData2(depart,year, getUser());
				} else if ("chart1-outcome1".equals(chartName)) {
					//总支出-各类支出占比
					map = cockpitMng.getData3(depart,year, getUser());
				} else if ("chart1-outcome2".equals(chartName)) {
					//总支出-单位预算支出同比分析
					map = cockpitMng.getData4(depart,year, getUser());
				} else if ("chart1-outcome3".equals(chartName)) {
					//总支出-单位预算支出环比分析
					map = cockpitMng.getData5(depart,year, getUser());
				} else if ("chart1-least1".equals(chartName)) {
					//剩余-各类型指标额度占比
					map = cockpitMng.getData6(depart,year, getUser());
				} else if ("chart1-least2".equals(chartName)) {
					//剩余-各部门指标额度占比
					map = cockpitMng.getData7(depart,year, getUser());
				}
			} else if (chartName.contains("chart2")) {
				//各部门预算执行排名
				if ("chart2-inner1".equals(chartName)) {
					departName=StringUtil.setUTF8(departName);
					map = cockpitMng.getData8(departName,year,getUser());
				}
				
			} else if (chartName.contains("chart3")) {
				//项目执行进度
				if ("chart3-inner1".equals(chartName)) {
					//项目指标支出明细
					//跳转到/outLogData
					//map = cockpitMng.getData9(depart,year);
				}
				
			} else if (chartName.contains("chart4")) {
				//-----------培训会议支出/次数统计
				//  次数:typeNumber;   金额:typeMoney
				if ("chart4-inner1".equals(chartName)) {
					//各类型培训支出统计
					map = cockpitMng.getData10(depart,year,"typeMoney",getUser());
				} else if ("chart4-inner2".equals(chartName)) {
					//各部门培训支出统计
					map = cockpitMng.getData11(depart,year,"typeMoney",getUser());
					
				}else if ("chart4-inner1-num".equals(chartName)) {
					//各类型培训次数统计
					map = cockpitMng.getData10(depart,year,"typeNumber",getUser());
				}else if ("chart4-inner2-num".equals(chartName)) {
					//各部门培训次数统计
					map = cockpitMng.getData11(depart,year,"typeNumber",getUser());
				}
				
				else if ("chart4-inner3".equals(chartName)) {
					//各类型会议支出统计
					map = cockpitMng.getData10_(depart,year,"typeMoney",getUser());
				} else if ("chart4-inner4".equals(chartName)) {
					//各部门会议支出统计
					map = cockpitMng.getData11_(depart,year,"typeMoney",getUser());
					
				}else if ("chart4-inner3-num".equals(chartName)) {
					//各类型会议次数统计
					map = cockpitMng.getData10_(depart,year,"typeNumber",getUser());
				}else if ("chart4-inner4-num".equals(chartName)) {
					//各部门会议次数统计
					map = cockpitMng.getData11_(depart,year,"typeNumber",getUser());
				}
				
			} else if (chartName.contains("chart5")) {
				//各部门差旅费支出情况
				if ("chart5-inner1".equals(chartName)) {
					//各项目差旅费支出情况
					departName=StringUtil.setUTF8(departName);
					map = cockpitMng.getData12(departName,year,getUser());
				}
				
			} else if (chartName.contains("chart6")) {
				//三公经费
				if ("chart6-inner1".equals(chartName)) {
					//各部门经费使用使用情况
					map = cockpitMng.getData13(depart,year,itemName,dates,datee,getUser());
				} else if ("chart6-inner2".equals(chartName)) {
					//各月份经费使用情况
					map = cockpitMng.getData14(depart,year,itemName,getUser());
				}
			}
			return map;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 二级下钻图
	 * @param model
	 * @param chartName 表名
	 * @param departName 部门名称
	 * @param indexType 指标类型
	 * @param pageNo 分页参数-页码
	 * @param pageSize 分页参数-每页数据量
	 * @param
	 * @param
	 * @return 
	 */
	@RequestMapping("/insideData2")
	@ResponseBody
	public Map<?,?> insideData2(ModelMap model, String chartName, String departName, String itemName, String indexType, 
			String year, String departId, Integer pageNo, Integer pageSize){
		
		if (StringUtil.isEmpty(chartName)) return null;
		Map<String,Double> map = new HashMap<>();
		Depart depart = null;
		//设置查询条件：部门 、年度
		if (StringUtil.isEmpty(year)) {
			//没有查询条件，默认本年度
			year = DateUtil.getCurrentYear();
		}
		if (StringUtil.isEmpty(departId)) {
			//没有查询条件，默认本部门
			depart = getUser().getDepart();
		} else {
			depart = departMng.findById(departId);
		}
		//获取数据
		if (chartName.contains("chart1")) {
			//总支出 图一下钻饼图
			if ("chart1-outcome1_outcome1".equals(chartName)) {
				//**部门 各类型报销情况
				Map<String,Map<String,Double>> mapData=new HashMap<>();
				Map<String,Double> map2 = new HashMap<>();
				//当前年份
				map = cockpitMng.getData17(depart,indexType,year,getUser());
				mapData.put("map1", map);
				//上一年
				int y=Integer.valueOf(year)-1;
				map2 = cockpitMng.getData17(depart,indexType,String.valueOf(y),getUser());
				mapData.put("map2", map2);
				return mapData;
			}
		} else if (chartName.contains("chart2")) {
			//各部门预算执行排名
		}
		return map;
	}
	//-------------------------------
		//列表跳转页面
		@RequestMapping("/chartDetail")
		public String openChartDetail(ModelMap model, String typeNum, String type, String dept,String departId,String indexType,
				String itemName,String year,String month, String dates, String datee){
			model.addAttribute("year", year);	//驾驶舱搜索的条件年份
			model.addAttribute("departId",departId);	//驾驶舱搜索的条件部门
			//培训
			if ("train".equals(type)) {
				if(typeNum!=null){
					typeNum=StringUtil.setUTF8(typeNum);
					if(typeNum.equals("一类培训")){
						indexType="1";
					}else if(typeNum.equals("二类培训")){
						indexType="2";
					}else if(typeNum.equals("三类培训")){
						indexType="3";
					}else if(typeNum.equals("四类培训")){
						indexType="4";
					}
					model.addAttribute("indexName", typeNum);		//类型名字
					model.addAttribute("indexType", indexType);		//类型 1、2、3、4
					//培训类型页面
					return "/WEB-INF/view/cockpit-detail/inner3-train1";
				}else{
					dept=StringUtil.setUTF8(dept);
					//培训部门页面
					Depart d=departMng.findByName(dept);
					model.addAttribute("departName",dept);	//部门名称
					model.addAttribute("departNameId", d.getId());	//部门id
					return "/WEB-INF/view/cockpit-detail/inner3-train2";
				}
			//会议
			} else if ("meeting".equals(type)) {
				if(typeNum!=null){
					typeNum=StringUtil.setUTF8(typeNum);
					if(typeNum.equals("一类会议")){
						indexType="1";
					}else if(typeNum.equals("二类会议")){
						indexType="2";
					}else if(typeNum.equals("三类会议")){
						indexType="3";
					}else if(typeNum.equals("四类会议")){
						indexType="4";
					}
					model.addAttribute("indexName", typeNum);		//类型名字
					model.addAttribute("indexType", indexType);		//类型 1、2、3、4
					//会议类型页面
					return "/WEB-INF/view/cockpit-detail/inner3-meeting1";
				}else{
					dept=StringUtil.setUTF8(dept);
					//会议部门页面
					Depart d=departMng.findByName(dept);
					model.addAttribute("departName",dept);	//部门名称
					model.addAttribute("departNameId", d.getId());	//部门id
					return "/WEB-INF/view/cockpit-detail/inner3-meeting2";
				}
			//各项目差旅列表界面
			}else if("inner4".equals(type)){
				dept=StringUtil.setUTF8(dept);
				Depart d=departMng.findByName(dept);
				model.addAttribute("departName",dept);	//部门名称
				model.addAttribute("departNameId", d.getId());	//部门id
				model.addAttribute("month", month);
				return "/WEB-INF/view/cockpit-detail/inner4-1";
			//三公经费列表界面 itemName=因公出国、公务接待、公务用车
			}else if(type.contains("inner5")){
				itemName=StringUtil.setUTF8(itemName);
				model.addAttribute("itemName", itemName);
//				model.addAttribute("departId", departId); //dept  部门id
				
				//按部门
				if("inner5_1".equals(type)){
					dept=StringUtil.setUTF8(dept);
					model.addAttribute("departName",dept);	//部门名称
					Depart d=departMng.findByName(dept);
					model.addAttribute("departNameId", d.getId());	//部门id
					model.addAttribute("dates", dates);
					model.addAttribute("datee", datee);
					return "/WEB-INF/view/cockpit-detail/inner5-1";
				}else{
				//按月份
					model.addAttribute("month",month);
					return "/WEB-INF/view/cockpit-detail/inner5-2";
				}
			}else if("555".equals(type)){
				return "/WEB-INF/view/cockpit-detail/inner5-1";
			}
			return "";
		}
		
		//下钻图数据 详情列表
			@RequestMapping(value = "/chartDataList")
			@ResponseBody
			public JsonPagination openDataList(ModelMap model,String type,String searchName,String searchContent, Depart dept, 
					Integer page, Integer rows,String indexType,String itemName,String year,String month, String dates, String datee,
					String searchGCode, String searchGName){
				//部门
				if(!StringUtil.isEmpty(dept.getId())){
					dept=departMng.findById(dept.getId());
				}
				
				Pagination p = new Pagination();
				//培训列表
				if("train".equals(type)){
					//培训各类型
					if (!StringUtil.isEmpty(indexType)) {	//indexType类型 等于 F_TRAINING_TYPE
						p =reimbAppliMng.getData23(dept, indexType,year,page,rows,searchName,searchContent);
						return getJsonPagination(p, page);
					}
					//培训各部门
					if(dept != null && !StringUtil.isEmpty(dept.getId())) {
						dept=departMng.findById(dept.getId());
						p = reimbAppliMng.getData24(dept,year,page,rows,searchName,searchContent);	
						return getJsonPagination(p, page);
					}
				//会议列表
				}else if ("meeting".equals(type)){
					//会议各类型
					if (!StringUtil.isEmpty(indexType)) {
						p =reimbAppliMng.getData21(dept, indexType,year,page,rows,searchName,searchContent);
						return getJsonPagination(p, page);
					}
//					会议各部门列表
					if(dept != null && !StringUtil.isEmpty(dept.getId())) {
						dept=departMng.findById(dept.getId());
						p = reimbAppliMng.getData22(dept,year,page,rows,searchName,searchContent); 
						return getJsonPagination(p, page);
					}
				//某项目所有差旅记录列表数据
				}else if ("inner4".equals(type)){
					p =applicationBasicInfoMng.getData25(dept,month,page,rows,searchGCode,searchGName);
					return getJsonPagination(p, page);
				//三公经费列表数据
				}else if("inner5".equals(type)){
					//按部门
					if("inner5_1".equals(indexType)){
						//searchContent 报销单编号；searchName 指标名字
						p =reimbAppliMng.getData26(dept,itemName,year,dates,datee,page,rows,searchContent,searchName,getUser()); 
						return getJsonPagination(p, page);
					}
					//按月份 年月（month）
					if("inner5_2".equals(indexType)){
						dept = departMng.findById(dept.getId());
						//searchContent 报销单编号；searchName 指标名字
						p =reimbAppliMng.getData27(dept,itemName,month,page,rows,searchContent,searchName,getUser());  
						return getJsonPagination(p, page);
					}
				}
				return getJsonPagination(p, page);
			}
		//-------------------------------
	//-------------指标管理信息数据列表界面-----------------
	//打开 指标管理信息    queryYear：总支出 指标支出明细  图一 下钻列表 返回时用到
		@RequestMapping("/indexDataJsp")
		public String indexDataJsp(ModelMap model,String typeStr, String year,String queryYear, String departId,
				String departName, String indexName,String indexType){

			model.addAttribute("year", year);
			model.addAttribute("departId", departId);
			//总预算指标管理信息
			if("budget".equals(typeStr)){
				if(indexName!=null){
					indexName=StringUtil.setUTF8(indexName);
					int typeNum=0;
					if (indexName.equals("基本支出")) {
						typeNum = 0;
					} else if (indexName.equals("项目支出")) {
						typeNum = 1;
					}
					model.addAttribute("indexName",indexName); //指标名称 界面显示用 ：基本支出/项目支出
					model.addAttribute("typeNum",typeNum); //指标类型 查询用
					
					return "/WEB-INF/view/cockpit-detail/total-budget1";
				}
				departName=StringUtil.setUTF8(departName);
				Depart d=departMng.findByName(departName);
				//departNameId 使用部门查看数据时使用 
				model.addAttribute("departNameId", d.getId());
				model.addAttribute("departName", departName);
				//model.addAttribute("indexType",indexType); //指标类型
				return "/WEB-INF/view/cockpit-detail/total-budget2";
			//总支出 指标支出明细
			}else if("detail".equals(typeStr)){
				if(indexType!=null){
					//费用类型     1、收入	2、还款	3、直接报销	4、申请报销	5、借款	6、采购支付	7、合同报销
					model.addAttribute("indexType",indexType); 
				}
				model.addAttribute("queryYear", queryYear);
				return "/WEB-INF/view/cockpit-detail/total-outcome1";
			//总剩余指标管理信息
			}else if("residue".equals(typeStr)){
				if(indexName!=null){
					indexName=StringUtil.setUTF8(indexName);
					int typeNum=0;
					if (indexName.equals("基本支出")) {
						typeNum = 0;
					} else if (indexName.equals("项目支出")) {
						typeNum = 1;
					}
					model.addAttribute("indexName",indexName); //指标名称 界面显示用 ：基本支出/项目支出
					model.addAttribute("typeNum",typeNum); //指标类型 查询用
					return "/WEB-INF/view/cockpit-detail/total-least1";
					}
				departName=StringUtil.setUTF8(departName);
				Depart d=departMng.findByName(departName);
				//departNameId 使用部门查看数据时使用 
				model.addAttribute("departNameId", d.getId());
				model.addAttribute("departName", departName);
				model.addAttribute("indexType",indexType); //指标类型
				return "/WEB-INF/view/cockpit-detail/total-least2";
			}
			return "";
		}
		
		/**
		 * 下钻数据列表
		 * @param model
		 * @param tim 预算指标
		 * @param depart 部门
		 * @param typeStr 类型 ：总预算（budget）、总支出 detail、总剩余（residue）
		 * @return 
		 */
		//指标管理信息数据列表
		@RequestMapping("/indexDataList")
		@ResponseBody
		public JsonPagination indexDataList(ModelMap model, Depart depart, String indexName,String indexType, String year,String typeStr,
				String searchIndexName, String searchDeptName, String searchIndexCode,String type, Integer page, Integer rows){
			if(!StringUtil.isEmpty(depart.getId()) || !StringUtil.isEmpty(depart.getName())){
				if(!StringUtil.isEmpty(depart.getName())){
					depart = departMng.findByName(depart.getName());
				}else{
					depart = departMng.findById(depart.getId());
				}
			}
			
			Pagination p=new Pagination();
			//总预算指标管理信息
			if("budget".equals(typeStr)){
				//各指标信息
				if(indexName!=null){
					depart = departMng.findById(depart.getId());
					p = transmitMng.getData15(depart, year,indexName,  page, rows,searchIndexName,searchDeptName);
					return getJsonPagination(p, page);
				//各部门指标信息
				}else if(depart.getName()!=null){
					p = transmitMng.indexMgrData2(depart, indexType, year, page, rows,searchIndexName,searchIndexCode);
					return getJsonPagination(p, page);
				}
			//总支出 指标支出明细
			}else if("detail".equals(typeStr)){
				depart = departMng.findById(depart.getId());
				//indexType:费用类型; type:指标类型
				p=indexDetailMng.indexDetailData1(depart, year, indexType,type, page, rows,searchIndexName, searchDeptName);
				return getJsonPagination(p, page);
			//总剩余指标管理信息
			}else if("residue".equals(typeStr)){
				//各指标信息
				if(indexName!=null){
					depart = departMng.findById(depart.getId());
					p = transmitMng.getData15(depart, year,indexName,  page, rows,searchIndexName,searchDeptName);
					return getJsonPagination(p, page);
				//各部门指标信息
				}else if(depart.getName()!=null){
					p = transmitMng.indexMgrData2(depart, indexType, year, page, rows,searchIndexName,searchIndexCode);
					return getJsonPagination(p, page);
				}
			}
			return getJsonPagination(p, page);
		}
		//总预算 指标详情信息 界面(废弃)
		@RequestMapping(value = "/tBudgetDetail")
		@ResponseBody
		public List<TIndexDetail> tBudgetDetail(String code) {
			List<TIndexDetail> li = indexDetailMng.findByIndexCode(code);
			for (TIndexDetail list:li) {
				User user = userMng.findById(list.getUserId());
				list.setUsername(user.getName());
			}
			return li;
		}
		//指标历史记录 界面
		@RequestMapping(value = "/tIndexHistory")
		public String tBudgetHistory(ModelMap model, String code,String year,String departName,String departNameId,String departId){
			model.addAttribute("year", year);
			TBudgetIndexMgr bean = budgetIndexMgrMng.findByIndexCode(code);
			model.addAttribute("bean", bean);
			model.addAttribute("code", code);
			//departNameId 使用部门查看数据时使用 
			if(!StringUtil.isEmpty(departName)){
				departName=StringUtil.setUTF8(departName);
				Depart d=departMng.findByName(departName);
				model.addAttribute("departNameId", d.getId());
			}else if(!StringUtil.isEmpty(departNameId)){
				model.addAttribute("departNameId", departNameId);
			}else{
				model.addAttribute("departNameId", bean.getDeptCode());
			}
			model.addAttribute("departId", departId);
			//指标详情信息和历史记录查询界面
			return "/WEB-INF/view/cockpit-detail/total-budget1-1";
		}
		

		//指标详情信息>支出明细>搜素查询
		@RequestMapping("/searchZCList")
		@ResponseBody
		public JsonPagination searchZCList(ModelMap model,String departId,String departName,String code,
				String moneyStart,String moneyEnd,String fType,String userName, Integer page, Integer rows){
			Depart depart=null;
			if(!StringUtil.isEmpty(departId) || !StringUtil.isEmpty(departName)){
				if(!StringUtil.isEmpty(departName)){
					depart = departMng.findByName(departName);
				}else{
					depart = departMng.findById(departId);
				}
			}
			Pagination p = new Pagination();
			p=cockpitMng.getData28(depart,code, moneyStart, moneyEnd, fType, userName, page, rows);
			return getJsonPagination(p, page);
		}
		
		//根据申请单号获取报销单 id 查看详情
		@RequestMapping("/obtainId")
		@ResponseBody
		public String obtainId(String code){
			
			ReimbAppliBasicInfo r=reimbAppliMng.findByProperty("gCode", code).get(0);
			String ss=r.getrId().toString();
			return ss;
		}
		//指标详情信息>支出明细>冻结金额查看
		@RequestMapping("/frozenAList")
		@ResponseBody
		public JsonPagination frozenAList(ModelMap model,String departId,String departName,String code,
				String moneyStart,String moneyEnd,String fType,String userName, Integer page, Integer rows){
			Pagination p = new Pagination();
			p=cockpitMng.getFrozenAList(getUser(),code, page, rows);
			return getJsonPagination(p, page);
		}
}
