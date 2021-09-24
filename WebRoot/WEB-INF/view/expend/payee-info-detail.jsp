<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<table class="window-table" cellspacing="0" cellpadding="0" style="margin-left: -10px;">
	<tr class="trbody">
		<td class="td1">收款人</td>

		<td class="td2">
			<input class="easyui-combobox" id="paymentType" readonly="readonly" name="paymentType" data-options="url:'${base}/Formulation/lookupsJson?parentCode=FKFS&selected=${payee.paymentType}',method:'POST',valueField:'code',textField:'text',editable:false" style="width: 200px;height: 30px" />
		</td>
		
		<td class="td3">
			<input hidden="hidden" value="${payee.paymentType}" id="paymentTypeHi"/>
		</td>

		<td class="td1">付款方式</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 200px;height:25px;" 
			<c:if test="${payee.paymentType==1}">value="银行转账"</c:if>
			<c:if test="${payee.paymentType==2}">value="现金"</c:if>
			<c:if test="${payee.paymentType==3}">value="支票"</c:if>
			readonly="readonly">
		</td>
	</tr>
	
	<tr class="trbody">
	<td class="td1">银行账户</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 200px;height:25px;" name="bankAccount" value="${payee.bankAccount}" readonly="readonly"/>
		</td>
		<td class="td3"></td>
		<td class="td1">开户行</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 200px;height:25px;" name="bank" value="${payee.bank}" readonly="readonly"/>
		</td>
	</tr>
	<tr class="trbody" id="bank-info2">
		<td class="td1">身份证号</td>
		<td class="td2" colspan="4">
			<input class="easyui-textbox" style="width: 200px; height: 30px;" readonly="readonly" id="payeeIdCard" name="payeeIdCard" value="${payee.payeeIdCard}"/>
		</td>
	</tr>
	<tr class="trbody" style="display: none;" id="zfb-info1">
		<td class="td1">支付宝账户</td>

		<td colspan="4">
			<input class="easyui-textbox" style="width: 200px;height:25px;" name="zfbAccount" value="${payee.zfbAccount}" readonly="readonly"/>
		</td>
	</tr>
	
	<tr class="trbody" style="display: none;" id="zfb-info2">
		<td class="td1">支付宝二维码</td>
		<td colspan="4" id="zfbimagetd">
			<img style="vertical-align:bottom;width: 200px; height: 153px;" src="${payee.zfbQR}"/>
		</td>
	</tr>
	
	<tr class="trbody" style="display: none;" id="wx-info1">
		<td class="td1">微信账户</td>

		<td colspan="4">
			<input class="easyui-textbox" style="width: 200px;height:25px;" name="wxAccount" value="${payee.wxAccount}" readonly="readonly"/>
		</td>
	</tr>
	
	<tr class="trbody" style="display: none;" id="wx-info2">
		<td class="td1">微信二维码</td>
		<td colspan="4" id="wximagetd">
			<img style="vertical-align:bottom;width: 200px; height: 153px;" src="${payee.wxQR}"/>
		</td>
	</tr>
</table>

<script type="text/javascript">

$(document).ready(function() {	
	//设值复选框的值
	/* var h = $("#paymentTypeHi").val();
	if (h != "") {
		if(h=='FKFS-03'||h=='FKFS-05'||h=='FKFS-05') {
			$('#bank-info1').css('display','');
			$('#bank-info2').css('display','');
			$('#zfb-info1').css('display','none');
			$('#zfb-info2').css('display','none');
			$('#wx-info1').css('display','none');
			$('#wx-info2').css('display','none');
			return;
		}
		if(h=='FKFS-01'||h=='FKFS-06') {
			$('#bank-info1').css('display','none');
			$('#bank-info2').css('display','none');
			$('#zfb-info1').css('display','none');
			$('#zfb-info2').css('display','none');
			$('#wx-info1').css('display','none');
			$('#wx-info2').css('display','none');
			return;
		}
	} */
});
</script>