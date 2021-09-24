<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">

	<table id="apply_outside_traffic_tab_id" class="easyui-datagrid" style="width:407px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#outside_traffic_Id',
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/applyOutsideTrafficPage?gId=${applyBean.gId}',
	</c:if>
	<c:if test="${empty applyBean.gId}">
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
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'travelPersonnel',width:177,
                        editor:{
                            type:'combobox',
                            options:{
                                valueField:'id',
                                textField:'text',
                                multiple: false,
                                onShowPanel:onClickCellInternational
                            }}">出行人员</th>
				<th data-options="field:'applyAmount',width:200,align:'center',editor:{type:'numberbox',options:{editable:true,precision:2 }}">申请费用</th>
			</tr>
		</thead>
	</table>
	<div id="outside_traffic_Id" style="height:30px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">国外城市间交通费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">申请金额：<span id="applyOutsideTrafficAmount"><fmt:formatNumber groupingUsed="true" value="${abroad.trafficMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
</div>
<script type="text/javascript">

</script>