<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<table class="window-table" cellspacing="0" cellpadding="0">
	<input hidden="hidden" value="${payee.paymentType}" id="paymentTypeHi"/>
	<tr class="trbody">
		<td class="td1">收款人</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 200px; height: 30px;" value="${bean.userName}" readonly="readonly"/>
		</td>
		
		<td class="td1">身份证号</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 200px; height: 30px;" id="idCard" name="idCard" value="${payee.idCard}" readonly="readonly" />
		</td>
		<!-- <td class="td1">付款方式</td>
		<td class="td2">
			<select id="paymentType" class="easyui-combobox" name="paymentType" style="width: 200px; height: 30px;" editable="false">
				<option value="1">银行转账</option>
				<option value="2">现金</option>
				<option value="3">支票</option>
			</select>
		</td> -->
	</tr>
	
	<tr class="trbody" id="bank-info1">
		<td class="td1">银行账户</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 200px; height: 30px;" id="bankAccount" name="bankAccount" value="${payee.bankAccount}" readonly="readonly"/>
		</td>
		<td class="td1">开户行</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 200px; height: 30px;" name="bank" value="${payee.bank}" readonly="readonly"/>
		</td>
	</tr>
	<tr class="trbody" id="">
		<td class="td1">转账金额</td>
		<td class="td2">
			<input class="easyui-numberbox" style="width: 200px; height: 30px;" id="skAccount" name="payeeAmount" value="${payee.payeeAmount}" readonly="readonly" data-options="precision:2,icons: [{iconCls:'icon-yuan'}],groupSeparator:','"/>
		</td>
	</tr>
	<%-- <tr class="trbody" id="bank-info2">
		<td class="td1">银行名称</td>
		<td class="td2" colspan="3">
			<input class="easyui-textbox" style="width: 200px; height: 30px;" id="bankName" name="bankName" value="${payee.bankName}"/>
		</td>
	</tr> --%>
	<tr class="trbody" style="display: none;" id="zfb-info1">
		<td class="td1">支付宝账户</td>
		<td class="td2">
			<input class="easyui-textbox" style="width: 200px; height: 30px;" name="zfbAccount" value="${payee.zfbAccount}"/>
			<input type="file" id="zfbimage" onchange="upImageFile(this)" hidden="hidden">
			<input hidden="hidden" id="zfbQR" name="zfbQR" value="${payee.zfbQR}"/>
		</td>
	</tr>
	
	<tr class="trbody" style="display: none;" id="zfb-info2">
		<td class="td1">支付宝二维码</td>
		<td class="td2" colspan="4" id="zfbimagetd">
			<c:if test="${payee.zfbQR==null||empty payee.zfbQR}">
			<a onclick="clickUpFile('1')" style="font-weight: bold;" href="#">
				<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
			</a>
			</c:if>
			<c:if test="${payee.zfbQR!=null&&!empty payee.zfbQR}">
			<img style="vertical-align:bottom;width: 200px; height: 153px;" src="${payee.zfbQR}"/><a style="color:red" href="#" onclick="deleteImage('1')">    删除</a>
			</c:if>
		</td>
	</tr>
	
	<tr class="trbody" style="display: none;" id="wx-info1">
		<td class="td1">微信账户</td>
		<td class="td2" colspan="4">
			<input class="easyui-textbox" style="width: 200px; height: 30px;" name="wxAccount" value="${payee.wxAccount}"/>
			<input type="file" id="wximage" onchange="upImageFile(this)" hidden="hidden">
			<input hidden="hidden" id="wxQR" name="wxQR" value="${payee.wxQR}"/>
		</td>
	</tr>
	
	<tr class="trbody" style="display: none;" id="wx-info2">
		<td class="td1">微信二维码</td>
		<td class="td2" colspan="4" id="wximagetd">
			<c:if test="${payee.wxQR==null||empty payee.wxQR}">
			<a onclick="clickUpFile('2')" style="font-weight: bold;" href="#">
				<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
			</a>
			</c:if>
			<c:if test="${payee.wxQR!=null&&!empty payee.wxQR}">
			<img style="vertical-align:bottom;width: 200px; height: 153px;" src="${payee.wxQR}"/><a style="color:red" href="#" onclick="deleteImage('2')">    删除</a>
			</c:if>
		</td>
	</tr>
</table>

<%-- <img id="picture" width="62px" height="20px"  src="${ss}"> --%>

<script type="text/javascript">

$(document).ready(function() {	
//设值复选框的值
	var h = $("#paymentTypeHi").val();
	if (h != "") {
		$('#paymentType').textbox().textbox('setValue', h);
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
//选择不同的支付方式，改变页面字段显示
$('#paymentType').combobox({
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
			$('#zfb-info1').css('display','none');
			$('#zfb-info2').css('display','none');
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

/* function clickUpFile(type) {
	if(type==1) {
		$('#zfbimage').click();
	}
	if(type==2) {
		$('#wximage').click();
	}
} */

//上传图片文件转化为base64在页面显示
/* function upImageFile(obj) {
	if(obj==null||obj=="") {
		return;
	}
	var files = obj.files;
	var formData = new FormData();
	for(var i=0; i< files.length; i++){
		formData.append("imageFile",files[i]);//图片文件
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
		        	$('#zfbimagetd').append('<img style="vertical-align:bottom; width: 100px;height: 73px" src="'+data+'"/><a style="color:red" href="#" onclick="deleteImage(1)">    删除</a>');
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
} */

//删除上传的图片
/* function deleteImage(type) {
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
} */
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