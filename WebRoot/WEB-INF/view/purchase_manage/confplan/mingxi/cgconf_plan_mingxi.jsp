<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table id="qingdangrid" class="easyui-datagrid"  style="width:660px;height:auto"
data-options="
<c:if test="${empty bean.fplId}">
url: '',
</c:if>
<c:if test="${!empty bean.fplId}">
url: '${base}/cgconfplan/mingxi?id=${bean.fplId}',
</c:if>
method: 'get'
">
<thead>
	<tr>
		<th data-options="field:'mainId',hidden:true"></th>
		<th data-options="field:'fplId',hidden:true"></th>
		<th data-options="field:'fpId',hidden:true"></th>
		<th data-options="field:'num',align:'center'" style="width: 10%">序号</th>
		<th data-options="field:'fpurName',align:'center',editor:'textbox'" style="width: 16%">采购名称</th>
		<th data-options="field:'fmeasureUnit',align:'center',editor:'textbox'" style="width: 10%">计量单位</th>
		<th data-options="field:'fpurBrand',align:'center',editor:'textbox'" style="width: 12%">品牌</th>
		<th data-options="field:'fspecifModel',align:'center',editor:'textbox'" style="width: 10%">规格型号</th>
		<th data-options="field:'fnum',align:'center',editor:'numberbox'" style="width: 10%">数量</th>
		<th data-options="field:'funitPrice',align:'center',editor:'numberbox'" style="width:12%">单价[元]</th>
		<th data-options="field:'fsumMoney',align:'center',editor:'numberbox'" style="width: 12%">金额[元]</th>
		<!-- <th data-options="field:'fneedTime',align:'center',editor:'textbox',formatter:ChangeDateFormat" style="width: 20%">需求时间</th> -->
		<th data-options="field:'fcommProp',align:'center',editor:'textbox'" style="width: 12%">商品属性</th>
	</tr>
</thead>
</table>