<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body>
<div class="win-div">
<form id="reimburse_cashier_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="easyAcc" style="width:662px;margin-left: 20px">
					<div title="基本信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable">
							<tr class="trbody">
								<td class="td1">事前申请单号</td>
								<td colspan="4">
									<input type="text" style="width: 555px;"
									name="gCode" class="easyui-textbox"
									value="${bean.gCode}" id=""
									readonly="readonly"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1">报销摘要</td>
								<td colspan="4">
									<input style="width: 555px;" name="gName" class="easyui-textbox"
									value="${bean.gName}" readonly="readonly"/>
								</td>
							</tr>
						
						
							<tr class="trbody">
								<td class="td1">报销人</td>

								<td class="td2">
									<input style="width: 200px;" id="" name="userName" class="easyui-textbox"
									value="${bean.userName}" readonly="readonly"></input>
								<td class="td4">
									<!-- 隐藏域 --> 
									<!-- 主键ID --><input type="hidden" name="rId" value="${bean.rId}" id="rId"/>
									<!-- 报销单号 --><input type="hidden" name="rCode" value="${bean.rCode}" id="rId"/>
									<!-- 收款人主键ID --><input type="hidden" name="pId" value="${payeeBean.pId}"/>
									<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="reimburseFlowStauts" />
									<!-- 报销状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="reimburseStauts" />
									<!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}" />
									<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" />
									<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
									<!-- 报销类型 --><input type="hidden" id="reimburseTypeHi" value="${bean.type}" />
									<!-- 指标ID --><input type="hidden" name="indexId" value="${bean.indexId}" id=""/>
									<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id=""/>
									<input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
			    					<input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
			    					<!-- 审批附件 --><input type="hidden" name="spjlFile" id="spjlFile" value=""/>
								</td>

								<td class="td1">报销部门</td>
								<td class="td2">
									<input style="width: 200px;" id="" name="deptName" class="easyui-textbox"
									value="${bean.deptName}" readonly="readonly"></input></td>
							</tr>

							<tr class="trbody">
								<td class="td1">报销事项</td>
								<td class="td2">
								<select id="reimburseType" class="easyui-combobox" name="type" style="width: 200px;">
										<option value="1">通用事项报销</option>
										<option value="2">会议报销</option>
										<option value="3">培训报销</option>
										<option value="4">差旅报销</option>
										<option value="5">公务接待报销</option>
										<option value="6">公务用车报销</option>
										<option value="7">公务出国报销</option>
								</select></td>

								<td style="width: 0px"></td>

								<td class="td1">报销时间</td>

								<td class="td2"><input style="width: 200px;"
									id="reimburseReqTime" name="reimburseReqTime" class="easyui-datebox"
									readonly="readonly" value="${bean.reimburseReqTime}"></input></td>
							</tr>

							<tr class="trbody">
								<td class="td1">支出项目</td>
								<td class="td2"><input type="text" style="width: 200px;"
									name="indexName" class="easyui-textbox"
									value="${bean.indexName}" id="" readonly="readonly"/>
								</td>

								<td class="td4"></td>
								
								<td class="td1">报销总额</td>
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
								<td class="td1" valign="top"><p style="margin-top: 8px">报销事由</p></td>
								<td colspan="4">
									<input class="easyui-textbox"data-options="multiline:true" name="reimburseReason" style="width:555px;height:70px;" value="${bean.reimburseReason}" readonly="readonly">
								</td>
							</tr>
						</table>
					</div>


					<div title="会议信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../apply/check/meetingCheck.jsp" />
					</div>
	
					<div title="培训信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../apply/check/trainingCheck.jsp" />
					</div>
	
					<div title="差旅信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../apply/check/travelCheck.jsp" />
					</div>
	
					<div title="接待信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../apply/check/receptionCheck.jsp" />
					</div>
					
					<div title="接待人员名单" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../apply/add/reception_people.jsp" />
					</div>
					
					<div title="公务用车信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../apply/check/officeCarCheck.jsp" />
					</div>
					
					<div title="公务出国信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../apply/check/abroadCheck.jsp" />
					</div>
	
					<div title="报销明细" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../reimburse/reimburse/reimburse_mingxi.jsp" />
					</div>
					
					<%-- <div title="发票信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../reimburse/reimburse/reimburse_invoice.jsp" />
					</div> --%>
					
					<div title="收款人信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../payee-info-detail.jsp" />
					</div>
					
					<div title="资金信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../apply/check/fundCheck.jsp" />												
					</div>
					
					<%-- <div title="出纳受理" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false"
						style="overflow:auto;margin-top: 10px;">
						<table class="ourtable">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>受理人</td>

								<td class="td2">
									<input style="width: 200px;" name="acceptUser" class="easyui-textbox"
									value="${userInfo.name}" readonly="readonly"/>
								</td>
								<td class="td4">
								</td>

								<td class="td1"><span class="style1">*</span>受理时间</td>
								<td class="td2">
									<input style="width: 200px;" name="acceptTime" class="easyui-datebox" value="date" readonly="readonly"/>
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
				<a href="javascript:void(0)" onclick="openCheckWin('受理意见','1')">
					<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="openCheckWin('受理意见','0')">
					<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
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
//显示详细信息手风琴页面
$(document).ready(function() {
	//设值时间
	if ($("#rId").val() == "") {
		$("#reimburseReqTime").textbox().textbox('setValue', 'date');
	}

	var h = $("#reimburseTypeHi").textbox().textbox('getValue');
	if (h != "") {
		$('#reimburseType').textbox().textbox('setValue', h);
		$('#reimburseType').textbox().attr('readonly', true);
	}

	if (h == 1) {
		$("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息');
	}
	if (h == 2) {
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息');
	}
	if (h == 3) {
		$("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息');
	}
	if (h == 4) {
		$("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息');
	}
	if (h == 5) {
		$("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息');
	}
	if (h == 6) {
		$("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息');
	}
	if (h == 7) {
		$("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
	}
});


//审定
function check(result) {
	$('#reimburse_cashier_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}
			return flag;
		},
		url : base + '/cashier/reimburseCashierResult?result='+result,
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				$('#reimburse_cashier_form').form('clear');
				$('#reimburseCashierTab').datagrid('reload'); 
				$("#indexdb").datagrid('reload');
			} else {
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#reimburse_cashier_form').form('clear');
			}
		}
	});
}

		

		
		
</script>
</body>


