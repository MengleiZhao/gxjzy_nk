<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="window-div">
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="合同信息" data-options="collapsible:false" style="overflow:auto;margin-top:10px;">
					<jsp:include page="../../base/contract-formulation-base-detail.jsp"/>
				</div>
			</div>
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="签约方信息" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;">
				<jsp:include page="../../base/contract-formulation-sign-base-detail.jsp"/>
				</div>
			</div>
			<div id="recePlanId" hidden="hidden">
			<div class="easyui-accordion" data-options="collapsible:false" id="" style="width:707px;margin-left: 20px">
				<div title="采购清单" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;">
				  	<jsp:include page="../../base/contract_cg_mingxi_detail.jsp" />												
				</div>	
			</div>
			</div>
			<div id="filingPlanId" hidden="hidden">
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="付款计划" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<jsp:include page="../../base/contract-filing-edit-plan-detail.jsp"/>
				</div>
			</div>
			</div>
			<div id="proceedsPlanId"  hidden="hidden">
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="收款计划" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<jsp:include page="../../base/contract-proceeds-edit-plan-detail.jsp"/>
				</div>
			</div>
			</div>
			<c:if test="${!empty fsyjsFile}">
			<!-- 附件信息 -->
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
			<div title="法审意见书" data-options="collapsed:false,collapsible:false" style="overflow:auto;">		
				<table class="window-table">
					<tr>
						<c:if test="${fsyjsFile==1}">
							<td class="td1" style="width:80px;">意见书
								<input type="file" multiple="multiple" id="fsyjs"
								onchange="upladFileMoreParams(this,'fsyjs','zcgl01','jdghprogressNumber','fsyjspercent','fsyjstdf','fsyjsfiles','fsyjsprogid','fsyjsfileUrl')" hidden="hidden"> <input
								type="text" id="fsyjsfiles" name="fsyjsfiles" hidden="hidden"></td>
							<td colspan="3" id="fsyjstdf">&nbsp;&nbsp; 
							<a onclick="$('#fsyjs').click()"
								style="font-weight: bold;  " href="#"> <img
									style="vertical-align:bottom;margin-bottom: 5px;"
									src="${base}/resource-modality/${themenurl}/button/shangchuan1.png"
									onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
							</a>
							<div id="fsyjsprogid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none">
								<div id="fsyjsprogressNumber"
									style="background:#3AF960;width:0px;height:10px"></div>
								文件上传中...&nbsp;&nbsp;<font id="fsyjspercent">0%</font>
							</div>
							<c:forEach items="${formulationAttaList}" var="att">
							<c:if test="${att.serviceType=='fsyjs' }">
								<div style="margin-top: 5px;">
									<a href='${base}/attachment/download/${att.id}'
										style="color: #666666;font-weight: bold;">${att.originalName}</a>
									&nbsp;&nbsp;&nbsp;&nbsp; <img style="margin-top: 5px;"
										src="${base}/resource-modality/${themenurl}/sccg.png">
									&nbsp;&nbsp;&nbsp;&nbsp; <a id="${att.id}" class="fsyjsfileUrl" href="#"
										style="color:red" onclick="deleteAttac(this)">删除</a>
								</div>
							</c:if>
							</c:forEach>
							</td>
							</c:if>
							<c:if test="${fsyjsFile==0}">
								<td class="td1" style="width:80px;">意见书</td>
								<td colspan="4">
									<c:if test="${!empty formulationAttaList}">
										<c:forEach items="${formulationAttaList}" var="att">
											<c:if test="${att.serviceType=='fsyjs'}">
												<a href='${base}/attachment/download/${att.id}'
													style="color: #666666;font-weight: bold;">${att.originalName}</a>
												<br>
											</c:if>
										</c:forEach>
									</c:if>
								</td>	
							</c:if>
						</tr>
					</table>
			</div>
			</div>
			</c:if>
			<!-- 附件信息 -->
			<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
			<div title="附件信息" data-options="collapsed:false,collapsible:false"
				style="overflow:auto;">		
				<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
					<tr>
						<td class="td1" style="width:55px;text-align: left">
							&nbsp;&nbsp;附件
						</td>
						<td colspan="4" id="htndtdf">
							<c:forEach items="${formulationAttaList}" var="att">
								<c:if test="${att.serviceType=='fhtnd' }">
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
			<c:if test="${openType != 'add'}">
			<div class="easyui-accordion" style="width:707px;margin-left: 20px">
				<div title="审批记录" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
				<jsp:include page="../../../check_history.jsp" />
				</div>
			</div>
			</c:if>
			</div>
