<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${openType=='add'||openType=='edit'}">
	<th data-options="field:'fAssCode_RL',editor:'textbox',align:'center'" style="width: 20%">资产编号</th>
	<th data-options="field:'fAssName_RL',editor:'textbox',align:'center'" style="width: 20%">资产名称</th>
	<th data-options="field:'fAssSpecif_RL',editor:'textbox',align:'center'" style="width: 20%">规格型号</th>
	<th data-options="field:'fOldAddress',editor:'textbox',align:'center'" style="width: 25%">原存放地点</th>
	<th data-options="field:'fOldUser',editor:'textbox',align:'center'" style="width: 25%">原资产管理人</th>
	<th data-options="field:'fMeasUnit_RL',editor:'textbox',align:'center'" style="width: 15%">计量单位</th>
	<th data-options="field:'fReceNum_RL',editor:{type:'numberbox',options:{precision:2,onChange:sumAmount}},align:'center'" style="width: 15%">数量</th>
	<th data-options="field:'fSignPrice',editor:{type:'numberbox',options:{precision:2,onChange:sumAmount}},align:'center'" style="width: 15%">单价(元)</th>
	<th data-options="field:'fAmount',editor:{type:'numberbox',options:{precision:2}},align:'center'" style="width: 15%">总值(元)</th>
	<th data-options="field:'fNewAddress',editor:'textbox',align:'center'" style="width: 25%">新存放地点</th>
	<th data-options="field:'fNewUser',editor:'textbox',align:'center'" style="width: 25%">新资产管理人</th>
</c:if>
<c:if test="${openType=='detail'||openType=='app'}">
	<th data-options="field:'fAssCode_RL',align:'center'" style="width: 20%">资产编号</th>
	<th data-options="field:'fAssName_RL',align:'center'" style="width: 20%">资产名称</th>
	<th data-options="field:'fAssSpecif_RL',editor:'textbox',align:'center'" style="width: 20%">规格型号</th>
	<th data-options="field:'fOldAddress',editor:'textbox',align:'center'" style="width: 25%">原存放地点</th>
	<th data-options="field:'fOldUser',editor:'textbox',align:'center'" style="width: 25%">原资产管理人</th>
	<th data-options="field:'fMeasUnit_RL',editor:'textbox',align:'center'" style="width: 15%">计量单位</th>
	<th data-options="field:'fReceNum_RL',editor:'numberbox',align:'center'" style="width: 15%">数量</th>
	<th data-options="field:'fSignPrice',editor:'numberbox',align:'center'" style="width: 15%">单价(元)</th>
	<th data-options="field:'fAmount',editor:'numberbox',align:'center'" style="width: 15%">总值(元)</th>
	<th data-options="field:'fNewAddress',editor:'textbox',align:'center'" style="width: 25%">新存放地点</th>
	<th data-options="field:'fNewUser',editor:'textbox',align:'center'" style="width: 25%">新资产管理人</th>
</c:if>
