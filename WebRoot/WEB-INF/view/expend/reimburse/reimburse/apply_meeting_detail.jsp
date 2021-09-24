<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/includes/taglibs.jsp"%>
<style type="text/css">
</style>


<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 0px;">
	<tr class="trbody">
		<td class="td1" ><span class="style1">*</span> 会议名称</td>
		<td class="td2" colspan="3" >
			<input class="easyui-textbox" style="width: 590px; height: 30px;" name="meetingName" 
			value="${meetingBean.meetingName}" readonly="readonly" required="required" data-options="validType:'length[1,50]'"/>
		</td>
	</tr>
			
	<tr class="trbody">
		<td class="td1" ><span class="style1">*</span> 会议类型</td>
		<td class="td2">
			<input class="easyui-combobox" readonly="readonly" style="width: 200px; height: 30px;" name="meetingType" value="${meetingBean.meetingType}"
				data-options="prompt: '-请选择-' ,valueField: 'meetingType',textField: 'value',editable: false,
				data: [{meetingType: '1',value: '一类会议'},{meetingType: '2',value: '二类会议'},{meetingType: '3',value: '三类会议'},{meetingType: '4',value: '四类会议'}]"/>
		</td>
		<td class="td1"><span class="style1">*</span> 会议方式</td>
		<td class="td2" style="width: 200px;">
			<input class="easyui-combobox" readonly="readonly" style="width: 200px; height: 30px;" name="meetingMethod" value="${meetingBean.meetingMethod}"
				data-options="prompt: '-请选择-' ,valueField: 'meetingMethod',textField: 'value',editable: false,
				data: [{meetingMethod: '1',value: '电视电话'},{meetingMethod: '2',value: '网络视频会议'},{meetingMethod: '3',value: '单位内部会议室'},{meetingMethod: '4',value: '外部定点会议室'}]"/>
		</td>
	</tr>		

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 参会人数</td>
		<td class="td2"><input class="easyui-numberbox" style="width: 200px; height: 30px;" name="attendNum" readonly="readonly"
			value="${meetingBean.attendNum}" required="required" data-options="validType:'length[1,3]'"/>
		</td>

		<td class="td1">其中工作人员人数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 200px; height: 30px;" readonly="readonly"
			 name="staffNum"
			value="${meetingBean.staffNum}" data-options="validType:'length[1,3]'"/>
		</td>
	</tr>
	<tbody id="bz" >
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 备注</td>
		<td colspan="3">
			<input class="easyui-textbox" style="width: 590px; height: 30px;" name="attendPeople" readonly="readonly"
			value="${meetingBean.attendPeople}" required="required" data-options="validType:'length[1,100]'"/>
		</td>
	</tr>
	</tbody>
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 报到时间</td>
		<td class="td2" style="width: 281px;">
			<input class="easyui-datebox" readonly="readonly" style="width: 200px; height: 30px;"  name="dateStart"
			data-options="" value="${meetingBean.dateStart}" required="required" editable="false"/>
		</td>

		<td class="td1"><span class="style1">*</span> 离开时间</td>
		<td class="td2">
			<input class="easyui-datebox" readonly="readonly" style="width: 200px; height: 30px;"  name="dateEnd"
			data-options="onSelect:onSelect2" value="${meetingBean.dateEnd}" required="required" editable="false"/>
		</td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 会议天数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 200px; height: 30px;"  name="duration" 
			value="${meetingBean.duration}" readonly="readonly" required="required" data-options="iconCls:'icon-tian',validType:'length[1,2]'"/>
		</td>
			
		<td class="td1" ></td>
		<td class="td2" style="width: 200px;"></td>
	</tr>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 省</td>
		<td class="td2" style="width: 281px;">
			<input class="easyui-combobox" readonly="readonly" style="width: 200px; height: 30px;"  name="fsheng"
			 value="${meetingBean.fsheng}" required="required" editable="false" data-options="editable:false,
				url:'${base}/apply/getRegion?id=0&selected=${meetingBean.fsheng}',
				method:'POST',
				valueField:'id',
				textField:'text'"/>
		</td>

		<td class="td1"><span class="style1">*</span> 市</td>
		<td class="td2">
			<input class="easyui-combobox" readonly="readonly" style="width: 200px; height: 30px;"  name="fshi"
			data-options="editable:false,
				method:'POST',
				url:'${base}/apply/getRegion?selected=${meetingBean.fshi}',
				valueField:'id',
				textField:'text'" value="${meetingBean.fshi}" required="required" editable="false"/>
		</td>
	</tr>
	
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 区</td>
		<td class="td2" style="width: 281px;">
			<input class="easyui-combobox" readonly="readonly" style="width: 200px; height: 30px;"  name="fqu"
			 value="${meetingBean.fqu}" required="required" editable="false" data-options="editable:false,
									url:'${base}/apply/getRegion?selected=${meetingBean.fqu}',method:'POST',valueField:'id',textField:'text'
									"/>
		</td>

		<td class="td1"><span class="style1">*</span> 详细地址</td>
		<td class="td2">
			<input class="easyui-textbox" readonly="readonly" style="width: 200px; height: 30px;"  name="meetingPlace"
			data-options="" value="${meetingBean.meetingPlace}" required="required" editable="false"/>
		</td>
	</tr>
	<%-- <tr class="trbody">
		<td class="td1"><span class="style1">*</span> 会议地点</td>
		<td colspan="3">
			<input class="easyui-textbox" style="width: 590px; height: 30px;" name="meetingPlace" readonly="readonly"
			value="${meetingBean.meetingPlace}" required="required" data-options="validType:'length[1,50]'"/>
		</td>
	</tr> --%>
	
	
	<tr style="height:5px;"></tr>

	<%-- <tr class="trbody">
		<td class="td1" valign="top"><p style="margin-top: 8px">会议内容</p></td>
		<td colspan="3">
			 <input class="easyui-textbox"data-options="multiline:true,required:false,validType:'length[0,250]'" readonly="readonly" name="content" style="width:590px;height:70px;" 
			value="${meetingBean.content}"> 
		</td>
	</tr> --%>
	<tr class="trbody">
		<td class="td1" ><span class="style1">*</span>
			经办人</td>
		<td class="td2"><input class="easyui-textbox" 
			name="userNames" readonly="readonly" value="${applyBean.userNames}"
			style="width: 200px;height: 30px;margin-left: 10px "></td>
		<td class="td1" ><span class="style1">*</span>
			部门名称</td>
		<td class="td2"><input class="easyui-textbox" 
			name="deptName" readonly="readonly" value="${applyBean.deptName}"
			style="width: 200px;height: 30px;margin-left: 10px "></td>
	</tr>
</table>

<script type="text/javascript">
$(document).ready(function() {
	 var meetType = $('#meetingType').combobox('getValue');
	 var attendNum = parseInt($('#attendNum').numberbox('getValue'));
	if(meetType == '4'){
		if(attendNum>50){
			$('#bz').show();
		} else {
			$('#bz').hide();
		}
	}else {
		$('#bz').hide();
	}

});
	
</script>
