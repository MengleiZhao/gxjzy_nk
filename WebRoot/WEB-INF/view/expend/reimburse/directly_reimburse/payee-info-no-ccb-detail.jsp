<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
		<table class="easyui-datagrid" style="width:695px;height:auto"
		data-options="
		singleSelect: true,
		toolbar: '#payer_info_no_ccb_toolbar_detail',
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
					<th data-options="field:'payeeName',align:'center',editor:{type:'textbox',options:{required:true,editable:true}}" width="17%">姓名</th>
					<th data-options="field:'company',align:'center',editor:{type:'textbox',options:{required:true,editable:true}}" width="25%">单位</th>
					<th data-options="field:'duty',align:'center',editor:{type:'textbox',options:{required:true,editable:true}}" width="20%">职务/职称</th>
					<th data-options="field:'tel',align:'center',editor:{type:'textbox',options:{required:true,editable:true,precision:0}}" width="20%">手机号码</th>
					<th data-options="field:'idCard',align:'center',editor:{type:'textbox',options:{required:true,editable:true}}" width="25%">身份证号</th>
					<th data-options="field:'bank',align:'center',editor:{type:'textbox',options:{required:true,editable:true}}" width="25%">开户银行</th>
					<th data-options="field:'bankAccount',align:'center',editor:{type:'textbox',options:{required:true,editable:true}}" width="25%">银行账号</th>
					<th data-options="field:'planAmount',align:'center',editor:{type:'textbox',options:{required:true,editable:true,precision:2}}" width="17%">应发金额</th>
					<th data-options="field:'deductionAmount',align:'center',editor:{type:'textbox',options:{required:true,editable:true,precision:2}}" width="17%">扣税金额</th>
					<th data-options="field:'payeeAmount',align:'center',editor:{type:'textbox',options:{required:true,editable:true,precision:2}}" width="17%">实发金额</th>
					<th data-options="field:'remark',align:'center',editor:{type:'textbox',options:{required:true,editable:true}}" width="30%">备注</th>				
				</tr>
			</thead>
		</table>
		<div id="payer_info_no_ccb_toolbar_detail" style="height:30px;padding-top : 8px">
			<a style="text-align: right;">
				合计金额：<span style="color: red"><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>元</span>
			</a>
		</div>
</div>