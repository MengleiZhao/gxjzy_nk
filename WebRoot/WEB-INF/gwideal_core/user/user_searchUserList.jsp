<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp" %>
<%@ include file="/includes/links.jsp" %> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户选择</title>
<script>
	var winname = 'refwindow';
	window.name = winname;
</script>
</head>
<body onload="changeTarget();undisplay();">
<table border="0" cellspacing="0" cellpadding="0" id="mamber">
  <tr>
    <td width="12"><img src="${base}/web-resources/images/choice_03.gif" width="12" height="28" /></td>
    <td class="title">人员选择</td>
  </tr>
  <tr>
    <td colspan="2">
    <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="con">
      <tr>
     <td class="td001"  height="385" valign="top">    
	 
      
      <table border="0" align="center" cellpadding="0" cellspacing="0" width="100%"> 
  <tr>
    <td  align="center"> 
    
	<div class="mamsearch" >
	<s:form  action="refInAutListUser" namespace="/sys"  cssStyle="padding:0px;margin:0px">
    <s:hidden name="user.depart.id"/>
    <s:hidden name="user.depart.code"/>
    <table   border="0" cellspacing="0" cellpadding="0"  align="center"  >
    <tr>
    	<td width="20%" class="con_left" align="right">帐号:</td>
    	<td width="20%"><s:textfield name="user.accountNo"  cssClass="input_gray" size="15"></s:textfield> </td>
    	<td width="20%" class="con_left"  align="right">姓名:</td>
    	<td width="20%"><s:textfield name="user.name" cssClass="input_gray" size="15"></s:textfield> </td>
    	<td  width="20%">&nbsp; 	 
    	    <span onClick="document.forms[0].submit()" class="button">搜 索</span>
    	</td>
  	</tr>
  	<tr>
    	<td colspan="5" align="center" height="28" style="color:#AAA;font-size:11px;">说明：您可以在上面的录入框中输入帐号或姓名对用户进行搜索</td>
    </tr>
   
	</table>
	</s:form></div>
    
    </td>
    </tr>
    <tr>
        <td align="right"  >
        <table width="80%" border="0" cellspacing="0" cellpadding="0" >  	       
			   
			    <s:iterator value="userList" status="user">
				    <s:if test="#user.index%3==0">
					  	<tr>   
				    </s:if>
					    	<td width="33%">
					    	    <input type="checkBox" value='<s:property value="name"/>|<s:property value="id"/>|<s:property value="accountNo"/>' id='<s:property value="id"/>'  name="users" />
					    	    <label for='<s:property value="id"/>' style="cursor:hand" ><s:property value="name" /></label>
					    	</td>  
					<s:if test="#user.index%3==2">
					  	</tr>
				    </s:if>
			     </s:iterator>			 
  		</table>
  		</td>
  <tr>
   <td align="center" height ="40"   > 
   	<input name="button" type="button" onClick="choose()" class="button_blue" id="button" value="确 定"/>&nbsp;&nbsp;
   	<input name="button2" type="button" onClick="doClear()" class="button_blue" id="button2" value="置 空"/>&nbsp;&nbsp;
   	<input name="button3" type="button" onClick="noChose()" class="button_blue" id="button3" value="返 回"/>&nbsp;&nbsp;
   </td>
  </tr>
</table>
	 
	 
      </td>
      </tr>
    </table></td>
  </tr>
</table>

<script>
//选择用户的返回值

	function choose()
	{
		var names="";
	    var ids="";
	    var accountNos="";
	    var users=getObjsByName("users");
	    if(users!=null && users.length>0)
	    {
	    	for(i=0;i<users.length;i++)
	    	{
		    	if(users[i].checked==true||users[i].checked=="checked")
		    	{
		         var userinfo=users[i].value.split("|");
	 			
	 			 if(userinfo[0]!=null ){
		 			if(names!=""){
		 				names+=";"
		 			}
	 			 	names+=userinfo[0];
	 			 }
	 			 if(userinfo[1]!=null ){
	 			 	if(ids!=""){
		 				ids+=";"
		 			}
	 			 	ids+=userinfo[1];
	 			 }
	 			 if(userinfo[2]!=null ){
	 			 	if(accountNos!=""){
		 				accountNos+=";"
		 			}
	 			 	accountNos+=userinfo[2];
	 			 }
	 			 
 			 }
	    	}
	    }
 	   if(names=="")
		{
			alert("请选择至少一个用户！");
			return;
		}
	  
	    window.returnValue="name="+names+"&id="+ids+"&accountNo="+accountNos;
	   
		window.close();
	}
	function changeTarget()
	{
		 
		 
		var hrefs=getObjsByTagName("form");
		for(i=0;i<hrefs.length;i++)
		{
			hrefs[i].target=winname;
		}
		
	}
</script>

</body>
</html>

