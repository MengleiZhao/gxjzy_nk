<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<div id="apply_trafficCityToCity_Id" style="height:30px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">师资费-城市间交通费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">合计金额：<span id="traffic1Amount"><fmt:formatNumber groupingUsed="true" value="${trainingBean.lessonsOutMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
	<table id="apply_mingxi-trafficCityToCity-dg" class="easyui-datagrid" style="width:693px;height:auto;"
	data-options="
	toolbar: 'apply_trafficCityToCity_Id',
	<c:if test="${!empty trainingBean.tId}">
	url: '${base}/apply/teacherMingxi?id=${trainingBean.tId}&costType=traffic1',
	</c:if>
	<c:if test="${empty trainingBean.tId}">
	url: '',
	</c:if>
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:false,
	scrollbarSize:0,
	singleSelect: true,
	">
	<thead>
		<tr>
			<th data-options="field:'thId',hidden:true"></th>
				<th data-options="field:'lecturerName',width:170,align:'center'">讲师姓名</th>
				<th data-options="field:'administrativeLevelName',required:'required',align:'center',width:170">行政级别</th>
				<th data-options="field:'vehicle',width:180,align:'center'">交通工具</th>
				<th data-options="field:'applySum',required:'required',align:'center',width:180">申请金额[元]</th>
				<th data-options="field:'administrativeLevel',hidden:true,align:'center'">行政级别编号</th>
		</tr>
	</thead>
	</table>
</div>