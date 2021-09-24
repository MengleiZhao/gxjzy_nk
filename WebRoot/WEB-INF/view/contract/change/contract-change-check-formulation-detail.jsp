<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="合同信息" data-options="collapsible:false" style="overflow:auto;margin-top:10px;">
					<%@ include file="../base/contract-formulation-base-detail.jsp"%>
				</div>
			</div>
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="签约方信息" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;">
				<%@ include file="../base/contract-formulation-sign-base-detail.jsp"%>
				</div>
			</div>
			<div id="recePlanId" hidden="hidden">
			<div class="easyui-accordion" data-options="collapsible:false" id="" style="width:707px;margin-left: 20px">
				<div title="采购清单" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;">
				  	<%@ include file="../base/contract_cg_mingxi_detail.jsp" %>												
				</div>	
			</div>
			</div>
			<div id="filingPlanId" hidden="hidden">
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="付款计划" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<%@ include file="../base/contract-filing-edit-plan-detail.jsp"%>
				</div>
			</div>
			</div>
			<div id="proceedsPlanId"  hidden="hidden">
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="收款计划" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<%@ include file="../base/contract-proceeds-edit-plan-detail.jsp"%>
				</div>
			</div>
			</div>
			<!-- 附件信息 -->
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
			<div title="附件信息" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
					<tr>
						<td class="td1" style="width:55px;text-align: left">
							&nbsp;&nbsp;附件
						</td>
						<td colspan="4" id="htndtdf">
							<c:forEach items="${formulationAttaList}" var="att">
								<c:if test="${att.serviceType=='fhtnd' }">
									<div style="">
										<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
									</div>
								</c:if>
							</c:forEach>
						</td>
					</tr>
				</table>
			</div>
			</div>
			<%-- <c:if test="${openType != 'add'}">
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="审批记录" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<%@ include file="../../check_history.jsp" />
				</div>
			</div>
			</c:if> --%>
<script type="text/javascript">
flashtab('contract-formulation-add');
//flashtab_pro_add('project-tab');
$('#F_fcAmount').numberbox({
    onChange:function(newValue,oldValue){
    	$('#F_fcAmountMax').textbox('setValue',convertCurrency(newValue));
    }
});

</script>