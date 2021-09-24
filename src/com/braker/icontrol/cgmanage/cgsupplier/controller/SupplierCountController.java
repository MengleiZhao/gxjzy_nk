package com.braker.icontrol.cgmanage.cgsupplier.controller;

import java.io.InputStream;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.Result;
import com.braker.common.web.BaseController;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierMng;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierTransactionHisMng;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierTransactionHis;


/**
 * 供应商统计的控制层
 * 本模块用于绩效自评的操作
 * @author 冉德茂
 * @createtime 2018-09-12
 * @updatetime 2018-09-12
 */
@Controller               
@RequestMapping(value = "/suppliercount")
public class SupplierCountController extends BaseController{
	@Autowired
	private SupplierMng supplierMng;
	@Autowired
	private SupplierTransactionHisMng suptrhisMng;
	
	


	/*
	 * 跳转到供应商列表页面
	 * @author 冉德茂
	 * @createtime 2018-09-11
	 * @updatetime 2018-09-11
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/purchase_manage/cgsupplier/supplier_count_list";
	}
	/*
	 * 点击柱状图折线图追溯供应商该月份的成交信息
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */
	@RequestMapping(value = "/trlist")
	public String trlist( ModelMap model) {
		
		return "/WEB-INF/view/purchase_manage/cgsupplier/supplier_count_trlist";
		
	}
	/*
	 * 柱状图展示供应商每月的成交记录信息
	 * @author 冉德茂
	 * @createtime 2018-09-13
	 * @updatetime 2018-09-13
	 */
	@RequestMapping("/echart")
	public String add(ModelMap model,Integer id){
		//传递供应商的id   用于页面展示统计信息
		model.addAttribute("fwid", id);
		return "/WEB-INF/view/purchase_manage/cgsupplier/supplier_count_echart";
	}
	
	/*
	 * 获取供应商每个月成交额的信息 获取json数据
	 * @author 冉德茂
	 * @createtime 2018-09-13
	 * @updatetime 2018-09-13
	 */
	@RequestMapping(value = "/getCountMoney")
	@ResponseBody
	public Map<String,Object> getCountMoney(String fwid) {
		//fwid是供应商的主键id
		//String categories[]={"1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"};
		//int data[]={100,200,300,400,500,600,700,800,900,1000,1100,1200};
		//查询该供应商每月的成交额
		List<SupplierTransactionHis> trbeanlist = suptrhisMng.getTrbyfwid(Integer.valueOf(fwid));
		int size = trbeanlist.size();
		String[] categories = new String[size];//必须初始化
		int[] data=new int[size];
		for(int i=0;i<trbeanlist.size();i++){
			categories[i] = trbeanlist.get(i).getFtrMonth() + "月";//生成月份
			Double num = Double.valueOf(trbeanlist.get(i).getFtrAmount());
			int b = num.intValue();
			data[i]=Integer.valueOf(b);//每个月的成交总额
		}
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("categories",categories);
		map.put("data",data);
		return map;
	}
	/*
	 * 获取供应商成交量的信息 获取json数据
	 * @author 冉德茂
	 * @createtime 2018-09-13
	 * @updatetime 2018-09-13
	 */
	@RequestMapping(value = "/getCountAmount")
	@ResponseBody
	public Map<String,Object> getCountAmount(String fwid) {
		//fwid是供应商的主键id
		//String categories[]={"1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"};
		//int data[]={100,200,300,400,500,600,700,800,900,1000,1100,1200};
		//查询该供应商每月的成交量
		List<SupplierTransactionHis> trbeanlist = suptrhisMng.getsupamountbyfwid(Integer.valueOf(fwid));
		int size = trbeanlist.size();
		String[] categories = new String[size];//必须初始化
		int[] data=new int[size];
		for(int i=0;i<trbeanlist.size();i++){
			categories[i] = trbeanlist.get(i).getFtrMonth() + "月";//生成月份
			Double num = Double.valueOf(trbeanlist.get(i).getFtrAmount());
			int b = num.intValue();
			data[i]=Integer.valueOf(b);//每个月的成交总额
		}
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("categories",categories);
		map.put("data",data);
		return map;
	}
	/*
	 * 点击柱状图或折线图追溯供应商该月份的成交信息
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */
	@RequestMapping(value = "/getTrHisJson")
	@ResponseBody
	public List<SupplierTransactionHis> getTrHisJson(String fwid,String month) {
		//截取月份  去掉   月
		String mon = month.substring(0, 2);
		//供应商id和当前的月份
		List<SupplierTransactionHis> trsuplist = suptrhisMng.getTrSup(Integer.valueOf(fwid), mon);
		for(int i=0;i<trsuplist.size();i++){//去掉多余的.0
			trsuplist.get(i).setFtrAmount(new BigDecimal(trsuplist.get(i).getFtrAmount()).stripTrailingZeros().toPlainString());
		}
		return trsuplist;
	}	
	
	
	
	/*
	 * 导出数据
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */
/*	@RequestMapping("/getOutput")
	//导出
	public Result getOutPage(String colvalue,String varFields,String fwid,String month,String name,String sort,String order){
		System.out.println(colvalue);
		System.out.println(varFields);
		System.out.println(fwid);
		System.out.println(month);
		System.out.println(sort);
		System.out.println(order);
		
		try {
			Gson gson = new Gson ();
			List<SupplierTransactionHis> value;

			//表头获取
			List<String> volHeader =  gson.fromJson(colvalue, new TypeToken<List<String>>(){}.getType());
			List<List<JGridColumnDto>> listField = gson.fromJson(varFields, new TypeToken<List<List<JGridColumnDto>>>(){}.getType());
			List<JColumnType> listHeader = new ArrayList<JColumnType>();
			for (List<JGridColumnDto> listDto :listField ){
				for(JGridColumnDto dto : listDto){
					if (dto.getField() != null){
						JColumnType jtype = new JColumnType();
						jtype.setColName(dto.getField());
						jtype.setType((dto.getType() != null ?  dto.getType():"STRING"));
						listHeader.add(jtype);
					}
				}
			}
			
			ExportExcelReport excelreport = new ExportExcelReport();
			System.out.println("进入导出方法.");
			if(name.equals("trhis")){//导出成交信息
				value= suptrhisMng.getoutputTrSup(65535, 1, sort, order, Integer.valueOf(fwid), month);
				excelStream = 	excelreport.writeExcelType(listField, listHeader, value);
				String names = "供应商_"+month+"月成交记录表";
				excelFileName =  new String(names.getBytes("utf-8"), "iso8859-1")+""+".xls";
			}
			
			return getJsonResult(true,"操作成功！");
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
	}*/
	
	/*
	 * 导出数据
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */

	
	
}
