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
</style>
	<div id="lessons_Id" style="height:30px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">综合预算</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
	</div>
<table class="window-table-readonly-zc-pxAndHy" cellspacing="0" cellpadding="0">
	<tr>
		<td class="window-table-td1" style="font-weight:bold;width:20%;"  ><span style="color: red"></span>住宿费</td>
		<td class="window-table-td2" style="width:27%;">
			<p style=" color:#0000CD;"></p>
		</td>
		<td class="window-table-td1" style="width: 129px;"></td>
		<td class="window-table-td2">
		</td>
	</tr>
	<tr>
		<td class="window-table-td1" colspan="2" style="padding-left: 50px;">
			<input class="under" id="hotelPersonNum" autocomplete="off" onchange="hotelPersonNumOnChanges(this.value)" onkeyup="value=this.value.replace(/\D+/g,'')"
				 <c:if test="${operation=='add'}"> value="${trainingBean.hotelPersonNum}"</c:if>
				 <c:if test="${operation!='add'}"> value="${reimbTrainingBean.hotelPersonNum}"</c:if>
			  	 <c:if test="${operation!='add'&& operation!='edit'}"> readonly="readonly"</c:if>
				  type="text">人·天
				<input class="under" id="realityHotelMoney" autocomplete="off" onchange="realityHotelMoneyOnChanges(this.value)" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"
				 <c:if test="${operation=='add'}"> value="${trainingBean.realityHotelMoney}"</c:if>
				 <c:if test="${operation!='add'}"> value="${reimbTrainingBean.realityHotelMoney}"</c:if>
			  	 <c:if test="${operation!='add'&& operation!='edit'}"> readonly="readonly"</c:if>
				  type="text">元/人·天
		</td>
		<td class="window-table-td1"><p>报销金额：</p></td>
		<td class="td2">
			<input id="hotelMoney" onchange="hotelMoneyOnChanges(this.value)"
			 <c:if test="${operation=='add'}"> value="${trainingBean.hotelMoney}"</c:if>
			 <c:if test="${operation!='add'}"> value="${reimbTrainingBean.hotelMoney}"</c:if>
			 class="easyui-numberbox" style="height:25px;" data-options="icons: [{iconCls:'icon-yuan'}],precision:2"
			  <c:if test="${operation!='add'&& operation!='edit'}"> readonly="readonly"</c:if>>
		</td>
	</tr>
	<tr>
		<td class="window-table-td1" style="width:15%"></td>
		<td class="window-table-td2" style="width:27%">
		</td>
		<td class="window-table-td1"><p>定额标准：</p></td>
		<td class="td2">
			<input class="under" id="hotelStds" 
			 <c:if test="${operation=='add'}"> value="${trainingBean.hotelStd}"</c:if>
			 <c:if test="${operation!='add'}"> value="${reimbTrainingBean.hotelStd}"</c:if>
			  readonly="readonly" type="text">元
		</td>
	</tr>
</table>		
<div style="height:10px;"></div>
<table class="window-table-readonly-zc-pxAndHy" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1" style="width:20%;font-weight:bold;"><span style="color: red"></span>伙食费</td>
			<td class="window-table-td2" style="width:27%">
				<p style=" color:#0000CD;"></p>
			</td>
			<td class="window-table-td1" colspan="2">
			</td>
		</tr>
		<tr>
			<td class="window-table-td1" colspan="2" style="padding-left: 50px;">
			<input class="under" id="foodPersonNum" autocomplete="off" onchange="foodPersonNumOnChanges(this.value)" onkeyup="value=this.value.replace(/\D+/g,'')"
					<c:if test="${operation=='add'}"> value="${trainingBean.foodPersonNum}"</c:if>
			 		<c:if test="${operation!='add'}"> value="${reimbTrainingBean.foodPersonNum}"</c:if>
			  <c:if test="${operation!='add'&& operation!='edit'}"> readonly="readonly"</c:if>
					 type="text">人·天
					<input class="under" id="realityFoodMoney" autocomplete="off" onchange="realityFoodMoneyOnChanges(this.value)" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"
					<c:if test="${operation=='add'}"> value="${trainingBean.realityFoodMoney}"</c:if>
			 		<c:if test="${operation!='add'}"> value="${reimbTrainingBean.realityFoodMoney}"</c:if>
			  <c:if test="${operation!='add'&& operation!='edit'}"> readonly="readonly"</c:if>
					 type="text">元/人·天
			</td>
			<td class="window-table-td1"><p>报销金额：</p></td>
			<td class="td2">
			<input class="easyui-numberbox" style="height:25px;" data-options="icons: [{iconCls:'icon-yuan'}],precision:2" 
				id="foodMoney" onchange="foodMoneyOnChanges(this.value)"
					<c:if test="${operation=='add'}"> value="${trainingBean.foodMoney}"</c:if>
			 		<c:if test="${operation!='add'}"> value="${reimbTrainingBean.foodMoney}"</c:if>
					<c:if test="${operation!='add'&& operation!='edit'}"> readonly="readonly"</c:if>>
			</td>
			</tr>
			<tr>
			<td class="window-table-td1" style="width:15%"></td>
			<td class="window-table-td2" style="width:27%">
			</td>
			<td class="window-table-td1"><p>定额标准：</p></td>
			<td class="td2">
				<input class="under" id="foodStds" 
					<c:if test="${operation=='add'}"> value="${trainingBean.foodStd}"</c:if>
			 		<c:if test="${operation!='add'}"> value="${reimbTrainingBean.foodStd}"</c:if>
					 readonly="readonly" type="text">元
			</td>
	</tr>
