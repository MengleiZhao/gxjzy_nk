<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<form id="bid_detail_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
  <div class="window-div">
  <div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 10px; margin-bottom: 10px;">
  
	<div class="win-left-top-div">
	  <div class="tab-wrapper" id="yx-tab">
		<ul class="tab-menu" >
			<li class="active">采购申请</li>
			<c:if test="${!empty bidStauts }">
			<li onclick="onclick_cggl_detail()">过程登记</li>
			</c:if>
			<c:if test="${!empty accStauts }">
			<li onclick="onclick_cggl_detailjh()">采购验收</li>
			</c:if>
		</ul>
		<div class="tab-content">
		<div title="采购申请" style="margin-bottom:35px;width: 737px" >
			<%@ include file="../purchase/cggl_detail_base.jsp" %>
		</div>
		<div title="中标登记" style="margin-bottom:35px;width: 737px" >
			<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 707px;">
				<!--第1个div  -->
				<div title="供应商信息"  id="gysxxdiv"  data-options="collapsed:false,collapsible:false" style="overflow:auto;">
					<jsp:include page="../process/course_gys_detail.jsp" />
				</div>
			</div>
		</div>
		<div title="采购验收"  id="cgysdiv" data-options="collapsible:false" style="overflow:auto;margin-bottom:35px;">
						 	<div class="easyui-accordion" data-options="" id="" style="width: 707px;margin-left: 20px">
						 		<div title="验收详情" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;">
							  		<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
										<tr class="trbody">
											<td class="td1"><span class="style1">*</span>&nbsp;验收人</td>
											<td class="td2">
												<input class="easyui-textbox" type="text" id="F_facpUser" readonly="readonly"  name="facpUser"required="required" data-options="validType:'length[1,20]'" style="width: 200px" value="${acptbean.facpUsername}"/>
											</td>
											
											<td class="td4">
												<input type="hidden" name="id" id="pjId" value="${bean.fpId}"/><!--采购的主键id  -->
												
												<!-- 验收的主键id --><input type="hidden" id="F_AcpId" name="facpId" value="${acptbean.facpId}"/>
												<!-- 验收的编码 --><input type="hidden" id="F_AcpCode" name="facpCode" value="${acptbean.facpCode}"/>
												<!-- 验收员id --><input type="hidden" id="F_AcpUserId" name="facpUserId" value="${acptbean.facpUserId}"/>
												<!-- 验收员姓名 --><input type="hidden" id="F_AcpUsername" name="facpUsername" value="${acptbean.facpUsername}"/>
												<!-- 验收部门id --><input type="hidden" id="F_DeptId" name="fDeptId" value="${acptbean.fDepartId}"/>
												<!-- 验收部门名称 --><input type="hidden" id="F_DeptName" name="fDeptName" value="${acptbean.fDepartName}"/>
												<!-- 删除状态 --><input type="hidden" id="F_Stauts" name="fStauts" value="${acptbean.fStauts}"/>
												
												<!-- 审批状态 --><input type="hidden" id="F_CheckStauts" name="fCheckStauts" value="${acptbean.fCheckStauts}"/>
												<!-- 下节点审批人id --><input type="hidden"  name="fuserId" value="${acptbean.fuserId}"/>
												<!-- 下节点审批人姓名 --><input type="hidden"  name="userName2" value="${acptbean.userName2}"/>
												<!-- 下节点编码 --><input type="hidden"  name="nCode" value="${acptbean.nCode}"/>
											</td>
											
											<td class="td1"><span class="style1">*</span>&nbsp;验收时间</td>
											<td class="td2">
												<input class="easyui-datebox" class="dfinput" id="F_facpTime"  name="facpTime" readonly="readonly" required="required" data-options="editable:false,validType:'length[1,20]'" style="width: 200px;" value="${acptbean.facpTime}"/>
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
											验收报告及专家意见（如有）
											<input type="file" multiple="multiple" id="f" onchange="upladFile(this,'cggl','cggl04')" hidden="hidden">
											<input type="text" id="files" name="files" hidden="hidden">
										</td>
										<td colspan="4" id="tdf">
											<c:if test="${!empty reciveattac}">
												<c:forEach items="${reciveattac}" var="att">
													<c:if test="${att.serviceType=='cggl' }">
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
									</table>
								</div>
							</div>												
							<div class="easyui-accordion" data-options="collapsible:false" id="" style="width:707px;margin-left: 20px">
							<div title="审批记录" data-options="collapsible:false" style="overflow-x:hidden;margin-top: 10px;">
							<jsp:include page="../../check_history_ys.jsp" />										
							</div> 
							</div>
						</div> 
					</div>	
				
		</div>
	</div>
	<div class="window-left-bottom-div">
		<a href="javascript:void(0)" onclick="closeWindow()">
		<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
		</a>
	</div>
	<%-- <div class="window-left-bottom-div" style="margin-top: 55px;">
				<a href="javascript:void(0)" onclick="closeSecondWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
	</div> --%>

</div>
</div>
</form>			
<script type="text/javascript">
//加载tab页
flashtab('yx-tab');

var cggl_detailcount = 0;
function onclick_cggl_detail(){
	if(cggl_detailcount>=1){
		detaiurlcount+=1;
		return false;
	}else {
		cggl_detailcount+=1;
		$('#plan_dg').datagrid('reload'); 
		$('#course_gys_detail_dg').datagrid('reload'); 
		return true;
	}
}

var cggl_detailcountjh = 0;
function onclick_cggl_detailjh(){
	if(cggl_detailcountjh>=1){
		cggl_detailcountjh+=1;
		return false;
	}else {
		cggl_detailcountjh+=1;
		$('#plan_dg').datagrid('reload'); 
		$('#plan_receive_detail_dg').datagrid('reload'); 
		$('#check-history-dg-ys').datagrid('reload'); 
		return true;
	}
}

//是否论证	是-显示采购论证结论按钮
function isInquiry(){
	var isInquiry = $("input[name='fIsInquiry']:checked").val();
	if(isInquiry == "1"){
		$("#cglzjl").show();
	}else {
		$("#cglzjl").hide();
	}
}

//采购类型为货物类，采购单价大于等于10万，显示大型仪器设备前期调研报告
function dxyqdybg(){
	var totalFsumMoney = $("#F_fpAmount").val();
	var fpPype = $("#F_fpPype").val(); 
	if(totalFsumMoney>=100000 && fpPype=='A10'){
		$("#dxyqdybg").show();
	}else{
		$("#dxyqdybg").hide();
	}
}

//采购总金额大于等于10万，要上传三重一大党委会纪要
function scyddwhjy(){
	var totalFsumMoney = $("#F_fpAmount").val();
	if(totalFsumMoney>=100000){
		$("#scyddwhjy").show();
	}else{
		$("#scyddwhjy").hide();
	}
}
</script>
</body>