<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<script type="text/javascript">
//加载tab页
flashtab('contract-enforcing-cashier');	

$('#F_fcType').combobox({  
       onChange:function(newValue,oldValue){  
   	var sel2=$('#F_fcType').combobox('getValue');
   	if(sel2!="1"){
   		$('#cg1').hide();
   		//$('#cg2').hide();
   		//$('#F_fPurchNo').next(".textbox").show();
	}else{
   		$('#cg1').show();
   		//$('#cg2').show();
   		//$('#F_fPurchNo').next(".textbox").hide();
	} 
       }
   }); 

//审批
function savecheck() {
	$('#fcheckResult').val(1);
	var payId = $('#contBeanPayId').val();
	var bankAccountId = $('#bankAccountId').val();
	
	$('#contract_reimburse_cashier_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}
			return flag;
		},
		url : base + '/cashier/contractCashierResult?payId='+payId+'&bankAccountId='+bankAccountId,
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				$('#contract_reimburse_cashier_form').form('clear');
				$('#contractReimbCashierTab').datagrid('reload'); 
				$("#indexdb").datagrid('reload');
			} else {
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#contract_reimburse_cashier_form').form('clear');
			}
		}
	});
}

	var c =0;
	//时间格式化
	function ChangeDateFormat(val) {
		//alert(val)
		var t, y, m, d, h, i, s;
		if (val == null) {
			return "";
		}
		t = new Date(val)
		y = t.getFullYear();
		m = t.getMonth() + 1;
		d = t.getDate();
		h = t.getHours();
		i = t.getMinutes();
		s = t.getSeconds();
		// 可根据需要在这里定义时间格式  
		return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
	}

</script>
<div class="win-div">
<form id="contract_reimburse_cashier_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<input type="hidden" name="fcId" id="dispute_fcId" value="${bean.fcId}"/>
	    		<input type="hidden" name="fFlowStauts" id="dispute_fFlowStauts" value="${bean.fFlowStauts}"/>
	    		<input type="hidden" name="fContStauts" id="dispute_fContStauts" value="${bean.fContStauts}"/>
	    		<input type="hidden" name="fUserName" id="dispute_fUserName" value="${bean.fUserName}"/>
	    		<input type="hidden" name="fUserCode" id="dispute_fUserCode" value="${bean.fUserCode}"/>
	    		<input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
			    <input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
			    <!-- 审批附件 --><input type="hidden" name="spjlFile" id="spjlFile" value=""/>
	    		<div class="tab-wrapper" id="contract-enforcing-cashier">
						
						<div class="tab-content">
							<input hidden="hidden"  name="fPlanId" value="${payBean.fPlanId}">
							
							<div title="资金信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;margin-left: 10px;">
								<jsp:include page="../apply/check/fundCheck.jsp" />												
							</div>
							
					</div>
				
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="savecheck()">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<%-- <a href="javascript:void(0)" onclick="openCheckWin('受理意见','0')">
					<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp; --%>
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				
				<input id="contBeanPayId" hidden="hidden" value="${contBean.payId}" />
			</div>
		</div>
	
	
		<%-- <div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div> --%>
	</div>
</form>
</div>
</body>
