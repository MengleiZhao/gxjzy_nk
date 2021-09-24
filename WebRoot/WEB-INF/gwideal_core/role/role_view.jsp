<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
    <div class="easyui-layout" fit="true">
    	<div region="center" border="false">
			<table border="0" cellpadding="0" cellspacing="0" class="main_table">
				<tr>
					<th width="40%">角色代码：</th>
					<td width="60%" colspan="3">
						${bean.code}&nbsp;
					</td>
				</tr>
				<tr>
					<th>角色名称：</th>
					<td colspan="3">
						${bean.name}&nbsp;
					</td>
				</tr>
				<tr>
					<th>排列顺序：</th>
					<td colspan="3">
						${bean.orderNo}&nbsp;
					</td>
				</tr>
				<tr>
					<th>描述：</th>
					<td colspan="3">
						${bean.description}&nbsp;
					</td>
				</tr>
			</table>
		</div>
		<div region="south" border="false" class="south">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" onclick="closeWindow();">关闭</a>
		</div>
	</div>
</body>
</html>

