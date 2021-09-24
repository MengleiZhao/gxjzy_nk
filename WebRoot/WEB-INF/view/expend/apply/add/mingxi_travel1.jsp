<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0">
	<tr>
		<td class="window-table-td1"><p>费用名称：</p></td>
		<td class="window-table-td2">
			<p style=" color:#0000CD;">住宿费</p>
		</td>
		
		<td class="window-table-td1"><p >申请金额：</p></td>
		<td class="window-table-td2">
			<%-- <p id="p_hotelStd" >${travelBean.hotelAmount}元</p> --%>
			<input class="easyui-numberbox" id="hotelAmount" name="hotelAmount" value="${travelBean.hotelAmount}" 
			<c:if test="${operation!='add'&& operation!='edit'}">readonly="readonly"</c:if> 
			style=" width:120px; height: 25px;" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]">
		</td>
	</tr>
</table>		
<div style="height:10px;"></div>
<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0">
	<tr>
		<td class="window-table-td1"><p>费用名称：</p></td>
		<td class="window-table-td2">
			<p style=" color:#0000CD;">伙食补助费</p>
		</td>
		
		<td class="window-table-td1"><p>申请金额：</p></td>
		<td class="window-table-td2">
			<%-- <p id="p_foodStd" >${travelBean.foodAmount}元</p> --%>
			<input class="easyui-numberbox" id="foodAmount" name="foodAmount" value="${travelBean.foodAmount}" 
			<c:if test="${operation!='add'&& operation!='edit'}">readonly="readonly"</c:if>
			style=" width:120px; height: 25px;" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]">
		</td>
	</tr>
</table>		
<div style="height:10px;"></div>
<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0">
	<tr>
		<td class="window-table-td1"><p >费用名称：</p></td>
		<td class="window-table-td2">
			<p style=" color:#0000CD;">长途交通费</p>
		</td>
		
		<td class="window-table-td1"><p>申请金额：</p></td>
		<td class="window-table-td2">
			<input class="easyui-numberbox" id="loongTavelAmount" name="loongTavelAmount" value="${travelBean.loongTavelAmount}" style=" width:120px; height: 25px;" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]">
		</td>
	</tr>
</table>		
<div style="height:10px;"></div>
<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1"><p >费用名称：</p></td>
			<td class="window-table-td2">
				<p style=" color:#0000CD;">市内交通费</p>
			</td>
			
			<td class="window-table-td1"><p>申请金额：</p></td>
			<td class="window-table-td2">
			<input class="easyui-numberbox" id="cityTavelAmount" name="cityTavelAmount" value="${travelBean.cityTavelAmount}"  style=" width:120px;height: 25px;" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]">
			</td>
		</tr>
</table>		
<div style="height:10px;"></div>
<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1"><p >费用名称：</p></td>
			<td class="window-table-td2">
				<p style=" color:#0000CD;">其他费用</p>
			</td>
			
			<td class="window-table-td1"><p>申请金额：</p></td>
			<td class="window-table-td2">
			<!-- <font id="p_otherStd">150</font>元 -->
			<input class="easyui-numberbox" id="otherAmount" name="otherAmount" value="${travelBean.otherAmount}" style=" width:120px; height: 25px;" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]">
			</td>
		</tr>
</table>	

<script type="text/javascript">

