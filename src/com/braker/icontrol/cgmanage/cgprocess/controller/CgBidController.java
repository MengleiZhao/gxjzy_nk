package com.braker.icontrol.cgmanage.cgprocess.controller;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.FileUpLoadUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.model.CheterInfo;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgBidMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgBidWinRefMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgSelMng;
import com.braker.icontrol.cgmanage.cgprocess.model.BidRegist;
import com.braker.icontrol.cgmanage.cgprocess.model.BidWinningRef;
import com.braker.icontrol.contract.Formulation.manager.FormulationMng;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.zzww.comm.entity.Attachment;
import com.braker.zzww.comm.manager.AttachmentMng;


/**
 * 采购过程登记的控制层
 * 本模块用于采购过程登记的操作
 * @author 冉德茂
 * @createtime 2018-07-20
 * @updatetime 2018-07-20
 */
@Controller
@RequestMapping(value = "/cgbid")
public class CgBidController extends BaseController{
	
	@Autowired
	private CgBidMng cgbidMng;
	
	@Autowired
	private CheterMng cheterMng;
	
	@Autowired
	private CgSelMng cgselMng;
	
	@Autowired
	private CgBidWinRefMng cgbwrefMng;
	
	@Autowired
	private FormulationMng formulationMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private CgApplysqMng cgsqMng;
	/*
	 * 跳转到列表页面
	 * @author 冉德茂
	 * @createtime 2018-07-20
	 * @updatetime 2018-07-20
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/purchase_manage/process/bid_list";
	}
	

	/*
	 * 中标登记 添加按钮 信息登记
	 * @author 冉德茂
	 * @createtime 2018-07-20
	 * @updatetime 2018-07-20
	 */
	@RequestMapping("/add")
	public String add(ModelMap model,String id){
		PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(id));
		//查询基本信息
		model.addAttribute("bean",bean);
		//查询附件信息
		List<Attachment> attac =attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		//取消右侧流程显示
		model.addAttribute("splc", "1");
		//操作类型
		model.addAttribute("operType", "add");
		//对象编码
		model.addAttribute("foCode",bean.getBeanCode());
		
