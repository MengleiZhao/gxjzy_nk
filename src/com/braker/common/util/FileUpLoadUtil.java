package com.braker.common.util;

import java.util.ResourceBundle;

public class FileUpLoadUtil {
	private final static ResourceBundle res = ResourceBundle.getBundle("upload");
	
	public static String getSavePath(){
		return res.getString("upload.save_path");
	}
	
	public static String getRootPath(){
		return res.getString("upload.root.save_path");
	}
	
	public static String getDemoSavePath(){
		return getRootPath() + res.getString("upload.demo.save_path");
	}
	//预算模块
	//项目库附件
	public static String getXmkSavePath(){
		return getRootPath() + res.getString("upload.ysgl01.save_path");
	}
	//"项目评审"功能附件存放目录
	public static String getXMPSSavePath(){
		return getRootPath() + res.getString("upload.ysgl02.save_path");
	}
	//"预算控制数分解 一下" 功能附件存放目录
	public static String getYXKZSSavePath(){
		return getRootPath() + res.getString("upload.ysgl03.save_path");
	}
	//"绩效自评" 功能附件存放目录
	public static String getJXZPSavePath(){
		return getRootPath() + res.getString("upload.ysgl04.save_path");
	}
	//预算指标生成"等模块中 提供下载模板的目录
	public static String getYSMBSavePath(){
		return getRootPath() + res.getString("upload.ysgl09.save_path");
	}
	//"结项申请"功能附件存放目录
	public static String getJXSQSavePath(){
		return getRootPath() + res.getString("upload.ysgl10.save_path");
	}
	//收入管理
	//"收入登记" 功能附件存放目录
	public static String getSRDJSavePath(){
		return getRootPath() + res.getString("upload.srgl01.save_path");
	}
	//"收入登记" 功能附件存放目录
	public static String getZJGDSavePath(){
		return getRootPath() + res.getString("upload.srgl02.save_path");
	}
	
	//支出管理
	// "事前申请"  功能附件存放目录
	public static String getSQSQSavePath(){
		return getRootPath() + res.getString("upload.zcgl01.save_path");
	}
	//"借款申请"  功能附件存放目录
	public static String getJKSQSavePath(){
		return getRootPath() + res.getString("upload.zcgl02.save_path");
	}
	//"报销申请"  功能附件存放目录
	public static String getBXSQSavePath(){
		return getRootPath() + res.getString("upload.zcgl03.save_path");
	}
	//"财务审定"  功能附件存放目录
	public static String getCWSDSavePath(){
		return getRootPath() + res.getString("upload.zcgl04.save_path");
	}
	//"出纳受理"  功能附件存放目录
	public static String getCNSLSavePath(){
		return getRootPath() + res.getString("upload.zcgl05.save_path");
	}
	// 提供下载模板的存放目录
	public static String getZCMBSavePath(){
		return getRootPath() + res.getString("upload.zcgl09.save_path");
	}
	
	//采购管理
	//"配置计划管理"  功能附件存放目录
	public static String getPZJHSavePath(){
		return getRootPath() + res.getString("upload.cggl01.save_path");
	}
	//"采购申请审批"  功能附件存放目录
	public static String getCGSQSavePath(){
		return getRootPath() + res.getString("upload.cggl02.save_path");
	}
	//"采购过程登记"  功能附件存放目录
	public static String getCGGCSavePath(){
		return getRootPath() + res.getString("upload.cggl03.save_path");
	}
	// "采购验收"  功能附件存放目录
	public static String getCGYSSavePath(){
		return getRootPath() + res.getString("upload.cggl04.save_path");
	}
	//"采购付款"  功能附件存放目录
	public static String getCGFKSavePath(){
		return getRootPath() + res.getString("upload.cggl05.save_path");
	}
	//"供应商管理"  功能附件存放目录
	public static String getGYSSavePath(){
		return getRootPath() + res.getString("upload.cggl06.save_path");
	}
	//"专家库管理"  功能附件存放目录
	public static String getZJKSavePath(){
		return getRootPath() + res.getString("upload.cggl07.save_path");
	}
	
	//合同管理
	// "合同管理"  功能附件存放目录
	public static String getHTGLSavePath(){
		return getRootPath() + res.getString("upload.htgl01.save_path");
	}
	
	//资产管理
	// "资产管理" 附件共用此目录
	public static String getZCAGKSavePath(){
		return getRootPath() + res.getString("upload.zcagl01.save_path");
	}
	
	//基础数据管理
	//"制度中心"  功能附件存放目录
	public static String getZDZXSavePath(){
		return getRootPath() + res.getString("upload.jcsj01.save_path");
	}
	//"公告管理"  功能附件存放目录
	public static String getGGGLSavePath(){
		return getRootPath() + res.getString("upload.jcsj02.save_path");
	}
	// "经济科目管理"、"功能科目管理"等模块提供下载模板的存放目录
	public static String getJCSJMBSavePath(){
		return getRootPath() + res.getString("upload.jcsj03.save_path");
	}
	
