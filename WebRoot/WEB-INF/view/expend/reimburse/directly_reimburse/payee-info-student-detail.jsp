<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
		<table class="easyui-datagrid" style="width:695px;height:auto"
		data-options="
		singleSelect: true,
		toolbar: '#payer_info_student_toolbar_detail',
		<c:if test="${!empty bean.drId}">
		url: '${base}/directlyReimburse/payerInfojson?drId=${bean.drId}',
		</c:if>
		<c:if test="${empty bean.drId}">
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
					<th data-options="field:'sclass',align:'center',editor:{type:'textbox',options:{required:true,editable:true}}" width="17%">班级</th>
					<th data-options="field:'payeeName',align:'center',editor:{type:'textbox',options:{required:true,editable:true}}" width="17%">姓名</th>
					<th data-options="field:'proName',align:'center',editor:{type:'textbox',options:{required:true,editable:true}}" width="25%">项目</th>
					<th data-options="field:'numberDays',align:'center',editor:{type:'numberbox',options:{required:true,editable:true}}" width="10%">天数</th>
					<th data-options="field:'everyoneAmount',align:'center',editor:{type:'numberbox',options:{required:true,editable:true,precision:2}}" width="17%">金额/人</th>
					<th data-options="field:'bankAccount',align:'center',editor:{type:'textbox',options:{required:true,editable:true}}" width="25%">建行账号</th>
					<th data-options="field:'payeeAmount',align:'center',editor:{type:'numberbox',options:{required:true,editable:true,precision:2}}" width="17%">总金额</th>
					<th data-options="field:'tel',align:'center',editor:{type:'textbox',options:{required:true,editable:true,precision:0}}" width="25%">联系号码</th>
					<th data-options="field:'remark',align:'center',editor:{type:'textbox',options:{required:true,editable:true}}" width="30%">备注</th>
				</tr>
			</thead>
		</table>
		<div id="payer_info_student_toolbar_detail" style="height:30px;padding-top : 8px">
			<a style="text-align: right;">
				合计金额：<span style="color: red" id="studentAmount"><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>元</span>
			</a>
		</div>
</div>