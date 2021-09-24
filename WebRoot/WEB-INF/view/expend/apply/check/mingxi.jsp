<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>


<!-- <div class="window-title">费用明细</div> -->


<div class="window-tab">
	<table id="appli-detail-dg" class="easyui-datagrid" style="width:660px;height:auto"
	data-options="
	toolbar: '#appli-detail-tb',
	<c:if test="${!empty bean.gId}">
	url: '${base}/apply/mingxi?id=${bean.gId}',
	</c:if>
	<c:if test="${empty bean.gId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRow,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	singleSelect: true,
	">
	<thead>
		<tr>
			<th data-options="field:'cId',hidden:true"></th>
			<th data-options="field:'costDetail',required:'required',align:'center',width:180,editor:'textbox'">费用名称</th>
			<c:if test="${empty detail}">
			<th data-options="field:'applySum',required:'required',align:'center',width:200,editor:{type:'numberbox',options:{onChange:addNum,precision:2}},formatter:function(value,row,index){return fomatMoney(value,2);}">申请金额[元]</th>
			</c:if>
			<c:if test="${!empty detail}">
			<th data-options="field:'applySum',required:'required',align:'center',width:200,editor:{type:'numberbox'},formatter:function(value,row,index){return fomatMoney(value,2);}">申请金额[元]</th>
			</c:if>
			<th data-options="field:'remark',required:'required',align:'center',width:250,editor:'textbox'">描述</th>
			
		</tr>
	</thead>
	</table>
</div>
<input type="hidden" id="mingxiJson" name="mingxi"/>
