<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="合同信息" data-options="collapsible:false" style="overflow:auto;margin-top:10px;">
					<jsp:include page="../change/contract-formulation-base-detail-change.jsp"/>
				</div>
			</div>
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="签约方信息" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;">
				<jsp:include page="../change/contract-formulation-sign-base-detail-change.jsp"/>
				</div>
			</div>
			<div id="recePlanId3" hidden="hidden">
			<div class="easyui-accordion" data-options="collapsible:false" id="" style="width:707px;margin-left: 20px">
				<div title="采购清单" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;">
				  	<jsp:include page="../change/contract_cg_mingxi_detail.jsp" />												
				</div>
			</div>
			</div>
			<div id="recePlanId4" hidden="hidden">
			<div class="easyui-accordion" data-options="collapsible:false" id="" style="width:707px;margin-left: 20px">
				<div title="变更后采购清单" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;">
				  	<jsp:include page="../change/contract_cg_mingxi_detail-change.jsp" />												
				</div>
			</div>
			</div>
			<div id="filingPlanId3" hidden="hidden">
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="付款计划" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<jsp:include page="../change/contract-filing-edit-plan-detail.jsp"/>
				</div>
			</div>
			</div>
			<div id="filingPlanId4" hidden="hidden">
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="变更后付款计划" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<jsp:include page="../change/contract-filing-edit-plan-detail-change.jsp"/>
				</div>
			</div>
			</div>
			<div id="proceedsPlanId3"  hidden="hidden">
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="收款计划" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<jsp:include page="../change/contract-proceeds-edit-plan-detail.jsp"/>
				</div>
			</div>
			</div>
			<div id="proceedsPlanId4"  hidden="hidden">
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="变更后收款计划" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<jsp:include page="../change/contract-proceeds-edit-plan-detail-change.jsp"/>
				</div>
			</div>
			</div>
			<!-- 附件信息 -->
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
			<div title="附件信息" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
					<tr>
						<td class="td1" style="width:55px;text-align: left">
							&nbsp;&nbsp;附件
						</td>
						<td colspan="4" id="htndtdf">
							<c:forEach items="${changeAttaList}" var="att">
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
	if(fcType=="HTFL-01"){
		$('#cg11').show();
		$('#cg21').show();
		$('#cg31').show();
		$('#cg41').show();
		$('#fLandlineTd1').hide();
		$('#f_fLandlinePhone1').hide();
		$('#finish_fLandlinePhone1').textbox({required:false});
		$('#fTaxpayerNum_show1').hide();
		$('#f_fTaxpayerNum1').textbox({required:false});
		$('#fAddress_show1').hide();
		$('#f_fAddress1').textbox({required:false});
		$('#fCardNo_show1').show();
		$('#fBankName_show1').show();
		$('#recePlanId1').show();
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

var num = 0;
$('#F_fcTypeName2').combobox({  
      onSelect:function(rec){
      	if(num<2){
      		num+=1;
      		var fcType = '${bean.fcType}';
      		if(fcType=="HTFL-01"){
      			$('#cg1').show();
      			$('#cg2').show();
      			$('#cg3').show();
      			$('#cg4').show();
      			$('#bb').html('');
          		$('#aa').show();
          		$('#cc').show();
          		$('#dd').hide();
          		var assisDeptId = '${bean.assisDeptId}';
          		var standard = '${bean.standard}';
          		var html = "";
          		var html1 = "";
          			html +="<td class=\"td1\"><div id=\"cg3\"><span class=\"style1\">*</span>&nbsp;付款方式</div></td>"+
      	        		"<td class=\"td2\"><div id=\"cg4\"><input class=\"easyui-combobox\" id=\"F_fPayType\" name=\"fPayType.code\" data-options=\"editable:false,panelHeight:'auto',url:'${base}/Formulation/lookupsJson?parentCode=FKFS&selected=${bean.fPayType.code}',method:'POST',valueField:'code',textField:'text',editable:false\" style=\"width: 200px\" /></div></td>"+
      	        		"<td class=\"td4\">&nbsp;</td><td class=\"td1\">协同部门</td><td class=\"td2\" ><select id=\"F_assisDeptId\" class=\"easyui-combobox\" name=\"assisDeptId\" data-options=\"validType:'length[1,20]',editable:false\" style=\"width: 206px\" ><option value=\"\">--请选择--</option><option value=\"14\"";
      	    		if(assisDeptId==14){
      	    			html +="selected=\"selected\"";
      	       		}
      	       		html+=">设备与安技处</option><option value=\"35\" ";
      	    		if(assisDeptId==35){
      	    			html +="selected=\"selected\"";
      	       		}
      	    			html +=">总务处</option><option value=\"20\"";
      	    		if(assisDeptId==20){
      	    			html +="selected=\"selected\"";
      	       		}
          			html+=">创业就业指导中心</option></select></td>";
          			html1+="<td class=\"td1\"><span class=\"style1\">*</span>是否制式合同</td><td class=\"td2\"><input type=\"radio\" name=\"standard\" value=\"0\" ";
          			if(standard==0){
          				html1+=" checked=\"checked\" ";
          			}
          			html1+="/>否<input type=\"radio\" name=\"standard\" value=\"1\"";
      				if(standard==1){
      					html1+=" checked=\"checked\"";
      				}		
      				html1+=" />是</td><td class=\"td4\">&nbsp;</td>";
          		$('#aa').html(html);
          		$('#cc').html(html1);
          		$.parser.parse("#aa");
          		$.parser.parse("#cc");
      			$('#fLandlineTd').hide();
      			$('#f_fLandlinePhone').hide();
      			$('#finish_fLandlinePhone').textbox({required:false});
      			$('#fTaxpayerNum_show').hide();
      			$('#f_fTaxpayerNum').textbox({required:false});
      			$('#fAddress_show').hide();
      			$('#f_fAddress').textbox({required:false});
      			$('#F_fcAmount').numberbox('readonly',true);
      			$('#fCardNo_show').show();
      			$('#fBankName_show').show();
      			$('#recePlanId').show();
      			$.parser.parse("#recePlanId");
      			$('#plan_contract_dg').datagrid('reload');
      			$('#proceedsPlanId').hide();
      			$('#filingPlanId').show();
      			$.parser.parse("#filingPlanId");
      			$('#filing-edit-plan-dg').datagrid('reload');
      		}
      		
      		if(fcType=="HTFL-02"){
      			$('#cg1').hide();
      			$('#cg2').show();
      			$('#cg3').show();
      			$('#cg4').show();
      			$('#bb').html('');
          		$('#aa').show();
          		$('#cc').show();
          		$('#dd').show();
          		var assisDeptId = '${bean.assisDeptId}';
          		var standard = '${bean.standard}';
          		var isinvoice = '${bean.isinvoice}';
          		var html = "";
          		var html1 = "";
          		var html2 = "";
          			html +="<td class=\"td1\"><div id=\"cg3\"><span class=\"style1\">*</span>&nbsp;付款方式</div></td>"+
      	        		"<td class=\"td2\"><div id=\"cg4\"><input class=\"easyui-combobox\" id=\"F_fPayType\" name=\"fPayType.code\" data-options=\"editable:false,panelHeight:'auto',url:'${base}/Formulation/lookupsJson?parentCode=FKFS&selected=${bean.fPayType.code}',method:'POST',valueField:'code',textField:'text',editable:false\" style=\"width: 200px\" /></div></td>"+
      	        		"<td class=\"td4\">&nbsp;</td><td class=\"td1\">协同部门</td><td class=\"td2\" ><select id=\"F_assisDeptId\" class=\"easyui-combobox\" name=\"assisDeptId\" data-options=\"validType:'length[1,20]',editable:false\" style=\"width: 206px\" ><option value=\"\">--请选择--</option><option value=\"14\"";
      	    		if(assisDeptId==14){
      	    			html +="selected=\"selected\"";
      	       		}
      	       		html+=">设备与安技处</option><option value=\"35\" ";
      	    		if(assisDeptId==35){
      	    			html +="selected=\"selected\"";
      	       		}
      	    			html +=">总务处</option><option value=\"20\"";
      	    		if(assisDeptId==20){
      	    			html +="selected=\"selected\"";
      	       		}
          			html+=">创业就业指导中心</option></select></td>";
          			html1+="<td class=\"td1\"><span class=\"style1\">*</span>是否制式合同</td><td class=\"td2\"><input type=\"radio\" name=\"standard\" value=\"0\" ";
          			if(standard==0){
          				html1+=" checked=\"checked\" ";
          			}
          			html1+="/>否<input type=\"radio\" name=\"standard\" value=\"1\"";
      				if(standard==1){
      					html1+=" checked=\"checked\"";
      				}		
      				html1+=" />是</td><td class=\"td4\">&nbsp;</td>";
      				
      				html2+="<td class=\"td1\"><span class=\"style1\">*</span>是否预开发票</td><td class=\"td2\"><input type=\"radio\" name=\"isinvoice\" value=\"0\" ";
          			if(isinvoice==0){
          				html2+=" checked=\"checked\" ";
          			}
          			html2+="/>否<input type=\"radio\" name=\"isinvoice\" value=\"1\"";
      				if(isinvoice==1){
      					html2+=" checked=\"checked\"";
      				}		
      				html2+=" />是</td><td class=\"td4\">&nbsp;</td>";
          		$('#aa').html(html);
          		$('#cc').html(html1);
          		$('#dd').html(html2);
          		$.parser.parse("#aa");
          		$.parser.parse("#cc");
          		$.parser.parse("#dd");
      			$('#fLandlineTd').show();
      			$('#F_fcAmount').numberbox('readonly', false);
      			$('#f_fLandlinePhone').show();
      			$('#finish_fLandlinePhone').textbox({required: true});
      			$('#fTaxpayerNum_show').show();
      			$('#f_fTaxpayerNum').textbox({required: true});
      			$('#fAddress_show').show();
      			$('#f_fAddress').textbox({required: true});
      			$('#fCardNo_show').show();
      			$('#fBankName_show').show();
      			$('#recePlanId').hide();
      			$('#proceedsPlanId').show();
      			$('#filingPlanId').hide();
      			$.parser.parse("#proceedsPlanId");
      			$('#proceeds-edit-plan-dg-change').datagrid('reload');
      		}
      		if(fcType=="HTFL-03"){
      			$('#cg1').hide();
      			$('#cg2').hide();
      			$('#cg3').hide();
      			$('#cg4').hide();
      			$('#aa').hide();
          		$('#cc').hide();
          		$('#aa').html('');
          		$('#cc').html('');
          		$('#bb').show();
          		$('#dd').hide();
          		var assisDeptId = '${bean.assisDeptId}';
          		var standard = '${bean.standard}';
          		var html = "";
          			html +="<td class=\"td1\"><span class=\"style1\">*</span>是否制式合同</td><td class=\"td2\"><input type=\"radio\" name=\"standard\" value=\"0\" ";
          			if(standard==0){
          				html+=" checked=\"checked\" ";
          			}
          			html+="/>否<input type=\"radio\" name=\"standard\" value=\"1\"";
      				if(standard==1){
      					html+=" checked=\"checked\"";
      				}		
      				html+=" />是</td>";
          		$('#bb').html(html);
          		$.parser.parse("#bb");
      			$('#fLandlineTd').hide();
      			$('#fCardNo_show').hide();
      			$('#fBankName_show').hide();
      			$('#f_fLandlinePhone').hide();
      			$('#finish_fLandlinePhone').textbox({required:false});
      			$('#fTaxpayerNum_show').hide();
      			$('#f_fTaxpayerNum').textbox({required:false});
      			$('#fAddress_show').hide();
      			$('#f_fAddress').textbox({required:false});
      			$('#recePlanId').hide();
      			$('#fTaxpayerNum_show').hide();
      			$('#proceedsPlanId').hide();
      			$('#filingPlanId').hide();
      		}
      		if('${bean.fcTitle}' != '${findById.fcTitle}'){
      			$('#F_fcTitle2').textbox('textbox').css('color','red');
      		}
      		 if('${bean.fcNum}' != '${findById.fcNum}'){
      			$('#F_fcNum2').numberbox('textbox').css('color','red');
      		}
      		if('${bean.fcAmount}' != '${findById.fcAmount}'){
      			$('#F_fcAmount2').numberbox('textbox').css('color','red');
      		}
      		if('${bean.fcAmountMax}' != '${findById.fcAmountMax}'){
      			$('#F_fcAmountMax2').textbox('textbox').css('color','red');
      		}
      		if('${bean.fperformance}' != '${findById.fperformance}'){
      			$('#fperformance2').numberbox('textbox').css('color','red');
      		}
      		date='${bean.fContStartTime}';
      		date1='${findById.fContStartTime}';
      		if(date != date1){
      			$('#F_fContStartTime2').datebox('textbox').css('color','red');
      		}
      		date2='${bean.fContEndTime}';
      		date3='${findById.fContEndTime}';
      		if(date2 != date3){
      			$('#F_fContEndTime2').datebox('textbox').css('color','red');
      		}
      		if('${bean.fRemark}' != '${findById.fRemark}'){
      			$('#f_fRemark1').textbox('textbox').css('color','red');
      		}
      		if('${signInfo.fSignName}' != '${findSign.fSignName}'){
      			$('#f_fSignName2').textbox('textbox').css('color','red');
      		}
      		if('${signInfo.fLandlinePhone}' != '${findSign.fLandlinePhone}'){
      			$('#finish_fLandlinePhone2').textbox('textbox').css('color','red');
      		}
      		if('${signInfo.fConcUser}' != '${findSign.fConcUser}'){
      			$('#f_fConcUser2').textbox('textbox').css('color','red');
      		}
      		if('${signInfo.fConcTel}' != '${findSign.fConcTel}'){
      			$('#f_fConcTel2').textbox('textbox').css('color','red');
      		}
      		if('${signInfo.fTaxpayerNum}' != '${findSign.fTaxpayerNum}'){
      			$('#f_fTaxpayerNum2').textbox('textbox').css('color','red');
      		}
      		if('${signInfo.fAddress}' != '${findSign.fAddress}'){
      			$('#f_fAddress2').textbox('textbox').css('color','red');
      		}
      		if('${signInfo.fCardNo}' != '${findSign.fCardNo}'){
      			$('#f_fCardNo2').textbox('textbox').css('color','red');
      		}
      		if('${signInfo.fBankName}' != '${findSign.fBankName}'){
      			$('#f_fBankName2').textbox('textbox').css('color','red');
      		} 
      		return false;
      	}
     	if(rec.code=='' || rec.code==undefined){
     		return false;
     	}
  	if(rec.code=="HTFL-01"){
  		$('#F_fcType').val("HTFL-01");
  		$('#cg1').show();
  		$('#cg2').show();
  		$('#cg3').show();
  		$('#cg4').show();
  		$('#bb').html('');
  		$('#aa').show();
  		$('#cc').show();
  		$('#dd').hide();
  		var assisDeptId = '${bean.assisDeptId}';
  		var standard = '${bean.standard}';
  		var html = "";
  		var html1 = "";
  			html +="<td class=\"td1\"><div id=\"cg3\"><span class=\"style1\">*</span>&nbsp;付款方式</div></td>"+
	        		"<td class=\"td2\"><div id=\"cg4\"><input class=\"easyui-combobox\" id=\"F_fPayType\" name=\"fPayType.code\" data-options=\"editable:false,panelHeight:'auto',url:'${base}/Formulation/lookupsJson?parentCode=FKFS&selected=${bean.fPayType.code}',method:'POST',valueField:'code',textField:'text',editable:false\" style=\"width: 200px\" /></div></td>"+
	        		"<td class=\"td4\">&nbsp;</td><td class=\"td1\">协同部门</td><td class=\"td2\" ><select id=\"F_assisDeptId\" class=\"easyui-combobox\" name=\"assisDeptId\" data-options=\"validType:'length[1,20]',editable:false\" style=\"width: 206px\" ><option value=\"\">--请选择--</option><option value=\"14\"";
	    		if(assisDeptId==14){
	    			html +="selected=\"selected\"";
	       		}
	       		html+=">设备与安技处</option><option value=\"35\" ";
	    		if(assisDeptId==35){
	    			html +="selected=\"selected\"";
	       		}
	    			html +=">总务处</option><option value=\"20\"";
	    		if(assisDeptId==20){
	    			html +="selected=\"selected\"";
	       		}
  			html+=">创业就业指导中心</option></select></td>";
  			html1+="<td class=\"td1\"><span class=\"style1\">*</span>是否制式合同</td><td class=\"td2\"><input type=\"radio\" name=\"standard\" value=\"0\" ";
  			if(standard==0){
  				html1+=" checked=\"checked\" ";
  			}
  			html1+="/>否<input type=\"radio\" name=\"standard\" value=\"1\"";
				if(standard==1){
					html1+=" checked=\"checked\"";
				}		
				html1+=" />是</td><td class=\"td4\">&nbsp;</td>";
  		$('#aa').html(html);
  		$('#cc').html(html1);
  		$.parser.parse("#aa");
  		$.parser.parse("#cc");
  		$('#fLandlineTd').hide();
  		$('#f_fLandlinePhone').hide();
  		$('#finish_fLandlinePhone').textbox({required:false});
  		$('#fTaxpayerNum_show').hide();
  		$('#f_fTaxpayerNum').textbox({required:false});
  		$('#fAddress_show').hide();
  		$('#f_fAddress').textbox({required:false});
  		$('#F_fcAmount').numberbox('readonly',true);
  		$('#fCardNo_show').show();
  		$('#fBankName_show').show();
  		$('#recePlanId').show();
  		$.parser.parse("#recePlanId");
  		$('#plan_contract_dg').datagrid('reload');
  		$('#proceedsPlanId').hide();
  		$('#filingPlanId').show();
  		$.parser.parse("#filingPlanId");
  		$('#filing-edit-plan-dg').datagrid('reload');
  		
  		acceptContract();
  		editIndexContract == undefined;
  		var cg = $('#plan_contract_dg').datagrid('getRows');
  		for(var i = cg.length-1 ; i >= 0 ; i--){
  			$('#plan_contract_dg').datagrid('deleteRow',i);
  		}
  		$("#F_fPurchNo").val('');
			$("#F_fPurchName").textbox('setValue',''); 
			$("#F_fcAmount").numberbox('setValue',0); 
			$('#F_fcAmountMax').textbox('setValue',convertCurrency(0));
		}
  	
  	if(rec.code=="HTFL-02"){
  		$('#F_fcType').val("HTFL-02");
  		$('#cg1').hide();
  		$('#cg2').show();
  		$('#cg3').show();
  		$('#cg4').show();
  		$('#bb').html('');
  		$('#aa').show();
  		$('#cc').show();
  		$('#dd').show();
  		var assisDeptId = '${bean.assisDeptId}';
  		var standard = '${bean.standard}';
  		var isinvoice = '${bean.isinvoice}';
  		var html = "";
  		var html1 = "";
  		var html2 = "";
  			html +="<td class=\"td1\"><div id=\"cg3\"><span class=\"style1\">*</span>&nbsp;付款方式</div></td>"+
	        		"<td class=\"td2\"><div id=\"cg4\"><input class=\"easyui-combobox\" id=\"F_fPayType\" name=\"fPayType.code\" data-options=\"editable:false,panelHeight:'auto',url:'${base}/Formulation/lookupsJson?parentCode=FKFS&selected=${bean.fPayType.code}',method:'POST',valueField:'code',textField:'text',editable:false\" style=\"width: 200px\" /></div></td>"+
	        		"<td class=\"td4\">&nbsp;</td><td class=\"td1\">协同部门</td><td class=\"td2\" ><select id=\"F_assisDeptId\" class=\"easyui-combobox\" name=\"assisDeptId\" data-options=\"validType:'length[1,20]',editable:false\" style=\"width: 206px\" ><option value=\"\">--请选择--</option><option value=\"14\"";
	    		if(assisDeptId==14){
	    			html +="selected=\"selected\"";
	       		}
	       		html+=">设备与安技处</option><option value=\"35\" ";
	    		if(assisDeptId==35){
	    			html +="selected=\"selected\"";
	       		}
	    			html +=">总务处</option><option value=\"20\"";
	    		if(assisDeptId==20){
	    			html +="selected=\"selected\"";
	       		}
  			html+=">创业就业指导中心</option></select></td>";
  			html1+="<td class=\"td1\"><span class=\"style1\">*</span>是否制式合同</td><td class=\"td2\"><input type=\"radio\" name=\"standard\" value=\"0\" ";
  			if(standard==0){
  				html1+=" checked=\"checked\" ";
  			}
  			html1+="/>否<input type=\"radio\" name=\"standard\" value=\"1\"";
				if(standard==1){
					html1+=" checked=\"checked\"";
				}		
				html1+=" />是</td><td class=\"td4\">&nbsp;</td>";
				
				html2+="<td class=\"td1\"><span class=\"style1\">*</span>是否预开发票</td><td class=\"td2\"><input type=\"radio\" name=\"isinvoice\" value=\"0\" ";
  			if(isinvoice==0){
  				html2+=" checked=\"checked\" ";
  			}
  			html2+="/>否<input type=\"radio\" name=\"isinvoice\" value=\"1\"";
				if(isinvoice==1){
					html2+=" checked=\"checked\"";
				}		
				html2+=" />是</td><td class=\"td4\">&nbsp;</td>";
  		$('#aa').html(html);
  		$('#cc').html(html1);
  		$('#dd').html(html2);
  		$.parser.parse("#aa");
  		$.parser.parse("#cc");
  		$.parser.parse("#dd");
  		$('#fLandlineTd').show();
  		$('#F_fcAmount').numberbox('readonly',false);
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
  		$('#proceeds-edit-plan-dg-change').datagrid('reload');

  		acceptPlan();
  		editIndex = undefined;
  		var cgS = $('#filing-edit-plan-dg').datagrid('getRows');
  		for(var s = cgS.length-1 ; s >= 0 ; s--){
  			$('#filing-edit-plan-dg').datagrid('deleteRow',s);
  		}

  		acceptContract();
  		editIndexContract == undefined;
  		var cg = $('#plan_contract_dg').datagrid('getRows');
  		for(var i = cg.length-1 ; i >= 0 ; i--){
  			$('#plan_contract_dg').datagrid('deleteRow',i);
  		}
  		$("#F_fPurchNo").val('');
			$("#F_fPurchName").textbox('setValue',''); 
			$("#F_fcAmount").numberbox('setValue',0); 
			$('#F_fcAmountMax').textbox('setValue',convertCurrency(0));
		}
  	if(rec.code=="HTFL-03"){
  		$('#F_fcType').val("HTFL-03");
  		$('#cg1').hide();
  		$('#cg2').hide();
  		$('#cg3').hide();
  		$('#cg4').hide();
  		$('#aa').hide();
  		$('#cc').hide();
  		$('#dd').hide();
  		$('#aa').html('');
  		$('#cc').html('');
  		$('#bb').show();
  		var assisDeptId = '${bean.assisDeptId}';
  		var standard = '${bean.standard}';
  		var html = "";
  			html +="<td class=\"td1\"><span class=\"style1\">*</span>是否制式合同</td><td class=\"td2\"><input type=\"radio\" name=\"standard\" value=\"0\" ";
  			if(standard==0){
  				html+=" checked=\"checked\" ";
  			}
  			html+="/>否<input type=\"radio\" name=\"standard\" value=\"1\"";
				if(standard==1){
					html+=" checked=\"checked\"";
				}		
				html+=" />是</td>";
  		$('#bb').html(html);
  		$.parser.parse("#bb");
  		$('#fLandlineTd').hide();
  		$('#fCardNo_show').hide();
			$('#fBankName_show').hide();
  		$('#f_fLandlinePhone').hide();
  		$('#finish_fLandlinePhone').textbox({required:false});
  		$('#fTaxpayerNum_show').hide();
  		$('#f_fTaxpayerNum').textbox({required:false});
  		$('#fAddress_show').hide();
  		$('#f_fAddress').textbox({required:false});
  		$('#recePlanId').hide();
  		$('#fTaxpayerNum_show').hide();
  		$('#proceedsPlanId').hide();
  		$('#filingPlanId').hide();
  		
  		acceptPlan();
  		editIndex = undefined;
  		var cgS = $('#filing-edit-plan-dg').datagrid('getRows');
  		for(var s = cgS.length-1 ; s >= 0 ; s--){
  			$('#filing-edit-plan-dg').datagrid('deleteRow',s);
  		}
  		
  		acceptContract();
  		editIndexContract == undefined;
  		var cg = $('#plan_contract_dg').datagrid('getRows');
  		for(var i = cg.length-1 ; i >= 0 ; i--){
  			$('#plan_contract_dg').datagrid('deleteRow',i);
  		}

  		$("#F_fPurchNo").val('');
			$("#F_fPurchName").textbox('setValue',''); 
			$("#F_fcAmount").numberbox('setValue',0); 
			$('#F_fcAmountMax').textbox('setValue',convertCurrency(0));
		}
      }
  }); 
</script>