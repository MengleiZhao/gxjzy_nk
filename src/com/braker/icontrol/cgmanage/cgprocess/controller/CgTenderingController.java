package com.braker.icontrol.cgmanage.cgprocess.controller;



import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.braker.common.ftp.FileUpload;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.Result;
import com.braker.common.page.SimplePage;
import com.braker.common.util.FileUpLoadUtil;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.CheterMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Proposer;
import com.braker.core.model.SystemCenterAttac;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.project.entity.TProExpendDetail;
import com.braker.icontrol.budget.project.manager.TProExpendDetailMng;
import com.braker.icontrol.cgmanage.cgapply.manager.CgApplysqMng;
import com.braker.icontrol.cgmanage.cgconfplan.mananger.CgConPlanListMng;
import com.braker.icontrol.cgmanage.cgconfplan.model.ProcurementPlanList;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgBidWinRefMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgProcessMng;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgSelMng;
import com.braker.icontrol.cgmanage.cgprocess.model.BidRegist;
import com.braker.icontrol.cgmanage.cgprocess.model.BidWinningRef;
import com.braker.icontrol.cgmanage.cgprocess.model.BiddingRegist;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;
import com.braker.icontrol.purchase.apply.manager.PurchaseApplyMng;
import com.braker.icontrol.purchase.apply.model.PurchaseApplyBasic;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;
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
@RequestMapping(value = "/cgprocess")
public class CgTenderingController extends BaseController{
	
	@Autowired
	private CgProcessMng processMng;

	@Autowired
	private CheterMng cheterMng;
	
	@Autowired
	private CgApplysqMng cgsqMng;
	
	@Autowired
	private CgSelMng cgselMng;
	
	@Autowired
	private AttachmentMng attachmentMng;
	
	@Autowired
	private CgBidWinRefMng cgbwrefMng;
	
	@Autowired
	private PurchaseApplyMng purchaseApplyMng;
	
	@Autowired
	private CgConPlanListMng cgConPlanListMng;
	
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	
	@Autowired
	private TProExpendDetailMng detailMng;
	
	@Autowired
	private BudgetIndexMgrMng indexMng;
	/**
	 * 跳转到列表页面	采购过程登记界面
	 * @author 焦广兴
	 * @createtime 2019-05-28
	 * @updatetime 2019-05-28
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/purchase_manage/process/course_list";
	}
	
	
	
	@RequestMapping(value = "/cgTenderingPage")
	@ResponseBody
	public JsonPagination cgTenderingPage(PurchaseApplyBasic bean, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = cgsqMng.cgTenderingPageList(bean, page, rows, getUser());
		List<PurchaseApplyBasic> li = (List<PurchaseApplyBasic>) p.getList();
		for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNumber((x+1)+(page-1)*rows);	
		}
		return getJsonPagination(p, page);
	}
	
	
	
	/**
	 * 
	 * @Description 采购过程登记	新增登记
	 * @author 汪耀
	 * @param model
	 * @param id
	 * @return
	 * @return String
	 * @throws
	 * @date 2020年1月9日
	 */
	@RequestMapping(value = "/add")
	public String add(ModelMap model, String id){
		//操作类型
		model.addAttribute("operType", "add");
		
		//查询基本信息
		PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		
		Integer detailId = bean.getProDetailId();
		Integer indexId = bean.getIndexId();
		if (detailId != null && indexId != null) {
			TProExpendDetail detail = detailMng.findById(detailId);
			TBudgetIndexMgr index = indexMng.findById(indexId);
			if (detail != null && index != null) {
				//指标名称
				bean.setIndexName(index.getIndexName()+"【 "+detail.getSubName()+" 】");
				//批复金额
				bean.setPfAmount(detail.getOutAmount());		
				//批复时间
				if (index.getAppDate() != null) {
					bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
				}
				//使用部门
				bean.setPfDepartName(index.getDeptName());			
				//可用余额
				bean.setSyAmount(detail.getSyAmount());			
			}
		}else if(indexId != null){
			TBudgetIndexMgr index = indexMng.findById(indexId);
			//指标名称
			bean.setIndexName(index.getIndexName()+"【 "+index.getIndexCode()+" 】");
			//批复金额
			bean.setPfAmount(index.getPfAmount());		
			//批复时间
			if (index.getAppDate() != null) {
				bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
			}
			//使用部门
			bean.setPfDepartName(index.getDeptName());			
			//可用余额
			bean.setSyAmount(index.getSyAmount());			
		}
		
		//查询附件信息
		List<Attachment> attac = attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		
		//设置中标日期
		//model.addAttribute("fbidTime", new Date());
		
		//查询工作流
		if(bean.getfItems().equals("A")|| "B".equals(bean.getfItems())|| "C".equals(bean.getfItems())){
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HWCGSQ", bean.getfDeptId());
			model.addAttribute("fpIdCG", tProcessDefin.getFPId());
		}else{
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GCCGSQ", bean.getfDeptId());
			model.addAttribute("fpIdCG", tProcessDefin.getFPId());
		}
		//对象编码
		model.addAttribute("foCodeCG",bean.getBeanCode());
		return "/WEB-INF/view/purchase_manage/process/bid_add";
	}
	
