<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<style>
	.input_amonut{
		width: 150px;
		height: 20px;
		border-radius: 4px;
		border: 1px solid #F0F5F7;
	}
	.input_amonut1{
		width: 410px;
		height: 20px;
		border-radius: 4px;
		border: 1px solid #F0F5F7;
	}
	.fp_span{
		width:85px;
		margin-bottom:5px;
		display: inline-block;
	}
	.fp_span1{
		width:85px;
		margin-bottom:5px;
		margin-left:15px;
		display: inline-block;
	}
</style>
<div id="dlgdiv" class="easyui-dialog"
     style="width: 800px; height: 550px; padding: 10px 20px" closed="true"
     buttons="#dlgdiv-buttons">
        <div id="divlarge"></div>
</div>
<form id="form1">
	<table id="tableHotel" class="window-table-readonly" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:12.6%">
					<p style=" color:#0000CD;">住宿费</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p id="p_hotelMoney">${meetingBean.hotelMoney}元</p>
				</td>
				<td>
					<a onclick="append(this)" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/tjfp1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</td>
			</tr>
			<!-- <tr>
				<td class="window-table-td1"><p>备注：</p></td>
				<td class="window-table-td2">
					<p style=" color:#0000CD;"></p>
				</td>
			</tr> -->
			
			<tbody id="hotel_0" >
			<tr>
				<td class="td1">
					&nbsp;&nbsp;<span id="hotelFp_0">发票1</span>
					<input type="text" id="fp_0" name="fileId" hidden="hidden">
					<input type="file" id="image_0" onchange="upImageFile1(this)" hidden="hidden">
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_0">
					<a onclick="clickUpFile(this)" id="click_0" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</td>	
			</tr>
			<tr>
				<!-- <td class=""></td> -->
				<td class="td2" colspan="5" id="">
					<div style="width: auto; height:auto;margin-top:5px;margin-left:49px;">
						<p style="margin-bottom:10px;">
							<span class="fp_span">票面金额(元)：</span>
							<input class="input_amonut a" name="amount" id="amount_0" required="required" onchange="addAmonut(this)"
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="" />
							<span class="fp_span1">专项税额(元)：</span>
							<input  name="tax" id="tax_0" class="input_amonut"
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="" />
						</p>
						<p style="margin-bottom:10px;">
							<span class="fp_span">开票时间：</span>
							<input name="time" id="time_0" type="date" class="input_amonut"
							value="" />
						</p>
						<p style="margin-bottom:10px;">
							<span class="fp_span">住宿地点：</span>
							<input  name="unit"  id="unit_0" required="required" class="input_amonut"
							value="" />
						</p>
						<p style="margin-bottom:10px;">
							<span class="fp_span">入住日期：</span>
							<input  class="input_amonut" name="startTime"  id="startTime_0" type="date" onchange="countDays(this)"
							value="" />
							<span class="fp_span1">退房日期：</span>
							<input  class="input_amonut" name="endTime"  id="endTime_0" type="date" onchange="countDays(this)"
							value="" />
						</p>
						<p style="margin-bottom:10px;">
							<span class="fp_span">天数：</span>
							<input  class="input_amonut" name="days" id="days_0"  readonly="readonly"
							value="" />
							<span class="fp_span1">日均价(元)：</span>
							<input  class="input_amonut" name="average" id="average_0" readonly="readonly"
							value="" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">住宿人员：</span>
						<a href="#" id="choose_0" onclick="chooseUser(this)">
							<input  class="input_amonut1" name="people" id="people_0" readonly="readonly"  placeholder=" 请选择"
							value="" />
						</a>	
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">备注：</span>
							<input  class="input_amonut1" name="remark" id="remark_0" 
							value="" />
						</p>
						<p style="margin-bottom:5px;">
							<span style="width: 85px;display: inline-block;">核验结果：</span>
							<span style="width: 80px;display: inline-block;" id="checkTrue_0" >
								<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">
							</span>
							<span style="width: 45px;display: inline-block;" id="checkRepet_0"></span>
						</p>
					</div>
				</td>	
			</tr>
			</tbody>
	</table>
</form>	
	<div style="height:10px"></div>
