package com.braker.icontrol.assets.storage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.braker.common.page.Result;
import com.braker.common.util.StringUtil;
import com.braker.common.web.BaseController;
import com.braker.core.model.User;
import com.braker.icontrol.assets.storage.manager.AssetBasicInfoMng;
import com.braker.icontrol.assets.storage.model.AssetBasicInfo;

@Controller
@RequestMapping("/AssetBasicInfo")
public class AssetBasicInfoController extends BaseController{

	@Autowired
	private AssetBasicInfoMng assetBasicInfoMng;
	
	/**
	 * 低值易耗品入库时新增物资品目跳转到新增页面
	 * @param model
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-03
	 */
	@RequestMapping("/lowAddOther")
	public String lowAddOther(ModelMap model){
		//取消右侧流程显示
		model.addAttribute("splc", "1");
		return "/WEB-INF/view/assets/storage/storage_low_basicInfo_add";
	}

	/**
	 * 保存物资品目表
	 * @param model
	 * @param assetBasicInfo
	 * @return
	 * @author 陈睿超
	 * @createtime 2018-08-03
	 */
	@RequestMapping("/save")
	@ResponseBody
	public Result save(ModelMap model,AssetBasicInfo assetBasicInfo){
		if(StringUtil.isEmpty(assetBasicInfo.getfAssCode())){
			return getJsonResult(false,"请填写物资编码！");
		}else if(StringUtil.isEmpty(assetBasicInfo.getfAssName())){
			return getJsonResult(false,"请填写物资名称！");
		}else if(StringUtil.isEmpty(assetBasicInfo.getfAssType())){
			return getJsonResult(false,"请填写资产类型！");
		}else if(StringUtil.isEmpty(assetBasicInfo.getfSPModel())){
			return getJsonResult(false,"请填写规格型号！");
		}else if(StringUtil.isEmpty(assetBasicInfo.getfMeasUnit())){
			return getJsonResult(false,"请填写计量单位！");
		}else{
			assetBasicInfoMng.saveABI(assetBasicInfo, getUser());
			return getJsonResult(true,"操作成功！");
		}
	}
	
	
}