	/**
	 * 
	 * @Description 采购过程登记保存
	 * @author 汪耀
	 * @param bean
	 * @param bean2
	 * @param addFiles
	 * @param model
	 * @return
	 * @return Result
	 * @throws
	 * @date 2020年1月9日
	 */
	@RequestMapping(value = "/save")
	@ResponseBody	
	public Result save(String fbidStauts, BiddingRegist bean, String form, String files, ModelMap model) {
		try {
			processMng.save(fbidStauts, bean, form, files, getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false, "操作失败，请联系管理员！");
		}
		return getJsonResult(true, "操作成功！");
	}
	
	/**
	 * 
	 * @Description 采购过程登记修改
	 * @author 汪耀
	 * @param id
	 * @param model
	 * @return
	 * @return String
	 * @throws
	 * @date 2020年1月9日
	 */
	@RequestMapping(value = "/edit")
	public String edit(String id,ModelMap model){
		//操作类型
		model.addAttribute("operType", "edit");
		
		//查询采购基本信息
		PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		Integer detailId = bean.getProDetailId();
		Integer indexId = bean.getIndexId();
		if (detailId != null && indexId != null) {
			TProExpendDetail detail = detailMng.findById(detailId);
			TBudgetIndexMgr index = indexMng.findById(indexId);
			if (detail != null && index != null) {
				//指标名称
				bean.setIndexName(index.getIndexName()+"【 "+detail.getSubName()+" 】");
				//批复金额
				bean.setPfAmount(detail.getOutAmount());		
				//批复时间
				if (index.getAppDate() != null) {
					bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
				}
				//使用部门
				bean.setPfDepartName(index.getDeptName());			
				//可用余额
				bean.setSyAmount(detail.getSyAmount());			
			}
		}else if(indexId != null){
			TBudgetIndexMgr index = indexMng.findById(indexId);
			//指标名称
			bean.setIndexName(index.getIndexName()+"【 "+index.getIndexCode()+" 】");
			//批复金额
			bean.setPfAmount(index.getPfAmount());		
			//批复时间
			if (index.getAppDate() != null) {
				bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
			}
			//使用部门
			bean.setPfDepartName(index.getDeptName());			
			//可用余额
			bean.setSyAmount(index.getSyAmount());			
		}
		//查询采购单附件信息
		List<Attachment> attac = attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		
		//查询过程登记基本信息
		BiddingRegist br = processMng.findByProperty("fpId", Integer.valueOf(id)).get(0);
		model.addAttribute("br", br);
		//查询登记过程附件信息
		List<Attachment> brAttac = attachmentMng.list(br);
		model.addAttribute("brAttac", brAttac);
		
		//查询供应商信息  id是中标表里的主键  是中标供应商映射表的字段
		List<WinningBidder> bwlist = cgselMng.findByWid(br.getFpId());
		model.addAttribute("fwbean", bwlist);
		model.addAttribute("fwbeanNum", bwlist.size());
		//查询工作流
		if(bean.getfItems().equals("A")|| "B".equals(bean.getfItems())|| "C".equals(bean.getfItems())){
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HWCGSQ", bean.getfDeptId());
			model.addAttribute("fpIdCG", tProcessDefin.getFPId());
		}else{
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GCCGSQ", bean.getfDeptId());
			model.addAttribute("fpIdCG", tProcessDefin.getFPId());
		}
		//对象编码
		model.addAttribute("foCodeCG",bean.getBeanCode());
		return "/WEB-INF/view/purchase_manage/process/bid_edit";
	}
	
