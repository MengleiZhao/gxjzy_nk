<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<div id="apply_lessons_Id" style="height:30px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">师资费-讲课费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">合计金额：<span id="lessonsAmount"><fmt:formatNumber groupingUsed="true" value="${trainingBean.lessonsMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
	<table id="apply_mingxi-lessons-dg" class="easyui-datagrid" style="width:693px;height:auto;"
	data-options="
	toolbar: 'apply_lessons_Id',
	<c:if test="${!empty trainingBean.tId}">
	url: '${base}/apply/teacherMingxi?id=${trainingBean.tId}&costType=lesson',
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
				<th data-options="field:'lecturerName',required:'required',align:'center',width:190">讲师姓名</th>
				<th data-options="field:'fIdentityNumber',align:'center',hidden:true">身份证号</th>
				<th data-options="field:'lessonTime',required:'required',width:140,align:'center'">学时</th>
				<th data-options="field:'lessonStd',required:'required',align:'center',width:190,hidden:true">标准课时费标准（元/学时）</th>
				<th data-options="field:'realityLessonStd',required:'required',align:'center',width:190,">课时费标准（元/学时）</th>
				<th data-options="field:'lessonStdTotal',required:'required',align:'center',width:180,hidden:true">正常标准[元]</th>
				<th data-options="field:'lessonStdTotalUp',required:'required',align:'center',width:180,hidden:true">上浮后标准[元]</th>
				<th data-options="field:'fNetAmount',align:'center'">税后金额[元]</th>
				<th data-options="field:'fIndividualIncomeTax'">预扣预缴税款[元]</th>
				<th data-options="field:'applySum',required:'required',align:'center',width:190">申请金额[元]</th>
				<th data-options="field:'isOutside',hidden:true"></th>
		</tr>
	</thead>
	</table>
</div>