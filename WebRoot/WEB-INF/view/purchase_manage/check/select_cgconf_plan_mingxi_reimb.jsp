<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table id="plan_dg" class="easyui-datagrid" style="width:700px;height:auto"
data-options="
singleSelect: true,
toolbar: '#tb',
rownumbers : true,
striped:true,
 <c:if test="${empty purchase.fpId}">
url: '',
</c:if>
<c:if test="${!empty purchase.fpId}">
url: '${base}/cgreceive/mingxi?id=${purchase.fpId}',
</c:if>
method: 'post',
">
<thead>
	<tr>
		<th data-options="field:'mainId',hidden:true"></th>
		<th data-options="field:'fpId',hidden:true"></th>
		<th data-options="field:'fpurCode',hidden:true"></th>
		<th data-options="field:'fpurName',align:'center',width:154">货物或服务名称</th>
		<th data-options="field:'fnum',align:'center',width:70">数量</th>
		<th data-options="field:'fmeasureUnit',align:'center',width:70">单位</th>
		<th data-options="field:'funitPrice',align:'center',width:110,formatter:listToFixed">单价[元]</th>
		<th data-options="field:'fsumMoney',align:'center',width:110,formatter:listToFixed">预算金额[元]</th>
		<th data-options="field:'fIsImp',align:'center',width:110,formatter:isorno">进口产品</th>
		<th data-options="field:'fSiteAndPeriod',align:'center',width:190">安装使用地点服务周期</th>
		<th data-options="field:'fManager',align:'center',width:110">负责人</th>
	</tr>
</thead>
</table>
<div id="tb" style="height:30px;margin-bottom:5px;margin-top:5px">
	<a style="color: red;">申请总额：</a><input style="width: 100px;" id="totalPrice" name="ffinalPrice" value="${purchase.fpAmount }" class="easyui-numberbox"  readonly="readonly" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]"/>
</div>
<input type="hidden" id="mingxiJson" name="mingxi"/>

<script type="text/javascript">
function isorno(val){
	if(val=='1'){
		return '是';
	}else if(val=='0'){
		return '否';
	}else{
		return val;
	}
}
</script>