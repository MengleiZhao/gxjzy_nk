<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table id="plan_contract_dg_detail_change" class="easyui-datagrid" style="width:700px;height:auto"
data-options="
singleSelect: true,
rownumbers : true,
striped:true,
url: '${base}/Formulation/mingxi?id=${bean.fcId}&type=0',
">
<thead>
	<tr>
		<th data-options="field:'mainId',hidden:true"></th>
		<th data-options="field:'fplId',hidden:true"></th>
		<th data-options="field:'fpId',hidden:true"></th>
		<th data-options="field:'fpurCode',hidden:true"></th>
		<th data-options="field:'fIsImp',hidden:true"></th>
		<th data-options="field:'fSiteAndPeriod',hidden:true"></th>
		<th data-options="field:'fManager',hidden:true"></th>
		<th data-options="field:'fIfEdit',hidden:true"></th>
		<th data-options="field:'fpurName',align:'center',width:154">商品名称</th>
		<th data-options="field:'fpurBrand',align:'center',width:154">品牌</th>
		<th data-options="field:'fModel',align:'center',width:154">型号</th>
		<th data-options="field:'fspec',align:'center',width:154">规格</th>
		<th data-options="field:'fnum',align:'center',width:70">数量</th>
		<th data-options="field:'fmeasureUnit',align:'center',width:70">单位</th>
		<th data-options="field:'funitPrice',align:'center',width:110">单价(元)</th>
		<th data-options="field:'fsumMoney',align:'center',width:110">金额(元)</th>
	</tr>
</thead>
</table>