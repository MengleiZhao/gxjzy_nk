<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>欢迎使用内控管理平台 </title>
<script src="${base}/resource-modality/js/jquery-1.11.3.min.js"></script>
<script src="${base}/resource/plugins/jquery.cookie.js"></script>
<script language="javascript">
	var loginMsg='${loginMsg}';
	if(loginMsg.length>0){
		alert(loginMsg);
	}
	$(document).ready(function(){
		if ($.cookie("rmbUser") == "true") {
            $("#rememberMe").attr("checked", false);
            $("#accountNo").val($.cookie("username"));
            $("#password").val($.cookie("password"));
        }
		//回车键登录
		document.onkeydown = function (event){
			if (event.keyCode==13){doSubmit();}
		};
	});
	document.onkeydown=function(e){
		var keycode=document.all?event.keyCode:e.which;
		if(keycode==13){
			doSubmit();
		}
	};
    function doSubmit(){
    	if ($("#rememberMe").prop("checked")) {
    	    var accountNo = $("#accountNo").val();//用户名
    	    var password = $("#password").val();//密码
    	    var verificationCode = $("#verificationCode").val();//验证码
    	    $.cookie("rmbUser", "true", { expires: 9999 }); //存储一个带7天期限的cookie
    	    $.cookie("username", accountNo, { expires: 9999 });
    	    $.cookie("password", password, { expires: 9999 });
    	    $.cookie("verificationCode", verificationCode, { expires: 9999 });
    	} else {
    	    $.cookie("rmbUser", "false", { expire: -1 });
    	    $.cookie("username", "", { expires: -1 });
    	    $.cookie("password", "", { expires: -1 });
    	    $.cookie("verificationCode", "", { expires: -1 });
    	}
		document.getElementById("loginForm").submit();
	}
    function changeRememberPassword() {
    	var s = $('#remember-password1').attr('src').substring(34,36);
    	if(s=='f1'){
	    	$('#remember-password1').attr('src','${base}/resource-modality/img/login/o1.png');
    	} else {
    		$('#remember-password1').attr('src','${base}/resource-modality/img/login/f1.png');
    	}
    }

</script> 
<style type="text/css">
input:-webkit-autofill , textarea:-webkit-autofill, select:-webkit-autofill { 
    -webkit-text-fill-color: #008dff !important;  
    -webkit-box-shadow: 0 0 0px 1000px transparent  inset !important;  
    background-color:transparent;  
    background-image: none;  
    transition: background-color 50000s ease-in-out 0s;
   
}  
input {  
     background-color:transparent;  border-radius: 0px 2px 2px 0px;
}

.inpu:focus {
outline:none;
}
.text_put_div{
	width: 64%;margin: 0 auto;padding:7px 0;
}
/* 判断显示屏宽度大于1300的显示大图、小于1300的显示方图 */
.cssDiv{overflow:hidden;background-size:100% 100% ; background-attachment: fixed;font-family:Microsoft YaHei;color:#fff;}
@media screen and (min-width:1301px){
.cssDiv{ background-image:url(${base}/resource-modality/img/login/register_bg1.png); 
}
}
@media screen and (max-width: 1300px){ 
.cssDiv{ background-image:url( b${base}/resource-modality/img/login/register_bg1.png); 
}
 }
</style>
</head>

<body class="cssDiv">
<div style="border-radius:0px;margin:8% 0% 0% 24% ;width:50%;height:50%;">
<div style="width:57%;height:100%;float:left;background:rgba(255,255,255,0.5);">
<img src="${base}/resource-modality/img/login/login.png" style="width:70%;height:15%;margin: 38% 0 0 14%;">
</div>
<form id="loginForm" action="${base}/login.do" style="border-radius:0px;width:43%;height:100%;float:right;background: #FFFFFF;" method="post">
		
		<div style="width:100%;height:36%;text-align: center;">
			<div style="width:100%;height:20%;padding: 15% 0% 8% 0%;color: #408FFA;font-size: 23px;
					font-family: Microsoft YaHei;
					font-weight: bold;letter-spacing: 5px;
					line-height: 26px;">内控管理平台</div>
		</div>
		<div style="width:100%;height:60%;">
			<div class="text_put_div" >
				<span style=""><img src="${base}/resource-modality/img/login/username.png" style="width: 11.5%;height: 11%">
				<input id="accountNo" name="accountNo" class="inpu" type="text" placeholder="请输入您的账号" style="width: 88.5%;
    float: right;height: 11%;background: #FFFFFF;
					border: 1px solid #E4E3E6;
					opacity: 1;
					border-radius: 0px 2px 2px 0px;" autocomplete="off"/>
				</span>
			</div>
			<div class="text_put_div">
				<span style=""><img src="${base}/resource-modality/img/login/password.png" style="width: 11.5%;height: 11%">
				<input id="password" name="password" class="inpu" type="password" placeholder="请输入您的密码" style="width: 88.5%;
    float: right;height: 11%;background: #FFFFFF;
					border: 1px solid #E4E3E6;
					opacity: 1;
					border-radius: 0px 2px 2px 0px;" autocomplete="off""/>
				</span>
			</div>
			<div class="text_put_div" style="margin-top: 0px;">
				<input id="verificationCode" name="verificationCode" class="inpu" type="text" placeholder="请输入验证码" style="width:45%;height:11%;background: #FFFFFF;
					border: 1px solid #E4E3E6;
					opacity: 1;
					border-radius: 0px 2px 2px 0px;" autocomplete="off""/>
				<div style="float: right;width:23%;height:6%;margin-top: 5;">
					<img src="${base}/resource-modality/img/login/hyz.png" onclick="refresh()" style="float: right;width: 100%;height: 100%">
				</div>
				<img id="img" src="${base}/createCode" style="float: right;width:30%;height:11%;">
			</div> 
			<div class="text_put_div" style="margin-top: 20px;">
				<div style="text-align: center;">
					<a id="Asubmit" href="#" onclick="doSubmit()" style="width:100%;height:32px;text-align:center;text-decoration:none;background-color:#008DFF;border-radius:0px;display:block;">
						<span style="font-size:14px;font-family:Microsoft YaHei;text-align:center;font-weight:400;line-height:28px;color:#fff;">登录</span>
					</a>
				</div>
			</div>
		</div>
	</form>
</div>
	<div style="width:100%;height:9%;text-align: center;position: absolute;bottom: 0;opacity:0.7">技术支持：天职（上海）企业管理咨询有限公司</div>
	<script type="text/javascript">
    function refresh(){ 
    	var bean = '${base}';
    	  var url = bean+"/createCode?number="+Math.random();
    	  $("#img").attr("src",url); 
    	}
	</script>
</body>
</html>
