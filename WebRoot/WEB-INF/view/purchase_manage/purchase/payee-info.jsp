<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<form id="payInfo_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
<table class="window-table" cellspacing="0" cellpadding="0">
	<input hidden="hidden" value="${bean.paymentType}" id="paymentTypeHi"/>
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span>&nbsp;收款人姓名</td>
		<td class="td2">
			<input class="easyui-textbox" required="required" id="payeeName" style="width: 200px;  height: 30px;" value="${payee.payeeName}" />
		</td>
		
		<td class="td1"></td>
		<td class="td2">
		</td>
	</tr>
	
	<tr class="trbody">
		<td class="td1"><span class="style1">*</span>&nbsp;付款金额</td>
		<td class="td2">
			<input class="easyui-numberbox" id="payeeAmount" required="required" style="width: 200px;  height: 30px;" value="${bean.amount}" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]"/>
		</td>
		
		<td class="td1"><span class="style1">*</span>&nbsp;付款方式</td>
		<td class="td2">
			<input class="easyui-combobox" id="paymentTypeShow" required="required" value="${bean.paymentType}"  style="width: 200px; height: 30px;" data-options="validType:'selectValid',editable:false,url:base+'/lookup/lookupsJson?parentCode=FKFS&selected=${bean.paymentType}',method:'POST',valueField:'text',textField:'text'"/>
		</td>
	</tr>
	<tr class="trbody" id="bank-info1">
		<td class="td1"><span class="style1">*</span>&nbsp;银行卡号</td>
		<td colspan="4">
			<input class="easyui-textbox" required="required" style="width: 532px; height: 30px;" id="bankAccount" name="bankAccount" value="${payee.bankAccount}" />
		</td>
	</tr>
	<tr class="trbody" >
		<td class="td1"><span class="style1">*</span>&nbsp;开户行</td>
		<td colspan="4">
			<input class="easyui-textbox" required="required" id="bankName" style="width: 532px; height: 30px;" name="bank" value="${payee.bank}" />
		</td>
	</tr>
	
	
	
</table>
</form>
<%-- <img id="picture" width="62px" height="20px"  src="${ss}"> --%>

<script type="text/javascript">

$(document).ready(function() {	
//设值复选框的值
	var h = $("#paymentTypeHi").val();
	if (h != "") {
		if(h==1) {
			$('#bank-info1').css('display','');
			$('#bank-info2').css('display','');
			$('#zfb-info1').css('display','none');
			$('#zfb-info2').css('display','none');
			$('#wx-info1').css('display','none');
			$('#wx-info2').css('display','none');
			return;
		}
		if(h==2) {
			$('#bank-info1').css('display','none');
			$('#bank-info2').css('display','none');
			$('#zfb-info1').css('display','none');
			$('#zfb-info2').css('display','none');
			$('#wx-info1').css('display','none');
			$('#wx-info2').css('display','none');
			return;
		}
		if(h==3) {
			$('#bank-info1').css('display','none');
			$('#bank-info2').css('display','none');
			$('#zfb-info1').css('display','');
			$('#zfb-info2').css('display','');
			$('#wx-info1').css('display','none');
			$('#wx-info2').css('display','none');
			return;
		}
		if(h==4) {
			$('#bank-info1').css('display','none');
			$('#bank-info2').css('display','none');
			$('#zfb-info1').css('display','none');
			$('#zfb-info2').css('display','none');
			$('#wx-info1').css('display','');
			$('#wx-info2').css('display','');
			return;
		}
	}
});
$('#payeeAmount').numberbox({
	onChange : function(n, o) {
		if(n!=''||n!=null){
			var cgAmount =parseFloat(${purchase.fpAmount});
			if(n>cgAmount){
				alert('付款金额不能超过采购金额');
				$('#payeeAmount').numberbox('setValue','');
			}
		}
	}
});
//选择不同的支付方式，改变页面字段显示
$('#paymentType1').combobox({
	onChange : function(newValue, oldValue) {
		if(newValue==1) {
			$('#bank-info1').css('display','');
			$('#bank-info2').css('display','');
			$('#zfb-info1').css('display','none');
			$('#zfb-info2').css('display','none');
			$('#wx-info1').css('display','none');
			$('#wx-info2').css('display','none');
			return;
		}
		if(newValue==2) {
			$('#bank-info1').css('display','none');
			$('#bank-info2').css('display','none');
			$('#zfb-info1').css('display','none');
			$('#zfb-info2').css('display','none');
			$('#wx-info1').css('display','none');
			$('#wx-info2').css('display','none');
			return;
		}
		if(newValue==3) {
			$('#bank-info1').css('display','none');
			$('#bank-info2').css('display','none');
			$('#zfb-info1').css('display','');
			$('#zfb-info2').css('display','');
			$('#wx-info1').css('display','none');
			$('#wx-info2').css('display','none');
			return;
		}
		if(newValue==4) {
			$('#bank-info1').css('display','none');
			$('#bank-info2').css('display','none');
			$('#zfb-info1').css('display','none');
			$('#zfb-info2').css('display','none');
			$('#wx-info1').css('display','');
			$('#wx-info2').css('display','');
			return;
		}
	}
});

