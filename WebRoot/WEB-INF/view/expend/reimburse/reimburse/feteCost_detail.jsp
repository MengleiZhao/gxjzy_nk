<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!-- 其他费用 -->
<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">
	<table id="rec-fete-dg" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#costFete_id',
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/feteCostJson?gId=${applyBean.gId}',
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
				<th data-options="field:'fId',hidden:true"></th>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'rId',hidden:true"></th>
				<th data-options="field:'fAddress',width:115,
                        editor:{
                            type:'combobox',
                            options:{
                                valueField:'id',
                                textField:'text',
                                editable:false,
                                multiple:false,
                            }}">所在城市</th>
				<th data-options="field:'fAddressId',hidden:true,align:'center',editor:{type:'textbox',options:{ editable:false}}">所在城市ID</th>
				<th data-options="field:'standard',align:'center',width:115,editor:{type:'numberbox',options:{editable:false}}">费用标准(每人)</th>
				<th data-options="field:'fFeeNum',align:'center',width:75,editor:{type:'numberbox',options:{ }}">宴请人数</th>
				<th data-options="field:'fAccompanyNum',align:'center',width:75,editor:{type:'numberbox',options:{ }}">陪餐人数</th>
				<th data-options="field:'countStandard',align:'center',width:115,editor:{type:'numberbox',options:{editable:false}}">总额标准（外币）</th>
				<th data-options="field:'currency',align:'center',width:45,editor:{type:'textbox',options:{editable:false}}">币种</th>
				<th data-options="field:'fApplyAmount',align:'center',width:141,editor:{type:'numberbox',options:{ precision:2,groupSeparator:','}}">申请金额(人民币)</th>
			</tr>
		</thead>
	</table>
	<div id="costFete_id" style="height:20px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">宴请费用</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">申请金额：<span id="feteCostAmounts"><fmt:formatNumber groupingUsed="true" value="${abroad.feteMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
</div>
<script type="text/javascript">
</script>