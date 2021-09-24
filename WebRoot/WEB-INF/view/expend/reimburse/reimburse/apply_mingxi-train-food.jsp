<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<div id="apply_food_Id" style="height:30px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">师资费-伙食费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">合计金额：<span id="foodAmount"><fmt:formatNumber groupingUsed="true" value="${trainingBean.lessonsFoodMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
	<table id="apply_mingxi-food-dg" class="easyui-datagrid" style="width:693px;height:auto;"
	data-options="
	toolbar: 'apply_food_Id',
	<c:if test="${!empty trainingBean.tId}">
	url: '${base}/apply/teacherMingxi?id=${trainingBean.tId}&costType=food',
	</c:if>
	<c:if test="${empty trainingBean.tId}">
	url: '',
	</c:if>
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:false,
	scrollbarSize:0,
	singleSelect: true,
	">
	<thead>
		<tr>
			<th data-options="field:'thId',hidden:true"></th>
			<th data-options="field:'lecturerName',required:'required',align:'center',width:230">讲师姓名</th>
			<th data-options="field:'foodDay',required:'required',align:'center',width:230">用餐天数</th>
			<th data-options="field:'foodStd',align:'center'">伙食费标准（元/人•天）</th>
			<th data-options="field:'realityFoodStd',align:'center',width:230">申请单价（元/人•天）</th>
			<th data-options="field:'applySum',required:'required',align:'center',width:250">申请金额[元]</th>
			<th data-options="field:'fIdentityNumber',hidden:true,align:'center'">身份证号作为唯一标识</th>
		</tr>
	</thead>
	</table>
</div>