<form id="form2">		
	<table id="tableFood" class="window-table-readonly" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:12.6%;">
					<p style=" color:#0000CD;">伙食费</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p id="p_foodMoney">${meetingBean.foodMoney}元</p>
				</td>
				<td>
				<a onclick="append1(this)" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/tjfp1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</td>
			</tr>
			
			<tbody id="food_0" >
			<tr>
				<td class="td1">
					&nbsp;&nbsp;<span id="foodFp_0">发票1</span>
					<input type="text" id="fp_1" name="fileId" hidden="hidden">
					<input type="file" id="image_1" onchange="upImageFile2(this)" hidden="hidden">
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_1">
					<a onclick="clickUpFile(this)" id="click_1" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</td>	
			</tr>

			<tr>
				<!-- <td class=""></td> -->
				<td class="td2" colspan="5" id="">
					<div style="width: auto; height:auto;margin-top:5px;margin-left:49px;">
						<p style="margin-bottom:5px;">
							<span class="fp_span">票面金额(元)：</span>
							<input  class="input_amonut a" name="amount"  id="amount_1" class="" onchange="addAmonut(this)"
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="" />
							<span class="fp_span1">专项税额(元)：</span>
							<input  class="input_amonut" name="tax" id="tax_1" 
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">开票时间：</span>
							<input  class="input_amonut" name="time" id="time_1" type="date"
							value="" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">备注：</span>
							<input  class="input_amonut1" name="remark" id="remark_1" 
							value="" />
						</p>
						<p style="margin-bottom:5px;">
							<span style="width: 85px;display: inline-block;">核验结果：</span>
							<span style="width: 80px;display: inline-block;" id="checkTrue_1">
								<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">
							</span>
							<span style="width: 45px;display: inline-block;" id="checkRepet_1"></span>
						</p>
					</div>
				</td>	
			</tr>
			</tbody>
	</table>
</form>	
	<div style="height:10px"></div>
<form id="form3">
	<table id="tableOther" class="window-table-readonly" cellspacing="0" cellpadding="0" style="">
			<tr>
				<td class="window-table-td1"><p>费用名称：</p></td>
				<td class="window-table-td2" style="width:12.6%">
					<p style=" color:#0000CD;">其他费用</p>
				</td>
				<td class="window-table-td1"><p>申请金额：</p></td>
				<td class="window-table-td2" style="width:17%">
					<p id="p_otherMoney">${meetingBean.otherMoney}元</p>
				</td>
				<td class="">
					<a onclick="append2(this)" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/tjfp1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</td>
			</tr>
			
			<tbody id="other_0" >
			<tr>
				<td class="td1">
					&nbsp;&nbsp;<span id="otherFp_0">发票1</span>
					<input type="text" id="fp_2" name="fileId" hidden="hidden">
					<input type="file" id="image_2" onchange="upImageFile3(this)" hidden="hidden">
				</td>
				<td class="td2" colspan="4" id="zfbimagetd_2">
					<a onclick="clickUpFile(this)" id="click_2" style="font-weight: bold;" href="#">
						<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
					</a>
				</td>	
			</tr>

			<tr>
				<!-- <td class=""></td> -->
				<td class="td2" colspan="5" id="">
					<div style="width: auto; height:auto;margin-top:5px;margin-left:49px;">
						<p style="margin-bottom:5px;">
							<span class="fp_span">票面金额(元)：</span>
							<input  class="input_amonut a" name="amount" id="amount_2"   onchange="addAmonut(this)"
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="" />
							<span class="fp_span1">专项税额(元)：</span>
							<input  class="input_amonut" name="tax" id="tax_2" 
							oninput = "value=value.replace(/^\D*(\d*(?:\.\d{0,2})?).*$/g, '$1')" value="" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">开票时间：</span>
							<input  class="input_amonut" name="time" id="time_2" type="date"
							value="" />
						</p>
						<p style="margin-bottom:5px;">
							<span class="fp_span">备注：</span>
							<input  class="input_amonut1" name="remark" id="remark_2" 
							value="" />
						</p>
						<p style="margin-bottom:10px;">
							<span style="width: 85px;display: inline-block;">核验结果：</span>
							<span style="width: 80px;display: inline-block;" id="checkTrue_2">
								<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">
							</span>
							<span style="width: 45px;display: inline-block;" id="checkRepet_2"></span>
						</p>
					</div>
				</td>	
			</tr>
	</table>
