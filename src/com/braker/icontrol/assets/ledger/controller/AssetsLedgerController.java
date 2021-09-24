package com.braker.icontrol.assets.ledger.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.icontrol.assets.handle.model.Handle;
import com.braker.icontrol.assets.storage.manager.AssetBasicInfoMng;
import com.braker.icontrol.assets.storage.manager.AssetFlowMng;
import com.braker.icontrol.assets.storage.manager.AssetStockMng;
import com.braker.icontrol.assets.storage.manager.StorageMng;
import com.braker.icontrol.assets.storage.model.AssetBasicInfo;
import com.braker.icontrol.assets.storage.model.AssetFlow;
import com.braker.icontrol.assets.storage.model.AssetStock;
import com.braker.icontrol.assets.storage.model.Storage;

@Controller
@RequestMapping("/AssetsLedger")
public class AssetsLedgerController extends BaseController{

	@Autowired
	private AssetBasicInfoMng assetBasicInfoMng;
	@Autowired
	private AssetStockMng assetStockMng;
	@Autowired
	private AssetFlowMng assetFlowMng;
	@Autowired
	private StorageMng storageMng;
	
	/**
	 * 跳转到低值易耗品台账页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-20
	 */
	@RequestMapping("/lowList")
	public String list(ModelMap model){
		return "/WEB-INF/view/assets/ledger/ledger_low_list";
	}

	/**
	 * 跳转到固定台账页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-20
	 */
	@RequestMapping("/fixedList")
	public String fixedlist(ModelMap model){
		return "/WEB-INF/view/assets/ledger/ledger_fixed_list";
	}
	
	/**
	 * 跳转到无形资产台账页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-20
	 */
	@RequestMapping("/intangibleList")
	public String intangibllist(ModelMap model){
		return "/WEB-INF/view/assets/ledger/ledger_intangible_list";
	}
	
	/**
	 * 加载到台账页面数据
	 * @param assetBasicInfo
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-20
	 */
	@RequestMapping("/JsonPagination")
	@ResponseBody
	public JsonPagination JsonPagination(AssetBasicInfo assetBasicInfo,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(rows==null){rows=SimplePage.DEF_COUNT;}
		if(page==null){page=1;}
		Pagination p = assetBasicInfoMng.allAss(assetBasicInfo, page, rows);
		List<AssetBasicInfo> li= (List<AssetBasicInfo>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
			li.get(i).setNumber(i+1);
		}
    	p.setList(li);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 跳转到详情页
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-20
	 */
	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable String id,ModelMap model){
		AssetBasicInfo abi = assetBasicInfoMng.findById(Integer.valueOf(id));
		List<AssetStock> stock = assetStockMng.findbycode(abi.getfAssCode());
		abi.setStockNum(stock.get(0).getfRestNum());
		model.addAttribute("bean", abi);
		return "/WEB-INF/view/assets/ledger/ledger_add";
	}
	
	/**
	 * 跳转到该资产的流水界面
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2019-04-17
	 */
	@RequestMapping("/fixedDetail/{id}")
	public String fixedDetail(@PathVariable String id ,ModelMap model){
		AssetBasicInfo abi = assetBasicInfoMng.findById(Integer.valueOf(id));
		model.addAttribute("code", abi.getfAssCode());
		return "/WEB-INF/view/assets/ledger/ledger_fixed_flow";
	}
	
	/**
	 * 固定资产台账
	 * @param assetBasicInfo 查询数据
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2019-04-17
	 */
	@RequestMapping("/fixedFlow")
	@ResponseBody
	public JsonPagination fixedFlow(AssetFlow assetFlow,AssetBasicInfo assetBasicInfo,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(rows==null){rows=SimplePage.DEF_COUNT;}
		if(page==null){page=1;}
		
		Pagination p = assetFlowMng.fixedFlow(assetFlow, assetBasicInfo, getUser(), page, rows);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 根据流水单跳转到相应单据明细
	 * @param id 流水单主键
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2019-04-18
	 */
	@RequestMapping("/flowPage/{id}")
	public String flowPage(@PathVariable String id,ModelMap model,HttpServletRequest request){
		AssetFlow assetFlow = assetFlowMng.findById(Integer.valueOf(id));
		if("ZCLSCZLX-01".equals(assetFlow.getfOptType().getCode())){
			//入库
			return "redirect:/Storage/detail/"+id;
		}else if("ZCLSCZLX-02".equals(assetFlow.getfOptType().getCode())){
			//领用
			return "redirect:/Rece/detail/"+id;
		}else if("ZCLSCZLX-03".equals(assetFlow.getfOptType().getCode())){
			//调拨
			return "redirect:/Alloca/detail/"+id;
		}else if("ZCLSCZLX-04".equals(assetFlow.getfOptType().getCode())){
			//处置
			return "redirect:/Handle/detail/"+id;
		}else if("ZCLSCZLX-05".equals(assetFlow.getfOptType().getCode())){
			//维修
			
		}
		return null;
	}
	
	
}
