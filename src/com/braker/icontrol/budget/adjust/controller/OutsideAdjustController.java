package com.braker.icontrol.budget.adjust.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;

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
import com.braker.core.manager.CheterMng;
import com.braker.core.manager.DepartMng;
import com.braker.core.model.CheterInfo;
import com.braker.core.model.Proposer;
import com.braker.icontrol.budget.adjust.entity.TIndexAdItf;
import com.braker.icontrol.budget.adjust.entity.TIndexExteAd;
import com.braker.icontrol.budget.adjust.entity.TIndexExteAdLst;
import com.braker.icontrol.budget.adjust.manager.OutsideAdjustMny;
import com.braker.icontrol.budget.adjust.manager.TIndexExteAdLstMng;
import com.braker.icontrol.budget.manager.entity.TBudgetIndexMgr;
import com.braker.icontrol.budget.manager.manager.BudgetIndexMgrMng;
import com.braker.icontrol.budget.release.manager.TBasicItfMng;
import com.braker.icontrol.budget.release.manager.TBasicMng;
import com.braker.icontrol.budget.release.manager.TProItfMng;
import com.braker.icontrol.budget.release.manager.TProMng;
import com.braker.workflow.entity.TNodeData;
import com.braker.workflow.entity.TProcessDefin;
import com.braker.workflow.manager.TNodeLinkMng;
import com.braker.workflow.manager.TProcessCheckMng;
import com.braker.workflow.manager.TProcessDefinMng;

/**
 * 预算外部修改的控制层
 * @author 叶崇晖
 * @createtime 2018-07-25
 * @updatetime 2018-07-25
 */
@Controller
@RequestMapping(value = "/outsideAdjust")
public class OutsideAdjustController extends BaseController{
	@Autowired
	private OutsideAdjustMny adjustMny;
	
	@Autowired
	private CheterMng cheterMng;
	
	@Autowired
	private TBasicItfMng basicItfMng;
	
	@Autowired
	private TProItfMng proItfMng; 
	
	@Autowired
	private TBasicMng basicMng;
	
	@Autowired
	private TProMng proMng;
	
	@Autowired
	private TIndexExteAdLstMng adLstMng;
	
	
	@Autowired
	private BudgetIndexMgrMng budgetIndexMgrMng;
	
	@Autowired
	private DepartMng departMng;
	@Autowired
	private TNodeLinkMng tNodeLinkMng;
	@Autowired
	private TProcessCheckMng tProcessCheckMng;
	@Autowired
	private TProcessDefinMng tProcessDefinMng;
	/*
	 * 跳转到列表页面
	 * @author 叶崇晖
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 */
	@RequestMapping(value = "/list")
	public String list(ModelMap model) {
		return "/WEB-INF/view/budget/adjust/outside-list";
	}
	
	/*
	 * 分页数据获得
	 * @author 叶崇晖
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 */
	@RequestMapping(value = "/adjustPage")
	@ResponseBody
	public JsonPagination adjustPage(TIndexExteAd bean, Integer page, Integer rows) {
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	
    	Pagination p = adjustMny.pageList(bean, page, rows, getUser());
    	//序号设置	
    	List<TIndexExteAd> li = (List<TIndexExteAd>) p.getList();
    	for (int i = 0; i < li.size(); i++) {
    		li.get(i).setNum((i+1)+(page-1)*rows);
    		String indexName="";
    		BigDecimal changeAmount=BigDecimal.ZERO;
    		List<TIndexExteAdLst> adLstlist = adLstMng.findByAid(li.get(i).getaId()+"");
    		if(adLstlist!=null && adLstlist.size()>0){
    			for(int j=0;j<adLstlist.size();j++){
	    			if("".equals(indexName)){
	    				indexName=adLstlist.get(j).getIndexName();
	    			}else{
	    				indexName=indexName+" | "+adLstlist.get(j).getIndexName();
	    			}
	    			if(adLstlist.get(j).getChangeAmount() !=null){
	    				changeAmount=changeAmount.add(adLstlist.get(j).getChangeAmount());
	    			}
	    			
    			}	
    		}
    		li.get(i).setIndexName(indexName);
			li.get(i).setChangeAmount(changeAmount);
		}
    	
    	return getJsonPagination(p, page); 
	}
	
