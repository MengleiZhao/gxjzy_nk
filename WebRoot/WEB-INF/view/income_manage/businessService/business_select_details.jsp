<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table id="business_add_details_dg" class="easyui-datagrid" style="width:660px;height:auto"
data-options="
singleSelect: true,
toolbar: '#tb',
rownumbers : true,
striped:true,
url: '${base}/business/addDetails?id=${bean.fBusiId }',
method: 'post',
">
	<thead>
		<tr>
			<th data-options="field:'fChargeItems',align:'center'" style="width: 25%">收费项目</th>
			<th data-options="field:'fChargeUnit',align:'center'" style="width: 20%">计费单位</th>
			<th data-options="field:'fChargeAdvice',align:'center'" style="width: 20%">收费标准意见</th>
			<th data-options="field:'fRemark',align:'left'" style="width: 39%">备注</th>
		</tr>
	</thead>
</table>