<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table class="window-table" cellspacing="0" cellpadding="0">
	<tr class="trbody" style="line-height: 19px;">
		<td class="td1"><span class="style1">*</span> 会议名称</td>
		<td class="td2"><input  style="width: 200px; height: 30px;" id=""
			name="meetingName" class="easyui-textbox"
			value="${meetingBean.meetingName}" readonly="readonly"></input>
		</td>

		<td class="td4">
			 <!-- 隐藏域主键 --> 
			 <input type="hidden" name="mId" value="${meetingBean.mId}" />
			 <input type="hidden" id="meetingTypeHi" value="${meetingBean.meetingType}" />
			 <input type="hidden" id="meetingMethodHi" value="${meetingBean.meetingMethod}" />
		</td>

		<td class="td1"><span class="style1">*</span> 会议类型</td>
		<td class="td2">
			<select id="meetingType" class="easyui-combobox" name="meetingType" style="width: 200px; height: 30px;"readonly="readonly">
			
				<option value="1" <c:if test="${meetingBean.meetingType==1 }">selected="selected"</c:if>>一类会议</option>
				<option value="2" <c:if test="${meetingBean.meetingType==2 }">selected="selected"</c:if>>二类会议</option>
				<option value="3" <c:if test="${meetingBean.meetingType==3 }">selected="selected"</c:if>>三类会议</option>
				<option value="4" <c:if test="${meetingBean.meetingType==4 }">selected="selected"</c:if>>四类会议</option>
		</select>
		</td>
	</tr>

	<tr class="trbody" style="line-height: 19px;">
		<td class="td1"><span class="style1">*</span> 开始日期</td>
		<td class="td2"><input  style="width: 200px; height: 30px;" id="dateStarts" 
			name="dateStart" class="easyui-datebox"
			value="${meetingBean.dateStart}" readonly="readonly"></input>
		</td>

		<td class="td4" style="width: 67px;"></td>

		<td class="td1"><span class="style1">*</span> 结束日期</td>
		<td class="td2"><input  style="width: 200px; height: 30px;" id="dateEnds"
			name="dateEnd" class="easyui-datebox"
			value="${meetingBean.dateEnd}" readonly="readonly"></input>
		</td>
	</tr>

	<tr class="trbody" style="line-height: 19px;">
		<td class="td1"><span class="style1">*</span> 会议天数</td>
		<td class="td2"><input  style="width: 200px; height: 30px;" id=""
			name="dayNum" class="easyui-numberbox" value="${meetingBean.dayNum}"
			readonly="readonly"></input></td>
			
		<td class="td4" style="width: 67px;"></td>
		
		<td class="td1"><span class="style1">*</span> 会议方式</td>
		<td class="td2">
			<select id="meetingMethod" class="easyui-combobox"
			name="meetingMethod" style="width: 200px; height: 30px;" readonly="readonly">
				<option value="1" <c:if test="${meetingBean.meetingMethod==1 }">selected="selected"</c:if>>现场会议</option>
				<option value="2" <c:if test="${meetingBean.meetingMethod==2 }">selected="selected"</c:if>>网络电话会议</option>
				<option value="3" <c:if test="${meetingBean.meetingMethod==3 }">selected="selected"</c:if>>网络视频会议</option>
				<option value="4" <c:if test="${meetingBean.meetingMethod==4 }">selected="selected"</c:if>>其他</option>
			</select>
		</td>
	</tr>

	<tr class="trbody" style="line-height: 19px;">
		<td class="td1"><span class="style1">*</span> 会议地点</td>
		<td class="td2"  colspan="4"><input  style="width: 580px; height: 30px;" id=""
			name="meetingPlace" class="easyui-textbox"
			value="${meetingBean.meetingPlace}" readonly="readonly"></input></td>
	</tr>

	<tr class="trbody" style="line-height: 19px;">
		<td class="td1"><span class="style1">*</span> 会议地点说明</td>
		<td class="td2"  colspan="4"><input  style="width: 580px; height: 30px;" id=""
			name="placeExplain" class="easyui-textbox"
			value="${meetingBean.placeExplain}" readonly="readonly"></input></td>
	</tr>

	<tr class="trbody" style="line-height: 19px;">
		<td class="td1"><span class="style1">*</span> 主要参会人员</td>
		<td class="td2" colspan="4"><input  style="width: 580px; height: 30px;" id=""
			name="attendPeople" class="easyui-textbox"
			value="${meetingBean.attendPeople}" readonly="readonly"></input></td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 参会人数</td>
		<td class="td2"><input  style="width: 200px; height: 30px;" id=""
			name="attendNum" class="easyui-numberbox"
			value="${meetingBean.attendNum}" readonly="readonly"></input></td>

		<td class="td4" style="width: 67px;"></td>

		<td class="td1">工作人员数量</td>
		<td class="td2"><input  style="width: 200px; height: 30px;" id=""
			name="staffNum" class="easyui-numberbox"
			value="${meetingBean.staffNum}" readonly="readonly"></input></td>
	</tr>
	
	<tr style="height:5px;"></tr>

	<tr style="height: 70px;">
		<td class="td1" valign="top"><p style="margin-top: 10px">会议内容</p></td>
		<td class="td2"  colspan="4"><input class="easyui-textbox"
			data-options="multiline:true" name="content"
			style="width:580px;height:100px" value="${meetingBean.content}"
			readonly="readonly">
		</td>
	</tr>
</table>

<script type="text/javascript">
 	$(document).ready(function() {	
	});
 	
 	$("#dateStarts").datebox({
 	    onSelect : function(beginDate){
 	        $('#dateEnds').datebox().datebox('calendar').calendar({
 	            validator: function(date){
 	                return beginDate <= date;
 	            }
 	        });
 	    }
 	});
</script>
