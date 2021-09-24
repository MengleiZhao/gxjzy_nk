<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body>
<style type="text/css">
/*---滚动条默认显示样式--*/
::-webkit-scrollbar-thumb {
background-color: #e5f0f6;
height: 50px;
outline-offset: -2px;
outline: 2px solid #fff;
-webkit-border-radius: 15px;
border: 2px solid #fff;
}
	
/*---鼠标点击滚动条显示样式--*/
::-webkit-scrollbar-thumb:hover {
background-color: #cfdde4;
height: 50px;
-webkit-border-radius: 15px;
}
	
/*---滚动条大小--*/
::-webkit-scrollbar {
width: 16px;
height: 12px;
}
	
/*---滚动框背景样式--*/
::-webkit-scrollbar-track-piece {
background-color: #fff;
-webkit-border-radius: 0;
}

</style>
<link rel="stylesheet" type="text/css" href="${base}/resource/ui/themes/first/style-new.css"/>
<div class="win-div">
<form id="reimburse_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="easyAcc" style="width:662px;margin-left: 20px">
					<div title="基本信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable">
							<tr class="trbody">
								<td class="td1">报销单编号</td>
								<td colspan="4">
									<a href="#" onclick="opeanQRecode('${bean.rCode}')">
									<input style="width: 555px;"name="gCode" class="easyui-textbox" id="gCode"
									value="${bean.rCode}" data-options="icons: [{iconCls:'icon-qrcode'}]"
									readonly="readonly"/>
									</a>
								</td>
							</tr>
							
							<tr class="trbody">
								<td class="td1">报销摘要</td>
								<td colspan="4">
									<input style="width: 555px;" name="gName" class="easyui-textbox"
									value="${bean.gName}" readonly="readonly"/>
								</td>
							</tr>
						
						
							<tr class="trbody">
								<td class="td1">报销人</td>

								<td class="td2">
									<input style="width: 200px;" class="easyui-textbox"
									value="${bean.userName}" readonly="readonly"></input>
								<td class="td4">
									<!-- 隐藏域 --> 
									<!-- 主键ID --><input type="hidden" name="rId" value="${bean.rId}" id="rId"/>
									<!-- 报销单号 --><input type="hidden" name="rCode" value="${bean.rCode}" id="rId"/>
									<!-- 收款人主键ID --><input type="hidden" name="pId" value="${payeeBean.pId}"/>
									<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="reimburseFlowStauts" />
									<!-- 报销状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="reimburseStauts" />
									<!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}" />
									<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" />
									<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
									<!-- 报销类型 --><input type="hidden" id="reimburseTypeHi" value="${bean.type}" />
									<!-- 指标ID --><input type="hidden" name="indexId" value="${bean.indexId}" id=""/>
									<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id=""/>
								</td>

								<td class="td1">报销部门</td>
								<td class="td2">
									<input style="width: 200px;" class="easyui-textbox"
									value="${bean.deptName}" readonly="readonly"></input></td>
							</tr>

							<tr class="trbody">
								<td class="td1">报销事项</td>
								<td class="td2">
								<select id="reimburseType" class="easyui-combobox" name="type" style="width: 200px;">
										<option value="1">通用事项报销</option>
										<option value="2">会议报销</option>
										<option value="3">培训报销</option>
										<option value="4">差旅报销</option>
										<option value="5">公务接待报销</option>
										<option value="6">公务用车报销</option>
										<option value="7">公务出国报销</option>
								</select></td>

								<td style="width: 0px"></td>

								<td class="td1">报销时间</td>

								<td class="td2"><input style="width: 200px;"
									id="reimburseReqTime" name="reimburseReqTime" class="easyui-datebox"
									readonly="readonly" value="${bean.reimburseReqTime}"></input></td>
							</tr>

							<tr class="trbody">
								<td class="td1">支出项目</td>
								<td class="td2"><input type="text" style="width: 200px;"
									name="indexName" class="easyui-textbox"
									value="${bean.indexName}" id="" readonly="readonly"/>
								</td>

								<td style="width: 0px"></td>
								
								<td class="td1">报销总额</td>
								<td class="td2">
									<input class="easyui-numberbox"  style="width: 200px;" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]"
									value="${bean.amount}" readonly="readonly">
								</td>
							</tr>

							<tr class="trbody">
								<td class="td1">附件</td>
								<td colspan="4">
									<c:if test="${!empty attaList}">
									<c:forEach items="${attaList}" var="att">
										<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;margin-left: 8px">${att.originalName}</a><br>
									</c:forEach>
									</c:if>
									<c:if test="${empty attaList}">
										<span style="color:#999999">暂未上传附件</span>
									</c:if>
								</td>
							</tr>
							

							<tr style="height: 70px;">
								<td class="td1" valign="top"><p style="margin-top: 8px">报销事由</p></td>
								<td colspan="4">
									<input class="easyui-textbox"data-options="multiline:true" name="reimburseReason" style="width:555px;height:70px;" value="${bean.reimburseReason}" readonly="readonly">
								</td>
							</tr>
						</table>
					</div>


					<div title="会议信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../../apply/check/meetingCheck.jsp" />
					</div>
	
					<div title="培训信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../../apply/check/trainingCheck.jsp" />
					</div>
	
					<div title="差旅信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../../apply/check/travelCheck.jsp" />
					</div>
	
					<div title="接待信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../../apply/check/receptionCheck.jsp" />
					</div>
					
					<div title="接待人员名单" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../../apply/add/reception_people.jsp" />
					</div>
					
					<div title="公务用车信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../../apply/check/officeCarCheck.jsp" />
					</div>
					
					<div title="公务出国信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../../apply/check/abroadCheck.jsp" />
					</div>
	
					<div title="报销明细" data-options="iconCls:'icon-xxlb'"
						style="overflow:auto;margin-top: 10px;">
						<jsp:include page="reimburse_mingxi.jsp" />
					</div>
					
					<div title="发票信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="reimburse_invoice.jsp" />
					</div>
					
					<div title="收款人信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../../payee-info-detail.jsp" />
					</div>
					
					<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../../../check_history.jsp" />												
					</div>
						
				</div>
			
		
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="closeSearchDateWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../../check_system.jsp" />
		</div>
	</div>
</form>
</div>
<script type="text/javascript">
//显示详细信息手风琴页面
$(document).ready(function() {
	//设值时间
	if ($("#rId").val() == "") {
		$("#reimburseReqTime").textbox().textbox('setValue', 'date');
	}

	var h = $("#reimburseTypeHi").textbox().textbox('getValue');
	if (h != "") {
		$('#reimburseType').textbox().textbox('setValue', h);
		$('#reimburseType').textbox().attr('readonly', true);
	}

	if (h == 1) {
		$("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息');
	}
	if (h == 2) {
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息');
	}
	if (h == 3) {
		$("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息');
	}
	if (h == 4) {
		$("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息');
	}
	if (h == 5) {
		$("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息');
	}
	if (h == 6) {
		$("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息');
	}
	if (h == 7) {
		$("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
	}
});





</script>
</body>

