<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">
	<table id="reimbursein_hoteltab" class="easyui-datagrid" style="width:695px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#reimburse_hoteltool',
	url: '${base}/reimburse/hotelJson?rId=${bean.rId}',
	method: 'post',
	striped : true,
	nowrap : true,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'ffId',hidden:true"></th>
				<th data-options="field:'checkInTime',align:'center',editor:{type:'datebox', options:{editable:false}},formatter:ChangeDateFormat"width="18%">入住时间</th>
				<th data-options="field:'checkOUTTime',align:'center',editor:{type:'datebox',options:{editable:false}},formatter:ChangeDateFormat"width="18%">退房时间</th>
				<th data-options="field:'CityId',align:'center',editor:'textbox',hidden:true">城市id</th>
				<th data-options="field:'travelPersonnelId',align:'center',editor:'textbox',hidden:true">住宿人员id</th>
				<th data-options="field:'locationCity',align:'center'" width="20.2%">所在城市</th>
				<th data-options="field:'travelPersonnel',align:'center'" width="32%">住宿人员</th>
				<th data-options="field:'travelChummage',width:150,
		             editor:{
		                 type:'combobox',
		                 options:{
		                 	editable:false,
		                     valueField:'id',
		                     textField:'text',
		                     multiple: false,
		                 }}">合住人员</th>
				<th data-options="field:'applyAmount',align:'center',editor:{type:'numberbox',options:{precision:2}}" width="13%">报销金额</th>
			</tr>
		</thead>
	</table>
	<div id="reimburse_hoteltool" style="height:20px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">住宿费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="rhotelAmount"><fmt:formatNumber groupingUsed="true" value="${bean.hotelAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
</div>