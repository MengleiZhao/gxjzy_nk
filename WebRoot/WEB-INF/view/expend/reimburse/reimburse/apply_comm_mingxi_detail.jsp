<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<div id="appli-detail-tb" style="height:30px;padding-top : 8px">
		<a style="float: left;color: #666666;font-size:12px;">申请金额：<span><fmt:formatNumber groupingUsed="true" value="${applyBean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		<a style="float: left;">&nbsp;&nbsp;</a>
	</div>
	<table id="appli-detail-dg" class="easyui-datagrid" style="width:693px;height:auto"
	data-options="
	toolbar: '#appli-detail-tb',
	url: '${base}/apply/mingxi?id=${applyBean.gId}',
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	singleSelect: true,
	">
		<thead>
			<tr>
				<th data-options="field:'cId',hidden:true"></th>
				<th data-options="field:'costDetail',required:'required',align:'center',editor:'textbox'" width='30%';>费用名称</th>
				<th data-options="field:'applySum',required:'required',align:'center',editor:{type:'numberbox',options:{precision:2,groupSeparator:','}}"  width='30%';>申请金额[元]</th>
				<th data-options="field:'remark',required:'required',align:'center',editor:'textbox'" width='40%';>描述</th>
			</tr>
		</thead>
	</table>
</div>
<input type="hidden" id="mingxiJson" name="mingxi"/>
