<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<form id="storage_imput_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
<div style="width: 436px;height: 127px;border:1px #d9e3e7 solid;">
	<table style="width: 436px;height: 127px;" cellpadding="0" cellspacing="0" border="0" >
		<tr>
			<td style="padding-left: 20px;width: 60px">导入文件</td>
			<td>
				<input style="width: 260px;" value="${bean.deptName}" readonly="readonly" id="fil" name="" class="easyui-textbox"/>
				<input type="file" id="f" name="xlsx" onchange="upFile()" hidden="hidden">
			</td>
			<td style="padding-right: 20px">
				<a onclick="$('#f').click()" style="font-weight: bold;" href="#">
					<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
				</a>
			</td>
		</tr>
		<tr style="text-align: center;">
			<td colspan="3">
				<a href="javascript:void(0)" onclick="save()">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="closeFirstWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</td>
		</tr>
	</table>
</div>
</form>

<script type="text/javascript">
function upFile() {
	var url = $("#f").val();
	$('#fil').textbox('setValue',url);
}

function save() {
	//保存导入的xml文件
	var url = $('#fil').textbox('getValue');
	var arr = url.split('.')[1];
	var formData = new FormData($('#storage_imput_form')[0]);
	if(arr != "xlsx") {
		alert("请上传xlsx文件！");
	} else {
		$.messager.progress();
		$.ajax({
        	type: 'post',
            url: base+'/Storage/collect',
			data: formData,
			cache: false,
			processData: false,
			contentType: false,
			dataType: 'json',
		}).success(function (data) {
			$.messager.progress('close');
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
			$('#storage_imput_form').form('clear');
			$('#basicIndex').datagrid('reload');
			$('#proIndex').datagrid('reload');
		}).error(function () {
			$.messager.progress('close');
			alert('上传失败！');
		});
		closeWindow();
	}
}
</script>