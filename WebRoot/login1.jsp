<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>欢迎使用内控管理平台 </title>

<link rel="shortcut icon" href="${base}/resource-modality/img/icon/favicon.ico" type="image/x-icon" />


<script src="${base}/resource-modality/js/jquery-1.11.3.min.js"></script>
<script src="${base}/resource-modality/js/jquery.vide.js"></script>

<script language="javascript">
	
</script> 
<style>
-webkit-text-fill-color: #ffffff;
caret-color: #fff; /* 光标颜色 */

input:focus { outline: none; }
input:-webkit-autofill { 　-webkit-text-fill-color: #000 !important;　-webkit-text-fill-color: #ffffff;
transition: background-color 5000s ease-in-out 0s; }

html, body {
	margin: 0;
	width: 100%;
	height: 100%;
}
<!--
	.STYLE1 {
		color: #FFFFFF;
		font-weight: bold;
	}
	.STYLE2 {color: #FFFFFF;font-size: 12px}
	-->
	
#log{
            width: 385px;
            height: 250px;
            position:absolute;
            left:0;
           	top:-100px;
            bottom: 0;
            right: 0;
            margin: auto;
        }
        
input:-webkit-autofill {
    -webkit-box-shadow: 0 0 0px 1000px white inset !important;
}
  </style>
</head>

<script language="javascript">
	//弹出登录失败信息
	var loginMsg='${loginMsg}';
	if(loginMsg.length>0){
		alert(loginMsg);
	}

	//回车键登录
	$(document).ready(function(){
		document.onkeydown = function (event){
			if (event.keyCode==13){doSubmit();}
		};
	});
    function doSubmit(){
		document.getElementById("loginForm").submit();
	}
    
    function th(){
    	if($("#fo").val()!=1){  		
	    	$("#f").css("display","none");
	    	$("#o").css("display","");
	    	$("#fo").val("1");
    	} else {
    		$("#f").css("display","");
	    	$("#o").css("display","none");
	    	$("#fo").val("0");
    	}
    }
    var isFirst = true; 
    function openLogin() {
    	if(isFirst) {
    		$('#logtab').css('display','none');
    		/* $('#log').css('display',''); */
    		$('#log').fadeIn({duration: 1500});
	    	isFirst = false;
    	}
    }
    
    $(function(){
    })

</script>

<body data-vide-bg="video/aa" onclick="openLogin()">
<div id="mainBody">
	<div id="cloud1" class="cloud"></div>
	<div id="cloud2" class="cloud"></div>
</div>  
<form id="loginForm" action="${base}/login.do" method="post">

<table id="logtab" style="height: 98%;margin: auto;" border="0" cellpadding="0" cellspacing="0">
	<tr style="height: 15%"><td></td></tr>
	<tr style="height: 20%"><td><img src="${base}/resource-modality/img/login/tz.png"></td></tr>
	<tr style="height: 27%"><td></td></tr>
	<tr style="height: 11%;font-size: 16px;color: #025982;text-align: center;font-family: '微软雅黑'"><td>全程管控  |  绩效一体 |  深度融合 | 规范透明 | 约束有力</td></tr>
	<tr style="height: 15%;font-size: 18px;color: #025982;text-align: center;font-family: '微软雅黑';vertical-align: text-top;font-weight: bold; "><td>天职（上海）企业管理咨询有限公司</td></tr>
	<tr style="height: 12%"><td></td></tr>
</table>


<div id="log" style="display: none;"/>
<table border="0" cellpadding="0" cellspacing="0" style="width: 383px;height: 250px;" background="${base}/resource-modality/img/login/login.png">
	<tr style="height: 93px">
		<td>&nbsp;</td>
	</tr>
	<tr style="height: 34px">
		<td colspan="3" style="padding-bottom:10px;">
			<!-- <input name="" style= "background-color:transparent;border:0;"/> -->
			<input name="accountNo" type="text" style="background-color:transparent;margin-left:110px;border:none;outline:none;background:none;width:130px; font-size:12px; color: #666666;" autocomplete="off"/>
		</td>
	</tr>
	<tr style="height: 46px">
		<td colspan="3" style="padding-bottom:24px;">
			<input name="password" type="password" style="margin-left:110px;border:none;outline:none;background:none; width:130px; font-size:12px;color: #666666;"/>
		</td>
	</tr>
	<tr style="height: 42px">
		<td colspan="3">
			<a onclick="doSubmit()" href="#" style="margin-left:90px;display:block;width: 207px;text-decoration: none;margin-top: -10px;">&nbsp;</a>
		</td>
	</tr>
	<tr>
		<td style="width: 20px;">
		</td>
	</tr>
	<tr style="height: 20px">
		<td></td>
	</tr>
</table>
</div>
</form>
</body>
</html>
