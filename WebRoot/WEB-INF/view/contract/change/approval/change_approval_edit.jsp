<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="changeInfoApproval" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div">
	    		<input type="hidden" name="fcId" id="F_fcId" value="${bean.fcId}"/>
				<input type="hidden" name="Id" id="C_fcId" value="${bean.fcId}"/>
				<input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
			    <input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
			    <!-- 审批附件 --><input type="hidden" name="spjlFile" id="spjlFile" value=""/>
	    		<div class="tab-wrapper" id="contract-change-approval">
					<ul class="tab-menu">
						<li class="active">变更表</li>
						<li onclick="fcTypeOnClik()">合同信息</li>
						<li id="cg" class="display_all" onclick="contraOnclik1()">采购信息</li>
					</ul>
					<div class="tab-content">
						<div title="变更表" style="margin-bottom:35px;width: 737px;">
							<jsp:include page="../../base/contract-change-base-detail.jsp" />
						</div>
						<div title="合同信息" style="margin-bottom:35px;width: 737px;">
							<jsp:include page="../../formulation/formulation_detail_base.jsp" />
						</div>
						<div id="cgl" title="采购信息" style="margin-bottom:35px;width: 737px">
							<jsp:include page="../../formulation/cggl_detail_ht.jsp" />
						</div>
					</div>
				</div>
			</div>
			
			<div class="window-left-bottom-div" style="margin-top: 55px;">
				<a href="javascript:void(0)" onclick="openCheckWin('审批意见','1')">
					<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="openCheckWin('审批意见','0')">
					<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<div class="window-right-div" id="check_system_div" style="width:254px;height: auto;padding-bottom: 20px;">
			<jsp:include page="../../../check_system.jsp" />
		</div>
	</div>
