<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script type="text/javascript">
function selectUser(){
	var win=creatFirstWin('选择被替换用户',850,525,'icon-add','/wflow/bindingUser');
	win.window('open');
}


function userAddEditForms(){
	$('#AKeyToReplaceId').form('submit', {
		onSubmit: function(){ 
			/* flag=$(this).form('enableValidation').form('validate');
			if(flag){ */
				$.messager.progress();
			/* }
			return flag; */
		}, 
		dataType:'json',
		success:function(data){
			/* if(flag){ */
				$.messager.progress('close');
			/* } */
			var data = eval('(' + data + ')');
			if(data.success){
				$.messager.alert('系统提示',data.info,'info');
				closeWindow();
				$('#AKeyToReplaceId').form('clear');
				$("#user_dg").datagrid('reload');
			}else{
				$.messager.alert('系统提示',data.info,'error');
				closeWindow();
				$('#AKeyToReplaceId').form('clear');
			}
		} 
	});
}
</script>
<form id="AKeyToReplaceId" action="${base}/user/aKeyToReplaceEdit" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<table class="window-table" style="margin-top: 10px;width: 96%" cellspacing="0" cellpadding="0">
			<tr class="trbody">
				<td class="td1"><span class="style1">*</span>被替换人：</td>
				<td colspan="3">
					<a onclick="selectUser()" href="#">
					<input class="easyui-textbox" style="width: 200px;height: 30px;"
					name="userName" value="" id="userNames"
					data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo'}]" readonly="readonly" required="required"/>
					</a>
					<input id="userById" type="hidden" name="userById" value="${id}" />
					<input id="userIds" type="hidden" name="userId" value="" />
					<input id="departNames" type="hidden" name="departName" value="" />
				</td>
			</tr>
			<tr style="text-align: center;">
				<td colspan="4" style="padding-top: 100px;">
				<a href="javascript:void(0)" onclick="userAddEditForms();">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				<td>
			</tr>
			</table>
			
				
	</div>
</form>
