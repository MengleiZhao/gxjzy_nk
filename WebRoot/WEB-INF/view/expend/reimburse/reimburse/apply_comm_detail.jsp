<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!-- 预算信息 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 695px">
	<div title="预算信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;margin-left: 0px;height: 150px">				
		<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;width:693px;">
			<tr class="trbody">
				<td style="width: 60px;text-align: right;"><span style="text-align: left;color: red">*</span> 支出项目:</td>
				<td colspan="3" >
					<input class="easyui-textbox" style="width: 630px;height: 30px;"
					name="indexName" value="${bean.indexName}" id="F_fBudgetIndexName"
					data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo'}]" readonly="readonly" required="required"/>
				</td>
			</tr>
		</table>	
		<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="margin-left: 0px;width:693px;height: 50px;">
			<tr>
				<td class="window-table-td1"><p>批复金额：</p></td>
				<td class="window-table-td2"><p id="p_pfAmount"><fmt:formatNumber groupingUsed="true" value="${bean.pfAmount}" minFractionDigits="2" maxFractionDigits="2"/>元</p></td>
				
				<td class="window-table-td1"><p>预算年度：</p></td>
				<td class="window-table-td2"><p id="p_pfDate">${fn:substring(bean.pfDate, 0, 4)}</p></td>
			</tr>
			<tr>
				<td class="window-table-td1"><p>可用额度：</p></td>
				<td class="window-table-td2"><p id="p_syAmount"><fmt:formatNumber groupingUsed="true" value="${bean.indexAmount}" minFractionDigits="2" maxFractionDigits="2"/>元</p></td>
			</tr>
		</table>				
	</div>
</div>
<!-- 基本信息 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 695px">
<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
	<table class="window-table" style="margin-top: 10px" cellspacing="0" cellpadding="0">
		<tr class="trbody">
			<td style="width: 70px;"><span class="style1">*</span> 单据编号</td>
			<td class="td2" colspan="4">
				<input style="width: 620px; height: 30px;margin-left: 10px" name="gCode" class="easyui-textbox"
				value="${bean.gCode}" data-options="prompt: '事前申请选择' ,required:true" readonly="readonly"/>
			</td>
		</tr>
		<tr class="trbody">
			<td style="width: 70px;"><span class="style1">*</span> 事项摘要</td>
			<td class="td2" colspan="4">
				<input style="width: 620px;height: 30px;" name="gName" class="easyui-textbox"
				value="${applyBean.gName}" readonly="readonly"/>
			</td>
		</tr>
		<tr class="trbody" style="margin-top: 10px;">
			<td style="width: 70px;" valign="top"><p style="margin-top: 10px"><span class="style1">*</span> 申请事由</p></td>
			<td class="td2" colspan="4">
				<input style="width: 620px;height: 60px;" name=""  class="easyui-textbox" data-options="multiline:true" readonly="readonly"
				value="${applyBean.reason}" required="required" />
		</tr>
		<tr class="trbody">
			<td style="width: 70px;"><span class="style1">*</span> 经办人</td>
			<td class="td2">
				<input class="easyui-textbox" value="${bean.userName}" style="width: 200px; height: 30px;" readonly="readonly" required="required" data-options="validType:'length[1,50]'"/>
			</td>
			<td style="width:140px"></td>
			<td style="width: 70px;">部门名称</td>
			<td class="td2">
				<input class="easyui-textbox" value="${bean.deptName}" style="width: 200px; height: 30px;" required="required" data-options="validType:'length[1,50]'" readonly="readonly"/>
			</td>
		</tr>
		<tr class="trbody">
			<td style="width: 70px;"><span class="style1">*</span> 费用类型</td>
			<td class="td2">
			<select id="fcostType" class="easyui-combobox" readonly="readonly"
				name="fcostType" style="width: 200px; height: 30px;" data-options="required:true" editable="false">
					<option value="1" <c:if test="${applyBean.fcostType=='1'}"> selected="selected" </c:if>>人员经费</option>
					<option value="2" <c:if test="${applyBean.fcostType=='2'}"> selected="selected" </c:if>>部门日常办公经费</option>
					<option value="3" <c:if test="${applyBean.fcostType=='3'}"> selected="selected" </c:if>>因公出国经费</option>
					<option value="4" <c:if test="${applyBean.fcostType=='4'}"> selected="selected" </c:if>>科研经费/教研经费</option>
					<option value="5" <c:if test="${applyBean.fcostType=='5'}"> selected="selected" </c:if>>其他公用经费</option>
			</select>
			</td>
		</tr>
	</table>
	</div>				
</div>
<!-- 费用明细 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 40px;width: 695px">
	<div title="费用明细" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
		<div style="overflow:auto;">
			<!--  通用事项申请明细 -->
			<jsp:include page="apply_comm_mingxi_detail.jsp" />
		</div>
	</div>
</div>

<!-- 附件信息 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 695px">
	<div title="附件信息" data-options="collapsed:false,collapsible:false" style="overflow:auto; ">		
		<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
			<tr class="trbody">
				<td style="width:60px;">附件</td>
				<td colspan="4">
					<c:if test="${!empty attaList}">
					<c:forEach items="${attaList}" var="att">
						<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a><br>
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
<!-- 审批记录 事前申请 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 695px">
	<div title="审批记录" data-options=" collapsible:false" style="overflow:auto;">
		<!-- <div class="window-title"> 审批记录</div> -->
			<jsp:include page="../check/check_history_apply.jsp" />
	</div>
</div>