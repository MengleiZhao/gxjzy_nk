<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1"><p>费用名称：</p></td>
			<td class="window-table-td2">
				<p style=" color:#0000CD;">住宿费</p>
			</td>
			
			<td class="window-table-td1"><p >申请金额：</p></td>
			<td class="window-table-td2"><p id="p_hotelStd" >${travelBean.hotelAmount}元</p></td>
		</tr>
</table>		
<div style="height:10px;"></div>
<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1"><p>费用名称：</p></td>
			<td class="window-table-td2">
				<p style=" color:#0000CD;">伙食补助费</p>
			</td>
			
			<td class="window-table-td1"><p >申请金额：</p></td>
			<td class="window-table-td2"><p id="p_foodStd" >${travelBean.foodAmount}元</p></td>
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
			<td class="window-table-td2"><p >${travelBean.loongTavelAmount}元</p></td>
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
			<td class="window-table-td2"><p>${travelBean.cityTavelAmount}元</p></td>
		</tr>
</table>		
<div style="height:10px;"></div>
<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1"><p>费用名称：</p></td>
			<td class="window-table-td2">
				<p style=" color:#0000CD;">其他费用</p>
			</td>
			
			<td class="window-table-td1"><p>申请金额：</p></td>
			<td class="window-table-td2"><p>${travelBean.otherAmount}元</p></td>
		</tr>
</table>	

<script type="text/javascript">
$(function(){
	initMeetInput();
});

//计算各项申请金额和总额
function calTotalMoney(){
	//住宿费总额
	var hotelMoney = 0;
	var std1 = parseInt($('#p_hotelStd').html());
	var personNum1 = parseInt($('#nb_hotelPerson').numberbox('getValue'));
	var dayNum1 = parseInt($('#nb_hotelDays').numberbox('getValue'));
	if(!isNaN(std1) && !isNaN(personNum1) && !isNaN(dayNum1)){
		hotelMoney = std1 * personNum1 * dayNum1;
	}
	$('#p_hotelMoney').html(hotelMoney.toFixed(2));
	//伙食费
	var foodMoney = 0;
	var std2 = parseInt($('#p_foodStd').html());
	var personNum2 = parseInt($('#nb_foodPerson').numberbox('getValue'));
	var dayNum2 = parseInt($('#nb_foodDays').numberbox('getValue'));
	if(!isNaN(std2) && !isNaN(personNum2) && !isNaN(dayNum2)){
		foodMoney = std2 * personNum2 * dayNum2;
	}
	$('#p_foodMoney').html(foodMoney.toFixed(2));
	//其他费用
	var otherMoney = 0;
	var std3 = parseInt($('#p_otherStd').html());
	var personNum3 = parseInt($('#nb_otherPerson').numberbox('getValue'));
	var dayNum3 = parseInt($('#nb_otherDays').numberbox('getValue'));
	if(!isNaN(std3) && !isNaN(personNum3) && !isNaN(dayNum3)){
		otherMoney = std3 * personNum3 * dayNum3;
	}
	$('#p_otherMoney').html(otherMoney.toFixed(2));
	//所有费用合计
	$('#applyAmount_span').html((hotelMoney + foodMoney + otherMoney).toFixed(2));
}
//初始化费用明细的输入框
function initMeetInput(){
	$("#nb_hotelPerson").numberbox({
		onChange: function(newValue, oldValue) {
			calTotalMoney();
		}
	});
	$("#nb_hotelDays").numberbox({
		onChange: function(newValue, oldValue) {
			calTotalMoney();
		}
	});
	$("#nb_foodPerson").numberbox({
		onChange: function(newValue, oldValue) {
			calTotalMoney();
		}
	});
	$("#nb_foodDays").numberbox({
		onChange: function(newValue, oldValue) {
			calTotalMoney();
		}
	});
	$("#nb_otherPerson").numberbox({
		onChange: function(newValue, oldValue) {
			calTotalMoney();
		}
	});
	$("#nb_otherDays").numberbox({
		onChange: function(newValue, oldValue) {
			calTotalMoney();
		}
	});
}
</script>
