<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<style>
.under{
	outline: none;
	width:75px;
    border-bottom: 1px solid #000;
    border-top: 0px;
    border-left: 0px;
    border-right: 0px;
    background-color: #F0F5F7;
    text-align:center;
    color:#0000CD;
}
.window-table-td1{
	width: 130px;
    height: 30px;
}
.underline{
 text-decoration: underline
}
.window-table-readonly{
	margin-left: 5px;
	width: 680px;
}
</style>

<table class="window-table-readonly" cellspacing="0" cellpadding="0">
	<tr>
		<td class="window-table-td1"><p>住宿费</p></td>
		<td class="window-table-td2"></td>
		<td class="window-table-td1"></td>
		<td class="window-table-td2"></td>
	</tr>
	<tr>
		<td class="window-table-td1">
			<p><input class="under" id="hotelPersonNum" autocomplete="off" name="hotelPersonNum" value="${meetingBean.hotelPersonNum}" onkeyup="value=this.value.replace(/\D+/g,'')" onchange="getHotelMoney()" type="text" <c:if test="${operation!='add'&& operation!='edit'}">readonly="readonly"</c:if>>人·天*</p>
		</td>
		<td class="window-table-td2">
			<p>
				&nbsp;&nbsp;<input class="numberf under" autocomplete="off" id="realityHotelMoney" name="realityHotelMoney" value="${meetingBean.realityHotelMoney}" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="getHotelMoney()" type="text" <c:if test="${operation!='add'&& operation!='edit'}">readonly="readonly"</c:if>>元/人·天
   			</p>
		</td>
		<td class="window-table-td1"><p>申请金额：</p></td>
		<td class="window-table-td2">
			<c:if test="${operation!='add'&& operation!='edit'}">
				<%-- <p class="underline" id="p_hotelMoney">${meetingBean.hotelMoney}元</p> --%>
				<input class="numberf under" value="${meetingBean.hotelMoney}" readonly="readonly" type="text">元
			</c:if>
			<c:if test="${operation=='add'|| operation=='edit'}">
				<input class="numberf under" id="hotelMoney" autocomplete="off" name="hotelMoney" value="${meetingBean.hotelMoney}" type="text" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="hotelMoneyChange()">元
			</c:if>
		</td>
	</tr>
	<tr>
		<td class="window-table-td1" ></td>
		<td class="window-table-td2" ></td>
		<td class="window-table-td1"><p>定额标准：</p></td>
		<td class="window-table-td2">
			<input class="numberf under" id="hotelStdUpdate" name="hotelStd" type="text" value="${meetingBean.hotelStd }" readonly="readonly">元
			<input type="hidden" id="p_hotelStd" name="hotelStdSingle"/>
		</td>
	</tr>
</table>		
<div style="height:10px;"></div>
<table class="window-table-readonly" cellspacing="0" cellpadding="0">
	<tr>
		<td class="window-table-td1"><p>伙食费</p></td>
		<td class="window-table-td2"></td>
		<td class="window-table-td1"></td>
		<td class="window-table-td2"></td>
	</tr>
	<tr>
		<td class="window-table-td1">
			<p><input class="under" id="foodPersonNum" autocomplete="off" name="foodPersonNum" value="${meetingBean.foodPersonNum}" onkeyup="value=this.value.replace(/\D+/g,'')" onchange="getFoodMoney()" type="text" <c:if test="${operation!='add'&& operation!='edit'}">readonly="readonly"</c:if>>人·天*</p>
		</td>
		<td class="window-table-td2">
			<p>
				&nbsp;&nbsp;<input class="numberf under" autocomplete="off" id="realityFoodMoney" name="realityFoodMoney" value="${meetingBean.realityFoodMoney}" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="getFoodMoney()" type="text" <c:if test="${operation!='add'&& operation!='edit'}">readonly="readonly"</c:if>>元/人·天
   			</p>
		</td>
		<td class="window-table-td1"><p>申请金额：</p></td>
		<td class="window-table-td2">
			<c:if test="${operation!='add'&& operation!='edit'}">
				<%-- <p id="p_foodMoney">${meetingBean.foodMoney}元</p> --%>
				<input class="numberf under" value="${meetingBean.foodMoney}" readonly="readonly" type="text">元
			</c:if>
			<c:if test="${operation=='add'|| operation=='edit'}">
				<input class="numberf under" id="foodMoney" autocomplete="off" name="foodMoney" value="${meetingBean.foodMoney}" type="text" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="foodMoneyChange()">元
			</c:if>
		</td>
	</tr>
	<tr>
		<td class="window-table-td1" ></td>
		<td class="window-table-td2" ></td>
		<td class="window-table-td1"><p>定额标准：</p></td>
		<td class="window-table-td2">
			<input class="numberf under" id="foodStdUpdate" name="foodStd" type="text" value="${meetingBean.foodStd}" readonly="readonly">元
			<input type="hidden" id="p_foodStd" name="foodStdSingle"/>
		</td>
	</tr>
