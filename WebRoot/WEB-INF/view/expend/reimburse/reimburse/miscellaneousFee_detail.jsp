<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!-- 其他费用 -->
<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">
	<table id="rec-fee-dg" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#fee_id',
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/miscellaneousFee?id=${applyBean.gId}',
	</c:if>
	<c:if test="${empty applyBean.gId}">
	url: '',
	</c:if>
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0
	">
		<thead>
			<tr>
				<th data-options="field:'mId',hidden:true"></th>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'rId',hidden:true"></th>
				<th data-options="field:'fAddress',align:'center',width:100,editor:{type:'textbox',options:{editable:false,readonly:true}}" >所在城市</th>
				<th data-options="field:'standard',align:'center',width:160,editor:{type:'numberbox',options:{editable:false,readonly:true,precision:2}}" >费用标准(元/人天)</th>
				<th data-options="field:'fDays',hidden:true,align:'center',width:160,editor:{type:'numberbox',options:{editable:false,readonly:true}}" >公杂费天数</th>
				<th data-options="field:'countStandard',align:'center',width:160,editor:{type:'numberbox',options:{editable:false,readonly:true,precision:2}}" >总额标准(外币)</th>
				<th data-options="field:'currency',align:'center',width:100,editor:{type:'textbox',options:{editable:false,readonly:true}}" >币种</th>
				<th data-options="field:'fApplyAmount',align:'center',width:160,editor:{type:'numberbox',options:{editable:true,precision:2}}" >申请金额(人民币)</th>
			</tr>
		</thead>
	</table>
	<div id="fee_id" style="height:20px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">公杂费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">申请金额：<span id="feeAmounts"><fmt:formatNumber groupingUsed="true" value="${abroad.mixMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
</div>
<script type="text/javascript">
</script>