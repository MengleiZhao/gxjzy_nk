<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<form id="cgsq_reimb_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div">
			
				<!-- 隐藏域 --> 
				<!-- 主键ID --><input type="hidden" name="rId" value="${bean.rId}" id="rId"/>
				<!-- 采购单ID --><input type="hidden" name="purchaseId"  value="${bean.purchaseId}"/>
				<!-- 报销单号 --><input type="hidden" name="rCode" value="${bean.rCode}"/>
				<!-- 摘要--><input type="hidden" name="gName" value="${bean.gName}"/>
				<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="reimburseFlowStauts" />
				<!-- 报销状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="reimburseStauts" />
				<%-- <!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}" />
				<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" /> --%>
				<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
				<!-- 报销类型 --><input type="hidden" id="reimburseTypeHi" value="${bean.type}" name="type"/>
				<!-- 报销金额 --><input type="hidden" id="reimburseAmount" name="amount"  value="${bean.amount}"/>
				<!-- 指标ID --><input type="hidden" name="indexId" value="${bean.indexId}" id=""/>
				<!-- 项目支出明细id --><input type="hidden" name="proDetailId" value="${bean.proDetailId}" id=""/>
				<!-- 预算指标名称 <input type="hidden" id="indexName" name="indexName" value="${bean.indexName}" /> -->
				<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="indexType"/>
				<!-- 可用金额  --><input type="hidden" id="syAmount" value="${bean.syAmount}"/>
				<!-- 批复金额  --><input type="hidden" id="pfAmount" value="${bean.pfAmount}"/>
				<!-- 批复时间  --><input type="hidden" id="pfDate"  value="${bean.pfDate}"/>
				<!-- 收款人信息id --><input type="hidden" name="payId" value="${payee.pId}" />
				<!-- 付款方式 --><input type="hidden" name="paymentType" value="${bean.paymentType}" id="paymentType"/>
				<input type="hidden" id="hbank" name="bank" value="${payee.bank}"  /><!-- 开户行 -->
				<input type="hidden" id="hbankAccount" name="bankAccount" value="${payee.bankAccount}" /><!-- 银行账户 -->
				<input type="hidden" id="hpayeeName" name="payeeName" value="${payee.payeeName}" /><!-- 收款人 -->
				<input type="hidden" id="json1" name="form1" />
				</form>
				<!-- 收款人信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					  	<div title="收款人信息" data-options="collapsible:false"
						style="overflow:auto;">
						<jsp:include page="payee-info.jsp" />
						
					</div>
				</div>
				
				<!-- 附件信息 -->
						<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
						<div title="附件信息" data-options="collapsible:false" style="overflow:auto;">		
							<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width: 707px">
								<tr>
									<td class="td1" style="width:60px;">
										附件
										<input type="file" multiple="multiple" id="f" onchange="upladFile(this,'file','cggl02')" hidden="hidden" >
										<input type="text" id="files" name="files" hidden="hidden">
									</td>
									<td colspan="3" id="tdf">
										&nbsp;&nbsp;
										<a onclick="$('#f').click()" style="font-weight: bold;  " href="#">
											<img style="vertical-align:bottom;margin-bottom: 5px;" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
										</a>
										<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
											<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
											 </div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
										</div>
										<c:forEach items="${attaList}" var="att">
										<c:if test="${att.serviceType=='file'}">
											<div style="margin-top: 5px;">
											<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<img style="margin-top: 5px;" src="${base}/resource-modality/${themenurl}/sccg.png">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
											</div>
										</c:if>	
										</c:forEach>
									</td>
								</tr>
							</table>
						</div>
						</div>
			<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					  	<div title="发票信息" data-options="collapsible:false"
						style="overflow:auto;">
							<c:if test="${openType=='add'}">		
							<div style="overflow:hidden;margin-top: 0px">
								<!-- 新增 -->
								<jsp:include page="cgReimb_fp_mingxi.jsp" />
							</div>
							</c:if>
							<c:if test="${openType=='edit'}">		
							<div style="overflow:hidden;margin-top: 0px">
								<!--修改 -->
								<jsp:include page="cgReimb_fp_mingxi_edit.jsp" />
							</div>
							</c:if>
						</div>
			</div>
			<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="采购信息" data-options=" collapsible:false" style="overflow:auto;">
						<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
							<tr class="trbody">
								<td class="td1" style="width: 70px"><span class="style1">*</span>&nbsp;采购批次编号</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fpCode" readonly="readonly" name="fpCode"  style="width:220px;height: 30px" value="${purchase.fpCode}"/>
								</td>
								<td class="td1"><span class="style1">*</span>&nbsp;申请时间</td>
								<td class="td2">
									<input class="easyui-datebox" class="dfinput" id="F_fReqTime" name="fReqTime" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 220px;height: 30px" value="${purchase.fReqTime}"/>
								</td>			
								
							</tr>
	
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;申请部门</td>
								<td class="td2">
									<input class="easyui-textbox" type="text" id="F_fDeptName" readonly="readonly" required="required" name="fDeptName" data-options="validType:'length[1,20]'" style="width: 220px;height: 30px" value="${purchase.fDeptName}"/>
								</td>
								
								<td class="td1"><span class="style1">*</span>&nbsp;申请人</td>
								<td class="td2">
									<input id="F_fUserName" class="easyui-textbox" type="text" readonly="readonly" required="required" name="fUserName" data-options="validType:'length[1,20]'" style="width: 220px;height: 30px" value="${purchase.fUserName}"/>
								</td>
								
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;采购名称</td>
								<td colspan="4">
									<input class="easyui-textbox" type="text" id="F_fpName"  name="fpName" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 563px;height: 30px" value="${purchase.fpName}"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;采购品目</td>
								<td class="td2" colspan="4">
										<select class="easyui-combobox" id="fItems" name="fItems" required="required" readonly="readonly" style="width: 220px;height: 30px" data-options="editable:false,panelHeight:'auto'" validType="selectValueRequired['#test']">
											<option value="">--请选择--</option>
											<option value="A10" <c:if test="${purchase.fItems=='A10'}">selected="selected"</c:if>>货物</option>
											<option value="A20" <c:if test="${purchase.fItems=='A20'}">selected="selected"</c:if>>工程</option>
											<option value="A30" <c:if test="${purchase.fItems=='A30'}">selected="selected"</c:if>>服务</option>
											<option value="A40" <c:if test="${purchase.fItems=='A40'}">selected="selected"</c:if>>办公用品及耗材</option>
										</select>	
								</td>
							</tr>
	
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;采购细目</td>
								<td colspan="4">
									<input class="easyui-textbox" type="text" id="fItemsDetail"  name="fItemsDetail" required="required" readonly="readonly" data-options="prompt: '选择细目' ,icons: [{iconCls:'icon-sousuo'}]"  style="width: 563px;height: 30px" value="${purchase.fItemsDetail}"/>
								</td>
								<input type="hidden" name="fItemsDetailIds" id="fItemsDetailIds" value="${purchase.fItemsDetailIds}"/>
							</tr>
	
							
							<tr>
								<td class="td1" valign="top"><span class="style1">*</span>&nbsp;购置申请说明</td>
								<td colspan="4">
									<textarea name="fRemark"  id="F_fRemark"  class="textbox-text"   readonly="readonly" style="width:558px;height:70px;resize:none;border-radius: 5px;border: 1px solid #D9E3E7; margin-top:5px; margin-bottom:0px;">${purchase.fRemark}</textarea>
								</td>
							</tr>
							<tr class="trbody" >
								
								<td class="td1"><span class="style1">*</span>&nbsp;采购类型</td>
								<td class="td2">
									<input class="easyui-combobox" type="text" id="F_fpPype"  name="fpPype"  readonly="readonly" style="width: 220px;height: 30px" data-options="editable:false,panelHeight:'auto',
												url:'${base}/apply/lookupsJson?parentCode=CGLX&selected=${purchase.fpPype}',
												method:'POST',
												valueField:'code',
												textField:'text',
												editable:false,
												validType:'selectValid',
												
											"/>
								</td>
								
								<td class="td1"><span class="style1">*</span>&nbsp;采购方式</td>
								<td class="td2">
									<input class="easyui-combobox" type="text" id="F_fpMethod"  name="fpMethod"  readonly="readonly"  style="width: 220px;height: 30px"data-options="editable:false,panelHeight:'auto',
												url:'${base}/apply/lookupsJson?parentCode=${purchase.fpPype}&selected=${purchase.fpMethod}',
												method:'POST',
												valueField:'code',
												textField:'text',
												editable:false,
												validType:'selectValid'
											"/>
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1" style="width:70px;"><span class="style1">*</span>&nbsp;是否进口</td>
								<td class="td2">
         							<input type="radio" name="fIsImp"  readonly="readonly" disabled="disabled" <c:if test="${purchase.fIsImp=='1'}">checked="checked"</c:if> value="1">是</input>
         							<input type="radio" name="fIsImp"  readonly="readonly" disabled="disabled" <c:if test="${purchase.fIsImp!='1'}">checked="checked"</c:if> value="0">否</input>
								</td>
								<td class="td1" ><span class="style1">*</span>&nbsp;是否订立合同</td>
								<td class="td2">
									<input type="radio" name="fIsContract"  readonly="readonly" disabled="disabled" <c:if test="${purchase.fIsContract=='1'}">checked="checked"</c:if> value="1">是</input>
         							<input type="radio" name="fIsContract"  readonly="readonly" disabled="disabled" <c:if test="${purchase.fIsContract!='1'}">checked="checked"</c:if> value="0">否</input>
								</td>
							</tr>
							<tr class="trbody">
					<td class="td1">&nbsp;校内论证</td>
					<td colspan="4">
						<c:if test="${!empty attac}">
							<c:forEach items="${attac}" var="att">
								<c:if test="${att.serviceType=='xnlz' }">
									<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
								</c:if>
							</c:forEach>
						</c:if>
						
						<c:if test="${empty attac}">
							<span style="color:#999999">暂未上传附件</span>
						</c:if>
					</td>
				</tr>
				
				<tr class="trbody">
					<td class="td1">&nbsp;校外论证</td>
					<td colspan="4">
						<c:if test="${!empty attac}">
							<c:forEach items="${attac}" var="att">
								<c:if test="${att.serviceType=='xwlz' }">
									<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
								</c:if>
							</c:forEach>
						</c:if>
						
						<c:if test="${empty attac}">
							<span style="color:#999999">暂未上传附件</span>
						</c:if>
					</td>
				</tr>
				
				<tr class="trbody">
					<td class="td1">&nbsp;进口产品专家意见</td>
					<td colspan="4">
						<c:if test="${!empty attac}">
							<c:forEach items="${attac}" var="att">
								<c:if test="${att.serviceType=='jkspzjyj' }">
									<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
								</c:if>
							</c:forEach>
						</c:if>
						
						<c:if test="${empty attac}">
							<span style="color:#999999">暂未上传附件</span>
						</c:if>
					</td>
				</tr>
						</table>
						</div>				
					</div>	
				<!-- 预算信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width:717px;">
					<div title="预算信息" data-options="collapsible:false" style="overflow:auto;height: 150px;margin-left: 0px;">				
						<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;width:707px;">
							<tr class="trbody">
									<td style="width: 60px;float: left;"><span class="style1">*</span> 支出项目</td>
									<td colspan="3" style="padding-right: 5px;">
										<input class="easyui-textbox" style="width: 642px;height: 30px;"
										name="indexName" value="${bean.indexName}" id="F_fBudgetIndexName"
									 readonly="readonly" required="required"/>
									</td>
								</tr>
							</table>	
							<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="margin-left: 0px;width:707px;height: 50px;">
									<tr>
										<td class="window-table-td1"><p>批复金额：</p></td>
										<td class="window-table-td2"><p id="p_pfAmount">${bean.pfAmount}万元</p></td>
										
										<td class="window-table-td1"><p>预算年度：</p></td>
										<td class="window-table-td2"><p id="p_pfDate">${bean.pfDate}</p></td>
									</tr>
									
									<tr>
										<td class="window-table-td1"><p>可用额度：</p></td>
										<td class="window-table-td2"><p id="p_syAmount">${bean.syAmount}</p></td>
									</tr>
							</table>				
						</div>
					</div>	
				
					<!-- 采购清单 -->
					<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					  	<div title="采购清单" data-options="collapsible:false"
						style="overflow:auto;">
						<div style="overflow:auto;margin-top: 0px">
					  		<jsp:include page="../check/select_cgconf_plan_mingxi_reimb.jsp" />
						</div>
						</div>
					</div>
					</div>
			
			
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveCgsqReimb(0)">
					<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveCgsqReimb(1)">
					<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
			</div>
		</div>
	
		<div class="window-right-div" id="check_system_div" style="width:254px;height: 591px">
			<jsp:include page="../../check_system.jsp" />
		</div>
	</div>

