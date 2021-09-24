<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<style type="text/css">
.panel-header{
	height: 20px;
}
</style>
<div class="window-div">
<form id="cgreceive_check_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
		<div class="window-left-div" style="width: 765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;" data-options="region:'west',split:true">
			<div class="win-left-top-div">
				<div class="tab-wrapper" id="yx-tab">
					<ul class="tab-menu" >
						<li onclick="onclickYSDetail()" class="active">采购验收</li>
						<c:if test="${!empty bidStauts }">
						<li onclick="onclickDJDetail()">过程登记</li>
						</c:if>
					    <li onclick="onclickCGSQDetail()">采购申请</li>
					</ul>
					<div class="tab-content">
						<div title="采购验收"  id="cgysdiv" data-options="" style="overflow:auto;margin-bottom:35px;">
							<div class="easyui-accordion" data-options="collapsed:false,collapsible:false" id="" style="width:707px;margin-left: 20px">
							 	<div title="验收" data-options="collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
								  	<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>&nbsp;验收人</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_facpUser" readonly="readonly"  name="facpUser"required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${acptbean.facpUsername}"/>
											</td>
												
											<td class="td4">
											<!-- 验收的主键id --><input type="hidden" id="F_AcpId" name="facpId" value="${acptbean.facpId}"/>
											<!-- 验收的编码 --><input type="hidden" id="F_AcpCode" name="facpCode" value="${acptbean.facpCode}"/>
											<!-- 验收员id --><input type="hidden" id="F_AcpUserId" name="facpUserId" value="${acptbean.facpUserId}"/>
											<!-- 验收员姓名 --><input type="hidden" id="F_AcpUsername" name="facpUsername" value="${acptbean.facpUsername}"/>
											<!-- 验收部门id --><input type="hidden" id="F_DeptId" name="fDepartId" value="${acptbean.fDepartId}"/>
											<!-- 验收部门名称 --><input type="hidden" id="F_DeptName" name="fDepartName" value="${acptbean.fDepartName}"/>
											<!-- 删除状态 --><input type="hidden" id="F_Stauts" name="fStauts" value="${acptbean.fStauts}"/>
													
											<!-- 审批状态 --><input type="hidden" id="F_CheckStauts" name="fCheckStauts" value="${acptbean.fCheckStauts}"/>
											<!-- 下节点审批人id --><input type="hidden"  name="fuserId" value="${acptbean.fuserId}"/>
											<!-- 下节点审批人姓名 --><input type="hidden"  name="userName2" value="${acptbean.userName2}"/>
											<!-- 下节点编码 --><input type="hidden"  name="nCode" value="${acptbean.nCode}"/>
												
											<!-- 审批结果 --><input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
										    <!-- 审批意见 --><input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
											<!-- 审批附件 --><input type="hidden" name="spjlFile" id="spjlFile" value=""/>
										</td>
												
										<td class="td1"><span class="style1">*</span>&nbsp;验收时间</td>
										<td class="td2">
											<input class="easyui-datebox" class="dfinput" id="F_facpTime"  name="facpTime" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 200px;" value="${acptbean.facpTime}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1">验收地点</td>
										<td colspan="4">
											<input class="easyui-textbox" type="text" id="F_facpAddr"  name="facpAddr" readonly="readonly" required="required" data-options="validType:'length[1,20]'" style="width: 555px" value="${acptbean.facpAddr}"/>
										</td>
									</tr>
										
									<tr style="height: 80px;">
										<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span>&nbsp;验收意见</p></td>
										<td class="td2" colspan="4">
											<input class="easyui-textbox" type="text" id="F_fmatchRemark" readonly="readonly" required="required" name="fmatchRemark" data-options="validType:'length[1,50]',multiline:true"   style="width:555px;height:70px;" value="${acptbean.fmatchRemark}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1">
											&nbsp;&nbsp;验收报告及专家意见（如有）
										</td>
										<td colspan="4" id="tdf">
											<c:if test="${!empty reciveattac}">
												<c:forEach items="${reciveattac}" var="att">
													<c:if test="${att.serviceType=='cgys' }">
														<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
													</c:if>
												</c:forEach>
											</c:if>
												
											<c:if test="${empty reciveattac}">
												<span style="color:#999999">暂未上传附件</span>
											</c:if>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1">
											&nbsp;&nbsp;送货清单
										</td>
										<td colspan="4" id="tdf">
											<c:if test="${!empty reciveattac}">
												<c:forEach items="${reciveattac}" var="att">
													<c:if test="${att.serviceType=='shqd' }">
														<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
													</c:if>
												</c:forEach>
											</c:if>
												
											<c:if test="${empty reciveattac}">
												<span style="color:#999999">暂未上传附件</span>
											</c:if>
										</td>
									</tr>
									<tr></tr>
								</table>
							</div>
							<div title="审批记录" data-options="collapsed:false,collapsible:false" style="overflow-x:hidden;margin-top: 10px;">
								<jsp:include page="../../check_history.jsp" />												
							</div> 
						</div>												
					</div>
					<c:if test="${!empty bidStauts }">
						<div title="过程登记" style="width:720px;margin-left: 20px" data-options="collapsed:false,collapsible:false">
							<div class="easyui-accordion" style="width:720px;margin-right: 20px;">
								<!--第1个div  -->
								<div title="供应商信息" data-options="collapsed:false,collapsible:false" style="width:717px;overflow:auto;">
									<jsp:include page="../process/course_gys_detail.jsp" />
								</div>
							</div>
							<div class="easyui-accordion" style="width:720px;margin-right: 20px;">
								<div title="采购结果" data-options="collapsed:false,collapsible:false" style="width:717px;overflow:auto;">
									<jsp:include page="../process/course_gys_plan_mingxi_detail.jsp" />
								</div>
							</div>
						</div>
					</c:if>
					<div title="采购申请" style="margin-bottom:35px;overflow:auto" data-options="collapsible:false"  style="width:720px;margin-left: 20px">
						<jsp:include page="../purchase/cggl_detail_base.jsp" />	
					</div>
				</div>
			</div>
		</div>
			
		<div class="window-left-bottom-div">
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
	
	<div class="window-right-div" data-options="region:'east',split:true">
		<jsp:include page="../../check_system.jsp" />
	</div>
