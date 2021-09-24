<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
.td1 input{
 height: 30px;
}
</style>

<table class="window-table" cellspacing="0" cellpadding="0">
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span> 下级审批人</td>
		<td class="td2">
			<a href="#"  onclick="chooseUserid()">
				<input class="easyui-textbox" style="width: 200px; height: 30px;" id="userName2" name="userName2"
				value="" required="required" data-options="prompt:'请选择下一级审批人'"/>
			</a>
		</td>

		<td class="td4">
			<!-- 下环节处理人编码 -->
			<input hidden="hidden" name="fuserId" id="fuserId">
		</td>

		<td class="td1"><span class="style1"></span></td>
		<td class="td2">
		<%--	<input class="easyui-datebox" style="width: 200px; height: 30px;" id="meetingDateEnd" name="dateEnd"
			data-options="onSelect:onSelect2" value="${bean.dateEnd}" required="required" editable="false"/>--%>
		</td> 
	</tr>
</table>
<script type="text/javascript">
function chooseUserid(){
	var win=creatSecondWin('选择下级审批人',860,580,'icon-search','/apply/chooseNextRole'); 
	win.window('open');
}
</script>