package com.braker.icontrol.cgmanage.cgprocess.controller;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;





import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.JsonPagination;
import com.braker.common.page.Pagination;
import com.braker.common.page.SimplePage;
import com.braker.common.web.BaseController;
import com.braker.icontrol.cgmanage.cgprocess.manager.CgSelMng;
import com.braker.icontrol.cgmanage.cgsupplier.model.WinningBidder;

/**
 * 供应商的控制层
 * 本模块用于采购过程登记的操作
 * @author 冉德茂
 * @createtime 2018-07-25
 * @updatetime 2018-07-25
 */
@Controller
@RequestMapping(value = "/cgsel")
public class CgSelController extends BaseController{
	@Autowired
	private CgSelMng cgselMng;
	



	
	
}
