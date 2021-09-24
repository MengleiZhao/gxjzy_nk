<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>
</head>
<body>
	<div class="easyui-layout" fit="true">
			<div region="center" border="false" style="background: #fff; border-bottom: 1px solid #ccc;position:relative;">
				
				<table cellpadding="5" cellspacing="0" class="a_table" width="100%">
					<tr>
						<th class="br" width="20%" >名称：</th>
						<td class="br"  >
							${bean.name}
						</td>
					</tr>
					
					<tr>
						<th class="br" width="20%" >手机号码：</th>
						<td class="br"  >
							${bean.phoneNumber}
						</td>
					</tr>
					
				</table>
			</div>
			<div region="south" border="false" style="text-align: center;padding: 2px 2px 2px 2px;">
				
				<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" onclick="closeWindow()">关闭</a>
			</div>
	</div>
	
	
</body>
</html>

