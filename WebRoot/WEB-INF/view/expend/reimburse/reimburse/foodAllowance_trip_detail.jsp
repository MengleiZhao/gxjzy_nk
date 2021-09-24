<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">

	<table id="foodtabTripDetail" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#foodtoolTripReim',
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/foodJson?gId=${applyBean.gId}&travelType=GWCX',
	</c:if>
	<c:if test="${empty applyBean.gId}">
	url: '',
	</c:if>
	method: 'post',
	striped : true,
	nowrap : true,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'ffId',hidden:true"></th>
				<th data-options="field:'fname',align:'center',width:160,editor:{type:'textbox',readonly:true}" >姓名</th>
				<th data-options="field:'fDays',align:'center',width:260,editor:{type:'numberbox',options:{editable:true }}" >补贴天数</th>
				<th data-options="field:'fApplyAmount',align:'center',width:255,editor:{type:'numberbox',options:{editable:false,precision:2 }}" >申请金额</th>
				<th data-options="field:'fnameId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
			</tr>
		</thead>
	</table>
	<div id="foodtoolTripReim" style="height:20px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">伙食补助费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">申请金额：<span id="applyFoodAmountTrip"><fmt:formatNumber groupingUsed="true" value="${applyBean.foodAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
</div>
<script type="text/javascript">
</script>