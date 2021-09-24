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
			<td class="window-table-td1" style=" font-weight:bold"><p>住宿费</p></td>
			<td class="window-table-td2"></td>
			<td class="window-table-td1">
				<p><input class="under" id="hotelPersonNum" name="hotelPersonNum" value="${reimbMeetingBean.hotelPersonNum}" onkeyup="value=this.value.replace(/\D+/g,'')" onchange="getHotelMoney()" type="text" >人·天*</p>
			</td>
			<td class="window-table-td2">
				<p>
					&nbsp;&nbsp;<input class="numberf under" id="realityHotelMoney" name="realityHotelMoney" value="${reimbMeetingBean.realityHotelMoney}" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="getHotelMoney()" type="text" >元/人·天
	   			</p>
			</td>
			
		</tr>
		<tr>
			<td class="window-table-td1"></td>
			<td class="window-table-td1"></td>
			<td class="window-table-td1"><p>报销金额：</p></td>
			<td class="window-table-td2">
				<c:if test="${operation!='add'&& operation!='edit'}">
					<%-- <p id="p_hotelMoney">${reimbMeetingBean.hotelMoney}元</p> --%>
					<input class="numberf under" value="${reimbMeetingBean.hotelMoney}" readonly="readonly" type="text">元
				</c:if>
				<c:if test="${operation=='add'|| operation=='edit'}">
					<input class="numberf under" id="hotelMoney" name="hotelMoney" value="${reimbMeetingBean.hotelMoney}" type="text" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="hotelMoneyChange()">元
				</c:if>
			</td>
		</tr>
		<tr>
			<td class="window-table-td1" ></td>
			<td class="window-table-td2" ></td>
			<td class="window-table-td1"><p>定额标准：</p></td>
			<td class="window-table-td2">
				<input class="numberf under" id="hotelStdUpdate" name="hotelStd" type="text" value="${reimbMeetingBean.hotelStd }" readonly="readonly">元
				<input type="hidden" id="p_hotelStd" name="hotelStdSingle"/>
			</td>
		</tr>
	</table>		
	<div style="height:10px;"></div>
	<table class="window-table-readonly" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1" style=" font-weight:bold"><p>伙食费</p></td>
			<td class="window-table-td2"></td>
			<td class="window-table-td1">
				<p><input class="under" id="foodPersonNum" name="foodPersonNum" value="${reimbMeetingBean.foodPersonNum}" onkeyup="value=this.value.replace(/\D+/g,'')" onchange="getFoodMoney()" type="text" <c:if test="${operation!='add'&& operation!='edit'}">readonly="readonly"</c:if>>人·天*</p>
			</td>
			<td class="window-table-td2">
				<p>
					&nbsp;&nbsp;<input class="numberf under" id="realityFoodMoney" name="realityFoodMoney" value="${reimbMeetingBean.realityFoodMoney}" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="getFoodMoney()" type="text" <c:if test="${operation!='add'&& operation!='edit'}">readonly="readonly"</c:if>>元/人·天
	   			</p>
			</td>
		</tr>
		<tr>
			<td class="window-table-td1"></td>
			<td class="window-table-td1"></td>
			
			<td class="window-table-td1"><p>报销金额：</p></td>
			<td class="window-table-td2">
				<c:if test="${operation!='add'&& operation!='edit'}">
					<%-- <p id="p_foodMoney">${reimbMeetingBean.foodMoney}元</p> --%>
					<input class="numberf under" value="${reimbMeetingBean.foodMoney}" readonly="readonly" type="text">元
				</c:if>
				<c:if test="${operation=='add'|| operation=='edit'}">
					<input class="numberf under" id="foodMoney" name="foodMoney" value="${reimbMeetingBean.foodMoney}" type="text" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="foodMoneyChange()">元
				</c:if>
			</td>
		</tr>
		<tr>
			<td class="window-table-td1" ></td>
			<td class="window-table-td2" ></td>
			<td class="window-table-td1"><p>定额标准：</p></td>
			<td class="window-table-td2">
				<input class="numberf under" id="foodStdUpdate" name="foodStd" type="text" value="${reimbMeetingBean.foodStd}" readonly="readonly">元
				<input type="hidden" id="p_foodStd" name="foodStdSingle"/>
			</td>
		</tr>
	</table>
	
	<div style="height:10px;"></div>
	<table class="window-table-readonly" cellspacing="0" cellpadding="0">
		<tr>
			<!-- <td class="window-table-td1" style=" font-weight:bold"><p>其他费用</p></td>
			<td class="window-table-td2"></td> -->
			<!-- <td class="window-table-td1"><p>报销金额：</p></td>
			<td class="window-table-td2">
				<p id="p_otherAllMoney">元</p>
			</td> -->
		</tr>
		 <tr>
			<td class="window-table-td1" style=" font-weight:bold"><p>其他费用</p></td> 
			<td class="window-table-td2"></td>
			<td class="window-table-td1">
				<p><input class="under" id="printingPersonNum" name="printingPersonNum" value="${reimbMeetingBean.printingPersonNum}" onkeyup="value=this.value.replace(/\D+/g,'')" onchange="getPrintingMoney()" type="text" <c:if test="${operation!='add'&& operation!='edit'}">readonly="readonly"</c:if>>人*</p>
			</td>
			<td class="window-table-td2">
				<p>
					&nbsp;&nbsp;<input class="numberf under" id="realityPrintingMoney" name="realityPrintingMoney" value="${reimbMeetingBean.realityPrintingMoney}" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="getPrintingMoney()" type="text" <c:if test="${operation!='add'&& operation!='edit'}">readonly="readonly"</c:if>>元/人
	   			</p>
			</td>
		</tr> 
		<tr>
			<td class="window-table-td1"></td>
			<td class="window-table-td1"></td>
			
			<td class="window-table-td1"><p>金额：</p></td>
			<td class="window-table-td2">
				<c:if test="${operation!='add'&& operation!='edit'}">
					<%-- <p id="p_printingMoney">${reimbMeetingBean.printingMoney}元</p> --%>
					<input class="numberf under" value="${reimbMeetingBean.printingMoney}" readonly="readonly" type="text" >元
				</c:if>
				<c:if test="${operation=='add'|| operation=='edit'}">
					<input class="numberf under" id="printingMoney" name="printingMoney" value="${reimbMeetingBean.printingMoney}" type="text" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="printingMoneyChange()">元
				</c:if>
			</td>
		</tr>
		
		<%-- <tr>
			<td class="window-table-td1" style=" font-weight:bold"><p>会议场租金</p></td>
			<td class="window-table-td2"></td>
			<td class="window-table-td1"><p>金额：</p></td>
			<td class="window-table-td2">
				<c:if test="${operation!='add'&& operation!='edit'}">
					<p id="p_rentMoney">${reimbMeetingBean.rentMoney}元</p>
					<input class="numberf under" value="${reimbMeetingBean.rentMoney}" readonly="readonly" type="text" >元
				</c:if>
				<c:if test="${operation=='add'|| operation=='edit'}">
					<input class="numberf under" id="rentMoney" name="rentMoney" value="${reimbMeetingBean.rentMoney}" type="text" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="getApplyAmount()">元
				</c:if>
			</td>
		</tr> --%>
		
		<%-- <tr>
			<td class="window-table-td1" style=" font-weight:bold"><p>交通费</p></td>
			<td class="window-table-td2"></td>
			<td class="window-table-td1"><p>金额：</p></td>
			<td class="window-table-td2">
				<c:if test="${operation!='add'&& operation!='edit'}">
					<p id="p_trafficMoney">${reimbMeetingBean.trafficMoney}元</p>
					<input class="numberf under" value="${reimbMeetingBean.trafficMoney}" readonly="readonly" type="text" >元
				</c:if>
				<c:if test="${operation=='add'|| operation=='edit'}">
					<input class="numberf under" id="trafficMoney" name="trafficMoney" value="${reimbMeetingBean.trafficMoney}" type="text" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="getApplyAmount()">元
				</c:if>
			</td>
		</tr> --%>
		
		<%-- <tr>
			<td class="window-table-td1" style=" font-weight:bold"><p>其他</p></td>
			<td class="window-table-td2"></td>
			<td class="window-table-td1"><p>金额：</p></td>
			<td class="window-table-td2">
				<c:if test="${operation!='add'&& operation!='edit'}">
					<p id="p_otherMoney">${reimbMeetingBean.otherMoney}元</p>
					<input class="numberf under" value="${reimbMeetingBean.otherMoney}" readonly="readonly" type="text" >元
				</c:if>
				<c:if test="${operation=='add'|| operation=='edit'}">
					<input class="numberf under" id="otherMoney" name="otherMoney" value="${reimbMeetingBean.otherMoney}" type="text" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')" onchange="getApplyAmount()">元
				</c:if>
			</td>
		</tr> --%>
		
		<tr>
			<td class="window-table-td1" ></td>
			<td class="window-table-td2" ></td>
			<td class="window-table-td1"><p>定额标准：</p></td>
			<td class="window-table-td2">
				<input type="hidden" id="p_otherStd" name="otherStdSingle" />
				<input class="numberf under" id="otherStdUpdate" name="otherStd" type="text" value="${reimbMeetingBean.otherStd}" readonly="readonly">元
			</td>
		</tr>
	</table>
