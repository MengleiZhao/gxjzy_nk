<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="window-div">
<form id="ApprovalAddEditForm" action="${base}/Approval/approve" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
		<div class="window-left-div" data-options="region:'west',split:true" style="width: 765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div">
				<input type="hidden" name="fcId" id="F_fcId" value="${bean.fcId}"/>
				<input type="hidden" id="totalAmount" name="totalAmount" value="${bean.totalAmount }"/>
    			<input type="hidden" name="fBudgetIndexCode" id="F_indexId" value="${bean.fBudgetIndexCode}"/>
    			<input type="hidden" name="proDetailId" id="F_proDetailId" value="${bean.proDetailId}"/>
    			<%-- <input type="hidden" name="fcType" id="fcType" value="${bean.fcType}"/> --%>
	    		<c:if test="${bean.fcId!=null}">
	    			<input type="hidden" name="fUserName" id="F_fUserName" value="${bean.fUserName}"/>
	    			<input type="hidden" name="fUserCode" id="F_fUserCode" value="${bean.fUserCode}"/>
	    			<input type="hidden" name="fProCode" id="F_fProCode" value="${bean.fProCode}"/>
	    			<input type="hidden" name="fNCode" id="F_fNCode" value="${bean.fNCode}"/>
	    			<input type="hidden" name="fPayStauts" id="F_fPayStauts" value="${bean.fPayStauts}"/>
	    			<input type="hidden" name="fOperatorId" id="F_fOperatorId" value="${bean.fOperatorId}"/>
	    			<input type="hidden" name="fReqtIME" id="F_fReqtIME" value="${bean.fReqtIME}"/>
	    			 <input type="hidden" name="fDeptId" id="F_fDeptId" value="${bean.fDeptId}"/> 
	    			<input type="hidden" name="fContractor" id="F_fContractor" value="${signInfo.fSignName}"/>
	    		</c:if>
	    		<%-- <input type="hidden" name="fcId" id="F_fcId" value="${bean.fcId}"/> --%>
				<input type="hidden" name="Id" id="C_fcId" value="${bean.fcId}"/>
				<input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
			    <input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
			    <!-- 审批附件 --><input type="hidden" name="spjlFile" id="spjlFile" value=""/>
	    		<div class="tab-wrapper" id="contract-change-edit">
					<ul class="tab-menu">
						<li class="active">合同表</li>
						<li id="cg" onclick="contraOnclik()">采购信息</li>
					</ul>
					<div class="tab-content">
						<div title="合同表" style="margin-bottom:0px;width: 737px">
							<%@ include file="../../formulation/approval/approval_add_ht.jsp" %>
						</div>
						    <div id="cgxxs" title="采购信息" style="margin-bottom:35px;width: 737px">
							<jsp:include page="../../formulation/cggl_detail_ht.jsp" />
							</div>   
					</div>
				</div>
			</div>
			<div class="window-left-bottom-div">
				<c:if test="${openType=='add'||openType=='edit'}">
					<a href="javascript:void(0)" onclick="openCheckWin('审批意见','1')">
						<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="openCheckWin('审批意见','0')">
						<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
				</c:if>
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		<div class="window-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../../check_system.jsp" />
		</div>
</form>
</div>
<script type="text/javascript">
	//flashtab('contract-approval-add');
	flashtab('contract-change-edit');
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
	var num=0;
	$('#filing-edit-plan-dg').datagrid({
		onBeforeLoad : function (param){
			if(num>2){
				return false;
			}else{
				num=num+1;
				return true;
			}
		}
	});
	$.messager.progress('close');
		function check(stauts){
			if(${fsyjsFile==1}){
				var s1="";
				$(".fsyjsfileUrl").each(function(){
					s1=s1+$(this).attr("id")+",";
				});
				$('#fsyjsfiles').val(s1);
				if(s1==''){
					alert('请上传法审意见书!');
					return false;
				}
			}
			//var a = '${bean.fcId}';
			var fFlowStauts = $("#CF_fFlowStauts").val(stauts);
			$('#ApprovalAddEditForm').form('submit', {
				onSubmit: function(){ 
					$.messager.progress();
   				},
   				//url:'${base}/Approval/approve',
   				
   				data : {
					'fFlowStauts' : fFlowStauts
				},
   				success:function(data){
   					data=eval("("+data+")");
					$.messager.progress('close');
   					if(data.success){
   						$.messager.alert('系统提示', data.info, 'info');
   						$('#ApprovalAddEditForm').form('clear');
   						$("#CF_app_dg").datagrid('reload'); 
   						$("#indexdb").datagrid('reload'); 
   						closeWindow();
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   					}
   				} 
   			});	
		}
		

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
		    		$('#recePlanId').hide();
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

		 function contraOnclik(){
				var fPurchNo = $("#F_fPurchNo").val();
				if(fPurchNo == '' || fPurchNo == null){
					alert('请先选择采购订单！');
					return false;
				}else{
					$('#cgxxs').load('${base}/Formulation/cgdetail?id=' + fPurchNo);
					//$('#cgl1').load('${base}/Formulation/cgdetail?id=' + fPurchNo);
					//$('#cgl').load('${base}/Formulation/cgdetail?id=' + fPurchNo);
					//$("#cgl").load("${base}/Formulation/cgdetail?id="+fPurchNo);
				}
			}
</script>
</body>