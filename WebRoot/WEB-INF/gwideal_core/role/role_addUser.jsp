<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html>
<head>
	<title>给角色新增用户</title>
</head>
<body>
<table border="0" align="center" cellpadding="0" cellspacing="0" class="main_table">
	<tr>
	<td class="main">		 
		<s:hidden name="msg.id"></s:hidden>
		<s:hidden name="method" value="save"></s:hidden>
		<div class="position1" style="width:900px"><a>首页</a>
		&nbsp;&nbsp;&gt;&gt;&nbsp;&nbsp;系统管理
		&nbsp;&nbsp;&gt;&gt;&nbsp;&nbsp;权限管理
		&nbsp;&nbsp;&gt;&gt;&nbsp;&nbsp;给角色分配用户

		&nbsp;&nbsp;&nbsp;&nbsp;当前角色：<s:property value="role.name"/>
		<input type="button" onClick="self.close()" class="button_blue" value="关闭页面" style="margin-left:200px;" />
		</div>
		<div class="table">
			<table width="100%" border="0" cellpadding="5" cellspacing="0" class="table_detail">			 
			<tr>
				<td>
	              <iframe height="500"   id="leftTree" name="leftTree"  frameborder="NO" style="border:1px gray solid"  marginwidth="0" marginheight="0" src="${base}/sys/treeDepart.action?treeType=choseUserTree"  scrolling="auto"  noresize  target="content" ></iframe>
			    </td>
			    <td>
				  <iframe height="500"    id="content" name="content" src="${base}/sys/user/user_refGate.jsp" frameborder="NO" style="border:1px gray solid"  scrolling="auto" target="self" ></iframe>
			    </td>
			    <td>
			      <iframe height="500"  id="chosedUserList" name="chosedUserList" src="" frameborder="NO" style="border:1px gray solid"  scrolling="auto" target="self" ></iframe>
			    </td>
		  
		    </tr>
		    </table>
		    
		</div>
		 
		 
	</td>
	</tr>
</table>
<s:form action="saveAddUserRole" namespace="/sys">
		<s:hidden name="role.id" />
		<s:hidden name="role.uids" id="id" />
		<s:hidden name="role.unames" id="name" />
</s:form>	  
 
<script>
var _src=encodeURI("${base}/sys/user/user_chosedList.jsp?dialogArguments=id=id,name=name");
getObjById("chosedUserList").src=_src;
function saveCheck()
{
	if(notNullCheck("名称","name")==false)
		return false;
	if(notNullCheck("代码","code")==false)
		return false;
	
	return true;	
}

</script>	
</body>
</html>