</div>

<script type="text/javascript">
$(function(){
	var fupdateStatus = $(':radio[name="fupdateStatus"]:checked').val();
	var operationType = '${operation}';
	if(fupdateStatus == 1 && (operationType == 'add' || operationType == 'edit')){
		$('#hotelPersonNum').attr("readOnly",false);
		$('#realityHotelMoney').attr("readOnly",false);
		$('#hotelMoney').attr("readOnly",false);
		$('#foodPersonNum').attr("readOnly",false);
		$('#realityFoodMoney').attr("readOnly",false);
		$('#foodMoney').attr("readOnly",false);
		$('#printingPersonNum').attr("readOnly",false);
		$('#realityPrintingMoney').attr("readOnly",false);
		$('#printingMoney').attr("readOnly",false);
		$('#rentMoney').attr("readOnly",false);
		$('#trafficMoney').attr("readOnly",false);
		$('#otherMoney').attr("readOnly",false);
	}else{
		//$('#hotelPersonNum').attr("readOnly","true");
		//$('#realityHotelMoney').attr("readOnly","true");
		$('#hotelMoney').attr("readOnly","true");
		//$('#foodPersonNum').attr("readOnly","true");
		//$('#realityFoodMoney').attr("readOnly","true");
		$('#foodMoney').attr("readOnly","true");
		//$('#printingPersonNum').attr("readOnly","true");
		//$('#realityPrintingMoney').attr("readOnly","true");
		$('#printingMoney').attr("readOnly","true");
		$('#rentMoney').attr("readOnly","true");
		$('#trafficMoney').attr("readOnly","true");
		$('#otherMoney').attr("readOnly","true");
	}
	
	getApplyAmount(1);
	
	var printingMoneyInit = '${reimbMeetingBean.printingMoney}';
	var rentMoneyInit = '${reimbMeetingBean.rentMoney}';
	var trafficMoneyInit = '${reimbMeetingBean.trafficMoney}';
	var otherMoneyInit = '${reimbMeetingBean.otherMoney}';
	var otherStd = '${reimbMeetingBean.otherStd}';
	var otherAmount = Number(printingMoneyInit) + Number(rentMoneyInit)
		+ Number(trafficMoneyInit) + Number(otherMoneyInit);
	$('#p_otherAllMoney').html(otherAmount.toFixed(2) + "元");
	//定额标准总额
	var stdAmount = Number($('#hotelStdUpdate').val()) + Number($('#foodStdUpdate').val())
		+ Number(otherStd);
	$('#stdAmount_span').html(stdAmount.toFixed(2) + "[元]");
	
	$("input[class^='numberf']").each(function() {
		if($(this).val() != ''){
			var value = Number($(this).val()).toFixed(2)
			$(this).val(value)
		}
	});
});

