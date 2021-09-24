<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<c:if test="${type!=1}">
</c:if>
<div class="window-tab">
	<c:if test="${empty detail}">
	<div style="margin-right:40px;margin-top: 10px">
	<a href="javascript:void(0)" onclick="removeit()" style="float: right;margin-right: 22px;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<a style="float: right;">&nbsp;&nbsp;</a>
	<a href="javascript:void(0)" onclick="append()" style="float: right; "><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	</c:if>
	<table id="appli-detail-dg" class="easyui-datagrid" style="width:655px;height:auto;margin-top: 10px"
	data-options="
	toolbar: '#appli-detail-tb',
	<c:if test="${!empty bean.gId}">
	url: '${base}/apply/mingxi?id=${bean.gId}',
	</c:if>
	<c:if test="${empty bean.gId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRow,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	singleSelect: true,
	">
	<thead>
		<tr>
			<th data-options="field:'cId',hidden:true"></th>
			
			<c:if test="${type==1}">
				<th data-options="field:'costDetail',required:'required',align:'center',width:185,editor:'textbox'">费用名称</th>
				<c:if test="${empty detail}">
				<th data-options="field:'applySum',required:'required',align:'center',width:150,editor:{type:'numberbox',options:{onChange:addNum,precision:2,groupSeparator:','}}">申请金额[元]</th>
				</c:if>
				<c:if test="${!empty detail}">
				<th data-options="field:'applySum',required:'required',align:'center',width:150,editor:{type:'numberbox',options:{precision:2,groupSeparator:','}}">申请金额[元]</th>
				</c:if>
				<th data-options="field:'remark',required:'required',align:'center',width:280,editor:'textbox'">描述</th>
			</c:if>
		</tr>
	</thead>
	</table>
</div>
<input type="hidden" id="mingxiJson" name="mingxi"/>
