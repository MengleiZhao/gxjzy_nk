<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">

	<table id="reimbursein_hoteltab_detail" class="easyui-datagrid" style="width:695px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#reimburse_hoteltool',
	url: '${base}/reimburse/hotelJson?rId=${bean.rId}',
	method: 'post',
	striped : true,
	nowrap : true,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'ffId',hidden:true"></th>
				<th data-options="field:'checkInTime',align:'center',formatter:ChangeDateFormat"width="18%">入住时间</th>
				<th data-options="field:'checkOUTTime',align:'center',formatter:ChangeDateFormat"width="18%">退房时间</th>
				<th data-options="field:'cityId',align:'center',hidden:true">城市id</th>
				<th data-options="field:'travelPersonnelId',hidden:true">住宿人员id</th>
				<th data-options="field:'hotelDay',align:'center'">住宿天数</th>
				<th data-options="field:'locationCity',align:'center'" width="20%">所在城市</th>
				<th data-options="field:'travelPersonnel',align:'center'" width="33%">住宿人员</th>
                 <th data-options="field:'travelChummage',align:'center',width:150">合住人员</th>
				<th data-options="field:'travelChummageId',hidden:true">合住人员id</th>
				<th data-options="field:'reimbAmount',align:'center'" width="12%">报销金额</th>
				<th data-options="field:'standard',hidden:true">住宿标准</th>
			</tr>
		</thead>
	</table>
	<div id="reimburse_hoteltool" style="height:20px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">住宿费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="rhotelAmount"><fmt:formatNumber groupingUsed="true" value="${bean.hotelAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
</div>