//计算申请总额
function addNum(newValue,oldValue) {
		var row = $('#reimb-meeting-mingxi').datagrid('getSelected');//获得选择行
		var index=$('#reimb-meeting-mingxi').datagrid('getRowIndex',row);//获得选中行的行号
		var tr = $('#reimb-meeting-mingxi').datagrid('getEditors', index);
		var standar= parseFloat(row.totalStandard);//获得选中行的开支标准
		if(isNaN(standar)){
			standar=0;
		}
		/* if(parseFloat(newValue)>parseFloat(standar)){
			
			alert('报销金额不能大于开支标准，请核对！');
			tr[0].target.numberbox('setValue',0);
			newValue=0;
		} */
		
		var num = 0;
		var rows = $('#reimb-meeting-mingxi').datagrid('getRows');
		for(var i=0;i<rows.length;i++){
			if(i!=index){
				if(rows[i].remibAmount!=""&&rows[i].remibAmount!=null){
					num += parseFloat(rows[i].remibAmount);
				}
			}
		}
		if(newValue!=""&&newValue!=null) {
			num += parseFloat(newValue);
		}
		$('#reimburseAmount').val(num.toFixed(2));
		$('#reimbAmount_span').html(fomatMoney(num,2));
		$('#p_amount').html(fomatMoney(num,2)+"[元]");
				cx();
}

