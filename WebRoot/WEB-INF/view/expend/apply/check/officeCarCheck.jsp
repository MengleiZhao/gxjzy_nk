<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<table cellpadding="0" cellspacing="0" class="window-table">
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 用车类型</td>
		<td class="td2">
			<input type="text" style="width: 200px; height: 30px;" id="" name="fCarType" class="easyui-textbox" value="${officeCar.fCarType}" readonly="readonly"></input> 
		</td>
		<td class="td4" style="width: 67px;">
			<input type="hidden" name="mId" value="${officeCar.focID}" />
		</td>
		<td class="td1"><span class="style1">*</span> 用车时间</td>
		<td class="td2">
			<input type="text" style="width: 200px; height: 30px;" id="" name="fUseTime" class="easyui-datebox" value="${officeCar.fUseTime}"  readonly="readonly"></input> 
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 乘车人数</td>
		<td colspan="4"><input type="text" style="width: 200px; height: 30px;" id="fUseNumber" name="fUseNumber" class="easyui-numberbox"  value="${officeCar.fUseNumber}"  readonly="readonly"></input>
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 行车路线</td>
		<td colspan="4">
			<input type="text" style="width:580px; height: 30px;" id="fDrivingRoute" name="fDrivingRoute" class="easyui-textbox" value="${officeCar.fDrivingRoute}"  readonly="readonly"></input>
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 用车事由</td>
		<td colspan="4">
			<input type="text" style="width:580px; height: 30px;" id="fUseRemark" name="fUseRemark" class="easyui-textbox" value="${officeCar.fUseRemark}"  readonly="readonly"></input>
		</td>
	</tr>

</table>


<script type="text/javascript">
	
</script>
