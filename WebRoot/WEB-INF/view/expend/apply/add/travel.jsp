<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<table class="window-table" cellspacing="0" cellpadding="0">
			<!-- 隐藏域 -->
			<input type="hidden" name="trId" value="${travelBean.trId}" />
			<input type="hidden" name="travelRId" value="${tPeopBean.travelRId}" />
			<input type="hidden" id="travelTypeHi" value="${travelBean.travelType}" />
			<input type="hidden" id="wagesPlanHi" value="${travelBean.wagesPlan}" />
			<input type="hidden" id="expensePlanHi" value="${travelBean.expensePlan}" />
	<c:if test="${!empty travelBean.placeStart}">
	<tr class="trbody">
		<td colspan="5"><span style="color:#ff6800">系统已智能为您匹配常用的出差地区</span></td>
	</tr>
	</c:if>

	<!-- 选择出差地区 -->
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 出差地区</td>
		<td class="td2" onclick="chooseArea()">
			<input id="travel_add_placeEnd" name="travelArea.area" value="${travelBean.travelArea.area}" class="easyui-textbox" style="width: 200px; height: 30px;" 
			data-options="editable:false,prompt: '选择出差地' ,icons: [{iconCls:'icon-sousuo'}]"  required="required"/>
		</td>
		
		<td class="td4" style="width: 65px;"></td>
		
		<td class="td1"><!-- <span class="style1">*</span>差旅配置id --></td>
		<td class="td2">
			<div class="easyui-panel" data-options="closed:true">
				<input id="travel_add_placeEnd_id" name="travelArea.id" value="${travelBean.travelArea.id}" class="easyui-textbox" style="width: 200px; height: 30px;" 
				data-options="editable:false"/>
			</div>
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 开始日期</td>
		<td class="td2">
			<input id="travel_add_ksrq" class="easyui-datebox" style="width: 200px; height: 30px;" name="travelDateStart"
			data-options="" value="${travelBean.travelDateStart}" required="required" editable="false"/>
		</td>

		<td class="td4" style="width: 65px;"></td>

		<td class="td1"><span class="style1">*</span> 结束日期</td>
		<td class="td2">
			<input id="travel_add_jsrq" class="easyui-datebox" style="width: 200px; height: 30px;" name="travelDateEnd"
			data-options="onSelect:onSelect6" value="${travelBean.travelDateEnd}" required="required" editable="false"/>
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 出差天数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 200px; height: 30px;" id="travelDayNum" name="travelDayNum"
			value="${travelBean.travelDayNum}" readonly="readonly" required="required" data-options="validType:'length[1,2]'"/>
		</td>

		<td class="td4" style="width: 65px;"></td>

		<td class="td1"><span class="style1">*</span> 住宿天数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 200px; height: 30px;" id="hotelDayNum" name="hotelDayNum"
			value="${travelBean.hotelDayNum}"  required="required"  data-options="validType:'length[1,2]'"/>
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 出差类型</td>
		<td class="td2">
			<select id="travelType" class="easyui-combobox" name="travelType" style="width: 200px; height: 30px;" required="required" editable="false">
				<option value="1">公务出差</option>
				<option value="2">非公务出差</option>
		</select>
		</td>

		<td class="td4" style="width: 65px;"></td>

		<td class="td1"><span class="style1">*</span> 出差人</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 200px; height: 30px;" name="travelAttendPeop"
			value="${bean.userName}" readonly="readonly" required="required" data-options="validType:'length[1,100]'"/>
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 交通工具</td>
		<td class="td2">
			<%-- <input class="easyui-textbox" style="width: 200px; height: 30px;" name="vehicle" value="${travelBean.vehicle}" required="required" data-options="validType:'length[1,10]'"> --%>
			<input class="easyui-combobox" style="width: 200px;height: 30px;" name="vehicle" id="vehicle"
			data-options="url:base+'/vehicle/comboboxJson?selected=${travelBean.vehicle}',
						method:'get',valueField:'code',textField:'text',editable:false,
						onSelect: function(rec){
						//如果选择其他，就显示手动输入框
				    	if(rec.code !='JTGJ06'){
							$('#vehicleLevel1').css('display','');
							$('#vehicleLevel2').css('display','');
							$('#vehicleOther1').css('display','none');
							$('#vehicleOther2').css('display','none');
							var url = base+'/vehicle/comboboxJson?selected=${travelBean.vehicle}&parentCode='+rec.code;
					    	$('#vehicleLevel').combobox('reload', url);
						}else{
							$('#vehicleOther1').css('display','');
							$('#vehicleOther2').css('display','');
							$('#vehicleLevel1').css('display','none');
							$('#vehicleLevel2').css('display','none');
						}
					    }"/>
		</td>

		<td class="td4" style="width: 65px;"></td>
		<td class="td1" id="vehicleLevel1"><span class="style1">*</span> 交通工具等级</td>
		<td class="td2"  id="vehicleLevel2">
			<input class="easyui-combobox" style="width: 200px;height: 30px;" name="vehicleLevel" id="vehicleLevel"
			data-options="url:base+'/vehicle/comboboxJson?selected=${travelBean.vehicleLevel}&parentCode=${travelBean.vehicle}',
						method:'get',valueField:'code',textField:'text',editable:false"/>
		</td>
		<td class="td1" id="vehicleOther1" style="display: none"><span class="style1">*</span> 其他交通工具</td>
		<td class="td2" id="vehicleOther2" style="display: none">
			<input class="easyui-textbox" style="width: 200px; height: 30px;" name="vehicleOther"
			value="${travelBean.vehicleOther}" data-options="validType:'length[1,100]'"/>
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 伙食费用安排</td>
		<td class="td2">
			<select id="wagesPlan" class="easyui-combobox" name="wagesPlan" style="width: 200px; height: 30px;" required="required" editable="false">
				<option value="1">单位支付</option>
				<option value="2">自行安排</option>
			</select>
		</td>

		<td class="td4" style="width: 65px;"></td>

		<td class="td1"><span class="style1">*</span> 住宿费用安排</td>
		<td class="td2">
			<select id="expensePlan" class="easyui-combobox" name="expensePlan" style="width: 200px; height: 30px;" required="required" editable="false">
				<option value="1">单位支付</option>
				<option value="2">自行安排</option>
			</select>
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1">伙食费补助天数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 200px; height: 30px;" id="foodDayNum" name="foodDayNum"
			value="${travelBean.foodDayNum}" data-options="required:false,validType:'length[0,2]'">
		</td>

		<td class="td4" style="width: 65px;"></td>

		<td class="td1">住宿费补助天数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 200px; height: 30px;" id="traDayNum" name="traDayNum"
			value="${travelBean.traDayNum}" data-options="required:false,validType:'length[0,2]'"/>
		</td>
	</tr>
	<!-- 临时存放后台计算后返回的费用 -->
	<input id="container_travelCost" type="hidden"/>

	<%-- <tr class="trbody">
		<td class="td1">&nbsp;&nbsp;人员备注</td>
		<td colspan="4">
			<input class="easyui-textbox" name="traPeopRemark" style="width:555px;"
			value="${tPeopBean.traPeopRemark}" data-options="required:false,validType:'length[0,250]'"></td>
	</tr> --%>