</table>
<div style="height:10px;"></div>
<table class="window-table-readonly-zc-pxAndHy" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1" style="width:20%;font-weight:bold;"><span style="color: red"></span>资料、场地、交通费</td>
			<td class="window-table-td2" style="width:27%">
				<p style=" color:#0000CD;"></p>
			</td>
			<td class="window-table-td1"><p></p></td>
			<td class="td2" hidden="hidden">
				<input id="costThreeTermsMoney" class="easyui-numberbox" readonly="readonly" data-options="icons: [{iconCls:'icon-yuan'}],precision:2"
				 onchange="costThreeTermsMoneyOnChanges(this.value)"
				<c:if test="${operation=='add'}"> value="${trainingBean.costThreeTermsMoney}"</c:if>
		 		<c:if test="${operation!='add'}"> value="${reimbTrainingBean.costThreeTermsMoney}"</c:if>
			    <c:if test="${operation!='add'&& operation!='edit'}"> readonly="readonly"</c:if>
				style="height:25px;"/>
			</td>
		</tr>
		<tr>
			<td class="window-table-td1" colspan="2" style="padding-left: 50px;">
				<input class="under" id="dataPersonNum" autocomplete="off" onchange="dataPersonNumOnChanges(this.value)" onkeyup="value=this.value.replace(/\D+/g,'')"
					<c:if test="${operation=='add'}"> value="${trainingBean.dataPersonNum}"</c:if>
			 		<c:if test="${operation!='add'}"> value="${reimbTrainingBean.dataPersonNum}"</c:if>
			  		<c:if test="${operation!='add'&& operation!='edit'}"> readonly="readonly"</c:if>
					 type="text">人*
					<input class="under" id="realityDataMoney" autocomplete="off" onchange="realityDataMoneyOnChanges(this.value)" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"
					<c:if test="${operation=='add'}"> value="${trainingBean.realityDataMoney}"</c:if>
			 		<c:if test="${operation!='add'}"> value="${reimbTrainingBean.realityDataMoney}"</c:if>
			  		<c:if test="${operation!='add'&& operation!='edit'}"> readonly="readonly"</c:if>
					 type="text">元/人
			</td>

			<td class="window-table-td1"><p>报销金额：</p></td>
			<td class="td2">
				<input id="dataMoney" class="easyui-numberbox" 
					<c:if test="${operation=='add'}"> value="${trainingBean.dataMoney}"</c:if>
			 		<c:if test="${operation!='add'}"> value="${reimbTrainingBean.dataMoney}"</c:if>
					 data-options="icons: [{iconCls:'icon-yuan'}],precision:2"
				<c:if test="${operation!='add'&& operation!='edit'}">
				readonly="readonly"
				</c:if>
				style="height:25px;"/>
			</td>
		</tr>
		<tr hidden="hidden">
			<td class="window-table-td1" style="padding-left: 30px;font-weight:bold;" colspan="2"><span style="color: red;"></span>培训场地费</td>
			<td class="window-table-td1"><p>金额：</p></td>
			<td class="td2">
				<input id="spaceMoney" class="easyui-numberbox" data-options="icons: [{iconCls:'icon-yuan'}],precision:2"
				<c:if test="${operation=='add'}"> value="${trainingBean.spaceMoney}"</c:if>
		 		<c:if test="${operation!='add'}"> value="${reimbTrainingBean.spaceMoney}"</c:if>
					data-options="icons: [{iconCls:'icon-yuan'}],precision:2"
		  		<c:if test="${operation!='add'&& operation!='edit'}"> readonly="readonly"</c:if>
				style="height:25px;"/>
			</td>
		</tr>
		<tr hidden="hidden">
			<td class="window-table-td1" style="padding-left: 30px;font-weight:bold;" colspan="2"><span style="color: red;"></span>交通费</td>
			<td class="window-table-td1"><p>金额：</p></td>
			<td class="td2">
				<input id="transportMoney" class="easyui-numberbox" name="transportMoney" data-options="icons: [{iconCls:'icon-yuan'}],precision:2"
				<c:if test="${operation=='add'}"> value="${trainingBean.transportMoney}"</c:if>
		 		<c:if test="${operation!='add'}"> value="${reimbTrainingBean.transportMoney}"</c:if>
				data-options="icons: [{iconCls:'icon-yuan'}],precision:2"
		 		<c:if test="${operation!='add'&& operation!='edit'}"> readonly="readonly"</c:if>
				style="height:25px;"/>
			</td>
		</tr>
		<tr>
			<td class="window-table-td1" style="width:15%"></td>
			<td class="window-table-td2" style="width:27%">
			</td>
			<td class="window-table-td1"><p>定额标准：</p></td>
			<td class="td2">
				<input class="under" id="zongheStds" onchange="costThreeTermsStdOnChanges(this.value)"
				<c:if test="${operation=='add'}"> value="${trainingBean.costThreeTermsStd}"</c:if>
		 		<c:if test="${operation!='add'}"> value="${reimbTrainingBean.costThreeTermsStd}"</c:if>
		 		readonly="readonly" type="text">元
			</td>
		</tr>
