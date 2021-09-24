<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table class="window-table" style="margin-top: 10px;width: 695px" cellspacing="0" cellpadding="0">
	<input type="hidden" name="fbId" id="F_fbId" value="${br.fbId}"/><!--过程登记的主键id  --> 
	<c:forEach items="${fwbean }" varStatus="i" var="invoice">
		<tbody id="supplier_${i.index}" style="overflow:hidden;">
			<tr>
				<td class="td1"></td>
				<td class="td1"></td>
				<td>供应商<c:if test="${i.index != '0'}">${i.index}</c:if></td>
				<td class="td1"></td>
			</tr>
			<tr>
				<td class="td1"><span class="style1">*</span>&nbsp;供应商名称</td>
				<td colspan="4">
					<input class="easyui-textbox" id="F_fwName_${i.index}" name="fwName" required="required" readonly="readonly" data-options="" style="width: 587px;height: 30px;" value="${invoice.fwName}"/>
				</td>
			</tr>	
				
			<tr>
				<td class="td1" style="width: 70px">联系人</td>
				<td class="td2">
					<input class="easyui-textbox" id="F_fwuserName_${i.index}"  name="fwuserName" data-options="" readonly="readonly" style="width: 230px; height: 30px;" value="${invoice.fwuserName}"/>
				</td>
				<td class="td1" style="width: 120px"><span class="style1">*</span>&nbsp;成交日期</td>
				<td class="td2">
					<input class="easyui-datebox" id="F_flastDealTime_${i.index}" name="flastDealTime" required="required" readonly="readonly" data-options="editable:false" style="width: 230px; height: 30px;" value="${invoice.flastDealTime}"/>
				</td>
				
			</tr>
			<tr>
				<td class="td1" style="width: 120px">手机号码</td>
				<td class="td2">
					<input class="easyui-textbox" id="F_fwTel_${i.index}" name="fwTel" readonly="readonly" data-options="validType:'length[11,11]'" style="width: 230px; height: 30px;" value="${invoice.fwTel}"/>
				</td>
				<td class="td1" style="width: 120px">座机号码</td>
				<td class="td2">
					<input class="easyui-textbox" id="F_fwStorageTel_${i.index}" name="fwStorageTel" readonly="readonly" data-options="validType:'length[10,12]'" style="width: 230px; height: 30px;" value="${invoice.fwStorageTel}"/>
				</td>
			</tr>
			<tr>
				<td class="td1" style="width: 70px"><span class="style1">*</span>&nbsp;成交金额[元]</td>
				<td class="td2">
					<input class="easyui-numberbox" id="F_dealAmount_${i.index}" name="dealAmount" required="required" readonly="readonly" data-options="precision:2" style="width: 230px; height: 30px;" value="${invoice.dealAmount}"/>
				</td>
				<td class="td1" style="width: 70px"><span class="style1">*</span>&nbsp;允许浮增金额[元]</td>
				<td class="td2">
					<input class="easyui-numberbox" id="F_floatAmount_${i.index}" name="floatAmount" required="required" readonly="readonly" data-options="precision:2" style="width: 230px; height: 30px;" value="${invoice.floatAmount}"/>
				</td>
				
			</tr>
			
			<tr>
				<td class="td1" valign="top">&nbsp;&nbsp;备注</td>
				<td colspan="4" style="margin-top: 10px;">
					<input class="easyui-textbox" id="F_fwRemark_${i.index}" name="fwRemark" readonly="readonly" data-options="validType:'length[1,200]',multiline:true" style="width:587px;height:70px;" value="${invoice.fwRemark}"/>
				</td>
			</tr>
			
		</tbody>
	</c:forEach>
	
	<tr>
		<!-- 附件信息 -->
		<td class="td1" style="width:60px;">
			<span class="style1">*</span>附件
			<input type="file" multiple="multiple" id="f" onchange="upladFile(this,'supplier','cggl01')" hidden="hidden">
		</td>
		<td colspan="3" id="tdf">
			<c:forEach items="${brAttac}" var="att">
				<c:if test="${att.serviceType=='supplier'}">
					<div style="margin-top: 0px;">
						<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
					</div>
				</c:if>	
			</c:forEach>
		</td>
	</tr>
</table>