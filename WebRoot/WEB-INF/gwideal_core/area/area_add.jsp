<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>


<div style="border:1px #d9e3e7 solid;height: 252px">
<form id="area_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div style="height: 185px">
		<table cellpadding="0" cellspacing="0" style="padding: 20px">
			<tr>
				<td class="td1">省市地区编码</td>
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
				<td class="td1">省市地区名称</td>
				<td class="td2">
					<input class="easyui-textbox" style="width: 200px;" value="${bean.name}" name="name"/>
				</td>
			</tr>
			<c:if test="${!empty bean.parentCode}">
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td class="td1">城市等级</td>
				<td class="td2">
					<input class="easyui-combobox" style="width: 200px;" name="level"
					data-options="url:base+'/lookup/lookupsJson?parentCode=CSDJ&selected=${bean.level}',
								method:'get',valueField:'code',textField:'text',editable:false"/>
				</td>
			</tr>
			</c:if>
		</table>
	</div>
	
	<div class="win-left-bottom-div">
		<a href="javascript:void(0)" onclick="saveArea()">
			<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>&nbsp;&nbsp;
		<a href="javascript:void(0)" onclick="closeWindow()">
			<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
	</div>
</form>
</div>
<script type="text/javascript">
function saveArea(parentCode){
	//提交
	$('#area_save_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if(flag){
				$.messager.progress();
			}
			return flag;
		},
		url : base + '/area/save',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#area_save_form').form('clear');
					$('#area_list').datagrid('reload');
					$('#area_list2').datagrid('reload');
				closeWindow();
				
			} else {
				$.messager.alert('系统提示', data.info, 'error');
				$('#area_save_form').form('clear');
				closeWindow();
			}
		}
	});
}
</script>