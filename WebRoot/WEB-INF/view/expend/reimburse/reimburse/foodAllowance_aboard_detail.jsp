<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">
	<table id="foodtab" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#foodtool',
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/foodJson?gId=${applyBean.gId}',
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
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'fAddress',align:'center',width:100,editor:{type:'textbox',options:{editable:false,readonly:true}}" >所在城市</th>
				<th data-options="field:'standard',align:'center',width:160,editor:{type:'numberbox',options:{editable:false,precision:2,readonly:true}}" >费用标准(元/人天)</th>
				<th data-options="field:'fDays',hidden:true,align:'center',width:160,editor:{type:'numberbox',options:{editable:false,readonly:true}}" >住宿天数</th>
				<th data-options="field:'countStandard',align:'center',width:160,editor:{type:'numberbox',options:{editable:false,precision:2,readonly:true}}" >总额标准(外币)</th>
				<th data-options="field:'currency',align:'center',width:100,editor:{type:'textbox',options:{editable:false,readonly:true}}" >币种</th>
				<th data-options="field:'fApplyAmount',align:'center',width:160,editor:{type:'numberbox',options:{editable:true,precision:2 }}" >申请金额(人民币)</th>
			</tr>
		</thead>
	</table>
	<div id="foodtool" style="height:20px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">伙食费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">申请金额：<span id="applyFoodAmount"><fmt:formatNumber groupingUsed="true" value="${abroad.foodMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
</div>
<script type="text/javascript">

</script>