</table>

<div style="height:10px;"></div>
<table class="window-table-readonly" cellspacing="0" cellpadding="0">
	<tr>
		<td class="window-table-td1"><p>其他费用</p></td>
		<td class="window-table-td2"></td>
		<!-- <td class="window-table-td1"><p>申请金额：</p></td>
		<td class="window-table-td2">
			<p id="p_otherAllMoney">元</p>
		</td> -->
	</tr>
	<!-- <tr>
		<td class="window-table-td1"><p>文件印刷费</p></td>
		<td class="window-table-td2"></td>
		<td class="window-table-td1"></td>
		<td class="window-table-td2"></td>
	</tr> -->
	<tr>
		<td class="window-table-td1">
			<p><input class="under" id="printingPersonNum" autocomplete="off" name="printingPersonNum" value="${meetingBean.printingPersonNum}" onkeyup="value=this.value.replace(/\D+/g,'')" onchange="getPrintingMoney()" type="text" <c:if test="${operation!='add'&& operation!='edit'}">readonly="readonly"</c:if>>人*</p>
		</td>
		<td class="window-table-td2">
			<p>
				&nbsp;&nbsp;<input class="numberf under" autocomplete="off" id="realityPrintingMoney" name="realityPrintingMoney" value="${meetingBean.realityPrintingMoney}" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="getPrintingMoney()" type="text" <c:if test="${operation!='add'&& operation!='edit'}">readonly="readonly"</c:if>>元/人
   			</p>
		</td>
		<td class="window-table-td1"><p>申请金额：</p></td>
		<td class="window-table-td2">
			<c:if test="${operation!='add'&& operation!='edit'}">
				<%-- <p id="p_printingMoney">${meetingBean.printingMoney}元</p> --%>
				<input class="numberf under" value="${meetingBean.printingMoney}" readonly="readonly" type="text" >元
			</c:if>
			<c:if test="${operation=='add'|| operation=='edit'}">
				<input class="numberf under" id="printingMoney" autocomplete="off" name="printingMoney" value="${meetingBean.printingMoney}" type="text" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="printingMoneyChange()">元
			</c:if>
		</td>
	</tr>
	
	<%-- <tr>
		<td class="window-table-td1"><p>会议场租金</p></td>
		<td class="window-table-td2"></td>
		<td class="window-table-td1"><p>金额：</p></td>
		<td class="window-table-td2">
			<c:if test="${operation!='add'&& operation!='edit'}">
				<p id="p_rentMoney">${meetingBean.rentMoney}元</p>
				<input class="numberf under" value="${meetingBean.rentMoney}" readonly="readonly" type="text" >元
			</c:if>
			<c:if test="${operation=='add'|| operation=='edit'}">
				<input class="numberf under" id="rentMoney" autocomplete="off" name="rentMoney" value="${meetingBean.rentMoney}" type="text" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="getApplyAmount()">元
			</c:if>
		</td>
	</tr> --%>
	
	<%-- <tr>
		<td class="window-table-td1"><p>交通费</p></td>
		<td class="window-table-td2"></td>
		<td class="window-table-td1"><p>金额：</p></td>
		<td class="window-table-td2">
			<c:if test="${operation!='add'&& operation!='edit'}">
				<p id="p_trafficMoney">${meetingBean.trafficMoney}元</p>
				<input class="numberf under" value="${meetingBean.trafficMoney}" readonly="readonly" type="text" >元
			</c:if>
			<c:if test="${operation=='add'|| operation=='edit'}">
				<input class="numberf under" id="trafficMoney" autocomplete="off" name="trafficMoney" value="${meetingBean.trafficMoney}" type="text" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="getApplyAmount()">元
			</c:if>
		</td>
	</tr> --%>
	
	<%-- <tr>
		<td class="window-table-td1"><p>其他</p></td>
		<td class="window-table-td2"></td>
		<td class="window-table-td1"><p>金额：</p></td>
		<td class="window-table-td2">
			<c:if test="${operation!='add'&& operation!='edit'}">
				<p id="p_otherMoney">${meetingBean.otherMoney}元</p>
				<input class="numberf under" value="${meetingBean.otherMoney}" readonly="readonly" type="text" >元
			</c:if>
			<c:if test="${operation=='add'|| operation=='edit'}">
				<input class="numberf under" id="otherMoney" autocomplete="off" name="otherMoney" value="${meetingBean.otherMoney}" type="text" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="getApplyAmount()">元
			</c:if>
		</td>
	</tr> --%>
	
	<tr>
		<td class="window-table-td1" ></td>
		<td class="window-table-td2" ></td>
		<td class="window-table-td1"><p>定额标准：</p></td>
		<td class="window-table-td2">
			<input type="hidden" id="p_otherStd" name="otherStdSingle" />
			<input class="numberf under" id="otherStdUpdate" name="otherStd" type="text" value="${meetingBean.otherStd}" readonly="readonly">元
		</td>
	</tr>
