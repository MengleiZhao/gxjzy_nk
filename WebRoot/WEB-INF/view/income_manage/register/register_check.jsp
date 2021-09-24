<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<form id="re_check_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 451px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div" id="easyAcc">
				<!-- 主键id --><input type="hidden" name="fincomeId" id="F_fincomeId" value="${bean.fincomeId}"/>
				<!-- 审批状态 --><input type="hidden" id="F_fFlowStatus" name="fFlowStatus" value="${bean.fFlowStauts }"/>
				<!-- 审批结果 --><input type="hidden" id="fcheckResult" name="fcheckResult" value=""/>
				<!-- 审批意见 --><input type="hidden" id="fcheckRemake" name="fcheckRemake" value=""/>
				<!-- 审批附件 --><input type="hidden" id="spjlFile" name="spjlFile" value=""/>
				
				<div class="easyui-accordion"  style="margin-left: 20px;margin-right: 20px;">
					<div title="基本信息" data-options="collapsible:false" style="overflow:auto;">
						<table class="win-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;登记编号</td>
								<td class="td2">
									<input id="F_fincomeNum" class="easyui-textbox" type="text" readonly="readonly" required="required" name="fincomeNum" data-options="validType:'length[1,30]'" style="width: 212px" value="${bean.fincomeNum}"/>
								</td>
								<td class="td1"><span class="style1">*</span>&nbsp;登记日期</td>
								<td class="td2">
									<input class="easyui-datebox" id="F_fregisterTime" name="fregisterTime" readonly="readonly" required="required" data-options="validType:'length[1,30]',editable:false" style="width: 212px" value="${bean.fregisterTime}"/>
								</td>			
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;登记部门</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fregisterDepart" name="fregisterDepart" readonly="readonly" required="required" data-options="validType:'length[1,30]',editable:false" style="width: 212px" value="${bean.fregisterDepart}"/>
								</td>
								<td class="td1"><span class="style1">*</span>&nbsp;登记人</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fregisterPerson" name="fregisterPerson" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 212px" value="${bean.fregisterPerson}"/>
								</td>
							</tr>
										
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;立项项目名称</td>
								<td class="td2"  colspan="4">
									<input id="fproName" class="easyui-textbox" type="text" readonly="readonly" name="fproName" data-options="editable:false" required="required" style="width: 555px" value="${bean.fproName}"/>
								</td>
							</tr>
										
							<tr class="trbody">	
								<td class="td1"><span class="style1">*</span>收费标准</td>
								<td colspan="4">
									<input class="easyui-textbox" id="F_fPlanPrice" name="fPlanPrice" readonly="readonly" required="required" data-options="validType:'length[1,500]',multiline:true" style="width: 555px; height: 70px" value="${bean.fPlanPrice}"/>
								</td>
							</tr>
							<tr style="height: 5px;"></tr>
							<tr class="trbody">	
								<td class="td1"><span class="style1">*</span>收费依据</td>
								<td colspan="4">
									<input class="easyui-textbox" id="F_fProPlan" name="fProPlan" required="required" readonly="readonly"  data-options="validType:'length[1,500]',multiline:true" style="width: 555px; height: 70px" value="${bean.fProPlan}"/>
								</td>
							</tr>
							<tr style="height: 5px;"></tr>
							<tr class="trbody">	
								<td class="td1">论证资料</td>
								<td colspan="4">
									<input class="easyui-textbox" id="F_fRemark" name="fRemark" readonly="readonly"  data-options="validType:'length[1,500]',multiline:true" style="width: 555px; height: 70px" value="${bean.fRemark}"/>
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1">
									&nbsp;&nbsp;附件
									<input type="file" multiple="multiple" id="f_business" onchange="upladFile(this, 'business', 'business01')" hidden="hidden">
									<input type="text" id="files" name="files" hidden="hidden">
								</td>
								<td colspan="4" id="tdf">
								<c:if test="${!empty businessAttaList}">
									<c:forEach items="${businessAttaList }" var="att">
										<c:if test="${att.serviceType=='business' }">
											<div style="margin-top: 10px;">
												<a href='${base}/attachment/download/${att.id }' style="color: #666666;font-weight: bold;">${att.originalName }</a>
												&nbsp;&nbsp;&nbsp;&nbsp;
											</div>
										</c:if>
									</c:forEach>
								</c:if>
								<c:if test="${empty businessAttaList}">
									<span style="color:#999999">暂未上传附件</span>
								</c:if>
								</td>
							</tr>
						</table>
					</div>
					</div>
				<!-- 来款明细-->
				<div  class="easyui-accordion"  style="margin-left: 20px;margin-right: 20px;">
					<div title="应收款项明细" data-options="collapsible:false"
						style="overflow:auto;">
						<div style="overflow:auto;margin-top: 0px">
						<jsp:include page="mingxi_list_detail.jsp" /> 
						</div>
					</div>
				</div>
				<!-- 审批记录 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="审批记录" data-options="collapsible:false" style="overflow:auto;">
							<jsp:include page="../../check_history.jsp" />
					</div>
				</div>
				</div>
			
			<div class="window-left-bottom-div" style="margin-top: 15px;">
				<a href="javascript:void(0)" onclick="openCheckWin('审批意见','1')">
					<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="openCheckWin('审批意见','0')">
					<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		<div class="window-right-div" style="width:254px;height: auto">
			<jsp:include page="../../check_system.jsp" />
		</div>
	</div>
</form>

<script type="text/javascript">
//送审
function check(result) {
	$('#re_check_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}
			return flag;
		},
		url : base + '/srregister/checkResult',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#re_check_form').form('clear');
				$('#registerTab').datagrid('reload');
				$('#indexdb').datagrid('reload');
				closeWindow();
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});  
}
</script>
</body>