<script type="text/javascript">
	$(document).ready(function() {
		//批复金额
		var pfAmount = $("#pfAmount").val();
		if(pfAmount !=""){
			$('#p_pfAmount').html(fomatMoney(pfAmount,2)+" [元]");
		}
		//可用金额
		var syAmount = $("#syAmount").val();
		if(syAmount !=""){
			$('#p_syAmount').html(fomatMoney(syAmount,2)+" [元]");
		}
		//批复时间
		var pfDate = $("#pfDate").val();
		if(pfDate !=""){
			$('#p_pfDate').html(getYear(pfDate));
		}
		
	});
	
	

	//保存
	function saveCgsqReimb(fCheckStauts) {
		
		//附件的路径地址
		var s="";
		$(".fileUrl").each(function(){
			s=s+$(this).attr("id")+",";
		});
		$("#files").val(s);
		var jsonStr1 = $("#form1").serializeJson();
		// 在后台反序列话成明细Json的对象集合
		$('#json1').val(jsonStr1);
		//设置审批状态
		$('#reimburseFlowStauts').val(fCheckStauts);
		//设置申请状态
		$('#reimburseStauts').val(fCheckStauts);
		flag = $('#payInfo_form').form('enableValidation').form('validate');
		if(flag){
			$('#hpayeeName').val($('#payeeName').textbox('getValue'));
			$('#reimburseAmount').val($('#payeeAmount').numberbox('getValue'));
			$('#paymentType').val($('#paymentTypeShow').combobox('getValue'));
			$('#hbankAccount').val($('#bankAccount').textbox('getValue'));
			$('#hbank').val($('#bankName').textbox('getValue'));
			
		}else{
			return flag;
		}
		//提交
		$('#cgsq_reimb_form').form('submit', {
			onSubmit : function() {
				//获得校验结果
				flag = $(this).form('enableValidation').form('validate');
				if (flag) {
					//如果校验通过，则进行下一步
					$.messager.progress();
				}else{
					//校验不通过，就打开第一个校验失败的手风琴
					//openAccordion();
				}
				return flag;
			},
			url : base + '/reimburse/save',
			success : function(data) {
				if (flag) {
					$.messager.progress('close');
				}
				data=eval("("+data+")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
				    $("#cg_reimb_Tab").datagrid("reload");
				    $("#indexdb").datagrid("reload");
					closeWindow();
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
</script>
</body>