</table>

<script type="text/javascript">
$(function(){
	//其他费用申请金额
	var printingMoneyInit = '${meetingBean.printingMoney}';
	var rentMoneyInit = '${meetingBean.rentMoney}';
	var trafficMoneyInit = '${meetingBean.trafficMoney}';
	var otherMoneyInit = '${meetingBean.otherMoney}';
	var otherAmount = Number(printingMoneyInit) + Number(rentMoneyInit)
		+ Number(trafficMoneyInit) + Number(otherMoneyInit);
	$('#p_otherAllMoney').html(otherAmount.toFixed(2) + "元");
	//定额标准总额
	var stdAmount = Number($('#hotelStdUpdate').val()) + Number($('#foodStdUpdate').val())
		+ Number($('#otherStdUpdate').val());
	$('#stdAmount_span').html(stdAmount.toFixed(2) + "[元]");
	$("input[class^='numberf']").each(function() {
		if($(this).val() != ''){
			var value = Number($(this).val()).toFixed(2);
			$(this).val(value);
		}
	});
});

function getHotelMoney(){
	var duration = Number($('#duration').numberbox('getValue'));//会议天数
	var attendNum = Number($('#attendNum').numberbox('getValue'));//参会人数
	var hotelPersonNum = Number($('#hotelPersonNum').val());
	if (hotelPersonNum !== '') {
		 if(hotelPersonNum>((duration-1)*attendNum)){
			alert('住宿费人·天超出标准，请重新填写！');
			$('#hotelPersonNum').val('');
			return false;
		} 
		//定额标准
		var p_hotelStd = $('#p_hotelStd').val();
		$('#hotelStdUpdate').val(p_hotelStd * hotelPersonNum);
		
	}
	var realityHotelMoney = Number($('#realityHotelMoney').val());
	if(realityHotelMoney == '0'){
		$('#realityHotelMoney').val(p_hotelStd);
		var hotelMoney = hotelPersonNum * p_hotelStd;
		$('#hotelMoney').val(hotelMoney);
		var p_hotelStd = $('#p_hotelStd').val();
		$('#hotelStdUpdate').val(p_hotelStd * hotelPersonNum);
		getApplyAmount();
		return;
	}
	/* if (realityHotelMoney == '') {
		$('#hotelMoney').val('');
		$('#hotelStdUpdate').val('');
		var hMoney = $('#hotelMoney').val();
		if (hMoney != '') {
			$('#realityHotelMoney').val((Number(hMoney)/hotelPersonNum).toFixed(2));
		}
		return;
	} */
	var hotelMoney = hotelPersonNum * realityHotelMoney;
	$('#hotelMoney').val(hotelMoney.toFixed(2));
	getApplyAmount();
}

function getFoodMoney() {
	var duration = Number($('#duration').numberbox('getValue'));//会议天数
	var attendNum = Number($('#attendNum').numberbox('getValue'));//参会人数
	var foodPersonNum = Number($('#foodPersonNum').val());
	if (foodPersonNum !== '') {
		if(foodPersonNum>(duration*attendNum)){
			alert('伙食费人·天超出标准，请重新填写！');
			$('#foodPersonNum').val('');
			return false;
		}
		//定额标准
		var p_foodStd = $('#p_foodStd').val();
		$('#foodStdUpdate').val(p_foodStd * foodPersonNum);
	}
	var realityFoodMoney = Number($('#realityFoodMoney').val());
	/* if(realityFoodMoney>p_foodStd){
		alert('伙食费人·天超出标准，请重新填写！');
		$('#realityFoodMoney').val('');
	} */
	if(realityFoodMoney == '0'){
		$('#realityFoodMoney').val(p_foodStd);
		var p_food= foodPersonNum * p_foodStd;
		$('#foodMoney').val(p_food);
		//$('#foodStdUpdate').val(p_foodStd * foodPersonNum);
		getApplyAmount();
		return;
	}
	/* if (realityFoodMoney == '') {
		$('#foodMoney').val('');
		$('#foodStdUpdate').val('');
		var fMoney = $('#foodMoney').val();
		if (fMoney != '') {
			$('#realityFoodMoney').val((Number(fMoney)/foodPersonNum).toFixed(2));
		}
		return;
	} */
	var foodMoney = foodPersonNum * realityFoodMoney;
	$('#foodMoney').val(foodMoney.toFixed(2));
	getApplyAmount();
}

