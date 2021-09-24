<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<aside class="menu-accordion">
	<gwideal:perm url="/cockpit/list">
	<h1 onclick="addTabs('管理驾驶舱','${base}/cockpit/list');">综合驾驶舱</h1>
	<div></div>
	</gwideal:perm>

	<h1>报表分析</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/bData/list1">
		<h2 onclick="addTabs('指标执行情况报表','${base}/bData/list1');">指标执行情况报表</h2>
		<div></div>
		</gwideal:perm>
		
		<gwideal:perm url="/bData/list2">
		<h2 onclick="addTabs('指标执行进度总表','${base}/bData/list2');">指标执行进度总表</h2>
		<div></div>
		</gwideal:perm> 
	</div>
	
	<h1>预警分析</h1>
	<div class="opened-for-codepen">
		<gwideal:perm url="/bExcess/list2">
		<h2 onclick="addTabs('预算超额预警','${base}/bExcess/list2');">预算超额预警</h2>
		<div></div>
		</gwideal:perm>
		 
		<gwideal:perm url="/proDelay/proDelaylist">
		<h2 onclick="addTabs('项目延期预警','${base}/proDelay/proDelaylist');">项目延期预警</h2>
		<div></div>
		</gwideal:perm> 
	</div>
</aside>