		return "/WEB-INF/view/purchase_manage/process/bid_add";
	}
	
	
	/*
	 * 分页数据获得
	 * @author 冉德茂
	 * @createtime 2018-07-24
	 * @updatetime 2018-07-24
	 */
	@RequestMapping(value = "/cgbidPage")
	@ResponseBody
	public JsonPagination loanPage(BidRegist bean, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = cgbidMng.pageList(bean, page, rows);;
    	List<BidRegist> li = (List<BidRegist>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	
	
	/*
	 * 弹出招标信息页面
	 * @author 冉德茂
	 * @createtime 2018-07—25
	 * @updatetime 2018-07—25
	 */
	@RequestMapping(value = "/zhaobiaoinfo")
	public String check(ModelMap model) {
		return "/WEB-INF/view/purchase_manage/process/zhaobiaoinfo_list";
	}
	
	/*
	 * 弹出供应商信息页面
	 * @author 冉德茂
	 * @createtime 2018-07—25
	 * @updatetime 2018-07—25
	 */
	@RequestMapping(value = "/selinfo")
	public String sel(ModelMap model) {
		return "/WEB-INF/view/purchase_manage/process/selinfo_list";
	}

	
	/*
	 * 中标 查看详情
	 * @author 冉德茂
	 * @createtime 2018-07-26
	 * @updatetime 2018-07-26
	 */
	@RequestMapping(value ="/detail")
	public String detail(String id,ModelMap model){
		PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(id));
		//查询采购基本信息
		model.addAttribute("bean",bean);
		//查询过程登记基本信息
		BidRegist br=cgbidMng.findByProperty("fpId", Integer.valueOf(id)).get(0);
		model.addAttribute("br",br);
		//合同基本信息
		/*model.addAttribute("contractBasicInfo",formulationMng.findAttacByFPurchNo(bean.getFproNum()));*/
		//查询登记过程附件信息
		List<Attachment> attac = attachmentMng.list(br);
		model.addAttribute("attac", attac);
		//查询采购单附件信息
		List<Attachment> pattac = attachmentMng.list(bean);
		model.addAttribute("pattac", pattac);
		/*//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("中标登记");
		model.addAttribute("cheterInfo", cheterInfo);*/
		//查询供应商信息  id是中标表里的主键  是中标供应商映射表的字段
		List<BidWinningRef> bwlist=cgbwrefMng.findByBidid(br.getFbIdId());
		Integer wid=bwlist.get(0).getFwId();
		model.addAttribute("fwbean",cgselMng.findById(wid));
		//取消右侧流程显示
		model.addAttribute("splc", "1");
		return "/WEB-INF/view/purchase_manage/process/bid_detail";
	}
	
	
	/*
	 * 修改中标信息
	 * @author 冉德茂
	 * @createtime 2018-07-30
	 * @updatetime 2018-07-30
	 */
	@RequestMapping(value = "/edit")
	public String edit(String id, ModelMap model) {
		//操作类型
		model.addAttribute("operType", "add");
		// 查询基本信息
		BidRegist bean = cgbidMng.findById(Integer.valueOf(id)); 
		model.addAttribute("br", bean);
		//合同基本信息
		model.addAttribute("contractBasicInfo",formulationMng.findAttacByFPurchNo(bean.getFproNum()));
		// 查询附件
		List<Attachment> attaList = attachmentMng.list(bean);
		model.addAttribute("attac", attaList);
		// 查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("中标登记");
		model.addAttribute("cheterInfo", cheterInfo);
		// 查询供应商信息 id是中标表里的主键 是中标供应商映射表的字段
		List<BidWinningRef> bwlist = cgbwrefMng.findByBidid(Integer.valueOf(id));
		Integer wid = bwlist.get(0).getFwId();
		model.addAttribute("fwbean", cgselMng.findById(wid));

		model.addAttribute("detail", "不可操作");//查看修改     detail设置非空 不能进行编辑操作  
		//取消右侧流程显示
		model.addAttribute("splc", "1");
		
		return "/WEB-INF/view/purchase_manage/process/bid_add";

	}
	
	
	/*
	 * 跳转到专家选择页面
	 * @author 冉德茂
	 * @createtime 2018-07-26
	 * @updatetime 2018-07-26
	 */
	@RequestMapping(value = "/index")
	public String index(ModelMap model) {
		return "/WEB-INF/view/purchase_manage/process/expert_index";
	}
	
	/* 中标信息保存
	 * 
	 * @author 冉德茂
	 * @createtime 2018-07-23
	 * @updatetime 2018-07-23
	 */
	
	@RequestMapping(value = "/save")
	@ResponseBody	
	public Result save(BidRegist bean, String addFiles,ModelMap model,String fpId,String fwId,String fwName,String eids,String fwCode) {
		//pid 招标外键   wid映射供应商    eids映射评标专家		
		try {
			cgbidMng.save(bean, addFiles,getUser(),fwName,fpId,fwId,null,fwCode);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
		
	}
	
	
	/*
	 * 删除中标登记
	 * @author 冉德茂
	 * @createtime 2018-07-30
	 * @updatetime 2018-07-30
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id) {
		try {
			//传回来的id是主键
			cgbidMng.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");	
	}


	/*
	 * 上传附件
	 * 中标登记
	 * @author 张迅
	 * @createtime 2018-11-21
	 * @updatetime 2018-11-21
	 */
	@RequestMapping("/uploadAtt")
	@ResponseBody
	public Result uploadAtt(
			ModelMap model,
			String serviceType,
			@RequestParam(value = "attFiles", required = false) MultipartFile[] attFiles) {

		try {
			// 保存附件到服务器
			String ids = attachmentMng.uploadAjax(attFiles, serviceType,
					FileUpLoadUtil.getCGGCSavePath(), getUser());
			if (ids != null) {
				return getJsonResult(true, ids);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, e.getMessage());
		}
		return null;
	}
}
