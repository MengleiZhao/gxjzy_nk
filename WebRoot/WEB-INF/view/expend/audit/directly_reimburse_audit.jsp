\<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
  
<body>
<div class="win-div">
<form id="directly_reimburse_audit_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="easyAcc" style="width:662px;margin-left: 20px">
					<div title="基本信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable">
							<tr class="trbody">
								<td class="td1">报销摘要</td>
								<td colspan="4">
									<input style="width: 555px;" name="summary" class="easyui-textbox"
									value="${bean.summary}" readonly="readonly"/>
								</td>
							</tr>
						
							<tr class="trbody">
								<td class="td1">报销人</td>

								<td class="td2"><input style="width: 200px;" id=""
									name="userName" class="easyui-textbox"
									value="${bean.userName}" readonly="readonly"></input>
								<td class="td4">
									<!-- 隐藏域 --> 
									<!-- 主键ID --><input type="hidden" name="drId" value="${bean.drId}" />
									<!-- 报销单编号 --><input type="hidden" name="drCode" value="${bean.drCode}" />
									<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="drFlowStauts" />
									<!-- 申请状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="drStauts" />
									<!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}" />
									<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" />
									<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
									<!-- 指标ID --><input type="hidden" name="indexId" value="${bean.indexId}" id="indexId"/>
									<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="indexType"/>
									<!-- 审定结果 --><input type="hidden" name="auditResult" id="directlyReimbAuditResult" value=""/>
									<input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
			    					<input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
			    					<!-- 审批附件 --><input type="hidden" name="spjlFile" id="spjlFile" value=""/>
								</td>

								<td class="td1">报销部门</td>
								<td class="td2"><input style="width: 200px;"
									value="${bean.deptName}" readonly="readonly" id=""
									name="deptName" class="easyui-textbox" readonly="readonly"></input>
								</td>
							</tr>

							<tr class="trbody">
								<td class="td1">报销类别</td>
								<td class="td2">
								<input style="width: 200px;"
									value="直接报销" readonly="readonly" id="drType"
									name="type" class="easyui-textbox" readonly="readonly"/>
								</td>

								<td style="width: 0px"></td>

								<td class="td1">报销时间</td>

								<td class="td2"><input style="width: 200px;"
									id="directlyReimburseReqTime" name="reqTime" class="easyui-datebox"
									readonly="readonly" value="${bean.reqTime}" readonly="readonly"></input></td>
							</tr>

							<tr class="trbody">
								<td class="td1">支出项目</td>
								<td class="td2"><input type="text" style="width: 200px;"
									name="indexName" class="easyui-textbox"
									value="${bean.indexName}" id="F_fBudgetIndexName"
									data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo',handler: function(){openIndex()}}]" readonly="readonly"/>
								</td>
								
								<td style="width: 0px"></td>

								<td class="td1">申请总额</td>
								<td class="td2">
									<input class="easyui-numberbox" name="amount" style="width: 200px;" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]"
									value="${bean.amount}" readonly="readonly">
								</td>
							</tr>

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
							

							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px">申请事由</p></td>
								<td colspan="4">
									<input class="easyui-textbox"data-options="multiline:true" name="reason" style="width:555px;height:70px;" value="${bean.reason}" readonly="readonly"/>
								</td>
							</tr>
						</table>
					</div>

					<div title="明细信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../reimburse/directly_reimburse/directly_reimburse_mingxi.jsp" />
					</div>
					
					<div title="发票信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../reimburse/directly_reimburse/directly_reimburse_invoice.jsp" />
					</div>
					
					<div title="收款人信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../payee-info-detail.jsp" />
					</div>
					
					<!-- <div title="财务审定" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable">
							<tr class="trbody">
								<td class="td1">审定结果</td>

								<td colspan="4">
									<input checked="checked" type="radio" value="1" name="outCheckResult"/>通过
									<input type="radio" value="0" name="outCheckResult"/>不通过
								</td>
							</tr>
							
							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px">审定内容</p></td>
								<td colspan="4">
									<input class="easyui-textbox"
									data-options="multiline:true" name="auditRemake"
									style="width:555px;height:70px">
								</td>
							</tr>
						</table>
					</div> -->
					<input hidden="hidden" name="auditRemake" id="remakeValue"/>
					
					<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../../check_history.jsp" />												
					</div>
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="openCheckWin('审定意见','1')">
					<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="openCheckWin('审定意见','0')">
					<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div>
	</div>
</form>
</div>
<script type="text/javascript">
//审定
function check(result) {
/* 	var checkResult =$("input[name='outCheckResult']:checked").val(); */
	$('#directlyReimbAuditResult').val(result);
	
	$('#directly_reimburse_audit_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}
			return flag;
		},
		url : base + '/audit/reimburseAuditResult',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				$('#directly_reimburse_audit_form').form('clear');
				$('#directlyReimbAuditTab').datagrid('reload'); 
				$("#indexdb").datagrid('reload');
			} else {
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#directly_reimburse_audit_form').form('clear');
			}
		}
	});
}
		
		
</script>
</body>