</form>
</div>
<script type="text/javascript">
flashtab('contract-change-approval');
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
function check(stauts){
	var fId_U=$('#F_fId_U').val();
	$('#changeInfoApproval').form('submit', {
			onSubmit: function(){ 
				flag=$(this).form('enableValidation').form('validate');
				if(flag){
					$.messager.progress();
				}
				return flag;
			}, 
			url:'${base}/Change/approve/'+stauts+'?fId='+fId_U,
			success:function(data){
				if(flag){
					$.messager.progress('close');
				}
				data=eval("("+data+")");
				if(data.success){
					$.messager.alert('系统提示', data.info, 'info');
					$('#changeInfoApproval').form('clear');
					$("#change_approval_dg").datagrid('reload'); 
					$("#indexdb").datagrid('reload'); 
					closeWindow();
				}else{
					$.messager.alert('系统提示', data.info, 'error');
				}
			} 
		});	
}
 $(document).ready(function(){
	 var fcType = '${bean.fcType}';
		if(fcType=="HTFL-01"){
			$(".display_all").css("display", "");
	   		$('#cg1').show();
	   		$('#cg2').show();
	   		$('#cg3').show();
	   		$('#cg4').show();
	   		$('#dd2').hide();
	   		$('#fLandlineTd2').hide();
	   		$('#f_fLandlinePhone2').hide();
	   		$('#finish_fLandlinePhone2').textbox({required:false});
	   		$('#fTaxpayerNum_show2').hide();
	   		$('#f_fTaxpayerNum2').textbox({required:false});
	   		$('#fAddress_show2').hide();
	   		$('#f_fAddress2').textbox({required:false});
	   		$('#fCardNo_show2').show();
	   		$('#fBankName_show2').show();
	   		$('#recePlanId3').hide();
	   		$('#recePlanId2').show();
	   		$('#recePlanId').show();
	   		$.parser.parse("#recePlanId");
	   		$.parser.parse("#recePlanId2");
	   		$.parser.parse("#recePlanId3");
	   		$('#plan_contract_dg_detail').datagrid('reload');
	   		$('#plan_contract_dg_detail_change').datagrid('reload');
	   		$('#proceedsPlanId').hide();
	   		$('#proceedsPlanId2').hide();
	   		$('#proceedsPlanId3').hide();
	   		$('#filingPlanId').show();
	   		$('#filingPlanId2').show();
	   		$('#filingPlanId3').show();
	   		$.parser.parse("#filingPlanId");
	   		$.parser.parse("#filingPlanId2");
	   		$.parser.parse("#filingPlanId3");
	   		$('#filing-edit-plan-dg-detail').datagrid('reload');
	   		$('#filing-edit-plan-dg-detail-change').datagrid('reload');
	   		
		}
	   	
	   	if(fcType=="HTFL-02"){
	   		$(".display_all").css("display", "none");
	   		$('#cg12').hide();
	   		$('#cg22').show();
	   		$('#cg3').show();
	   		$('#cg4').show();
	   		$('#dd2').show();
	   		$('#fLandlineTd2').show();
	   		$('#f_fLandlinePhone2').show();
	   		$('#finish_fLandlinePhone2').textbox({required:true});
	   		$('#fTaxpayerNum_show2').show();
	   		$('#f_fTaxpayerNum2').textbox({required:true});
	   		$('#fAddress_show2').show();
	   		$('#f_fAddress2').textbox({required:true});
	   		$('#fCardNo_show2').show();
	   		$('#fBankName_show2').show();
	   		$('#recePlanId').hide();
	   		$('#recePlanId2').hide();
	   		$('#recePlanId3').hide();
	   		$('#recePlanId4').hide();
	   		$('#proceedsPlanId').show();
	   		$('#proceedsPlanId3').show();
	   		$('#proceedsPlanId4').show();
	   		$('#filingPlanId').hide();
	   		$('#filingPlanId2').hide();
	   		$('#filingPlanId3').hide();
	   		$('#filingPlanId4').hide();
	   		$('#proceedsPlanId2').show();
	   		$.parser.parse("#proceedsPlanId");
	   		$.parser.parse("#proceedsPlanId2");
	   		$.parser.parse("#proceedsPlanId3");
	   		$.parser.parse("#proceedsPlanId4");
	   		$('#proceeds-edit-plan-dg-detail').datagrid('reload');
		}
	   	if(fcType=="HTFL-03"){
	   		$(".display_all").css("display", "none");
	   		$('#cg12').hide();
	   		$('#cg22').hide();
	   		$('#cg3').hide();
	   		$('#cg4').hide();
	   		$('#dd2').hide();
	   		$('#fLandlineTd2').hide();
	   		$('#fCardNo_show2').hide();
	   		$('#f_fLandlinePhone2').hide();
	   		$('#finish_fLandlinePhone2').textbox({required:false});
	   		$('#fTaxpayerNum_show2').hide();
	   		$('#f_fTaxpayerNum2').textbox({required:false});
	   		$('#F_fPayType').combobox({required:false});
	   		$('#fAddress_show2').hide();
	   		$('#f_fAddress2').textbox({required:false});
	   		$('#recePlanId').hide();
	   		$('#recePlanId2').hide();
	   		$('#recePlanId3').hide();
	   		$('#recePlanId4').hide();
	   		$('#fTaxpayerNum_show2').hide();
	   		$('#proceedsPlanId').hide();
	   		$('#proceedsPlanId2').hide();
	   		$('#proceedsPlanId3').hide();
	   		$('#proceedsPlanId4').hide();
	   		$('#filingPlanId').hide();
	   		$('#filingPlanId2').hide();
	   		$('#filingPlanId3').hide();
	   		$('#filingPlanId4').hide();
		}
}); 
function fcTypeOnClik(){
	var fcType = '${bean.fcType}';
	if(fcType=="HTFL-01"){
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
   	
   	if(fcType=="HTFL-02"){
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
   	if(fcType=="HTFL-03"){
   		$('#cg11').hide();
   		$('#cg21').hide();
   		$('#cg31').hide();
   		$('#cg41').hide();
   		$('#dd1').hide();
   		$('#fLandlineTd1').hide();
   		$('#fCardNo_show1').hide();
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
   		$('#dd1').hide();
	}
   	$('#check-history-dg-contract').datagrid('reload'); 
}
function contraOnclik1(){
	var fPurchNo = $("#F_fPurchNo1").val();
	if(fPurchNo == '' || fPurchNo == null){
		alert('请先选择采购订单！');
		return false;
	}else{
		$('#cgl').load('${base}/Formulation/cgdetail?id=' + fPurchNo);
	}
}
</script>
</body>