<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="window-div">
<form id="changeInfo" action="${base}/Formulation/savebg?openType=${openType}" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div">
				<input type="hidden" name="fcId" id="F_fcId" value="${bean.fcId}"/>
	    		<%-- <input id="F_fcType" name="fcType" value="${bean.fcType}" type="hidden"/> --%>
	    		<input type="hidden" id="totalAmount" name="totalAmount" value="${bean.totalAmount }"/>
    			<input type="hidden" name="fBudgetIndexCode" id="F_indexId" value="${bean.fBudgetIndexCode}"/>
    			<input type="hidden" name="proDetailId" id="F_proDetailId" value="${bean.proDetailId}"/>
    			<input type="hidden" name="fhttype" id="fhttype" value="${bean.fhttype}"/>
    			<input type="hidden" name="fyhtid" id="fyhtid" value="${bean.fyhtid}"/>
	    		<c:if test="${bean.fcId!=null}">
	    			<%-- <input type="hidden" name="fUserName" id="F_fUserName" value="${bean.fUserName}"/> --%>
	    			<%-- <input type="hidden" name="fUserCode" id="F_fUserCode" value="${bean.fUserCode}"/> --%>
	    			<input type="hidden" name="fProCode" id="F_fProCode" value="${bean.fProCode}"/>
	    			<%-- <input type="hidden" name="fNCode" id="F_fNCode" value="${bean.fNCode}"/> --%>
	    			<input type="hidden" name="fPayStauts" id="F_fPayStauts" value="${bean.fPayStauts}"/>
	    			<input type="hidden" name="fOperatorId" id="F_fOperatorId" value="${bean.fOperatorId}"/>
	    			<input type="hidden" name="fReqtIME" id="F_fReqtIME" value="${bean.fReqtIME}"/>
	    			<input type="hidden" name="fDeptId" id="F_fDeptId" value="${bean.fDeptId}"/>
	    			<input type="hidden" name="fContractor" id="F_fContractor" value="${signInfo.fSignName}"/>
	    		</c:if>
	    		<div class="tab-wrapper" id="contract-change-edit">
					<ul class="tab-menu">
						<li class="active">?????????</li>
						<li onclick="contraOnclik()">????????????</li>
						<li id="cg" class="display_all" onclick="contraOnclik1()">????????????</li>
					</ul>
					<div class="tab-content">
						<div title="?????????" style="margin-bottom:35px;width: 737px">
							<%@ include file="../change/change-add-edit.jsp" %>
						</div>
						<div title="????????????" style="margin-bottom:35px;width: 737px">
							<%@ include file="../formulation/formulation_detail_base.jsp" %>
						</div>
						 <div id="cgl" title="????????????" style="margin-bottom:35px;width: 737px">
							<%@ include file="../formulation/cggl_detail_ht.jsp" %>
						</div>
					</div>
				</div>
			</div>
			
			<div class="window-left-bottom-div" style="margin-top: 55px;">
				<a href="javascript:void(0)" onclick="changeeditFrom(0);">
					<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="changeeditFrom(1)">
					<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<div class="window-right-div" id="check_system_div" style="width:254px;height: auto;padding-bottom: 20px;">
			<jsp:include page="../../check_system.jsp" />
		</div>
