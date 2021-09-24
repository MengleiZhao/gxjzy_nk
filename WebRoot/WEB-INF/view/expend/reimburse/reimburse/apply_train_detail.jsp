<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 0px;margin-left: 3px;">
	<tr class="trbody">
		<td class="td1" style=""><span class="style1">*</span> 培训名称</td>
		<td colspan="4">
			<input class="easyui-textbox" style="width: 580px; height: 30px;" readonly="readonly"
			value="${trainingBean.trainingName}" required="required" data-options="validType:'length[1,50]'"/>
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1" style="width: 70px;"><span class="style1">*</span> 省</td>
		<td class="td2">
			<input  class="easyui-combobox" style="width: 200px;; height: 30px;" readonly="readonly"
			value="${travelBean.fProvinceId}" required="required" editable="false" data-options="editable:false,
				url:'${base}/apply/getRegion?id=0&selected=${trainingBean.fProvinceId}',
				method:'POST',
				valueField:'id',
				textField:'text'"/>
		</td>
		<td class="td4" style="width: 67px;"></td>
		<td class="td1" style="width: 70px;"><span class="style1">*</span> 市</td>
		<td class="td2">
			<input class="easyui-combobox" style="width: 200px;; height: 30px;" readonly="readonly"
			value="${travelBean.fCityId}" required="required" editable="false" data-options="editable:false,
				method:'POST',
				url:'${base}/apply/getRegion?selected=${trainingBean.fCityId}',
				valueField:'id',
				textField:'text'"/>
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1" style="width: 70px;"><span class="style1">*</span> 区</td>
		<td class="td2">
			<input  class="easyui-combobox" style="width: 200px;; height: 30px;" readonly="readonly"
			value="${travelBean.fDistrictId}" required="required" editable="false" data-options="editable:false,
				url:'${base}/apply/getRegion?selected=${trainingBean.fDistrictId}',method:'POST',valueField:'id',textField:'text'"/>
		</td>
		<td class="td4" style="width: 67px;"></td>
		<td class="td1" style="width: 70px;"><span class="style1">*</span> 详细地址</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 200px;; height: 30px;" readonly="readonly"
			value="${trainingBean.trPlace}" required="required" />
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 参训人数</td>
		<td class="td2">
			<input  class="easyui-numberbox" style="width: 200px; height: 30px;" readonly="readonly"
			value="${trainingBean.trAttendNum}" required="required" data-options="validType:'length[1,3]'"/>
		</td>

		<td class="td4" style="width: 67px;"></td>

		<td class="td1"><span class="style1">*</span>工作人员人数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 200px; height: 30px;" readonly="readonly"
			value="${trainingBean.trStaffNum}" required="required" data-options="validType:'length[1,3]'"/>
		</td>
	</tr>
	
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 报到时间</td>
		<td class="td2">
			<input  class="easyui-datebox" style="width: 200px;; height: 30px;" readonly="readonly"
			data-options="" value="${trainingBean.trDateStart}" required="required" editable="false"/>
		</td>

		<td class="td4" style="width: 67px;"></td>

		<td class="td1"><span class="style1">*</span> 撤离时间</td>
		<td class="td2">
			<input class="easyui-datebox" style="width: 200px;; height: 30px;" readonly="readonly"
			data-options="onChange:onSelect4" value="${trainingBean.trDateEnd}" required="required" editable="false"/>
		</td>
	</tr>
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span>培训天数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 200px;; height: 30px;" 
			value="${trainingBean.trDayNum}" readonly="readonly" required="required" 
			data-options="validType:'length[1,2]',icons: [{iconCls:'icon-tian'}]"/>
		</td>
		<td class="td4" style="width: 67px;"></td>
		<td class="td1"></td>
		<td class="td2">
		</td>
		
		<%-- <td class="td4" style="width: 67px;"></td>
		<td class="td1"><span class="style1">*</span> 培训类别</td>
		<td class="td2">
			<input id="trainingType" class="easyui-combobox" required="required" style="width: 200px; height: 30px;" value="${trainingBean.trainingType}" name="trainingType"
			data-options="valueField: 'trainingType',textField: 'value',editable: false,
				data: [{trainingType: '1',value: '一类培训'},{trainingType: '2',value: '二类培训'},{trainingType: '3',value: '三类培训'}]"/> 
		</td> --%>
	</tr>

	<%-- <tr class="trbody">
		<td class="td1"><span class="style1">*</span> 培训地点</td>
		<td colspan="4">
			<input class="easyui-textbox" style="width: 580px; height: 30px;" name="trPlace"
			value="${trainingBean.trPlace}" required="required" data-options="prompt: '填写时地点精确到会议室房间号' ,validType:'length[1,50]'"/>
		</td>
	</tr>


	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 参训人员说明</td>
		<td colspan="4">
			<input class="easyui-textbox" style="width: 580px; height: 30px;" name="trAttendPeop"
			value="${trainingBean.trAttendPeop}" required="required" data-options="validType:'length[1,100]'"/>
		</td>
	</tr> --%>

	<tr class="trbody">
		<td class="td1"><span class="style1">*</span>
			经办人</td>
		<td class="td2"><input class="easyui-textbox" id="userNames"
			name="userNames" readonly="readonly" value="${applyBean.userNames}"
			style="width: 200px;height: 30px; "></td>
		<td class="td4" style="width: 67px;"></td>
		<td class="td1"><span class="style1">*</span>
			经办部门</td>
		<td class="td2"><input class="easyui-textbox" id="deptName"
			name="deptName" readonly="readonly" value="${applyBean.deptName}"
			style="width: 200px;height: 30px; "></td>
	</tr>
</table>
