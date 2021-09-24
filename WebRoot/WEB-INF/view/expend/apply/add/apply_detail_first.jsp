<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body>
<link rel="stylesheet" type="text/css" href="${base}/resource/ui/themes/cockpit/cockpit.css">
<div class="win-div">
<form id="apply_check_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="easyAcc" style="width:662px;margin-left: 20px;">
					<div title="基本信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<table cellpadding="0" cellspacing="0" class="ourtable">
							<tr class="trbody">
								<td class="td1">申请摘要名称</td>
								<td colspan="4">
									<input class="easyui-textbox" style="width: 555px;" value="${bean.gName}" readonly="readonly"/>
								</td>
							</tr>
						
							<tr class="trbody">
								<td class="td1">申请人</td>

								<td class="td2">
									<input style="width: 200px;" name="user" class="easyui-textbox" 
									value="${bean.userName}" readonly="readonly"/>
								</td>
								
								<td class="td4">
									<!-- 隐藏域 --> 
									<input type="hidden" id="checkTypeHi"value="${bean.type}" />
								</td>

								<td class="td1">申请部门</td>
								<td class="td2">
									<input style="width: 200px;" name="dept" class="easyui-textbox" 
									value="${bean.deptName}" readonly="readonly"/>
								</td>
							</tr>

							<tr class="trbody">
								<td class="td1">申请事项</td>
								<td class="td2">
									<select style="width:200px;" id="applyType" name="type" class="easyui-combobox">
										<option value="1">通用事项申请</option>
										<option value="2">会议申请</option>
										<option value="3">培训申请</option>
										<option value="4">差旅申请</option>
										<option value="5">公务接待申请</option>
										<option value="6">公务用车申请</option>
										<option value="7">公务出国申请</option>
									</select> 
								</td>

								<td style="width: 0px"></td>

								<td class="td1">申请时间</td>

								<td class="td2">
									<input style="width: 200px;" id="applyReqTime" name="reqTime" class="easyui-datebox"
									value="${bean.reqTime}"	readonly="readonly"/>
								</td>
							</tr>

							<tr class="trbody">
								<td class="td1">支出项目</td>
								<td class="td2">
									<input style="width: 200px;" name="indexName" class="easyui-textbox"
									value="${bean.indexName}" readonly="readonly"/>
								</td>
								
								<td class="td4"></td>
								
								<td class="td1">申请总额</td>
								<td class="td2">
									<input style="width: 200px;" class="easyui-numberbox" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]"
									value="${bean.amount}" readonly="readonly">
								</td>
							</tr>
						<tr class="trbody">
							<td class=window-table-td1><span class="style1">*</span>归口部门</td>
							<td colspan="4">
								<input class="easyui-combobox" style="width: 200px;height: 30px; " value="${bean.suggestDepId}" id="suggestDepId" name="suggestDepId" required="required"  data-options="editable:false,panelHeight:'auto',url:'${base}/apply/chooseDepart?selected=${bean.suggestDepId}',method:'POST',valueField:'code',textField:'text',editable:false,validType:'selectValid'"/>
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
								<td class="td1" valign="top"><p style="margin-top: 8px">申请事由</p></td>
								<td colspan="4">
									<input style="width:555px;height:70px" class="easyui-textbox" data-options="multiline:true"
									name="reason" value="${bean.reason}" readonly="readonly"/>
									<!-- <a href="/nkgl/resource-modality/img/a.pdf">aaa</a> -->
								</td>
							</tr>
						</table>
					</div>


					<div title="会议信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../check/meetingCheck.jsp" />
					</div>
			
					<div title="培训信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../check/trainingCheck.jsp" />
					</div>
			
					<div title="差旅信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../check/travelCheck.jsp" />
					</div>
			
					<div title="接待信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../check/receptionCheck.jsp" />
					</div>
					
					<div title="接待人员名单" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="reception_people.jsp" />
					</div>
					
					<div title="公务用车信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../check/officeCarCheck.jsp" />
					</div>
					
					<div title="公务出国信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../check/abroadCheck.jsp" />
					</div>
			
					<div title="明细信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="mingxi.jsp"/>
					</div>
					
					<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
						<jsp:include page="../../../check_history.jsp" />												
					</div>
								
				</div>
			</div>
			
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="closeWindow()">
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
	var h = $("#checkTypeHi").textbox().textbox('getValue');
			
	if (h != "") {
		$('#applyType').textbox().textbox('setValue', h);
		$('#applyType').textbox().attr('readonly', true);
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