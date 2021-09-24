<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table cellpadding="0" cellspacing="0" class="window-table">
	<tr class="trbody" style="line-height: 19px;">
		<td class="td1"><span class="style1">*</span> 接待对象单位</td>
		<td class="td2">
			<input type="text" style="width: 200px; height: 30px;"
			name="receptionObject" class="easyui-textbox"
			value="${receptionBean.receptionObject}" readonly="readonly"/>
		</td>

		<td class="td4" style="width: 67px;">
			 <!-- 隐藏域主键 -->
			 <input type="hidden" name="jId" value="${receptionBean.jId}" />
			 <input type="hidden" id="stayYNHi" value="${receptionBean.stayYN}" />
			 <input type="hidden" id="receptionLevelHi" value="${receptionBean.receptionLevel}" />
			 <input type="hidden" id="diningPlacePlanHi" value="${receptionBean.diningPlacePlan}" />
			 <input type="hidden" id="diningPlaceHi" value="${receptionBean.diningPlace}" />
		</td>

		<td class="td1"><span class="style1">*</span> 接待等级</td>
		<td class="td2">
			<select id="receptionLevel" class="easyui-combobox"
			name="receptionLevel" style="width: 200px; height: 30px;">
				<option value="1">普通接待</option>
				<option value="2">高规格接待</option>
			</select>
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 接待日期</td>
		<td class="td2">
			<input style="width: 200px; height: 30px;" id="reDateStarts"
			name="reDateStart" class="easyui-datebox"
			value="${receptionBean.reDateStart}" readonly="readonly"/>
		</td>
		
		<td class="td4" style="width: 67px;"></td>

		<td class="td1">至</td>
		<td class="td2">
			<input type="text" style="width: 200px; height: 30px;" id="reDateEnds"
			name="reDateEnd" class="easyui-datebox"
			value="${receptionBean.reDateEnd}" readonly="readonly"/>
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 接待天数</td>
		<td class="td2">
			<input type="text" style="width: 200px; height: 30px;"
			name="reDayNum" class="easyui-numberbox"
			value="${receptionBean.reDayNum}" readonly="readonly"/>
		</td>

		<td class="td4" style="width: 67px;"></td>

		<td class="td1"><span class="style1">*</span> 接待对象人数</td>
		<td class="td2">
			<input type="text" style="width: 200px; height: 30px;"
			name="rePeopNum" class="easyui-numberbox"
			value="${receptionBean.rePeopNum}" readonly="readonly"/>
		</td>
	</tr>

	<tr class="trbody" style="line-height: 19px;">
		<td class="td1"><span class="style1">*</span> 接待就餐安排</td>
		<td class="td2">
			<select id="diningPlacePlan" class="easyui-combobox"
			name="diningPlacePlan" style="width: 200px; height: 30px;">
				<option value="1">工作餐</option>
				<option value="2">自助餐</option>
				<option value="3">份饭</option>
				<option value="4">宴请</option>
				<option value="5">其他</option>
			</select>
		</td>

		<td class="td4" style="width: 67px;"></td>

		<td class="td1"><span class="style1">*</span> 接待就餐地点</td>
		<td class="td2">
			<select id="diningPlace" class="easyui-combobox"
			name="diningPlace" style="width: 200px; height: 30px;">
				<option value="1">单位食堂</option>
				<option value="2">定点饭店</option>
			</select>
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1">地点说明</td>
		<td colspan="4">
			<input class="easyui-textbox"
			name="dPlaceExplain" style="width:580px; height: 30px;"
			value="${receptionBean.dPlaceExplain}" readonly="readonly">
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 主陪人</td>
		<td class="td2">
			<input style="width: 200px; height: 30px;" name="reAttendPeople"
			class="easyui-textbox" value="${receptionBean.reAttendPeople}" readonly="readonly"/>
		</td>

		<td class="td4" style="width: 67px;"></td>

		<td class="td1"><span class="style1">*</span> 陪餐人数</td>
		<td class="td2">
			<input style="width: 200px; height: 30px;" name="attendPeopNum"
			class="easyui-numberbox" value="${receptionBean.attendPeopNum}" readonly="readonly"/>
		</td>
	</tr>
	
	<tr class="trbody" style="line-height: 19px;">
		<td class="td1"><span class="style1">*</span> 是否安排住宿</td>
		<td class="td2">
			<select id="stayYN" class="easyui-combobox" name="stayYN" style="width: 200px; height: 30px;">
				<option value="0">不安排</option>
				<option value="1">安排</option>
			</select>
		</td>
		
		<td class="td4" style="width: 67px;"></td>
		
		<td class="td1" id="zhusu1" style="display: none;">住宿标准</td>
		<td class="td2" id="zhusu2" style="display: none;">
			<input style="width: 200px; height: 30px;" name="stayStandard"
			class="easyui-textbox" value="${receptionBean.stayStandard}" readonly="readonly"/>
		</td>
	</tr>
	
	<tr class="trbody" id="zhusu3" style="display: none;">
		<td class="td1">住宿地点说明</td>
		<td colspan="4">
			<input style="width:580px; height: 30px;" name="stayPlaceExplai"
			class="easyui-textbox" value="${receptionBean.stayPlaceExplai}" readonly="readonly"/>
		</td>
	</tr>
	
	<tr style="height:5px;"></tr>

	<tr style="height: 70px;">
		<td class="td1" valign="top"><p style="margin-top: 8px">接待内容</p></td>
		<td colspan="4">
			<input class="easyui-textbox" data-options="multiline:true" name="receptionContent"
			style="width:580px;height:70px" value="${receptionBean.receptionContent}" readonly="readonly"></td>
	</tr>
</table>

<%-- <table id="rpt" class="easyui-datagrid" style="width:550px;height:auto"
	data-options="url:'${base}/apply/recep?id=${receptionBean.jId}',
				 method: 'get',
				 striped : true,
				 wrap : false,">
	<thead>
		<tr>
			<th data-options="field:'travelRId',hidden:true"></th>
			<th
				data-options="field:'receptionPeopName',width:150,editor:'textbox'">姓名</th>
			<th data-options="field:'position',width:150,editor:'textbox'">职务</th>
			<th data-options="field:'jDremake',width:250,editor:'textbox'">备注</th>
		</tr>
	</thead>
</table> --%>
<script type="text/javascript">

$("#reDateStarts").datebox({
    onSelect : function(beginDate){
        $('#reDateEnds').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});
	$(document).ready(function() {
		//设值复选框的值
		var h = $("#receptionLevelHi").textbox().textbox('getValue');
		if (h != "") {
			$('#receptionLevel').textbox().textbox('setValue', h);
		}
		var n = $("#diningPlacePlanHi").textbox().textbox('getValue');
		if (n != "") {
			$('#diningPlacePlan').textbox().textbox('setValue', n);
		}
		var j = $("#diningPlaceHi").textbox().textbox('getValue');
		if (j != "") {
			$('#diningPlace').textbox().textbox('setValue', j);
		}
		var z = $("#stayYNHi").textbox().textbox('getValue');
		if(z != "") {
			$('#stayYN').textbox().textbox('setValue', z);
			if(z == 1) {
				$('#zhusu1').css('display','');
				$('#zhusu2').css('display','');
				$('#zhusu3').css('display','');
			}
		}
		
		$('#receptionLevel').textbox().attr('readonly', true);
		$('#diningPlacePlan').textbox().attr('readonly', true);
		$('#diningPlace').textbox().attr('readonly', true);
		$('#stayYN').textbox().attr('readonly', true);
	});
</script>