	//支出管理 报销
	//"通用事项报销"  功能发票存放目录
	public static String getFP1SavePath(){
		return getRootPath() + res.getString("upload.fp01.save_path");
	}
	//"会议报销"  功能发票存放目录
	public static String getFP2SavePath(){
		return getRootPath() + res.getString("upload.fp02.save_path");
	}
	//"培训报销"  功能发票存放目录
	public static String getFP3SavePath(){
		return getRootPath() + res.getString("upload.fp03.save_path");
	}
	//"差旅报销"  功能发票存放目录
	public static String getFP4SavePath(){
		return getRootPath() + res.getString("upload.fp04.save_path");
	}
	//"公务接待报销"  功能发票存放目录
	public static String getFP5SavePath(){
		return getRootPath() + res.getString("upload.fp05.save_path");
	}
	//"公车运维报销"  功能发票存放目录
	public static String getFP6SavePath(){
		return getRootPath() + res.getString("upload.fp06.save_path");
	}
	//"公务出国报销"  功能发票存放目录
	public static String getFP7SavePath(){
		return getRootPath() + res.getString("upload.fp07.save_path");
	}
	/*
	 * 根据目录编号获取上传存子目录
	 * @author 安达
	 * @createtime 2018-11-28
	 * @updatetime 2018-11-28
	 */
	public static String getSavePathByName(String pathNum ){
		switch(pathNum){
		case "ysgl01":
		    return getXmkSavePath();//项目库附件
		case "ysgl02":
			return getXMPSSavePath();//"项目评审"功能附件存放目录
		case "ysgl03":
		    return getYXKZSSavePath();//"预算控制数分解 一下" 功能附件存放目录
		case "ysgl04":
		    return getJXZPSavePath();//"绩效自评" 功能附件存放目录   
		case "ysgl09":
		    return getYSMBSavePath();//预算指标生成"等模块中 提供下载模板的目录   
		case "ysgl10":
		    return getJXSQSavePath();//结项申请模块中 提供下载模板的目录       
		case "srgl01":
		    return getSRDJSavePath();//"收入登记" 功能附件存放目录
		case "srgl02":
		    return getZJGDSavePath();//"收入登记" 功能附件存放目录   
		case "zcgl01":
		    return getSQSQSavePath();// "事前申请"  功能附件存放目录   
		case "zcgl02":
		    return getJKSQSavePath();//"借款申请"  功能附件存放目录   
		case "zcgl03":
		    return getBXSQSavePath();//"报销申请"  功能附件存放目录
		case "zcgl04":
		    return getCWSDSavePath();//"财务审定"  功能附件存放目录
		case "zcgl05":
		    return getCNSLSavePath();//"出纳受理"  功能附件存放目录
		case "zcgl09":
		    return getZCMBSavePath();// 提供下载模板的存放目录
		case "cggl01":
		    return getPZJHSavePath();//"配置计划管理"  功能附件存放目录
		case "cggl02":
		    return getCGSQSavePath();//"采购申请审批"  功能附件存放目录
		case "cggl03":
		    return getCGGCSavePath();//"采购过程登记"  功能附件存放目录
		case "cggl04":
		    return getCGYSSavePath();// "采购验收"  功能附件存放目录
		case "cggl05":
		    return getCGFKSavePath();//"采购付款"  功能附件存放目录
		case "cggl06":
		    return getGYSSavePath();//"供应商管理"  功能附件存放目录
		case "cggl07":
		    return getZJKSavePath();//"专家库管理"  功能附件存放目录
		case "htgl01":
		    return getHTGLSavePath();// "合同管理"  功能附件存放目录
		case "zcagl01":
		    return getZCAGKSavePath();// "资产管理" 附件共用此目录
		case "jcsj01":
		    return getZDZXSavePath();//"制度中心"  功能附件存放目录
		case "jcsj02":
		    return getGGGLSavePath();//"公告管理"  功能附件存放目录
		case "jcsj03":
		    return getJCSJMBSavePath();// "经济科目管理"、"功能科目管理"等模块提供下载模板的存放目录
		case "fp01":
		    return getFP1SavePath();// "通用事项报销"  功能发票存放目录
		case "fp02":
		    return getFP2SavePath();// "会议报销"  功能发票存放目录
		case "fp03":
		    return getFP3SavePath();// "培训报销"  功能发票存放目录
		case "fp04":
		    return getFP4SavePath();// "差旅报销"  功能发票存放目录
		case "fp05":
		    return getFP5SavePath();// "公务接待报销"  功能发票存放目录
		case "fp06":
		    return getFP6SavePath();// "公车运维报销"  功能发票存放目录
		case "fp07":
		    return getFP7SavePath();// "公务出国报销"  功能发票存放目录
		default:
			return getSavePath();
		}
	}
}