</form>	
<script type="text/javascript">
var index =2;//页面tbody默认原始数   减一
var a =0;
var b =0;
var c =0;
$(function(){
/* 	for(var i=0; i<=index; i++){
		
	$('#startTime' + i).change(function(){
		countDays(i);
		});
	$('#endTime' + i).change(function(){
		countDays(i);
		});
	} */
});
//计算报销金额
function addAmonut(obj){
	var totalAmount=0;
    var tags = [];
    $(".a").each(function(i,e){
        tags[i]= e.value;
        var num =parseFloat(tags[i]);
        if(!isNaN(num)){
        	totalAmount+=num;
        }
      });
    $('#p_amount').html(fomatMoney(totalAmount,2)+" [元]");
    $('#reimburseAmount').val(totalAmount.toFixed(2));
      countDays(obj);
      cx();
}

function countDays(obj){
	var id=obj.id;
	var j=id.lastIndexOf("\_");
	var i=id.substring(j+1,id.length);
	var time1 =new Date($('#startTime_' + i).val());
	var time2 =new Date($('#endTime_' + i).val());
	var d = (time2 - time1) / 86400000 + 1;
	if (d > 0) {
		var amount =parseFloat($('#amount_' + i).val());
		if(!isNaN(amount)){
			var average =(amount/d).toFixed(2);
			$('#average_' + i).val(average);
		}
	$('#days_' + i).val(d);
	}else{
	$('#days_' + i).val("");
	}
}



