<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="reimburse_outside_tab_id" class="easyui-datagrid" style="width:695px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#reimburse_outside_traffic_Id',
	url: '${base}/reimburse/applyOutsideTrafficPage?rId=${bean.rId}',
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
				<th data-options="field:'travelPersonnel',width:110,align:'center',
                        editor:{
                            type:'combobox',
                            options:{
                                valueField:'id',
                                textField:'text',
                                multiple: true,
                            }}">出行人员</th>
				<th data-options="field:'travelPersonnelId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'vehicle',width:110,align:'center',editor:{
							editable:true,
							type:'combotree',
							filter: function(q, row){
									var opts = $(this).combotree('options');
									return row[opts.textField].indexOf(q) == 0;
								}}">交通工具</th>
				<th data-options="field:'vehicleLevel',width:130,align:'center',editor:{
							editable:true,
							type:'combotree',
							options:{
								required:true,
								valueField:'code',
								textField:'text',
								method:'post',
								url:base+'/vehicle/comboboxJson?selected=JTGJ06&parentCode=JTGJ0602',
							}}">交通工具级别</th>
				<th data-options="field:'applyAmount',width:100,align:'center',editor:{type:'numberbox',options:{editable:true,precision:2}}">报销金额</th>
				<th data-options="field:'travelPersonnelLevel',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
			</tr>
		</thead>
	</table>
	<div id="reimburse_outside_traffic_Id" style="height:30px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">城市间交通费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="rOutsideTrafficAmount"><fmt:formatNumber groupingUsed="true" value="${bean.outsideAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
</div>