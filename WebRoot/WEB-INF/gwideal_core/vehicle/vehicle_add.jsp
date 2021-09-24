<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>


<div style="border:1px #d9e3e7 solid;height: 192px">
<form id="vehicle_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div style="height: 125px">
		<table cellpadding="0" cellspacing="0" style="padding: 20px">
			<tr>
				<td class="td1">交通工具编码</td>
				<td class="td2">
					<input class="easyui-textbox" style="width: 200px;" value="${bean.code}" name="code" readonly="readonly"/>
					<input type="hidden" name='fId' value="${bean.fId}"/>
					<input type="hidden" name='parentCode' value="${bean.parentCode}"/>
				</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td class="td1">交通工具等级名称</td>
				<td class="td2">
					<input class="easyui-textbox" style="width: 200px;" value="${bean.name}" name="name"/>
				</td>
			</tr>
		</table>
	</div>
	
	<div class="win-left-bottom-div">
		<a href="javascript:void(0)" onclick="saveVehicle()">
			<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>&nbsp;&nbsp;
		<a href="javascript:void(0)" onclick="closeWindow()">
			<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
	</div>
</form>
</div>
<script type="text/javascript">
function saveVehicle(parentCode){
	//提交
	$('#vehicle_save_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			return flag;
		},
		url : base + '/vehicle/save',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#vehicle_save_form').form('clear');
					$('#vehicle_list').datagrid('reload');
					$('#vehicle_list2').datagrid('reload');
				closeWindow();
				
			} else {
				$.messager.alert('系统提示', data.info, 'error');
				$('#vehicle_save_form').form('clear');
				closeWindow();
			}
		}
	});
}
</script>