</form>
</div>
<script type="text/javascript">
	//加载tab页
	flashtab('yx-tab');
	
	//防止不停重新加载
	var urlcountYS = 0;
	function onclickYSDetail(){
		if(urlcountYS>=0){
			urlcountYS+=1;
			return false;
		}else {
			urlcountYS+=1;
			$('#plan_receive_dg').datagrid('reload');
			return true;
		}
	}
	var urlcountCGSQ = 0;
	function onclickCGSQDetail(){
		if(urlcountCGSQ>=1){
			urlcountCGSQ+=1;
			return false;
		}else {
			urlcountCGSQ+=1;
			$('#plan_dg').datagrid('reload');
			$('#check-history-dg-cg').datagrid('reload');
			return true;
		}
	}
	var urlcountDJ = 0;
	function onclickDJDetail(){
		if(urlcountDJ>=1){
			urlcountDJ+=1;
			return false;
		}else {
			urlcountDJ+=1;
			$('#course_gys_detail_dg').datagrid('reload');
			return true;
		}
	}
	
	//审核
	function check(checkResult) {
		//附件的路径地址
		var s="";
		$(".zjyjfileUrl").each(function(){
			s=s+$(this).attr("id")+",";
		});
		$("#zjyjfiles").val(s);
		
	 	$('#cgreceive_check_form').form('submit', {
			onSubmit : function() {
				flag = $(this).form('enableValidation').form('validate');
				if (flag) {
					$.messager.progress();
				}
				return flag;
			},
			url : base + '/cgreceive/checkResult',
			success : function(data) {
				if (flag) {
					$.messager.progress('close');
				}
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$('#receive_list').datagrid('reload');
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