</table>		
<div style="height:10px;"></div>
<table class="window-table-readonly-zc-pxAndHy" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1" style="width:20%;font-weight:bold;"><span style="color: red"></span>其他费用</td>
			<td class="window-table-td2" style="width:27%">
				<p style=" color:#0000CD;"></p>
			</td>
			<td class="window-table-td1"></td>
			<td class="td2">
			</td>
		</tr>
		
		<tr>
			<td class="window-table-td1" colspan="2" style="padding-left: 50px;">
			<input class="under" id="otherPersonNum" autocomplete="off" onchange="otherPersonNumOnChanges(this.value)" onkeyup="value=this.value.replace(/\D+/g,'')"
					<c:if test="${operation=='add'}"> value="${trainingBean.otherPersonNum}"</c:if>
			 		<c:if test="${operation!='add'}"> value="${reimbTrainingBean.otherPersonNum}"</c:if>
			  <c:if test="${operation!='add'&& operation!='edit'}"> readonly="readonly"</c:if>
					 type="text">人·天
					<input class="under" id="realityOtherMoney" autocomplete="off" onchange="realityOtherMoneyOnChanges(this.value)" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"
					<c:if test="${operation=='add'}"> value="${trainingBean.realityOtherMoney}"</c:if>
			 		<c:if test="${operation!='add'}"> value="${reimbTrainingBean.realityOtherMoney}"</c:if>
			  <c:if test="${operation!='add'&& operation!='edit'}"> readonly="readonly"</c:if>
					 type="text">元/人·天
			</td>
			<td class="window-table-td1"><p>报销金额：</p></td>
			<td class="td2">
				<input id="otherMoney" class="easyui-numberbox"
					<c:if test="${operation=='add'}"> value="${trainingBean.otherMoney}"</c:if>
			 		<c:if test="${operation!='add'}"> value="${reimbTrainingBean.otherMoney}"</c:if>
					data-options="icons: [{iconCls:'icon-yuan'}],precision:2"
			  		<c:if test="${operation!='add'&& operation!='edit'}"> readonly="readonly"</c:if>
				style="height:25px;"/>
			</td>
			</tr>
		
		<tr>
			<td class="window-table-td1" style="width:15%"></td>
			<td class="window-table-td2" style="width:27%">
			</td>
			<td class="window-table-td1"><p>定额标准：</p></td>
			<td class="td2">
				<input class="under" id="otherStds" onchange="otherStdsOnChanges(this.value)"
				<c:if test="${operation=='add'}"> value="${trainingBean.otherStd}"</c:if>
		 		<c:if test="${operation!='add'}"> value="${reimbTrainingBean.otherStd}"</c:if>
		 		readonly="readonly" type="text">元
			</td>
		</tr>
</table>	
<script type="text/javascript">
$(function(){
	initMeetInputs();
});

//计算住宿费总额
function addHotelMoney(){
	var hotelMoney=0;
	var num1= parseFloat($('#personNum1').val());
	var num2= parseFloat($('#personDay1').val());
	var num3= parseFloat($('#hotelStd').val());
	if(!isNaN(num1) && !isNaN(num2) && !isNaN(num3)){
		hotelMoney = num1 * num2 * num3;
	}
	$('#hotelMoney').numberbox('setValue',hotelMoney);
	calTotalMoneys();
}

