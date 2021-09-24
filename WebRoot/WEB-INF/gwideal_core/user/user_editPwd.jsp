<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
<link rel="stylesheet" type="text/css" href="${base}/resource/ui/themes/cockpit/cockpit.css">
	<style type="text/css">
	.pwd_tr{
		line-height: 30px;
	}
	</style>
	<script type="text/javascript">
		function userEditPwdForm(){
			var flag=false;
			$('#userEditPwdForm').form('submit', {
				onSubmit: function(){
					flag=$(this).form('enableValidation').form('validate');
					if(flag){
						$.messager.progress();
					}
					return flag;
				}, 
				dataType:'json',
				success:function(data){
					if(flag){
						$.messager.progress('close');
					}
					var data = eval('(' + data + ')');
					if(data.success){
						alert(data.info);
						closeWindow();
					}else{
						$.messager.alert('系统提示',data.info,'error');
					}
				} 
			});
		}
	</script>
    <div class="easyui-layout" fit="true">
    	<div region="center" border="false">
	    	<form id="userEditPwdForm" action="${base}/user/saveEditPwd" method="post" data-options="novalidate:true" class="easyui-form">
	    		<input type="hidden" name="userId" value="${currentUser.id}"/>
				<table border="0" cellpadding="0" cellspacing="0" class="main_table">
					<tr>
						<th style="font-size: 16px; color: blue;">&nbsp;账号信息</th>
					</tr>
					<tr class="pwd_tr">
						<th width="20%">&nbsp;&nbsp;用户姓名</th>
						<td width="80%">
							${currentUser.name}（不可修改）
						</td>
					</tr>
					<tr class="pwd_tr">
						<th width="20%">&nbsp;&nbsp;系统账号</th>
						<td width="80%">
							${currentUser.accountNo}（不可修改）
						</td>
					</tr>
					<tr class="pwd_tr">
						<th><span style="color: red;">*</span>当前密码</th>
						<td>
							<input class="easyui-textbox" type="password" name="originalPwd" data-options="required:true,validType:'length[1,50]'" size="30" style="height:30px;"/> 必填
						</td>
					</tr>
					<tr class="pwd_tr">
						<th><span style="color: red;">*</span>新密码</th>
						<td>
							<input class="easyui-textbox" type="password" name="newPwd" data-options="required:true,validType:'length[6,12]'" size="30" style="height:30px;"/> 必填
						</td>
					</tr>
					<tr class="pwd_tr">
						<th><span style="color: red;">*</span>确认新密码</th>
						<td>
							<input class="easyui-textbox" type="password" name="confirmNewPwd" data-options="required:true,validType:'length[6,12]'" size="30" style="height:30px;"/> 必填
						</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr class="">
						<td style="color: #ff6800" colspan="2">
							<div>&nbsp;&nbsp;温馨提示：</div>
							<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✧&nbsp;密码长度为6-12位;</div>
							<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✧&nbsp;密码不能包含空格和! & @ # ^ & * 等特殊字符;</div>
							<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✧&nbsp;为提升账号安全，建议您3-4周更换一次密码。</div>
						</td>
					</tr>
					<tr class="pwd_tr" style="height:50px;">
						<td colspan="2" style="text-align: center;">
							<a href="javascript:void(0)" onclick="userEditPwdForm();">
								<img src="${base}/resource-modality/${themenurl}/button/baocun1.png"
									onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/baocun2.png')"
									onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/baocun1.png')"
								/>
							</a> 
							<a href="javascript:void(0)" onclick="closeWindow();">
								<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png"
									onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/guanbi2.png')"
									onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/guanbi1.png')"
								/>
							</a>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>