function getHotelMoney() {
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
	if (realityHotelMoney == '') {
		$('#hotelMoney').val('');
		$('#hotelStdUpdate').val('');
		var hMoney = $('#hotelMoney').val();
		if (hMoney != '') {
			$('#realityHotelMoney').val((Number(hMoney)/hotelPersonNum).toFixed(2));
		}
		return;
	}
	var hotelMoney = hotelPersonNum * realityHotelMoney;
	$('#hotelMoney').val(hotelMoney.toFixed(2));
	getApplyAmount(2);
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
	if (realityFoodMoney == ''){
		$('#foodMoney').val('');
		$('#foodStdUpdate').val('');
		var fMoney = $('#foodMoney').val();
		if (fMoney != '') {
			$('#realityFoodMoney').val((Number(fMoney)/foodPersonNum).toFixed(2));
		}
		return;
	}
	var foodMoney = foodPersonNum * realityFoodMoney;
	$('#foodMoney').val(foodMoney.toFixed(2));
	getApplyAmount(2);
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
	if (realityPrintingMoney == '') {
		$('#printingMoney').val('');
		var pMoney = $('#printingMoney').val();
		if (pMoney != ''  && pMoney != '0') {
			$('#realityPrintingMoney').val((Number(pMoney)/printingPersonNum).toFixed(2));
		}
		getApplyAmount(2);
		return;
	}
	var printingMoney = printingPersonNum * realityPrintingMoney;
	$('#printingMoney').val(printingMoney.toFixed(2));
	getApplyAmount(2);
}

function getApplyAmount(type) {
	//其他费用申请金额
	var otherAmount = Number($('#printingMoney').val()) + Number($('#rentMoney').val())
		+ Number($('#trafficMoney').val()) + Number($('#otherMoney').val());
	$('#p_otherAllMoney').html(otherAmount.toFixed(2) + "元");
	//申请总额
	var applyAmount = Number($('#hotelMoney').val()) + Number($('#foodMoney').val())
		+ Number($('#printingMoney').val());
	// + Number($('#rentMoney').val())
	//	+ Number($('#trafficMoney').val()) + Number($('#otherMoney').val())
	$('#reimburseAmount').val(applyAmount.toFixed(2));
	$('#reimbAmount_span').html(fomatMoney(applyAmount,2)+"[元]");
	$('#p_amount').html(fomatMoney(applyAmount,2)+"[元]");
	//其他费用标准总额
	var p_otherStd = $('#p_otherStd').val();
	var printingPersonNum = $('#printingPersonNum').val();
	var duration = $('#duration').numberbox("getValue");
	var attendNum = $('#attendNum').numberbox("getValue");
	var p_otherAllMoney = $('#p_otherAllMoney').html();
	if(p_otherAllMoney != '' && p_otherAllMoney != '0.00元' && duration != '' && attendNum != '' ){
		$('#otherStdUpdate').val(p_otherStd * printingPersonNum);
	}else{
		$('#otherStdUpdate').val('');
	}
	//定额标准总额
	var stdAmount = Number($('#hotelStdUpdate').val()) + Number($('#foodStdUpdate').val())
		+ Number($('#otherStdUpdate').val());
	$('#reimbStdAmount_span').html(stdAmount.toFixed(2) + "[元]");
	
	if (type != 1) {
		cx();
	}
}

function printingMoneyChange(){
	var printingPersonNum = $('#printingPersonNum').val();
	if (printingPersonNum == '' || printingPersonNum == '0') {
		return;
	}
	var printingMoney = Number($('#printingMoney').val());
	printingPersonNum = Number(printingPersonNum);
	$('#realityPrintingMoney').val((printingMoney/printingPersonNum).toFixed(2));
	getApplyAmount(2);
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
	getApplyAmount(2);
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
	getApplyAmount(2);
}
</script>
