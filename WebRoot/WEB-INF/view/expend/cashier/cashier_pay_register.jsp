<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body>
<form id="cashier_pay_register_form" method="post" data-options="novalidate:true" class="easyui-form"  enctype="multipart/form-data">
<div class="window-div">
		<div class="window-left-div" data-options="region:'west',split:true">
			<div class="window-left-top-div"  style="height: 150px;">
				<%@ include file="../apply/check/fundCheck.jsp" %>
				<input hidden="hidden" name="rId" id="fid" value="${ID }"/>
			</div>
			
			<div class="window-left-bottom-div" >
				<a href="javascript:void(0)" onclick="savePayRegister();">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
</div>
</form>
<script type="text/javascript">

function savePayRegister(){
	$('#cashier_pay_register_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}
			return flag;
		},
		url : base + '/cashier/payRegister',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				closeWindow();
				$.messager.alert('系统提示', data.info, 'info');
				$('#cashier_pay_register_form').form('clear');
				$('#reimburseCashierTab').datagrid('reload');
				$('#reimburseCashierTab').datagrid('reload');
				$('#currentCashierTab').datagrid('reload');
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});
}

//审定
function check(result) {
	$('#cashier_pay_register_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}
			return flag;
		},
		url : base + '/cashier/reimburseCashierResult?result='+result,
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				$('#cashier_pay_register_form').form('clear');
				$('#reimburseCashierTab').datagrid('reload');
				$('#purchaseCashierTab').datagrid('reload');
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});
}

</script>
</body>


