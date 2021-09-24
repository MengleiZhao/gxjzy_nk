<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<!-- 基本信息 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 695px">
<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
	<table class="window-table" style="margin-top: 10px" cellspacing="0" cellpadding="0">
		<tr class="trbody">
			<td style="width: 70px;"><span class="style1">*</span> 摘要</td>
			<td class="td2" colspan="4">
				<input style="width: 620px;height: 30px;" id="gNames" class="easyui-textbox" value="${bean.gName}" />
			</td>
		</tr>
		<tr class="trbody">
			<td style="width: 70px;"><span class="style1">*</span>项目名称</td>
			<td class="td2" colspan="4">
				<input style="width: 620px;height: 30px;" id="proName_show" class="easyui-combobox" value="${bean.proName}" 
				data-options="editable:false,panelHeight:'auto',
				url:'${base}/reimburse/getProNameData?selected=${bean.proName}',
				method:'POST',valueField:'code',textField:'text',editable:false,validType:'selectValid',"/>
			</td>
		</tr>
		<tr class="trbody">
			<td style="width: 70px;"><span class="style1">*</span> 经办人</td>
			<td class="td2">
				<input class="easyui-textbox" value="${bean.userName}" style="width: 200px; height: 30px;" readonly="readonly" required="required" data-options="validType:'length[1,50]'"/>
			</td>
			<td style="width:140px"></td>
			<td class="td1" style="width: 70px;">部门名称</td>
			<td class="td2">
				<input class="easyui-textbox" value="${bean.deptName}" style="width: 200px; height: 30px;" required="required" data-options="validType:'length[1,50]'" readonly="readonly"/>
			</td>
		</tr>
		<tr class="trbody">
			<td style="width: 70px;"><span class="style1">*</span>报销日期</td>
			<td class="td2" >
				<input class="easyui-datebox" id="reimburseReqTime" name="reimburseReqTime" readonly="readonly" value="${bean.reimburseReqTime}" style="width: 200px;height: 30px;margin-left: 10px; margin-bottom: 5px;" >
			</td>
			<td style="width:140px"></td>
			<td class="td1" style="width: 70px;"><span class="style1">*</span>付款方式</td>
			<td class="td2" >
				<input class="easyui-combobox" id="paymentTypeShow" value="${bean.paymentType}" required="required" style="width: 200px; height: 30px;" data-options="validType:'selectValid',editable:false,url:base+'/lookup/lookupsJson?parentCode=FKFS&selected=${bean.paymentType}',method:'POST',valueField:'text',textField:'text'"/>
			</td>
		</tr>
		<tr style="height:5px;"></tr>
		<tr class="trbody" style="margin-top: 10px;">
			<td style="width: 70px;" ><p style="margin-top: 10px"> 报销说明</p></td>
			<td class="td2" colspan="4">
				<input style="width: 620px;height: 60px;margin-top: 5px;"id="commreason" class="easyui-textbox" data-options="multiline:true"
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
			<jsp:include page="reimburse_current_mingxi_edit.jsp" />
		</div>
		<c:if test="${operation=='add'}">		
			<div style="overflow:hidden;margin-top: 0px">
				<!-- 通用事项发票明细 -->
				<jsp:include page="mingxi_current.jsp" />
			</div>
		</c:if>
		<c:if test="${operation=='edit'}">		
			<div style="overflow:hidden;margin-top: 0px">
				<!-- 通用事项发票明细 -->
				<jsp:include page="mingxi_current_edit.jsp" />
			</div>
		</c:if>
	</div>
</div>

<!-- 收款人信息 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
	<div title="收款人信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;padding:0px;">
		<div id="" style="overflow-x:hidden;margin-top: 0px;">
			<jsp:include page="payee-info.jsp" />	
		</div>
	</div>
</div>
<!-- 附件信息 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
<div title="附件信息" data-options="collapsed:false,collapsible:false"
	style="overflow:auto;">		
	<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
		<tr>
			<td style="width:75px;text-align: left">
				&nbsp;&nbsp;附件
				<input type="file" multiple="multiple" id="f" onchange="upladFile(this,'wlkbx','zcgl01')" hidden="hidden">
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
				<c:forEach items="${attaList1}" var="att">
					<div style="margin-top: 5px;">
					<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<img style="margin-top: 5px;" src="${base}/resource-modality/${themenurl}/sccg.png">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
					</div>
				</c:forEach>
			</td>
		</tr>
	</table>
</div>
</div>
<c:if test="${operation=='edit'}">
	<!-- 审批记录报销 -->
	<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
		<div title="审批记录" data-options=" collapsible:false" style="overflow:auto;padding:0px;">
			<!-- <div class="window-title"> 审批记录</div> -->
				<jsp:include page="../check/check_history.jsp" />
		</div>
	</div>
</c:if>