function clickUpFile(type) {
	if(type==1) {
		$('#zfbimage').click();
	}
	if(type==2) {
		$('#wximage').click();
	}
}

//上传图片文件转化为base64在页面显示
function upImageFile(obj) {
	if(obj==null||obj=="") {
		return;
	}
	var files = obj.files;
	var formData = new FormData();
	for(var i=0; i< files.length; i++){
		formData.append("imageFile",files[i]);//图片文件
		/* formData.append("imageType",type); //类型1支付宝、2微信 */
		$.ajax({ 
			url: base + '/base64/uploadImage' ,
			type: 'post',  
	        data: formData,
	        cache: false,
	        processData: false,
	        contentType: false,
	        async: false,
	        dataType:'json',
	        success:function(data){
	        	if(obj.id=="zfbimage") {
		        	$('#zfbimagetd').empty();
		        	$('#zfbimage').val("");
		        	$('#zfbimagetd').append('<img style="vertical-align:bottom; width: 200px;height: 153px" src="'+data+'"/><a style="color:red" href="#" onclick="deleteImage(1)">    删除</a>');
		        	$('#zfbQR').val(data);
	        	}
	        	if(obj.id=="wximage") {
	        		$('#wximagetd').empty();
		        	$('#wximage').val("");
		        	$('#wximagetd').append('<img style="vertical-align:bottom; width: 200px; height: 153px" src="'+data+'"/><a style="color:red" href="#" onclick="deleteImage(2)">    删除</a>');
		        	$('#wxQR').val(data);
	        	}
	        }
		});
	} 
}

//删除上传的图片
function deleteImage(type) {
	if(type==1){
		
		$('#zfbimagetd').empty();
		$('#zfbimagetd').append('<a onclick="clickUpFile('+type+')" style="font-weight: bold;" href="#">'+
			'<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
		$('#zfbQR').val("");
	}
	if(type==2){
		$('#wximagetd').empty();
		$('#wximagetd').append('<a onclick="clickUpFile('+type+')" style="font-weight: bold;" href="#">'+
			'<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>');
		$('#wxQR').val("");
	}
}
// Easyui中textbox中input事件失效的原因是 easy TextBox控件不是修改你的border 而是，将input进行了隐藏。然后用一个框放到了外面。实现所有浏览器效果统一。
$('#bankAccount').textbox({
	inputEvents: $.extend({},$.fn.textbox.defaults.inputEvents,{
	keyup: function(event){
		var tempValue = $(this).val();
        if(null != tempValue && '' != tempValue && undefined != tempValue){
        	
        	 var info=_getBankInfoByCardNo(tempValue);
        	$('#bankName').textbox('setValue',info.bankName); //银行名称 
        }
	}})
});
	
</script>