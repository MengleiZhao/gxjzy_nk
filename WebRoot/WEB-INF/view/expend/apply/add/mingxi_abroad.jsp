<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<style>
.under{
	outline: none;
	width:25px;
	color:#0000CD;
    border-bottom: 1px solid #000;
    border-top: 0px;
    border-left: 0px;
    border-right: 0px;
    background-color: #F0F5F7;
    text-align:center;
}
.td2{
	width: 300px;
}
</style>
<table class="window-table-readonly" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1" style="width:15%"><p>费用名称：</p></td>
			<td class="window-table-td2" style="width:27%">
				<p style=" color:#0000CD;">国际旅费</p>
			</td>
			
			<td class="window-table-td1"><p>计算标准：</p></td>
			<td class="td2">
				（人数<input class="easyui-numberbox" required="required" id="travelPerson" style="width:30px;height: 25px;" name="travelPerson" value="${abroad.travelPerson}" data-options="onChange:calTotalMoney"
				readonly="readonly" >*人/往返旅费
					<input class="easyui-numberbox" required="required" id="travelStd" name="travelStd" value="${abroad.travelStd}" style="width:50px;height: 25px;" data-options="onChange:calTotalMoney"
				<c:if test="${operation!='add'&& operation!='edit'}">
				readonly="readonly"
				</c:if>>元）
			</td>
			<!-- <td class="window-table-td2"><font id="p_hotelStd">200</font>元/人天</td> -->
		</tr>
		<!-- <tr>
			<td class="window-table-td1"><p>住宿人数：</p></td>
			<td class="window-table-td2">
				<input id="nb_hotelPerson" class="easyui-numberbox"
				style="height:25px;"/>
			</td>
			
			<td class="window-table-td1"><p>住宿天数：</p></td>
			<td class="window-table-td2">
				<input id="nb_hotelDays" class="easyui-numberbox"
				style="height:25px;"/>
			</td>
		</tr> -->
		<tr>
			<td class="window-table-td1"><p>申请金额：</p></td>
			<td class="window-table-td2"><p id="p_travelMoney"></p></td>
			<input hidden="hidden"  id="travelMoney" name="travelMoney" value="${abroad.travelMoney}" >
		</tr>
</table>		
<div style="height:10px;"></div>
<table class="window-table-readonly" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1" style="width:15%"><p>费用名称：</p></td>
			<td class="window-table-td2" style="width:27%">
				<p style=" color:#0000CD;">住宿费</p>
			</td>
			
			<td class="window-table-td1" ><p>计算标准：</p></td>
			<td class="td2" >
				（人数<input class="easyui-numberbox" required="required" style="width:30px;height: 25px;" id="hotelPerson" name="hotelPerson" value="${abroad.hotelPerson}" type="text" data-options="onChange:calTotalMoney"
				readonly="readonly" >*人/天
				<input class="easyui-numberbox" id="hotelStd" required="required" style="width:50px;height: 25px;" name="hotelStd" value="${abroad.hotelStd}"  style="width:40px" type="text" data-options="onChange:calTotalMoney"
				<c:if test="${operation!='add'&& operation!='edit'}">
				readonly="readonly"
				</c:if>>元*
				<input class="easyui-numberbox" style="width:30px;height: 25px;" required="required" id="hotelDay" name="hotelDay" value="${abroad.hotelDay}"  type="text" data-options="onChange:calTotalMoney"
				readonly="readonly" >天）
			</td>
			<!-- <td class="window-table-td2"><font id="p_foodStd">100</font>元/人天</td> -->
		</tr>
		<!-- <tr>
			<td class="window-table-td1"><p>申请人数：</p></td>
			<td class="window-table-td2">
				<input id="nb_foodPerson" class="easyui-numberbox"
				style="height:25px;"/>
			</td>
			
			<td class="window-table-td1"><p>申请天数：</p></td>
			<td class="window-table-td2">
				<input id="nb_foodDays" class="easyui-numberbox"
				style="height:25px;"/>
			</td>
		</tr> -->
		<tr>
			<td class="window-table-td1"><p>申请金额：</p></td>
			<td class="window-table-td2"><p id="p_hotelMoney"></p></td>
			<input type="hidden" id="hotelMoney" name="hotelMoney" value="${abroad.hotelMoney}" >
		</tr>
