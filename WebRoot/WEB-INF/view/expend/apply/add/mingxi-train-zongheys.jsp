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
		<td class="window-table-td1" style="width:20%"><span style="color: red"></span>住宿费</td>
		<td class="window-table-td2" style="width:27%">
			<p style=" color:#0000CD;"></p>
		</td>
		<td class="window-table-td1"></td>
		<td class="td2">
		</td>
	</tr>
	<tr>
		<td class="window-table-td1" colspan="2">
			<p>
				<input class="under" id="hotelPersonNum" readonly="readonly" name="hotelPersonNum" value="${trainingBean.hotelPersonNum}" onchange="hotelPersonNumOnChange(this.value)" type="text">人·天
				<input class="under" id="realityHotelMoney" readonly="readonly" name="realityHotelMoney" value="${trainingBean.realityHotelMoney}" onchange="realityHotelMoneyOnChange(this.value)" type="text">元/人·天
			</p>
		</td>
		<td class="window-table-td1"><p>申请金额：</p></td>
		<td class="td2">
			<input id="hotelMoney"  name="hotelMoney" value="${trainingBean.hotelMoney}" class="easyui-numberbox"
		 style="height:25px;" data-options="icons: [{iconCls:'icon-yuan'}],precision:2" readonly="readonly">
		</td>
	</tr>
	<tr>
		<td class="window-table-td1" style="width:15%"></td>
		<td class="window-table-td2" style="width:27%">
		</td>
		<td class="window-table-td1"><p>定额标准：</p></td>
		<td class="td2">
			<input class="under" id="hotelStds" name="hotelStd" value="${trainingBean.hotelStd}" readonly="readonly" type="text">元
		</td>
	</tr>
</table>		
<div style="height:10px;"></div>
<table class="window-table-readonly-zc-pxAndHy" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1" style="width:20%"><span style="color: red"></span>伙食费</td>
			<td class="window-table-td2" style="width:27%">
				<p style=" color:#0000CD;"></p>
			</td>
			<td class="window-table-td1"></td>
			<td class="td2">
			</td>
		</tr>
		<tr>
			<td class="window-table-td1" colspan="2">
				<p>
					<input class="under" id="foodPersonNum" readonly="readonly" name="foodPersonNum" value="${trainingBean.foodPersonNum}" onchange="foodPersonNumOnChange(this.value)" type="text">人·天
					<input class="under" id="realityFoodMoney" readonly="readonly" name="realityFoodMoney" value="${trainingBean.realityFoodMoney}" onchange="realityFoodMoneyOnChange(this.value)" type="text">元/人·天
				</p>
			</td>
			
			<td class="window-table-td1"><p>申请金额：</p></td>
			<td class="td2">
				<input class="easyui-numberbox" style="height:25px;" data-options="icons: [{iconCls:'icon-yuan'}],precision:2" 
					id="foodMoney" name="foodMoney" value="${trainingBean.foodMoney}" readonly="readonly">
			</td>
		</tr>
		<tr>
			<td class="window-table-td1" style="width:15%"></td>
			<td class="window-table-td2" style="width:27%">
			</td>
			<td class="window-table-td1"><p>定额标准：</p></td>
			<td class="td2">
				<input class="under" id="foodStds" value="${trainingBean.foodStd}" name="foodStd" readonly="readonly" type="text">元
			</td>
		</tr>
</table>		
<div style="height:10px;"></div>
<table class="window-table-readonly-zc-pxAndHy" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1" style="width:20%"><span style="color: red"></span>资料、场地、交通费</td>
			<td class="window-table-td2" style="width:27%">
				<p style=" color:#0000CD;"></p>
			</td>
			<td class="window-table-td1"></td>
			<td class="td2" hidden="hidden">
				<input id="dataMoney" class="easyui-numberbox" name="dataMoney" value="${trainingBean.dataMoney}" data-options="icons: [{iconCls:'icon-yuan'}],precision:2" readonly="readonly" style="height:25px;"/>
			</td>
		</tr>
		<tr>
			<td class="window-table-td1" style="padding-left: 30px;" colspan="2"><span style="color: red;"></span>培训资料费</td>
			<td class="window-table-td1"></td>
			<td class="td2"></td>
		</tr>
		<tr>
			<td class="window-table-td1" colspan="2" style="padding-left: 50px;">
				<p>
					<input class="under" id="dataPersonNum" readonly="readonly" name="dataPersonNum" value="${trainingBean.dataPersonNum}" onchange="dataPersonNumOnChange(this.value)" type="text">人*
					<input class="under" id="realityDataMoney" readonly="readonly" name="realityDataMoney" value="${trainingBean.realityDataMoney}" onchange="realityDataMoneyOnChange(this.value)" type="text">元/人
				</p>
			</td>
			<td class="window-table-td1"><p>金额：</p></td>
			<td class="td2">
			<input id="costThreeTermsMoney" class="easyui-numberbox" name="costThreeTermsMoney" value="${trainingBean.costThreeTermsMoney}" readonly="readonly" data-options="icons: [{iconCls:'icon-yuan'}],precision:2"
				style="height:25px;"/>
			</td>
		</tr>
		<tr hidden="hidden">
			<td class="window-table-td1" style="padding-left: 30px;" colspan="2"><span style="color: red;"></span>培训场地费</td>
			<td class="window-table-td1"><p>金额：</p></td>
			<td class="td2">
				<input id="spaceMoney" class="easyui-numberbox" name="spaceMoney" value="${trainingBean.spaceMoney}" data-options="icons: [{iconCls:'icon-yuan'}],precision:2"
				readonly="readonly"
				style="height:25px;"/>
			</td>
		</tr>
		<tr hidden="hidden">
			<td class="window-table-td1" style="padding-left: 30px;" colspan="2"><span style="color: red;"></span>交通费</td>
			
			<td class="window-table-td1"><p>金额：</p></td>
			<td class="td2">
				<input id="transportMoney" class="easyui-numberbox" name="transportMoney" value="${trainingBean.transportMoney}" data-options="icons: [{iconCls:'icon-yuan'}],precision:2"
				readonly="readonly"
				style="height:25px;"/>
			</td>
		</tr>
		<tr>
			<td class="window-table-td1" style="width:15%"></td>
			<td class="window-table-td2" style="width:27%">
			</td>
			<td class="window-table-td1"><p>定额标准：</p></td>
			<td class="td2">
				<input class="under" id="zongheStds" value="${trainingBean.costThreeTermsStd}" name="costThreeTermsStd" readonly="readonly" type="text">元
			</td>
		</tr>
