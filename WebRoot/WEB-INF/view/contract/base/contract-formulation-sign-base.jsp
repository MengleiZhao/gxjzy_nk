<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
	<table cellpadding="0" cellspacing="0" border="0">
			<tr class="trbody">
				<td class="td1"><span class="style1">*</span>&nbsp;签约方名称</td>
				<td class="td2">
					<input type="hidden" name="fSignId" id="F_fSignId" data-options="validType:'length[1,50]'"value="${signInfo.fSignId}"/>
					<input id="f_fSignName"  class="easyui-combobox" required="required" name="fSignName" data-options="editable:true,valueField:'text',
							textField:'text',onClick:queryWinning,onShowPanel:onShowPanel" style="width: 200px" value="${signInfo.fSignName}"/>
				</td>
				 <%-- <td class="td2" id="gysa">
					<input type="hidden" name="fSignI" id="fSignIds" value="${signInfo.fSignId}"/>
					<input id="fSignN"  class="easyui-textbox" required="required" name="fSignNames" data-options="validType:'length[1,50]'" style="width: 200px" value="${signInfo.fSignName}"/>
				</td> --%>
				<td class="td4">&nbsp;</td>
				<td class="td1"><span id="fLandlineTd"><span class="style1">*</span>&nbsp;座机联系方式</span></td>
				<td class="td2">
					<span id="f_fLandlinePhone">
					<input class="easyui-textbox" id="finish_fLandlinePhone" name="fLandlinePhone" style="width: 206px" value="${signInfo.fLandlinePhone}" data-options="validateOnCreate:false,validType:'length[1,50]',onChange:seleqyf">
					</span>
				</td>
			</tr>
			<tr class="trbody">
				<td class="td1"><span class="style1">*</span>&nbsp;联系人</td>
				<td class="td2">
					<input id="f_fConcUser"  class="easyui-textbox" required="required"  name="fConcUser" data-options="validType:'length[1,25]',onChange:selelxr" style="width: 200px" value="${signInfo.fConcUser}"/>
				</td>
				<td class="td4">&nbsp;</td>
				<td class="td1"><span class="style1">*</span>&nbsp;联系电话</td>
				<td class="td2">
					<input id="f_fConcTel"  class="easyui-textbox" name="fConcTel" data-options="validType:'length[1,13]',onChange:selelxdh" style="width: 206px" value="${signInfo.fConcTel}"/>
				</td>
			</tr>		
			<tr class="trbody" id="fTaxpayerNum_show" hidden="hidden">
				<td class="td1"><span class="style1">*</span>&nbsp;纳税人识别号</td>
				<td colspan="4">
					<input id="f_fTaxpayerNum"  class="easyui-textbox" type="text" name="fTaxpayerNum"  style="width: 563px" value="${signInfo.fTaxpayerNum}" data-options="validateOnCreate:false,validType:'length[1,50]',onChange:selensr"/>
				</td>
			</tr>
			<tr class="trbody" id="fAddress_show" hidden="hidden">
				<td class="td1"><span class="style1">*</span>&nbsp;地址</td>
				<td colspan="4">
					<input id="f_fAddress"  class="easyui-textbox" type="text" name="fAddress"  style="width: 563px" value="${signInfo.fAddress}" data-options="validateOnCreate:false,onChange:selendz"/>
				</td>
			</tr>				
			<tr class="trbody" id="fCardNo_show" hidden="hidden">
				<td class="td1"><span class="style1">*</span>&nbsp;银行账户</td>
				<td colspan="4">
					<input id="f_fCardNo" class="easyui-textbox" type="text"  name="fCardNo" data-options="onChange:seleyhzh" style="width: 563px" value="${signInfo.fCardNo}"/>
				</td >
			</tr>	
			<tr class="trbody" id="fBankName_show" hidden="hidden">
				<td class="td1"><span class="style1">*</span>&nbsp;开户银行</td>
				<td colspan="4">
					<input id="f_fBankName"  class="easyui-textbox" type="text"  name="fBankName" data-options="validType:'length[1,25]',onChange:selekhyh" style="width: 563px" value="${signInfo.fBankName}"/>
				</td>
			</tr>	
	</table>
<script type="text/javascript">	
function queryCGWinning(id){
	   $('#f_fSignName').textbox('setValue','');
	   $('#f_fConcUser').textbox('setValue','');
	   $('#f_fConcTel').textbox('setValue','');
	   $('#f_fCardNo').textbox('setValue','');
	   $('#f_fBankName').textbox('setValue','');
	$.ajax({
		   type : "post",
		   url : "${base}/Formulation/registerWinning?id="+id,
		   dataType: 'json',  
		   async: false,
		   success : function(data){
			   if(data!=null){
				   $('#f_fSignName').textbox('setValue',data.fwName);
				   $('#f_fConcUser').textbox('setValue',data.fwuserName);
				   $('#f_fConcTel').textbox('setValue',data.fwTel);
				   $('#f_fCardNo').textbox('setValue',data.fpayeeAccount);
				   $('#f_fBankName').textbox('setValue',data.fpayeeBank);
			   }
		   }
	   });
}