</table>		
<div style="height:10px;"></div>
<table class="window-table-readonly" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1" style="width:15%"><p>费用名称：</p></td>
			<td class="window-table-td2" style="width:27%">
				<p style=" color:#0000CD;">伙食丶公杂费</p>
			</td>
			<td class="window-table-td1"><p>计算标准：</p></td>
			<td class="td2">
				（人数<input class="easyui-numberbox" style="width:30px;height: 25px;" required="required" id="foodPerson" name="foodPerson" value="${abroad.foodPerson}" type="text" data-options="onChange:calTotalMoney"
				readonly="readonly" >*人/标准
				<input class="easyui-numberbox" style="width:50px;height: 25px;" required="required" id="foodStd" name="foodStd" value="${abroad.foodStd}" style="width:40px" type="text" data-options="onChange:calTotalMoney"
				<c:if test="${operation!='add'&& operation!='edit'}">
				readonly="readonly"
				</c:if>>元*
				<input class="easyui-numberbox" style="width:30px;height: 25px;" required="required" id="foodDay" name="foodDay" value="${abroad.foodDay}" type="text" data-options="onChange:calTotalMoney"
				readonly="readonly" >天）
			</td>
			
		</tr>
		<tr>
			<td class="window-table-td1"><p>申请金额：</p></td>
			<td class="window-table-td2"><p id="p_foodMoney"></p></td>
			<input type="hidden" id="foodMoney" name="foodMoney" value="${abroad.foodMoney}" >
		</tr>
</table>	
<div style="height:10px;"></div>
<table class="window-table-readonly" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1" style="width:15%"><p>费用名称：</p></td>
			<td class="window-table-td2" style="width:27%">
				<p style="color:#0000CD;">零用费</p>
			</td>
			<td class="window-table-td1"><p>计算标准：</p></td>
			<td class="td2">
				（人数<input class="easyui-numberbox" style="width:30px;height: 25px;" required="required" id="pocketPerson" name="pocketPerson" value="${abroad.pocketPerson}" type="text" data-options="onChange:calTotalMoney"
				readonly="readonly" >*人/标准
				<input  class="easyui-numberbox" style="width:50px;height: 25px;" required="required" id="pocketStd" name="pocketStd" value="${abroad.pocketStd}" style="width:40px" type="text" data-options="onChange:calTotalMoney"
				<c:if test="${operation!='add'&& operation!='edit'}">
				readonly="readonly"
				</c:if>>元*
				<input  class="easyui-numberbox" style="width:30px;height: 25px;" required="required" id="pocketDay" name="pocketDay" value="${abroad.pocketDay}" type="text" data-options="onChange:calTotalMoney"
				readonly="readonly" >天）
			</td>
		</tr>
		<tr>
			<td class="window-table-td1"><p>申请金额：</p></td>
			<td class="window-table-td2"><p id="p_pocketMoney"></p></td>
			<input type="hidden" id="pocketMoney" name="pocketMoney" value="${abroad.pocketMoney}" >
		</tr>
</table>	
<div style="height:10px;"></div>
<table class="window-table-readonly" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1" style="width:15%"><p>费用名称：</p></td>
			<td class="window-table-td2" style="width:27%">
				<p style=" color:#0000CD;">交通费</p>
			</td>
			<td class="window-table-td1"><p></p></td>
			<td class="td2">
			</td>
		</tr>
		<tr>
			<td class="window-table-td1"><p>申请金额：</p></td>
			<td class="td2">
				<input class="easyui-numberbox" style="width:50px;height: 25px;" required="required"  id="trafficMoney" name="trafficMoney" value="${abroad.trafficMoney}" style="width:40px" type="text" data-options="onChange:calTotalMoney"
				<c:if test="${operation!='add'&& operation!='edit'}">
				readonly="readonly"
				</c:if>>[元]
			</td>
		</tr>
</table>	
<div style="height:10px;"></div>
<table class="window-table-readonly" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1" style="width:15%;"><p>费用名称：</p></td>
			<td class="window-table-td2">
				<p style=" color:#0000CD;">其他费用</p>
			</td>
			
		</tr>
		<tr>
			<td class="window-table-td1"><p>计算标准：</p></td>
			<td class="td2">
				(出国签证费<input class="easyui-numberbox" style="width:50px;height: 25px;" required="required" id="visaMoney" name="visaMoney" value="${abroad.visaMoney}" style="width:30px" type="text" data-options="onChange:calTotalMoney"
				<c:if test="${operation!='add'&& operation!='edit'}">
				readonly="readonly"
				</c:if>>元;
				  保险费<input class="easyui-numberbox" style="width:50px;height: 25px;" required="required" id="premiumMoney" name="premiumMoney" value="${abroad.premiumMoney}" style="width:30px" type="text" data-options="onChange:calTotalMoney"
				  <c:if test="${operation!='add'&& operation!='edit'}">
				readonly="readonly"
				</c:if>>元;
				  防疫费<input class="easyui-numberbox" style="width:50px;height: 25px;" required="required" id="antiepidemicMoney" name="antiepidemicMoney" value="${abroad.antiepidemicMoney}" style="width:30px" type="text" data-options="onChange:calTotalMoney"
				  <c:if test="${operation!='add'&& operation!='edit'}">
				readonly="readonly"
				</c:if>>元;
				  国际会议注册费<input class="easyui-numberbox" style="width:50px;height: 25px;" required="required" id="registeringMoney" name="registeringMoney" value="${abroad.registeringMoney}" style="width:30px"  type="text" data-options="onChange:calTotalMoney"
				  <c:if test="${operation!='add'&& operation!='edit'}">
				readonly="readonly"
				</c:if>>元;
				  其他<input class="easyui-numberbox" style="width:50px;height: 25px;" required="required" id="otherMoney" name="otherMoney" value="${abroad.otherMoney}" style="width:30px" type="text" data-options="onChange:calTotalMoney"
				  <c:if test="${operation!='add'&& operation!='edit'}">
				readonly="readonly"
				</c:if>>元)
			</td>
		</tr>
		<tr>
			<td class="window-table-td1"><p>申请金额：</p></td>
			<td class="window-table-td2"><p id="p_totalOtherMoney"></p></td>
			<input type="hidden" id="totalOtherMoney" name="totalOtherMoney" value="${abroad.totalOtherMoney}" >
		</tr>
