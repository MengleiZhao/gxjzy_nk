<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<script type="text/javascript">
//保存
function saveAffirm(flowStauts){
	var accountantNum = $('#accountantNum').textbox('getValue');
	var fReceTime = $('#fReceTime').datebox('getValue');
	if(accountantNum==''){
		alert('请填写会计凭证号！');
		return false;
	}
	if(fReceTime==''){
		alert('请填写实际来款日期！');
		return false;
	}
	//提交
	$('#contract_affirm_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				//如果校验通过，则进行下一步
				$.messager.progress();
			}else{
				//校验不通过，就打开第一个校验失败的手风琴
				openAccordion();
			}
			return flag;
		},
		url : base + '/proceedsPlan/save',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#ContractRevenueTab').datagrid('reload');
				closeWindow();
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});
}
</script>
<form id="contract_affirm_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 471px;border: 1px solid #D9E3E7;margin-top: 10px;">
			<div class="win-left-top-div">
				<!-- 隐藏域 --> 
				<!-- 主键 ID --><input type="hidden" id="f_fPId" name="fPId" value="${id}" />
				<!-- 主键 ID --><input type="hidden" id="f_fContId" name="fContId" value="${cId}" />
				<!-- 主键 ID --><input type="hidden" id="f_dataType" name="dataType" value="${type}" />
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 13px;">
						<tr class="trbody">
							<td class="td1" style="width: 90px;"><span class="style1">*</span> 实际来款日期</td>
							<td class="td2" >
								<input class="easyui-datebox" id="fReceTime" name="fReceTime" style="width: 247px;height: 30px;margin-left: 10px " data-options="editable:false" >
							</td>
							<td class="td1" style="width: 90px;"><span class="style1">*</span> 会计凭证号</td>
							<td class="td2" >
								<input class="easyui-textbox" id="accountantNum" name="accountantNum" style="width: 247px;height: 30px;margin-left: 10px">
							</td>
						</tr>
					</table>
			</div>
			<div class="window-left-bottom-div" style="margin-top: 35px;">
				<a href="javascript:void(0)" onclick="saveAffirm(1)">
				<img src="${base}/resource-modality/${themenurl}/button/queren1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	</div>
</form>
