<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>党员列表</title>
</head>
<script>

</script>
<body>
<div id="nowChosedDeptId" style="display:none"></div>
<table border="0" align="center" cellpadding="0" cellspacing="0"  class="list-padding" >
  <tr>
    <td>
    <div  style="padding-left:5px">
	</div>
    <div>
    <br>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
  	<tr>
    	<td width="30%">
    	<div  class="position1" style="width:240px" id="nowChosedDept"><a href="#"  >当前部门：</a> 请点击左边的树，选择部门</div>
    	</td>   	 
  	</tr>
	</table>
    </div>
    <div id="userList"   >
	    
	</div>
	
	</td>
 </tr>
 </table>

 <iframe src="${base}/sys/refList2User.action" id="userRefList" style="width:350px;display:none;" />
 
</body>

</html>