//计算餐费总额
function addFoodMoney(){
	var foodMoney=0;
	var num1= parseFloat($('#personNum2').val());
	var num2= parseFloat($('#personDay2').val());
	var num3= parseFloat($('#foodStd').val());
	if(!isNaN(num1) && !isNaN(num2) && !isNaN(num3)){
		foodMoney = num1 * num2 * num3;
	}
	$('#foodMoney').numberbox('setValue',foodMoney);
	calTotalMoneys();
}
//计算讲课费1
$('#lessonTime1').numberbox({
	onChange:function(newValue,oldValue){
		var lessonMoney1=0;
		var num1= newValue;
		var num2= parseFloat($('#lessonStd1').val());
		if(!isNaN(num1) && !isNaN(num2)){
			lessonMoney1 = num1 * num2;
		}
		$('#lessonMoney1').numberbox('setValue',lessonMoney1);
		calTotalMoneys();
	}
});

//计算讲课费2
$('#lessonTime2').numberbox({
	onChange:function(newValue,oldValue){
		var lessonMoney2=0;
		var num1= newValue;
		var num2= parseFloat($('#lessonStd2').val());
		if(!isNaN(num1) && !isNaN(num2)){
			lessonMoney2 = num1 * num2;
		}
		$('#lessonMoney2').numberbox('setValue',lessonMoney2);
		calTotalMoneys();
	}
});
//计算讲课费3
$('#lessonTime3').numberbox({
	onChange:function(newValue,oldValue){
		var lessonMoney3=0;
		var num1= newValue;
		var num2= parseFloat($('#lessonStd3').val());
		if(!isNaN(num1) && !isNaN(num2)){
			lessonMoney3 = num1 * num2;
		}
		$('#lessonMoney3').numberbox('setValue',lessonMoney3);
		calTotalMoneys();
	}
});
//计算总额
function calTotalMoneys(){
	
	var totalMoney=0;
	var num1= parseFloat($('#hotelMoney').numberbox('getValue'));
	if(!isNaN(num1)){
		totalMoney = totalMoney + num1;
	}
	var num2= parseFloat($('#foodMoney').numberbox('getValue'));
	if(!isNaN(num2)){
		totalMoney = totalMoney + num2;
	}
	var num3= parseFloat($('#dataMoney').numberbox('getValue'));
	if(!isNaN(num3)){
		totalMoney = totalMoney + num3;
	}
	var num4= parseFloat($('#spaceMoney').numberbox('getValue'));
	if(!isNaN(num4)){
		totalMoney = totalMoney + num4;
	}
	var num5= parseFloat($('#transportMoney').numberbox('getValue'));
	if(!isNaN(num5)){
		totalMoney = totalMoney + num5;
	}
	var num6= parseFloat($('#otherMoney').numberbox('getValue'));
	if(!isNaN(num6)){
		totalMoney = totalMoney + num6;
	}
	//给两个总额框赋值
	$('#zongheMoney').val(totalMoney);
	addTotalAmounts();
}
//初始化费用明细的输入框
function initMeetInputs(){
	$("#hotelMoney").numberbox({
		onChange: function(newValue, oldValue) {
			var hotelPersonNum = Number($('#hotelPersonNum').val());
			var hotelStd = Number($('#hotelStd').val());
			var costExternalHotel = Number($('#costExternalHotel').val());
			var fProvinceId = $("#fProvinceId").textbox('getValue')
			var hotelMoneyVal = Number(newValue);
			if (hotelPersonNum == '' || hotelPersonNum == '0') {
				$('#hotelStds').val(0);
				allQuotaStandards();
				allApplyStandards();
				calTotalMoneys();
				return;
			}
			if(hotelMoneyVal==0){
				$('#hotelStds').val(0);
				$('#realityHotelMoney').val(0);
			}else{
				if(fProvinceId=='2260'){
					$('#hotelStds').val(hotelStd*hotelPersonNum);
					$('#realityHotelMoney').val((hotelMoneyVal/hotelPersonNum).toFixed(2));
				}else{
					$('#hotelStds').val(costExternalHotel*hotelPersonNum);
					$('#realityHotelMoney').val((hotelMoneyVal/hotelPersonNum).toFixed(2));
				}
			}
			allQuotaStandards();
			allApplyStandards();
			calTotalMoneys();
		}
	});
	$("#foodMoney").numberbox({
		onChange: function(newValue, oldValue) {
			var foodPersonNum = Number($('#foodPersonNum').val());
			var foodStd = Number($('#foodStd').val());
			var costExternalFood = Number($('#costExternalFood').val());
			var foodMoneyVal = Number(newValue);
			var fProvinceId = $("#fProvinceId").combobox('getValue');
			if (foodPersonNum == '' || foodPersonNum == '0') {
				$('#foodStds').val(0);
				allQuotaStandards();
				allApplyStandards();
				calTotalMoneys();
				return;
			}
			if(foodMoneyVal==0){
				$('#foodStds').val(0);
				$('#realityFoodMoney').val(0);
			}else{
				if(fProvinceId=='2260'){
					$('#foodStds').val(foodStd*foodPersonNum);
					$('#realityFoodMoney').val((foodMoneyVal/foodPersonNum).toFixed(2));
				}else{
					$('#foodStds').val(costExternalFood*foodPersonNum);
					$('#realityFoodMoney').val((foodMoneyVal/foodPersonNum).toFixed(2));
				}
			}
			allQuotaStandards();
			allApplyStandards();
			calTotalMoneys();
		}
	});
	$("#dataMoney").numberbox({
		onChange: function(newValue, oldValue) {
			var dataMoney = Number(newValue);
			var dataPersonNum = Number($('#dataPersonNum').val());
			var spaceMoney = parseFloat($('#spaceMoney').numberbox('getValue'));
			var transportMoney = parseFloat($('#transportMoney').numberbox('getValue'));
			if(isNaN(spaceMoney)){
				spaceMoney = 0;
			}
			if(isNaN(transportMoney)){
				transportMoney = 0;
			}
			if(dataMoney==0){
				$('#realityDataMoney').val(0);
			}else{
				$('#realityDataMoney').val(fomatMoney(dataMoney/dataPersonNum,2));
			}
			$('#costThreeTermsMoney').numberbox('setValue',dataMoney+spaceMoney+transportMoney);
			allQuotaStandards();
			allApplyStandards();
			calTotalMoneys();
		}
	});
	$("#spaceMoney").numberbox({
		onChange: function(newValue, oldValue) {
			var spaceMoney = isNaN(parseFloat(newValue))?0:parseFloat(newValue);
			$('#spaceMoneys').val(spaceMoney);
			var dataMoney = parseFloat($('#dataMoney').numberbox('getValue'));
			var transportMoney = parseFloat(newValue);
			if(isNaN(dataMoney)){
				dataMoney = 0;
			}
			if(isNaN(spaceMoney)){
				spaceMoney = 0;
			}
			if(isNaN(transportMoney)){
				transportMoney = 0;
			}
			$('#costThreeTermsMoney').numberbox('setValue',dataMoney+spaceMoney+transportMoney);
			allQuotaStandards();
			allApplyStandards();
			calTotalMoneys();
		}
	});
	$("#transportMoney").numberbox({
		onChange: function(newValue, oldValue) {
			var transportMoney = isNaN(parseFloat(newValue))?0:parseFloat(newValue);
			$('#transportMoneys').val(transportMoney);
			allQuotaStandards();
			allApplyStandards();
			calTotalMoneys();
		}
	});
	$("#otherMoney").numberbox({
		onChange: function(newValue, oldValue) {
			var otherMoney = isNaN(parseFloat(newValue))?0:parseFloat(newValue);
			$('#otherMoneys').val(otherMoney);
			var fProvinceId = $("#fProvinceId").combobox('getValue');
			var otherStd = parseFloat($('#otherStd').val());
			var costExternalOther = Number($('#costExternalOther').val());
			var train_num = parseInt($('#trDayNum').numberbox('getValue'));//培训天数
			var otherPersonNum = parseInt($('#otherPersonNum').val());//人数
			if(isNaN(otherStd)){
				otherStd=0;
			}
			if(isNaN(newValue)){
				newValue=0;
			}
			if(isNaN(train_num)){
				train_num=0;
			}
			if(newValue==0){
				$('#otherStds').val(0);
			}else{
				if(fProvinceId=='2260'){
					$('#otherStds').val(otherStd*otherPersonNum);
				}else{
					$('#otherStds').val(costExternalOther*otherPersonNum);
				}
			}
			
			allQuotaStandards();
			allApplyStandards();
			calTotalMoneys();
		}
	});
	$("#longTrafficMoney").numberbox({
		onChange: function(newValue, oldValue) {
			calTotalMoneys();
		}
	});
}

