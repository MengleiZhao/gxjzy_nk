<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<table cellpadding="0" cellspacing="0" class="window-table">
	<!-- 隐藏域主键 --> 
	<input type="hidden" name="trId" value="${travelBean.trId}" readonly="readonly"/>
	<input type="hidden" id="travelTypeHi" value="${travelBean.travelType}" />
	<input type="hidden" id="wagesPlanHi" value="${travelBean.wagesPlan}" />
	<input type="hidden" id="expensePlanHi" value="${travelBean.expensePlan}" />
	<%-- <tr class="trbody">
		<td class="td1">出发地</td>
		<td class="td2">
			<input class="easyui-combobox" style="width: 92px;" id="placeStart2"
			data-options="url:base+'/area/placeEndJson?sonCode=${travelBean.placeStart}',
						method:'get',valueField:'code',textField:'text',editable:false"/>
			
			&nbsp;&nbsp;
				    
			<input class="easyui-combobox" style="width: 92px;" id="placeStart1"
			data-options="url:base+'/area/placeEndJson?code=${travelBean.placeStart}',
						method:'get',valueField:'code',textField:'text',editable:false"/>
		</td>

		<td class="td4">
		</td>

		<td class="td1">目的地</td>
		<td class="td2">
			<input class="easyui-combobox" style="width: 92px;" id="placeEnd2"
			data-options="url:base+'/area/placeEndJson?sonCode=${travelBean.placeEnd}',
						method:'get',valueField:'code',textField:'text',editable:false"/>
			
			&nbsp;&nbsp;
				    
			<input class="easyui-combobox" style="width: 92px;" id="placeEnd1"
			data-options="url:base+'/area/placeEndJson?code=${travelBean.placeEnd}',
						method:'get',valueField:'code',textField:'text',editable:false"/>
		</td>
	</tr> --%>
	
	<!-- 选择出差地区 -->
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 出差地区</td>
		<td class="td2">
			<input id="travel_add_placeEnd" name="travelArea.area" value="${travelBean.travelArea.area}" class="easyui-textbox" style="width: 200px; height: 30px;" 
			readonly="readonly"  required="required"/>
		</td>
		
		<td class="td4" style="width: 65px;"></td>
		
		<%-- <td class="td1"><span class="style1">*</span>差旅配置id</td>
		<td class="td2">
			<div class="easyui-panel" data-options="closed:true">
				<input id="travel_add_placeEnd_id" name="travelArea.id" value="${travelBean.travelArea.id}" class="easyui-textbox" style="width: 200px; height: 30px;" 
				data-options="editable:false"/>
			</div>
		</td> --%>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 开始日期</td>
		<td class="td2"><input type="text" style="width: 200px; height: 30px;" id="travelDateStarts"
			name="travelDateStart" class="easyui-datebox"
			value="${travelBean.travelDateStart}" readonly="readonly"></input></td>

		<td class="td4" style="width: 65px;"></td>

		<td class="td1"><span class="style1">*</span> 结束日期</td>
		<td class="td2"><input type="text" style="width: 200px; height: 30px;" id="travelDateEnds"
			name="travelDateEnd" class="easyui-datebox"
			value="${travelBean.travelDateEnd}" readonly="readonly"></input>
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 出差天数</td>
		<td class="td2"><input type="text" style="width: 200px; height: 30px;" id=""
			name="travelDayNum" class="easyui-numberbox"
			value="${travelBean.travelDayNum}" readonly="readonly"></input></td>

		<td class="td4" style="width: 65px;"></td>

		<td class="td1"><span class="style1">*</span> 住宿天数</td>
		<td class="td2"><input type="text" style="width: 200px; height: 30px;" id=""
			name="hotelDayNum" class="easyui-numberbox"
			value="${travelBean.hotelDayNum}" readonly="readonly"></input></td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 出差类型</td>
		<td class="td2">
			<select id="travelType" class="easyui-combobox"
			name="travelType" style="width: 200px; height: 30px;">
				<option value="1">公务出差</option>
				<option value="2">非公务出差</option>
			</select>
		</td>

		<td class="td4" style="width: 65px;"></td>

		<td class="td1"><span class="style1">*</span> 出差人</td>
		<td class="td2"><input type="text" style="width: 200px; height: 30px;" id=""
			name="travelAttendPeop" class="easyui-textbox"
			value="${bean.userName}" readonly="readonly"></input></td>
	</tr>



	
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 交通工具</td>
		<td class="td2">
			<input class="easyui-combobox" style="width: 200px;height: 30px;"   readonly="readonly" name="vehicle" id="vehicle"
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
			<input class="easyui-combobox" style="width: 200px;height: 30px;"  readonly="readonly" name="vehicleLevel" id="vehicleLevel"
			data-options="url:base+'/vehicle/comboboxJson?selected=${travelBean.vehicleLevel}&parentCode=${travelBean.vehicle}',
						method:'get',valueField:'code',textField:'text',editable:false"/>
		</td>
		<td class="td1" id="vehicleOther1" style="display: none"><span class="style1">*</span> 其他交通工具</td>
		<td class="td2" id="vehicleOther2" style="display: none">
			<input class="easyui-textbox" style="width: 200px; height: 30px;"  readonly="readonly" name="vehicleOther"
			value="${travelBean.vehicleOther}" data-options="validType:'length[1,100]'"/>
		</td>
	</tr>
	
	
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 伙食费用安排</td>
		<td class="td2">
			<select id="wagesPlan" class="easyui-combobox" name="wagesPlan" style="width: 200px; height: 30px;">
				<option value="1">单位支付</option>
				<option value="2">自行安排</option>
			</select>
		</td>

		<td class="td4" style="width: 65px;"></td>

		<td class="td1"><span class="style1">*</span> 住宿费用安排</td>
		<td class="td2">
			<select id="expensePlan" class="easyui-combobox" name="expensePlan" style="width: 200px; height: 30px;">
				<option value="1">单位支付</option>
				<option value="2">自行安排</option>
			</select>
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1">伙食费补助天数</td>
		<td class="td2"><input type="text" style="width: 200px; height: 30px;" id="foodDayNum"
			name="foodDayNum" class="easyui-numberbox"
			value="${travelBean.foodDayNum}" readonly="readonly"></input></td>

		<td class="td4" style="width: 65px;"></td>

		<td class="td1">住宿费补助天数</td>
		<td class="td2"><input type="text" style="width: 200px; height: 30px;" id="traDayNum"
			name="traDayNum" class="easyui-numberbox"
			value="${travelBean.traDayNum}" readonly="readonly"></input></td>
	</tr>

	<%-- <tr class="trbody">
		<td class="td1">人员备注</td>
		<td colspan="4"><input class="easyui-textbox"
			name="traPeopRemark" style="width:555px;;"
			value="${tPeopBean.traPeopRemark}" readonly="readonly"></td>
	</tr> --%>


</table>

<script type="text/javascript">

$("#travelDateStarts").datebox({
    onSelect : function(beginDate){
        $('#travelDateEnds').datebox().datebox('calendar').calendar({
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
		var l = $("#expensePlanHi").textbox().textbox('getValue');
		if (l != "") {
			$('#expensePlan').textbox().textbox('setValue', l);
		}
		
		$('#travelType').textbox().attr('readonly', true);
		$('#wagesPlan').textbox().attr('readonly', true);
		$('#expensePlan').textbox().attr('readonly', true);
	});
</script>