</table>	
<div style="height:10px;"></div>
<table class="window-table-readonly-zc-pxAndHy" cellspacing="0" cellpadding="0">
		<tr>
			<td class="window-table-td1" style="width:20%"><span style="color: red;text-align: right;"></span>其他费用</td>
			<td class="window-table-td2" style="width:27%">
				<p style=" color:#0000CD;"></p>
			</td>
			<td class="window-table-td1"><p>申请金额：</p></td>
			<td class="td2">
				<input id="otherMoney" class="easyui-numberbox" name="otherMoney" value="${trainingBean.otherMoney}" data-options="icons: [{iconCls:'icon-yuan'}],precision:2"
				readonly="readonly"
				style="height:25px;"/>
			</td>
		</tr>
		<tr>
			<td class="window-table-td1" style="width:15%"></td>
			<td class="window-table-td2" style="width:27%">
			</td>
			<td class="window-table-td1"><p>定额标准：</p></td>
			<td class="td2">
				<input class="under" id="otherStds" value="${trainingBean.otherStd}" name="otherStd" readonly="readonly" type="text">元
			</td>
		</tr>
</table>	
<script type="text/javascript">
$(function(){
	initMeetInput();
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
	//$('#hotelMoney').val(hotelMoney);
	$('#hotelMoney').numberbox('setValue',hotelMoney);
	//$('#p_hotelMoney').html(fomatMoney(hotelMoney,2)+" [元]");
	calTotalMoney();
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
	//$('#foodMoney').val(foodMoney);
	$('#foodMoney').numberbox('setValue',foodMoney);
	//$('#p_foodMoney').html(fomatMoney(foodMoney,2)+" [元]");
	calTotalMoney();
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
		//console.log(lessonMoney1);
		//$('#lessonMoney1').val(lessonMoney1);
		$('#lessonMoney1').numberbox('setValue',lessonMoney1);
		//$('#p_lessonMoney1').html(fomatMoney(lessonMoney1,2)+" [元]");
		calTotalMoney();
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
		//$('#lessonMoney2').val(lessonMoney2);
		$('#lessonMoney2').numberbox('setValue',lessonMoney2);
		//$('#p_lessonMoney2').html(fomatMoney(lessonMoney2,2)+" [元]");
		calTotalMoney();
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
		//$('#lessonMoney3').val(lessonMoney3);
		$('#lessonMoney3').numberbox('setValue',lessonMoney3);
		//$('#p_lessonMoney3').html(fomatMoney(lessonMoney3,2)+" [元]");
		calTotalMoney();
	}
});
//计算总额
function calTotalMoney(){
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
	addTotalAmount();
}
//初始化费用明细的输入框
function initMeetInput(){
	$("#hotelMoney").numberbox({
		onChange: function(newValue, oldValue) {
			allQuotaStandard();
			allApplyStandard();
			calTotalMoney();
		}
	});
	$("#foodMoney").numberbox({
		
		onChange: function(newValue, oldValue) {
			allQuotaStandard();
			allApplyStandard();
			calTotalMoney();
		}
	});
	$("#dataMoney").numberbox({
		onChange: function(newValue, oldValue) {
			var dataMoney = parseFloat(newValue);
			var spaceMoney = parseFloat($('#spaceMoney').numberbox('getValue'));
			var transportMoney = parseFloat($('#transportMoney').numberbox('getValue'));
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
			calTotalMoney();
		}
	});
	$("#spaceMoney").numberbox({
		onChange: function(newValue, oldValue) {
			var dataMoney = parseFloat($('#dataMoney').numberbox('getValue'));
			var spaceMoney = parseFloat(newValue);
			var transportMoney = parseFloat($('#transportMoney').numberbox('getValue'));
			
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
			calTotalMoney();
		}
	});
	$("#transportMoney").numberbox({
		onChange: function(newValue, oldValue) {
			var dataMoney = parseFloat($('#dataMoney').numberbox('getValue'));
			var spaceMoney = parseFloat($('#spaceMoney').numberbox('getValue'));
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
			calTotalMoney();
		}
	});
	$("#otherMoney").numberbox({
		onChange: function(newValue, oldValue) {
			allQuotaStandard();
			allApplyStandard();
			calTotalMoney();
		}
	});
	$("#longTrafficMoney").numberbox({
		onChange: function(newValue, oldValue) {
			calTotalMoney();
		}
	});
	$("#costThreeTermsMoney").numberbox({
		onChange: function(newValue, oldValue) {
			allQuotaStandard()
			allApplyStandard();
			calTotalMoney();
		}
	});
}

