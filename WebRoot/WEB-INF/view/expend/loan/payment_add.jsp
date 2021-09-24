<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<script type="text/javascript">

//保存
function savePayment(saveType) {
	
	//流程状态
	$('#flowStatus').val(saveType);
	var cashierType = '${cashierType}';
	if(cashierType=="0"){
		alert("还有未付讫的报销单据不可以做还款登记！");
		return false;
	}
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);
	
			var payTime = $("#payTime").datebox('getValue');
			var freqTime = $("#freqTime").val();
			var date1 = new Date(freqTime);
			var date2 = new Date(payTime);
			if(date1>date2){
				alert("还款时间不能小于申请时间,请重新选择！");
				return false;
			}
	//提交
	$('#payment_add_form').form('submit', { 
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}else{
				
			}
			return flag;
		},
		url : base + '/payment/save',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$("#dg_payment_list").datagrid("reload");
				$('#indexdb').datagrid('reload');
				$('#capitalTab').datagrid('reload');
				closeWindow()
				closeFirstWindow();
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		} 
	});	
}
//弹出选择借款单页面
function changePayMent (){
	var win = creatFirstWin('选择借款单',1040,580,'icon-search','/payment/choicePayMent');
	win.window('open');
}


$('#payTime').datebox({
	onSelect: function(date){
		var freqTime = $("#freqTime").val();
		var date1 = new Date(freqTime);
		var date2 = new Date(date);
		if(date1>date2){
			alert("还款时间不能小于申请时间,请重新选择！");
		}
	}
});

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
function detail(id,type){
var typeDetail=0;
if(type==0){
	var win = creatWin('报销详情', 1080, 580, 'icon-search', "/directlyReimburse/edit?id="+ id +"&editType="+ typeDetail);
	win.window('open');
}else{
	var win = creatWin('报销详情', 1080, 580, 'icon-search', "/reimburse/edit?id="+ id +"&editType="+ typeDetail);
	win.window('open');
}

}
</script>