function queryWinning(id){
	   var ids = id.id;
	   $('#f_fSignName').textbox('setValue','');
	   $('#f_fConcUser').textbox('setValue','');
	   $('#f_fConcTel').textbox('setValue','');
	   $('#f_fCardNo').textbox('setValue','');
	   $('#f_fBankName').textbox('setValue','');
	$.ajax({
		   type : "post",
		   url : "${base}/Formulation/selectGys?id="+ids,
		   dataType: 'json',  
		   async: false,
		   success : function(data){
			   if(data!=null){
				   $('#f_fSignName').textbox('setValue',data.fwName);
				   $('#f_fConcUser').textbox('setValue',data.fwuserName);
				   $('#f_fConcTel').textbox('setValue',data.fwTel);
				   $('#f_fCardNo').textbox('setValue',data.fpayeeAccount);
				   $('#f_fBankName').textbox('setValue',data.fpayeeBank);
				   $("#F_fcAmount").numberbox('setValue',data.dealAmount); 
				   $('#F_fcAmountMax').textbox('setValue',convertCurrency(data.dealAmount));
			   }
		   }
	   });
}
function onShowPanel(){
	var ids=$("#F_fPurchNo").val();
	/* if(ids==""){
		alert('请先选择采购订单！');
		return false;
	} */
    $('#f_fSignName').combobox('reload', '${base}/apply/getGys?ids='+ids);
	}

function seleqyf(newValue) {
	if('${findSign.fLandlinePhone}' != ''){
	if(newValue != '${findSign.fLandlinePhone}'){
		//$('#F_fcTitle').textbox('textbox').css('background','red');
		$('#finish_fLandlinePhone').textbox('textbox').css('color','red');
	}else{
		$('#finish_fLandlinePhone').textbox('textbox').css('color','');
	}
	}
}
function selelxr(newValue) {
	if('${findSign.fConcUser}' != ''){
	if(newValue != '${findSign.fConcUser}'){
		//$('#F_fcTitle').textbox('textbox').css('background','red');
		$('#f_fConcUser').textbox('textbox').css('color','red');
	}else{
		$('#f_fConcUser').textbox('textbox').css('color','');
	}
	}
}
function selelxdh(newValue) {
	if('${findSign.fConcTel}' != ''){
	if(newValue != '${findSign.fConcTel}'){
		//$('#F_fcTitle').textbox('textbox').css('background','red');
		$('#f_fConcTel').textbox('textbox').css('color','red');
	}else{
		$('#f_fConcTel').textbox('textbox').css('color','');
	}
	}
}
function selensr(newValue) {
	if('${findSign.fTaxpayerNum}' != ''){
	if(newValue != '${findSign.fTaxpayerNum}'){
		//$('#F_fcTitle').textbox('textbox').css('background','red');
		$('#f_fTaxpayerNum').textbox('textbox').css('color','red');
	}else{
		$('#f_fTaxpayerNum').textbox('textbox').css('color','');
	}
	}
}
function selendz(newValue) {
	if('${findSign.fAddress}' != ''){
	if(newValue != '${findSign.fAddress}'){
		//$('#F_fcTitle').textbox('textbox').css('background','red');
		$('#f_fAddress').textbox('textbox').css('color','red');
	}else{
		$('#f_fAddress').textbox('textbox').css('color','');
	}
	}
}

/* function fPurchNo_GYS() {
	var win = creatFirstWin('选择供应商', 940, 600, 'icon-search',
			'/PurchaseApply/PurchNoGys');
	win.window('open');
} */
function seleyhzh(newValue) {
	if('${findSign.fCardNo}' != ''){
	if(newValue != '${findSign.fCardNo}'){
		//$('#F_fcTitle').textbox('textbox').css('background','red');
		$('#f_fCardNo').textbox('textbox').css('color','red');
	}else{
		$('#f_fCardNo').textbox('textbox').css('color','');
	}
	}
}
function selekhyh(newValue) {
	if('${findSign.fBankName}' != ''){
	if(newValue != '${findSign.fBankName}'){
		//$('#F_fcTitle').textbox('textbox').css('background','red');
		$('#f_fBankName').textbox('textbox').css('color','red');
	}else{
		$('#f_fBankName').textbox('textbox').css('color','');
	}
	}
}
</script>	