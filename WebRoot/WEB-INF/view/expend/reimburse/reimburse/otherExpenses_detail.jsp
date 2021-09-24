<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!-- 其他费用 -->
<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">
	<table id="rec-other-dg" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#other_id',
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/receptionOther?id=${applyBean.gId}',
	</c:if>
	<c:if test="${empty applyBean.gId}">
	url: '',
	</c:if>
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'oID',hidden:true"></th>
				<th data-options="field:'fCostName',required:'required',align:'center',width:195,editor:'textbox'">费用名称</th>
				<th data-options="field:'fCost',required:'required',align:'center',width:191,editor:{type:'numberbox',options:{ precision:2,groupSeparator:','}}">申请金额[元]</th>
				<th data-options="field:'fRemark',width:293,align:'center',editor:'textbox'">备注</th>
			</tr>
		</thead>
	</table>
	<div id="other_id" style="height:20px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">其他费用</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">申请金额：<span id="otherAmounts"><fmt:formatNumber groupingUsed="true" value="${abroad.totalOtherMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
</div>
<script type="text/javascript">
</script>