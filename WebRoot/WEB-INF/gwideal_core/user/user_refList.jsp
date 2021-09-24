<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp" %>
<%@ include file="/includes/links.jsp" %> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户管理</title>
</head>
<body onLoad="printToParent()">
<div id="userList">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" id="<s:property value="user.depart.id"/>">
  <s:iterator value="userList" status="user">
    <s:if test="#user.index%2==0">
	  	<tr>   
    </s:if>
	    	<td width="33%">
	    	    <input type="checkBox" value='<s:property value="name"/>|<s:property value="id"/>|<s:property value="accountNo"/>' id='<s:property value="id"/>'  onclick="doChoseUser(this)" />
	    	    <label for='<s:property value="id"/>' style="cursor:hand" ><s:property value="name" /></label>
	    	</td>  
	<s:if test="#user.index%2==1">
	  	</tr>
    </s:if>
  </s:iterator>
 
  </table>
</div>
</body>
</html>
<script>
function printToParent()
{

	var users=getObjById("userList");
	var parentTables=parent.getObjById("userList").getElementsByTagName("table");
	if(parentTables!=null && parentTables.length>0)
	{
		for(i=0;i<parentTables.length;i++)
		{
			parentTables[i].style.display="none";
		}
	}
	parent.getObjById("userList").innerHTML=parent.getObjById("userList").innerHTML+users.innerHTML;
	var init_id="";	 
	init_id=parent.parent.document.frames[2].getObjById("id");	 
	var init_ids=init_id.value.split(";"); 
	if(init_ids!=null && init_ids.length>0)
	{
		for(var i=0;i<init_ids.length;i++)
		{
			if(hasObj(init_ids[i]))
			{
				//getObjById(init_ids[i]).checked=true;
				parent.getObjById(init_ids[i]).checked=true;
			}
		}
	}
}
</script>

