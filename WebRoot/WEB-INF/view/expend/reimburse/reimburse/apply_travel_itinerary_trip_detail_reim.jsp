<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">

	<table id="tracel_itinerary_trip_reim_detail_tab_id" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	url: '${base}/reimburse/applyTravelPage?rId=${bean.rId}',
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
				<th data-options="field:'travelType',hidden:true"></th>
				<th data-options="field:'travelAttendPeop',width:158,align:'center',editor:{type:'textbox',options:{editable:false,icons:[{iconCls:'icon-add',handler: function(e){
									     }}]}}">出行人员</th>
				<th data-options="field:'travelAttendPeopId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'travelAreaTime',width:110,align:'center',editor:{type:'datebox', options:{editable:false}}">出行日期</th>
				<th data-options="field:'travelAreaName',width:158,align:'center',editor:{type:'textbox',options:{editable:false,icons:[{iconCls:'icon-add',handler: function(e){
									     }}]}}">目的地</th>
				<th data-options="field:'travelAreaId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options=" field:'areaNames',width:125,
			                        editor:{
			                            type:'combobox',
			                            options:{
			                                valueField:'code',
			                                textField:'text',
			                                editable:false,
			                                multiple: false,
			                            }}">出行区域</th>
				<th data-options="field:'areaCode',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options=" field:'fDriveWay',width:125,
			                        editor:{
			                            type:'combobox',
			                            options:{
			                                valueField:'code',
			                                textField:'text',
			                                editable:false,
			                                multiple: false,
			                            }}">乘车方式</th>
				<th data-options="field:'fDriveWayCode',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'reason',width:165,align:'center',editor:{type:'textbox',options:{editable:true}}">主要工作内容</th>
			</tr>
		</thead>
	</table>
</div>
<script type="text/javascript">
</script>