function hotelPersonNumOnChange(val){
	var realityHotelMoney = parseFloat($('#realityHotelMoney').val());
	var hotelPersonNum = parseFloat(val);
	var hotelStd = parseFloat($('#hotelStd').val());
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
	if(trainPersonNum<hotelPersonNum){
		alert('住宿人数不能超过参训人数！');
		$('#hotelPersonNum').val('');
		hotelPersonNum = 0;
	}
	$('#hotelStds').val(hotelStd*hotelPersonNum);
	allQuotaStandard();
	allApplyStandard();
	$('#hotelMoney').numberbox('setValue',hotelPersonNum*realityHotelMoney);
}
function realityHotelMoneyOnChange(val){
	
	var hotelPersonNum = parseFloat($('#hotelPersonNum').val());
	var realityHotelMoney = parseFloat(val);
	if(isNaN(hotelPersonNum)){
		hotelPersonNum=0;
	}
	if(isNaN(realityHotelMoney)){
		realityHotelMoney = 0;
	}
	$('#hotelMoney').numberbox('setValue',hotelPersonNum*realityHotelMoney);
}
function foodPersonNumOnChange(val){
	
	var realityFoodMoney = parseFloat($('#realityFoodMoney').val());
	var foodPersonNum = parseFloat(val);
	var trainPersonNum = parseInt($('#trAttendNum').numberbox('getValue'));//参会人数
	
	var foodStd = parseFloat($('#foodStd').val());
	if(isNaN(realityFoodMoney)){
		realityFoodMoney = 0;
	}
	if(isNaN(foodPersonNum)){
		foodPersonNum = 0;
	}
	if(isNaN(foodStd)){
		foodStd = 0;
	}
	if(trainPersonNum<foodPersonNum){
		alert('伙食费人数不能超过参训人数！');
		$('#foodPersonNum').val('');
		foodPersonNum = 0;
	}
	$('#foodStds').val(foodStd*foodPersonNum);
	allQuotaStandard();
	allApplyStandard();
	$('#foodMoney').numberbox('setValue',foodPersonNum*realityFoodMoney);
}
function realityFoodMoneyOnChange(val){
	
	var foodPersonNum = parseFloat($('#foodPersonNum').val());
	var realityFoodMoney = parseFloat(val);
	if(isNaN(foodPersonNum)){
		hotelPersonNum=0;
	}
	if(isNaN(realityFoodMoney)){
		realityFoodMoney = 0;
	}
	$('#foodMoney').numberbox('setValue',foodPersonNum*realityFoodMoney);
}
function dataPersonNumOnChange(val){
	
	var realityDataMoney = parseFloat($('#realityDataMoney').val());
	var dataPersonNum = parseFloat(val);
	var trainPersonNum = parseInt($('#trAttendNum').numberbox('getValue'));//参会人数
	if(isNaN(realityDataMoney)){
		realityDataMoney=0;
	}
	if(isNaN(dataPersonNum)){
		dataPersonNum = 0;
	}
	if(trainPersonNum<dataPersonNum){
		alert('培训资料费人数不能超过参训人数！');
		$('#dataPersonNum').val('');
		dataPersonNum = 0;
	}
	$('#dataMoney').numberbox('setValue',realityDataMoney*dataPersonNum);
}
function realityDataMoneyOnChange(val){
	
	var dataPersonNum = parseFloat($('#dataPersonNum').val());
	var realityDataMoney = parseFloat(val);
	if(isNaN(dataPersonNum)){
		dataPersonNum = 0;
	}
	if(isNaN(realityDataMoney)){
		realityDataMoney = 0;
	}
	$('#dataMoney').numberbox('setValue',dataPersonNum*realityDataMoney);
}
function allQuotaStandard(){
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
	$('#zongheMoneyStd').val(hotelStds+foodStds+zongheStds+otherStds);
}
function allApplyStandard(){
	
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
	$('#zongheMoney').val(otherMoney+costThreeTermsMoney+foodMoney+hotelMoney);
}
</script>
