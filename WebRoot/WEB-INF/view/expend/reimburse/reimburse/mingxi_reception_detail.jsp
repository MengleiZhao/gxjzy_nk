<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<c:if test="${type!=1}">
<!-- <div class="window-title">费用明细</div> -->
</c:if>
<!-- 餐费 -->
<div class="window-table" style="margin-bottom:10px">
	<c:if test="${detail!='detail'}">
	<div style="float: left;">
	<span>费用名称：</span>
	<span style=" color:black;">餐费</span>
	
	</div>
	</c:if>
	<table id="rec-food-dg_detail" class="easyui-datagrid" style="width:695px;height:auto;"
	data-options="
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/receptionFood?id=${applyBean.gId}',
	</c:if>
	<c:if test="${empty applyBean.gId}">
	url: '',
	</c:if>
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	singleSelect: true,
	">
	<thead>
		<tr>
			<th data-options="field:'fId',hidden:true"></th>
			<c:if test="${receptionBean.isForeign==0}">			
			<th data-options="field:'time',required:'required',align:'center',width:140,formatter:ChangeDateFormatIndex">时间</th>
			</c:if>
			<c:if test="${receptionBean.isForeign==1}">			
			<th data-options="field:'date',required:'required',align:'center',width:140,formatter:ChangeDateFormat">日期</th>
			</c:if>
			<th data-options="field:'place',required:'required',align:'center',width:190">地点</th>
			<th data-options="field:'fFoodType',required:'required',align:'center',width:113">标准</th>
			<th data-options="field:'fPersonNum',required:'required',align:'center',width:113">用餐总人数</th>
			<th data-options="field:'fOtherNum',required:'required',align:'center',width:114">其中陪餐人数</th>
		</tr>
	</thead>
	</table>
	<div style="overflow:auto;margin-top: 10px;">
		<span style="float: right;color: #0000CD;">
			<span>合计金额： </span>
			<%-- <span style="float: right;"  id="costFood_span" ><fmt:formatNumber groupingUsed="true" value="${receptionBean.costFood}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span> --%>
			<input  name="costFood" class="easyui-numberbox" style="width: 100px; height: 25px;" value="${receptionBean.costFood}"  readonly="readonly"  data-options="icons: [{iconCls:'icon-yuan'}],precision:2" />
			<input type="hidden" id="costFoodStd" name="costFoodStd" value="${receptionBean.costFoodStd}"  />
		</span>
	</div>
</div>
<div style="height:10px;"></div>
<!-- 住宿费 -->
<div class="window-table" style="margin-bottom:10px;">
	<div style="float: left;">
	<span>费用名称：</span>
	<span style=" color:black;">住宿费</span>
	</div>
	<table border="1" style="width:692px;border-collapse: collapse;border-radius: 5px;-webkit-border-radius:5px;border: 1px solid #D9E3E7">
	<tr style="height: 70px;">
		<td style="width:100px;text-align:center">
		<span>住宿安排</span>
		</td>
		<td colspan="3"><textarea name="hotelContet" id="hotelContet" 
				class="textbox-text" autocomplete="off" readonly="readonly" 
				style="width:590px;height:80px;resize:none; border:0;outline:none; margin-top:5px; margin-bottom:0px;">${receptionBean.hotelContet}</textarea>
		</td>
	</tr>
	</table>
	<div style="overflow:auto;margin-top: 10px;">
		<span style="float: right;color: #0000CD;">
			<span>合计金额： </span>
			<%-- <span style="float: right;"  id="costHotel_span" ><fmt:formatNumber groupingUsed="true" value="${receptionBean.costHotel}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span> --%>
			<input  id="costHotel" name="costHotel"  class="easyui-numberbox"  readonly="readonly"  style="width: 100px; height: 25px;" value="${receptionBean.costHotel}"  data-options="icons: [{iconCls:'icon-yuan'}],precision:2" />
		</span>
	</div>
</div>
<div style="height:10px;"></div>


<!-- 其他费用 -->
<div class="window-table">
	<c:if test="${detail!='detail'}">
	<div style="float: left;">
	<span>费用名称：</span>
	<span style=" color:black;">其他费用</span>
	</div>
	</c:if>
	<table id="rec-other-dg_detail" class="easyui-datagrid" style="width:695px;height:auto"
	data-options="
	singleSelect: true,
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/receptionOther?id=${applyBean.gId}',
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
				<th data-options="field:'oID',hidden:true"></th>
				<th data-options="field:'fCostName',required:'required',align:'center',width:195 ">费用名称</th>
				<th data-options="field:'fCost',required:'required',align:'center',width:191 ">支出金额[元]</th>
				<th data-options="field:'fRemark',width:283,align:'center' ">备注</th>
			</tr>
		</thead>
	</table>
	<div style="overflow:auto;margin-top: 10px;">
		<span style="float: right;color: #0000CD;">
			<span>合计金额： </span>
			<span style="float: right;"  id="costOther_span" ><fmt:formatNumber groupingUsed="true" value="${receptionBean.costOther}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span>
			<input type="hidden" id="costOther" name="costOther" value="${receptionBean.costOther}"  />
		</span>
	</div>
</div>
<script type="text/javascript">
</script>