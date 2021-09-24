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

<style>
-webkit-text-fill-color: #ffffff;
caret-color: #fff; /* 光标颜色 */

input:focus { outline: none; }
input:-webkit-autofill { 　-webkit-text-fill-color: #000 !important;　-webkit-text-fill-color: #ffffff;
transition: background-color 5000s ease-in-out 0s; }

html, body {margin: 0;width: 100%;height: 100%;}

	
#log{width: 719px;height: 342px;position:absolute;left:0;top:-100px;bottom: 0; right: 0; margin: auto;}
        
input:-webkit-autofill {-webkit-box-shadow: 0 0 0px 1000px white inset !important;}
</style>
</head>

<script language="javascript">
	//弹出登录失败信息
	var loginMsg='${loginMsg}';
	if(loginMsg.length>0){
		alert(loginMsg);
	}

	var timeout;
	$(document).ready(function(){
		timeout = setTimeout(function(){//建立定时器
			$('#log').fadeIn({duration: 1500});//淡出效果1500ms完成
			$('#login-bottom').fadeIn({duration: 1500});//淡出效果1500ms完成
		},9000);//延迟9000毫秒触发
		
		//回车键登录
		document.onkeydown = function (event){
			if (event.keyCode==13){doSubmit();}
		};
	});
	
    function doSubmit(){
		document.getElementById("loginForm").submit();
	}
    
   	//手动触发显示登录框
    var isFirst = true; 
    function openLogin() {
    	if(isFirst) {
    		clearTimeout(timeout);//结束定时器
    		
    		/* var myVideo = document.getElementsByTagName('video')[0];
    		 myVideo.remove(); */
    		
    		$('#log').fadeIn({duration: 1500});//淡出效果1500ms完成
			$('#login-bottom').fadeIn({duration: 1500});//淡出效果1500ms完成
	    	isFirst = false;
			return;
    	}
    }
    
    function changeRememberPassword() {
    	var s = $('#remember-password').attr('src').substring(34,36);
    	if(s=='f1'){
	    	$('#remember-password').attr('src','${base}/resource-modality/img/login/o1.png');
    	} else {
    		$('#remember-password').attr('src','${base}/resource-modality/img/login/f1.png');
    	}
    }
    
</script>

<body data-vide-bg="video/aa" onclick="openLogin()" data-vide-options="loop: false" style="background: ${base}/resource-modality/img/login/loginbackground.png">
	<form id="loginForm" action="${base}/login.do" method="post">
		<div id="log" style="display: none;">
			<%-- <img src="${base}/resource-modality/img/login/login.png"/> --%>
			<table border="0" cellpadding="0" cellspacing="0" style="width: 719px;height: 342px;" background="${base}/resource-modality/img/login/login.png">
				<tr style="height: 114px"><td colspan="2"></td></tr>
				<tr style="height: 24px">
					<td style="width: 444px"></td>
					<td>
						<input name="accountNo" type="text" style="margin-left:10px ;background-color:transparent;border:none;outline:none;background:none;width:167px; font-size:12px; color: #666666;" autocomplete="off"/>
					</td>
				</tr>
				<tr style="height: 18px"><td colspan="2"></td></tr>
				<tr style="height: 24px">
					<td></td>
					<td>
						<input name="password" type="password" style="margin-left:10px;border:none;outline:none;background:none; width:167px; font-size:12px;color: #666666;"/>
					</td>
				</tr>
				<tr style="height: 38px">
					<td></td>
					<td>
						<a href="#" style="margin-left: 116px;margin-top: 4px;display:block;width: 11px" onclick="changeRememberPassword()">
						<img id="remember-password" src="${base}/resource-modality/img/login/f1.png">
						</a>
					</td>
				</tr>
				<tr style="height: 24px"><td></td><td><a href="#" onclick="doSubmit()" style="height: 24px;width: 187px;display:block;"></a></td></tr>
				<tr style="height: 100px"><td colspan="2"></td></tr>
			</table>
		</div> 
	</form>
	
	<div id="login-bottom" style="width:100%; position:fixed; left:0; bottom:0;height: 100px;display: none;">
		<table width="100%" style="height: 100%"  border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td style="valign:middle; font-size: 16px; color: #666666; font-family: 微软雅黑;" align="center">全程管控  |  绩效一体 |  内控嵌套 | 业财融合 | 约束有力</td>
			</tr>
		</table>
	</div>
</body>
</html>