</table>


<script type="text/javascript">

var startday4='${travelBean.travelDateStart}';
var endday4='${travelBean.travelDateEnd}';

$("#travel_add_ksrq").datebox({
    onSelect : function(beginDate){
    	
    	startday4 = beginDate;
    	var d = (endday4 - startday4) / 86400000 + 1;
    	if (d > 0) {
    		$('#travelDayNum').textbox("setValue", d);
    		$('#hotelDayNum').textbox("setValue", d - 1);
    	} else {
    		$('#travelDayNum').textbox("setValue", "");
    		$('#hotelDayNum').textbox("setValue", "");
    	}
        $('#travel_add_jsrq').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});
	$(document).ready(function() {
		//设值复选框的值
		var h = $("#travelTypeHi").textbox().textbox('getValue');
		if (h != "") {
			$('#travelType').textbox().textbox('setValue', h);
		}
		var n = $("#wagesPlanHi").textbox().textbox('getValue');
		if (n != "") {
			$('#wagesPlan').textbox().textbox('setValue', n);
		}
		var j = $("#expensePlanHi").textbox().textbox('getValue');
		if (j != "") {
			$('#expensePlan').textbox().textbox('setValue', j);
		}
		
		//修改出差地区/开始日期/结束日期 时，自动计算支出明细
		$('#travel_add_placeEnd').textbox({
			onChange:function(newValue,oldValue){
				calcTravelCost();
			}
		});
		$('#travel_add_ksrq').datebox({
			onChange:function(newValue,oldValue){
				calcTravelCost();
			}
		});
		$('#travel_add_jsrq').datebox({
			onChange:function(newValue,oldValue){
				calcTravelCost();
			}
		});
	});


	function onSelect6(date) {
		endday4 = date;
		startday4 = new Date(startday4);
		var d = (endday4 - startday4) / 86400000 + 1;
		if (d > 0) {
			$('#travelDayNum').textbox("setValue", d);
			$('#hotelDayNum').textbox("setValue", d - 1);
		} else {
			$('#travelDayNum').textbox("setValue", "");
			$('#hotelDayNum').textbox("setValue", "");
		}
	}

	$('#wagesPlan').combobox({
		onChange : function(newValue, oldValue) {
			if (newValue != 1) {
				$('#foodDayNum').numberbox('disable');
			} else {
				$('#foodDayNum').numberbox('enable');
			}
		}
	});
	$('#expensePlan').combobox({
		onChange : function(newValue, oldValue) {
			if (newValue != 1) {
				$('#traDayNum').numberbox('disable');
			} else {
				$('#traDayNum').numberbox('enable');
			}
		}
	});
	
	//自动获得费用明细
	function calcTravelCost(){
		
		var configId = $('#travel_add_placeEnd_id').textbox('getValue');
		var realDates = $('#travel_add_ksrq').datebox('getValue');
		var realDatee = $('#travel_add_jsrq').datebox('getValue');
		if(configId=='' || realDates=='' || realDatee==''){
			return;
		}
		
		$('#appli-detail-dg-travel').datagrid({
			url: base+'/hotelStandard/calcCost?outType=travel',
			queryParams:{
				configId: configId,
				travelDates: realDates,
				travelDatee: realDatee
			}
		});
	}
	
	function chooseArea(){
		var win = creatFirstWin('选择-出差地区', 640, 580, 'icon-search', '/hotelStandard/choose');
		win.window('open');
	}
	$(function(){
		$("#hotelDayNum").numberbox({
			onChange: function(newValue, oldValue) {
				calcTravelCost();//住宿天数改变，重新计算开支标准
			}
		});
	});
</script>