</table>	
<script type="text/javascript">
$(function(){
	initMeetInput();
});

//计算各项申请金额和总额
function calTotalMoney(){
	//国际旅费总额
	var travelMoney = 0;
	var std1 = parseFloat($('#travelStd').numberbox('getValue'));
	var personNum1 = parseFloat($('#travelPerson').numberbox('getValue'));
	if(!isNaN(std1) && !isNaN(personNum1) ){
		travelMoney = std1 * personNum1 ;
	}
	$('#travelMoney').val(travelMoney.toFixed(2));
	$('#p_travelMoney').html(fomatMoney(travelMoney,2)+" [元]");
	//住宿费总额
	var hotelMoney = 0;
	var std2 = parseFloat($('#hotelStd').numberbox('getValue'));
	var personNum2 = parseFloat($('#hotelPerson').numberbox('getValue'));
	var hotelDay = parseFloat($('#hotelDay').numberbox('getValue'));
	if(!isNaN(std2) && !isNaN(personNum2)&& !isNaN(hotelDay) ){
		hotelMoney = std2 * personNum2 *hotelDay;
	}
	$('#hotelMoney').val(hotelMoney.toFixed(2));
	$('#p_hotelMoney').html(fomatMoney(hotelMoney,2)+" [元]");
	//伙食费、公杂费总额
	var foodMoney = 0;
	var std3 = parseFloat($('#foodStd').numberbox('getValue'));
	var personNum3 = parseFloat($('#foodPerson').numberbox('getValue'));
	var foodDay = parseFloat($('#foodDay').numberbox('getValue'));
	if(!isNaN(std3) && !isNaN(personNum3)&& !isNaN(foodDay) ){
		foodMoney = std3 * personNum3 *foodDay;
	}
	$('#foodMoney').val(foodMoney.toFixed(2));
	$('#p_foodMoney').html(fomatMoney(foodMoney,2)+" [元]");
	//零用费总额
	var pocketMoney = 0;
	var std4 = parseFloat($('#pocketStd').numberbox('getValue'));
	var personNum4 = parseFloat($('#pocketPerson').numberbox('getValue'));
	var pocketDay = parseFloat($('#pocketDay').numberbox('getValue'));
	if(!isNaN(std4) && !isNaN(personNum4)&& !isNaN(pocketDay) ){
		pocketMoney = std4 * personNum4 *pocketDay;
	}
	$('#pocketMoney').val(pocketMoney.toFixed(2));
	$('#p_pocketMoney').html(fomatMoney(pocketMoney,2)+" [元]");
	//交通费
	var num1 = parseFloat($('#trafficMoney').numberbox('getValue'));
	//其他费用
	var otherMoney = 0;
	var num2 = parseFloat($('#visaMoney').numberbox('getValue'));
	if(!isNaN(num2)){
		otherMoney=otherMoney+num2;
	}
	var num3 = parseFloat($('#premiumMoney').numberbox('getValue'));
	if(!isNaN(num3)){
		otherMoney=otherMoney+num3;
	}
	var num4 = parseFloat($('#antiepidemicMoney').numberbox('getValue'));
	if(!isNaN(num4)){
		otherMoney=otherMoney+num4;
	}
	var num5 = parseFloat($('#registeringMoney').numberbox('getValue'));
	if(!isNaN(num5)){
		otherMoney=otherMoney+num5;
	}
	var num6 = parseFloat($('#otherMoney').numberbox('getValue'));
	if(!isNaN(num6)){
		otherMoney=otherMoney+num6;
	}
	$('#totalOtherMoney').val(otherMoney.toFixed(2));
	$('#p_totalOtherMoney').html(fomatMoney(otherMoney,2)+" [元]");
	//所有费用合计
	var totalMoney =0;
	if(!isNaN(num1)){
		totalMoney=totalMoney+num1;
	}
	totalMoney=totalMoney+travelMoney+hotelMoney+foodMoney+pocketMoney+otherMoney;
	//给两个总额框赋值
	$('#applyAmount').val(totalMoney.toFixed(2));
	$('#applyAmount_span').html(fomatMoney(totalMoney,2)+" [元]");
}
//初始化费用明细的输入框
function initMeetInput(){
}
</script>