</form>
</div>
<script type="text/javascript">
flashtab('contract-change-edit');
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
$('#F_fcAmount').numberbox({
    onChange:function(newValue,oldValue){
    	//$('#F_fcAmountMax').textbox('setValue',convertCurrency(newValue));
    	if(newValue != '${findById.fcAmount}'){
    		//$('#F_fcTitle').textbox('textbox').css('background','red');
    		$('#F_fcAmount').textbox('textbox').css('color','red');
    		$('#F_fcAmountMax').textbox('setValue',convertCurrency(newValue));
    		$('#F_fcAmountMax').textbox('textbox').css('color','red');
    	}else{
    		$('#F_fcAmount').textbox('textbox').css('color','');
    		$('#F_fcAmountMax').textbox('setValue',convertCurrency(newValue));
    		$('#F_fcAmountMax').textbox('textbox').css('color','');
    	}
    }
});
function contraOnclik(){
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

$('#filing-edit-plan-dg').datagrid({
	onBeforeLoad : function(data){
		if(loadplan>3){
			return false;
		}else {
			return true;
		}
	}
});
//??????
function changeEditFormSS(){
	//var plan = getPlan1();//??????????????????
	var uptplan ;//??????????????????
	var planProceeds ;//??????????????????
	var uptcgconfigJson ;//??????????????????
	if('${Upt.fContUptType}'=='HTFL-01'){
		uptplan = getUptPlan();
		uptcgconfigJson = getuptcgconfigJson();
		var fcamount = isNaN(parseFloat($('#F_fcAmount').numberbox('getValue')))?0:parseFloat($('#F_fcAmount').numberbox('getValue'));
		var Uptrows = $('#change-plan-dg').datagrid('getRows');
		var Uptcount= 0.00;
		var fReceAmountcount= 0.00;//??????????????????
		for(var i = 0;i < Uptrows.length;i++){
			Uptcount = parseFloat(Uptcount) + parseFloat(Uptrows[i].fRecePlanAmount);  
			if(Uptrows[i].fStauts_R==1){
				fReceAmountcount = parseFloat(fReceAmountcount) + parseFloat(Uptrows[i].fReceAmount);  
			}
		}
		if(Uptcount>(fcamount*1.1)){
			alert('??????????????????????????????10%');
			return false;
		}
		
		$('#contract-cgconfig-dg').datagrid('acceptChanges');
		var cgconfigrows = $('#contract-cgconfig-dg').datagrid('getRows');
		var cgconfigcount= 0.00;
		for(var i = 0;i < cgconfigrows.length;i++){
			cgconfigcount = parseFloat(cgconfigcount) + parseFloat(cgconfigrows[i].fsumMoney);  
		}
		if(cgconfigcount>(fcamount*1.1)){
			alert('????????????????????????????????????10%');
			return false;
		}
		if(cgconfigcount!=Uptcount){
			alert('???????????????????????????????????????????????????');
			return false;
		}
		
		var fAmount =isNaN(parseFloat($('#F_fAmount').val()))?0:parseFloat($('#F_fAmount').val());
		var totalUptAmount = isNaN(parseFloat($('#totalUptAmount').val()))?0:parseFloat($('#totalUptAmount').val());
		if(fAmount!=totalUptAmount){
			alert('?????????????????????????????????????????????????????????');
			return false;
		};
		if(fAmount<fReceAmountcount){
			alert('????????????????????????????????????????????????????????????');
			return false;
		}
	}else if('${Upt.fContUptType}'=='HTFL-02'){
		planProceeds = getPlanProceeds();
	}
	$('#F_fUptFlowStauts').val("1");
	/* var a = $('#F_fcTitle').val();
	$('#fContName').val(a); */
	var fContUptType=$('#Upt_fContUptType').val();
	var filesValue = $("#htbgfiles").val(); 
	var fileUrl = $(".htbg").html(); 
	var totalAmount = $("#totalAmount").val();
	
	if(fileUrl==undefined){
		alert("???????????????????????????");
	}else {
   		$('#changeInfo').form('submit', {
			onSubmit:function(param){ 
			//	param.planJson=plan;
				param.uptplanJson=uptplan;
				param.proceedsPlanJson=planProceeds;
				param.uptcgconfigJson=uptcgconfigJson;
				flag=$(this).form('enableValidation').form('validate');
				if(flag){
					$.messager.progress();
				}
				return flag;
			}, 
			url:base+'/Change/Save',
			type:'post',
			success:function(data){
				if(flag){
					$.messager.progress('close');
				}
				data=eval("("+data+")");
				if(data.success){
					$.messager.alert('????????????', data.info, 'info');
					$('#changeInfo').form('clear');
					$("#change_dg").datagrid('reload');
					$('#indexdb').datagrid('reload'); 
					closeWindow();
				}else{
					$.messager.alert('????????????', data.info, 'error');
				}
			} 
		});	
   	
	}
}
//??????
function changeeditFrom(stauts){
	var fFlowStauts = $("#CF_fFlowStauts").val(stauts);
	var s = "";
	$(".htwbfileUrl").each(function() {
		s = s + $(this).attr("id") + ",";
	});
	$("#htwbfiles").val(s);
	var ss = "";
	$(".htndfileUrl").each(function() {
		ss = ss + $(this).attr("id") + ",";
	});
	$("#htndfiles").val(ss);
	//??????????????????
	var filesValue = $("#htwbfiles").val();
	if (filesValue == null || filesValue == '') {
		alert("?????????????????????");
	} else {
		//?????????????????????
		var type = $("#F_fcType").val();//????????????	
		var signName = $("#f_fSignName").textbox('getValue');//???????????????
		var concUser = $("#f_fConcUser").textbox('getValue');//?????????
		var concTel = $("#f_fConcTel").textbox('getValue');//????????????
		var bankName = $("#f_fBankName").textbox('getValue');//????????????
		var cardNo = $("#f_fCardNo").textbox('getValue');//???????????? 
		var landlinePhone = $("#finish_fLandlinePhone").textbox('getValue');//??????????????????
		var taxpayerNum = $("#f_fTaxpayerNum").textbox('getValue');//??????????????????
		var address = $("#f_fAddress").textbox('getValue');//??????
		//????????????
		if (type == 'HTFL-01'){
			var fcAmount = isNaN(parseFloat($('#F_fcAmount').textbox('getValue')))?0:parseFloat($('#F_fcAmount').textbox('getValue')); //????????????
			var totalAmount = isNaN(parseFloat($('#totalAmount').val()))?0:parseFloat($('#totalAmount').val());//??????????????????
			var iskjht = $('input[name="iskjht"]:checked').val();
			/* if(fcAmount!=totalAmount){
				alert('?????????????????????????????????????????????????????????');
				return false;
			} */
			/* var fPayType = $('#F_fPayType').combobox('getValues');
			if(stauts == '1'){
			if(fPayType==''){
				alert('????????????????????????');
				return false;
			}
			} */
			var plan = getPlan();
			//var contractJson = contractJsons();
			 if (('' == plan || null == plan || '[]' == plan) && type == 'HTFL-01') {
				if(iskjht != '1'){
					alert("???????????????????????????");
					return;
					}
			} 
			if (bankName == '' || signName == '' || concUser == '' || concTel == '' || cardNo == '') {
				alert("????????????????????????");
				return;
			}else {
					//var assisDeptId = $('#F_assisDeptId').combobox('getValues');
				/* if(fcAmount>=50000){
					if(assisDeptId==''){
						alert('????????????????????????50000???????????????????????????');
						return false;
					}
				}else{
					if(assisDeptId!=''){
						alert('??????????????????50000??????????????????????????????');
						return false;
					}
				} */
				$('#changeInfo').form('submit',{
							onSubmit : function(param) {
								param.planJson = plan;
								flag = $(this).form('enableValidation').form('validate');
								if (flag) {
									$.messager.progress();
								}
								return flag;
							},
							data : {
								'fFlowStauts' : fFlowStauts
							},
							success : function(data) {
								$.messager.progress('close');
								data = eval("(" + data + ")");
								if (data.success) {
									$.messager.alert('????????????', data.info,
											'info');
									$('#changeInfo').form('clear');
									$("#change_dg").datagrid('reload');
									$('#filing_dg').datagrid('reload');
									closeWindow();
								} else {
									$.messager.alert('????????????', data.info,
											'error');
								}
							}
						});
			}
		} else { //????????????
			if(type == 'HTFL-02'){
				if (bankName == '' || signName == '' || concUser == '' || concTel == '' || cardNo == '' || landlinePhone == '' || taxpayerNum == '' || address == '') {
					alert("????????????????????????");
					return;
				}
				acceptPlanProceeds();
				var pay = getPlanProceeds();
				var iskjht = $('input[name="iskjht"]:checked').val();
				if(stauts == '1'){
				if (('' == pay || null == pay || '[]' == pay) && type == 'HTFL-02') {
					if(iskjht != '1'){
						alert("?????????????????????");
						return;
						}
				}
				}
				acceptPlanProceeds();
				var F_fcAmount = isNaN(parseFloat($('#F_fcAmount').textbox('getValue')))?0:parseFloat($('#F_fcAmount').textbox('getValue')); //????????????
				var totalAmounts = isNaN(parseFloat($('#totalAmount').val()))?0:parseFloat($('#totalAmount').val());//??????????????????
				if(F_fcAmount!=totalAmounts){
					if(iskjht != '1'){
						alert('?????????????????????????????????????????????????????????');
						return false;
						}
				}
				/* var fPayTypes = $('#F_fPayType').combobox('getValues');
				if(fPayTypes==''){
					alert('????????????????????????');
					return false;
				} */
				var json = getPlanProceeds();
				//var assisDeptIds = $('#F_assisDeptId').combobox('getValues');
				/* if(F_fcAmount>=50000){
					if(assisDeptIds==''){
						alert('????????????????????????50000???????????????????????????');
						return false;
					}
				}else{
					if(assisDeptIds!=''){
						alert('??????????????????50000??????????????????????????????');
						return false;
					}
				} */
				$('#changeInfo').form('submit',{
							onSubmit : function(param){
								param.proceedsJson = json;
								flag = $(this).form('enableValidation')
										.form('validate');
								if (flag) {
									$.messager.progress();
								}
								return flag;
							},
							data : {
								'fFlowStauts' : fFlowStauts
							},
							success : function(data) {
								$.messager.progress('close');
								data = eval("(" + data + ")");
								if (data.success) {
									$.messager.alert('????????????', data.info,
											'info');
									$('#changeInfo').form('clear');
									$("#change_dg").datagrid('reload');
									$('#filing_dg').datagrid('reload');
									closeWindow();
								} else {
									$.messager.alert('????????????', data.info,
											'error');
								}
							}
						});
			}else{
				if ( signName == '' || concUser == '' || concTel == '' ) {
					alert("????????????????????????");
					return;
				}
				//var assisDept = $('#F_assisDeptId').combobox('getValues');
				/* if(assisDept==''){
					alert('??????????????????????????????????????????');
					return false;
				} */
				$('#changeInfo').form('submit',{
						onSubmit : function(param){
							flag = $(this).form('enableValidation')
									.form('validate');
							if (flag) {
								$.messager.progress();
							}
							return flag;
						},
						data : {
							'fFlowStauts' : fFlowStauts
						},
						success : function(data) {
							$.messager.progress('close');
							data = eval("(" + data + ")");
							if (data.success) {
								$.messager.alert('????????????', data.info,
										'info');
								$('#changeInfo').form('clear');
								$("#change_dg").datagrid('reload');
								$('#filing_dg').datagrid('reload');
								closeWindow();
							} else {
								$.messager.alert('????????????', data.info,
										'error');
							}
						}
					});
			}
		}
	}

}
function fPurchNo_DC(){
	//var node=$('#c_c_dg').#check-history-dgd('getSelected');
	var win=creatFirstWin('??????-???????????????',750,550,'icon-add','/PurchaseApply/PurchNoList');
	win.window('open');
}
function quota_DC(){
	//var node=$('#c_c_dg').datagrid('getSelected');
	var win=creatFirstWin('??????-??????????????????',750,550,'icon-add','/BudgetIndexMgr/contract_list');
	win.window('open');
}
/* var c =0;
function upt_upFile() {
	 console.log(document.getElementById("upt_fFileSrc1"));
	var src = getFilePath();
	alert(getFilePath()); 
	c ++;
	var src = $('#upt_fFileSrc1').val();
	 var srcs =src+','+$('#upt_fi1').val();
	$('#upt_fi1').val(srcs); 
	$('#upt__f1').append("<div id='c"+c+"'><a href='#' class='file_U' style='color: #3f7f7f;font-weight: bold;'>"+src+"</a><a style='color: red;' href='#' onclick='deleteF1(c"+c+")'>??????</a></div>");
}  */
function deleteF1(val){
	var child=document.getElementById(val.id);
	child.parentNode.removeChild(child);
}
//???????????????
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
	// ??????????????????????????????????????????  
	return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
}

