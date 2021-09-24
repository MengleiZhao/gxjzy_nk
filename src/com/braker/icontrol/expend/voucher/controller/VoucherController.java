package com.braker.icontrol.expend.voucher.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.Footer;
import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.icontrol.expend.voucher.entity.Voucher;
import com.braker.icontrol.expend.voucher.entity.VoucherList;
import com.braker.icontrol.expend.voucher.manager.VoucherListMng;
import com.braker.icontrol.expend.voucher.manager.VoucherMng;

/**
 * 记账凭证表控制层
 * @author 陈睿超
 * @createtime 2019-07-01
 */
@Controller
@RequestMapping("/Voucher")
public class VoucherController extends BaseController{

	@Autowired
	private VoucherMng voucherMng;
	@Autowired
	private VoucherListMng voucherListMng;
	
	
	/**
	 * 跳转到列表页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @reatetime 2019-07-01
	 */
	@RequestMapping("/list")
	public String list(ModelMap model){
		
		return "/WEB-INF/view/expend/voucher/voucher_list";
	}
	
	/**
	 * 加载列表页数据带查询
	 * @param voucher 查询数据
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @reatetime 2019-07-01
	 */
	@ResponseBody
	@RequestMapping("/JsonPagination")
	public JsonPagination jsonPagination(Voucher voucher,String sort,String order,Integer page,Integer rows,ModelMap model){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
		Pagination p = voucherMng.list(voucher, getUser(), page, rows);
		List<Voucher> list=(List<Voucher>) p.getList();
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setNumber(i+1);
		}
		p.setList(list);
		return getJsonPagination(p, page);
	}
	
	/**
	 * 
	 * @ToDo 跳转到查看页面
	 * @param id
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createTime 2019年7月1日
	 */
	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable String id,ModelMap model){
		Voucher bean = voucherMng.findById(Integer.valueOf(id));
		model.addAttribute("bean", bean);
		return "/WEB-INF/view/expend/voucher/voucher_detail";
	}

	/**
	 * @ToDo 根据相关表单编号查询
	 * @param code
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createTime 2019年7月8日
	 */
	@RequestMapping("/detailByBeanCode")
	public String detailByBeanCode(String code,ModelMap model){
		try {
			Voucher bean = voucherMng.findbyproperties("fBeanCode",code);
			model.addAttribute("bean", bean);
			model.addAttribute("code", code);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/WEB-INF/view/expend/voucher/voucher_detail";
	}
	
	
	/**
	 * 根据凭证号加载数据
	 * @param voucherList
	 * @param sort
	 * @param order
	 * @param page
	 * @param rows
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @reatetime 2019-07-01
	 */
	@ResponseBody
	@RequestMapping("/listJsonPagination")
	public JsonPagination listJsonPagination(VoucherList voucherList,String sort,String order,Integer page,Integer rows,String code,ModelMap model){
		if(page == null){page = 1;}
    	if(rows == null){rows = SimplePage.DEF_COUNT;}
    	Voucher bean = voucherMng.findbyproperties("fBeanCode",code);
    	Footer footers = new Footer();
    	footers.setfCreditAmount(bean.getfCreditAllAmoount());
    	footers.setfDebitAmount(bean.getfDebitAllAMount());
    	footers.setfSummary("合计");		
    	List<Footer> footer=new ArrayList<Footer>(); 
    	footer.add(footers);
		List<VoucherList> list = voucherListMng.findbyListVoucher(voucherList);
		Pagination p = new Pagination();
		p.setList(list);
		p.setPageNo(1);
		p.setPageSize(list.size());
		p.setTotalCount(1);
		p.setFooter(footer);
		return getJsonPagination(p, page);
	}
	
	
	@ResponseBody
	@RequestMapping("/exportFile")
	public String exportFile(@PathVariable String id,ModelMap model){
		
		return id;
	}
}