	/*
	 * 跳转新增页面
	 * @author 叶崇晖
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 */
	@RequestMapping("/add")
	public String add(ModelMap model) {
		TIndexExteAd bean = new TIndexExteAd();
		bean.setOpUser(getUser().getName());
		bean.setDeclarer(getUser().getId());
		bean.setDeptCode(getUser().getDepart().getId());
		String str="OS";
		bean.setOutCode(StringUtil.Random(str));
		model.addAttribute("bean", bean);
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("预算指标外部调整");
		model.addAttribute("cheterInfo", cheterInfo);
		
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(getUser().getId(),"WBZBDZ", getUser().getDpID(),null,bean.getnCode(), null, null, null, "1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		Proposer proposer = new Proposer(getUser().getName(), getUser().getDepartName(), bean.getOpTime());
		model.addAttribute("proposer", proposer);
		
		return "/WEB-INF/view/budget/adjust/outside-add";
	}
	
	/*
	 * 跳转修改查看页面
	 * @author 叶崇晖
	 * @createtime 2018-07-26
	 * @updatetime 2018-07-26
	 */
	@RequestMapping("/edit")
	public String edit(Integer id, ModelMap model ,String editType) {
		//传回来的id是主键
		TIndexExteAd bean = adjustMny.findById(id);
		model.addAttribute("bean", bean);
		
		//查询制度中心文件
		List<CheterInfo> cheterInfo = cheterMng.getCheterInfoList("预算指标外部调整");
		model.addAttribute("cheterInfo", cheterInfo);
		
		//查询工作流
		List<TNodeData> nodeConfList=tProcessCheckMng.getNodeConf(bean.getUserId(),"WBZBDZ", bean.getDeptCode(),bean.getBeanCode(),bean.getnCode(), bean.getJoinTable(), bean.getBeanCodeField(), bean.getOutCode(),"1");
		model.addAttribute("nodeConf", nodeConfList);
		//建立工作流发起人的信息
		String departName=departMng.findDeptByUserId(bean.getOpUser())[1];
		Proposer proposer = new Proposer(bean.getOpUser(), departName, bean.getOpTime());
		model.addAttribute("proposer", proposer);
		//得到工作流id
		TProcessDefin tProcessDefin=tProcessDefinMng.getByBusiAndDpcode("NBZBDZ", bean.getDeptCode());
		model.addAttribute("fpId", tProcessDefin.getFPId());
		//对象编码
		model.addAttribute("foCode",bean.getBeanCode());
		//根据修改还是查看跳转不同页面
		if(editType.equals("0")){
			model.addAttribute("detail", "1");
			return "/WEB-INF/view/budget/adjust/outside-detail";
		} else if(editType.equals("1")){
			return "/WEB-INF/view/budget/adjust/outside-add";
		} else {
			return null;
		}
	}
	
	/*
	 * 跳转到指标选择页面
	 * @author 叶崇晖
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 */
	@RequestMapping(value = "/index")
	public String index(ModelMap model) {
		return "/WEB-INF/view/budget/adjust/outside/index";
	}
	
	
	/*
	 * 指标数据查询
	 * @author 叶崇晖
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 */
	@RequestMapping(value = "/findIndex")
	@ResponseBody
	public List findIndex(ModelMap model, String bids, String pids,String aId, String adType){
		List<TIndexExteAdLst> indexList = new ArrayList<TIndexExteAdLst>();
		try {
			//查询指标
			if (!StringUtil.isEmpty(pids) || !StringUtil.isEmpty(bids)) {
				if(!StringUtil.isEmpty(pids)){
					indexList=adLstMng.findList(pids);
					for (int i = 0; i < indexList.size(); i++) {
						TIndexExteAdLst bean = (TIndexExteAdLst)indexList.get(i);
						bean.setNum(i+1);
					}
				}
				if(!StringUtil.isEmpty(bids)){
					List<TBudgetIndexMgr> indexMgrList=budgetIndexMgrMng.findByBids(bids);
					for(int i = 0; i < indexMgrList.size(); i++){
						 TBudgetIndexMgr indexMgr=indexMgrList.get(i);
						 TIndexExteAdLst bean=new TIndexExteAdLst();
						 bean.setBid(indexMgr.getbId());
						 bean.setIndexName(indexMgr.getIndexName());
						 bean.setPfAmount(indexMgr.getPfAmount());
						 bean.setPid(0);
						 bean.setActivity(indexMgr.getIndexName());
						 bean.setSyAmount(indexMgr.getSyAmount());
						 bean.setNum(i+1);
						 indexList.add(bean);
					 }
				}
			}else {
				indexList= adLstMng.findByAid(aId);
				for(int x=0; x<indexList.size(); x++) {
					//序号设置	
					indexList.get(x).setNum((x+1));	
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return indexList;
	}
	/*
	 * 外部指标调整保存
	 * @author 叶崇晖
	 * @createtime 2018-07-25
	 * @updatetime 2018-07-25
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public Result save(TIndexExteAd bean, String outsideJson ,String tzType) {
		try {
			//调入调出JSON转化为调整明细对象
			JSONArray j =JSONArray.fromObject("["+outsideJson.toString()+"]");
			List<TIndexExteAdLst> tzli = JSONArray.toList(j, TIndexExteAdLst.class);
			
			//保存指标外部调整信息和明细
			adjustMny.save(bean, tzli, getUser());
			
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"操作失败，请联系管理员！");
		}
		return getJsonResult(true,"操作成功！");
	}
	
	/*
	 *  外部指标调整删除
	 * @author 叶崇晖
	 * @createtime 2018-08-01
	 * @updatetime 2018-08-01
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Result delete(Integer id) {
		try {
			//传回来的id是主键
			adjustMny.delete(id);
		} catch (Exception e) {
			e.printStackTrace();
			return getJsonResult(false,"删除失败，请联系管理员！");
		}
		return getJsonResult(true,"删除成功！");	
	}
}