	/**
	 * 
	 * @Description 采购过程登记查看
	 * @author 汪耀
	 * @param id
	 * @param model
	 * @return
	 * @return String
	 * @throws
	 * @date 2020年1月9日
	 */
	@RequestMapping(value ="/detail")
	public String detail(String id,ModelMap model){
		//操作类型
		model.addAttribute("operType", "detail");
		
		//查询采购基本信息
		PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		Integer detailId = bean.getProDetailId();
		Integer indexId = bean.getIndexId();
		if (detailId != null && indexId != null) {
			TProExpendDetail detail = detailMng.findById(detailId);
			TBudgetIndexMgr index = indexMng.findById(indexId);
			if (detail != null && index != null) {
				//指标名称
				bean.setIndexName(index.getIndexName()+"【 "+detail.getSubName()+" 】");
				//批复金额
				bean.setPfAmount(detail.getOutAmount());		
				//批复时间
				if (index.getAppDate() != null) {
					bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
				}
				//使用部门
				bean.setPfDepartName(index.getDeptName());			
				//可用余额
				bean.setSyAmount(detail.getSyAmount());			
			}
		}else if(indexId != null){
			TBudgetIndexMgr index = indexMng.findById(indexId);
			//指标名称
			bean.setIndexName(index.getIndexName()+"【 "+index.getIndexCode()+" 】");
			//批复金额
			bean.setPfAmount(index.getPfAmount());		
			//批复时间
			if (index.getAppDate() != null) {
				bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
			}
			//使用部门
			bean.setPfDepartName(index.getDeptName());			
			//可用余额
			bean.setSyAmount(index.getSyAmount());			
		}
		//查询采购单附件信息
		List<Attachment> attac = attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		//查询工作流
		if(bean.getfItems().equals("A")|| "B".equals(bean.getfItems())|| "C".equals(bean.getfItems())){
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HWCGSQ", bean.getfDeptId());
			model.addAttribute("fpIdCG", tProcessDefin.getFPId());
		}else{
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GCCGSQ", bean.getfDeptId());
			model.addAttribute("fpIdCG", tProcessDefin.getFPId());
		}
		//对象编码
		model.addAttribute("foCodeCG",bean.getBeanCode());
		
		//查询过程登记基本信息
		BiddingRegist br = processMng.findByProperty("fpId", Integer.valueOf(id)).get(0);
		model.addAttribute("br", br);
		//查询登记过程附件信息
		List<Attachment> brAttac = attachmentMng.list(br);
		model.addAttribute("brAttac", brAttac);
		
		//查询供应商信息  id是中标表里的主键  是中标供应商映射表的字段
		List<WinningBidder> bwlist = cgselMng.findByWid(br.getFpId());
		model.addAttribute("fwbean", bwlist);
		return "/WEB-INF/view/purchase_manage/process/bid_detail";
	}
	
	/**
	 * 弹出供应商信息页面
	 * @author 焦广兴
	 * @createtime 2019-05—30
	 * @updatetime 2019-05—30
	 */
	@RequestMapping(value = "/selinfo")
	public String sel(ModelMap model) {
		return "/WEB-INF/view/purchase_manage/process/selinfo_list";
	}
	
