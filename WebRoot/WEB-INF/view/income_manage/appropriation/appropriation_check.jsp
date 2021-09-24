<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<form id="appropriation_check_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div">
				<!-- 隐藏域 --> 
				<!-- 主键ID --><input type="hidden" name="aId" value="${bean.aId}" />
				<!-- 申请人id --><input type="hidden" name="fOperatorId" value="${bean.fOperatorId }"/>
				<!-- 申请部门id --><input type="hidden" name="fDeptId" value="${bean.fDeptId }"/>
				
				<!-- 审批状态 --><input type="hidden" name="fFlowStatus" value="${bean.fFlowStatus}" id="appropriationFlowStauts" />
				<!-- 状态 --><input type="hidden" name="fStatus" value="${bean.fStatus}" />
				<!-- 确认状态 --><input type="hidden" name="fConfirmStatus" value="${bean.fConfirmStatus}" />
				
				<!-- 下节点审批人id -->	<input type="hidden" name="fNextUserId" value="${bean.fNextUserId }"/>
				<!-- 下节点审批人姓名 -->	<input type="hidden" name="fNextUserName" value="${bean.fNextUserName }"/>
				<!-- 下节点节点编码 --><input type="hidden" name="fNextCode" value="${bean.fNextCode}" />
				<input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
				<input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
				<!-- 审批附件 --><input type="hidden" name="spjlFile" value=""/>
				
				
				<!-- 基本信息 -->
				<div id="sqsqjbxx" style="overflow:auto;margin-top: 0px;">			
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
						<tr class="trbody">
							<td class="td1" >
								<span class="style1">*</span>登记单号
							</td>
							<td class="td2">
								<input class="easyui-textbox" id="registerCode"
								name="registerCode" readonly="readonly" value="${bean.registerCode}"
								style="width: 200px;height: 30px;margin-left: 10px ">
							</td>
							<td class="td1"><span class="style1">*</span> 登记日期</td>
							<td class="td2">
								<!-- <input class="easyui-datetimebox" style="width: 200px; height: 30px;" id="fApplyDate" name="fApplyDate"/> -->
								<input name="fApplyDate" id="fApplyDate" value="${bean.fApplyDate}" class="easyui-datebox" style="width:200px;height:30px"/>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" ><span class="style1">*</span>
								登记部门</td>
							<td class="td2"><input class="easyui-textbox" id="fDeptName"
								name="fDeptName" readonly="readonly" value="${bean.fDeptName}"
								style="width: 200px;height: 30px;margin-left: 10px "></td>
							<td class="td1" ><span class="style1">*</span>
								登记人</td>
							<td class="td2"><input class="easyui-textbox" id="fOperatorName"
								name="fOperatorName" readonly="readonly" value="${bean.fOperatorName}"
								style="width: 200px;height: 30px;margin-left: 10px "></td>
						</tr>
						<tr class="trbody">
							<td class="td1" ><span class="style1">*</span> 拨款收入类型</td>
							<td class="td2">
								<input id="fundType" class="easyui-combobox" style="width: 200px; height: 30px;" name="fundType" value="${bean.fundType}" required="required" readonly="readonly"
									data-options="prompt: '-请选择-' ,valueField: 'fundType',textField: 'value',editable: false,
									data: [{fundType: '1',value: '财政拨款收入'},{fundType: '2',value: '上级拨款收入'},{fundType: '3',value: '非同级财政收入'}]"/>
							</td>
							<td class="td1"></td>
							<td class="td2" style="width: 200px;">
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 来款项目名称</td>
							<td colspan="3">
								<input class="easyui-textbox" style="width: 550px; height: 30px;" name="projectName" readonly="readonly"
								value="${bean.projectName}" required="required" data-options="validType:'length[1,100]'"/>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span>依据及简要说明</td>
							<td colspan="3"><input class="easyui-textbox"
								data-options="multiline:true,required:true,validType:'length[0,250]'"
								name="remark" style="width:550px;height:70px;"
								value="${bean.remark }" readonly="readonly"></td>
						</tr>
					</table>
				</div>				
				</div>
				</div>
				
				<!-- 来款明细 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 40px">
					<div title="来款明细" data-options="collapsible:false" style="overflow:auto;">
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="appropriation_info_add.jsp" />
						</div>
						<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
						<tr>
							<td class="td1" style="width:55px;text-align: left"><span class="style1">*</span>
								附件:
								<input type="file" multiple="multiple" id="f" onchange="upladFile(this,null,'bklsr')" hidden="hidden">
								<input type="text" id="files" name="files" hidden="hidden">
							</td>
							<td colspan="3" id="tdf">
								<c:forEach items="${attaList}" var="att">
									<div style="margin-top: 5px;">
									<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
									</div>
								</c:forEach>
							</td>
						</tr>
					</table>
					</div>
				</div>
				<c:if test="${operation!='add' }">
				<!-- 审批记录 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 40px">
					<div title="审批记录" data-options="collapsible:false" style="overflow:auto;padding:10px;">
						<!-- <div class="window-title"> 审批记录</div> -->
						<jsp:include page="../../check_history.jsp" />
					</div>
				</div>
				</c:if>
			</div>
			
			<div class="window-left-bottom-div" style="margin-top: 55px;">
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
		<c:if test="${type!=1 }">
			<div class="window-right-div" style="width:254px;height: auto;padding-bottom: 20px;">
				<jsp:include page="../../check_system.jsp" />
			</div>
		</c:if>
	</div>
</form>

<script type="text/javascript">

//显示详细信息手风琴页面
$(document).ready(function() {
	$('#fApplyDate').attr("readonly","readonly");
	//$('#fApplyDate').datetimebox().datetimebox('setValue', formatterDate(new Date()));
	
});

function formatterDate(date){
	var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
	var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
	+ (date.getMonth() + 1);
	var hor = date.getHours();
	var min = date.getMinutes();
	var sec = date.getSeconds();
	return date.getFullYear() + '-' + month + '-' + day+" "+hor+":"+min+":"+sec;
}

//送审
function check(result) {
	$('#appropriation_check_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}
			return flag;
		},
		url : base + '/appropriation/checkResult',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#appropriation_check_form').form('clear');
				$('#appropriationTab').datagrid('reload');
				$('#indexdb').datagrid('reload');
				closeWindow();
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});  
}
</script>