<form id="payment_add_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
			<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
				<div class="window-left-top-div">
					<!-- 隐藏域 --> 
					<!-- 主键ID --><input type="hidden" name="id" value="${bean.id}" />
					<!-- 借款ID --><input type="hidden"  id="payment_lId" name="lId" value="${loan.lId}" />
					<!-- 附件名称 --><input type="hidden" name="fileName" value="${bean.fileName}" />
					<!-- 流程状态 --><input type="hidden" id="flowStatus" name="flowStatus" value="${bean.flowStatus}" />
					<!-- 借款时间 --><input type="hidden" id="freqTime" value=""/>
					
					<!-- 基本信息 -->
			<div id="sqsqjbxx" style="overflow:auto;">					
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
					<div title="还款信息" data-options="collapsed:false,collapsible:false"style="margin-left: 20px;margin-right: 20px">			
						<table class="window-table" cellspacing="0" cellpadding="0">							
							<tr class="trbody" style="height: 40px;line-height: 40px;">
								<td class="td1"><span class="style1">*</span> 还款单编号</td>
								<td colspan="4" class="window-table-td2">
								<input style="width: 545px;height: 30px;" id="code" name="code" class="easyui-textbox"
								data-options="prompt:'',iconCls:'',editable:false" value="${bean.code}"  readonly="readonly"/>
								</td>
							</tr>	
							<tr class="trbody" style="height: 40px;line-height: 40px;">
								<td class="td1"><span class="style1">*</span> 借款单编号</td>
								<td colspan="4" class="window-table-td2">
								<input style="width: 545px;height: 30px;" class="easyui-textbox"
								data-options="prompt:'单击选择借款单',iconCls:'icon-sousuo',editable:false" value="${loan.lCode}"  readonly="readonly"/>
								</td>
							</tr>	
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>借款单摘要</td>
								<td colspan="4" class="window-table-td2">
									<input style="width: 545px; height: 30px;"
									name="loanPurpose" class="easyui-textbox" readonly="readonly"
									value="${loan.loanPurpose}" data-options="required:true,validType:'length[1,50]'"/>
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span> 借款金额</td>
								<td class="window-table-td2">
									<input class="easyui-numberbox" id="loanAmount"  readonly="readonly" style="width: 200px; height: 30px;" data-options="precision:2,icons: [{iconCls:'icon-yuan'}],<c:if test="${opeType=='detail' }">editable:false</c:if>"
									value="${loan.lAmount}" required="required">
								</td>								
								<td class="td1"><span class="style1">*</span> 还款时间</td>
								<td class="window-table-td2">
									<input class="easyui-datebox" id="payTime" name="payTime" style="width: 200px; height: 30px;" editable="false"
									readonly="readonly"
									value="${bean.payTime}" required="required" />
								</td>
							</tr>
							<c:if test="${!empty reimbList||opeType!='detail'}">	
							<tr class="trbody">	
							<c:if test="${!empty reimbList}">							
								<td class="td1"><span class="style1">*</span>累计冲销</td>
								<td class="window-table-td2">				
									<input class="easyui-textbox" id="" name=""  readonly="readonly" style="width: 200px; height: 30px;" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]"
									 value="${totalCxAmount}&nbsp;&nbsp;(${cxNum}笔)" required="required">
									<%-- <input class="easyui-textbox" id="" name="" style="width: 50px; height: 30px;" data-options="precision:2,editable:false"  readonly="readonly"
									value="${cxNum}笔" required="required"> --%>
								</td>
							</c:if>	
							<c:if test="${opeType!='detail' }">
								<td class="td1"><span class="style1">*</span>剩余还款金额</td>
								<td class="window-table-td2">				
									<input class="easyui-numberbox" id="leastAmount"   readonly="readonly" style="width: 200px; height: 30px;" data-options="precision:2,icons: [{iconCls:'icon-yuan'}],<c:if test="${opeType=='detail' }">editable:false</c:if>"
									value="${loan.leastAmount }" required="required">
								</td>
							</c:if>	
							</tr>
							</c:if>	
						</table>
						<!-- 累计冲销 -->
						<table class="window-table-readonly" cellspacing="0" cellpadding="0" style="width: 550px;margin-left: 107px;">
							<c:forEach items="${reimbList}" var="reimb">
							<tr style="height: 30px;line-height: 30px;">
								<td class=""><p><span>&nbsp;冲销时间：</span><span >${fn:substring(reimb.reimburseReqTime, 0, 10)}</span></p></td>
								<td class=""><p><span>报销单：</span><a href='javascript:void(0)' onclick="detail('${reimb.rId}','${reimb.type}')" style="color: #666666;font-weight: bold">${reimb.gName}</a></p></td>
								<td class=""><p><span>冲销金额：</span><span>${reimb.cxAmount}元</span></p></td>				
							</tr>							
							</c:forEach>
						</table>
						
						<table class="window-table" cellspacing="0" cellpadding="0">
							<input hidden="hidden" value="${payee.paymentType}" id="paymentTypeHi"/>
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>本次还款金额</td>
								<td class="window-table-td2">				
									<input class="easyui-numberbox" id="payAmount" name="payAmount"  readonly="readonly" style="width: 200px; height: 30px;" data-options="precision:2,icons: [{iconCls:'icon-yuan'}],<c:if test="${opeType=='detail' }">editable:false</c:if>"
									 <c:if test="${opeType=='detail' }">value="${bean.payAmount }"</c:if> <c:if test="${opeType!='detail' }">value="${loan.leastAmount}"</c:if> required="required">
								</td>
								
								<td class="td1">还款方式</td>
								<td class="window-table-td2">
									<select id="paymentType" class="easyui-combobox" <c:if test="${opeType=='detail' }">readonly="readonly"</c:if> name="paymentType" style="width: 200px; height: 30px;" editable="false">
										<option <c:if test="${bean.paymentType==1 }">selected="selected"</c:if> value="1">银行转账</option>
										<option <c:if test="${bean.paymentType==2 }">selected="selected"</c:if> value="2">现金</option>
									</select>
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1">还款人</td>
								<td class="window-table-td2">
									<input class="easyui-textbox"  name="payPerson" style="width: 200px; height: 30px;" value="${loan.userName}" readonly="readonly"/>
								</td>
								
								<td class="td1">身份证号</td>
								<td class="window-table-td2">
								<input class="easyui-textbox" style="width: 200px; height: 30px;" value="${payee.idCard}" <c:if test="${opeType=='detail' }">readonly="readonly"</c:if>/>
								</td>
							</tr>
							<tr class="trbody" id="bank-info1">
								<td class="td1">银行账户</td>
								<td class="td2">
									<input class="easyui-textbox" style="width: 200px; height: 30px;" <c:if test="${opeType=='detail' }">readonly="readonly"</c:if>id="bankAccount" name="bankAccount" value="${payee.bankAccount}" data-options=""/>
								</td>
								<td class="td1">开户行</td>
								<td class="td2">
									<input class="easyui-textbox" style="width: 200px; height: 30px;" name="bank" <c:if test="${opeType=='detail' }">readonly="readonly"</c:if> value="${payee.bank}" />
								</td>
							</tr>
							
							
						</table>							
						
						<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: -4px;">
							<tr class="trbody">
								<!-- 附件框 -->
								<td class="td1">
									&nbsp;&nbsp;附件
									<input type="file" multiple="multiple" id="f" onchange="upladFile(this,null,'zcgl02')" hidden="hidden">
									<input type="text" id="files" name="files" hidden="hidden">
								</td>
								<td colspan="4" id="tdf">
									<c:if test="${opeType!='detail' }">
										<!-- 上传按钮 -->
										<a onclick="$('#f').click()" style="font-weight: bold;" href="#">
											<img style="vertical-align:bottom;" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
										</a>
									</c:if>
									<!-- 上传进度 -->
									<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
										<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
										 </div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
									</div>
									<!-- 附件列表 -->
									<c:forEach items="${attaList}" var="att">
										<div style="margin-top: 10px;">
										<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
										&nbsp;&nbsp;&nbsp;&nbsp;
										<c:if test="${opeType!='detail' }">
											<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
										&nbsp;&nbsp;&nbsp;&nbsp;
										</c:if>
										<c:if test="${opeType!='detail' }">
											<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
										</c:if>
										</div>
									</c:forEach>
								</td>
							</tr>
						</table>
					</div>
					</div>
				</div>
				
