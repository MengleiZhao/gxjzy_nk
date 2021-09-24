<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html>
<head>
<title>${title}</title>
</head>
<body>
<div class="easyui-layout" fit="true">
	<form action="${base}/log/archive" id="logArchiveForm" method="post" data-options="novalidate:true" class="easyui-form">
		<div region="center" border="false" style="border-bottom: 0px solid #ccc;">
			<table cellpadding="5" cellspacing="0" class="a_table" width="100%">
				<tr>
					<th class="br" colspan="2" style="text-align: center"><span style="color: red;">(归档日期之前的记录都移动到日志历史表)</span></th>
				</tr>
				<tr>
					<th class="br" style="text-align: right;">归档日期：</th>
					<td class="br" style="text-align: left;">
						<input id="logArchiveDate" name="archiveDate" class="Wdate" type="text" onClick="WdatePicker()" readonly="readonly" style="width: 100px;"></input>
					</td>
				</tr>
			</table>
		</div>
		<div region="south" border="false" style="text-align: center; height: 32px; line-height: 30px;padding-left: 5px;">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-ok" onclick="saveLogArchive();">归档</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" onclick="closeWindow();">关闭</a>
		</div>
	</form>
</div>
<script type="text/javascript">
function saveLogArchive(){
	var logArchiveDate =document.getElementById("logArchiveDate").value;
	if(logArchiveDate.length==0){
		$.messager.alert('系统提示',"请选择归档日期！",'info');
		return;
	}
	$.messager.confirm('系统提示','确认归档吗?',function(r){
		if(r){
			var flag=false;
			$('#logArchiveForm').form('submit', {
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
						$('#logArchiveForm').form('clear');
						$("#log_dg").datagrid('reload');
					}else{
						$.messager.alert('系统提示',data.info,'error');
					}
				} 
			});
		}
	});
}
</script>
</body>
</html>