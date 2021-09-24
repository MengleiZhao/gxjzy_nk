<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table id="plan_dg" class="easyui-datagrid" style="width:700px;height:auto"
data-options="
singleSelect: true,
toolbar: '#tb',
rownumbers : true,
striped:true,
 <c:if test="${empty bean.fpId}">
url: '',
</c:if>
<c:if test="${!empty bean.fpId}">
url: '${base}/cgsqsp/mingxi?id=${bean.fpId}',
</c:if>
method: 'post',
">
<thead>
	<tr>
		<th data-options="field:'mainId',hidden:true"></th>
		<th data-options="field:'fpId',hidden:true"></th>
		<th data-options="field:'fpurCode',hidden:true"></th>
		<th data-options="field:'fpurName',align:'center',width:154">商品名称</th>
		<th data-options="field:'fnum',align:'center',width:70">数量</th>
		<th data-options="field:'funitPrice',align:'right',width:110">单价[元]</th>
		<th data-options="field:'fsumMoney',align:'right',width:110">预算金额[元]</th>
		<th data-options="field:'fcommProp',align:'left',width:190">备注</th>
	</tr>
</thead>
</table>