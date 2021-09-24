<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="index_detail_tab_id" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#index_toolbar_Id',
	<c:if test="${!empty bean.gId}">
	url: '${base}/apply/budgetMessageList?gId=${bean.gId}',
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
				<th data-options="field:'pID',hidden:true"></th>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'rId',hidden:true"></th>
				<th data-options="field:'fCostName',width:210,align:'center'">费用名称</th>
				<th data-options="field:'fCostTheir',width:210,align:'center'">费用所属</th>
				<th data-options="field:'fCostClassifyShow',width:253,align:'center'">预算分类</th>
				<th data-options="field:'fCostAmount',hidden:true,editor:{type:'numberbox',options:{editable:false}}"></th>
				<th data-options="field:'fIndexId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fProDetailId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fIndexType',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fIndexName',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fIndexPFAmount',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fIndexKYAmount',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fBudgetYear',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'fCostClassify',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
			</tr>
		</thead>
	</table>
</div>