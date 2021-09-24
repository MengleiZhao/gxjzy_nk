<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<script type="text/javascript">
//显示详细信息手风琴页面
$(document).ready(function() {
	
});

//保存
function saveApply(flowStauts) {
	var reasonString = $("#reason").val();
	if(reasonString==''){
		alert('请填写内容说明！');
		return false;
	}
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);
	//设置审批状态
	$('#applyflowStauts').val(flowStauts);
	//设置申请状态
	$('#applyStauts').val(flowStauts);
	//提交
	$('#accounts_save_form').form('submit', {
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
		url : base + '/accountsCurrent/saveAccounts',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#accountsTab').datagrid('reload');
				$('#indexdb').datagrid('reload');
				closeWindow();
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});
}

</script>
<form id="accounts_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;"">
			<div class="win-left-top-div">
				<!-- 隐藏域 --> 
				<!-- 主键ID --><input type="hidden" name="fAcaId" value="${bean.fAcaId}" />
				<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="applyflowStauts" />
				<!-- 申请状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="applyStauts" />
				<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
				<!-- 流程id  --><input type="hidden" id="flowId"  value="${fpId}"/>
				<!--历史审批节点  --><input type="hidden" id="historyNodes"  value="${historyNodes}"/>
				<!-- 下一级审批节点  --><input type="hidden" id="nextKey"  value="${bean.nCode}"/>
				<!-- 基本信息 -->
				<div id="sqsqjbxx" style="overflow:auto;margin-top: 0px;">
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="基本信息" data-options="collapsed:false,collapsible:false"style="overflow:auto;">
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 申请单号</td>
							<td class="td2" >
								<input class="easyui-textbox" id="proCode" name="proCode" readonly="readonly" value="${bean.proCode}" style="width: 247px;height: 30px;margin-left: 10px " >
							</td>
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 申请日期</td>
							<td class="td2" >
								<input class="easyui-datebox" id="reqTime" name="reqTime" readonly="readonly" value="${bean.reqTime}" style="width: 247px;height: 30px;margin-left: 10px " >
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 部门名称</td>
							<td class="td2" >
								<input class="easyui-textbox" id="deptName" name="deptName" readonly="readonly" value="${bean.deptName}" style="width: 247px;height: 30px;margin-left: 10px " >
							</td>
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 经办人</td>
							<td class="td2" >
								<input class="easyui-textbox" id="userName" name="userName" readonly="readonly" value="${bean.userName}" style="width: 247px;height: 30px;margin-left: 10px " >
							</td>
							
						</tr>
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 项目名称</td>
							<td colspan="3">
								<input class="easyui-textbox" style="width: 590px;height: 30px; " value="${bean.proName}" id="proName" name="proName" required="required" data-options="validType:'length[1,50]'"/>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span>内容说明</td>
							<td colspan="3">
								<textarea name="contenExplain" id="reason" class="textbox-text" 
										oninput="textareaNum(this,'textareaNum1')" autocomplete="off" 
										style="width:584px;height:70px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:8px; margin-bottom:0px;">${bean.contenExplain}</textarea>
							</td>
						</tr>
						<tr>
							<td class="td1" style="width:55px;text-align: right">
								附件
								<input type="file" multiple="multiple" id="f" onchange="upladFile(this,null,'srgl01')" hidden="hidden">
								<input type="text" id="files" name="files" hidden="hidden">
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
								<c:forEach items="${attaList}" var="att">
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
				<a href="javascript:void(0)" onclick="saveApply(0)">
				<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveApply(1)">
				<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				&nbsp;&nbsp;
				<a href="${base }/systemcentergl/list?typeStr=支出管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		<div class="window-right-div" style="width:254px;height: auto;padding-bottom: 20px;">
			<jsp:include page="../../../check_system.jsp" />
		</div>
	</div>
</form>
