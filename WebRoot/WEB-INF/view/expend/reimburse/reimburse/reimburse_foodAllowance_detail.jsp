<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">

	<table id="reimbursein_foodtab" class="easyui-datagrid" style="width:695px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#reimburse_foodtool',
	url: '${base}/reimburse/foodJson?rId=${bean.rId}',
	method: 'post',
	striped : true,
	nowrap : true,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'ffId',hidden:true"></th>
				<th data-options="field:'fname',align:'center',editor:{type:'textbox',readonly:true}" width="40%">姓名</th>
				<th data-options="field:'fDays',align:'center',editor:{type:'numberbox',precision:2,readonly:true}" width="35%">补助天数</th>
				<th data-options="field:'fApplyAmount',align:'center',editor:{type:'numberbox',precision:2}" width="25.5%">报销金额</th>
				<th data-options="field:'fnameId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
			</tr>
		</thead>
	</table>
	<div id="reimburse_foodtool" style="height:20px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">伙食补助费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="rfoodAmount"><fmt:formatNumber groupingUsed="true" value="${bean.foodAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
</div>