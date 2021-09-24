<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
	<form id="researchProjects_check_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
		<div class="window-div">
			<div class="window-left-div" style="width:765px;height: 450px;border: 1px solid #D9E3E7;margin-top: 20px;">
				<div class="win-left-top-div">
					<!-- 隐藏域 --> 
					<input type="hidden" name="nCode" value="${bean.nCode}"/>
					<input type="hidden" name="fpCode" value="${bean.fpCode}"/>
					<input type="hidden" name="fpId"  value="${bean.fpId}"/>
					<input type="hidden" name="fUser"  value="${bean.fUser}"/>
					<input type="hidden" name="fDeptId"  value="${bean.fDeptId}"/>
					<input type="hidden" name="flowStatus" id="flowStatus" value="${bean.flowStatus}"/>
					<input type="hidden" name="status" id="status" value="${bean.status}"/>
					<input type="hidden" name="projectMemberId" id="projectMemberId" value="${bean.projectMemberId}"/>
					<!-- 审批结果 --><input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
					<!-- 审批意见 --><input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
					<!-- 审批附件 --><input type="hidden" name="spjlFile" id="spjlFile" value=""/>
					<!-- 下一级审批节点  --><input type="hidden" id="nextKey"  value="${bean.nCode}"/>
					<!--历史审批节点  --><input type="hidden" id="historyNodes"  value="${historyNodes}"/>
					<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
						<div title="基本信息" data-options=" collapsible:false" style="overflow:auto;">
							<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
								<tr class="trbody">
								
									<td class="td1">&nbsp;登记编号</td>
									<td class="td2">
										<input class="easyui-textbox" type="text" id="f_fpCode" readonly="readonly" required="required" name="fpCode" data-options="" style="width: 220px;height: 30px" value="${bean.fpCode}"/>
									</td>
									
									<td class="td1">&nbsp;登记日期</td>
									<td class="td2">
										<input id="f_fReqTime" class="easyui-datebox" readonly="readonly" required="required" name="fReqTime" data-options="" style="width: 220px;height: 30px" value="${bean.fReqTime}"/>
									</td>
									
								</tr>
								<tr class="trbody">
								
									<td class="td1">&nbsp;登记部门</td>
									<td class="td2">
										<input class="easyui-textbox" type="text" id="f_fDeptName" readonly="readonly" required="required" name="fDeptName" data-options="" style="width: 220px;height: 30px" value="${bean.fDeptName}"/>
									</td>
									
									<td class="td1">&nbsp;登记人</td>
									<td class="td2">
										<input id="f_fUserName" class="easyui-textbox" type="text" readonly="readonly" required="required" name="fUserName" data-options="" style="width: 220px;height: 30px" value="${bean.fUserName}"/>
									</td>
									
								</tr>
								<tr class="trbody">
								
									<td class="td1"><span class="style1">*</span>&nbsp;项目编号</td>
									<td class="td2">
										<input class="easyui-textbox" type="text" id="f_projectCode" readonly="readonly" required="required" name="projectCode" data-options="" style="width: 220px;height: 30px" value="${bean.projectCode}"/>
									</td>
									
									<td class="td1"><span class="style1">*</span>&nbsp;项目名称</td>
									<td class="td2">
										<input id="f_projectName" class="easyui-textbox" type="text" readonly="readonly" required="required" name="projectName" data-options="" style="width: 220px;height: 30px" value="${bean.projectName}"/>
									</td>
									
								</tr>
								<tr class="trbody">
								
									<td class="td1"><span class="style1">*</span>&nbsp;项目负责人</td>
									<td class="td2">
										<input class="easyui-textbox" type="text" id="f_projectUser" readonly="readonly" required="required" name="projectUser" data-options="" style="width: 220px;height: 30px" value="${bean.projectUser}"/>
									</td>
									
									<td class="td1"><span class="style1">*</span>&nbsp;项目组成员</td>
									<td class="td2">
										<input id="f_projectMember" class="easyui-textbox" type="text" readonly="readonly" required="required" name="projectMember" data-options="validType:'length[1,200]',editable:false,icons:[{iconCls:'icon-add',handler: function(e){
					   							  selectProjectMember();
					   								  }}]" style="width: 220px;height: 30px" value="${bean.projectMember}"/>
									</td>
									
								</tr>
								<tr class="trbody">
								
									<td class="td1"><span class="style1">*</span>&nbsp;项目经费金额</td>
									<td class="td2">
										<input class="easyui-numberbox" type="text" id="f_amount" readonly="readonly" required="required" name="amount" data-options="" style="width: 220px;height: 30px" value="${bean.amount}"/>
									</td>
									<td class="td1">&nbsp;&nbsp;科研类型</td>
									<td class="td2">
										<input id="f_researchType" class="easyui-combobox" readonly="readonly" name="researchType" data-options="editable:false,url:'${base}/Formulation/lookupsJson?parentCode=KYJFLX&selected=${bean.researchType}',method:'POST',valueField:'code',textField:'text'" style="width: 220px;height: 30px" value="${bean.researchType}"/>
									</td>
								</tr>
								<tr class="trbody">
								
									<td class="td1">&nbsp;&nbsp;校外人员</td>
									<td class="td2" colspan="3">
										<input class="easyui-textbox" type="text" id="f_offCampusPersonnel" readonly="readonly" name="offCampusPersonnel" data-options="" style="width: 575px;height: 30px" value="${bean.offCampusPersonnel}"/>
									</td>
								</tr>
							</table>
						</div>
					</div>
					
					<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
						<div title="附件信息" data-options="collapsible:false"
							style="overflow:auto;">		
							<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
								<tr>
									<td class="td1" style="width:55px;text-align: left">
										附件:
									</td>
									<td colspan="3" id="tdf">
										<c:forEach items="${attaList}" var="att">
											<div style="margin-top: 5px;">
											<c:if test="${att.serviceType=='null'}">
											<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
											&nbsp;&nbsp;&nbsp;&nbsp;
											</c:if>
											</div>
										</c:forEach>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				
				<div class="window-left-bottom-div" style="margin-top: 10px;">
					<a href="javascript:void(0)" onclick="openCheckWin('审批意见','1')">
						<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="openCheckWin('审批意见','0')">
						<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;
					<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</div>
				
			</div>
			
			<div class="window-right-div" id="check_system_div" style="width:254px;height: auto;padding-bottom: 20px;">
				<jsp:include page="../../check_system.jsp" />
			</div>
			
		</div>
	</form>

<script type="text/javascript">
//保存
function check(status) {
	//提交
	$('#researchProjects_check_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			 if (flag) {
				//如果校验通过，则进行下一步
				$.messager.progress();
			}else{
				//校验不通过，就打开第一个校验失败的手风琴
				openAccordion();
			}
			return flag;
		},
		url : base + '/researchProjects/checkResult',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			} 
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#researchProjects_check_tab').datagrid('reload');
				$('#indexdb').datagrid('reload');
				closeWindow();
				
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});
}

function selectProjectMember() {
	var peopId = $('#projectMemberId').val();
	var win = creatFirstWin('选择-人员', 640, 580, 'icon-search', '/researchProjects/chooseUser?peopId='+peopId);
	win.window('open');

}
</script>
</body>