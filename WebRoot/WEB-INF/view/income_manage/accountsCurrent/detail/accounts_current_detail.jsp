<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<script type="text/javascript">
//显示详细信息手风琴页面
$(document).ready(function() {
	
});

</script>
<form id="accounts_detail_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;"">
			<div class="win-left-top-div">
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
								<input class="easyui-textbox" style="width: 590px;height: 30px; " readonly="readonly" value="${bean.proName}" id="proName" name="proName" required="required" data-options="validType:'length[1,50]'"/>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span>内容说明</td>
							<td colspan="3">
								<textarea name="contenExplain" id="reason" class="textbox-text" readonly="readonly"
										oninput="textareaNum(this,'textareaNum1')" autocomplete="off" 
										style="width:584px;height:70px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:8px; margin-bottom:0px;">${bean.contenExplain}</textarea>
							</td>
						</tr>
						<tr>
							<td class="td1" style="width:75px;text-align: right"><span class="style1"></span>附件</td>
							<td colspan="3">
								<c:if test="${!empty attaList}">
								<c:forEach items="${attaList}" var="att">
									<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a><br>
								</c:forEach>
							</c:if>
							<c:if test="${empty attaList}">
								<span style="color:#999999">暂未上传附件</span>
							</c:if>
							</td>
						</tr>
					</table>
				</div>				
				</div>
				</div>
				<!-- 审批记录 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
					<div title="审批记录" data-options="collapsible:false" style="overflow:auto;padding:10px;">
						<jsp:include page="../../../check_history.jsp" />
					</div>
				</div>
			</div>
			<div class="window-left-bottom-div" style="margin-top: 55px;">
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
		<div class="window-right-div" style="width:254px;height: auto;padding-bottom: 20px;">
			<jsp:include page="../../../check_system.jsp" />
		</div>
	</div>
</form>
