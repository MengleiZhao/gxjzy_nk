<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="window-div">
<form id="uptInfo" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 10px;">
			<div class="win-left-top-div">
				<input type="hidden" name="fId_U" id="upt_fcId" value="${Upt.fId_U}"/>
	    		<%-- <input type="hidden" name="fFlowStauts" id="upt_fFlowStauts" value="${bean.fFlowStauts}"/> --%>
	    		<input type="hidden" name="fContStauts" id="upt_fContStauts" value="${bean.fContStauts}"/>
	    		<%-- <input type="hidden" name="fUserName" id="upt_fUserName" value="${bean.fUserName}"/> --%>
	    		<input type="hidden" name="fUserCode" id="upt_fUserCode" value="${bean.fUserCode}"/>
	    		<input type="hidden" name="fOperatorId" id="F_fOperatorId" value="${bean.fOperatorId}"/>
	    		<input type="hidden" name="fContId_U" id="fContId_U" value="${Upt.fContId_U}"/>
	    		<%-- <input type="hidden" name="fContName" id="fContName" value="${Upt.fContName}"/> --%>
	    		<input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
				<input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
				<!-- 审批附件 --><input type="hidden" name="spjlFile" id="spjlFile" value=""/>
				<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${findById.FNextCheckUserId}" /> 
				<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${findById.FNextCheckUserName}" />
				<input type="hidden" name="fToId" id="fToId" value="${findById.fToId}"/>
				<input type="hidden" name="FUserId" id="FUserId" value="${findById.FUserId}"/>
				<input type="hidden" name="FBeanCode" id="FBeanCode" value="${findById.FBeanCode}"/>
				<input id="F_fcType" name="fcType" value="${bean.fcType}" type="hidden"/>
				<div>
					<div title="" style="margin-bottom:35px;" data-options="">
							<div class="easyui-accordion" data-options="" style="width:707px;margin-left: 20px;">
								<div title="归档信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
								<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
									 <tr class="trbody">
										<td class="td1"><span class="style1">*</span>&nbsp;签订日期</td>
										<td class="td2" colspan="4">
										<input id="fqdTime" class="easyui-datebox" readonly="readonly" required="required" name="fqdTime" data-options="validType:'length[1,20]',editable:false" style="width: 200px;height: 30px" value="${archiving.fqdTime}"/>
										</td >
										</tr>
										<tr>
										<td class="td1" >
											&nbsp;&nbsp;已盖章合同文本
										</td>
										<td colspan="4" id="fhtgdtd">
											<c:forEach items="${archivingAttaList}" var="att">
												<c:if test="${att.serviceType=='fhtgd' }">
													<div style="">
														<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
													</div>
												</c:if>
											</c:forEach>
										</td>
									</tr>
								</table>
								</div>
							</div>
							<div class="easyui-accordion" style="width:707px;margin-left: 20px">
								<div title="审批记录" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
								<jsp:include page="../../check_history_gd.jsp" />
								</div>
							</div>
					</div>
				</div>
	    		<div class="tab-wrapper" id="contract-archiving-edit" style="margin-left: 0px;">
					<ul class="tab-menu">
						<li class="active">变更表</li>
						<li onclick="fcTypeOnClik()">合同信息</li>
					</ul>
					<div class="tab-content">
						<div title="变更表" style="margin-bottom:35px;width: 737px">
							<%@ include file="../base/contract-change-base-detail.jsp" %>
						</div>
						<div title="合同信息" style="margin-bottom:35px;width: 737px">
							<%@ include file="../formulation/formulation_detail_base.jsp" %>
						</div>
					</div>
	    		</div>
			</div>
			<div class="win-left-bottom-div">
				<c:if test="${openType=='Aadd'||openType=='Aedit'}"> 
					<a href="javascript:void(0)" onclick="ArchivingEditForm();">
						<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;
			 	</c:if> 
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		 <div class="window-right-div" id="check_system_div" style="width:254px;height: auto;padding-bottom: 20px;">
			<jsp:include page="../../check_system.jsp" />
		</div>
	</div>
</form>
</div>
<script type="text/javascript">
flashtab('contract-archiving-edit');	
$('#F_fcType').combobox({  
    onChange:function(newValue,oldValue){  
	var sel2=$('#F_fcType').combobox('getValue');
	if(sel2=="HTFL-01"){
		$('#cg1').show();
		$('#cg2').show();
		//$('#cg2').hide();
		//$('#F_fPurchNo').next(".textbox").show();
	}else{
		$('#cg1').hide();
		$('#cg2').hide();
		//$('#cg2').show();
		//$('#F_fPurchNo').next(".textbox").hide();
	} 
    }
}); 
	function ArchivingEditForm(){
		var ss = "";
		$(".htgdfileUrl").each(function() {
			ss = ss + $(this).attr("id") + ",";
		});
		$("#htgdfiles").val(ss);
		//校验合同信息
		if (ss == null || ss == '') {
			alert("请上传已盖章合同文本");
		} 
		
		//var plan = getPlan();
		//console.log($('#upt_fFileSrc1').val());
    	$('#uptInfo').form('submit', {
				onSubmit:function(){ 
					//param.planJson=plan;
					flag=$(this).form('enableValidation').form('validate');
					if(flag){
						$.messager.progress();
					}
					return flag;
				}, 
				url:'${base}/Archiving/Savebg',
				type:'post',
				/* data:{'fFileSrc':$('#upt_fFileSrc').val()}, */
				success:function(data){
					if(flag){
						$.messager.progress('close');
					}
					data=eval("("+data+")");
					if(data.success){
						$.messager.alert('系统提示', data.info, 'info');
						closeWindow();
						$('#archiving_dgs').form('clear');
						$('#archiving_dgs').datagrid('reload'); 
					}else{
						$.messager.alert('系统提示', data.info, 'error');
						closeWindow();
						$('#archiving_dgs').form('clear');
					}
				} 
			});		
		}
		function fPurchNo_DC(){
			//var node=$('#archiving_dgs').datagrid('getSelected');
			var win=creatFirstWin('选择-采购订单号',750,550,'icon-add','/PurchaseApply/PurchNoList');
			win.window('open');
		}
		function quota_DC(){
			//var node=$('#archiving_dgs').datagrid('getSelected');
			var win=creatFirstWin('选择-预算指标编号',750,550,'icon-add','/BudgetIndexMgr/contract_list');
			win.window('open');
		}
		var c =0;
		function upt_upFile() {
			/* console.log(document.getElementById("upt_fFileSrc1"));
			var src = getFilePath();
			alert(getFilePath()); */
			c ++;
			var src = $('#upt_fFileSrc1').val();
			/* var srcs =src+','+$('#upt_fi1').val();
			$('#upt_fi1').val(srcs); */
			$('#upt__f1').append("<div id='c"+c+"'><a href='#' class='file_U' style='color: #3f7f7f;font-weight: bold;'>"+src+"</a><a style='color: red;' href='#' onclick='deleteF1(c"+c+")'>删除</a></div>");
		} 
		function deleteF1(val){
			var child=document.getElementById(val.id);
			child.parentNode.removeChild(child);
		}
	</script>
</body>