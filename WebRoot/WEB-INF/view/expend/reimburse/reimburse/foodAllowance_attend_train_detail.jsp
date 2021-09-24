<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!-- 伙食费 -->
<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">
	<table id="reimbursein_foodtab_detail" class="easyui-datagrid" style="width:695px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#reimburse_foodtool',
	url: '${base}/reimburse/foodJson?rId=${bean.rId}',
	method: 'post',
	striped : true,
	nowrap : true,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'ffId',hidden:true"></th>
				<th data-options="field:'fname',width:220,align:'center'" >姓名</th>
				<th data-options="field:'fDays',width:220,align:'center'" >补贴天数</th>
				<th data-options="field:'fApplyAmount',width:227,align:'center'">报销金额</th>
				<th data-options="field:'fnameId',hidden:true"></th>
				<th data-options="field:'fStdAmount',hidden:true"></th>
			</tr>
		</thead>
	</table>
	<div id="reimburse_foodtool" style="height:20px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">伙食补助费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="rfoodAmount"><fmt:formatNumber groupingUsed="true" value="${bean.foodAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
</div>