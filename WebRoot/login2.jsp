<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>欢迎使用内控管理平台 </title>

<link href="${base}/resource-now/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resource-now/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resource-now/js/cloud.js"></script>
<script src="${base}/resource-modality/js/jquery-1.11.3.min.js"></script>
<script src="${base}/resource-modality/js/jquery.vide.js"></script>



<script language="javascript">
	$(function(){
	    $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
		$(window).resize(function(){  
	    $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
	    })  
	});  
	//回车键登录
	$(document).ready(function(){
		document.onkeydown = function (event){
			if (event.keyCode==13){doSubmit();}
		};
	});
    function doSubmit(){
		document.getElementById("loginForm").submit();
	}
</script> 

</head>

<body style="background-color:#1c77ac; background-image:url(${base}/resource-now/images/light.png); background-repeat:no-repeat; background-position:center top; overflow:hidden;">



    <div id="mainBody">
      <div id="cloud1" class="cloud"></div>
      <div id="cloud2" class="cloud"></div>
    </div>  


<div class="logintop">    
    <span>欢迎使用政务内控信息平台</span>    
    <ul> 
    </ul>    
    </div>
    
    <div class="loginbody">
    
    <span class="systemlogo"></span> 
       
    <div class="loginbox">
    <form id="loginForm" action="${base}/login.do" method="post">
    <ul>
    <li><input name="accountNo" type="text" class="loginuser" value="admin" onclick="JavaScript:this.value=''"/></li>
    <li><input name="password" type="password" class="loginpwd" value="" onclick="JavaScript:this.value=''"/></li>
    <li><input name="" type="button" class="loginbtn" value="登录"  onclick="doSubmit()"  />
    <label><input name="" type="checkbox" value="" checked="checked" />记住密码</label><label><a href="#">忘记密码？</a></label></li>
    </ul>
    </form>
    
    </div>
    
    </div>
    
    
    
    <div class="loginbm">版权所有 天职国际会计师事务所（特殊普通合伙）</div>
</body>
</html>