<script type="text/javascript">
	flashtab('contract-approval-add');
	
	var num=0;
	$('#filing-edit-plan-dg').datagrid({
		onBeforeLoad : function (param){
			if(num>2){
				return false;
			}else{
				num=num+1;
				return true;
			}
		}
	});
	$.messager.progress('close');
		function check(stauts){
			if(${fsyjsFile==1}){
				var s1="";
				$(".fsyjsfileUrl").each(function(){
					s1=s1+$(this).attr("id")+",";
				});
				$('#fsyjsfiles').val(s1);
				if(s1==''){
					alert('请上传法审意见书!');
					return false;
				}
			}
			$('#ApprovalAddEditForm').form('submit', {
				onSubmit: function(){ 
					$.messager.progress();
   				},
   				url:'${base}/Approval/approve/'+stauts,
   				data:{
   					'fFlowStauts':stauts,
   					'Id':'${bean.fcId}'
   				},
   				success:function(data){
   					data=eval("("+data+")");
					$.messager.progress('close');
   					if(data.success){
   						$.messager.alert('系统提示', data.info, 'info');
   						$('#ApprovalAddEditForm').form('clear');
   						$("#CF_app_dg").datagrid('reload'); 
   						$("#indexdb").datagrid('reload'); 
   						closeWindow();
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   					}
   				} 
   			});	
		}
		

		 $('#F_fcTypeName').combobox({  
		        onSelect:function(rec){
		    	if(rec.code=="HTFL-01"){
		    		$('#F_fcType').val("HTFL-01");
		    		$('#cg1').show();
		    		$('#cg2').show();
		    		$('#cg3').show();
		    		$('#cg4').show();
		    		$('#dd').hide();
		    		$('#fLandlineTd').hide();
		    		$('#f_fLandlinePhone').hide();
		    		$('#finish_fLandlinePhone').textbox({required:false});
		    		$('#fTaxpayerNum_show').hide();
		    		$('#f_fTaxpayerNum').textbox({required:false});
		    		$('#fAddress_show').hide();
		    		$('#f_fAddress').textbox({required:false});
		    		$('#fCardNo_show').show();
		    		$('#fBankName_show').show();
		    		$('#recePlanId').show();
		    		$.parser.parse("#recePlanId");
		    		$('#plan_contract_dg_detail').datagrid('reload');
		    		$('#proceedsPlanId').hide();
		    		$('#filingPlanId').show();
		    		$.parser.parse("#filingPlanId");
		    		$('#filing-edit-plan-dg-detail').datagrid('reload');
				}
		    	
		    	if(rec.code=="HTFL-02"){
		    		$('#F_fcType').val("HTFL-02");
		    		$('#cg1').hide();
		    		$('#cg2').show();
		    		$('#cg3').show();
		    		$('#cg4').show();
		    		$('#fLandlineTd').show();
		    		$('#f_fLandlinePhone').show();
		    		$('#finish_fLandlinePhone').textbox({required:true});
		    		$('#fTaxpayerNum_show').show();
		    		$('#f_fTaxpayerNum').textbox({required:true});
		    		$('#fAddress_show').show();
		    		$('#f_fAddress').textbox({required:true});
		    		$('#fCardNo_show').show();
		    		$('#fBankName_show').show();
		    		$('#recePlanId').hide();
		    		$('#proceedsPlanId').show();
		    		$('#filingPlanId').hide();
		    		$.parser.parse("#proceedsPlanId");
		    		$('#proceeds-edit-plan-dg-detail').datagrid('reload');
				}
		    	if(rec.code=="HTFL-03"){
		    		$('#F_fcType').val("HTFL-03");
		    		$('#cg1').hide();
		    		$('#cg2').hide();
		    		$('#cg3').hide();
		    		$('#cg4').hide();
		    		$('#dd').hide();
		    		$('#fLandlineTd').hide();
		    		$('#fCardNo_show').hide();
		    		$('#fBankName_show').hide();
		    		$('#f_fLandlinePhone').hide();
		    		$('#finish_fLandlinePhone').textbox({required:false});
		    		$('#fTaxpayerNum_show').hide();
		    		$('#f_fTaxpayerNum').textbox({required:false});
		    		$('#F_fPayType').combobox({required:false});
		    		$('#fAddress_show').hide();
		    		$('#f_fAddress').textbox({required:false});
		    		$('#recePlanId').hide();
		    		$('#fTaxpayerNum_show').hide();
		    		$('#proceedsPlanId').hide();
		    		$('#filingPlanId').hide();
				}
		        }
		    }); 

</script>
</body>