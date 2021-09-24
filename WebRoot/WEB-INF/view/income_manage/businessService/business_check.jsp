<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<form id="business_check_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 451px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div">
			<!-- 隐藏域 --> 
								    <!-- 立项申请id -->		<input type="hidden" id="F_fBusiId" name="fBusiId" value="${bean.fBusiId }"/>
									<!-- 申请人id -->			<input type="hidden" id="F_fOperatorId" name="fOperatorId" value="${bean.fOperatorId }"/>
									<!-- 申请部门id -->		<input type="hidden" id="F_fDeptId" name="fDeptId" value="${bean.fDeptId }"/>
									<!-- 数据状态 -->			<input type="hidden" id="F_fStatus" name="fStatus" value="${bean.fStatus }"/>
									
									<!-- 下节点审批人id -->	<input type="hidden" name="fNextUserId" value="${bean.fNextUserId }"/>
									<!-- 下节点审批人姓名 -->	<input type="hidden" name="fNextUserName" value="${bean.fNextUserName }"/>
									<!-- 下节点编码 -->			<input type="hidden" name="fNextCode" value="${bean.fNextCode }"/>
									<!-- 审批状态 -->			<input type="hidden" id="F_fFlowStatus" name="fFlowStatus" value="${bean.fFlowStatus }"/>
									<!-- 审批结果 -->			<input type="hidden" id="fcheckResult" name="fcheckResult" value=""/>
									<!-- 审批意见 -->			<input type="hidden" id="fcheckRemake" name="fcheckRemake" value=""/>
									<!-- 审批附件 -->			<input type="hidden" id="spjlFile" name="spjlFile" value=""/>
			<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="基本信息" data-options="collapsible:false" style="overflow:auto;">
						<table class="win-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
							<tr class="trbody">
								<td class="td1"  style="width: 70px"><span class="style1">*</span>&nbsp;立项编号</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fBusiCode" name="fBusiCode" readonly="readonly" required="required" data-options="validType:'length[1,30]'" style="width: 210px; height: 30px;" value="${bean.fBusiCode }"/>
								</td>
								<td class="td1"><span class="style1">*</span>&nbsp;申请日期</td>
								<td class="td2">
									<input class="easyui-datebox" id="F_fBusiTime" name="fBusiTime" readonly="readonly" required="required" data-options="validType:'length[1,30]'" style="width: 210px; height: 30px;" value="${bean.fBusiTime }"/>
								</td>
								
							</tr>
							
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;申请部门</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fDeptName" name="fDeptName" readonly="readonly" required="required" data-options="validType:'length[1,30]'" style="width: 210px; height: 30px" value="${bean.fDeptName }"/>
								</td>
								<td class="td1"><span class="style1">*</span>&nbsp;申请人</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fOperatorName" name="fOperatorName" readonly="readonly" required="required" data-options="validType:'length[1,30]'" style="width: 210px; height: 30px" value="${bean.fOperatorName }"/>
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
									<input class="easyui-textbox" id="F_fRemark" name="fRemark" readonly="readonly" data-options="validType:'length[1,500]',multiline:true" style="width: 555px; height: 70px" value="${bean.fRemark }"/>
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
				<%-- <div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
						<div title="三重一大会议信息" data-options="collapsible:false" style="overflow:auto; ">
							<jsp:include page="check_meeting_infomation.jsp" />
						</div>
				</div> --%>	
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
				<a href="http://111.202.125.165:8083${base}/business/print/${bean.fBusiId }" target="blank" >
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
	
//送审
function check(result) {
	/* if(${!empty xzbgsFile}){
		var meetingSummaryYear1 =$('#meetingSummaryYear1').val();
		var meetingSummaryTime1 =$('#meetingSummaryTime1').val();
		if(meetingSummaryYear1==''||meetingSummaryTime1==''){
			alert('请填写校长办公会会议纪要信息');
			return false;
		}
		var s1="";
		$(".xzbgsfileUrl").each(function(){
			s1=s1+$(this).attr("id")+",";
		});
		if(s1==''){
			alert('请上传校长办公会会议纪要附件');
			return false;
		}
	}
	if(${!empty dwhFile}){
		var meetingSummaryYear2 =$('#meetingSummaryYear2').val();
		var meetingSummaryTime2 =$('#meetingSummaryTime2').val();
		if(meetingSummaryYear2==''||meetingSummaryTime2==''){
			alert('请填写党委会会议纪要信息');
			return false;
		}
		var s2="";
		$(".dwhfileUrl").each(function(){
			s2=s2+$(this).attr("id")+",";
		});
		if(s2==''){
			alert('请上传党委会会议纪要附件');
			return false;
		}
	} */
	$('#business_check_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}
			return flag;
		},
		url : base + '/business/checkResult',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#business_check_form').form('clear');
				$('#business_tab').datagrid('reload');
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