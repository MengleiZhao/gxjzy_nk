<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!-- 基本信息 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 695px">
<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
	<table class="window-table" style="margin-top: 10px" cellspacing="0" cellpadding="0">
		<tr class="trbody">
			<td style="width: 70px;"><span class="style1">*</span> 摘要</td>
			<td class="td2" colspan="4">
				<input style="width: 620px;height: 30px;" readonly="readonly" id="gNames" class="easyui-textbox" value="${bean.gName}" />
			</td>
		</tr>
		<tr class="trbody">
			<td style="width: 70px;"><span class="style1">*</span>项目名称</td>
			<td class="td2" colspan="4">
				<input style="width: 620px;height: 30px;" id="proName_show" readonly="readonly" class="easyui-combobox" value="${bean.proName}" 
				data-options="editable:false,panelHeight:'auto',
				url:'${base}/reimburse/getProNameData?selected=${bean.proName}',
				method:'POST',valueField:'code',textField:'text',editable:false,validType:'selectValid',"/>
			</td>
		</tr>
		<tr class="trbody">
			<td style="width: 70px;"><span class="style1">*</span> 经办人</td>
			<td class="td2">
				<input class="easyui-textbox" value="${bean.userName}" readonly="readonly" style="width: 200px; height: 30px;" readonly="readonly" required="required" data-options="validType:'length[1,50]'"/>
			</td>
			<td style="width:140px"></td>
			<td style="width: 70px;">部门名称</td>
			<td class="td2">
				<input class="easyui-textbox" value="${bean.deptName}" readonly="readonly" style="width: 200px; height: 30px;" required="required" data-options="validType:'length[1,50]'" readonly="readonly"/>
			</td>
		</tr>
		<tr class="trbody">
			<td style="width: 70px;"><span class="style1">*</span>报销时间</td>
			<td class="td2" >
				<input class="easyui-datebox" id="reimburseReqTime" name="reimburseReqTime" readonly="readonly" value="${bean.reimburseReqTime}" style="width: 200px;height: 30px;margin-left: 10px; margin-bottom: 5px;" >
			</td>
			<td style="width:140px"></td>
			<td class="td1" style="width: 70px;"></td>
			<td class="td2" >
			</td>
		</tr>
		<tr style="height:5px;"></tr>
		<tr class="trbody" style="margin-top: 10px;">
			<td style="width: 70px;" ><p style="margin-top: 10px"> 报销说明</p></td>
			<td class="td2" colspan="4">
				<input style="width: 620px;height: 60px;margin-top: 5px;"id="commreason"  readonly="readonly"  class="easyui-textbox" data-options="multiline:true"
				value="${bean.reimburseReason}" required="required" />
		</tr>
	</table>
	</div>				
</div>
<!-- 费用明细 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 40px;width: 695px">
	<div title="费用明细" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
		<div style="overflow:auto;">
			<!--  通用事项申请明细 -->
			<jsp:include page="../reimburse/reimburse_current_mingxi_detail.jsp" />
		</div>
		<div style="overflow:hidden;margin-top: 0px">
			<!-- 通用事项发票明细 -->
			<jsp:include page="../reimburse/mingxi_current_detail.jsp" />
		</div>
	</div>
</div>

<!-- 收款人信息 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
	<div title="收款人信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;padding:0px;">
		<div id="" style="overflow-x:hidden;margin-top: 0px;">
			<jsp:include page="../reimburse/payee-info_detail.jsp" />	
		</div>
	</div>
</div>
<!-- 附件信息 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 695px">
	<div title="附件信息" data-options="collapsed:false,collapsible:false" style="overflow:auto; ">		
		<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
			<tr class="trbody">
				<td style="width:60px;text-align: right;">附件:</td>
				<td colspan="4">
					<c:if test="${!empty attaList1}">
					<c:forEach items="${attaList1}" var="att">
						<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a><br>
					</c:forEach>
				</c:if>
				<c:if test="${empty attaList1}">
					<span style="color:#999999;">暂未上传附件</span>
				</c:if>
				</td>
			</tr>
		</table>			
	</div>
</div>
<!-- 审批记录报销 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
	<div title="审批记录" data-options=" collapsible:false" style="overflow:auto;padding:0px;">
			<jsp:include page="../check/check_history.jsp" />
	</div>
</div>
