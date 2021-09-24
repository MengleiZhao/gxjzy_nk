<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<table cellpadding="0" cellspacing="0" class="window-table">
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span>&nbsp;培训名称</td>
		<td class="td2">
			<input  style="width: 200px; height: 30px;" id=""
			name="trainingName" class="easyui-textbox"
			value="${trainingBean.trainingName}" readonly="readonly"/>
		</td>

		<td class="td4">
		<!-- 隐藏域主键 --> 
			<input type="hidden" name="tId" value="${trainingBean.tId}" />
		 	<input type="hidden" id="trainingTypeHi" value="${trainingBean.trainingType}" />
		</td>

		<td class="td1"><span class="style1">*</span>&nbsp;讲师类型</td>
		<td class="td2">
			<!-- <select id="trainingType" class="easyui-combobox"
			name="trainingType" style="width: 200px;">
				<option value="1">短训</option>
				<option value="2">中训</option>
				<option value="3">长训</option>
			</select> -->
			<input id="trainingType" style="width: 200px; height: 30px;" value="${trainingBean.trainingType}" name="trainingType" readonly="readonly"
			data-options="valueField: 'trainingType',textField: 'value',
				data: [{trainingType: '1',value: '副高级技术职称专业人员'},{trainingType: '2',value: '正高级技术职称专业人员'},{trainingType: '3',value: '院士、全国知名专家'}],onSelect: function(rec){}"/>
		</td>
	</tr>

	<tr class="trbody" style="line-height: 19px;">
		<td class="td1"><span class="style1">*</span>&nbsp;培训举办机构</td>
		<td colspan="4"><input  style="width: 580px; height: 30px;" id=""
			name="organizer" class="easyui-textbox"
			value="${trainingBean.organizer}" readonly="readonly"></input></td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span>&nbsp;开始日期</td>
		<td class="td2"><input  style="width: 200px; height: 30px;" id="trDateStarts"
			name="trDateStart" class="easyui-datebox"
			value="${trainingBean.trDateStart}" readonly="readonly"></input>
		</td>

		<td class="td4" style="width: 67px;"></td>

		<td class="td1"><span class="style1">*</span>&nbsp;结束日期</td>
		<td class="td2"><input  style="width: 200px; height: 30px;" id="trDateEnds"
			name="trDateEnd" class="easyui-datebox"
			value="${trainingBean.trDateEnd}" readonly="readonly"></input>
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span>&nbsp;培训天数</td>
		<td class="td2"><input  style="width: 200px; height: 30px;" id=""
			name="trDayNum" class="easyui-numberbox"
			value="${trainingBean.trDayNum}" readonly="readonly"></input></td>
		<td colspan="4"></td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span>&nbsp;培训地点</td>
		<td colspan="4"><input  style="width:580px; height: 30px;" id=""
			name="trPlace" class="easyui-textbox" value="${trainingBean.trPlace}" readonly="readonly"></input>
		</td>
	</tr>

	<tr class="trbody" style="line-height: 19px;">
		<td class="td1"><span class="style1">*</span>&nbsp;培训地点说明</td>
		<td colspan="4"><input  style="width:580px; height: 30px;" id=""
			name="trPlaceExplain" class="easyui-textbox"
			value="${trainingBean.trPlaceExplain}" readonly="readonly"></input></td>
	</tr>

	<tr class="trbody" style="line-height: 19px;">
		<td class="td1"><span class="style1">*</span>&nbsp;参加培训人员</td>
		<td colspan="4"><input  style="width:580px; height: 30px;" id=""
			name="trAttendPeop" class="easyui-textbox"
			value="${trainingBean.trAttendPeop}" readonly="readonly"></input></td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span>&nbsp;参训人数</td>
		<td class="td2"><input  style="width: 200px; height: 30px;" id=""
			name="trAttendNum" class="easyui-numberbox"
			value="${trainingBean.trAttendNum}" readonly="readonly"></input></td>

		<td class="td4" style="width: 67px;"></td>

		<td class="td1">工作人员数量</td>
		<td class="td2"><input  style="width: 200px; height: 30px;" id=""
			name="trStaffNum" class="easyui-numberbox"
			value="${trainingBean.trStaffNum}" readonly="readonly"></input></td>
	</tr>
	
	<tr style="height:5px;"></tr>

	<tr style="height: 70px;">
		<td class="td1" valign="top"><p style="margin-top: 8px">培训内容</p></td>
		<td colspan="4"><input class="easyui-textbox"
			data-options="multiline:true" name="trContent"
			style="width:580px;height:100px" value="${trainingBean.trContent}" readonly="readonly">
		</td>
	</tr>
</table>

<script type="text/javascript">
$("#trDateStarts").datebox({
    onSelect : function(beginDate){
        $('#trDateEnds').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});
$(document).ready(function(){
	//设值复选框的值
	var h = $("#trainingTypeHi").textbox().textbox('getValue');
	if(h != "") {
		$('#trainingType').textbox().textbox('setValue',h);
	}
	$('#trainingType').textbox().attr('readonly', true);
});
</script>