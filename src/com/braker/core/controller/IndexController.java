package com.braker.core.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.Pagination;
import com.braker.common.util.DateUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.FunctionMng;
import com.braker.core.manager.IndexShortcutMng;
import com.braker.core.manager.NoticeMng;
import com.braker.core.manager.PersonalWorkMng;
import com.braker.core.manager.PrivateInforMng;
import com.braker.core.manager.SystemCenterMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.DsSelect;
import com.braker.core.model.Function;
import com.braker.core.model.IndexShortcut;
import com.braker.core.model.MyAssetsModel;
import com.braker.core.model.Notice;
import com.braker.core.model.RecentlyApplyVoIn;
import com.braker.core.model.TotalAmountOfBorrowing;
import com.braker.icontrol.expend.apply.manager.RecentlyApplyMng;
import com.braker.icontrol.expend.loan.manager.LoanMng;
import com.braker.icontrol.expend.loan.model.LoanBasicInfo;

/**
 * 系统首页控制层
 * @author 叶崇晖
 * @createtime 2018-08-30
 * @updatetime 2018-08-30
 */
@Controller
@RequestMapping(value = "/index")
public class IndexController extends BaseController {
	@Autowired
	private IndexShortcutMng indexShortcutMng;
	
	@Autowired
	private NoticeMng noticeMng;
	
	@Autowired
	private FunctionMng functionMng;
	
	@Autowired
	private SystemCenterMng systemCenterMng;
	
	@Autowired
	private PersonalWorkMng personalWorkMng;
	
	@Autowired
	private LoanMng loanMng;
	
	@Autowired
	private RecentlyApplyMng recentlyApplyMng;
	
