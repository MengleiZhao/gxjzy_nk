<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="outside_traffic_tab_id_detail" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#outside_traffic_Id_detail',
	<c:if test="${!empty bean.gId}">
	url: '${base}/apply/applyOutsideTrafficPage?gId=${bean.gId}',
	</c:if>
	<c:if test="${empty bean.gId}">
	url: '',
	</c:if>
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
				<th data-options="field:'fStartDate',width:110,align:'center'">出发日期</th>
				<th data-options="field:'fEndDate',width:110,align:'center'">到达日期</th>
				<th data-options="field:'travelPersonnel',width:142,align:'center'">出行人员</th>
				<th data-options="field:'vehicle',width:160,align:'center'">交通工具</th>
				<th data-options="field:'vehicleLevel',width:160,align:'center'">交通工具级别</th>
				<th data-options="field:'travelPersonnelId',hidden:true"></th>
			</tr>
		</thead>
	</table>
</div>
