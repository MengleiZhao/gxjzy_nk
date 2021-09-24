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
				<th>科目编号：</th>
				<td><input id="economic_code" readonly="readonly" class="easyui-textbox"
					type="text" name="code" data-options="validType:'length[1,20]'"
					size="30" value="${bean.code}" /></td>
				<th>科目名称：</th>
				<td><input class="easyui-textbox" readonly="readonly" type="text"
					id="economic_name" name="name"
					data-options="validType:'length[1,20]'" size="30"
					value="${bean.name}" /></td>
			</tr>
			<tr>
				<th>科目级别：</th>
				<td><select class="easyui-combobox" readonly="readonly" id="economic_leve"
					name="leve" style="width: 140px;" onchange="leve_op()" value="${bean.leve}"
					data-options="editable:false,panelHeight:'auto'">
						<option id="op_leve">${bean.leve}</option>
				</select></td>
				<th>上级科目编号：</th>
				<td><input class="easyui-textbox" readonly="readonly" type="text" id="economic_id"
					name="pid" data-options="validType:'length[1,50]'" size="30"
					value="${bean.pid}" /></td>
			</tr>
			<tr>
				<th>科目类型：</th>
				<td><select class="easyui-combobox" readonly="readonly" id="economic_type"
					name="type" value="${bean.type}" style="width: 140px;"
					data-options="editable:false,panelHeight:'auto'">
						<option id="op_type">${bean.type}</option>
				</select></td>
				<th>是否启用：</th>
				<td><select class="easyui-combobox" readonly="readonly" id="economic_on" name="on"
					value="${bean.on}" onchange="beanon()" style="width: 140px;"
					data-options="editable:false,panelHeight:'auto'">
						<option id="op_on">${bean.on}</option>
				</select></td>
			</tr>
			<tr>
	   		<td style="text-align: center;" colspan="4">
				<a href="javascript:void(0)" style="margin-top: 10px" class="easyui-linkbutton" iconcls="icon-cancel" onclick="closeWindow()">关闭</a>
			</td>
	   	</tr>
	</table>
</div>
</body>