//计算各项申请金额和总额
function calTotalMoney(){
	//住宿费总额
	var hotelMoney = parseFloat($('#hotelAmount').numberbox().numberbox('getValue'));
	//伙食费
	var foodMoney = parseFloat($('#foodAmount').numberbox().numberbox('getValue'));
	//长途交通费
	var loongTavelMoney = parseFloat($('#loongTavelAmount').numberbox().numberbox('getValue'));
	//市内交通费
	var cityTavelMoney = parseFloat($('#cityTavelAmount').numberbox().numberbox('getValue'));
	//其他费用
	var otherMoney = parseFloat($('#otherAmount').numberbox().numberbox('getValue'));
	//所有费用合计
	$('#applyAmount_span').html((hotelMoney + foodMoney + otherMoney + cityTavelMoney + loongTavelMoney).toFixed(2) + "[元]");
	$('#applyAmount').val((hotelMoney + foodMoney + otherMoney + cityTavelMoney + loongTavelMoney).toFixed(2));
}
//初始化费用明细的输入框
$("#hotelAmount").numberbox({
	onChange: function(newValue, oldValue) {
		//伙食费
		var foodMoney = parseFloat($('#foodAmount').numberbox('getValue'));
		//长途交通费
		var loongTavelMoney = parseFloat($('#loongTavelAmount').numberbox('getValue'));
		//市内交通费
		var cityTavelMoney = parseFloat($('#cityTavelAmount').numberbox('getValue'));
		//其他费用
		var otherMoney = parseFloat($('#otherAmount').numberbox('getValue'));
		//所有费用合计
		$('#applyAmount_span').html((parseFloat(newValue) + foodMoney + otherMoney+cityTavelMoney+loongTavelMoney).toFixed(2)+"[元]");
		$('#applyAmount').val((parseFloat(newValue) + foodMoney + otherMoney + cityTavelMoney + loongTavelMoney).toFixed(2));
	}
});
$("#foodAmount").numberbox({
	onChange: function(newValue, oldValue) {
		//住宿费总额
		var hotelMoney = parseFloat($('#hotelAmount').numberbox('getValue'));
		//长途交通费
		var loongTavelMoney = parseFloat($('#loongTavelAmount').numberbox('getValue'));
		//市内交通费
		var cityTavelMoney = parseFloat($('#cityTavelAmount').numberbox('getValue'));
		//其他费用
		var otherMoney = parseFloat($('#otherAmount').numberbox('getValue'));
		//所有费用合计
		$('#applyAmount_span').html((hotelMoney + parseFloat(newValue) + otherMoney+cityTavelMoney+loongTavelMoney).toFixed(2)+"[元]");
		$('#applyAmount').val((hotelMoney + parseFloat(newValue) + otherMoney + cityTavelMoney + loongTavelMoney).toFixed(2));
	}
});
$("#loongTavelAmount").numberbox({
	onChange: function(newValue, oldValue) {
		//住宿费总额
		var hotelMoney = parseFloat($('#hotelAmount').numberbox('getValue'));
		//伙食费
		var foodMoney = parseFloat($('#foodAmount').numberbox('getValue'));
		//市内交通费
		var cityTavelMoney = parseFloat($('#cityTavelAmount').numberbox('getValue'));
		//其他费用
		var otherMoney = parseFloat($('#otherAmount').numberbox('getValue'));
		//所有费用合计
		$('#applyAmount_span').html((hotelMoney + foodMoney + otherMoney+cityTavelMoney+parseFloat(newValue)).toFixed(2)+"[元]");
		$('#applyAmount').val((hotelMoney + foodMoney + otherMoney + cityTavelMoney + parseFloat(newValue)).toFixed(2));
	}
});
$("#cityTavelAmount").numberbox({
	onChange: function(newValue, oldValue) {
		//住宿费总额
		var hotelMoney = parseFloat($('#hotelAmount').numberbox('getValue'));
		//伙食费
		var foodMoney = parseFloat($('#foodAmount').numberbox('getValue'));
		//长途交通费
		var loongTavelMoney = parseFloat($('#loongTavelAmount').numberbox('getValue'));
		//其他费用
		var otherMoney = parseFloat($('#otherAmount').numberbox('getValue'));
		//所有费用合计
		$('#applyAmount_span').html((hotelMoney + foodMoney + otherMoney+parseFloat(newValue)+loongTavelMoney).toFixed(2)+"[元]");
		$('#applyAmount').val((hotelMoney + foodMoney + otherMoney + parseFloat(newValue) + loongTavelMoney).toFixed(2));
	}
});
$("#otherAmount").numberbox({
	onChange: function(newValue, oldValue) {
		//住宿费总额
		var hotelMoney = parseFloat($('#hotelAmount').numberbox('getValue'));
		//伙食费
		var foodMoney = parseFloat($('#foodAmount').numberbox('getValue'));
		//长途交通费
		var loongTavelMoney = parseFloat($('#loongTavelAmount').numberbox('getValue'));
		//市内交通费
		var cityTavelMoney = parseFloat($('#cityTavelAmount').numberbox('getValue'));
		//所有费用合计
		$('#applyAmount_span').html((hotelMoney + foodMoney + parseFloat(newValue)+cityTavelMoney+loongTavelMoney).toFixed(2)+"[元]");
		$('#applyAmount').val((hotelMoney + foodMoney + parseFloat(newValue) + cityTavelMoney + loongTavelMoney).toFixed(2));
	}
});
</script>
