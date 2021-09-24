<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp" %>
<%@ include file="/includes/links.jsp" %> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>用户管理</title>

</head>

<body>
<input type="hidden" name="accountNo" id="accountNo" >
<input type="hidden" name="name" id="name" >
<input type="hidden" name="id" id="id" >
<table border="0" align="center" cellpadding="0" cellspacing="0"  class="list-padding" >
  <tr>
    <td>
    	<td align="left"  style="vertical-align:top">选择项目权限:
            <td>
            	<input type="radio" value="ROLE_GROUP_PRINTOR" name="qx">文印人员</input>
				<br>
				<input type="radio" value="ROLE_GROUP_AUDITOR" name="qx">一线审计人员</input>
				<br>
				<input type="radio" value="ROLE_GROUP_REPORT_AUDITOR" name="qx">报表审核人</input>
				<br>
				<input type="radio" value="ROLE_GROUP_AUDITOR_LEADER" name="qx">审计组长(主审)</input>
				<br>
				<input type="radio" value="ROLE_GROUP_AUDITOR_MASTER" name="qx">审计科长</input>
				<br>
				<input type="radio" value="ROLE_GROUP_AUDITOR_SECRETARY" name="qx">审计局长</input>
				<br>
				<input type="radio" value="ROLE_GROUP_SYS_ADMIN" name="qx">系统管理员</input>
			</td>
		</td>
	</td>
 </tr>
 
 </table>

</body>
</html>
 

