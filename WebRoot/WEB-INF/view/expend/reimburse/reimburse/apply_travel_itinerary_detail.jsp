<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">

	<table id="tracel_itinerary_tab_id_detail" class="easyui-datagrid" style="width:693px;height:auto"
	data-options="
	singleSelect: true,
	url: '${base}/apply/applyTravelPage?gId=${applyBean.gId}',
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'trId',hidden:true"></th>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'travelAttendPeop',width:130,align:'center'">出行人（可多选）</th>
				<th data-options="field:'travelDateStart',width:140,align:'center',formatter:ChangeDateFormat">出发日期</th>
				<th data-options="field:'travelDateEnd',width:140,align:'center',formatter:ChangeDateFormat">结束日期</th>
				<th data-options="field:'travelAreaName',width:158,align:'center'">目的地</th>
				<th data-options="field:'vehicle',width:190,align:'center'">交通工具</th>
				<th data-options="field:'vehicleId',hidden:true"></th>
				<th data-options="field:'travelArea',hidden:true"></th>
				<th data-options="field:'travelAttendPeopId',hidden:true"></th>
				<th data-options="field:'travelPersonnelLevel',hidden:true"></th>
			</tr>
		</thead>
	</table>
</div>
