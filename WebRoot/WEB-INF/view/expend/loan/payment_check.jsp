<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<script type="text/javascript">

//审批
function check(result) {
			
	$('#payment_check_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}
			return flag;
		},
		url : base + '/payment/checkSave',
		success : function(data) {
			
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#payment_check_form').form('clear');
				$('#dg_payment_list').datagrid('reload'); 
				$("#indexdb").datagrid('reload');
				closeFirstWindow();
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});
}
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

function detail(id){
	var type=0;
	var win = creatWin('报销详情', 1080, 580, 'icon-search', "/reimburse/edit?id="+ id +"&editType="+ type);
	win.window('open');
}
</script>

<form id="payment_check_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
			<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
				<div class="window-left-top-div">
					<!-- 隐藏域 --> 
					<!-- 主键ID --><input type="hidden" name="id" value="${bean.id}" />
					<!-- 附件名称 --><input type="hidden" name="fileName" value="${bean.fileName}" />
					<!-- 流程状态 --><input type="hidden" id="flowStatus" name="flowStatus" value="${bean.flowStatus}" />
					<input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
			    	<input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
					<!-- 审批附件 --><input type="hidden" name="spjlFile" id="spjlFile" value=""/>
					<!-- 基本信息 -->
					<div id="sqsqjbxx" style="overflow:auto;">					
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
					<div title="基本信息" data-options="collapsed:false,collapsible:false" style="margin-left: 20px;margin-right: 20px">			
						<table class="window-table" cellspacing="0" cellpadding="0">							
							<tr class="trbody" style="height: 40px;line-height: 40px;">
								<td class="td1"><span class="style1">*</span> 借款单编号</td>
								<td colspan="4" class="window-table-td2">
								<input style="width: 545px;height: 30px;" id="code" name="code" class="easyui-textbox"
								data-options="prompt:'单击选择借款单',iconCls:'icon-sousuo',editable:false" value="${loan.lCode}"  readonly="readonly"/>
							</td>
							</tr>	
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>还款单摘要</td>
								<td colspan="4" class="window-table-td2">
									<input style="width: 545px; height: 30px;"
									name="loanPurpose" class="easyui-textbox" readonly="readonly"
									value="${loan.loanPurpose}" data-options="required:true,validType:'length[1,50]'"/>
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span> 借款金额</td>
								<td class="window-table-td2">
									<input class="easyui-numberbox" id="lAmount" name="lAmount" readonly="readonly" style="width: 200px; height: 30px;" data-options="precision:2,icons: [{iconCls:'icon-yuan'}],<c:if test="${opeType=='detail' }">editable:false</c:if>"
									value="${loan.lAmount}" required="required">
								</td>
								<td class="td1"><span class="style1">*</span> 还款时间</td>
								<td class="window-table-td2">
									<input class="easyui-datebox" id="payTime" name="payTime" style="width: 200px; height: 30px;" editable="false"
									readonly="readonly"
									value="${bean.payTime}" required="required" />
								</td>
								
							</tr>	
							<c:if test="${!empty reimbList}">								
							<tr class="trbody">	
								<td class="td1"><span class="style1">*</span>累计冲销</td>
								<td class="window-table-td2">				
									<input class="easyui-textbox" id="" name=""  readonly="readonly" style="width: 200px; height: 30px;" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]"
									 value="${totalCxAmount}&nbsp;&nbsp;(${cxNum}笔)" required="required">
									<%-- <input class="easyui-textbox" id="" name="" style="width: 50px; height: 30px;" data-options="precision:2,editable:false"  readonly="readonly"
									value="${cxNum}笔" required="required"> --%>
								</td>
							<%-- 	<td class="td1"><span class="style1">*</span>剩余还款金额</td>
								<td class="window-table-td2">				
									<input class="easyui-numberbox" id="leastAmount" name="leastAmount"  readonly="readonly" style="width: 200px; height: 30px;" data-options="precision:2,icons: [{iconCls:'icon-yuan'}],<c:if test="${opeType=='detail' }">editable:false</c:if>"
									value="${loan.leastAmount }" required="required">
								</td> --%>
							</tr>																																
							</c:if>	
						</table>
						<!-- 累计冲销 -->
						<table class="window-table-readonly" cellspacing="0" cellpadding="0" style="width: 550px;margin-left: 107px;">
							<c:forEach items="${reimbList}" var="reimb">
							<tr style="height: 30px;line-height: 30px;">
								<td class=""><p><span>&nbsp;冲销时间：</span><span >${fn:substring(reimb.reimburseReqTime, 0, 10)}</span></p></td>
								<td class=""><p><span>报销单：</span><a href='javascript:void(0)' onclick="detail(${reimb.rId})" style="color: #666666;font-weight: bold">${reimb.gName}</a></p></td>
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
									 value="${bean.payAmount }"  required="required">
								</td>
								
								<td class="td1">还款方式</td>
								<td class="window-table-td2">
									<select id="paymentType" class="easyui-combobox" readonly="readonly" name="paymentType" style="width: 200px; height: 30px;" editable="false">
										<option value="1">银行转账</option>
										<option value="2">现金</option>
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
								<input class="easyui-numberbox" style="width: 200px; height: 30px;" value="${payee.idCard}" readonly="readonly"/>
								</td>
							</tr>
							<tr class="trbody" id="bank-info1">
								<td class="td1">银行账户</td>
								<td class="td2">
									<input class="easyui-textbox" style="width: 200px; height: 30px;" readonly="readonly" id="bankAccount" name="bankAccount" value="${payee.bankAccount}" data-options=""/>
								</td>
								<td class="td1">开户行</td>
								<td class="td2">
									<input class="easyui-textbox" style="width: 200px; height: 30px;" name="bank" readonly="readonly" value="${payee.bank}" />
								</td>
							</tr>
							
							
						</table>					
						
						<table>
							<tr class="trbody">
							<td class="td1">附件</td>
							<td colspan="4">
								<c:if test="${!empty attaList}">
								<c:forEach items="${attaList}" var="att">
									<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;margin-left: 8px">${att.originalName}</a><br>
								</c:forEach>
								</c:if>
								<c:if test="${empty attaList}">
									<span style="color:#999999">暂未上传附件</span>
								</c:if>
							</td>
						</tr>
						</table>
					</div>
					</div>
				</div>
				
				
					<!-- 审批记录 -->
					<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
						<div title="审批记录" data-options="collapsed:false,collapsible:false" style="margin-left: 20px;margin-right: 20px">
						<!-- <div class="window-title"> 审批记录</div> -->
							<jsp:include page="../../check_history.jsp" />												
						</div>
					</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="openCheckWin('审批意见','1')">
					<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="openCheckWin('审批意见','0')">
					<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeFirstWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
			
		</div>
		
		<div class="window-right-div" style="width:254px;height: auto;padding-bottom: 20px;">
			<jsp:include page="../../check_system.jsp" />
		</div>
		
	</div>
</form>