function hotelPersonNumOnChanges(val){
	
	var realityHotelMoney = parseFloat($('#realityHotelMoney').val());
	var hotelPersonNum = parseFloat(val);
	var hotelStd = parseFloat($('#hotelStd').val());
	var costExternalHotel = Number($('#costExternalHotel').val());
	var fProvinceId = $("#fProvinceId").textbox('getValue')
	if(isNaN(realityHotelMoney)){
		realityHotelMoney = 0;
	}
	if(isNaN(hotelPersonNum)){
		hotelPersonNum = 0;
	}
	if(isNaN(hotelStd)){
		hotelStd = 0;
	}
	var trainPersonNum = parseInt($('#trAttendNum').numberbox('getValue'));//参会人数
	var trStaffNum = parseInt($('#trStaffNum').numberbox('getValue'));//工作人员人数
	var trDayNum = parseInt($('#trDayNum').numberbox('getValue'));//工作天数
	if(isNaN(trainPersonNum)){
		trainPersonNum = 0;
	}
	if(isNaN(trStaffNum)){
		trStaffNum = 0;
	}
	if(isNaN(trDayNum)){
		trDayNum = 0;
	}
	if(((trainPersonNum+trStaffNum)*(trDayNum-1))<hotelPersonNum){
		alert('住宿费人·天超标，请重新填写！');
		$('#hotelPersonNum').val('');
		hotelPersonNum = 0;
	}
	$('#hotelMoney').numberbox('setValue',hotelPersonNum*realityHotelMoney);
	$('#hotelMoneys').val(hotelPersonNum*realityHotelMoney);
	if(fProvinceId=='2260'){
		$('#hotelStds').val(hotelStd*hotelPersonNum);
		$('#hotelStdH').val(hotelStd*hotelPersonNum);
	}else{
		$('#hotelStds').val(costExternalHotel*hotelPersonNum);
		$('#hotelStdH').val(costExternalHotel*hotelPersonNum);
	}

	
	allQuotaStandards();
	allApplyStandards();
	$('#hotelPersonNums').val(hotelPersonNum);
}
function realityHotelMoneyOnChanges(val){
	var hotelPersonNum = parseFloat($('#hotelPersonNum').val());
	var realityHotelMoney = parseFloat(val);
	if(isNaN(hotelPersonNum)){
		hotelPersonNum=0;
	}
	if(isNaN(realityHotelMoney)){
		realityHotelMoney = 0;
	}
	$('#hotelMoney').numberbox('setValue',hotelPersonNum*realityHotelMoney);
	$('#hotelMoneys').val(hotelPersonNum*realityHotelMoney);
	allQuotaStandards();allApplyStandards();
	$('#realityHotelMoneys').val(realityHotelMoney);
}
function hotelMoneyOnChanges(val){
	var hotelMoney = parseFloat(val);
	if(isNaN(hotelMoney)){
		hotelMoney = 0;
	}
	$('#hotelMoneys').val(hotelMoney);
}
function hotelStdOnChanges(val){
	
	var hotelStd = parseFloat(val);
	if(isNaN(hotelStd)){
		hotelStd = 0;
	}
	$('#hotelStdH').val(hotelStd);
}
function foodMoneyOnChanges(val){
	var foodMoney = parseFloat(val);
	if(isNaN(foodMoney)){
		foodMoney = 0;
	}
	$('#foodMoneys').val(foodMoney);
}
function costThreeTermsMoneyOnChanges(val){
	var costThreeTermsMoney = parseFloat(val);
	var dataPersonNum = parseInt($("#dataPersonNum").val());
	var train_num = parseInt($('#trDayNum').numberbox('getValue'));//培训天数
	var costExternalBook = Number($('#costExternalBook').val());
	var fProvinceId = $("#fProvinceId").combobox('getValue');
	var zongheStd = parseFloat($('#zongheStd').val());
	if(isNaN(costThreeTermsMoney)){
		costThreeTermsMoney = 0;
	}
	if(isNaN(dataPersonNum)){
		dataPersonNum = 0;
	}
	if(costThreeTermsMoney==0){
		$('#zongheStds').val(0);
	}else{
		if(fProvinceId=='2260'){
			$('#zongheStds').val(zongheStd*dataPersonNum);
			$('#zongheStdH').val(zongheStd*dataPersonNum);
		}else{
			$('#zongheStds').val(costExternalBook*dataPersonNum);
			$('#zongheStdH').val(costExternalBook*dataPersonNum);
		}
	}
	$('#costThreeTermsMoneys').val(costThreeTermsMoney);
}
function costThreeTermsStdOnChanges(val){
	var costThreeTermsStd = parseFloat(val);
	if(isNaN(costThreeTermsStd)){
		costThreeTermsStd = 0;
	}
	$('#zongheStdH').val(costThreeTermsStd);
}
function otherStdsOnChanges(val){
	
	var otherStd = parseFloat(val);
	if(isNaN(otherStd)){
		otherStd = 0;
	}
	$('#otherStdH').val(otherStd);
}
function foodStdOnChanges(val){
	var foodStd = parseFloat(val);
	if(isNaN(foodStd)){
		foodStd = 0;
	}
	$('#foodStdH').val(foodStd);
}
function foodPersonNumOnChanges(val){
	var realityFoodMoney = parseFloat($('#realityFoodMoney').val());
	var foodPersonNum = parseFloat(val);
	var trainPersonNum = parseInt($('#trAttendNum').numberbox('getValue'));//参会人数
	var trStaffNum = parseInt($('#trStaffNum').numberbox('getValue'));//工作人员人数
	var trDayNum = parseInt($('#trDayNum').numberbox('getValue'));//工作天数
	var foodStd = parseFloat($('#foodStd').val());
	var costExternalFood = Number($('#costExternalFood').val());
	var fProvinceId = $("#fProvinceId").combobox('getValue');
	if(isNaN(realityFoodMoney)){
		realityFoodMoney = 0;
	}
	if(isNaN(foodPersonNum)){
		foodPersonNum = 0;
	}
	if(isNaN(foodStd)){
		foodStd = 0;
	}
	if(isNaN(trStaffNum)){
		trStaffNum = 0;
	}
	if(isNaN(trainPersonNum)){
		trainPersonNum = 0;
	}
	if(isNaN(trDayNum)){
		trDayNum = 0;
	}
	if(((trainPersonNum+trStaffNum)*trDayNum)<foodPersonNum){
		alert('伙食费人·天超标，请重新填写！');
		$('#foodPersonNum').val('');
		foodPersonNum = 0;
	}
	$('#foodMoney').numberbox('setValue',foodPersonNum*realityFoodMoney);
	$('#foodMoneys').val(foodPersonNum*realityFoodMoney);
	
	
	if(fProvinceId=='2260'){
		$('#foodStds').val(foodStd*foodPersonNum);
		$('#foodStdH').val(foodStd*foodPersonNum);
	}else{
		$('#foodStds').val(costExternalFood*foodPersonNum);
		$('#foodStdH').val(costExternalFood*foodPersonNum);
	}

	allQuotaStandards();
	allApplyStandards();
	$('#foodPersonNums').val(foodPersonNum);
}
function realityFoodMoneyOnChanges(val){
	
	var foodPersonNum = parseFloat($('#foodPersonNum').val());
	var realityFoodMoney = parseFloat(val);
	if(isNaN(foodPersonNum)){
		hotelPersonNum=0;
	}
	if(isNaN(realityFoodMoney)){
		realityFoodMoney = 0;
	}
	$('#foodMoney').numberbox('setValue',foodPersonNum*realityFoodMoney);
	$('#foodMoneys').val(foodPersonNum*realityFoodMoney);
	allQuotaStandards();allApplyStandards();
	$('#realityFoodMoneys').val(realityFoodMoney);
}
function otherPersonNumOnChanges(val){
	
	var realityOtherMoney = parseFloat($('#realityOtherMoney').val());
	var otherPersonNum = parseFloat(val);
	var trainPersonNum = parseInt($('#trAttendNum').numberbox('getValue'));//参会人数
	var trStaffNum = parseInt($('#trStaffNum').numberbox('getValue'));//工作人员人数
	var trDayNum = parseInt($('#trDayNum').numberbox('getValue'));//工作天数
	var otherStd = parseFloat($('#otherStd').val());
	var fProvinceId = $("#fProvinceId").combobox('getValue');
	var costExternalOther = Number($('#costExternalOther').val());
	if(isNaN(realityOtherMoney)){
		realityOtherMoney = 0;
	}
	if(isNaN(otherPersonNum)){
		otherPersonNum = 0;
	}
	if(isNaN(otherStd)){
		otherStd = 0;
	}
	if(isNaN(trStaffNum)){
		trStaffNum = 0;
	}
	if(isNaN(trainPersonNum)){
		trainPersonNum = 0;
	}
	if(isNaN(trDayNum)){
		trDayNum = 0;
	}
	if(((trainPersonNum+trStaffNum)*trDayNum)<otherPersonNum){
		alert('伙食费人·天超标，请重新填写！');
		$('#otherPersonNum').val('');
		otherPersonNum = 0;
	}
	$('#otherMoney').numberbox('setValue',otherPersonNum*realityOtherMoney);
	$('#otherMoneys').val(otherPersonNum*realityOtherMoney);
	
	if(fProvinceId=='2260'){
		$('#otherStds').val(otherStd*otherPersonNum);
		$('#otherStdH').val(otherStd*otherPersonNum);
	}else{
		$('#otherStds').val(costExternalOther*otherPersonNum);
		$('#otherStdH').val(costExternalOther*otherPersonNum);
	}

	allQuotaStandards();
	allApplyStandards();
	$('#otherPersonNums').val(otherPersonNum);
}
function realityOtherMoneyOnChanges(val){
	
	var otherPersonNum = parseFloat($('#otherPersonNum').val());
	var realityOtherMoney = parseFloat(val);
	if(isNaN(otherPersonNum)){
		hotelPersonNum=0;
	}
	if(isNaN(realityOtherMoney)){
		realityOtherMoney = 0;
	}
	$('#otherMoney').numberbox('setValue',otherPersonNum*realityOtherMoney);
	$('#otherMoneys').val(otherPersonNum*realityOtherMoney);
	allQuotaStandards();
	allApplyStandards();
	$('#realityOtherMoneys').val(realityOtherMoney);
}
function dataPersonNumOnChanges(val){
	var realityDataMoney = parseFloat($('#realityDataMoney').val());
	var dataPersonNum = parseFloat(val);
	var trainPersonNum = parseInt($('#trAttendNum').numberbox('getValue'));//参会人数
	var trStaffNum = parseInt($('#trStaffNum').numberbox('getValue'));//工作人员人数
	var trDayNum = parseInt($('#trDayNum').numberbox('getValue'));//工作天数
	var costExternalBook = Number($('#costExternalBook').val());
	var fProvinceId = $("#fProvinceId").combobox('getValue');
	var zongheStd = parseFloat($('#zongheStd').val());
	if(isNaN(realityDataMoney)){
		realityDataMoney=0;
	}
	if(isNaN(dataPersonNum)){
		dataPersonNum = 0;
	}
	if(isNaN(trainPersonNum)){
		trainPersonNum = 0;
	}
	if(isNaN(trStaffNum)){
		trStaffNum = 0;
	}
	if(isNaN(trDayNum)){
		trDayNum = 0;
	}
	if((trainPersonNum+trStaffNum)<dataPersonNum){
		alert('培训资料费人数超标，请重新填写！');
		$('#dataPersonNum').val('');
		dataPersonNum = 0;
	}
	$('#dataMoney').numberbox('setValue',realityDataMoney*dataPersonNum);
	$('#dataMoneys').val(realityDataMoney*dataPersonNum);
	if(fProvinceId=='2260'){
		$('#zongheStds').val(zongheStd*dataPersonNum);
		$('#zongheStdH').val(zongheStd*dataPersonNum);
	}else{
		$('#zongheStds').val(costExternalBook*dataPersonNum);
		$('#zongheStdH').val(costExternalBook*dataPersonNum);
	}
	
	allQuotaStandards();
	allApplyStandards();
	$('#dataPersonNums').val(dataPersonNum);
}
function realityDataMoneyOnChanges(val){
	
	var dataPersonNum = parseFloat($('#dataPersonNum').val());
	var realityDataMoney = parseFloat(val);
	if(isNaN(dataPersonNum)){
		dataPersonNum = 0;
	}
	if(isNaN(realityDataMoney)){
		realityDataMoney = 0;
	}
	$('#dataMoney').numberbox('setValue',dataPersonNum*realityDataMoney);
	$('#dataMoneys').val(dataPersonNum*realityDataMoney);
	allQuotaStandards();allApplyStandards();
	$('#realityDataMoneys').val(realityDataMoney);
}

