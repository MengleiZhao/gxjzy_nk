<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">

	<table id="reimbursein_city_tab_id" class="easyui-datagrid" style="width:695px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#reimburse_in_city_id',
	url: '${base}/reimburse/applyInCityPage?rId=${bean.rId}',
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'ftId',hidden:true"></th>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'fPerson',width:220,align:'center',editor:{type:'textbox',options:{editable:true}}">姓名</th>
				<th data-options="field:'fSubsidyDay',width:220,align:'center',editor:{type:'textbox',options:{editable:true}}">补助天数</th>
				<th data-options="field:'fApplyAmount',width:227,align:'center',editor:{type:'numberbox',options:{editable:true,precision:2}}">报销金额</th>
			</tr>
		</thead>
	</table>
	<div id="reimburse_in_city_id" style="height:30px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">市内交通费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="rInCityAmount"><fmt:formatNumber groupingUsed="true" value="${bean.cityAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
</div>