<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="changeInfo" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 10px;">
			<div class="win-left-top-div">
				<input type="hidden" name="fcId" id="F_fcId" value="${bean.fcId}"/>
	    		<input type="hidden" name="fUptFlowStauts" id="F_fUptFlowStauts" value="${Upt.fUptFlowStauts}"/>
	    		<input type="hidden" name="fId_U" id="F_fId_U" value="${Upt.fId_U}"/>
	    		<input type="hidden" name="fContId_U" id="F_fContId_U" value="${Upt.fContId_U}"/>
	    		<input type="hidden" name="fUptCode" id="F_fUptCode" value="${Upt.fUptCode}"/>
	    		<input type="hidden" name="fUptStatus" id="F_fUptStatus" value="${Upt.fUptStatus}"/>
	    		<input type="hidden" name="fOperatorID" id="F_fOperatorID" value="${Upt.fOperatorID}"/>
	    		<input type="hidden" name="fOperator" id="F_fOperator" value="${Upt.fOperator}"/>
	    		<input type="hidden" name="fDeptID" id="F_fDeptID" value="${Upt.fDeptID}"/>
	    		<input type="hidden" name="fReqTime" id="F_fReqTime" value="${Upt.fReqTime}"/>
	    		<input type="hidden" name="fUserName" id="F_fUserName" value="${Upt.fUserName}"/>
	    		<input type="hidden" name="fUserCode" id="F_fUserCode" value="${Upt.fUserCode}"/>
	    		<input type="hidden" name="fNCode" id="F_fNCode" value="${Upt.fNCode}"/>
	    		<div class="tab-wrapper" id="contract-change-edit">
					<ul class="tab-menu">
						<li class="active">合同信息</li>
						<%-- <c:if test="${!empty uptShow}">
						<li onclick="onclickUpt()">变更合同信息</li>
						</c:if> --%>
						<c:if test="${!empty disputeShow}">
						<!-- <li>合同纠纷</li> -->
						</c:if>
					</ul>
					<div class="tab-content">
						<div title="合同信息" style="margin-bottom:35px;width: 737px;">
							<%@ include file="../formulation/formulation_detail_base.jsp" %>
						</div>
						<%-- <c:if test="${!empty uptShow}">
						<div title="变更合同信息" style="margin-bottom:35px;width: 737px;">
							<%@ include file="../base/contract-change-base-detail.jsp" %>
						</div>
						</c:if> --%>
						<%-- <c:if test="${!empty disputeShow}">
						<div title="纠纷信息" style="margin-bottom:35px;width: 737px;">
							<%@ include file="../base/contract-dispute-base-detail.jsp" %>
						</div>
						</c:if> --%>
					</div>
				</div>
			</div>
			<div class="window-left-bottom-div">
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		<%-- <div class="window-right-div" id="check_system_div" style="width:254px;height: auto;padding-bottom: 20px;">
			<jsp:include page="../../check_system.jsp" />
		</div> --%>
	</div>
</form>
</div>
<script type="text/javascript">
flashtab('contract-change-edit');

