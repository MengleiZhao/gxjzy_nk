<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div style="width: 536px;height: 300px;padding: 10px;">
<form id="backups_form" action="${base}/backups/saveBackups" method="post" data-options="novalidate:true" class="easyui-form" >
	<div style="width: 536px;height: 220px" borger="0">
		<table id="backups_tab" style="width: 536px;height: 160px;">
			<tr style="height: 90px;">
				<td valign="top" style="width:100px;padding-top: 15px;"><span class="style1">*</span>&nbsp;备份描述</td>
				<td>
					<input type="hidden" name="type" value="${type}" />
					<textarea id="backups_msg" name="msg" class="textbox-text" oninput="textareaNum(this,'textareaNum1')" required="required" 
					 autocomplete="off"  style="width:460px;height:110px"></textarea>
				</td>
			</tr>
			<tr style="height: 20px;">
				<td align="right" colspan="2" style="padding-right: 10px;">
				可输入剩余数：<span id="textareaNum1" class="200">200</span>
				</td>
			</tr>			
		</table>
	</div>	
	<div class="win-left-bottom-div" style="height: 30px;line-height: 47px">
		<a href="javascript:void(0)" onclick="saveBackupsClick('${type}')">
			<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
		&nbsp;
		<a href="javascript:void(0)" onclick="closeWindow()">
			<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
	</div>
</form>
</div>
<script type="text/javascript">
function saveBackupsClick(type){
	var msg = $('#backups_msg').val();
	if(!isNotEmpty(msg)){
		$.messager.alert('系统提示','请填写备份描述。','info');
		return;
	}
	$('#backups_form').form('submit', {
		onSubmit : function(param) {
			var	flag=$(this).form('enableValidation').form('validate');
			if(flag){
				$.messager.progress();
			}
			return flag;
		},
		url : base+'/backups/saveBackups',
		success : function(data) {
			$.messager.progress('close');
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示',data.info,'info');
				closeWindow();
				$('#backups_tab').datagrid('reload');
			}else{
				$.messager.alert('系统提示',data.info,'error');
			}
		},
		error: function() {
			//请求出错处理
		}
	});
			
}
function saveBackupsClickAjax(type){
	$.messager.progress();
	$.ajax({
		url: base+'/backups/saveBackups',
		type: 'post',
		dataType: 'json',
		data: {'type': type},
		success: function(data){
			$.messager.progress('close');
			
			$.messager.alert('系统提示',data.info,'info');
		},
		error: function() {
			//请求出错处理
		}
	});
}
</script>
</body>