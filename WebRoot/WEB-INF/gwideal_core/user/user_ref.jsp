<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp" %>
<%@ include file="/includes/links.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户</title>
<script>
	var winname = 'refwindow';
	window.name = winname;
</script>
</head>
<body onload="changeTarget();undisplay();">
<table border="0" align="center" cellpadding="0" cellspacing="0" >
  <tr>
    <td class="main">
    <div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
  	<tr>
    	<td width="30%"></td>
    	<td align="right"></td>
  	</tr>
	</table>
    </div>
    <div class="table">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
    	<td>
    	<ec:table items="listItems" var="user"
		width="100%" action="${base}/sys/refPageListUser.action" filterable="true"
		autoIncludeParameters="false">
		<ec:row>
			<ec:column width="3%" filterable="false" alias="选择">
				<input type="radio" name="ids" value="${user.id }"/>
			</ec:column> 
			<ec:column interceptor="hidden" cell="rowSelected" property="id"/>
			<ec:column width="25%" property="name" title="姓名" cell="span"/>
		</ec:row>
		</ec:table>
		</td>
    </tr>
    </table>
    </div>
  </tr>
  <tr>
   <td align="center"> 
   	<input name="button" type="button" onClick="choose()" class="button_blue" id="button" value="确 定"/>&nbsp;&nbsp;
   	<input name="button2" type="button" onClick="doClear()" class="button_blue" id="button2" value="置 空"/>&nbsp;&nbsp;
   	<input name="button3" type="button" onClick="noChose()" class="button_blue" id="button3" value="返 回"/>&nbsp;&nbsp;
   </td>
  </tr>
</table>
<script>
	function choose()
	{
		var id = '';
		var ids=document.getElementsByName("ids");
		if(undefined!=ids && null!=ids && 0<ids.length){
			for(var i=0;i<ids.length;i++){
				if(ids[i].checked){
					id=ids[i].value;
					break;
				}
			}
		}
		if(id=="")
		{
			alert("请选择一条记录！");
			return;
		}
		var name = document.getElementById('name_'+id).innerText;
		var rtnValue = id + '&&' + name;
		window.returnValue = rtnValue;
		window.close();
	}
	function changeTarget()
	{
		getObjById('ec').target=winname;
		var hrefs=getObjsByTagName("a");
		for(i=0;i<hrefs.length;i++)
		{
			hrefs[i].target=winname;
		}
		
	}
	
	
</script>
</body>
</html>

