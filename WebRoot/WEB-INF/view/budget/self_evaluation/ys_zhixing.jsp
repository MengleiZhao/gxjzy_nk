<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table id="dg" class="easyui-datagrid" style="width:550px;height:auto"
data-options="
singleSelect: true,
toolbar: '#tb',
url: '',
method: 'post',
onClickRow: onClickRow
">
<thead>
	<tr>
		<th data-options="field:'fpId',hidden:true"></th>
		<th data-options="field:'fmName',align:'center',width:90,editor:'numberbox'">项目总预算</th>
		<th data-options="field:'fpNum',align:'center',width:90,editor:'numberbox'">本年度预算</th>
		<th data-options="field:'fmSpecif',align:'center',width:90,editor:'numberbox'">本年度执行数</th>
		<th data-options="field:'fRemark',align:'center',width:90,editor:'numberbox'">执行率</th>
		<th data-options="field:'fRemark1',align:'center',width:100,editor:'textbox'">偏差原因</th>
		<th data-options="field:'fRemark2',align:'center',width:90,editor:'textbox'">备注</th>
		
	</tr>
</thead>
</table>
<div id="tb" style="height:30px">
	<a href="javascript:void(0)" onclick="removeit()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<a style="float: right;">&nbsp;&nbsp;</a>
	<a href="javascript:void(0)" onclick="append()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
</div>
<input type="hidden" id="mingxiJson" name="mingxi"/>

