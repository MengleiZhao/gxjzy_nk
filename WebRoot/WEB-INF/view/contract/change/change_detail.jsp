<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="changeInfo" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
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
						<li class="active">变更表</li>
						<li onclick="fcTypeOnClik()">合同信息</li>
						<li id="cg" class="display_all" onclick="contraOnclik1()">采购信息</li>
					</ul>
					<div class="tab-content">
						<div title="变更表" style="margin-bottom:35px;width: 737px;">
							<%@ include file="../base/contract-change-base-detail.jsp" %>
						</div>
						<div title="合同信息" style="margin-bottom:35px;width: 737px;">
							<%@ include file="../formulation/formulation_detail_base.jsp" %>
						</div>
						<div id="cgl" title="采购信息" style="margin-bottom:35px;width: 737px">
							<%@ include file="../formulation/cggl_detail_ht.jsp" %>
						</div>
					</div>
				</div>
			</div>
			
			<div class="window-left-bottom-div" style="margin-top: 55px;">
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<div class="window-right-div" id="check_system_div" style="width:254px;height: auto;padding-bottom: 20px;">
			<jsp:include page="../../check_system.jsp" />
		</div>
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
$('#F_fcType').combobox({  
    onChange:function(newValue,oldValue){  
	var sel2=$('#F_fcType').combobox('getValue');
	if(sel2=="HTFL-01"){
		$('#cg1').show();
		$('#cg2').show();
		//$('#cg2').hide();
		//$('#F_fPurchNo').next(".textbox").show();
	}else{
		$('#cg1').hide();
		$('#cg2').hide();
		//$('#cg2').show();
		//$('#F_fPurchNo').next(".textbox").hide();
	} 
    }
}); 
   //送审
function changeEditFormSS(){
	var plan = getPlan1();
	$('#F_fUptFlowStauts').val("1");
	var a = $('#F_fcTitle').val();
	$('#fContName').val(a);
	var fContUptType=$('#Upt_fContUptType').combobox('getValue');
	var filesValue = $("#htbgfiles").val(); 
	if(fContUptType==''||fContUptType==null){
		alert("请选择变更类型！");
	}else if(filesValue==null||filesValue==''){
		alert("请上传附件");
	}else {
   		$('#changeInfo').form('submit', {
			onSubmit:function(param){ 
				param.planJson=plan;
				flag=$(this).form('enableValidation').form('validate');
				if(flag){
					$.messager.progress();
				}
				return flag;
			}, 
			url:base+'/Change/Save',
			type:'post',
			/* data:{'fFileSrc':$('#upt_fFileSrc').val()}, */
			success:function(data){
				if(flag){
					$.messager.progress('close');
				}
				data=eval("("+data+")");
				if(data.success){
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					$('#changeInfo').form('clear');
					$('#change_dg').datagrid('reload');
					$('#indexdb').datagrid('reload'); 
				}else{
					$.messager.alert('系统提示', data.info, 'error');
				}
			} 
		});	
   	
	}
}
//暂存
function changeeditFrom(){
	var plan = getPlan1();
	$('#F_fUptFlowStauts').val("0");
	$('#changeInfo').form('submit', {
		onSubmit: function(param){ 
			param.planJson=plan;
				flag=$(this).form('enableValidation').form('validate');
				if(flag){
					$.messager.progress();
				}
				return flag;
			}, 
			
			url:base+'/Change/Save',
			success:function(data){
				if(flag){
					$.messager.progress('close');
				}
				data=eval("("+data+")");
				if(data.success){
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					$('#changeInfo').form('clear');
					$("#change_dg").datagrid('reload'); 
				}else{
					$.messager.alert('系统提示', data.info, 'error');
				}
			} 
		});		
}
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
/* var c =0;
function upt_upFile() {
	 console.log(document.getElementById("upt_fFileSrc1"));
	var src = getFilePath();
	alert(getFilePath()); 
	c ++;
	var src = $('#upt_fFileSrc1').val();
	 var srcs =src+','+$('#upt_fi1').val();
	$('#upt_fi1').val(srcs); 
	$('#upt__f1').append("<div id='c"+c+"'><a href='#' class='file_U' style='color: #3f7f7f;font-weight: bold;'>"+src+"</a><a style='color: red;' href='#' onclick='deleteF1(c"+c+")'>删除</a></div>");
}  */
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
   		//$.parser.parse("#recePlanId3");
   		//$('#plan_contract_dg_detail').datagrid('reload');
   		//$('#plan_contract_dg_detail_change').datagrid('reload');
   		$('#proceedsPlanId').hide();
   		$('#proceedsPlanId2').hide();
   		$('#proceedsPlanId3').hide();
   		$('#filingPlanId').show();
   		$('#filingPlanId2').show();
   		$('#filingPlanId3').show();
   		$('#filingPlanId4').show();
   		$.parser.parse("#filingPlanId");
   		$.parser.parse("#filingPlanId2");
   		$.parser.parse("#filingPlanId3");
   		$.parser.parse("#filingPlanId4");
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
   		$('#dd').hide();
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

function contraOnclik1(){
	debugger
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