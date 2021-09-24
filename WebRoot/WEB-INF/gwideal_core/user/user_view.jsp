<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html>
<head>
<title>${title}</title>
</head>
<body>
<div class="easyui-layout" fit="true" style="padding:2px">
	<table border="0" cellpadding="0" cellspacing="0" class="main_table">
	   	<tr>
	   		<th width="20%">账号：</th>
	   		<td width="30%">${user.accountNo}</td>
	   		<th width="20%">姓名：</th>
	   		<td width="30%">${user.name}</td>
	   	</tr>
	   	<tr>
	   		<th>部门：</th>
	   		<td>${user.depart.name}</td>
	   		<th>职务：</th>
	   		<td>${user.post}</td>
	   	</tr>
	   	<tr>
	   		<th>手机号码：</th>
	   		<td>${user.mobileNo}</td>
	   		<th>电话号码：</th>
	   		<td>${user.telNo}</td>
	   	</tr>
	   	<tr>
	   		<th>传真号码：</th>
	   		<td>${user.faxNo}</td>
	   		<th>邮编：</th>
	   		<td>${user.postalCode}</td>
	   	</tr>
	   	<tr>
	   		<th>地址：</th>
	   		<td colspan="3">${user.address}</td>
	   	</tr>
	   	<tr>
	   		<td style="text-align: center;" colspan="4">
				<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" onclick="closeWindow()">关闭</a>
			</td>
	   	</tr>
	</table>
</div>
</body>
