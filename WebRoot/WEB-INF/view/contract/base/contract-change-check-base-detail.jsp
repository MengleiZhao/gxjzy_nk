<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
	<div title="变更信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
		<table class="window-table" style="margin-top: 10px;width: 695px" cellspacing="0" cellpadding="0">
			<tr class="trbody">
				<td class="td1"><span class="style1">*</span>&nbsp;原合同编号</td>
				<td colspan="4">
					<input class="easyui-textbox" id="F_fContCodeOld" name="fContCodeOld" readonly="readonly" required="required" data-options="validType:'length[1,50]'" style="width: 587px;height: 30px;" value="${Upt.fContCodeOld}"/>
				</td>
			</tr>	
			<tr class="trbody">
				<td class="td1"><span class="style1">*</span>&nbsp;原合同名称</td>
				<td colspan="4">
					<input class="easyui-textbox" id="F_fContNameOld" name="fContNameOld" readonly="readonly" required="required" data-options="validType:'length[1,50]'" style="width: 587px;height: 30px;" value="${Upt.fContNameOld}"/>
				</td>
			</tr>	
			<tr class="trbody">
				<td class="td1"><span class="style1">*</span>变更合同编号</td>
				<td colspan="4">
					<input class="easyui-textbox" id="F_fUptCode" name="fUptCode" readonly="readonly" required="required" data-options="validType:'length[1,50]'" style="width: 587px;height: 30px;" value="${Upt.fUptCode}"/>
				</td>
			</tr>	
			<tr class="trbody">
				<td class="td1"><span class="style1">*</span>变更合同名称</td>
				<td colspan="4">
					<input class="easyui-textbox" id="F_fContName" name="fContName" readonly="readonly" required="required" data-options="validType:'length[1,50]'" style="width: 587px;height: 30px;" value="${Upt.fContName}"/>
				</td>
			</tr>	
			<tr class="trbody">
				<td class="td1" ><span class="style1">*</span>&nbsp;变更内容</td>
				<td colspan="4">
					<input class="easyui-textbox" id="Upt_fUptReason" name="fUptReason" readonly="readonly" data-options="validType:'length[1,200]',multiline:true" style="width:587px;height:70px;margin-top: 10px;" value="${Upt.fUptReason }"/>
				</td>
			</tr>
			<tr class="trbody">
				<td class="td1" ><span class="style1">*</span>&nbsp;所属部门</td>
				<td>
					<input class="easyui-textbox" id="Upt_fDeptName" readonly="readonly" value="${Upt.fDeptName }" name="fDeptName" style="width: 240px;height: 30px;" data-options="editable:false,required:true">
				</td>
				<td class="td1" ><span class="style1">*</span>&nbsp;申请人</td>
				<td>
					<input class="easyui-textbox" id="Upt_fOperator" readonly="readonly" value="${Upt.fOperator }" name="fOperator" style="width: 240px;height: 30px;" data-options="editable:false,required:true">
				</td>
			</tr>
			<tr class="trbody">
				<td class="td1">
					<span class="style1">*</span>变更合同文本
					<input type="file" multiple="multiple" id="fhtbg" onchange="upladFileParams(this,'htbg','htgl01','progressNumberhtbg','percenthtbg','tdhtbg','htbgfiles','progidhtbg')" hidden="hidden">
					<input type="text" id="htbgfiles" name="htbgfiles" hidden="hidden">
				</td>
				<td colspan="4" id="tdhtbg">
					<div style="margin-top: 5px;">
						<c:forEach items="${changeAttaList}" var="att">
							<c:if test="${att.serviceType=='htbg' }">
								<div class="htbg" style="margin-top: 0px;margin-bottom: 10px;">
									<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</td>
			</tr>
		</table>
	</div>
</div>
<c:if test="${Upt.fContUptType=='HTFL-01'}">
	<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
		<div title="变更后采购清单" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
			<%@ include file="../base/contract-change-cgconf-mingxi-detail.jsp" %>
		</div>
	</div>
	<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
		<div title="付款计划" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
			<%@ include file="../base/contract-change-plan-detail.jsp" %>
		</div>
	</div>
</c:if>
<c:if test="${Upt.fContUptType=='HTFL-02'}">
	<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
		<div title="变更后收款计划" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
			<%@ include file="../base/contract-change-proceeds-plan-detail.jsp" %>
		</div>
	</div>
</c:if>
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
	<div title="附件信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
		<table class="window-table" style="margin-top: 10px;width: 695px" cellspacing="0" cellpadding="0">
			<tr class="trbody">
				<td class="td1">
					附件
					<input type="file" multiple="multiple" id="fhtbgOther" onchange="upladFileParamsOther(this,'htbgOther','htgl01','progressNumberhtbgOther','percenthtbgOther','tdhtbgOther','htbgOtherfiles','progidhtbgOther')" hidden="hidden">
					<input type="text" id="htbgOtherfiles" name="htbgOtherfiles" hidden="hidden">
				</td>
				<td colspan="4" id="tdhtbgOther" >
					<div style="margin-top: 5px;">
						<c:forEach items="${changeAttaList}" var="att">
							<c:if test="${att.serviceType=='htbgOther' }">
								<div class="htbgOther" style="margin-top: 0px;margin-bottom: 10px;">
									<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</td>
			</tr>
		</table>
	</div>
</div>
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
	<div title="审批记录" data-options="collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
		<jsp:include page="../../check_history.jsp" />
	</div>
</div>
<script type="text/javascript">
$('#Upt_fContUptType').combobox({
	onSelect : function(record){
		if(record.code=='HTBGLX-01'){
			$('#change-upt-datagr-div').show();
		}else {
			$('#change-upt-datagr-div').hide();
		}
		
	}
});

function onClickCellPlan(index, field){
	if (editIndex != index){
		if (endEditingPlan()){
			$('#change-upt-datagrid').datagrid('selectRow', index)
					.datagrid('beginEdit', index);
			var ed = $('#change-upt-datagrid').datagrid('getEditor', {index:index,field:field});
			if (ed){
				($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
			}
			editIndex = index;
		} else {
			setTimeout(function(){
				$('#change-upt-datagrid').datagrid('selectRow', editIndex);
			},0);
		}
	}
}
function appendPlan1(){
	if (endEditingPlan()){
		$('#change-upt-datagrid').datagrid('appendRow',{});
		editIndex = $('#change-upt-datagrid').datagrid('getRows').length-1;
		$('#change-upt-datagrid').datagrid('selectRow', editIndex)
				.datagrid('beginEdit', editIndex);
	}
}
function removeitPlan1(){
	if (editIndex == undefined){return}
	$('#change-upt-datagrid').datagrid('cancelEdit', editIndex)
			.datagrid('deleteRow', editIndex);
	editIndex = undefined;
}
var editIndex = undefined;
function endEditingPlan(){
	if (editIndex == undefined){return true}
	if ($('#change-upt-datagrid').datagrid('validateRow', editIndex)){
		$('#change-upt-datagrid').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function getPlan1(){
	$('#change-upt-datagrid').datagrid('acceptChanges');
	var rows = $('#change-upt-datagrid').datagrid('getRows');
	var entities= '';
	for(i = 0;i < rows.length;i++){
	 entities = entities  + JSON.stringify(rows[i]) + ',';  
	}
	entities = '[' + entities.substring(0,entities.length -1) + ']';
	return entities;
}
</script>