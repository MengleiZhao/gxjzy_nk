<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="window-div">
<form id="uptInfo" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div">
				<input type="hidden" name="fcId" id="F_fcId" value="${bean.fcId}"/>
	    		<%-- <input id="F_fcType" name="fcType" value="${bean.fcType}" type="hidden"/> --%>
	    		<input type="hidden" id="totalAmount" name="totalAmount" value="${bean.totalAmount }"/>
    			<input type="hidden" name="fBudgetIndexCode" id="F_indexId" value="${bean.fBudgetIndexCode}"/>
    			<input type="hidden" name="proDetailId" id="F_proDetailId" value="${bean.proDetailId}"/>
    			<input type="hidden" name="fhttype" id="fhttype" value="${bean.fhttype}"/>
    			<input type="hidden" name="fyhtid" id="fyhtid" value="${bean.fyhtid}"/>
	    		<c:if test="${bean.fcId!=null}">
	    			<%-- <input type="hidden" name="fUserName" id="F_fUserName" value="${bean.fUserName}"/> --%>
	    			<%-- <input type="hidden" name="fUserCode" id="F_fUserCode" value="${bean.fUserCode}"/> --%>
	    			<input type="hidden" name="fProCode" id="F_fProCode" value="${bean.fProCode}"/>
	    			<%-- <input type="hidden" name="fNCode" id="F_fNCode" value="${bean.fNCode}"/> --%>
	    			<input type="hidden" name="fPayStauts" id="F_fPayStauts" value="${bean.fPayStauts}"/>
	    			<input type="hidden" name="fOperatorId" id="F_fOperatorId" value="${bean.fOperatorId}"/>
	    			<input type="hidden" name="fReqtIME" id="F_fReqtIME" value="${bean.fReqtIME}"/>
	    			<input type="hidden" name="fDeptId" id="F_fDeptId" value="${bean.fDeptId}"/>
	    			<input type="hidden" name="fContractor" id="F_fContractor" value="${signInfo.fSignName}"/>
	    		</c:if>
				<div>
					<div title="" style="margin-bottom:35px;" data-options="">
							<div class="easyui-accordion" data-options="" style="width:707px;margin-left: 20px;">
								<div title="????????????" data-options="collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
								<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
									 <tr class="trbody">
										<td class="td1"><span class="style1">*</span>&nbsp;????????????</td>
										<td class="td2" colspan="4">
										<input id="fqdTime" class="easyui-datebox" required="required" name="fqdTime" data-options="validType:'length[1,20]',editable:false" style="width: 200px;height: 30px" value="${archiving.fqdTime}"/>
										</td >
										</tr>
										<tr>
										<td class="td1" >
											<span class="style1">*</span>&nbsp;?????????????????????
											<input type="file" multiple="multiple" id="fhtgd" onchange="upladFileMoreParams(this,'fhtgd','htgl01','fhtgdprogressNumber','htgdpercent','fhtgdtd','htgdfiles','htgdprogid','htgdfileUrl')" hidden="hidden" accept=".pdf">
											<input type="text" id="htgdfiles" name="files" hidden="hidden">
										</td>
										<td colspan="4" id="fhtgdtd">
											<a onclick="$('#fhtgd').click()" style="font-weight: bold;" href="#">
												<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
											</a>
											<c:forEach items="${archivingAttaList}" var="att">
												<c:if test="${att.serviceType=='fhtgd' }">
													<div style="margin-top: 10px;">
														<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
														&nbsp;&nbsp;&nbsp;&nbsp;
														<img style="vertical-align:middle" src="${base}/resource-modality/${themenurl}/sccg.png">
														&nbsp;&nbsp;&nbsp;&nbsp;
														<a id="${att.id}" class="htgdfileUrl" href="#" style="color:red" onclick="deleteAttac(this)">??????</a>
													</div>
												</c:if>
											</c:forEach>
											<div id="htgdprogid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
												<div id="fhtgdprogressNumber" style="background:#3AF960;width:0px;height:10px" >
											 	</div>???????????????...&nbsp;&nbsp;<font id="htgdpercent">0%</font> 
											</div>
											<c:if test="${openType=='Aadd'||openType=='Aedit'}">
												<span style="color: red">&nbsp;&nbsp;&nbsp;???????????????????????????????????????pdf?????????????????????????????????</span>
											</c:if>
										</td>
									</tr>
								</table>
								</div>
							</div>
							<%-- <div class="easyui-accordion" style="width:707px;margin-left: 20px">
								<div title="????????????" data-options="collapsible:false" style="overflow:auto;margin-top: 10px;margin-left: 0px;">
								<jsp:include page="../../check_history_gd.jsp" />
								</div>
								</div>
							</div> --%>
				</div>
			
	    		<!-- <div class="tab-wrapper" id="contract-archiving-edit" style="margin-left: 0px;"> -->
					<div class="tab-content">
						<div title="????????????" style="margin-bottom:35px;width: 737px">
							<%@ include file="../formulation/formulation_detail_base.jsp" %>
						</div>
					</div>
			</div>
			
			<div class="window-left-bottom-div">
				<c:if test="${openType=='Aadd'||openType=='Aedit'}">
					<a href="javascript:void(0)" onclick="ArchivingEditForm();">
						<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;
				</c:if>
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		 <%-- <div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div>  --%>
		<%-- <div class="window-right-div" id="check_system_div" style="width:254px;height: auto;padding-bottom: 20px;">
			<jsp:include page="../../check_system.jsp" />
		</div> --%>
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
		//??????????????????
		if (ss == null || ss == '') {
			alert("??????????????????????????????");
			return false;
		}
    	$('#uptInfo').form('submit', {
				onSubmit:function(){ 
					//param.planJson=plan;
					flag=$(this).form('enableValidation').form('validate');
					if(flag){
						$.messager.progress();
					}
					return flag;
				}, 
				url:'${base}/Archiving/Save',
				type:'post',
				/* data:{'fFileSrc':$('#upt_fFileSrc').val()}, */
				success:function(data){
					if(flag){
						$.messager.progress('close');
					}
					data=eval("("+data+")");
					if(data.success){
						$.messager.alert('????????????', data.info, 'info');
						closeWindow();
						$('#archiving_dg').form('clear');
						$('#archiving_dg').datagrid('reload'); 
					}else{
						$.messager.alert('????????????', data.info, 'error');
						closeWindow();
						$('#archiving_dg').form('clear');
					}
				} 
			});		
		}
		function fPurchNo_DC(){
			//var node=$('#archiving_dg').datagrid('getSelected');
			var win=creatFirstWin('??????-???????????????',750,550,'icon-add','/PurchaseApply/PurchNoList');
			win.window('open');
		}
		function quota_DC(){
			//var node=$('#archiving_dg').datagrid('getSelected');
			var win=creatFirstWin('??????-??????????????????',750,550,'icon-add','/BudgetIndexMgr/contract_list');
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
			$('#upt__f1').append("<div id='c"+c+"'><a href='#' class='file_U' style='color: #3f7f7f;font-weight: bold;'>"+src+"</a><a style='color: red;' href='#' onclick='deleteF1(c"+c+")'>??????</a></div>");
		} 
		function deleteF1(val){
			var child=document.getElementById(val.id);
			child.parentNode.removeChild(child);
		}
		
		
		/* var num = 0;
		 $('#F_fcTypeName').combobox({  
		        onSelect:function(rec){
		    	if(rec.code=="HTFL-01"){
		    		$('#F_fcType').val("HTFL-01");
		    		$('#cg1').show();
		    		$('#cg2').show();
		    		$('#cg3').show();
		    		$('#cg4').show();
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
		    		$('#fLandlineTd').hide();
		    		$('#fCardNo_show').hide();
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
		    }); */
		 $(document).ready(function() {
			var fcType = '${bean.fcType}';
			 if(fcType=="HTFL-01"){
			   		$('#cg11').show();
			   		$('#cg21').show();
			   		$('#cg31').show();
			   		$('#cg41').show();
			   		$('#dd1').hide();
			   		$('#fLandlineTd1').hide();
			   		$('#f_fLandlinePhone1').hide();
			   		$('#finish_fLandlinePhone1').textbox({required:false});
			   		$('#fTaxpayerNum_show1').hide();
			   		$('#f_fTaxpayerNum1').textbox({required:false});
			   		$('#fAddress_show1').hide();
			   		$('#f_fAddress1').textbox({required:false});
			   		$('#fCardNo_show1').show();
			   		$('#fBankName_show1').show();
			   		$('#recePlanId1').hide();
			   		$.parser.parse("#recePlanId1");
			   		$('#plan_contract_dg_detail').datagrid('reload');
			   		$('#proceedsPlanId1').hide();
			   		$('#filingPlanId1').show();
			   		$.parser.parse("#filingPlanId1");
			   		$('#filing-edit-plan-dg-detail').datagrid('reload');
				}
			   	
			   	if(fcType=="HTFL-02"){
			   		$('#cg11').hide();
			   		$('#cg21').show();
			   		$('#cg31').show();
			   		$('#cg41').show();
			   		$('#dd1').show();
			   		$('#fLandlineTd1').show();
			   		$('#f_fLandlinePhone1').show();
			   		$('#finish_fLandlinePhone1').textbox({required:true});
			   		$('#fTaxpayerNum_show1').show();
			   		$('#f_fTaxpayerNum1').textbox({required:true});
			   		$('#fAddress_show1').show();
			   		$('#f_fAddress1').textbox({required:true});
			   		$('#fCardNo_show1').show();
			   		$('#fBankName_show1').show();
			   		$('#recePlanId1').hide();
			   		$('#proceedsPlanId1').show();
			   		$('#filingPlanId1').hide();
			   		$.parser.parse("#proceedsPlanId1");
			   		$('#proceeds-edit-plan-dg-detail').datagrid('reload');
				}
			   	if(fcType=="HTFL-03"){
			   		$('#cg11').hide();
			   		$('#cg21').hide();
			   		$('#cg31').hide();
			   		$('#cg41').hide();
			   		$('#dd1').hide();
			   		$('#fLandlineTd1').hide();
			   		$('#fCardNo_show1').hide();
			   		$('#f_fLandlinePhone1').hide();
			   		$('#finish_fLandlinePhone1').textbox({required:false});
			   		$('#fTaxpayerNum_show1').hide();
			   		$('#f_fTaxpayerNum1').textbox({required:false});
			   		$('#F_fPayType1').combobox({required:false});
			   		$('#fAddress_show1').hide();
			   		$('#f_fAddress1').textbox({required:false});
			   		$('#recePlanId1').hide();
			   		$('#fTaxpayerNum_show1').hide();
			   		$('#proceedsPlanId1').hide();
			   		$('#filingPlanId1').hide();
			   		$('#dd1').hide();
				}
			   	//$('#check-history-dg-contract').datagrid('reload'); 
			});
	</script>
</body>