	@Autowired
	private PrivateInforMng privateInforMng;
	
	
	
	
	/*
	 * 跳转到首页
	 * @author 叶崇晖
	 * @createtime 2018-08-30
	 * @updatetime 2018-08-30
	 */
	@RequestMapping(value = "/indexStreetPart")
	public String indexStreetPart(ModelMap model,String loginType) {
		//查询用户的快速入口
		List<IndexShortcut> ksrk = indexShortcutMng.findByUserId(getUser());
		model.addAttribute("ksrk", ksrk);
		
		
		
		//固定资产3D效果数据
		List<MyAssetsModel> assets = recentlyApplyMng.finMyAssets(model,getUser().getId());
		model.addAttribute("assets", assets);
		model.addAttribute("index", "index");
		model.addAttribute("loginType",loginType);
		return "/newMain/index2";
	}
	
	
	/*
	 * 通知公告
	 * @author 赵孟雷
	 * @createtime 2019-05-14
	 * @updatetime 2019-05-14
	 */
	@RequestMapping(value = "/notice")
	@ResponseBody
	public List<Notice> notice(ModelMap model) {
		try {
			List<Notice> notice = noticeMng.getNotices();
			String b  = DateUtil.formatDate(new Date());
			for(int i=0;i<notice.size();i++){
				Notice notice2 = new Notice();
				Date a = notice.get(i).getReleaseTime();
				String c  = DateUtil.formatDate(a);
				Long d = dateDiff( c,b, "yyyy-MM-dd");
				notice2.setDiscrepancyTime(d);
				notice.get(i).setDiscrepancyTime(d);
			}
			return notice;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	/**
	 * 计算创建时间和当前时间天数
	 * @param startTime
	 * @param endTime
	 * @param format
	 * @return
	 */
	public static Long dateDiff(String startTime, String endTime,
            String format) {     
        // 按照传入的格式生成一个simpledateformate对象     
        SimpleDateFormat sd = new SimpleDateFormat(format);     
        long nd = 1000 * 24 * 60 * 60;// 一天的毫秒数     
        long diff;     
        long day = 0;     
        // 获得两个时间的毫秒时间差异     
        try {     
            diff = sd.parse(endTime).getTime() - sd.parse(startTime).getTime();     
            day = diff / nd;// 计算差多少天     
            // 输出结果     
           // System.out.println("时间相差：" + day + "天");     
    
        } catch (ParseException e) {     
            // TODO Auto-generated catch block     
            e.printStackTrace();     
        }
		return day;     
    }
	/*
	 * 制度中心
	 * @author 赵孟雷
	 * @createtime 2019-05-14
	 * @updatetime 2019-05-14
	 */
	@RequestMapping(value = "/cheter")
	@ResponseBody
	public List<CheterInfo> cheter(ModelMap model) {
		try {
			CheterInfo cheterInfo = new CheterInfo();
			Pagination cheter = systemCenterMng.pageList(cheterInfo, 1, 10);
			String b  = DateUtil.formatDate(new Date());

			List<CheterInfo> cheter1 = (List<CheterInfo>) cheter.getList();
			for(int i=0;i<cheter1.size();i++){
				CheterInfo CheterInfo2 = new CheterInfo();
				Date a = cheter1.get(i).getReleseTime();
				String c  = DateUtil.formatDate(a);
				Long d = dateDiff( c,b, "yyyy-MM-dd");
				CheterInfo2.setDiscrepancyTime(d);
				cheter1.get(i).setDiscrepancyTime(d);
			}
			return cheter1;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/*
	 * 首页获取待办事项总数
	 * @author 赵孟雷
	 * @createtime 2019-05-14
	 * @updatetime 2019-05-14
	 */
	@RequestMapping(value = "/taskNums")
	@ResponseBody
	public List<Integer> taskNums(ModelMap model) {
		try {
			List<Integer> taskNums = personalWorkMng.countTaskNum(getUser().getId());
			if(taskNums==null){
				List<Integer> taskNums1 = new ArrayList<Integer>();
				return taskNums1;
			}
			return taskNums;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	/*
	 * 首页获取已办事项总数
	 * @author 赵孟雷
	 * @createtime 2019-05-14
	 * @updatetime 2019-05-14
	 */
	@RequestMapping(value = "/countAlready")
	@ResponseBody
	public List<Integer> countAlready(ModelMap model) {
		try {
			List<Integer> countAlready =  personalWorkMng.countAlready(getUser().getId());
			if(countAlready==null){
				List<Integer> countAlready1 = new ArrayList<Integer>();
				return countAlready1;
			}
			return countAlready;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/*
	 * 首页获取完结事项总数
	 * @author 赵孟雷
	 * @createtime 2019-05-14
	 * @updatetime 2019-05-14
	 */
	@RequestMapping(value = "/countFinish")
	@ResponseBody
	public List<Integer> countFinish(ModelMap model) {
		try {
			List<Integer> countFinish = personalWorkMng.countFinish(getUser().getId());
			if(countFinish==null){
				List<Integer> countFinish1 = new ArrayList<Integer>();
				return countFinish1;
			}
			return countFinish;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/*
	 * 首页获取消息总数
	 * @author 赵孟雷
	 * @createtime 2019-05-14
	 * @updatetime 2019-05-14
	 */
	@RequestMapping(value = "/countInfor")
	@ResponseBody
	public int countInfor(ModelMap model) {
		try {
			int countInfor = privateInforMng.unread(getUser().getId()).size();
			return countInfor;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	/*
	 * 首页获取资产数
	 * @author 赵孟雷
	 * @createtime 2019-05-14
	 * @updatetime 2019-05-14
	 */
	@RequestMapping(value = "/assetsNumber")
	@ResponseBody
	public List<MyAssetsModel> assetsNumber(ModelMap model) {
		try {
			List<MyAssetsModel> assetsNumber = recentlyApplyMng.finMyAssetsNumber(model,getUser().getId());
			return assetsNumber;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/*
	 * 首页借款总额和条数
	 * @author 赵孟雷
	 * @createtime 2019-05-14
	 * @updatetime 2019-05-14
	 */
	@RequestMapping(value = "/amountOfBorrowings")
	@ResponseBody
	public List<TotalAmountOfBorrowing> amountOfBorrowings() {
		String flowStauts  = "9";
		try {
			List<TotalAmountOfBorrowing> amountOfBorrowings = loanMng.homeTotalAmount(flowStauts, getUser().getId());
			return amountOfBorrowings;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	/*
	 * 首页获取借款数据
	 * @author 赵孟雷
	 * @createtime 2019-05-14
	 * @updatetime 2019-05-14
	 */
	@RequestMapping(value = "/basicInfos")
	@ResponseBody
	public List<LoanBasicInfo> basicInfos() {
		String flowStauts  = "9";
		try {
			List<LoanBasicInfo> basicInfos = loanMng.homePageList(flowStauts,getUser().getId());
			return basicInfos;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	/*
	 * 首页获取报销数据
	 * @author 赵孟雷
	 * @createtime 2019-05-14
	 * @updatetime 2019-05-14
	 */
	@RequestMapping(value = "/recentlyApply")
	@ResponseBody
	public List<RecentlyApplyVoIn> recentlyApply(ModelMap model) {
		String dName = "9";
		try {
			List<RecentlyApplyVoIn> list = recentlyApplyMng.getRecentlyApply(model,getUser().getId(),dName);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	/*
	 * 首页获取报销总额和条数
	 * @author 赵孟雷
	 * @createtime 2019-05-14
	 * @updatetime 2019-05-14
	 */
	@RequestMapping(value = "/countAndSumApply")
	@ResponseBody
	public List<RecentlyApplyVoIn> countAndSumApply(ModelMap model) {
		String dName = "9";
		try {
			List<RecentlyApplyVoIn> countAndSumApply = recentlyApplyMng.getCountAndSumApply(model,getUser().getId(),dName);
			return countAndSumApply;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	
	/*
	 * 跳转到快速入口编辑页面
	 * @author 叶崇晖
	 * @createtime 2018-09-13
	 * @updatetime 2018-09-13
	 */
	@RequestMapping(value = "/indexShortcut")
	public String indexShortcut(ModelMap model) {
		//个人所有的权限
		List<Function> userMenus = functionMng.getFunctions(getUser().getId());
		//查询所有最底层的菜单（没有子节点）
		List<Double> functionIdList=functionMng.getFunctionIdList();
		Map<Long,Long> functionIdMap=functionMng.getFunctionIdMap(functionIdList);
		List<DsSelect> datas = new ArrayList<DsSelect>();
		for (int i = 0; i < userMenus.size(); i++) {
			if(functionIdMap.get(userMenus.get(i).getId())!=null) {
				DsSelect dsSelect = new DsSelect(userMenus.get(i).getId().toString(), userMenus.get(i).getName());
				datas.add(dsSelect);//当前登陆者拥有的权限的所有最底层菜单
			}
		}
		
		//查询用户的快速入口
		List<IndexShortcut> ksrk = indexShortcutMng.findByUserId(getUser());
		List<DsSelect> datasR = new ArrayList<DsSelect>();
		for (int i = 0; i < ksrk.size(); i++) {
			DsSelect dsSelect = new DsSelect(ksrk.get(i).getMenuCode(),ksrk.get(i).getMenuName());
			datasR.add(dsSelect);
		}
		List<DsSelect> deldatas = new ArrayList<DsSelect>();
		for (int i = 0; i < datas.size(); i++) {
			for (int j = 0; j < datasR.size(); j++) {
				if(datasR.get(j).getId().equals(datas.get(i).getId())) {
					//datas.remove(i);
					deldatas.add(datas.get(i));
				}
			}
		}
		datas.removeAll(deldatas);
		
		JSONArray json1 = JSONArray.fromObject(datas); 
		model.addAttribute("dsDatas", json1);
		JSONArray json2 = JSONArray.fromObject(datasR); 
		model.addAttribute("dsDatasR", json2);
		return "/newMain/index-shortcut";
	}
	
	/*
	 * 保存快速入口
	 * @author 叶崇晖
	 * @createtime 2018-09-13
	 * @updatetime 2018-09-13
	 */
	@RequestMapping(value = "/saveKsrk")
	@ResponseBody
	public List<IndexShortcut> saveKsrk(String ksrk) {
		List<IndexShortcut> newKsrk = new ArrayList<IndexShortcut>();
		try {
			
				indexShortcutMng.save(ksrk, getUser());
				newKsrk = indexShortcutMng.findByUserId(getUser());
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return newKsrk;
	}
	
	/*
	 * 跳转事项列表
	 */
	@RequestMapping(value = "/taskList")
	public String taskList(ModelMap model, String listType){
		//0、1、2我的工作台		3、4、5首页
		if ("0".equals(listType)) {//待办
			return "/WEB-INF/view/task/task-list0";
		} else if ("1".equals(listType)) {//已办
			return "/WEB-INF/view/task/task-list1";
		} else if ("2".equals(listType)) {//办结
			return "/WEB-INF/view/task/task-list2";
		}else if ("3".equals(listType)) {//待办
			return "/WEB-INF/view/task/task-list01";
		} else if ("4".equals(listType)) {//已办
			return "/WEB-INF/view/task/task-list12";
		} else if ("5".equals(listType)) {//办结
			return "/WEB-INF/view/task/task-list23";
		}
			return "";
	}
	
}
