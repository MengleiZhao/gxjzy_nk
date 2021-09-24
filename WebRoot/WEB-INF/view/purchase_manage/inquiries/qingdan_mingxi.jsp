<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table id="dg" class="easyui-datagrid" style="height:auto"
data-options="
singleSelect: true,
toolbar: '#tb', 
<c:if test="${empty mainid}">
url: '${base}/cginquiries/findcgqd?fpid=${fpid}&fwid=${fwbean.fwId}', 
</c:if>
<c:if test="${!empty mainid}">
url: '${base}/cginquiries/findIndex?mainid=${mainid}', 
</c:if>
method: 'post',
onClickRow: onClickRow
">
<thead>
</thead>
</table>
<div id="tb" style="height:30px">
<a style="color: red;">供货总额：</a><input style="width: 100px;" id="ffinalPrice" name="ffinalPrice"   class="easyui-numberbox" value="${bean.ffinalPrice}" readonly="readonly" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]"/>
优惠后总价=采购数量 X 单价 X (1-优惠幅度%)
</div>
<input type="hidden" id="mingxiJson" name="mingxi"/>

