<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp" %>
<%@ include file="/includes/links.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>法人-党组织设置</title>
<s:head/>
<style>
#saveRoleUser input
{
	background:url(${base}/web-resources/images/button_bg.gif) left top repeat-x;
	border:#669ed1 1px solid;
	line-height:12px;
	font-weight:bold;
	color:#fff;
	height:18px;
	padding:1px 5px 5px 5px;
	margin:5px 10px;
}
#saveRoleUser select
{
	font-family: verdana, arial, helvetica, sans-serif;
	font-size: 11px;
	border: solid 1px #669ed1;
	width:400px;
}
#saveRoleUser label
{
    color:#ff7200;
	font-size:14px;
	font-weight:bold;
}
#saveRoleUser_0
{
	margin-left:100px;
}
</style>
<script type="text/javascript">
window.name="wUserEditRole";
</script>
</head>
<body>
<input type="hidden" id="pojo" value="EntLicense"/>
<table border="0" align="center" cellpadding="0" cellspacing="0"  >
  <tr>
    <td class="main">
    <div>
    <table width="80%" border="0" cellspacing="0" cellpadding="0">
  	<tr>
    	<td width="30%"><div class="position1" style="width:460px">首页
    	&nbsp;&nbsp;&gt;&gt;&nbsp;&nbsp;系统管理&nbsp;&nbsp;&gt;&gt;&nbsp;&nbsp;用户-角色设置（<s:property value="user.name" />）</div></td>
    	<td align="right"><div class="search">
		</div></td>
  	</tr>
	</table>
    </div>
    <div class="table">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
    	<td>
    	<div id="message" class="message2">
			<s:actionmessage />
			<s:actionerror />
	    </div>
    	<s:form action="saveRoleUser" namespace="/sys" target="wUserEditRole" >
    	<s:hidden name="user.id"/>
        <s:optiontransferselect
        	label="选择角色"
            name=""
            leftTitle="未选择角色"
            rightTitle="已选择角色"
            allowUpDownOnLeft="false"
            allowUpDownOnRight="false"
            selectAllLabel="全选"
            list="allRoles" 
            listKey="id"
            listValue="name"
            multiple="true"
            size="22"
            cssStyle="width:250px"
            emptyOption="false"
            doubleList="user.roles" 
            doubleListKey="id"
            doubleListValue="name"
            doubleName="selectedRoleIds"
            doubleEmptyOption="false"
            doubleMultiple="true" 
            doubleSize="22"
            doubleCssStyle="width:250px"/>
        <s:submit value="保 存" cssClass="button_blue"/>
        <input type="button" onclick="window.close();" class="button_blue" value="关 闭" />
    	</s:form>
		</td>
    </tr>
    </table>
    </div>
  </tr>
</table>
</body>
</html>
