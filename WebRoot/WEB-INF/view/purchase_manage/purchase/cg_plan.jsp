<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table id="dg" class="easyui-datagrid" style="width:660px;height:auto"
data-options="
singleSelect: true,
toolbar: '#tb',
rownumbers : true,
<c:if test="${empty bean.fpId}">
url: '',
</c:if>
<c:if test="${!empty bean.fpId}">
url: '${base}/cgsqsp/mingxi?id=${bean.fpId}',
</c:if>
method: 'post',
onClickRow: onClickRow
">
<thead>
	<tr>
 		<!-- <th data-options="field:'ck',checkbox:true"></th> -->
		<th data-options="field:'fpId',hidden:true"></th>
		<!-- <th data-options="field:'index',align:'center',formatter:formatter_index">序号</th> -->
						
			<th data-options="field:'fmType',align:'left',width:112,
					editor:{
							editable:true,
							type:'combobox',
							options:{
								valueField:'code',
								textField:'text',
								method:'post',
									url:'${base}/lookup/lookupsJson?parentCode=ZCLX'								
							}
						}">物品类型</th>		
		<th data-options="field:'fmName',align:'left',width:92,editor:'textbox'">物品名称</th>
		<th data-options="field:'fmSpecif',align:'left',width:82,editor:'textbox'">规格型号</th>
		<th data-options="field:'fmModel',align:'left',width:62,editor:'textbox'">计量单位</th>
		<th data-options="field:'fpNum',align:'left',width:62,editor:'numberbox'">采购数量</th>
		<th data-options="field:'fsignPrice',align:'left',width:62,editor:'numberbox'">单价[元]</th>
		<th data-options="field:'famount',align:'left',width:72,editor:'numberbox'">金额[元]</th>
		<th data-options="field:'fRemark',align:'left',width:90,editor:'textbox'">要求</th>
		
	</tr>
</thead>
</table>
<div id="tb" style="height:30px">
	<a href="javascript:void(0)" onclick="removeit()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<a style="float: right;">&nbsp;&nbsp;</a>
	<a href="javascript:void(0)" onclick="append()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
</div>
<input type="hidden" id="mingxiJson" name="mingxi"/>


