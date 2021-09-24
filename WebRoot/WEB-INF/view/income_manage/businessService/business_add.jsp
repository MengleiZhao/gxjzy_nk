<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<form id="business_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 451px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div">
				<!-- 隐藏域 -->
					<!-- 立项申请id -->
					<input type="hidden" id="F_fBusiId" name="fBusiId"
						value="${bean.fBusiId }" />
					<!-- 申请人id -->
					<input type="hidden" id="F_fOperatorId" name="fOperatorId"
						value="${bean.fOperatorId }" />
					<!-- 申请部门id -->
					<input type="hidden" id="F_fDeptId" name="fDeptId"
						value="${bean.fDeptId }" />
					<!-- 数据状态 -->
					<input type="hidden" id="F_fStatus" name="fStatus"
						value="${bean.fStatus }" />

					<!-- 审批状态 -->
					<input type="hidden" id="F_fFlowStatus" name="fFlowStatus"
						value="${bean.fFlowStatus }" />
					<!-- 下节点审批人id -->
					<input type="hidden" name="fNextUserId"
						value="${bean.fNextUserId }" />
					<!-- 下节点审批人姓名 -->
					<input type="hidden" name="fNextUserName"
						value="${bean.fNextUserName }" />
					<!-- 下节点编码 -->
					<input type="hidden" name="fNextCode" value="${bean.fNextCode }" />
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
									<input class="easyui-textbox" id="F_fProName" name="fProName" required="required"  style="width: 555px; height: 30px" value="${bean.fProName }"/>
								</td>
							</tr>
							<tr class="trbody">	
								<td class="td1"><span class="style1">*</span>收费标准</td>
								<td colspan="4">
									<input class="easyui-textbox" id="F_fPlanPrice" name="fPlanPrice" required="required" data-options="validType:'length[1,1000]',multiline:true" style="width: 555px; height: 70px" value="${bean.fPlanPrice }"/>
								</td>
							</tr>
							
							<tr style="height: 5px;"></tr>
							
							<tr class="trbody">	
								<td class="td1"><span class="style1">*</span>收费依据</td>
								<td colspan="4">
									<input class="easyui-textbox" id="F_fProPlan" name="fProPlan" required="required" data-options="validType:'length[1,1000]',multiline:true" style="width: 555px; height: 70px" value="${bean.fProPlan }"/>
								</td>
							</tr>
							<tr style="height: 5px;"></tr>
							<tr class="trbody">	
								<td class="td1">论证资料</td>
								<td colspan="4">
									<input class="easyui-textbox" id="F_fRemark" name="fRemark" data-options="validType:'length[1,1000]',multiline:true" style="width: 555px; height: 70px" value="${bean.fRemark }"/>
								</td>
							</tr>
							
							
							
							<tr class="trbody">
								<td class="td1">
									&nbsp;&nbsp;附件
									<input type="file" multiple="multiple" id="f_business" onchange="upladFile(this, 'business', 'business01')" hidden="hidden">
									<input type="text" id="files" name="files" hidden="hidden">
								</td>
								<td colspan="4" id="tdf">
									<a onclick="$('#f_business').click()" style="font-weight: bold;" href="#">
										<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
									</a>
									<c:forEach items="${businessAttaList }" var="att">
										<c:if test="${att.serviceType=='business' }">
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
				</div>
					<%-- <div title="立项详情表" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
						<%@ include file="business_add_details.jsp" %>
					</div> --%>
					
				<%-- 	<c:if test="${openType != 'add' }">
					<div title="审批记录" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow-x:hidden;margin-top: 10px;">
						<jsp:include page="../../check_history.jsp" />												
					</div>
					</c:if> --%>
			
			<div class="window-left-bottom-div" style="margin-top: 15px;">
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
	
//保存
function saveIncome(status) {
	//设置数据状态
	$('#F_fStatus').val(status);
	//设置审批状态
	$('#F_fFlowStatus').val(status);
	/* //详情表
	getMingxiJson(); */
	
	//附件的路径地址
	var s = "";
	$(".fileUrl").each(function(){
		s = s + $(this).attr("id") + ",";
	});
	$("#files").val(s);
	
	//提交
	$('#business_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}
			return flag;
		},
		url : base + '/business/save',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#business_form').form("clear");  //带着新增完毕不能查询
				$('#business_tab').datagrid("reload");
				closeWindow();
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});  
}
</script>
</body>