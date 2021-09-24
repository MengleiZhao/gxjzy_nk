<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp" %>
<%@ include file="/includes/links.jsp" %> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>用户管理</title>
<script type="text/javascript">
  var mapping="";
  try{
      mapping=parent.dialogArguments[1]; 
  }	catch(e)
  {}
  var ifRef=true;
  if(mapping==null || mapping=="" )
  {
  	mapping=decodeURI("<%=request.getParameter("dialogArguments")%>");
  	ifRef=false;
  	
  }
</script>
</head>
<script>
function init_value()
{      if(mapping!=undefined && mapping!=null && mapping!="" )
	   {
		    
			var left ,right;
			left = getArrayByDelimiter(mapping, true);
			right = getArrayByDelimiter(mapping, false);
			for(var i=0;i<left.length;i++)
			{	 		 
			   if(hasObj(left[i]))
			    {  
			    	   if(ifRef)
			    	   		getObjById(left[i]).value = right[i];
			    	   else
			    	   		getObjById(left[i]).value = parent.getObjById(right[i]).value ;
			    }
						
			  
		      }
			 
		    
		    var ids=getObjById("id").value.split(";");
		    var accountNos=getObjById("accountNo").value.split(";");
		    var names=getObjById("name").value.split(";");		    
		    if(names!=null && names.length>0 && ids!=null && ids.length>0 &&ids.join("")!="")
		    {   var init_users="";
		    	for(i=0;i<names.length;i++)
		    	{
		    		var li_id=names[i];
		    		if(ids[i]!=undefined && ids[i]!=null)
		    		{
		    			li_id+="|"+ids[i];
		    		}else
		    		{
		    			li_id+="|noId";
		    		}
		    		if(accountNos[i]!=undefined && accountNos[i]!=null)
		    		{
		    			li_id+="|"+accountNos[i];
		    		}else
		    		{
		    			li_id+="|noAccounts";
		    		}
		    		init_users+="<li title='双击姓名，删除此人' style='cursor:hand' ondblclick='deleteUser(this)' id='"+li_id+"'>"+names[i]+"</li>";
		    	}
		    	getObjById("chosedList").innerHTML=init_users;
		    }
	    
	    }
}
function deleteUser(obj)
{     
    var chosedList=getObjById("chosedList");
	var lis=chosedList.getElementsByTagName("li");
	 	if(lis!=null && lis.length>0)
	 	{
	 		for(i=0;i<lis.length;i++)
	 		{
	 			if(lis[i].id==obj.id)
	 			{
	 				chosedList.removeChild(lis[i]);
	 			}
	 		}
	 	}
	var checks=parent.frames[1].document.getElementsByTagName("input");
	 
	if(checks!=null && checks.length>0)
	{
		
		for(i=0;i<checks.length;i++)
		{
			
			
			if(checks[i].type.toLowerCase()=="checkbox"&&checks[i].value==obj.id)
			{    
				checks[i].checked=false;
			}
		}
	}
	
}

function deleteAll()
{
	var chosedList=getObjById("chosedList");
	var lis=chosedList.getElementsByTagName("li");
	
	 	if(lis!=null)
	 	{
	 		var _length=lis.length;
	 		var i=0;
	 		while(i<_length)
	 		{
	 			
	 			deleteUser(lis[i]);
	 			i=0;
	 			_length=chosedList.getElementsByTagName("li").length; 			
	 			
	 		}
	 	}
}

function doSave()
{
	var chosedList=getObjById("chosedList");
	 
	var lis=chosedList.getElementsByTagName("li");
	 
	var names="";
	var ids="";
	var accountNos="";
 	if(lis!=null && lis.length>0){ 
 		for(i=0;i<lis.length;i++){
 			 var userinfo=lis[i].id.split("|");
 			
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
	 
	   if(ifRef)
	   {
		window.returnValue="name="+names+"&id="+ids+"&accountNo="+accountNos;
		parent.window.returnValue="name="+names+"&id="+ids+"&accountNo="+accountNos;
		parent.close();
		self.close();
	   }else
	     {
	     	parent.getObjById("id").value=ids;
	     	parent.getObjById("name").value=names;
	     	parent.document.forms[0].submit();
	     }
	 
}

function doClear()
{ 
	 if(ifRef)
	 {  window.returnValue="clear";
		parent.close();
	 }else
	 {
	 	    parent.getObjById("id").value="";
	     	parent.getObjById("name").value="";
	     	parent.document.forms[0].submit();
	 }
}
</script>
<body onload="init_value()">
<input type="hidden" name="accountNo" id="accountNo" >
<input type="hidden" name="name" id="name" >
<input type="hidden" name="id" id="id" >
<table border="0" align="center" cellpadding="0" cellspacing="0"  class="list-padding" >
  <tr>
    <td>
    <div  style="padding-left:5px">
		<span onClick="doSave()" class="button"  >确定</span>
		<span onClick="deleteAll()" class="button" title="指将下面已经选择的人员全部删除" >全部删除</span>
		<span onClick="doClear()" class="button" title="指已经选择的人员全部删除 并关闭页面">置空</span>
		
		
	</div>
    <div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
  	<tr>
    	<td width="30%">
    	<br>
    	<div class="position1" id="nowChosedDept" style="width:180px"><a href="#"  >已选择用户列表：</a>
    	
    	 </div>
    	 <div style="padding-left:5px;font-size:9px">
    	(双击下列已经选中的人名，<br>可删除此人)
    	 </div>
    	</td>   	 
  	</tr>
	</table>
    </div>
    <div   style="height:300px;padding-top:10px;">
	    <ul id="chosedList">
  			
        </ul>
        
	</div>
	
	</td>
 </tr>
 </table>

</body>
</html>
 

