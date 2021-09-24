<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<form id="business_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 451px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div">
			<!-- 隐藏域 --> 
								    <!-- 立项申请id -->		<input type="hidden" id="F_fBusiId" name="fBusiId" value="${bean.fBusiId}"/>
									<!-- 申请人id -->			<input type="hidden" id="F_fOperatorId" name="fOperatorId" value="${bean.fOperatorId}"/>
									<!-- 申请部门id -->		<input type="hidden" id="F_fDeptId" name="fDeptId" value="${bean.fDeptId}"/>
									
									<!-- 审批状态 -->			<input type="hidden" id="F_flowStauts" name="fFlowStauts" value="${bean.fFlowStatus }"/>
									<!-- 下节点审批人id -->	<input type="hidden" name="fNextUserId" value="${bean.fNextUserId }"/>
									<!-- 下节点审批人姓名 -->	<input type="hidden" name="fNextUserName" value="${bean.fNextUserName }"/>
									<!-- 下节点编码 -->			<input type="hidden" name="fNextCode" value="${bean.fNextCode }"/>
					<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="基本信息" data-options="collapsible:false" style="overflow:auto;">
						<table class="win-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
							<tr class="trbody">
								<td class="td1"  style="width: 70px"><span class="style1">*</span>&nbsp;立项编号</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fBusiCode" name="fBusiCode" readonly="readonly" required="required" data-options="validType:'length[1,30]'" style="width: 213px; height: 30px;" value="${bean.fBusiCode }"/>
								</td>
								<td class="td1"><span class="style1">*</span>&nbsp;申请日期</td>
								<td class="td2">
									<input class="easyui-datebox" id="F_fBusiTime" name="fBusiTime" readonly="readonly" required="required" data-options="validType:'length[1,30]'" style="width: 213px; height: 30px;" value="${bean.fBusiTime }"/>
								</td>
								
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;申请部门</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fDeptName" name="fDeptName" readonly="readonly" required="required" data-options="validType:'length[1,30]'" style="width: 213px; height: 30px" value="${bean.fDeptName }"/>
								</td>
								<td class="td1"><span class="style1">*</span>&nbsp;申请人</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fOperatorName" name="fOperatorName" readonly="readonly" required="required" data-options="validType:'length[1,30]'" style="width: 213px; height: 30px" value="${bean.fOperatorName }"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;立项项目名称</td>
								<td colspan="4">
									<input class="easyui-textbox" id="F_fProName" name="fProName" required="required" readonly="readonly"  style="width: 555px; height: 30px" value="${bean.fProName }"/>
								</td>
							</tr>
							<tr style="height: 5px;"></tr>
							<tr class="trbody">	
								<td class="td1"><span class="style1">*</span>收费标准</td>
								<td colspan="4">
									<input class="easyui-textbox" id="F_fPlanPrice" name="fPlanPrice" required="required" readonly="readonly" data-options="validType:'length[1,500]',multiline:true" style="width: 555px; height: 70px" value="${bean.fPlanPrice }"/>
								</td>
							</tr>
							
							<tr style="height: 5px;"></tr>
							
							<tr class="trbody">	
								<td class="td1"><span class="style1">*</span>收费依据</td>
								<td colspan="4">
									<input class="easyui-textbox" id="F_fProPlan" name="fProPlan" required="required" readonly="readonly" data-options="validType:'length[1,500]',multiline:true" style="width: 555px; height: 70px" value="${bean.fProPlan }"/>
								</td>
							</tr>
							<tr style="height: 5px;"></tr>
							<tr class="trbody">
								<td class="td1">论证资料</td>
								<td colspan="4">
									<input class="easyui-textbox" id="F_fRemark" name="fRemark" required="required"  readonly="readonly" data-options="validType:'length[1,500]',multiline:true" style="width: 555px; height: 70px" value="${bean.fRemark }"/>
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
				<!-- 三重一大会议信息 -->
				<c:if test="${!empty bean.meetingSummaryYear1}">
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="三重一大会议信息" data-options="collapsible:false" style="overflow:auto; ">
						<jsp:include page="check_meeting_infomation_detail.jsp" />
					</div>
				</div>
				</c:if>	
				<!-- 审批记录 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="审批记录" data-options="collapsible:false" style="overflow:auto;">
							<jsp:include page="../../check_history.jsp" />
					</div>
				</div>
				</div>
			
			<div class="window-left-bottom-div" style="margin-top: 15px;">
				<a href="${base}/business/print/${bean.fBusiId }" target="blank" >
					<img src="${base}/resource-modality/${themenurl}/button/dy1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
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
$(document).ready(function(){
	var myDate = new Date();
	myDate = myformatter(myDate);
	$('#F_fBusiTime').textbox().textbox('setValue', myDate);
});
</script>
</body>