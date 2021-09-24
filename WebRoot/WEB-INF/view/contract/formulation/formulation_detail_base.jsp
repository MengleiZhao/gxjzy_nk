<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="合同信息" data-options="collapsible:false" style="overflow:auto;margin-top:10px;">
					<jsp:include page="../change/contract-formulation-base-detail.jsp"/>
				</div>
			</div>
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="签约方信息" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;">
				<jsp:include page="../change/contract-formulation-sign-base-detail.jsp"/>
				</div>
			</div>
			<div id="recePlanId1" hidden="hidden">
			<div class="easyui-accordion" data-options="collapsible:false" id="" style="width:707px;margin-left: 20px">
				<div title="采购清单" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;">
				  	<jsp:include page="../change/contract_cg_mingxi_detail.jsp" />												
				</div>
			</div>
			</div>
			<div id="filingPlanId1" hidden="hidden">
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="付款计划" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<jsp:include page="../change/contract-filing-edit-plan-detail.jsp"/>
				</div>
			</div>
			</div>
			<div id="proceedsPlanId1"  hidden="hidden">
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="收款计划" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<jsp:include page="../change/contract-proceeds-edit-plan-detail.jsp"/>
				</div>
			</div>
			</div>
			<%-- <c:if test="${!empty fsyjsFile}">
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
			</c:if> --%>
			<!-- 附件信息 -->
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
			<div title="附件信息" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
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
						<input id="fqdTime" class="easyui-datebox" name="fSignTime" readonly="readonly" data-options="validType:'length[1,20]',editable:false" style="width: 200px;height: 30px" value="${bean.fSignTime}"/>
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
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="审批记录" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<jsp:include page="../../check_history_contract.jsp" />
				</div>
			</div>
<script type="text/javascript">
flashtab('contract-formulation-add');
//flashtab_pro_add('project-tab');
$('#F_fcAmount').numberbox({
    onChange:function(newValue,oldValue){
    	$('#F_fcAmountMax1').textbox('setValue',convertCurrency(newValue));
    }
});


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

function fcTypeOnClik(){
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
	$('#check-history-dg-contract').datagrid('reload');
}
</script>