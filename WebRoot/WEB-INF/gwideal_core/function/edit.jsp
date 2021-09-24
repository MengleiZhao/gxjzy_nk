<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
	<script type="text/javascript">
		function functionEditForm(){
			var flag=false;
			$('#functionEditForm').form('submit', {
				onSubmit: function(){ 
					flag=$(this).form('enableValidation').form('validate');
					if(flag){
						$.messager.progress();
					}
					return flag;
				}, 
				success:function(data){
					if(flag){
						$.messager.progress('close');
					}
					var data = eval('(' + data + ')');
					if(data.success){
						$.messager.alert('系统提示',data.info,'info');
						closeWindow();
						$('#functionEditForm').form('clear');
						$("#function_dg").datagrid('reload');
						$("#functionTree").tree('reload');
					}else{
						$.messager.alert('系统提示',data.info,'error');
						closeWindow();
						$('#functionEditForm').form('clear');
					}
				} 
			});
		}
	</script>
    <div class="easyui-layout" fit="true">
    	<form id="functionEditForm" action="${base}/function/update" method="post" data-options="novalidate:true" class="easyui-form">
    		<input type="hidden" name="id" value="${bean.id}"/>
			<table border="0" cellpadding="0" cellspacing="0" class="main_table">
				<tr>
					<th width="20%">上级菜单：</th>
					<td width="80%" colspan="3">
						<select name="parent.id" class="easyui-combobox" data-options="editable:false">
							<option value="">--请选择--</option>
							<c:forEach items="${listParent}" var="func">
								<option value="${func.id}" <c:if test="${bean.parent.id==func.id}">selected="selected"</c:if>>${func.selectTree}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th><span style="color: red;">*</span>名称：</th>
					<td colspan="3">
						<input class="easyui-textbox" type="text" name="name" data-options="required:true,validType:'length[1,50]'" size="50" value="${bean.name}"/>
					</td>
				</tr>
				<tr>
					<th>URL：</th>
					<td colspan="3">
						<input class="easyui-textbox" type="text" name="url" data-options="validType:'length[1,100]'" size="50" value="${bean.url}"/>
					</td>
				</tr>
				<tr>
					<th>功能集：</th>
					<td colspan="3">
						<input class="easyui-textbox" type="text" name="funcs" data-options="multiline:true,validType:'length[1,1000]'" size="70" style="height:100px" value="${bean.funcs}"/>
					</td>
				</tr>
				<tr>
					<th>描述：</th>
					<td colspan="3">
						<input class="easyui-textbox" type="text" name="description" data-options="validType:'length[1,100]'" size="50" value="${bean.description}"/>
					</td>
				</tr>
				<tr>
					<th><span style="color: red;">*</span>排列顺序：</th>
					<td colspan="3">
						<input class="easyui-textbox" type="text" name="priority" data-options="required:true,validType:'length[1,5]',validType:'integer'" value="${bean.priority}"/>
					</td>
				</tr>
				<tr>
					<td colspan="4" style="text-align: center;">
						<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-ok" onclick="functionEditForm();">保存</a> 
						<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" onclick="closeWindow();">关闭</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>

