<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
  
<body>
<div class="win-div">
<form id="loan_cashier_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="easyAcc" style="width:662px;margin-left: 20px">
					<div title="基本信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table class="ourtable" cellpadding="0" cellspacing="0">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>借款人</td>

								<td class="td2">
									<input style="width: 200px;" name="userName" class="easyui-textbox"
									value="${bean.userName}" readonly="readonly"/>
								<td class="td4">
									<!-- 隐藏域 --> 
									<!-- 主键ID --><input type="hidden" name="lId" id="lId" value="${bean.lId}" />
									<!-- 借款单编号 --><input type="hidden" name="lCode" value="${bean.lCode}" />
									<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="loanflowStauts"/> 
									<!-- 申请状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="loanStauts" />
									<!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}"/>
									<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" />
									<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
									<!-- 指标ID --><input type="hidden" name="indexId" value="${bean.indexId}" id="indexId"/>
									<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="indexType"/>
									<input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
			    					<input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
			    					<!-- 审批附件 --><input type="hidden" name="spjlFile" id="spjlFile" value=""/>
								</td>

								<td class="td1"><span class="style1">*</span>所属部门</td>
								<td class="td2">
									<input style="width: 200px;"
									value="${bean.deptName}" readonly="readonly"
									name="deptName" class="easyui-textbox" readonly="readonly"/>
								</td>
							</tr>

							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>借款时间</td>
								<td class="td2">
									<input style="width: 200px;"
									id="loanReqTime" name="reqTime" class="easyui-datebox"
									value="${bean.reqTime}" readonly="readonly"/>
								</td>

								<td class="td4"></td>

								<td class="td1"><span class="style1">*</span>预计冲账时间</td>

								<td class="td2">
									<input style="width: 200px;"
									name="estChargeTime" class="easyui-datebox"
									value="${bean.estChargeTime}" readonly="readonly"/>
								</td>
							</tr>

							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>支出项目</td>
								<td class="td2">
									<input style="width: 200px;" name="indexName" class="easyui-textbox"
									value="${bean.indexName}" readonly="readonly"/>
								</td>
								
								<td class="td4"></td>
								
								<td class="td1"><span class="style1">*</span>申请金额</td>
								<td class="td2">
									<input style="width: 200px;"
									id="lAmount" name="lAmount" class="easyui-numberbox" precision="2"
									value="${bean.lAmount}" readonly="readonly"/>
								</td>
							</tr>
							
							
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>用途</td>
								<td colspan="4">
									<input style="width: 555px;"
									id="" name="loanPurpose" class="easyui-textbox"
									value="${bean.loanPurpose}" readonly="readonly"/>
								</td>
							</tr>

							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px">&nbsp;&nbsp;申请事由</p></td>
								<td colspan="4">
									<input class="easyui-textbox"
									data-options="multiline:true"
									style="width:555px;height:70px" value="${bean.loanReason}" readonly="readonly"/>
								</td>
							</tr>
						</table>
					</div>
					
					<div title="借款人信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../payee-info-detail.jsp" />
					</div>
					
					<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../../check_history.jsp" />												
					</div>
					
					<div title="资金信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../apply/check/fundCheck.jsp" />												
					</div>
					
					<%-- <div title="资金信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../apply/check/fundCheck.jsp" />												
					</div> --%>
					
					<%-- <div title="出纳受理" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false"
						style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>受理人</td>

								<td class="td2">
									<input style="width: 200px;" class="easyui-textbox"
									value="${userInfo.name}" readonly="readonly"/>
								</td>
								<td class="td4">
								</td>

								<td class="td1"><span class="style1">*</span>受理时间</td>
								<td class="td2">
									<input style="width: 200px;" class="easyui-datebox" value="date" readonly="readonly"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1" valign="top"><p style="margin-top: 8px">受理内容</p></td>
								<td colspan="4">
									<input style="width:555px;height:70px" class="easyui-textbox" data-options="multiline:true"
									name="remark" />
								</td>
							</tr>
						</table>
					</div> --%>
					<input hidden="hidden" name="remark" id="remakeValue"/>
				</div>
			
		
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="save()">
					<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<%-- <div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div> --%>
	</div>
</form>
</div>

<script type="text/javascript">
//审定
function save(result) {
	var id = $('#lId').val();
	$('#loan_cashier_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}
			return flag;
		},
		url : base + '/cashier/simplePayRegister?id='+id+'&registertype=2',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				$('#loan_cashier_form').form('clear');
				$('#loanCashierTab').datagrid('reload'); 
				$("#indexdb").datagrid('reload');
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});
}
</script>
</body>

