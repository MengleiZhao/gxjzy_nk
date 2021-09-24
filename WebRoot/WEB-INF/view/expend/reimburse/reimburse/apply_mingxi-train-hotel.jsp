<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<div id="apply_hotel_Id" style="height:30px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">师资费-住宿费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">合计金额：<span id="hotelAmount"><fmt:formatNumber groupingUsed="true" value="${trainingBean.lessonsHotelMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
	<table id="apply_mingxi-hotel-dg" class="easyui-datagrid" style="width:693px;height:auto;"
	data-options="
	toolbar: 'apply_hotel_Id',
	<c:if test="${!empty trainingBean.tId}">
	url: '${base}/apply/teacherMingxi?id=${trainingBean.tId}&costType=hotel',
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
			<th data-options="field:'lecturerName',required:'required',align:'center',width:230">讲师姓名</th>
			<th data-options="field:'administrativeLevelName',required:'required',align:'center',width:230">行政级别</th>
			<th data-options="field:'hotelDay',required:'required',align:'center',width:230">住宿天数</th>
			<th data-options="field:'hotelStd',align:'center'">住宿费标准（元/人•天）</th>
			<th data-options="field:'realityHotelStd',align:'center',width:230">申请单价（元/人•天）</th>
			<th data-options="field:'applySum',required:'required',align:'center',width:250">申请金额[元]</th>
			<th data-options="field:'fIdentityNumber',hidden:true,align:'center'">身份证号作为唯一标识</th>
			<th data-options="field:'administrativeLevel',hidden:true,align:'center'">行政级别编号</th>
		</tr>
	</thead>
	</table>
	
</div>

<script type="text/javascript">
</script>
