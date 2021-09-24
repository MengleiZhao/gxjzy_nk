<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
		<!-- 基本信息 -->
		<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 695px">
		<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
			<table class="window-table" style="margin-top: 3px;width: 693px" cellspacing="0" cellpadding="0">
				<tr class="trbody">
					<td style="width: 70px;"><span class="style1">*</span>事项摘要</td>
					<td colspan="3" class="td2" >
						<input style="width: 635px; height: 30px;margin-left: 10px" readonly="readonly" class="easyui-textbox"
						value="${applyBean.gName}" />
					</td>
				</tr>
				<tr class="trbody">
					<td style="width: 70px;"><span class="style1">*</span>单据编号</td>
					<td colspan="3" class="td2" >
						<input style="width: 635px;height: 30px;" readonly="readonly" class="easyui-textbox"
						value="${applyBean.gCode}" data-options="prompt: '事前申请选择' ,icons: [{iconCls:'icon-sousuo'}],required:true" readonly="readonly"/>
					</td>
				</tr>
				<tr class="trbody">
					<td style="width: 70px;"><span class="style1">*</span>出差类型</td>
					<td class="td2" colspan="3">
					<input class="easyui-combobox" readonly="readonly" style="width: 635px;height: 30px;" data-options="editable:false,url:'${base}/Formulation/lookupsJson?parentCode=CCLX&selected=${applyBean.travelType }',method:'POST',valueField:'code',textField:'text'">
					</td>
				</tr>
				<tr class="trbody" >
					<td style="width: 70px;"><span class="style1">*</span>出差事由</td>
					<td colspan="3" class="td2" >
						<textarea readonly="readonly" name="reason"  readonly="readonly" class="textbox-text"
							oninput="textareaNum(this,'textareaNum1')" autocomplete="off"
							style="width:630px;height:60px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:7px; margin-bottom:0px;">${applyBean.reason }</textarea>
					</td>
				</tr>
				<tr class="trbody">
					<td class="td1" style="width: 70px;"><span class="style1">*</span> 经办人</td>
					<td class="td2" >
					<input class="easyui-textbox" readonly="readonly" value="${applyBean.userNames}" style="width: 265px;height: 30px;margin-left: 10px " >
					</td>
					<td class="td1" style="width: 70px;"><span class="style1">*</span> 经办部门</td>
					<td class="td2" >
					<input class="easyui-textbox" readonly="readonly" value="${applyBean.deptName}" style="width: 267px;height: 30px;margin-left: 10px " >
					</td>
				</tr>
			</table>
		</div>				
	</div>
	<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 695px">
		<div title="行程清单" data-options="collapsed:false,collapsible:false"style="overflow:auto;width: 695px">
			<div style="overflow:auto;margin-top: 0px;">
				<jsp:include page="apply_travel_itinerary_detail.jsp" />
			</div>
			<div style="margin-top: 20px">
				<div style="color: red;">${applyBean.fHotelHint}</div>
				<div style="color: red;">${applyBean.fTrafficHint}</div>
			</div>
		</div>
	</div>
	<!-- 审批记录 -->
	<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 695px">
		<div title="审批记录" data-options=" collapsible:false" style="overflow:auto;">
			<!-- <div class="window-title"> 审批记录</div> -->
				<jsp:include page="../../../check_history_reim_apply.jsp" />
		</div>
	</div>	
