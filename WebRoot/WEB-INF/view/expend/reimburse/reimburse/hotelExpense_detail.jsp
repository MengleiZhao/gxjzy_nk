<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">

	<table id="hoteltab_detail" class="easyui-datagrid" style="width:693px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#hoteltoolReimDetail',
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/hotelJson?gId=${applyBean.gId}&travelType=GWCC',
	</c:if>
	<c:if test="${empty applyBean.gId}">
	url: '',
	</c:if>
	method: 'post',
	<%-- <c:if test="${empty detail}">
	onClickRow: onClickRowhotel,
	</c:if> --%>
	striped : true,
	nowrap : true,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'ffId',hidden:true"></th>
				<th data-options="field:'checkInTime',align:'center',editor:{type:'datebox', options:{editable:false}},formatter:ChangeDateFormat"width="18%">入住时间</th>
				<th data-options="field:'checkOUTTime',align:'center',editor:{type:'datebox',options:{editable:false}},formatter:ChangeDateFormat"width="18%">退房时间</th>
				<th data-options="field:'CityId',align:'center',editor:'textbox',hidden:true">城市id</th>
				<th data-options="field:'travelPersonnelId',align:'center',editor:'textbox',hidden:true">住宿人员id</th>
				<th data-options="field:'locationCity',align:'center',editor:{type:'textbox',options:{icons:[{iconCls:'icon-add',handler: function(e){
				}}]}}" width="21%">所在城市</th>
				<th data-options="field:'travelPersonnel',align:'center',editor:{type:'textbox',options:{icons:[{iconCls:'icon-add',handler: function(e){
					}}]}}" width="32%">住宿人员</th>
				<th data-options="field:'applyAmount',align:'center',editor:{type:'numberbox',precision:2}" width="12%">申请费用</th>
			</tr>
		</thead>
	</table>
	<div id="hoteltoolReimDetail" style="height:20px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">住宿费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">申请金额：<span id="hotelAmount"><fmt:formatNumber groupingUsed="true" value="${applyBean.hotelAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
</div>