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
		function lookupEditForm(){
			var flag=false;
			$('#lookupEditForm').form('submit', {
				onSubmit: function(){ 
					flag=$(this).form('enableValidation').form('validate');
					if(flag){
						$.messager.progress();
					}
					return flag;
				}, 
				dataType:'json',
				success:function(data){
					if(flag){
						$.messager.progress('close');
					}
					var data = eval('(' + data + ')');
					if(data.success){
						$.messager.alert('系统提示',data.info,'info');
						closeWindow();
						$('#lookupEditForm').form('clear');
						$("#lookup_dg").datagrid('reload');
					}else{
						$.messager.alert('系统提示',data.info,'error');
						$('#lookupEditForm').form('clear');
					}
				} 
			});
		}
	</script>
    <div class="easyui-layout" fit="true">
    	<div region="center" border="false">
	    	<form id="lookupEditForm" action="${base}/lookup/save" method="post" data-options="novalidate:true" class="easyui-form">
	    		<input type="hidden" name="id" value="${bean.id}"/>
				<table border="0" cellpadding="0" cellspacing="0" class="main_table">
					<tr>
						<th width="20%"><span style="color: red;">*</span>字典项代码：</th>
						<td width="80%" colspan="3">
							<input class="easyui-textbox" type="text" name="code" data-options="required:true,validType:'length[1,50]'" size="50" value="${bean.code}"/>
						</td>
					</tr>
					<tr>
						<th><span style="color: red;">*</span>字典项名称：</th>
						<td colspan="3">
							<input class="easyui-textbox" type="text" name="name" data-options="required:true,validType:'length[1,50]'" size="50" value="${bean.name}"/>
						</td>
					</tr>
					<tr>
						<th>字典项简称：</th>
						<td colspan="3">
							<input class="easyui-textbox" type="text" name="shortName" data-options="required:false,validType:'length[1,50]'" size="50" value="${bean.shortName}"/>
						</td>
					</tr>
					<tr>
						<th>字典类型名称：</th>
						<td colspan="3">
							${category.name }
							<input type="hidden" name="category.id" value="${category.id }"/>
						</td>
					</tr>
					<tr>
						<th>字典类型代码：</th>
						<td colspan="3">
							${category.code }
						</td>
					</tr>
					<tr>
						<th><span style="color: red;">*</span>排列顺序：</th>
						<td colspan="3">
							<input class="easyui-textbox" type="text" name="orderNo" data-options="required:true,validType:'length[1,10]'" size="50" value="${bean.orderNo}"/>
						</td>
					</tr>
					<tr>
						<th>说明：</th>
						<td colspan="3">
							<input class="easyui-textbox" type="text" name="description" data-options="multiline:true,validType:'length[1,200]'" size="70" style="height:100px" value="${bean.description}"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div region="south" border="false" class="south">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-ok" onclick="lookupEditForm();">保存</a> 
			<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" onclick="closeWindow();">关闭</a>
		</div>
	</div>
</body>
</html>

