<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">

	<table id="hoteltabApply" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#hoteltool',
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/hotelJson?gId=${applyBean.gId}',
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
				<th data-options="field:'fHId',hidden:true"></th>
				<th data-options="field:'locationCity',width:80,
                        editor:{
                            type:'combobox',
                            options:{
                                valueField:'id',
                                textField:'text',
                                multiple:false,
                                onHidePanel:cityHotelId,
                                onShowPanel:clickComboxCity
                            }}">所在城市</th>
				<th data-options="field:'checkInTime',width:100,align:'center',editor:{type:'datebox', options:{editable:false }},formatter:ChangeDateFormat1" >入住时间</th>
				<th data-options="field:'checkOUTTime',width:100,align:'center',editor:{type:'datebox',options:{editable:false }},formatter:ChangeDateFormat1" >退房时间</th>
				<th data-options="field:'cityId',hidden:true,editor:{type:'textbox',options:{editable:false }}">城市id</th>
				<th data-options="field:'standard',width:60,editor:{type:'numberbox',options:{editable:false}}">住宿标准</th>
				<th data-options="field:'hotelDay',width:80,editor:{type:'numberbox',options:{editable:false}}">住宿天数</th>
				<th data-options="field:'countStandard',width:110,editor:{type:'numberbox',options:{editable:false}}">总额标准（外币）</th>
				<th data-options="field:'currency',width:50,editor:{type:'textbox',options:{editable:false}}">币种</th>
				<th data-options="field:'applyAmount',align:'center',width:100,editor:{type:'numberbox',options:{editable:true,precision:2 }}">申请费用</th>
			</tr>
		</thead>
	</table>
	<div id="hoteltool" style="height:20px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">住宿费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">申请金额：<span id="hotelAmounts"><fmt:formatNumber groupingUsed="true" value="${abroad.hotelMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
</div>
<script type="text/javascript">

</script>