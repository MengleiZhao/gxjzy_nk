<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<table cellpadding="0" cellspacing="0" class="window-table">
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 出国时间(开始)</td>
		<td class="td2">
			<input  style="width: 200px; height: 30px;" id="abroadDateStart" name="fAbroadDateStart" class="easyui-datebox" value="${abroad.fAbroadDateStart}" readonly="readonly"></input>
		</td>
		<td class="td4"></td>
		<td class="td1"><span class="style1">*</span> 出国时间(结束)</td>
		<td class="td2">
			<input  style="width: 200px; height: 30px;" id="abroadDateEnd" name="fAbroadDateEnd" class="easyui-datebox" value="${abroad.fAbroadDateEnd}" readonly="readonly"></input>
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 出国天数</td>
		<td class="td2">
			<input  style="width: 200px; height: 30px;" id="" name="fAbroadDayNum" class="easyui-textbox" value="${abroad.fAbroadDayNum}" readonly="readonly"></input> 
		</td>
		<td class="td4"></td>
		<td class="td1"><span class="style1">*</span> 出国人员</td>
		<td class="td2">
			<input  style="width: 200px; height: 30px;" id="" name="fAbroadPeople" class="easyui-textbox" value="${abroad.fAbroadPeople}" readonly="readonly"></input> 
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 任务类型</td>
		<td class="td2">
			<input  style="width: 200px; height: 30px;" id="" name="fTasjType" class="easyui-textbox" value="${abroad.fTasjType}" readonly="readonly"></input> 
		</td>
		<td class="td4"></td>
		<td class="td1"><span class="style1">*</span> 出访国家(地区)</td>
		<td class="td2">
			<input  style="width: 200px; height: 30px;" id="" name="fAbroadPlace" class="easyui-textbox" value="${abroad.fAbroadPlace}" readonly="readonly"></input> 
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 交通工具</td>
		<td class="td2"><input  style="width: 200px; height: 30px;" id="" name="fVehicle" class="easyui-textbox" value="${abroad.fVehicle}" readonly="readonly"></input>
		</td>
		<td class="td4"></td>
		<td class="td1"><span class="style1">*</span> 交通工具等级</td>
		<td class="td2">
			<input  style="width: 200px; height: 30px;" id="" name="fVehicleLevel" class="easyui-textbox" value="${abroad.fVehicleLevel}" readonly="readonly"></input> 
		</td>
	</tr>
</table>


<script type="text/javascript">
$("#abroadDateStart").datebox({
    onSelect : function(beginDate){
        $('#abroadDateEnd').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});
</script>
