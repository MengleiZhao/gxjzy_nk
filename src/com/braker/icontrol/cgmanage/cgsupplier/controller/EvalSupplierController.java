package com.braker.icontrol.cgmanage.cgsupplier.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgBidMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgProcessMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgSelMng;
import com.braker.icontrol.cgmanage.cgprocess.model.BidRegist;
import com.braker.icontrol.cgmanage.cgprocess.model.BiddingRegist;
import com.braker.icontrol.cgmanage.cgsupplier.manager.EvalSupplierMng;
import com.braker.icontrol.cgmanage.cgsupplier.manager.SupplierTransactionHisMng;
import com.braker.icontrol.cgmanage.cgsupplier.model.SupplierEvaluaInfo;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;

/**
 * 供应商评价管理的控制层
 * 本模块用于绩效自评的操作
 * @author 冉德茂
 * @createtime 2018-09-11
 * @updatetime 2018-09-11
 */
@Controller               
@RequestMapping(value = "/evalsupplier")
public class EvalSupplierController extends BaseController{

	@Autowired
	private SupplierTransactionHisMng suptrhisMng;
	@Autowired
	private CgApplysqMng cgApplySqMng;
	@Autowired
	private CgBidMng cgbidMng;
	@Autowired
	private CgSelMng cgselMng;
	@Autowired
	private EvalSupplierMng evalSupplierMng;
	@Autowired
	private CgProcessMng processMng;
	
