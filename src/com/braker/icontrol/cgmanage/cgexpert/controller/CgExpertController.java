package com.braker.icontrol.cgmanage.cgexpert.controller;

import java.util.ArrayList;
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
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.manager.DepartMng;
import com.braker.core.manager.UserMng;
import com.braker.core.model.Proposer;
import com.braker.icontrol.cgmanage.cgexpert.manager.CgExpertMng;
import com.braker.icontrol.cgmanage.cgexpert.manager.ExpertBlackMng;
import com.braker.icontrol.cgmanage.cgexpert.manager.ExpertCheckMng;
import com.braker.icontrol.cgmanage.cgexpert.manager.ExpertExtractMng;
import com.braker.icontrol.cgmanage.cgexpert.manager.ExpertOutMng;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertBlackInfo;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertInfo;
import com.braker.icontrol.cgmanage.cgexpert.model.ExpertOutInfo;
import com.braker.icontrol.cgmanage.cgexpert.model.ExtractRecordInfo;
import com.braker.icontrol.cgmanage.cgprocess.model.BidExpertRef;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeLinkMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;

/**
 * 评标专家的控制层
 * 本模块用于采购过程登记的操作
 * @author 冉德茂
 * @createtime 2018-07-27
 * @updatetime 2018-07-27
 */
@Controller
@RequestMapping(value = "/expertgl")
public class CgExpertController extends BaseController{
	@Autowired
	private CgExpertMng cgexpertMng;
	@Autowired
	private ExpertCheckMng expertCheckMng;
	@Autowired
	private ExpertBlackMng expertBlackMng;
	@Autowired
	private ExpertOutMng expertOutMng;
	@Autowired
	private DepartMng departMng;
	@Autowired
	private TNodeLinkMng tNodeLinkMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	@Autowired
	private ExpertExtractMng expertExtractMng;
	/*
	 * 分页数据获得
	 * @author 冉德茂
	 * @createtime 2018-07-24
	 * @updatetime 2018-07-24
	 */
	@RequestMapping(value = "/expertPageData")
	@ResponseBody
	public JsonPagination loanPage(ExpertInfo bean, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Pagination p = cgexpertMng.pageList(bean, page, rows);;
    	List<ExpertInfo> li = (List<ExpertInfo>) p.getList();
    	for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
    	return getJsonPagination(p, page);
	}
	
	/**
	 * 专家库申请 弹出页面
	 * @author 焦广兴
	 * @createtime 2019-06-25
	 * @updatetime 2019-06-25
	 */
	@RequestMapping("/expertApply")
	public String expertApply(ModelMap model,String checkType){
		model.addAttribute("checkType", checkType);
		return "/WEB-INF/view/purchase_manage/cgexpert/expert_apply_list";
	}
	
	/*
	 * 新增，修改，查看 ，页面显示已选择的专家列表
	 * @author 冉德茂
	 * @createtime 2018-07-27
	 * @updatetime 2018-07-25
	 */
	@RequestMapping(value = "/findIndex")
	@ResponseBody
	public JsonPagination findIndex(ModelMap model,String data,String fbIdId){
		Pagination p = new Pagination();
		String[] datas = new String[]{};
		
		if (fbIdId==null && data!= null) {//新增 页面  通过前台传过来的id查询评标专家信息
			//System.out.println("新增页面");
			List<ExpertInfo> list = new ArrayList<ExpertInfo>();
			if (!StringUtil.isEmpty(data)) {
				datas = data.split(",");
				for (int i = 0; i < datas.length; i++) {
					ExpertInfo bean = cgexpertMng.findById(Integer.valueOf(datas[i]));					
					list.add(bean);
				}
			}
			p.setList(list);		
		}else if(fbIdId!=null && data==null){//查看  页面 通过中标ID查询 评标专家信息
			//System.out.println("查看页面");
			List<BidExpertRef> bwlist=cgexpertMng.findByBidid(Integer.valueOf(fbIdId));
			List<ExpertInfo> list = new ArrayList<ExpertInfo>();
			for(int i=0;i<bwlist.size();i++){
				Integer eid=bwlist.get(i).getFeId();
				ExpertInfo bean = cgexpertMng.findById(Integer.valueOf(eid));					
				list.add(bean);
			}
			p.setList(list);
		}else if(fbIdId!=null && data!= null){//修改页面  通过前台传过来的id查询评标专家信息
			//System.out.println("修改页面");
			List<ExpertInfo> list = new ArrayList<ExpertInfo>();
			if (!StringUtil.isEmpty(data)) {
				datas = data.split(",");
				for (int i = 0; i < datas.length; i++) {
					ExpertInfo bean = cgexpertMng.findById(Integer.valueOf(datas[i]));					
					list.add(bean);
				}
			}
			p.setList(list);
		}
		return getJsonPagination(p,0);	
	}
	