function getPrintingMoney() {
	var attendNum = Number($('#attendNum').numberbox('getValue'));//参会人数
	var printingPersonNum = Number($('#printingPersonNum').val());
	var realityPrintingMoney = Number($('#realityPrintingMoney').val());
	if(attendNum!=''){
		if(printingPersonNum>attendNum){
			alert('人数不能超出参会人数！');
			$('#printingPersonNum').val('');
			return false;
		}
	}
	var p_otherStd = $('#p_otherStd').val();
	if(realityPrintingMoney == '0'){
		$('#realityPrintingMoney').val(p_otherStd);
		var p_otherStd = printingPersonNum * p_otherStd;
		$('#printingMoney').val(p_otherStd);
		getApplyAmount();
		return;
	}
	/* if (realityPrintingMoney == '') {
		$('#printingMoney').val('');
		var pMoney = $('#printingMoney').val();
		if (pMoney != '' && pMoney != '0') {
			$('#realityPrintingMoney').val((Number(pMoney)/printingPersonNum).toFixed(2));
		}
		getApplyAmount();
		return;
	} */
	var printingMoney = printingPersonNum * realityPrintingMoney;
	$('#printingMoney').val(printingMoney.toFixed(2));
	getApplyAmount();
}

function getApplyAmount(){
	//其他费用申请金额
	var otherAmount = Number($('#printingMoney').val());
	// + Number($('#rentMoney').val())
	//	+ Number($('#trafficMoney').val()) + Number($('#otherMoney').val())
	$('#p_otherAllMoney').html(otherAmount.toFixed(2) + "元");
	//申请总额
	var applyAmount = Number($('#hotelMoney').val()) + Number($('#foodMoney').val())
		+ Number($('#printingMoney').val());
	// + Number($('#rentMoney').val())
	//	+ Number($('#trafficMoney').val()) + Number($('#otherMoney').val())
	$('#applyAmount_span').html(applyAmount.toFixed(2) + "[元]");
	$('#applyAmount').val(applyAmount.toFixed(2));
	//其他费用标准总额
	var p_otherStd = $('#p_otherStd').val();
	//var duration = $('#duration').numberbox("getValue");
	var printingPersonNum = Number($('#printingPersonNum').val());
	//var attendNum = $('#attendNum').numberbox("getValue");
	var realityPrintingMoney = Number($('#realityPrintingMoney').val());
	/* if(realityPrintingMoney>p_otherStd){
		alert('其他费用人·天超出标准，请重新填写！');
		$('#realityPrintingMoney').val('');
	} */
	var p_otherAllMoney = $('#p_otherAllMoney').html();
	if(p_otherAllMoney != '' && p_otherAllMoney != '0.00元' && duration != '' ){
		$('#otherStdUpdate').val(p_otherStd * printingPersonNum);
	}else{
		$('#otherStdUpdate').val('');
	}
	//定额标准总额
	var stdAmount = Number($('#hotelStdUpdate').val()) + Number($('#foodStdUpdate').val())
		+ Number($('#otherStdUpdate').val());
	$('#stdAmount_span').html(stdAmount.toFixed(2) + "[元]");
}

function printingMoneyChange(){
	var printingPersonNum = $('#printingPersonNum').val();
	if (printingPersonNum == '' || printingPersonNum == '0') {
		return;
	}
	var printingMoney = Number($('#printingMoney').val());
	printingPersonNum = Number(printingPersonNum);
	$('#realityPrintingMoney').val((printingMoney/printingPersonNum).toFixed(2));
	getApplyAmount();
}

function hotelMoneyChange(){
	var hotelPersonNum = $('#hotelPersonNum').val();
	if (hotelPersonNum == '' || hotelPersonNum == '0') {
		return;
	}
	var hotelMoney = Number($('#hotelMoney').val());
	hotelPersonNum = Number(hotelPersonNum);
	$('#realityHotelMoney').val((hotelMoney/hotelPersonNum).toFixed(2));
	//定额标准
	var p_hotelStd = $('#p_hotelStd').val();
	$('#hotelStdUpdate').val(p_hotelStd * hotelPersonNum);
	getApplyAmount();
}

function foodMoneyChange(){
	var foodPersonNum = $('#foodPersonNum').val();
	if (foodPersonNum == '' || foodPersonNum == '0') {
		return;
	}
	var foodMoney = Number($('#foodMoney').val());
	foodPersonNum = Number(foodPersonNum);
	$('#realityFoodMoney').val((foodMoney/foodPersonNum).toFixed(2));
	//定额标准
	var p_foodStd = $('#p_foodStd').val();
	$('#foodStdUpdate').val(p_foodStd * foodPersonNum);
	getApplyAmount();
}
</script>