$(document).ready(function() {
	var fcType = '${bean.fcType}';
	if(fcType=="HTFL-01"){
		$(".display_all").css("display", "");
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
   		$('#recePlanId2').show();
   		$('#recePlanId').show();
   		$.parser.parse("#recePlanId");
   		$.parser.parse("#recePlanId2");
   		//$('#plan_contract_dg_detail').datagrid('reload');
   		//$('#plan_contract_dg_detail_change').datagrid('reload');
   		$('#proceedsPlanId').hide();
   		$('#proceedsPlanId2').hide();
   		$('#filingPlanId').show();
   		$('#filingPlanId2').show();
   		$.parser.parse("#filingPlanId");
   		$.parser.parse("#filingPlanId2");
   		//$('#filing-edit-plan-dg-detail').datagrid('reload');
   		$('#filing-edit-plan-dg-detail-change').datagrid('reload');
   		
	}
   	
   	if(fcType=="HTFL-02"){
   		$(".display_all").css("display", "none");
   		$('#cg1').hide();
   		$('#cg2').show();
   		$('#cg3').show();
   		$('#cg4').show();
   		$('#dd').show();
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
   		$('#recePlanId2').hide();
   		$('#proceedsPlanId').show();
   		$('#filingPlanId').hide();
   		$('#filingPlanId2').hide();
   		$('#proceedsPlanId2').show();
   		$.parser.parse("#proceedsPlanId");
   		$.parser.parse("#proceedsPlanId2");
   		$('#proceeds-edit-plan-dg-detail').datagrid('reload');
	}
   	if(fcType=="HTFL-03"){
   		$(".display_all").css("display", "none");
   		$('#cg1').hide();
   		$('#cg2').hide();
   		$('#cg3').hide();
   		$('#cg4').hide();
   		$('#dd').hide();
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
   		$('#recePlanId2').hide();
   		$('#fTaxpayerNum_show').hide();
   		$('#proceedsPlanId').hide();
   		$('#proceedsPlanId2').hide();
   		$('#filingPlanId').hide();
   		$('#filingPlanId2').hide();
   		$('#cg').css('display','none');
	}
});
function contraOnclik1(){
	var fPurchNo = $("#F_fPurchNo").val();
	if(fPurchNo == '' || fPurchNo == null){
		alert('???????????????????????????');
		$('#cgl').hide();
		$('#cgl').css('display','none');
		return false;
	}else{
		$('#cgl').load('${base}/Formulation/cgdetail?id=' + fPurchNo);
	}
}
</script>
</body>