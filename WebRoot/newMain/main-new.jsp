<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<style>
/* 左侧隐藏滚动条 */
#left-scrollbar::-webkit-scrollbar {
  display: none;
} 
</style>

<html>

<head>
<title>欢迎使用内控管理平台 </title>
</head>

<body class="easyui-layout" style="text-align: left;" id="content">
	<div data-options="region:'north'" 
	style="height: 114px ;border-bottom: 1px #d9e3e7 solid ;background:url(${base}/resource-modality/${themenurl}/skin_/daohang.png) repeat-x;
	background-color: #ffffff;" >
		<%@include file="top.jsp"%>
	</div>
	
	<div id="left-scrollbar" data-options="region:'west'" style="width: 155px;float: left;border: 0px;overflow:hidden;overflow-y:auto;background-color: #0170a4">
		<%@include file="left.jsp"%>
	</div>
	
	<div data-options="region:'center'" style="border: 0px;">
		<div id="system-body" class="easyui-panel" style="width: 100%;height: 100%;background: #f0f5f7"></div>
	</div>
</body>

<script type="text/javascript">
//判断是否退出
function panduan() {
	if(confirm("确认退出吗")){
		window.location.href=base+"/logout.do";
	}
}
var loginType = '${loginType}';
//自动加载首页
$(document).ready(function(){
	dynamicLoading.css('/gxjzy_nk/resource/ui/themes/default/easyui-new.css');
	$("#system-body").panel({
	    href:base+"/index/indexStreetPart?loginType="+loginType+"",
	});
});
</script>

<div id="custom_window"></div>
<div id="search_data_window"></div>
<div id="child_window_1"></div>
<div id="first_window"></div>
<div id="second_window"></div>
<div id="third_window"></div>
<div id="four_window"></div>

<!-- 叶添加，审批弹出窗口 -->
<div id="check_window"></div>
<div id="custom_index_release_window"></div>
<!-- 二维码页面  -->
<div id="QRcode_window"></div>
</html>