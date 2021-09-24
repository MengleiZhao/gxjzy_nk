<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div style="border:1px #d9e3e7 solid;height: 252px">
<form id="area_batch_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<input type="hidden" name='parentCode' value="${parentCode}"/>
	<input type="hidden" name='firstCode' value="${firstCode}"/>
	<div style="height: 185px">
		<table cellpadding="0" cellspacing="0" style="padding: 20px">
			<tr>
				<td class="td1">地区名称</td>
				<td class="td2">
					<input class="easyui-textbox" data-options="multiline:true,required:false,validType:'length[0,250]'" name="nameList" style="width:200px;height:70px;"/>
				</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2"><span style="color:#ff6800">✧地区名称输入案例：东城,西城,崇文,宣武,朝阳,丰台</span><br><span style="color:#ff6800">(各个城市地区之间用</span><span style="color: red;font-weight: bold;">英文“,”</span><span style="color:#ff6800">隔开</span>)</td>
			</tr>
		</table>
	</div>
	
	<div class="win-left-bottom-div">
		<a href="javascript:void(0)" onclick="saveBatchArea()">
			<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>&nbsp;&nbsp;
		<a href="javascript:void(0)" onclick="closeWindow()">
			<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
	</div>
</form>
</div>
<script type="text/javascript">
function saveBatchArea(){
	//提交
	$('#area_batch_save_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if(flag){
					$.messager.progress();
			}
			return flag;
		},
		url : base + '/area/batchSave',
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