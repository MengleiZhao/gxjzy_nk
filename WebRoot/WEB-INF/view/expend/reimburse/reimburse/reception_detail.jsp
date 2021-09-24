<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
	<tr class="trbody">
		<td class="td1" style="width: 70px"><span class="style1">*</span> 来访单位</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 230px; height: 30px;" readonly="readonly"
			value="${receptionBean.receptionObject}" data-options="required:true,validType:'length[1,25]'"/>
		</td>
		<td class="td1" style="width: 100px"><span class="style1">*</span> 来访日期</td>
		<td class="td2">
			<input class="easyui-datebox" style="width: 150px; height: 30px;" readonly="readonly"
			value="${receptionBean.reDateStart}" data-options=""/>
		</td>
	</tr>
	
	<tr class="trbody">
		<td class="td1" style="width: 70px"><span class="style1">*</span> 来访活动名称</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 230px; height: 30px;" readonly="readonly"
			value="${receptionBean.receptionContent}" data-options="required:true,validType:'length[1,25]'"/>
		</td>
		<td class="td1" style="width: 120px"><span class="style1">*</span>来访单位带队领导姓名</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 150px; height: 30px;" readonly="readonly"
			value="${receptionBean.diningPlacePlan1}" data-options=""/>
		</td>
	</tr>
	
	<tr class="trbody">
		<td class="td1" style="width: 120px"><span class="style1">*</span>来访单位带队领导职务</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 230px; height: 30px;" readonly="readonly"
			value="${receptionBean.diningPlacePlan2}" data-options="required:true,validType:'length[1,25]'"/>
		</td>
		<td class="td1"  style="width: 70px"><span class="style1">*</span>领导级别</td>
		<td class="td2" >
		<select  class="easyui-combobox"
			name="receptionLevel1" style="width: 150px; height: 30px;" readonly="readonly" data-options="required:true"  editable="false">
				<option value="1" <c:if test="${receptionBean.receptionLevel1=='1'}"> selected="selected" </c:if>>省部级</option>
				<option value="2" <c:if test="${receptionBean.receptionLevel1=='2'}"> selected="selected" </c:if>>司局级</option>
				<option value="3" <c:if test="${receptionBean.receptionLevel1=='3'}"> selected="selected" </c:if>>处级以下（含处级）</option>
			</select>
		</td>
	</tr>
	
	<tr class="trbody">
		<td class="td1" style="width: 100px"><span class="style1">*</span> 随行人数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 230px; height: 30px;" readonly="readonly"
			value="${receptionBean.attendPeopNum}" data-options=""/>
		</td>
		<td class="td1" style="width: 70px"><span class="style1">*</span> 陪餐人数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 150px; height: 30px;" readonly="readonly"
			value="${receptionBean.diningPlacePlan3}" data-options="required:true,validType:'length[1,25]'"/>
		</td>
	</tr>
	
	<tr class="trbody">
	<td class="td1" style="width: 100px"><span class="style1">*</span> 用餐总人数</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 230px; height: 30px;" readonly="readonly"
			value="${receptionBean.rePeopNum}" data-options=""/>
		</td>
		<td class="td1" style="width: 70px"><span class="style1">*</span> 用餐地点类型</td>
		<td class="td2">
			<select  class="easyui-combobox" readonly="readonly"
			 style="width: 150px; height: 30px;" data-options="required:true" editable="false">
				<option value="1" <c:if test="${receptionBean.receptionLevel=='1'}"> selected="selected" </c:if>>学校内部</option>
				<option value="2" <c:if test="${receptionBean.receptionLevel=='2'}"> selected="selected" </c:if>>学校外部</option>
				<%-- <option value="3" <c:if test="${receptionBean.receptionLevel=='3'}"> selected="selected" </c:if>>执行任务</option>
				<option value="4" <c:if test="${receptionBean.receptionLevel=='4'}"> selected="selected" </c:if>>学习交流</option>
				<option value="5" <c:if test="${receptionBean.receptionLevel=='5'}"> selected="selected" </c:if>>检查指导</option>
				<option value="6" <c:if test="${receptionBean.receptionLevel=='6'}"> selected="selected" </c:if>>请示汇报工作</option>
				<option value="7" <c:if test="${receptionBean.receptionLevel=='7'}"> selected="selected" </c:if>>其他</option> --%>
			</select>
		</td>
		
		<%-- <td class="td1" style="width: 70px"><span class="style1">*</span>是否有外宾接待</td>
		<td class="td2" colspan="3" >
			<input type="radio" name="isForeign" value="1" onclick="foreignYes()" disabled="disabled" <c:if test="${receptionBean.isForeign==1}">checked="checked"</c:if> />是
			<input type="radio" name="isForeign" value="0" onclick="foreignNo()" disabled="disabled" <c:if test="${receptionBean.isForeign==0}">checked="checked"</c:if> />否
		</td> --%>
	</tr>
		<tr class="trbody">
		<td class="td1" style="width: 100px"><span class="style1">*</span> 用餐地点</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 230px; height: 30px;" readonly="readonly"
			value="${receptionBean.diningPlace}" data-options=""/>
		</td>
		<td class="td1" style="width: 100px"><span class="style1">*</span> 费用预算</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 150px; height: 30px;" readonly="readonly"
			value="${applyBean.amount}" data-options=""/>
		</td>
	</tr>
	
	<tr class="trbody">
		<td class="td1"  style="width: 70px"><span class="style1">*</span> 经办人</td>
		<td class="td2" >
		<input class="easyui-textbox"  readonly="readonly" value="${applyBean.userNames}" style="width: 230px;height: 30px;margin-left: 10px " >
		</td>
		<td class="td1"  style="width: 70px"><span class="style1">*</span> 部门名称</td>
		<td class="td2" >
		<input class="easyui-textbox" readonly="readonly" value="${applyBean.deptName}" style="width: 150px;height: 30px;margin-left: 10px " >
		</td>
	</tr>
	
	
	<%-- <tr style="height: 70px;">
		<td class="td1" style="width: 70px;"><span class="style1">*</span>接待事由</td>
		<td colspan="3">
			<textarea class="textbox-text"  readonly="readonly" oninput="textareaNum(this,'textareaNum2')" autocomplete="off" 
			  style="width:579px;height:60px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:5px; margin-bottom:0px;">${receptionBean.receptionContent}</textarea>
		</td>
	</tr> --%>
<%-- <tr class="trbody">
	<td class="td1" style="width:70px;"><span class="style1">*</span>接待公函及其他附件 </td>
	<td colspan="4"><c:if test="${!empty attaList}">
			<c:forEach items="${attaList}" var="att">
			<c:if test="${att.serviceType=='jdgh' }">
				<a href='${base}/attachment/download/${att.id}'
					style="color: #666666;font-weight: bold;">${att.originalName}</a>
				<br>
			</c:if>
			</c:forEach>
			
		</c:if> </td>
</tr> --%>	
	
<script type="text/javascript">
</script>
