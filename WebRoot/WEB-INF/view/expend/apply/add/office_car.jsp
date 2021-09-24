<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<table class="window-table" cellspacing="0" cellpadding="0">
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 用车类型</td>
		<td class="td2">
			<input style="width: 200px; height: 30px;" name="fCarType" class="easyui-textbox" 
			value="${officeCar.fCarType}" data-options="required:true,validType:'length[1,25]'"/> 
		</td>
		<td class="td4" style="width: 67px;">
		<input type="hidden" name="focID" value="${officeCar.focID}" />
		</td>
		<td class="td1"><span class="style1">*</span> 用车时间</td>
		<td class="td2">
			<input style="width: 200px; height: 30px;" name="fUseTime" class="easyui-datebox" 
			value="${officeCar.fUseTime}" data-options="required:true" editable="false"/> 
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 乘车人数</td>
		<td colspan="4">
		<input type="text" style="width: 200px; height: 30px;" id="fUserNumber" name="fUserNumber" class="easyui-numberbox" 
		value="${officeCar.fUserNumber}" data-options="required:true,validType:'length[1,3]'"/>
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 行车路线</td>
		<td colspan="4">
			<input style="width:580px; height: 30px;" id="fDrivingRoute" name="fDrivingRoute" class="easyui-textbox" 
			value="${officeCar.fDrivingRoute}" data-options="required:true,validType:'length[1,100]'"/>
		</td>
	</tr>
	
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 用车事由</td>
		<td colspan="4">
			<input style="width:580px; height: 30px;" id="fUseRemark" name="fUseRemark" class="easyui-textbox"
			value="${officeCar.fUseRemark}" data-options="required:true,validType:'length[1,50]'"/>
		</td>
	</tr>

</table>


<script type="text/javascript">
$(function(){
	calcTravelCost();
});

//自动获得费用明细
function calcTravelCost(){
	$('#appli-detail-dg-travel').datagrid({
		url: base+'/hotelStandard/calcCost?outType=car',
		queryParams:{
			
		}
	});
}
</script>
