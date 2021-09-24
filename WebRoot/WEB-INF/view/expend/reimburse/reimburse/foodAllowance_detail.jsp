<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">

	<table id="foodtab_detail" class="easyui-datagrid" style="width:693px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#foodtoolReimDetail',
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/foodJson?gId=${applyBean.gId}&travelType=GWCC',
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
				<th data-options="field:'fname',width:220,align:'center',editor:{type:'textbox',readonly:true}" >姓名</th>
				<th data-options="field:'fDays',width:220,align:'center',editor:{type:'numberbox',precision:2,readonly:true}" >补贴天数</th>
				<th data-options="field:'fApplyAmount',width:227,align:'center',editor:{type:'numberbox',precision:2}" >补贴金额</th>
				<th data-options="field:'fnameId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
			</tr>
		</thead>
	</table>
	<div id="foodtoolReimDetail" style="height:20px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">伙食补助费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">申请金额：<span ><fmt:formatNumber groupingUsed="true" value="${applyBean.foodAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
</div>