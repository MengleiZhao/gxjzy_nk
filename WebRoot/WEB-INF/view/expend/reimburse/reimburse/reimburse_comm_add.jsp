<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!-- 预算信息 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
	<div title="预算信息" data-options="collapsed:false,collapsible:false"style="overflow:auto;margin-left: 0px;height: auto">				
		<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;;margin-bottom: 0px;width: 695px;">					
			<tr class="trbody">
				<td style="width: 60px;"><span class="style1">*</span> 支出项目</td>
				<td colspan="3" style="padding-right: 5px;">
					<input class="easyui-textbox" style="width: 630px;height: 30px;"
					 value="${bean.indexName}" id="F_fBudgetIndexName"
					 readonly="readonly" required="required"/>
				</td>
			</tr>
		</table>	
		<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="margin-left:0px;;margin-bottom: 0px;width: 695px;height: 50px;">
			<tr>
				<td class="window-table-td1"><p style=" color:#0000CD;">申请金额:</p></td>
				<td class="window-table-td2"><p id="applyAmount_span">${applyBean.amount}[元]</p></td>
				<td class="window-table-td1"><p style="color: red;" >报销金额:</p></td>
				<td class="window-table-td2"><p id="p_amount">${bean.amount}[元]</p></td>
			</tr>
			<tr>
				<td class="window-table-td1"><p>归还预算:</p></td>
				<td class="window-table-td2"><p id="ghAmount">[元]</p></td>
			</tr>
			<tr >
				<td class="window-table-td1"><p>是否冲销借款</p></td>
				<td class="window-table-td2">
					<input id="hotelstd_add_sfwj" name="withLoan" value="1"
						type="radio" onclick="selectCxjk(this)" <c:if test="${bean.withLoan==1 }">checked="checked"</c:if>/>是
					<input id="hotelstd_add_sfwj" name="withLoan" value="0"
						type="radio" onclick="selectCxjk(this)" <c:if test="${bean.withLoan!=1 }">checked="checked"</c:if>/>否
				</td>	
			</tr>
			<tbody id="jk">
				<tr>
					<td class="window-table-td1"><p>借款单号:</p></td>
					<td class="window-table-td2">
						<a href="#" onclick="chooseJkd()">
							<input class="easyui-textbox" value="${bean.loan.lCode}"  id="input_jkdbh" style="width: 250px;height: 30px;" data-options="prompt:'借款单选择'" readonly="readonly" >
							<input id="input_jkdid" hidden="hidden" value="${bean.loan.lId}" name="loan.lId"/>
							<input id="input_jkdamonut" value="${bean.loan.lAmount}" hidden="hidden"  />
						</a>
					</td>
				</tr>
				<tr>
					<td class="window-table-td1"><p>本次冲销金额:</p></td>
					<td class="window-table-td2"><p id="cxAmount">[元]</p></td>
					<td class="window-table-td1"><p>剩余应还:</p></td>
					<td class="window-table-td2"><p id="syAmount">[元]</p></td>
				</tr>
			</tbody>
		</table>			
	</div>
</div>
<!-- 基本信息 -->
<form id="paymentTypeForm" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
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
				<input style="width: 620px;height: 30px;" id="gNames" class="easyui-textbox" value="${bean.gName}" />
			</td>
		</tr>
		<%-- <tr class="trbody">
			<td style="width: 70px;"><span class="style1">*</span> 付款方式</td>
			<td class="td2">
				<input class="easyui-combobox" id="paymentTypeShow" value="${bean.paymentType}" style="width: 200px; height: 30px;" required="required" data-options="validType:'selectValid',editable:false,url:base+'/lookup/lookupsJson?parentCode=FKFS&selected=${bean.paymentType}',method:'POST',valueField:'text',textField:'text'"/>
			</td>
			<td style="width:140px"></td>
			<td style="width: 70px;"></td>
			<td class="td2">
			</td>
		</tr> --%>
		<tr style="height:5px;"></tr>
		<tr class="trbody" style="margin-top: 10px;">
			<td style="width: 70px;" ><p style="margin-top: 10px"><span class="style1">*</span> 报销事由</p></td>
			<td class="td2" colspan="4">
				<input style="width: 620px;height: 60px;margin-top: 5px;"id="commreason" class="easyui-textbox" data-options="multiline:true"
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
</form>
<!-- 费用明细 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 40px;width: 695px">
	<div title="费用明细" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
		<div style="overflow:auto;">
			<!--  通用事项申请明细 -->
			<jsp:include page="reimburse_comm_mingxi_edit.jsp" />
		</div>
		<c:if test="${operation=='add'}">		
			<div style="overflow:hidden;margin-top: 0px">
				<!-- 通用事项发票明细 -->
				<jsp:include page="mingxi_comm.jsp" />
			</div>
		</c:if>
		<c:if test="${operation=='edit'}">		
			<div style="overflow:hidden;margin-top: 0px">
				<!-- 通用事项发票明细 -->
				<jsp:include page="mingxi_comm_edit.jsp" />
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
				<input type="file" multiple="multiple" id="f" onchange="upladFile(this,'bxsq','zcgl01')" hidden="hidden">
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
<%-- <!-- 下级审批人 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 695px">
	<div title="下级审批人" data-options="collapsed:false,collapsible:false" style="overflow:auto; ">	
		<table class="window-table" cellspacing="0" cellpadding="0">
			<tr class="trbody">
				<td class="td1" style="text-align: left;padding-right: 0px;"><span class="style1">*</span> 下级审批人</td>
				<td class="td2">
					<a href="#" onclick="chooseUserid()">
						<input class="easyui-textbox" style="width: 200px; height: 30px;" id="userName2" name="userName2" readonly="readonly"
						data-options="prompt:'单击选取审批人'" required="required" />
					</a>
				</td>
				<td class="td3">
					<!-- 下节点节点编码 -->
					<!-- <input hidden="hidden" name="fuserId" id="fuserId"> -->
				</td>
				<td class="td1"><span class="style1"></span></td>
				<td class="td2">
					<input class="easyui-datebox" style="width: 200px; height: 30px;" id="meetingDateEnd" name="dateEnd"
					data-options="onSelect:onSelect2" value="${bean.dateEnd}" required="required" editable="false"/>
				</td> 
			</tr>
		</table>
	</div>
</div> --%>