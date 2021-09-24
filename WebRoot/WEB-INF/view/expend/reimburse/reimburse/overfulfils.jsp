<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
	<form>
		<table style="width: 100%">
			<tr>
				<th colspan="2" style="text-align: center;">该报销单已超出事前申请额度！</th>
			</tr>
			<tr>
				<td style="width: 200px;text-align: right;">报销标准：</td>
				<td>${standard }</td>
			</tr>
			<tr>
				<td style="width: 200px;text-align: right;">报销总金额：</td>
				<td>${amount}</td>
			</tr>
			<tr>
				<td style="width: 200px;text-align: right;">报销超额：</td>
				<td>${applyAmount}</td>
			</tr>
			<tr style="position:absolute;bottom: 10px">
				<td style="width: 200px;text-align: right;">
					<a href="javascript:void(0)" onclick="reimburseChecks1(${sts})">
						<img src="${base}/resource-modality/${themenurl}/button/jxmrbx1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				<td>
					<a href="javascript:void(0)" onclick="closeFirstWindow()">
						<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	</form>
	<script>
//保存
function reimburseChecks1(flowStauts) {
	$('#reimburse_check_form').form('submit', {
		onSubmit : function() {
				$.messager.progress();
		},
		url : base + '/reimburseCheck/checkResult',
		success : function(data) {
				$.messager.progress('close');
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				closeFirstWindow();
				closeWindow();
				$('#reimburse_check_form').form('clear');
				$('#reimburseCheckTab').datagrid('reload'); 
				$("#indexdb").datagrid('reload');
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});
}	
</script>