	/*
	 * 跳转到供应商列表页面（展示所有的供应商    状态显示是否黑名单）
	 * @author 冉德茂
	 * @createtime 2018-09-11
	 * @updatetime 2018-09-11
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		
		return "/WEB-INF/view/purchase_manage/cgsupplier/eval_supplier_list";

	}
	/*
	 * 分页数据获得（供应商成交记录信息  用于评价）
	 * @author 冉德茂
	 * @createtime 2018-07-24
	 * @updatetime 2018-07-24
	 */
	@RequestMapping(value = "/evaltrhisPage")
	@ResponseBody
	public JsonPagination checkPage(SupplierEvaluaInfo bean, String wid,String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = evalSupplierMng.pageList(bean,wid, page, rows);
    	List<SupplierEvaluaInfo> li = (List<SupplierEvaluaInfo>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
			PurchaseApplyBasic cgbean = cgApplySqMng.findById(li.get(x).getFpId());
			li.get(x).setCgTime(cgbean.getfReqTime());//获得采购时间
		}
    	return getJsonPagination(p, page);
	}
	/*
	 *供应商评价模块   查看评价的列表信息
	 * @author 冉德茂
	 * @createtime 2018-09-25
	 * @updatetime 2018-09-25
	 */
	@RequestMapping(value = "/seeEvalSupplierList")
	public String seeEvalSupplierList( ModelMap model,String id){
		//id是供应商的主键id  通过评价信息表查询所有的评价信息
		model.addAttribute("fwid", id);
		
		return "/WEB-INF/view/purchase_manage/cgsupplier/eval_supplier_detail_list";
	}
	/*
	 *供应商评价模块   查看评价的详细信息
	 * @author 冉德茂
	 * @createtime 2018-09-25
	 * @updatetime 2018-09-25
	 */
	@RequestMapping(value = "/seeEvalSupplierDetai")
	public String seeEvalSupplierDetai( ModelMap model,String id){
		
		//id是供应商评价信息表的主键id
		SupplierEvaluaInfo evalbean = evalSupplierMng.findById(Integer.valueOf(id));
		
		//查询采购的信息
		PurchaseApplyBasic hisbean = cgApplySqMng.findById(Integer.valueOf(evalbean.getFpId()));
		Date reqTime = hisbean.getfReqTime();//采购的申请时间
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		String dealTime = format.format(reqTime); 
		model.addAttribute("hisbean", hisbean);//采购的额基本信息
		model.addAttribute("dealTime", dealTime);//采购申请时间
		
		model.addAttribute("evalbean", evalbean);
		
		return "/WEB-INF/view/purchase_manage/cgsupplier/see_eval_supplier_detail";
	}
	
	
	/*
	 *验收列表页弹出供应商的评价信息   一次弹出
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */
	@RequestMapping(value = "/trhisdiscussYi")
	public String discusstrhislist( ModelMap model,String id){
		//查询采购的信息
		PurchaseApplyBasic hisbean = cgApplySqMng.findById(Integer.valueOf(id));
		Date reqTime = hisbean.getfReqTime();//采购的申请时间
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		String dealTime = format.format(reqTime); 
		model.addAttribute("hisbean", hisbean);//采购的额基本信息
		model.addAttribute("dealTime", dealTime);//采购申请时间
		//查询过程登记基本信息
		BiddingRegist br=processMng.findByProperty("fpId", Integer.valueOf(id)).get(0);
		//根据过程登记表查询供应商的信息
		WinningBidder fwbean = cgselMng.findById(br.getFwId());
		model.addAttribute("fwbean", fwbean);
		
		return "/WEB-INF/view/purchase_manage/cgsupplier/eval_trhis_discussYi";
		
	}
	/*
	 *跳转到成交记录的评价页面（保存成交记录二次弹出页面）
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */
	@RequestMapping(value = "/trhisdiscussEr")
	public String discusstrhis( ModelMap model,String id){
		//id是采购信息的主键id fpid	
		//查询采购的信息
		PurchaseApplyBasic hisbean = cgApplySqMng.findById(Integer.valueOf(id));
		Date reqTime = hisbean.getfReqTime();//采购的申请时间
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		String dealTime = format.format(reqTime); 
		model.addAttribute("hisbean", hisbean);//采购的额基本信息
		model.addAttribute("dealTime", dealTime);//采购申请时间
		
		//查询过程登记基本信息
		BiddingRegist br=processMng.findByProperty("fpId", Integer.valueOf(id)).get(0);
		//根据过程登记表查询供应商的信息
		WinningBidder fwbean = cgselMng.findById(br.getFwId());
		model.addAttribute("fwbean", fwbean);
			
		return "/WEB-INF/view/purchase_manage/cgsupplier/eval_trhis_discussEr";

	}
	/*
	 * 保存成交记录的评价信息
	 * @author 冉德茂
	 * @createtime 2018-08-20
	 * @updatetime 2018-08-20
	 */
	@RequestMapping(value = "/saveEvalSupplier")
	@ResponseBody
	public Result delete(SupplierEvaluaInfo bean,String fremark,String fpid,String fwid,String fpcode,String fpname,String zonghe,String price,String rate,String quality,String service,String isniming ) {
		try {
			//传回来的id是主键
			evalSupplierMng.save(bean,getUser(),fpid,fwid,fpcode,fpname,zonghe,price,rate,quality,service,fremark,isniming);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"评价失败，请联系管理员！");
		}
		return getJsonResult(true,"评价成功！");	
	}
	
	
	/*
	 *点击查看供应商评价信息
	 * @author 冉德茂
	 * @createtime 2018-09-21
	 * @updatetime 2018-09-21
	 */
	@RequestMapping(value = "/seeEvalSupplier")
	public String seeEvalSupplier( ModelMap model,String id){
		//id是采购信息的主键id fpid	
		//查询采购的信息
		PurchaseApplyBasic hisbean = cgApplySqMng.findById(Integer.valueOf(id));
		Date reqTime = hisbean.getfReqTime();//采购的申请时间
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		String dealTime = format.format(reqTime); 
		model.addAttribute("hisbean", hisbean);//采购的额基本信息
		model.addAttribute("dealTime", dealTime);//采购申请时间
		//查询过程登记基本信息
		BiddingRegist br=processMng.findByProperty("fpId", Integer.valueOf(id)).get(0);
		//根据过程登记表查询供应商的信息
		WinningBidder fwbean = cgselMng.findById(br.getFwId());
		//通过fpid查询供应商的评价信息
		List<SupplierEvaluaInfo> supEvalList=evalSupplierMng.findEvalSupplierbyFpid(Integer.valueOf(id));
		SupplierEvaluaInfo supEval=new SupplierEvaluaInfo();
		if(supEvalList!=null && supEvalList.size()>0){
			supEval=supEvalList.get(0);
		}
		model.addAttribute("supEval", supEval);

		return "/WEB-INF/view/purchase_manage/cgsupplier/eval_trhis_discussYi";
		
	}

}
