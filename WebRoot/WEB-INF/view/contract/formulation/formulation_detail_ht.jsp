<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<script type="text/javascript" src="/resource/custom/custom.js"></script>
<body>
<div class="window-div">
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="合同信息" data-options="collapsible:false" style="overflow:auto;margin-top:10px;">
					<jsp:include page="../base/contract-formulation-base-detail.jsp"/>
				</div>
			</div>
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="签约方信息" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;">
				<jsp:include page="../base/contract-formulation-sign-base-detail.jsp"/>
				</div>
			</div>
			<div id="recePlanId" hidden="hidden">
			<div class="easyui-accordion" data-options="collapsible:false" id="" style="width:707px;margin-left: 20px">
				<div title="采购清单" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;">
				  	<jsp:include page="../base/contract_cg_mingxi_detail.jsp" />												
				</div>	
			</div>
			</div>
			<div id="filingPlanId" hidden="hidden">
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="付款计划" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<jsp:include page="../base/contract-filing-edit-plan-detail.jsp"/>
				</div>
			</div>
			</div>
			<div id="proceedsPlanId"  hidden="hidden">
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="收款计划" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<jsp:include page="../base/contract-proceeds-edit-plan-detail.jsp"/>
				</div>
			</div>
			</div>
			<c:if test="${!empty fsyjsFile}">
			<!-- 附件信息 -->
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
			<div title="法审意见书" data-options="collapsed:false,collapsible:false" style="overflow:auto;">		
				<table class="window-table">
					<tr>
						<c:if test="${fsyjsFile==0}">
							<td class="td1" style="width:80px;">意见书</td>
							<td colspan="4">
								<c:if test="${!empty formulationAttaList}">
									<c:forEach items="${formulationAttaList}" var="att">
										<c:if test="${att.serviceType=='fsyjs'}">
											<a href='${base}/attachment/download/${att.id}'
												style="color: #666666;font-weight: bold;">${att.originalName}</a>
											<br>
										</c:if>
									</c:forEach>
								</c:if>
							</td>	
						</c:if>
					</tr>
				</table>
			</div>
			</div>
			</c:if>
			<!-- 附件信息 -->
			<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
			<div title="附件信息" data-options="collapsed:false,collapsible:false"
				style="overflow:auto;">		
				<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
					<tr>
						<td class="td1" style="width:55px;text-align: left">
							&nbsp;&nbsp;附件
						</td>
						<td colspan="4" id="htndtdf">
							<c:forEach items="${formulationAttaList}" var="att">
								<c:if test="${att.serviceType=='fhtnd' }">
									<div style="">
										<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
									</div>
								</c:if>
							</c:forEach>
						</td>
					</tr>
				</table>
			</div>
			</div>
			<!-- 原合同已盖章合同文本 -->
			<%-- <div class="easyui-accordion" style="width:707px;margin-left: 20px">
			<div title="原合同已盖章合同文本" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
				 	<tr class="trbody">
						<td class="td1"><span class="style1">*</span>&nbsp;签订日期</td>
						<td class="td2" colspan="4">
						<input id="fqdTime" class="easyui-datebox" readonly="readonly" data-options="validType:'length[1,20]',editable:false" style="width: 200px;height: 30px" value="${bean.fSignTime}"/>
						</td >
					</tr>
					<tr>
						<td class="td1" style="width:95px;">
							&nbsp;&nbsp;已盖章合同文本
						</td>
						<td colspan="4">
							<c:forEach items="${formulationAttaList}" var="att">
								<c:if test="${att.serviceType=='ygzhtwb'}">
									<div style="">
										<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
									</div>
								</c:if>
							</c:forEach>
						</td>
					</tr>
				</table>
			</div>
			</div> --%>
			<c:if test="${openType != 'add'}">
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="审批记录" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<jsp:include page="../../check_history.jsp" />
				</div>
			</div>
			</c:if>
			</div>
<script type="text/javascript">
flashtab('contract-formulation-add');
$(document).ready(function() {
	
});
//flashtab_pro_add('project-tab');
function flashtab(tabid) {
 var $wrapper = $('#'+tabid),
  $allTabs = $wrapper.find('.tab-content > div'),
  $tabMenu = $wrapper.find('.tab-menu li');
  $line = $('<div class="line"></div>').appendTo($tabMenu);
 
 $allTabs.not(':first-of-type').hide();  
 $tabMenu.filter(':first-of-type').find(':first').width('100%');
 
 $tabMenu.each(function(i) {
   $(this).attr('data-tab', 'tab'+i);
 });
 
 $allTabs.each(function(i) {
   $(this).attr('data-tab', 'tab'+i);
 });
 
 $tabMenu.on('click', function() {
   var dataTab = $(this).data('tab');
   $getWrapper = $(this).closest($wrapper);
   
   $getWrapper.find($tabMenu).removeClass('active');
   $(this).addClass('active');
   
   $getWrapper.find('.line').width(0);
   $(this).find($line).animate({'width':'100%'}, 'fast');
   $getWrapper.find($allTabs).hide();
   $getWrapper.find($allTabs).filter('[data-tab='+dataTab+']').show();
 });
}


var c=0;
$('#F_fcAmount').numberbox({
    onChange:function(newValue,oldValue){
    	$('#F_fcAmountMax').textbox('setValue',convertCurrency(newValue));
    }
});


var num = 0;
 $('#F_fcTypeName').combobox({  
        onSelect:function(rec){
    	if(rec.code=="HTFL-01"){
    		$('#F_fcType').val("HTFL-01");
    		$('#cg1').show();
    		$('#cg2').show();
    		$('#cg3').show();
    		$('#cg4').show();
    		$('#dd').hide();
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
    	
    	if(rec.code=="HTFL-02"){
    		$('#F_fcType').val("HTFL-02");
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
    	if(rec.code=="HTFL-03"){
    		$('#F_fcType').val("HTFL-03");
    		$('#cg1').hide();
    		$('#cg2').hide();
    		$('#cg3').hide();
    		$('#cg4').hide();
    		$('#dd').hide();
    		$('#fLandlineTd').hide();
    		$('#fCardNo_show').hide();
    		$('#fBankName_show').hide();
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

</script>
</body>