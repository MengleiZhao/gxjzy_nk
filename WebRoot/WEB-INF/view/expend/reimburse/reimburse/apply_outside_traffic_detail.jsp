<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="outside_traffic_tab_id_detail_apply" class="easyui-datagrid" style="width:693px;height:auto"
	data-options="
	singleSelect: true,
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/applyOutsideTrafficPage?gId=${applyBean.gId}&travelType=GWCC',
	</c:if>
	<c:if test="${empty applyBean.gId}">
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
				<th data-options="field:'fStartDate',width:110,align:'center',editor:{type:'datebox', options:{editable:false}},formatter:ChangeDateFormat">出发日期</th>
				<th data-options="field:'fEndDate',width:110,align:'center',editor:{type:'datebox',options:{editable:false}},formatter:ChangeDateFormat">到达日期</th>
				<th data-options="field:'travelPersonnel',width:140,align:'center',editor:{type:'textbox',options:{editable:false}}">出行人员</th>
				<th data-options="field:'vehicle',width:150,align:'center',editor:{type:'textbox',options:{editable:false}}">交通工具</th>
				<th data-options="field:'vehicleLevel',width:155,align:'center',editor:{type:'textbox',options:{editable:false}}">交通工具级别</th>
				<th data-options="field:'travelAttendPeopId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
			</tr>
		</thead>
	</table>
</div>