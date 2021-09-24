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
function check(result) {
	
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
						<ul class="tab-menu">
							<li class="active">合同信息</li>
							<li>签约方信息</li>
							<li onclick="$('#filing-edit-plan-dg').datagrid('reload')">付款计划</li>
							<c:if test="${!empty Upt.fContUptType}"><li>变更表</li></c:if>
							<c:if test="${!empty dispute.fDisId||!empty dispute.fDisResult}"><li>纠纷信息</li></c:if>
							<li>付款信息</li>
							<c:if test="${checkHistory=='1'}"><li onclick="$('#appli-detail-dg-cont').datagrid('reload')">审批记录</li></c:if>
							<li>资金信息</li>
							<%-- <c:if test="${!empty archiving.fToPosition}"><li>归档位置</li></c:if> --%>
						</ul>
						
						<div class="tab-content">
							<div title="合同信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
								<%@ include file="../../contract/base/contract-formulation-base2.jsp" %>
							</div>
							<div title="签约方信息" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
								<%@ include file="../../contract/base/contract-formulation-sign-base.jsp" %>
							</div>
							<div title="付款计划" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
								<%@ include file="../../contract/base/contract-filing-edit-plan.jsp" %>
							</div>
							<c:if test="${!empty Upt.fContUptType}">
								<div title="变更表" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
									<%@ include file="../../contract/base/contract-change-base.jsp" %>
								</div>
							</c:if>
							<c:if test="${!empty dispute.fDisId||!empty dispute.fDisResult}">
								<div title="纠纷信息" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
									<%@ include file="../../contract/base/contract-dispute-base.jsp" %>
								</div>
							</c:if>
							<div title="付款信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
								<table cellpadding="0" cellspacing="0" class="ourtable" style="margin-left: 20px">
									<tr class="trbody">
										<td class="td1" >付款名称</td>
										<td>
											<input hidden="hidden" id="F_flowStauts" name ="flowStauts">
											<input hidden="hidden" id="F_stauts" name ="stauts">
											<input id=""  class="easyui-textbox" readonly="readonly"  name="" style="width: 150px;" value="${payBean.fRecStage}"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1" >计划付款时间</td>
										<td>
											<input id=""  class="easyui-datebox" readonly="readonly"  name="" style="width: 150px;" value="${payBean.fRecePlanTime}"/>
										</td>
									</tr>
								
									<tr class="trbody">
										<td class="td1" >计划付款金额</td>
										<td>
											<input  class="easyui-textbox" readonly="readonly"  name="" style="width: 150px;" value="${payBean.fRecePlanAmount}"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1" >是否达到付款条件</td>
										<td>
											<input checked="checked" type="radio" value="1" name="outCheckResult"/>是
											<input type="radio" value="0" name="outCheckResult"/>否
										</td>
									</tr>
									
									<tr class="trbody">
										<td class="td1" >实际付款金额</td>
										<td colspan="4">
											<input id=""  class="easyui-numberbox"  name="fReceAmount" style="width: 150px;" value="${payBean.fRecePlanAmount}"/>
										</td>
									</tr>
								</table>
							</div>
							
							
							
							<c:if test="${checkHistory=='1'}">
								<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
									<jsp:include page="../../check_history.jsp" />												
								</div>
							</c:if>
							<input hidden="hidden"  name="fPlanId" value="${payBean.fPlanId}">
							
							<div title="资金信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
								<jsp:include page="../apply/check/fundCheck.jsp" />												
							</div>
							
					</div>
				
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="openCheckWin('受理意见','1')">
					<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="openCheckWin('受理意见','0')">
					<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
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