$('#F_fcTypeName').combobox({  
    onChange:function(newValue,oldValue){  
    	var fcType = '${findById.fcType}';
    	if(fcType=="HTFL-01"){
    		$('#cg1').show();
    		$('#cg2').show();
    		$('#cg3').show();
    		$('#cg4').show();
    		$('#fLandlineTd').hide();
    		$('#f_fLandlinePhone').hide();
    		$('#finish_fLandlinePhone').textbox({required:false});
    		$('#fTaxpayerNum_show').hide();
    		$('#f_fTaxpayerNum').textbox({required:false});
    		$('#fAddress_show').hide();
    		$('#f_fAddress').textbox({required:false});
    		$('#fCardNo_show').show();
    		$('#fBankName_show').show();
    		$('#recePlanId').show();
    		$.parser.parse("#recePlanId");
    		$('#plan_contract_dg_detail').datagrid('reload');
    		$('#proceedsPlanId').hide();
    		$('#filingPlanId').show();
    		$.parser.parse("#filingPlanId");
    		$('#filing-edit-plan-dg-detail').datagrid('reload');
    	}
    	
    	if(fcType=="HTFL-02"){
    		$('#cg1').hide();
    		$('#cg2').show();
    		$('#cg3').show();
    		$('#cg4').show();
    		$('#fLandlineTd').show();
    		$('#f_fLandlinePhone').show();
    		$('#finish_fLandlinePhone').textbox({required:true});
    		$('#fTaxpayerNum_show').show();
    		$('#f_fTaxpayerNum').textbox({required:true});
    		$('#fAddress_show').show();
    		$('#f_fAddress').textbox({required:true});
    		$('#fCardNo_show').show();
    		$('#fBankName_show').show();
    		$('#recePlanId').hide();
    		$('#proceedsPlanId').show();
    		$('#filingPlanId').hide();
    		$.parser.parse("#proceedsPlanId");
    		$('#proceeds-edit-plan-dg-detail').datagrid('reload');
    	}
    	if(fcType=="HTFL-03"){
    		$('#cg1').hide();
    		$('#cg2').hide();
    		$('#cg3').hide();
    		$('#cg4').hide();
    		$('#fLandlineTd').hide();
    		$('#fCardNo_show').hide();
    		$('#f_fLandlinePhone').hide();
    		$('#finish_fLandlinePhone').textbox({required:false});
    		$('#fTaxpayerNum_show').hide();
    		$('#f_fTaxpayerNum').textbox({required:false});
    		$('#F_fPayType').combobox({required:false});
    		$('#fAddress_show').hide();
    		$('#f_fAddress').textbox({required:false});
    		$('#recePlanId').hide();
    		$('#fTaxpayerNum_show').hide();
    		$('#proceedsPlanId').hide();
    		$('#filingPlanId').hide();
    	}
    }
}); 
function fPurchNo_DC(){
	//var node=$('#c_c_dg').#check-history-dgd('getSelected');
	var win=creatFirstWin('选择-采购订单号',750,550,'icon-add','/PurchaseApply/PurchNoList');
	win.window('open');
}
function quota_DC(){
	//var node=$('#c_c_dg').datagrid('getSelected');
	var win=creatFirstWin('选择-预算指标编号',750,550,'icon-add','/BudgetIndexMgr/contract_list');
	win.window('open');
}
function deleteF1(val){
	var child=document.getElementById(val.id);
	child.parentNode.removeChild(child);
}
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
$(document).ready(function() {
	var fcType = '${bean.fcType}';
	var findType = '${findById.fcType}';
	if(fcType=="HTFL-01" || findType=="HTFL-01"){
		$('#cg11').show();
		$('#cg21').show();
		$('#cg31').show();
		$('#cg41').show();
		$('#dd1').hide();
		$('#fLandlineTd1').hide();
		$('#f_fLandlinePhone1').hide();
		$('#finish_fLandlinePhone1').textbox({required:false});
		$('#fTaxpayerNum_show1').hide();
		$('#f_fTaxpayerNum1').textbox({required:false});
		$('#fAddress_show1').hide();
		$('#f_fAddress1').textbox({required:false});
		$('#fCardNo_show1').show();
		$('#fBankName_show1').show();
		$('#recePlanId1').hide();
		$.parser.parse("#recePlanId1");
		$('#plan_contract_dg_detail').datagrid('reload');
		$('#proceedsPlanId1').hide();
		$('#filingPlanId1').show();
		$.parser.parse("#filingPlanId1");
		$('#filing-edit-plan-dg-detail').datagrid('reload');
	}
	
	if(fcType=="HTFL-02"|| findType=="HTFL-02"){
		$('#cg11').hide();
		$('#cg21').show();
		$('#cg31').show();
		$('#cg41').show();
		$('#dd1').show();
		$('#fLandlineTd1').show();
		$('#f_fLandlinePhone1').show();
		$('#finish_fLandlinePhone1').textbox({required:true});
		$('#fTaxpayerNum_show1').show();
		$('#f_fTaxpayerNum1').textbox({required:true});
		$('#fAddress_show1').show();
		$('#f_fAddress1').textbox({required:true});
		$('#fCardNo_show1').show();
		$('#fBankName_show1').show();
		$('#recePlanId1').hide();
		$('#proceedsPlanId1').show();
		$('#filingPlanId1').hide();
		$.parser.parse("#proceedsPlanId1");
		$('#proceeds-edit-plan-dg-detail').datagrid('reload');
	}
	if(fcType=="HTFL-03" ||findType=="HTFL-03"){
		$('#cg11').hide();
		$('#cg21').hide();
		$('#cg31').hide();
		$('#cg41').hide();
		$('#dd1').hide();
		$('#fLandlineTd1').hide();
		$('#fCardNo_show1').hide();
		$('#fBankName_show1').hide();
		$('#f_fLandlinePhone1').hide();
		$('#finish_fLandlinePhone1').textbox({required:false});
		$('#fTaxpayerNum_show1').hide();
		$('#f_fTaxpayerNum1').textbox({required:false});
		$('#F_fPayType1').combobox({required:false});
		$('#fAddress_show1').hide();
		$('#f_fAddress1').textbox({required:false});
		$('#recePlanId1').hide();
		$('#fTaxpayerNum_show1').hide();
		$('#proceedsPlanId1').hide();
		$('#filingPlanId1').hide();
	}
	//$('#check-history-dg-contract').datagrid('reload');
});
</script>
</body>