function append(obj){
		index=index+1;
		var addItem = $('#hotel_0').clone(true);
		addItem.attr('id', "hotel_" + (a+1));
		var amount = addItem.find('#amount_0' ); //根据id查找子元素
		var tax = addItem.find('#tax_0' );
		var time = addItem.find('#time_0' );
		var unit = addItem.find('#unit_0' );
		var startTime = addItem.find('#startTime_0' );
		var endTime = addItem.find('#endTime_0' );
		var days = addItem.find('#days_0' );
		var average = addItem.find('#average_0' );
		var people = addItem.find('#people_0' );
		var remark = addItem.find('#remark_0' );
		var fp = addItem.find('#fp_0' );
		var image = addItem.find('#image_0' );
		var zfbimagetd = addItem.find('#zfbimagetd_0' );
		var click = addItem.find('#click_0' );
		var sc = addItem.find('#sc_0' );
		var checkTrue = addItem.find('#checkTrue_0' );
		var checkRepet = addItem.find('#checkRepet_0' );
		var hotelFp = addItem.find('#hotelFp_0' );
		var choose = addItem.find('#choose_0' );
		amount.attr("id", "amount_" + index); //改变克隆子元素节点
		tax.attr("id", "tax_" + index); //改变克隆元素子节点
		time.attr("id", "time_" + index); //改变克隆子元素节点
		unit.attr("id", "unit_" + index); //改变克隆子元素节点
		startTime.attr("id", "startTime_" + index); //改变克隆子元素节点
		endTime.attr("id", "endTime_" + index); //改变克隆子元素节点
		days.attr("id", "days_" + index); //改变克隆子元素节点
		average.attr("id", "average_" + index); //改变克隆子元素节点
		people.attr("id", "people_" + index); //改变克隆子元素节点
		remark.attr("id", "remark_" + index); //改变克隆子元素节点
		fp.attr("id", "fp_" + index); //改变克隆子元素节点
		image.attr("id", "image_" + index); //改变克隆子元素节点
		zfbimagetd.attr("id", "zfbimagetd_" + index); //改变克隆子元素节点
		click.attr("id", "click_" + index); //改变克隆子元素节点
		sc.attr("id", "sc_" + index); //改变克隆子元素节点
		checkTrue.attr("id", "checkTrue_" + index); //改变克隆子元素节点
		checkRepet.attr("id", "checkRepet_" + index); //改变克隆子元素节点
		hotelFp.attr("id", "hotelFp_" + (a+1)); //改变克隆子元素节点
		choose.attr("id", "choose_" + index); //改变克隆子元素节点
		$('#hotel_0').after(addItem);
		$('#zfbimagetd_'+index).empty();
		$('#zfbimagetd_'+index).append('<a onclick="clickUpFile(this)" id="click_'+index+'" style="font-weight: bold;" href="#">'+
			'<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>'
				+'<a onclick="deleteMeeting(this)" '
				+ index
				+ '" style="float: right;" href="#">'
				+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
				+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
		$('#amount_' + index).val("");
		$('#tax_' + index).val("");
		$('#time_' + index).val("");
		$('#unit_' +index).val("");
		$('#startTime_' + index).val("");
		$('#endTime_' + index).val("");
		$('#days_' + index).val("");
		$('#average_' + index).val("");
		$('#people_' + index).val("");
		$('#remark_' + index).val("");
		$('#fp_' + index).val(null);
		$('#checkTrue_' + index).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">');
		$('#checkRepet_' + index).html("");
		
		var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
		for (var i = 1; i < fromNum.length; i++) {
			var s = fromNum[i].children[0].children[0].children[0].id;
			$('#' + s).html("发票"+i);
			}
		a =a+1;
	}
function append1(obj){
	index=index+1;
	var addItem = $('#food_0').clone(true);
	addItem.attr('id', "food_" + (b+1));
	var amount = addItem.find('#amount_1' ); //根据id查找子元素
	var tax = addItem.find('#tax_1' );
	var time = addItem.find('#time_1' );
	var remark = addItem.find('#remark_1' );
	var fp = addItem.find('#fp_1' );
	var image = addItem.find('#image_1' );
	var zfbimagetd = addItem.find('#zfbimagetd_1' );
	var click = addItem.find('#click_1' );
	var sc = addItem.find('#sc_1' );
	var checkTrue = addItem.find('#checkTrue_1' );
	var checkRepet = addItem.find('#checkRepet_1' );
	var foodFp = addItem.find('#foodFp_0' );
	amount.attr("id", "amount_" + index); //改变克隆子元素节点
	tax.attr("id", "tax_" + index); //改变克隆元素子节点
	time.attr("id", "time_" + index); //改变克隆子元素节点
	remark.attr("id", "remark_" + index); //改变克隆子元素节点
	fp.attr("id", "fp_" + index); //改变克隆子元素节点
	image.attr("id", "image_" + index); //改变克隆子元素节点
	zfbimagetd.attr("id", "zfbimagetd_" + index); //改变克隆子元素节点
	click.attr("id", "click_" + index); //改变克隆子元素节点
	sc.attr("id", "sc_" + index); //改变克隆子元素节点
	foodFp.attr("id", "foodFp_" + (b+1)); //改变克隆子元素节点
	checkTrue.attr("id", "checkTrue_" + index); //改变克隆子元素节点
	checkRepet.attr("id", "checkRepet_" + index); //改变克隆子元素节点
	$('#food_0').after(addItem);
	$('#zfbimagetd_'+index).empty();
	$('#zfbimagetd_'+index).append('<a onclick="clickUpFile(this)" id="click_'+index+'" style="font-weight: bold;" href="#">'+
		'<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>'
			+'<a onclick="deleteMeeting(this)" '
			+ index
			+ '" style="float: right;" href="#">'
			+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
			+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
	$('#amount_' + index).val("");
	$('#tax_' + index).val("");
	$('#time_' + index).val("");
	$('#remark_' + index).val("");
	$('#fp_' + index).val(null);
	$('#checkTrue_' + index).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">');
	$('#checkRepet_' + index).html("");
	
	var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
	for (var i = 1; i < fromNum.length; i++) {
		var s = fromNum[i].children[0].children[0].children[0].id;
		$('#' + s).html("发票"+i);
		}
	b =b+1;
}
function append2(obj){
	index=index+1;
	var addItem = $('#other_0').clone(true);
	addItem.attr('id', "other_" + (c+1));
	var amount = addItem.find('#amount_2' ); //根据id查找子元素
	var tax = addItem.find('#tax_2' );
	var time = addItem.find('#time_2' );
	var remark = addItem.find('#remark_2' );
	var fp = addItem.find('#fp_2' );
	var image = addItem.find('#image_2' );
	var zfbimagetd = addItem.find('#zfbimagetd_2' );
	var click = addItem.find('#click_2' );
	var sc = addItem.find('#sc_2' );
	var checkTrue = addItem.find('#checkTrue_2' );
	var checkRepet = addItem.find('#checkRepet_2' );
	var otherFp = addItem.find('#otherFp_0' );
	amount.attr("id", "amount_" + index); //改变克隆子元素节点
	tax.attr("id", "tax_" + index); //改变克隆元素子节点
	time.attr("id", "time_" + index); //改变克隆子元素节点
	remark.attr("id", "remark_" + index); //改变克隆子元素节点
	fp.attr("id", "fp_" + index); //改变克隆子元素节点
	image.attr("id", "image_" + index); //改变克隆子元素节点
	zfbimagetd.attr("id", "zfbimagetd_" + index); //改变克隆子元素节点
	click.attr("id", "click_" + index); //改变克隆子元素节点
	sc.attr("id", "sc_" + index); //改变克隆子元素节点
	checkTrue.attr("id", "checkTrue_" + index); //改变克隆子元素节点
	checkRepet.attr("id", "checkRepet_" + index); //改变克隆子元素节点
	otherFp.attr("id", "otherFp_" + (c+1)); //改变克隆子元素节点
	$('#other_0').after(addItem);
	$('#zfbimagetd_'+index).empty();
	$('#zfbimagetd_'+index).append('<a onclick="clickUpFile(this)" id="click_'+index+'" style="font-weight: bold;" href="#">'+
		'<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>'
			+'<a onclick="deleteMeeting(this)" '
			+ index
			+ '" style="float: right;" href="#">'
			+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
			+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
	$('#amount_' + index).val("");
	$('#tax_' + index).val("");
	$('#time_' + index).val("");
	$('#remark_' + index).val("");
	$('#fp_' + index).val(null);
	$('#checkTrue_' + index).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">');
	$('#checkRepet_' + index).html("");
	
	var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
	for (var i = 1; i < fromNum.length; i++) {
		var s = fromNum[i].children[0].children[0].children[0].id;
		$('#' + s).html("发票"+i);
		}
	c=c+1;
}
	//将表单序列化成json格式的数据(但不适用于含有控件的表单，例如复选框、多选的select)
	(function($) {
		$.fn.serializeJson = function() {
			var jsonData1 = {};
			var serializeArray = this.serializeArray();
			// 先转换成{"id": ["12","14"], "name": ["aaa","bbb"], "pwd":["pwd1","pwd2"]}这种形式
			$(serializeArray).each(
					function() {
						if (jsonData1[this.name]) {
							if ($.isArray(jsonData1[this.name])) {
								jsonData1[this.name].push(this.value);
							} else {
								jsonData1[this.name] = [ jsonData1[this.name],
										this.value ];
							}
						} else {
							jsonData1[this.name] = this.value;
						}
					});
			// 再转成[{"id": "12", "name": "aaa", "pwd":"pwd1"},{"id": "14", "name": "bb", "pwd":"pwd2"}]的形式
			var vCount = 0;
			// 计算json内部的数组最大长度
			for ( var item in jsonData1) {
				var tmp = $.isArray(jsonData1[item]) ? jsonData1[item].length
						: 1;
				vCount = (tmp > vCount) ? tmp : vCount;
			}

			if (vCount > 1) {
				var jsonData2 = new Array();
				for (var i = 0; i < vCount; i++) {
					var jsonObj = {};
					for ( var item in jsonData1) {
						jsonObj[item] = jsonData1[item][i];
					}
					jsonData2.push(jsonObj);
				}
				return JSON.stringify(jsonData2);
			} else {
				return "[" + JSON.stringify(jsonData1) + "]";
			}
		};
	})(jQuery);
	
	
	function clickUpFile(obj) {
		var id =obj.id;
		 var i=id.lastIndexOf("\_");
	     var j=id.substring(i+1,id.length);
			$('#image_'+ j).click();
	}

	//上传图片文件转化为base64在页面显示
	function upImageFile1(obj) {
		var id =obj.id;
		 var i=id.lastIndexOf("\_");
	     var j=id.substring(i+1,id.length);
		if(obj==null||obj=="") {
			return;
		}
		var files = obj.files;
		var formData = new FormData();
		for(var i=0; i< files.length; i++){
			formData.append("imageFile",files[i]);//图片文件
			/* formData.append("imageType",type); //类型1支付宝、2微信 */
			$.ajax({ 
				url: base + '/base64/uploadImage' ,
				type: 'post',  
		        data: formData,
		        cache: false,
		        processData: false,
		        contentType: false,
		        async: false,
		        dataType:'json',
		        success:function(data){
			        	upladFp(obj,"hotel","fp02");
			        	
			        	$('#image_'+j).val("");
			        	var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
			        	$('#zfbimagetd_'+j).empty();
			        	var x=fromNum[1].id.lastIndexOf("\_");
				   	     var y=fromNum[1].id.substring(x+1,fromNum[1].id.length);
				        	if(y!=0){
				        		$('#zfbimagetd_'+j).append('<img style="vertical-align:bottom;margin-left:30px; width: 100px;height: 73px" src="'+data+'" onclick="yl(this.src)"/><a style="color:red" href="#" id="sc_'+j+'" onclick="deleteImage(this)">    删除</a>'
										+'<a onclick="deleteMeeting(this)" style="float: right;" href="#">'
										+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
										+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
				        	}else{
				        		$('#zfbimagetd_'+j).append('<img style="vertical-align:bottom;margin-left:30px; width: 100px;height: 73px" src="'+data+'" onclick="yl(this.src)"/><a style="color:red" href="#" id="sc_'+j+'" onclick="deleteImage(this)">    删除</a>');
				        	}
			        	
			        	$('#checkTrue_'+j).html('<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/left/zp.png">');
			        	$('#checkRepet_'+j).html('<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/left/wcf.png">');
		        }
			});
		} 
	}
	
	function upImageFile2(obj) {
		var id =obj.id;
		 var i=id.lastIndexOf("\_");
	     var j=id.substring(i+1,id.length);
		if(obj==null||obj=="") {
			return;
		}
		var files = obj.files;
		var formData = new FormData();
		for(var i=0; i< files.length; i++){
			formData.append("imageFile",files[i]);//图片文件
			/* formData.append("imageType",type); //类型1支付宝、2微信 */
			$.ajax({ 
				url: base + '/base64/uploadImage' ,
				type: 'post',  
		        data: formData,
		        cache: false,
		        processData: false,
		        contentType: false,
		        async: false,
		        dataType:'json',
		        success:function(data){
		        	console.log(obj);
		        	
			        	upladFp(obj,"food","fp02");
			        	$('#image_'+j).val("");
			        	var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
			        	$('#zfbimagetd_'+j).empty();
			        	var x=fromNum[1].id.lastIndexOf("\_");
				   	     var y=fromNum[1].id.substring(x+1,fromNum[1].id.length);
				        	if(y!=0){
				        		$('#zfbimagetd_'+j).append('<img style="vertical-align:bottom;margin-left:30px; width: 100px;height: 73px" src="'+data+'" onclick="yl(this.src)"/><a style="color:red" href="#" id="sc_'+j+'" onclick="deleteImage(this)">    删除</a>'
										+'<a onclick="deleteMeeting(this)" style="float: right;" href="#">'
										+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
										+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
				        	}else{
				        		$('#zfbimagetd_'+j).append('<img style="vertical-align:bottom;margin-left:30px; width: 100px;height: 73px" src="'+data+'" onclick="yl(this.src)"/><a style="color:red" href="#" id="sc_'+j+'" onclick="deleteImage(this)">    删除</a>');
				        	}
			        	$('#checkTrue_'+j).html('<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/left/zp.png">');
			        	$('#checkRepet_'+j).html('<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/left/wcf.png">');
		        }
			});
		} 
	}

	function upImageFile3(obj) {
		var id =obj.id;
		 var i=id.lastIndexOf("\_");
	     var j=id.substring(i+1,id.length);
		if(obj==null||obj=="") {
			return;
		}
		var files = obj.files;
		var formData = new FormData();
		for(var i=0; i< files.length; i++){
			formData.append("imageFile",files[i]);//图片文件
			/* formData.append("imageType",type); //类型1支付宝、2微信 */
			$.ajax({ 
				url: base + '/base64/uploadImage' ,
				type: 'post',  
		        data: formData,
		        cache: false,
		        processData: false,
		        contentType: false,
		        async: false,
		        dataType:'json',
		        success:function(data){
		        	console.log(obj);
			        	upladFp(obj,"other","fp02",j);
			        	var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
			        	$('#zfbimagetd_'+j).empty();
			        	$('#image_'+j).val("");
			        	var x=fromNum[1].id.lastIndexOf("\_");
				   	     var y=fromNum[1].id.substring(x+1,fromNum[1].id.length);
				        	if(y!=0){
				        		$('#zfbimagetd_'+j).append('<img style="vertical-align:bottom;margin-left:30px; width: 100px;height: 73px" src="'+data+'" onclick="yl(this.src)"/><a style="color:red" href="#" id="sc_'+j+'" onclick="deleteImage(this)">    删除</a>'
										+'<a onclick="deleteMeeting(this)" style="float: right;" href="#">'
										+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
										+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
				        	}else{
				        		$('#zfbimagetd_'+j).append('<img style="vertical-align:bottom;margin-left:30px; width: 100px;height: 73px" src="'+data+'" onclick="yl(this.src)"/><a style="color:red" href="#" id="sc_'+j+'" onclick="deleteImage(this)">    删除</a>');
				        	}
			        	$('#checkTrue_'+j).html('<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/left/zp.png">');
			        	$('#checkRepet_'+j).html('<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/left/wcf.png">');
		        }
			});
		} 
	}


	//删除上传的图片
	function deleteImage(obj) {
		var id =obj.id;
		 var i=id.lastIndexOf("\_");
	     var j=id.substring(i+1,id.length);
			var fromNum = obj.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children;
			$('#zfbimagetd_'+j).empty();
			
			var x=fromNum[1].id.lastIndexOf("\_");
	   	     var y=fromNum[1].id.substring(x+1,fromNum[1].id.length);
		   	  if(y!=0){
		   		$('#zfbimagetd_'+j).append('<a onclick="clickUpFile(this)" id="click_'+j+'" style="font-weight: bold;" href="#">'+
						'<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)"'
						+' onMouseOut="mouseOut(this)"></a>'
						+'<a onclick="deleteMeeting(this)" style="float: right;" href="#">'
						+ '<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/scyh1.png"'
						+' onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
	      	}else{
	      		$('#zfbimagetd_'+j).append('<a onclick="clickUpFile(this)" id="click_'+j+'" style="font-weight: bold;" href="#">'+
						'<img style="vertical-align:bottom;margin-left:30px" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)"'
						+' onMouseOut="mouseOut(this)"></a>');
	      	}
			$('#fp_'+j).val(null);
			$('#checkTrue_'+j).html('<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/left/dyz.png">');
			$('#checkRepet_'+j).html("");
	}
	//选择人员
	function chooseUser(obj){
		var id =obj.id;
		var i=id.lastIndexOf("\_");
	    var j=id.substring(i+1,id.length);
		var win=creatSecondWin('选择住宿人员',860,580,'icon-search','/user/chooseUser?index='+j+''); 
		win.window('open');
	}
	//预览图片
	function yl(e){
	    var large='<img width="596px" height="453px" src=' +e+ '></img>';
	    $("#divlarge").html(large).animate({
	        height:'30%',
	        width:'30%'
	    },1);
	    $("#dlgdiv").dialog("open").dialog("setTitle", "预览");
}
	
	
	function  deleteMeeting(item){
		var fromNum = item.parentNode.parentNode.parentNode.parentNode.parentNode.children[0].children.length;
		var id = item.parentNode.parentNode.parentNode.id;
		$("#"+id).remove();
		var arr=id.split("_");
		for(var i=1;i<fromNum-1;i++){
			if('hotel'==arr[0]){
				var tableId = $('#tableHotel').find('tbody');
				var fapiao = tableId[i].children[0].children[0].children[0].id;
				$("#"+fapiao).html("发票"+i);
			}
			if('food'==arr[0]){
				var tableId = $('#tableFood').find('tbody');
				var fapiao = tableId[i].children[0].children[0].children[0].id;
				$("#"+fapiao).html("发票"+i);
			}
			if('other'==arr[0]){
				var tableId = $('#tableOther').find('tbody');
				var fapiao = tableId[i].children[0].children[0].children[0].id;
				$("#"+fapiao).html("发票"+i);
			}
			
		}
		addAmonut(item);
		return ;
	}
</script>
