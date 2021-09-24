<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="refund_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div">
				<!-- 隐藏域 --> 
			    <!-- 立项申请id -->		<input type="hidden" id="F_fRID" name="fRID" value="${bean.fRID }"/>
				<!-- 申请人id -->			<input type="hidden" id="F_fUserId" name="fUserId" value="${bean.fUserId }"/>
				<!-- 申请部门id -->		<input type="hidden" id="F_fDeptId" name="fDeptId" value="${bean.fDeptId }"/>
				<!-- 学生类型 -->			<input type="hidden" id="F_fNewOrOld" name="fNewOrOld" value="${bean.fNewOrOld }"/>
				<!-- 数据状态 -->			<input type="hidden" id="F_stauts" name="stauts" value="${bean.stauts }"/>
				
				<!-- 审批状态 -->			<input type="hidden" id="F_flowStauts" name="flowStauts" value="${bean.flowStauts }"/>
				<!-- 下节点审批人id -->	<input type="hidden" name="fUserId2" value="${bean.fUserId2 }"/>
				<!-- 下节点审批人姓名 -->	<input type="hidden" name="userName2" value="${bean.userName2 }"/>
				<!-- 下节点编码 -->			<input type="hidden" name="nCode" value="${bean.nCode }"/>
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
					<!-- 第一个div -->
					<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
						<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span>&nbsp;申请单号</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fInfoCode" name="fInfoCode" readonly="readonly" required="required" data-options="validType:'length[1,30]'" style="width: 200px; height: 30px;" value="${bean.fInfoCode }"/>
								</td>
								<td class="td1"><span class="style1">*</span>&nbsp;申请部门</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fDeptName" name="fDeptName" readonly="readonly" required="required" data-options="validType:'length[1,30]'" style="width: 200px; height: 30px;" value="${bean.fDeptName }"/>
								</td>
							</tr>
							
							<tr>
								<td class="td1"><span class="style1">*</span>&nbsp;经办人</td>
								<td class="td2">
									<input class="easyui-textbox" id="F_fUserName" name="fUserName" readonly="readonly" required="required" data-options="validType:'length[1,30]'" style="width: 200px; height: 30px;" value="${bean.fUserName }"/>
								</td>
								<td class="td1"><span class="style1">*</span>&nbsp;申请日期</td>
								<td class="td2">
									<input class="easyui-datebox" id="F_fReqTime" name="fReqTime" readonly="readonly" required="required" data-options="validType:'length[1,30]'" style="width: 200px; height: 30px;" value="${bean.fReqTime }"/>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1">
									&nbsp;&nbsp;附件
									<input type="file" multiple="multiple" id="f_refund" onchange="upladFile(this, 'refund', 'refund01')" hidden="hidden">
									<input type="text" id="files" name="files" hidden="hidden">
								</td>
								<td colspan="4" id="tdf">
									<a onclick="$('#f_refund').click()" style="font-weight: bold;" href="#">
										<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
									</a>
									<c:forEach items="${refundAttaList }" var="att">
										<c:if test="${att.serviceType=='refund' }">
										<div style="margin-top: 10px;">
											<a href='${base}/attachment/download/${att.id }' style="color: #666666;font-weight: bold;">${att.originalName }</a>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<a id="${att.id }" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
										</div>
										</c:if>
									</c:forEach>
									<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
										<div id="progressNumber" style="background:#3AF960;width:0px;height:10px"></div>
										文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
									</div>
								</td>
							</tr>
						</table>
					</div>
					</div>
					<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
						<div title="退费明细表" data-options="collapsed:false,collapsible:false" style="overflow:auto;" >
							<%@ include file="refund_add_mingxi_old.jsp" %>
						</div>
					</div>
					
					<c:if test="${openType != 'add' }">
						<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
							<div title="审批记录" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
								<jsp:include page="../../../check_history.jsp" />												
							</div>
						</div>
					</c:if>
				</div>
			
			<div class="window-left-bottom-div" style="margin-top: 55px;">
				<a href="javascript:void(0)" onclick="saveIncome(0)">
					<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveIncome(1)">
					<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<div class="window-right-div" style="width:254px;height: auto;padding-bottom: 20px;">
			<jsp:include page="../../../check_system.jsp" />
		</div>
	</div>
</form>
</div>
<script type="text/javascript">
$(document).ready(function(){
	var myDate = new Date();
	myDate = myformatter(myDate);
	$('#F_fReqTime').textbox().textbox('setValue', myDate);
});

//保存
function saveIncome(status) {
	//设置数据状态
	$('#F_stauts').val(status);
	//设置审批状态
	$('#F_flowStauts').val(status);
	//设置学生类型 0-新生	1-老生
	$('F_fNewOrOld').val();
	
	//明细表
	getMingxiJson();
	
	//附件的路径地址
	var s = "";
	$(".fileUrl").each(function(){
		s = s + $(this).attr("id") + ",";
	});
	$("#files").val(s);
	
	//提交
	$('#refund_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}
			return flag;
		},
		url : base + '/refund/save',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#refund_form').form('clear');
				$('#refund_tab').datagrid('reload');
				closeWindow();
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});  
}
</script>
</body>