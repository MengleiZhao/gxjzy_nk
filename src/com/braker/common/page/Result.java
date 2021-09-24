package com.braker.common.page;

public class Result {
	
	public static final String saveSuccessMessage="保存成功！";
	public static final String saveFailureMessage="保存失败，请联系管理员！";
	public static final String deleteSuccessMessage="删除成功！";
	public static final String deleteSuccessMessagecz="专业分类已使用！";
	public static final String deleteFailureMessage="删除失败，请联系管理员！";
	public static final String commitSuccessMessage="提交成功！";
	public static final String commitFailureMessage="提交失败，请联系管理员！";
	public static final String saveSuccessMessagecz = "专业分类已存在";
	public static final String cancelSuccessMessage="注销成功！";
	public static final String cancelFailureMessage="注销失败，请联系管理员！";
	public static final String downSuccessMessage="下载成功！";
	public static final String downFailureMessage="下载失败，请联系管理员！";
	
	private boolean success;//是否成功
	private String info;//提示信息
	public boolean isSuccess() {
		return success;
	}
	public void setSuccess(boolean success) {
		this.success = success;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
}