function allQuotaStandards(){
	
	var hotelStds = parseFloat($('#hotelStds').val());
	var foodStds = parseFloat($('#foodStds').val());
	var zongheStds = parseFloat($('#zongheStds').val());
	var otherStds = parseFloat($('#otherStds').val());
	if(isNaN(hotelStds)){
		hotelStds = 0;
	}
	if(isNaN(foodStds)){
		foodStds = 0;
	}
	if(isNaN(zongheStds)){
		zongheStds = 0;
	}
	if(isNaN(otherStds)){
		otherStds = 0;
	}
	$('#zongheMoneyStd').val((hotelStds+foodStds+zongheStds+otherStds).toFixed(2));
	$('#zongheMoneyStds').val((hotelStds+foodStds+zongheStds+otherStds).toFixed(2));
}
function allApplyStandards(){
	
	var hotelMoney = parseFloat($('#hotelMoney').val());
	var foodMoney = parseFloat($('#foodMoney').val());
	var costThreeTermsMoney = parseFloat($('#costThreeTermsMoney').val());
	var otherMoney = parseFloat($('#otherMoney').val());
	if(isNaN(hotelMoney)){
		hotelMoney = 0;
	}
	if(isNaN(foodMoney)){
		foodMoney = 0;
	}
	if(isNaN(costThreeTermsMoney)){
		costThreeTermsMoney = 0;
	}
	if(isNaN(otherMoney)){
		otherMoney = 0;
	}
	$('#zongheMoney').val((otherMoney+costThreeTermsMoney+foodMoney+hotelMoney).toFixed(2));
	$('#zongheMoneys').val((otherMoney+costThreeTermsMoney+foodMoney+hotelMoney).toFixed(2));
}
</script>