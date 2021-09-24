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
.window-table-readonly{
	margin-left: 5px;
	width: 680px;
}
</style>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table class="window-table-readonly" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1"><p>住宿费</p></td>
			<td class="window-table-td2"></td>
			<td class="window-table-td1"></td>
			<td class="window-table-td2"></td>
		</tr>
		<tr>
			<td class="window-table-td1">
				<p><input class="under" value="${meetingBean.hotelPersonNum}" onkeyup="value=this.value.replace(/\D+/g,'')" onchange="getHotelMoney()" type="text" readonly="readonly">人·天*</p>
			</td>
			<td class="window-table-td2">
				<p>
					&nbsp;&nbsp;<input class="numberf under" value="${meetingBean.realityHotelMoney}" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="getHotelMoney()" type="text" readonly="readonly">元/人·天
	   			</p>
			</td>
			<td class="window-table-td1"><p>申请金额：</p></td>
			<td class="window-table-td2">
				<c:if test="${operation!='add'&& operation!='edit'}">
					<%-- <p>${meetingBean.hotelMoney}元</p> --%>
					<input class="numberf under" value="${meetingBean.hotelMoney}" readonly="readonly" type="text">元
				</c:if>
				<c:if test="${operation=='add'|| operation=='edit'}">
					<input class="numberf under" value="${meetingBean.hotelMoney}" type="text" readonly="readonly" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="hotelMoneyChange()">元
				</c:if>
			</td>
		</tr>
		<tr>
			<td class="window-table-td1" ></td>
			<td class="window-table-td2" ></td>
			<td class="window-table-td1"><p>定额标准：</p></td>
			<td class="window-table-td2">
				<input class="numberf under" type="text" value="${meetingBean.hotelStd }" readonly="readonly">元
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
				<p><input class="under" value="${meetingBean.foodPersonNum}" onkeyup="value=this.value.replace(/\D+/g,'')" onchange="getFoodMoney()" type="text" readonly="readonly">人·天*</p>
			</td>
			<td class="window-table-td2">
				<p>
					&nbsp;&nbsp;<input class="numberf under" value="${meetingBean.realityFoodMoney}" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="getFoodMoney()" type="text" readonly="readonly">元/人·天
	   			</p>
			</td>
			<td class="window-table-td1"><p>申请金额：</p></td>
			<td class="window-table-td2">
				<c:if test="${operation!='add'&& operation!='edit'}">
					<%-- <p>${meetingBean.foodMoney}元</p> --%>
					<input class="numberf under" value="${meetingBean.foodMoney}" readonly="readonly" type="text">元
				</c:if>
				<c:if test="${operation=='add'|| operation=='edit'}">
					<input class="numberf under" value="${meetingBean.foodMoney}" type="text" readonly="readonly" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="foodMoneyChange()">元
				</c:if>
			</td>
		</tr>
		<tr>
			<td class="window-table-td1" ></td>
			<td class="window-table-td2" ></td>
			<td class="window-table-td1"><p>定额标准：</p></td>
			<td class="window-table-td2">
				<input class="numberf under" type="text" value="${meetingBean.foodStd}" readonly="readonly">元
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
				<p id="p_otherAllMoneyApply">元</p>
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
				<p><input class="under" value="${meetingBean.printingPersonNum}" onkeyup="value=this.value.replace(/\D+/g,'')" onchange="getPrintingMoney()" type="text" readonly="readonly">人*</p>
			</td>
			<td class="window-table-td2">
				<p>
					&nbsp;&nbsp;<input class="numberf under" value="${meetingBean.realityPrintingMoney}" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="getPrintingMoney()" type="text" readonly="readonly">元/人
	   			</p>
			</td>
			<td class="window-table-td1"><p>申请金额：</p></td>
			<td class="window-table-td2">
				<c:if test="${operation!='add'&& operation!='edit'}">
					<%-- <p>${meetingBean.printingMoney}元</p> --%>
					<input class="numberf under" value="${meetingBean.printingMoney}" readonly="readonly" type="text" >元
				</c:if>
				<c:if test="${operation=='add'|| operation=='edit'}">
					<input class="numberf under" value="${meetingBean.printingMoney}" type="text" readonly="readonly" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="printingMoneyChange()">元
				</c:if>
			</td>
		</tr>
		
		<%-- <tr>
			<td class="window-table-td1"><p>会议场租金</p></td>
			<td class="window-table-td2"></td>
			<td class="window-table-td1"><p>金额：</p></td>
			<td class="window-table-td2">
				<c:if test="${operation!='add'&& operation!='edit'}">
					<p>${meetingBean.rentMoney}元</p>
					<input class="numberf under" value="${meetingBean.rentMoney}" readonly="readonly" type="text" >元
				</c:if>
				<c:if test="${operation=='add'|| operation=='edit'}">
					<input class="numberf under" value="${meetingBean.rentMoney}" type="text" readonly="readonly" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="getApplyAmount()">元
				</c:if>
			</td>
		</tr> --%>
		
		<%-- <tr>
			<td class="window-table-td1"><p>交通费</p></td>
			<td class="window-table-td2"></td>
			<td class="window-table-td1"><p>金额：</p></td>
			<td class="window-table-td2">
				<c:if test="${operation!='add'&& operation!='edit'}">
					<p>${meetingBean.trafficMoney}元</p>
					<input class="numberf under" value="${meetingBean.trafficMoney}" readonly="readonly" type="text" >元
				</c:if>
				<c:if test="${operation=='add'|| operation=='edit'}">
					<input class="numberf under" value="${meetingBean.trafficMoney}" type="text" readonly="readonly" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="getApplyAmount()">元
				</c:if>
			</td>
		</tr> --%>
		
		<%-- <tr>
			<td class="window-table-td1"><p>其他</p></td>
			<td class="window-table-td2"></td>
			<td class="window-table-td1"><p>金额：</p></td>
			<td class="window-table-td2">
				<c:if test="${operation!='add'&& operation!='edit'}">
					<p>${meetingBean.otherMoney}元</p>
					<input class="numberf under" value="${meetingBean.otherMoney}" readonly="readonly" type="text" >元
				</c:if>
				<c:if test="${operation=='add'|| operation=='edit'}">
					<input class="numberf under" value="${meetingBean.otherMoney}" type="text" readonly="readonly" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="getApplyAmount()">元
				</c:if>
			</td>
		</tr> --%>
		
		<tr>
			<td class="window-table-td1" ></td>
			<td class="window-table-td2" ></td>
			<td class="window-table-td1"><p>定额标准：</p></td>
			<td class="window-table-td2">
				<input class="numberf under" type="text" value="${meetingBean.otherStd}" readonly="readonly">元
			</td>
		</tr>
	</table>
</div>

<script type="text/javascript">
	var printingMoneyApplyInit = '${meetingBean.printingMoney}';
	var rentMoneyApplyInit = '${meetingBean.rentMoney}';
	var trafficMoneyApplyInit = '${meetingBean.trafficMoney}';
	var otherMoneyApplyInit = '${meetingBean.otherMoney}';
	var otherStd = '${meetingBean.otherStd}';
	var otherAmountApply = Number(printingMoneyApplyInit) + Number(rentMoneyApplyInit)
		+ Number(trafficMoneyApplyInit) + Number(otherMoneyApplyInit);
	$('#p_otherAllMoneyApply').html(otherAmountApply.toFixed(2) + "元");
	//定额标准总额
	var stdAmount = Number($('#hotelStdUpdate').val()) + Number($('#foodStdUpdate').val())
		+ Number(otherStd);
	$('#stdReimAmount_span').html(stdAmount.toFixed(2) + "[元]");
	
	$("input[class^='numberf']").each(function() {
		if($(this).val() != ''){
			var value = Number($(this).val()).toFixed(2)
			$(this).val(value)
		}
	});
</script>
