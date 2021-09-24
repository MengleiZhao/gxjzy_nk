<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/includes/taglibs.jsp"%>

   <table id="alloca_add_plan" class="easyui-datagrid"  style="height:auto;"
		data-options="
			iconCls: 'icon-edit',
			singleSelect: true,
			toolbar: '#tb',
			url: '${base}/Alloca/aListJsonPagination?fAssAllcoaCode=${bean.fAssAllcoaCode }',
			method: 'post'
		">
	<thead>
		<tr>
			<th data-options="field:'fAssCode',align:'center'" style="width: 20%">资产编号</th>
			<th data-options="field:'fAssName',align:'center'" style="width: 20%">资产名称</th>
			<!-- <th data-options="field:'fAssSpecif',align:'center'" style="width: 20%">规格型号</th> -->
			<th data-options="field:'fSpecification',align:'center'" style="width: 15%">规格</th>
			<th data-options="field:'fModel',align:'center'" style="width: 15%">型号</th>
			<th data-options="field:'fAssNum',align:'center'" style="width: 15%">数量</th>
			<th data-options="field:'fMeasUnit',align:'center'" style="width: 15%">计量单位</th>
			<th data-options="field:'fSignPrice',align:'center'" style="width: 15%">单价(元)</th>
			<th data-options="field:'fAmount',align:'center'" style="width: 15%">金额(元)</th>
			<th data-options="field:'fOldAddress',align:'center'" style="width: 20%">原存放地点</th>
			<th data-options="field:'fOldUser',align:'center'" style="width: 20%">原资产管理人</th>
			<th data-options="field:'fNewAddress',align:'center'" style="width: 20%">现存放地点</th>
			<th data-options="field:'fNewUser',align:'center'" style="width: 20%">现资产管理人</th>
			<th data-options="field:'fRemark',align:'center'" style="width: 20%">资产内部转移原因</th>
		</tr>
	</thead>
</table>
<script type="text/javascript">

</script>