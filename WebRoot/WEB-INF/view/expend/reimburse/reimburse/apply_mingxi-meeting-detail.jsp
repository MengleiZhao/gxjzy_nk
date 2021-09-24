<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>



<div class="window-tab" style="margin-left: 0px;padding-top: 10px">


	<table id="appli-detail-dg1" class="easyui-datagrid" style="width:693px;height:auto;"
	data-options="
	toolbar: '#appli-detail-tb',
	url: '${base}/apply/mingxi?id=${applyBean.gId}',
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:false,
	scrollbarSize:0,
	singleSelect: true,
	">
	<thead>
		<tr>
			<th data-options="field:'cId',hidden:true"></th>
				<th data-options="field:'costDetail',required:'required',align:'center',width:170">费用名称</th>
				<th data-options="field:'standard',required:'required',align:'center',width:180">费用标准（元/人天）</th>
				<th data-options="field:'totalStandard',required:'required',align:'center',width:170">总额标准[元]</th>
				<th data-options="field:'applySum',required:'required',align:'center',width:175,formatter:listToFixed">申请金额[元]</th>
		</tr>
	</thead>
	</table>
</div>
<%-- <c:if test="${empty detail}">
<div id="appli-detail-tb" style="height:30px">
	<a style="color: red;">申请总额：</a><input style="width: 100px;" id="num1" class="easyui-numberbox" value="${bean.amount}" readonly="readonly" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]"/>
	
	<!-- <a href="#" onclick="openbz()" style="color: blue">查看标准</a> -->
	<a href="javascript:void(0)" onclick="removeit()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<a style="float: right;">&nbsp;&nbsp;</a>
	<a href="javascript:void(0)" onclick="append()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
</div>
</c:if>
<c:if test="${!empty detail}">
<div id="appli-detail-tb" style="height:30px">
	<a style="color: red;">申请总额：</a><input style="width: 100px;" class="easyui-numberbox" value="${bean.amount}" readonly="readonly"/>
</div>
</c:if> --%>
<script type="text/javascript">
</script>
