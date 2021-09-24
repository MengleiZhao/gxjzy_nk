<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>党员列表</title>
</head>
<script>
 function doChoseUser(obj)
 {
 	var chosedList=parent.frames[2].getObjById("chosedList");
 	var userInfo=obj.value.split("|");
 	
 	if(obj.checked==true)
 	{
 	    var user="";
 	    
 	    if(userInfo!=null&&userInfo.length==3)
 	    {
 	    	user="<li title='双击姓名，删除此人' style='cursor:hand' ondblclick='deleteUser(this)' id='"+obj.value+"'>"+userInfo[0]+"</li>";
 	    }
 		chosedList.innerHTML=chosedList.innerHTML+user;
 		 
 	}else{
	 	var lis=chosedList.getElementsByTagName("li");
	 	if(lis!=null && lis.length>0)
	 	{
	 		for(i=0;i<lis.length;i++)
	 		{
	 			if(lis[i].id.indexOf(obj.id)>0)
	 			{
	 				chosedList.removeChild(lis[i]);
	 				 
	 			}
	 		}
	 	}
 	  
 	}
 }
 function choseAll()
 {
    var nowDeptId=getObjById("nowChosedDeptId").innerHTML;	
    if(nowDeptId=="")
    {
    	alert("请您先选择一个部门！");
    	return;
    }
    var checkboxs=getObjById(nowDeptId).getElementsByTagName("input");
    for(var i=0;i<checkboxs.length;i++)
    {
    	if(checkboxs[i].type.toLowerCase()=='checkbox'&&checkboxs[i].checked==false)
    	{
    		checkboxs[i].checked=true;
    		doChoseUser(checkboxs[i]);
    	}
    }
 }
 function disChoseAll()
 {
    var nowDeptId=getObjById("nowChosedDeptId").innerHTML;	
    if(nowDeptId=="")
    {
    	alert("请您先选择一个部门！");
    	return;
    }
    var checkboxs=getObjById(nowDeptId).getElementsByTagName("input");
    for(var i=0;i<checkboxs.length;i++)
    {
    	if(checkboxs[i].type.toLowerCase()=='checkbox'&&checkboxs[i].checked==true)
    	{
    		checkboxs[i].checked=false;
    		doChoseUser(checkboxs[i]);
    	}
    }
 }
</script>
<body>
<div id="nowChosedDeptId" style="display:none"></div>
<table border="0" align="center" cellpadding="0" cellspacing="0"  class="list-padding" >
  <tr>
    <td>
    <div  style="padding-left:5px">
  			<span onClick="choseAll()" class="button">全部选中</span>
		    <span onClick="disChoseAll()" class="button">全部取消</span>
		
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

 <iframe src="${base}/sys/refListUser.action" id="userRefList" style="width:350px;display:none;" />
 
</body>

</html>

