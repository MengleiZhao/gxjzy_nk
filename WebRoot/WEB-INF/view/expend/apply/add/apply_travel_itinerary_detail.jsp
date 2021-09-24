<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '',
	<c:if test="${!empty bean.gId}">
	url: '${base}/apply/applyTravelPage?gId=${bean.gId}&travelType=${bean.travelType}',
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
				<th data-options="field:'travelAttendPeop',width:130,align:'center',editor:{type:'textbox',options:{editable:false,icons:[{iconCls:'icon-add',handler: function(e){
					     }}]}}">出行人（可多选）</th>
				<th data-options="field:'travelDateStart',width:140,align:'center',editor:{type:'datebox', options:{editable:false,showSeconds:false}},formatter:ChangeDateFormat1">出发日期</th>
				<th data-options="field:'travelDateEnd',width:140,align:'center',editor:{type:'datebox',options:{editable:false,showSeconds:false}},formatter:ChangeDateFormat1">结束日期</th>
				<th data-options="field:'travelAreaName',width:158,align:'center',editor:{type:'textbox',options:{editable:false,icons:[{iconCls:'icon-add',handler: function(e){
									     }}]}}">目的地</th>
				<th data-options="field:'vehicle',width:190,align:'center',editor:{
									type:'combobox',
									options:{
									prompt:'--请选择--',
									editable:false,
										required:true,
										valueField:'text',
                               			multiple: true,
										textField:'text',
										method:'post',
										url:base+'/apply/comboboxJson',
									}}">交通工具</th>
				<th data-options="field:'vehicleId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'travelArea',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'travelAttendPeopId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'travelPersonnelLevel',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
			</tr>
		</thead>
	</table>
</div>