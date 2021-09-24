<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

   <table id="voucher_detail_list" class="easyui-datagrid"  style="height:auto;"
		data-options="
			iconCls: 'icon-edit',
			singleSelect: true,
			toolbar: '#tb',
			url: '${base}/Voucher/listJsonPagination?fListVoucher=${bean.fVoucher }&fVid=${bean.fid }&code=${code}',
			method: 'post',
			nowrap:false,
			striped:true,
			fitColumns: true,
			rownumbers: true,
			showFooter: true,
		">
	<thead>
		<tr>
			<th data-options="field:'fSummary',align:'center'" style="width: 20%">摘要</th>
			<th data-options="field:'fSubjectCodeAndName',align:'center'" style="width: 20%">科目编号及名称</th>
			<th data-options="field:'fEconomicName',align:'center'" style="width: 15%">经济分类科目名称</th>
			<th data-options="field:'fDeptName',align:'center'" style="width: 10%">部门名称</th>
			<th data-options="field:'fProjectName',align:'center'" style="width: 15%">项目名称</th>
			<th data-options="field:'fDebitAmount',align:'center'" style="width: 10%">借方金额(元)</th>
			<th data-options="field:'fCreditAmount',align:'center'" style="width: 10%">贷方金额(元)</th>
		</tr>
	</thead>
</table>
