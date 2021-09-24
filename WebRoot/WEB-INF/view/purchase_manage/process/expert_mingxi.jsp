<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table class="easyui-datagrid"  style="width:660px;height:auto"
data-options="
url: '${base}/expertgl/findIndex?fbIdId='+${bean.fbIdId},
method: 'get'
">
<thead>
	<tr>
		<th data-options="field:'feId',hidden:true"></th>
		<th data-options="field:'fexpertName',width:70,editor:'textbox'">专家名称</th>
		<th data-options="field:'fidNumber',width:80,editor:'textbox'">身份证号</th>
		<th data-options="field:'ftel',width:90,editor:'textbox'">办公电话</th>
		<th data-options="field:'feducation',width:70,editor:'textbox'">专家学历</th>
		<th data-options="field:'fjobTime',width:70,editor:'textbox'">工作年限</th>
		<th data-options="field:'ffield',width:80,editor:'textbox'">擅长领域</th>
		<th data-options="field:'fhomeAddr',width:100,editor:'textbox'">家庭住址</th>
		<th data-options="field:'fremark',width:100,editor:'textbox'">备注</th>
</thead>
</table>