<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<script type="text/javascript">
//显示详细信息手风琴页面
$(document).ready(function() {
	
});

//审批
function check(result) {
		/* //设置审批状态
		$('#accountsFlowStauts').val(result);
		//设置申请状态
		$('#accountsStauts').val(result); */
		$('#accounts_register_check_form').form('submit', {
			onSubmit:function(){
				$.messager.progress();
			},
			url : base + '/accountsRegisterCheck/checkResult',
			success : function(data) {
				$.messager.progress('close');
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$('#accounts_register_check_form').form('clear');
					$('#accountsRegisterCheckTab').datagrid('reload');
					$('#indexdb').datagrid('reload');
					closeWindow();
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
</script>
<form id="accounts_register_check_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;"">
			<div class="win-left-top-div">
				<!-- 隐藏域 --> 
				<!-- 主键 ID --><input type="hidden" id="fMSId" name="fMSId" value="${bean.fMSId}" />
				<!-- 主键 ID --><input type="hidden" id="fAcaId" name="fAcaId" value="${bean.fAcaId}" />
				<!-- 合同 ID --><input type="hidden" id="conId" name="conId" value="${bean.conId}" />
				<%-- <!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="applyflowStauts" />
				<!-- 申请状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="applyStauts" /> --%>
				<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
				<input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
				<input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
				<!-- 审批附件 --><input type="hidden" name="spjlFile" id="spjlFile" value=""/>
				<!-- 流程id  --><input type="hidden" id="flowId"  value="${fpId}"/>
				<!-- 下一级审批节点  --><input type="hidden" id="nextKey"  value="${bean.nCode}"/>
				<!-- 基本信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="基本信息" data-options="collapsed:false,collapsible:false"style="overflow:auto;">
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
						<tr class="trbody">
							<td class="td1" style="width: 120px;"><span class="style1">*</span> 登记单号</td>
							<td class="td2" >
								<input class="easyui-textbox" id="registerCode" name="registerCode" readonly="readonly" value="${bean.registerCode}" style="width: 237px;height: 30px;margin-left: 10px " >
							</td>
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 登记日期</td>
							<td class="td2" >
								<input class="easyui-datebox" id="reqTime" name="reqTime" readonly="readonly" value="${bean.reqTime}" style="width: 244px;height: 30px;margin-left: 10px " >
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 登记部门</td>
							<td class="td2" >
								<input class="easyui-textbox" id="deptName" name="deptName" readonly="readonly" value="${bean.deptName}" style="width: 237px;height: 30px;margin-left: 10px " >
							</td>
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 登记人</td>
							<td class="td2" >
								<input class="easyui-textbox" id="userName" name="userName" readonly="readonly" value="${bean.userName}" style="width: 244px;height: 30px;margin-left: 10px " >
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 来款项目名称</td>
							<td colspan="3">
								<input class="easyui-textbox" style="width: 570px;height: 30px; " value="${bean.proName}" id="proName" name="proName" readonly="readonly" required="required" data-options="prompt:'请选择来款项目名称'"/>
								<input value="${bean.proCode}" id="proCode" name="proCode" hidden="hidden"/>
							</td>
						</tr>
						<tr class="trbody" style="line-height: 0px">
							<td class="td1"><span class="style1">*</span> 依据及简要说明</td>
							<td colspan="3">
								<textarea name="contenExplain" id="reason" class="textbox-text" readonly="readonly"
										oninput="textareaNum(this,'textareaNum1')" autocomplete="off" 
										style="width:564px;height:70px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:3px; margin-bottom:0px;">${bean.contenExplain}</textarea>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1"><span class="style1"> </span> 合同编号</td>
							<td colspan="3">
								<input class="easyui-textbox" style="width: 570px;height: 30px; " readonly="readonly" value="${bean.conCode}" id="conCode" name="conCode" required="required" data-options="prompt:'请选择合同编号'"/>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1"><span class="style1"> </span> 合同名称</td>
							<td colspan="3">
								<input class="easyui-textbox" style="width: 570px;height: 30px; " value="${bean.conName}" id="conName" name="conName" required="required" readonly="readonly" data-options="prompt:'请选择合同名称'"/>
							</td>
						</tr>
					</table>
				</div>				
				</div>
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;height: 200px">
				<div title="来款明细" data-options="collapsed:false,collapsible:false"style="overflow:auto;">
					<div style="overflow:auto;margin-top: 20px;">
						<jsp:include page="../add/accounts_register_lkmx.jsp" />
					</div>
					<table style="margin-top: 20px">
						<tr>
							<td class="td1" style="width:55px;text-align: right"> 附件 </td>
							<td colspan="3" id="tdf">
								&nbsp;&nbsp;
								<c:forEach items="${attaList}" var="att">
									<div style="margin-top: 5px;">
									<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
									&nbsp;&nbsp;&nbsp;&nbsp;
									</div>
								</c:forEach>
							</td>
						</tr>
					</table>
				</div>
				</div>
				<c:if test="${operation!='add' }">
				<!-- 审批记录 -->
				<div class="easyui-accordion" style="">
					<div title="审批记录" data-options="collapsible:false" style="overflow:auto;padding:10px;">
						<c:if test="${type!=1 }">
							<jsp:include page="../../../check_history.jsp" />
						</c:if>												
					</div>
				</div>
				</c:if>
			</div>
			<div class="window-left-bottom-div" style="margin-top: 55px;">
				<a href="javascript:void(0)" onclick="openCheckWin('审批意见','1')">
					<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="openCheckWin('审批意见','0')">
					<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				&nbsp;&nbsp;
				<a href="${base }/systemcentergl/list?typeStr=支出管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		<div class="window-right-div" style="width:254px;height:490px">
			<jsp:include page="../../../check_system.jsp" />
		</div>
	</div>
</form>
