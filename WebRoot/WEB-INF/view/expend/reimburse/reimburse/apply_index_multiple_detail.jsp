<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="index_detail_apply_tab_id" class="easyui-datagrid" style="width:695px;height:auto"
	data-options="
	singleSelect: true,
	url: '${base}/reimburse/budgetMessageList?rId=${bean.rId}',
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'pID',hidden:true"></th>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'rId',hidden:true"></th>
				<th data-options="field:'fCostName',width:220,align:'center'">费用名称</th>
				<th data-options="field:'fCostClassifyShow',width:216,align:'center'">预算分类</th>
				<th data-options="field:'fCostAmount',align:'center',width:210,editor:{type:'numberbox',options:{editable:false}}">报销金额</th>
				<th data-options="field:'fIndexId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fProDetailId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fIndexType',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fIndexName',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fIndexPFAmount',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fIndexKYAmount',hidden:true,align:'center',width:160,editor:{type:'textbox',options:{editable:false}}">可用额度</th>
				<th data-options="field:'fBudgetYear',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fCostClassify',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
			</tr>
		</thead>
	</table>
</div>