<%-- 				<div class="easyui-accordion">
					<div title="还款信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
						<!-- <div class="window-title">还款信息</div>	 -->				
						<table class="window-table" cellspacing="0" cellpadding="0">
							<input hidden="hidden" value="${payee.paymentType}" id="paymentTypeHi"/>
							<tr class="trbody">
								<td class="td1">还款人</td>
								<td class="td2">
									<input class="easyui-textbox"  name="payPerson" style="width: 200px; height: 30px;" value="${loan.userName}" readonly="readonly"/>
								</td>
								
								<td class="td1">付款方式</td>
								<td class="td2">
									<select id="paymentType" class="easyui-combobox" <c:if test="${opeType=='detail' }">readonly="readonly"</c:if> name="paymentType" style="width: 200px; height: 30px;" editable="false">
										<option value="1">银行转账</option>
										<option value="2">现金</option>
										<option value="3">支票</option>
									</select>
								</td>
							</tr>
							
							<tr class="trbody" id="bank-info1">
								<td class="td1">银行账户</td>
								<td class="td2">
									<input class="easyui-textbox" style="width: 200px; height: 30px;" <c:if test="${opeType=='detail' }">readonly="readonly"</c:if>id="bankAccount" name="bankAccount" value="${payee.bankAccount}" data-options="validType:'BankCardID'"/>
								</td>
								<td class="td1">开户行</td>
								<td class="td2">
									<input class="easyui-textbox" style="width: 200px; height: 30px;" name="bank" <c:if test="${opeType=='detail' }">readonly="readonly"</c:if> value="${payee.bank}" />
								</td>
							</tr>
							<tr class="trbody" id="bank-info2">
								<td class="td1">银行名称</td>
								<td class="td2" colspan="3">
									<input class="easyui-textbox" style="width: 200px; height: 30px;" id="bankName" name="bankName" value="${payee.bankName}"/>
								</td>
							</tr>
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
					</div>
				</div>
				 --%>
					<!-- 审批记录 -->
					<c:if test="${opeType=='detail' }">
					<div class="easyui-accordion" style="">
						<div title="审批记录" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
						<!-- <div class="window-title"> 审批记录</div> -->
							<jsp:include page="../../check_history.jsp" />												
						</div>
					</div>
					</c:if>
			</div>
			
			
			<div class="window-left-bottom-div">
			
				<c:if test="${opeType!='detail' }">
					<a href="javascript:void(0)" onclick="savePayment(0)">
					<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="savePayment(1)">
					<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;
				
				</c:if>
			
				<a href="javascript:void(0)" onclick="closeWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				&nbsp;&nbsp;
				<a href="${base }/systemcentergl/list?typeStr=支出管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		
		<div class="window-right-div" style="width:254px;height: 491px">
			<jsp:include page="../../check_system.jsp" />
		</div>
		
	</div>
</form>