	/*
	 * 分页数据获得
	 * @author 冉德茂
	 * @createtime 2018-07-23
	 * @updatetime 2018-07-23
	 */
	@RequestMapping(value = "/cgprocessPage")
	@ResponseBody
	public JsonPagination loanPage(BiddingRegist bean,String timea,String timeb, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = processMng.pageList(bean,timea,timeb, page, rows);;
    	List<BiddingRegist> li = (List<BiddingRegist>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	/*
	 * 中标页面选择  开标日期小于当前系统时间的数据进行中标登记
	 * @author 冉德茂
	 * @createtime 2018-10-17
	 * @updatetime 2018-10-17
	 */
	@RequestMapping(value = "/pickZBPage")
	@ResponseBody
	public List<BiddingRegist> getlistjson(BiddingRegist bean) {
		List<BiddingRegist> prolist = processMng.pickZBPage(bean);
		for(int i=0;i<prolist.size();i++){
			prolist.get(i).setNum(i+1);
		}
		return prolist;
	}
	
	/*
	 * 跳转采购批次列表
	 * @author 冉德茂
	 * @createtime 2018-07—23
	 * @updatetime 2018-07—23
	 */
	@RequestMapping(value = "/baseinfo")
	public String check(ModelMap model) {
				
		return "/WEB-INF/view/purchase_manage/process/basicinfo_list";
	}

	/*
	 * 获取所有的已审批的基本信息进行招标
	 * @author 冉德茂
	 * @createtime 2018-07-23
	 * @updatetime 2018-07-23
	 */
	@RequestMapping(value = "/basicInfoPage")
	@ResponseBody
	public List<PurchaseApplyBasic> loanPage(PurchaseApplyBasic bean){
		List<PurchaseApplyBasic> li= processMng.pageBasicInfoList(bean);;
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNumber(x+1);	
		}
    	return li;
	}
	
	/*
	 * 附件上传AJAX
	 * @author 冉德茂
	 * @createtime 2018-07-24
	 * @updatetime 2018-07-24
	 */
	@RequestMapping(value = "/tenderFile")
	@ResponseBody
	public boolean applyFile(String fileurl){
		try {
			fileurl = java.net.URLDecoder.decode(fileurl,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//获取文件名
		String[] names = fileurl.split("\\\\");
		String name = names[names.length-1];
		System.out.println(name);
		//保存附件文件
		FileUpload fu = new FileUpload();
		String url = fu.getFtpConfig("url");
		int port = Integer.parseInt(fu.getFtpConfig("port"));
		String username = fu.getFtpConfig("username");
		String password = fu.getFtpConfig("password");
		boolean flag = false;
		try {
			String path = "CG/CGSQ";
			String filename = name.trim();
			String input = fileurl.trim();
			flag=fu.upLoadFromProduction(url, port,username,password,path,filename,input);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flag;
	}
	
	
	
	/*
	 * 招标登记删除
	 * @author 冉德茂
	 * @createtime 2018-07-24
	 * @updatetime 2018-07-24
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id) {
		try {
			//传回来的id是主键
			processMng.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");	
	}
	
	/*
	 * 制度查找
	 * @author 冉德茂
	 * @createtime 2018-07-26
	 * @updatetime 2018-07-26
	 */
	@RequestMapping(value = "/systemFind")
	@ResponseBody
	public String findSystem(Integer id) {
		SystemCenterAttac sca = cheterMng.getSystemCenterAttac(id);
		String fileUrl=sca.getFileSrc()+"/"+sca.getAttacName();
		
		FileUpload fu = new FileUpload();
		String url = fu.getFtpConfig("url");
		fileUrl="http://"+url+":8080/ftp/ff/"+fileUrl;
		return fileUrl;
	}
	
	/*
	 * 上传附件
	 * 招标登记
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
	
	
	@ResponseBody
	@RequestMapping(value = "/tenderingmingxi")
	public List<ProcurementPlanList> mingxi(Integer id) {
		BiddingRegist br = processMng.findById(id);
		List<ProcurementPlanList> mingxiList = new ArrayList<ProcurementPlanList>();
		if(id != null) {		
			//查询申请明细
			mingxiList = cgConPlanListMng.findbyIdAndTypes("fbId", String.valueOf(br.getFbId()),"2");
		}
		return mingxiList;
	}
	
	
	/**
	 * 
	 * @Description 采购过程登记附件查看
	 * @author 方淳洲
	 * @param id
	 * @param model
	 * @return
	 * @return String
	 * @throws
	 * @date 2021年6月4日
	 */
	@RequestMapping(value ="/fileDetail")
	public String fileDetail(String id,ModelMap model){
		//查询采购基本信息
		PurchaseApplyBasic bean = cgsqMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		Integer detailId = bean.getProDetailId();
		Integer indexId = bean.getIndexId();
		if (detailId != null && indexId != null) {
			TProExpendDetail detail = detailMng.findById(detailId);
			TBudgetIndexMgr index = indexMng.findById(indexId);
			if (detail != null && index != null) {
				//指标名称
				bean.setIndexName(index.getIndexName()+"【 "+detail.getSubName()+" 】");
				//批复金额
				bean.setPfAmount(detail.getOutAmount());		
				//批复时间
				if (index.getAppDate() != null) {
					bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
				}
				//使用部门
				bean.setPfDepartName(index.getDeptName());			
				//可用余额
				bean.setSyAmount(detail.getSyAmount());			
			}
		}else if(indexId != null){
			TBudgetIndexMgr index = indexMng.findById(indexId);
			//指标名称
			bean.setIndexName(index.getIndexName()+"【 "+index.getIndexCode()+" 】");
			//批复金额
			bean.setPfAmount(index.getPfAmount());		
			//批复时间
			if (index.getAppDate() != null) {
				bean.setPfDate(new SimpleDateFormat("yyyy-MM-dd").format(index.getAppDate()));				
			}
			//使用部门
			bean.setPfDepartName(index.getDeptName());			
			//可用余额
			bean.setSyAmount(index.getSyAmount());			
		}
		//查询采购单附件信息
		List<Attachment> attac = attachmentMng.list(bean);
		model.addAttribute("attac", attac);
		//查询工作流
		if(bean.getfItems().equals("A")|| "B".equals(bean.getfItems())|| "C".equals(bean.getfItems())){
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("HWCGSQ", bean.getfDeptId());
			model.addAttribute("fpIdCG", tProcessDefin.getFPId());
		}else{
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("GCCGSQ", bean.getfDeptId());
			model.addAttribute("fpIdCG", tProcessDefin.getFPId());
		}
		//对象编码
		model.addAttribute("foCodeCG",bean.getBeanCode());
		
		//查询过程登记基本信息
		BiddingRegist br = processMng.findByProperty("fpId", Integer.valueOf(id)).get(0);
		model.addAttribute("br", br);
		//查询登记过程附件信息
		List<Attachment> brAttac = attachmentMng.list(br);
		model.addAttribute("brAttac", brAttac);
		
		//查询供应商信息  id是中标表里的主键  是中标供应商映射表的字段
		List<WinningBidder> bwlist = cgselMng.findByWid(br.getFpId());
		model.addAttribute("fwbean", bwlist);
		return "/WEB-INF/view/purchase_manage/process/bid_file";
	}
	
}