	/*
	 * 跳转到专家列表页面
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	@RequestMapping(value = "/list")
	public String list( ModelMap model) {
		return "/WEB-INF/view/purchase_manage/cgexpert/expert_list";

	}
	/*
	 * 新增专家
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	@RequestMapping("/add")
	public String add(ModelMap model){
		model.addAttribute("operType", "add");
		//生成专家编号
		ExpertInfo ebean = new ExpertInfo();
		String str="EX";
		ebean.setFexpertCode(StringUtil.Random(str));
		model.addAttribute("ebean", ebean);
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(getUser().getId(),"CGEXSQ", getUser().getDpID(),null,ebean.getnCode(), null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(getUser().getName(), getUser().getDepartName(), null);
		model.addAttribute("proposer", proposer);
		return "/WEB-INF/view/purchase_manage/cgexpert/expert_add";
	}
	/*
	 * 新增的保存
	 * @author 专家
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	@RequestMapping(value = "/save")
	@ResponseBody	
	public Result save(ExpertInfo bean,ModelMap model) {
		
		try {
			bean.setfRecUser(getUser().getName());
			bean.setfRecDept(getUser().getDepartName());
			bean.setfRecDeptId(getUser().getDpID());
			cgexpertMng.save(bean,getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	/*
	 * 查看专家信息
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	@RequestMapping(value ="/detail")
	public String detail(String id,String checkType,ModelMap model){
		//查询基本信息
		ExpertInfo ebean = cgexpertMng.findById(Integer.valueOf(id));
		//id是专家的主键id   feid
		model.addAttribute("ebean",ebean);
		model.addAttribute("checkType",checkType);
		
		//入库流程
		if(checkType.equals("in")){
			if(ebean.getFisOutStatus().equals("9")||ebean.getFisOutStatus().equals("1")){
				//查询基本信息				
				ExpertOutInfo bean = expertOutMng.findByExpertOut(id, null, ebean.getFisOutStatus(), null).get(0);
				model.addAttribute("bean", bean);		
				//查询工作流
				List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"ZJKCK", bean.getfRecDeptId(),bean.getBeanCode(),bean.getfNcode(), bean.getJoinTable(), bean.getBeanCodeField(),  bean.getFoCode(),"1");
				model.addAttribute("nodeConf", nodeConfList);
				//得到工作流id
				TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("ZJKCK", bean.getfRecDeptId());
				model.addAttribute("fpId", tProcessDefin.getFPId());
				//对象编码
				model.addAttribute("foCode",bean.getBeanCode());
				//建立工作流发起人的信息
				Proposer proposer = new Proposer(bean.getfRecUser(), bean.getfRecDept(), bean.getfRecTime());
				model.addAttribute("proposer", proposer);
				return "/WEB-INF/view/purchase_manage/cgexpert/expert_detail";
			}
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(ebean.getUserId(),"CGEXSQ", ebean.getfRecDeptId(),ebean.getBeanCode(),ebean.getnCode(), ebean.getJoinTable(), ebean.getBeanCodeField(),  ebean.getFexpertCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(ebean.getfRecUser(), ebean.getfRecDept(), ebean.getfRecTime());
			model.addAttribute("proposer", proposer);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("CGEXSQ", ebean.getfRecDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//对象编码
			model.addAttribute("foCode",ebean.getBeanCode());
		//出库
		}else if(checkType.equals("out")){
			//查询基本信息				
			ExpertOutInfo bean = expertOutMng.findByExpertOut(id, null, ebean.getFisOutStatus(), null).get(0);
			model.addAttribute("bean", bean);		
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"ZJKCK", bean.getfRecDeptId(),bean.getBeanCode(),bean.getfNcode(),bean.getJoinTable(),  bean.getBeanCodeField(), bean.getFoCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("ZJKCK", bean.getfRecDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//对象编码
			model.addAttribute("foCode",bean.getBeanCode());
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(bean.getfRecUser(), bean.getfRecDept(), bean.getfRecTime());
			model.addAttribute("proposer", proposer);
			
		//黑名单
		}else if(checkType.equals("black")){
			//查询基本信息				
			ExpertBlackInfo bean = expertBlackMng.findByExpertBlack(id,ebean.getFisBlackStatus()).get(0);
			model.addAttribute("bean", bean);		
			
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(ebean.getUserId(),"ZJKHMD", bean.getfRecDeptId(),bean.getBeanCode(),bean.getfNcode(),bean.getJoinTable(),  bean.getBeanCodeField(),  bean.getFeBCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("ZJKHMD", bean.getfRecDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//对象编码
			model.addAttribute("foCode",bean.getBeanCode());
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(bean.getfRecUser(), bean.getfRecDept(), bean.getFblackTime());
			model.addAttribute("proposer", proposer);
		}
		
		return "/WEB-INF/view/purchase_manage/cgexpert/expert_detail";
	}
	/*
	 * 专家信息的删除
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id) {
		try {
			//传回来的id是主键
			cgexpertMng.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");	
	}
	/*
	 * 专家信息 修改
	 * @author 冉德茂
	 * @createtime 2018-09-03
	 * @updatetime 2018-09-03
	 */
	@RequestMapping(value = "/edit")
	public String edit(String id, String checkType, ModelMap model){
		model.addAttribute("operType", "edit");
		ExpertInfo ebean = cgexpertMng.findById(Integer.valueOf(id));
		//查询基本信息
		model.addAttribute("ebean",ebean);
		if(checkType.equals("in")){
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(ebean.getUserId(),"CGEXSQ", ebean.getfRecDeptId(),ebean.getBeanCode(),ebean.getnCode(),ebean.getJoinTable(),  ebean.getBeanCodeField(), ebean.getFexpertCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(ebean.getfRecUser(), ebean.getfRecDept(), ebean.getfRecTime());
			model.addAttribute("proposer", proposer);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("CGEXSQ", ebean.getfRecDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//对象编码
			model.addAttribute("foCode",ebean.getBeanCode());	
			return "/WEB-INF/view/purchase_manage/cgexpert/expert_add";
		//出库
		}else if(checkType.equals("out")){
			//查询基本信息				
			ExpertOutInfo bean = expertOutMng.findByExpertOut(id, null, ebean.getFisOutStatus(), null).get(0);
			model.addAttribute("bean", bean);		
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"ZJKCK", bean.getfRecDeptId(),bean.getBeanCode(),bean.getfNcode(),bean.getJoinTable(),  bean.getBeanCodeField(),  bean.getFoCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("ZJKCK", bean.getfRecDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//对象编码
			model.addAttribute("foCode",bean.getBeanCode());
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(bean.getfRecUser(), bean.getfRecDept(), bean.getfRecTime());
			model.addAttribute("proposer", proposer);
			return "/WEB-INF/view/purchase_manage/cgexpert/expert_out";
			
		//黑名单
		}else if(checkType.equals("black")){
			//查询基本信息				
			ExpertBlackInfo bean = expertBlackMng.findByExpertBlack(id,ebean.getFisBlackStatus()).get(0);
			model.addAttribute("bean", bean);		
			
			//查询工作流
			List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"ZJKHMD", bean.getfRecDeptId(),bean.getBeanCode(),bean.getfNcode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getFeBCode(),"1");
			model.addAttribute("nodeConf", nodeConfList);
			//得到工作流id
			TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("ZJKHMD", bean.getfRecDeptId());
			model.addAttribute("fpId", tProcessDefin.getFPId());
			//对象编码
			model.addAttribute("foCode",bean.getBeanCode());
			//建立工作流发起人的信息
			Proposer proposer = new Proposer(bean.getfRecUser(), bean.getfRecDept(), bean.getFblackTime());
			model.addAttribute("proposer", proposer);
			return "/WEB-INF/view/purchase_manage/cgexpert/black_expert_add";		
		}
		return null;
	}

	/*
	 * 分页数据获得（白名单(台账)管理页面） 中标登记选择专家页面
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */
	@RequestMapping(value = "/whiteexpPage")
	@ResponseBody
	public JsonPagination blacksupPage(ExpertInfo bean, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = cgexpertMng.whitepageList(bean, page, rows);;
		List<ExpertInfo> li = (List<ExpertInfo>) p.getList();
		for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
		return getJsonPagination(p, page);
	}
	/*
	 * 分页数据获得（黑名单管理页面）
	 * @author 冉德茂
	 * @createtime 2018-09-14
	 * @updatetime 2018-09-14
	 */
	@RequestMapping(value = "/blackexpPage")
	@ResponseBody
	public JsonPagination whitesupPage(ExpertInfo bean, String sort, String order, Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = cgexpertMng.blackpageList(bean, page, rows);
		List<ExpertInfo> li = (List<ExpertInfo>) p.getList();
		for(int x=0; x<li.size(); x++) {
			//序号设置	
			li.get(x).setNum((x+1)+(page-1)*rows);	
		}
		return getJsonPagination(p, page);
	}
	
	/**
	 * 专家库抽取记录JSP
	 * @author 焦广兴
	 * @createtime 2019-06-27
	 * @updatetime 2019-06-27
	 */
	@RequestMapping("/recordJsp")
	public String recordJsp(ModelMap model){
		return "/WEB-INF/view/purchase_manage/cgexpert/extract_record_list";
	}
	
	/**
	 * 专家库抽取记录 分页
	 * @author 焦广兴
	 * @createtime 2019-06-27
	 * @updatetime 2019-06-27
	 */
	@RequestMapping(value = "/recordList")
	@ResponseBody
	public JsonPagination recordList(ExtractRecordInfo bean, Integer page, Integer rows){
		if(page == null){page = 1;}
		if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = expertExtractMng.pageList(bean, page, rows);;
		return getJsonPagination(p, page);
	}
	
	/**
	 * 专家库抽取JSP
	 * @author 焦广兴
	 * @createtime 2019-06-19
	 * @updatetime 2019-06-19
	 */
	@RequestMapping("/extractJsp")
	public String extractJsp(ModelMap model){
		return "/WEB-INF/view/purchase_manage/cgexpert/expert_extract";
	}
	
	/**
	 * 专家库抽取
	 * @author 焦广兴
	 * @createtime 2019-06-19
	 * @updatetime 2019-06-19
	 */
	@RequestMapping(value = "/expertExtractList")
	@ResponseBody
	public JsonPagination expertExtractList(ExpertInfo bean, String num, String label ){
		Pagination p = new Pagination();
		List<ExpertInfo> li= cgexpertMng.expertExtract(bean, num, label);
		p.setList(li);
		return getJsonPagination(p, 1);
	}
	
	/**
	 * 保存专家库抽取记录
	 * @author 焦广兴
	* @createtime 2019-06-27
	 * @updatetime 2019-06-27
	 */
	@RequestMapping(value = "/saveRecord")
	@ResponseBody
	public Result saveRecord(ExtractRecordInfo bean) {
		try {
			expertExtractMng.save(bean,getUser());
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/**
	 * 专家库抽取记录查看JSP
	 * @author 焦广兴
	 * @createtime 2019-06-19
	 * @updatetime 2019-06-19
	 */
	@RequestMapping("/recordDetailJsp")
	public String recordDetailJsp(String idArr, ModelMap model){
		model.addAttribute("idArr", idArr);
		return "/WEB-INF/view/purchase_manage/cgexpert/record_detail";
	}
	
	/**
	 * 抽取记录专家查看list
	 * @author 焦广兴
	 * @createtime 2019-06-28
	 * @updatetime 2019-06-28
	 */
	@RequestMapping(value = "/recordDetailList")
	@ResponseBody
	public JsonPagination recordDetailList(String idArr,String s1,String s2){
		Pagination p = new Pagination();
		List<ExpertInfo> list=new ArrayList<>();
		if(!StringUtil.isEmpty(idArr)){ 
			String[] feIdArr=idArr.split(",");
			int i=0;
			for (String id : feIdArr) {
				ExpertInfo bean= cgexpertMng.findById(Integer.valueOf(id));
				bean.setNum(i+=1);
				list.add(bean);
			}
		}
		p.setList(list);
		return getJsonPagination(p, 1);
	}
}
