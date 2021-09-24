<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="Conclusion" action="${base}/Change/Save" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="easyui-layout" style="height: 509px;">
		<div class="win-left-div" data-options="region:'west',split:true">
			<div class="win-left-top-div">
			<input type="hidden" name="fcId" id="finish_fcId" value="${bean.fcId}"/>
	    		<input type="hidden" name="fFlowStauts" id="finish_fFlowStauts" value="${bean.fFlowStauts}"/>
	    		<input type="hidden" name="fContStauts" id="finish_fContStauts" value="${bean.fContStauts}"/>
	    		<input type="hidden" name="fUserName" id="finish_fUserName" value="${bean.fUserName}"/>
	    		<input type="hidden" name="fUserCode" id="finish_fUserCode" value="${bean.fUserCode}"/>
				<div class="easyui-accordion" id="acc" data-options="multiple:true" style="width:662px;margin-left: 20px;">
							<div title="合同信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top:10px;">
								<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;合同编号</td>
										<td  colspan="4">
											<input id="F_fcCode" class="easyui-textbox" type="text" readonly="readonly" name="fcCode" data-options="prompt:'系统自动生成',validType:'length[1,20]'" value="${bean.fcCode}" style="width: 505px"/> 
										</td>								
									</tr>
									
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;合同名称</td>
										<td  colspan="4">
											<input class="easyui-textbox" type="text" id="F_fcTitle" readonly="readonly" name="fcTitle"required="required" data-options="validType:'length[1,50]'" value="${bean.fcTitle}" style="width: 505px"/>
										</td>
									</tr>
									
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;合同分类</td>
										<td class="td2">
											<input class="easyui-combobox" id="F_fcType" name="fcType" readonly="readonly" style="width: 150px;" data-options="editable:false,panelHeight:'auto',url:'${base}/Formulation/lookupsJson?parentCode=HTFL&selected=${bean.fcType}',method:'POST',valueField:'code',textField:'text',editable:false">
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1">&nbsp;&nbsp;合同份数</td>
										<td class="td2">
											<input id="F_fcNum"  class="easyui-numberbox" readonly="readonly" type="text" required="true" name="fcNum" data-options="validType:'length[1,20]'"  value="${bean.fcNum}" style="width: 150px"/>
										</td>
									</tr>
									
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;合同金额</td>
										<td class="td2">
											<input class="easyui-numberbox" type="text" readonly="readonly" id="F_fcAmount" name="fcAmount" data-options="icons: [{iconCls:'icon-wanyuan'}]" value="${bean.fcAmount}" style="width: 150px"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1">&nbsp;&nbsp;质保期</td>
										<td class="td2">
											<input class="easyui-textbox" type="text" readonly="readonly" id="F_fWarrantyPeriod" name="fWarrantyPeriod"  data-options="validType:'length[1,20]'" style="width: 150px" value="${bean.fWarrantyPeriod}"/>
										</td>
										<%-- <td class="td1">申请时间</td>
										<td class="td2">
											<input class="easyui-datebox" class="dfinput" id="F_fReqtIME" name="fReqtIME"  data-options="validType:'length[1,20]'" style="width: 150px" value="${bean.fReqtIME}"/>
										</td> --%>
									</tr>
									
									
									
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;合同开始时间</td>
										<td class="td2">
											<input id="F_fContStartTime" class="easyui-datebox" readonly="readonly" class="dfinput"  name="fContStartTime" data-options="validType:'length[1,20]'" style="width: 150px" value="${bean.fContStartTime}"/>					
										</td>
										
										<td class="td4">&nbsp;</td>
										
										<td class="td1">&nbsp;&nbsp;合同结束时间</td>
										<td class="td2">
											<input class="easyui-datebox" class="dfinput" readonly="readonly" id="F_fContEndTime" name="fContEndTime"  data-options="validType:'length[1,20]'" style="width: 150px" value="${bean.fContEndTime}"/>
										</td>
									</tr>
									
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;合同签署人</td>
										<td class="td2">
											<input id="F_fSignUser"  class="easyui-textbox" readonly="readonly" type="text" name="fSignUser" data-options="validType:'length[1,20]'" style="width: 150px" value="${bean.fSignUser}"/>					
										</td>
										
										<td class="td4">&nbsp;</td>
										
										<td class="td1">&nbsp;&nbsp;合同签署时间</td>
										<td class="td2">
											<input class="easyui-datebox" class="dfinput" readonly="readonly" id="F_fSignTime" name="fSignTime"  data-options="validType:'length[1,20]'" style="width: 150px" value="${bean.fSignTime}"/>
										</td>
									</tr>
									
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;保证金金额</td>
										<td class="td2">
											<input id="F_fMarginAmount"  class="easyui-numberbox" readonly="readonly" type="text" name="fMarginAmount" data-options="validType:'length[1,20]',prompt:'(元)',precision:2" style="width: 150px" value="${bean.fMarginAmount}"/>
										</td >
										<td class="td4">&nbsp;</td>
										<td class="td1">&nbsp;&nbsp;是否委托授权</td>
										<td class="td2">
											<input type="radio" name="fIsAuthor" value="1" checked="checked" <c:if test="${bean.fIsAuthor=='1'}">checked="checked"</c:if> />是
											<input type="radio" name="fIsAuthor" value="0" <c:if test="${bean.fIsAuthor=='0'}">checked="checked"</c:if> />否
											<%-- <select class="easyui-combobox" id="F_fIsAuthor" name="fIsAuthor" value="${bean.fIsAuthor}" style="width: 150px;" data-options="editable:false,panelHeight:'auto'">
												<option value="${bean.fIsAuthor}"></option>
												<option value="0">否</option>
												<option value="1">是</option>
											</select> --%>
										</td>
									</tr>
									<tr id="cg1" hidden="hidden" class="trbody">
										<td class="td1">&nbsp;&nbsp;采购订单号</td>
										<td  colspan="4">
											<a onclick="fPurchNo_DC()"><input id="F_fPurchNo" readonly="readonly" class="easyui-textbox" name="fPurchNo" data-options="prompt:'单击打开选取采购订单号',validType:'length[1,50]'" value="${bean.fPurchNo}" style="width: 505px"/></a>
										</td>
									</tr>
									<tr id="cg2" hidden="hidden" class="trbody">
										<td class="td1">&nbsp;&nbsp;预算指标名称</td>
										<td >
											<input id="F_fBudgetIndexName" class="easyui-textbox" readonly="readonly" name="fBudgetIndexName" data-options="validType:'length[1,20]'" style="width: 150px" value="${bean.fBudgetIndexName}"/>
										</td >
										<td class="td4">&nbsp;</td>
										<td class="td1">&nbsp;&nbsp;预算指标金额</td>
										<td >
											<input id="F_fAvailableAmount" class="easyui-textbox" readonly="readonly" name="fAvailableAmount" style="width: 150px"  value="${bean.fAvailableAmount}"/>
											<input id="F_fBudgetIndexCode" hidden="hidden"  name="fBudgetIndexCode" style="width: 150px"  value="${bean.fBudgetIndexCode}"/>
										</td >
									</tr>
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;申请人</td>
										<td class="td2">
											<input id="F_fOperator"  class="easyui-textbox" readonly="readonly" name="fOperator" data-options="validType:'length[1,20]'" style="width: 150px" value="${bean.fOperator}"/>					
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1">&nbsp;&nbsp;申请时间</td>
										<td class="td2">
											<input id="F_fReqtIME"  class="easyui-datebox" readonly="readonly" name="fReqtIME" data-options="validType:'length[1,20]'" style="width: 150px" value="${bean.fReqtIME}"/>					
										</td>
									</tr>
									<%--<tr class="trbody">
										<td class="td1">质保期</td>
										<td class="td2">
											<input class="easyui-textbox" type="text" id="F_fWarrantyPeriod" name="fWarrantyPeriod"  data-options="validType:'length[1,20]'" style="width: 150px" value="${bean.fWarrantyPeriod}"/>
										</td>
										 <td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>项目编号</td>
										<td class="td2">
											<a onclick="fProCode_DC()"><input class="easyui-textbox" type="text" id="F_fProCode" name="fProCode"  data-options="prompt:'单击打开选取项目编号',validType:'length[1,20]'" style="width: 150px" value="${bean.fProCode}"/></a>
										</td> 
									</tr>--%>
									
									<tr class="trbody">
										<td class="td1">
											&nbsp;&nbsp;附件
											<input type="file" multiple="multiple" id="f" onchange="upFile()" hidden="hidden">
											<input type="text" id="files" name="files" hidden="hidden">
										</td>
										<td colspan="4" id="tdf">
											<%-- <a onclick="$('#f').click()" style="font-weight: bold;" href="#">
												<img src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
											</a> --%>
											<c:forEach items="${attac}" var="att">
												<div style="margin-top: 10px;">
													<a href='#' style="color: #666666;font-weight: bold;">${att.fAttacName}</a>
													<c:if test="${openType=='add'}">
													&nbsp;&nbsp;&nbsp;&nbsp;
													<img src="${base}/resource-modality/${themenurl}/sccg.png">
													&nbsp;&nbsp;&nbsp;&nbsp;
													<a id="${att.fAttacName}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
													</c:if>													
												</div>
											</c:forEach>
										</td>
									</tr>
									
									<tr style="height: 70px;">
										<td class="td1" valign="top">&nbsp;&nbsp;合同说明</td>
										<td  colspan="4">
											<input class="easyui-textbox" readonly="readonly" data-options="multiline:true" id="CF_fRemark" name="fRemark" style="width: 505px;height:70px" value="${bean.fRemark}">  
											<input type="text" id="CF_fFlowStauts" name="fFlowStauts" hidden="hidden" value="0"/>
										</td>
									</tr>
								</table>
							</div>
							<div title="基本信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
								<table cellpadding="0" cellspacing="0"  class="ourtable">
									<input type="hidden" name="fSignId" id="finish_fSignId" value="${signInfo.fSignId}"/>
										<tr class="trbody">
											<td class="td1" >&nbsp;&nbsp;签约方信息</td>
											<td>
												<input id="finish_fSignName" readonly="readonly" class="easyui-textbox" type="text"  name="fSignName" data-options="validType:'length[1,20]'" style="width: 150px;" value="${signInfo.fSignName}"/>
											</td>
											<td class="td4">&nbsp;</td>
											<td class="td1" >&nbsp;&nbsp;签约方类型</td>
											<td>
												<input class="easyui-combobox" readonly="readonly" id="finish_fSignType" name="fSignType" style="width: 150px;" data-options="editable:false,panelHeight:'auto',url:'${base}/Formulation/lookupsJson?parentCode=HTQYFLX&selected=${signInfo.fSignType}',method:'POST',valueField:'code',textField:'text',editable:false">
											</td>
										</tr>	
										<tr class="trbody">
											<td class="td1" >&nbsp;&nbsp;开户银行</td>
											<td>
												<input id="finish_fBankName" readonly="readonly" class="easyui-textbox" type="text" name="fBankName" data-options="validType:'length[1,20]'" style="width: 150px;" value="${signInfo.fBankName}"/>
											</td>
											<td class="td4">&nbsp;</td>
											<td class="td1" >&nbsp;&nbsp;银行账户</td>
											<td>
												<input id="finish_fCardNo" readonly="readonly" class="easyui-textbox" type="text"  name="fCardNo" data-options="validType:'length[1,20]'" style="width: 150px;" value="${signInfo.fCardNo}"/>
											</td>
										</tr>						
										<tr class="trbody">
											<td class="td1" >&nbsp;&nbsp;联系人</td>
											<td>
												<input id="finish_fConcUser" readonly="readonly" class="easyui-textbox" type="text"  name="fConcUser" data-options="validType:'length[1,20]'" style="width: 150px;" value="${signInfo.fConcUser}"/>
											</td>
											<td class="td4">&nbsp;</td>
											<td class="td1" >&nbsp;&nbsp;联系电话</td>
											<td>
												<input id="finish_fConcTel" readonly="readonly" class="easyui-textbox" type="text"  name="fConcTel" data-options="validType:'length[1,20]'" style="width: 150px;" value="${signInfo.fConcTel}"/>
											</td>
										</tr>						
										<tr class="trbody">
											<td class="td1" >&nbsp;&nbsp;签署人</td>
											<td>
												<input id="finish_fSignUser_SI" readonly="readonly" class="easyui-textbox" type="text"  name="fSignUser_SI" data-options="validType:'length[1,20]'" style="width: 150px;" value="${signInfo.fSignUser_SI}"/>
											</td>
											<td class="td4">&nbsp;</td>
											<td class="td1" >&nbsp;&nbsp;签署时间</td>
											<td>
												<input id="finish_fSignTime" readonly="readonly" class="easyui-datebox" class="dfinput" name="f_SignTime" data-options="validType:'length[1,20]'" style="width: 150px;" value="${signInfo.f_SignTime}"/>
											</td>
										</tr>						
									</table>		
							</div>
							<div title="付款计划" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
								<%@ include file="../change/change-edit-plan.jsp" %>
								<%-- <jsp:include page="filing-edit-plan.jsp"/>  --%>
							</div>
							<div title="附件信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">				
								<%-- <jsp:include page="filing_annex.jsp"/>  --%>
								<%@ include file="../change/change_annex.jsp" %>
							</div>
							<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
								<jsp:include page="../../check_history.jsp" />												
							</div>
							<div title="变更表" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
								<table class="ourtable">
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;预变更内容</td>
										<td colspan="4">
											<input hidden="hidden" type="text" id="Upt_fId_U" name="fId_U" value="${Upt.fId_U}"/>
											<input class="easyui-textbox"  type="text" id="Upt_fCoOld" name="fCoOld" data-options="validType:'length[1,50]'"   style="width: 505px;height:100px" value="${Upt.fCoOld}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1" >&nbsp;&nbsp;变更后内容</td>
										<td colspan="4">
											<input class="easyui-textbox"  type="text" id="Upt_fCoNew" name="fCoNew" data-options="validType:'length[1,50]'"   style="width: 505px;height:100px" value="${Upt.fCoNew}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;合同变更类型</td>
										<td>
											<input class="easyui-combobox" id="Upt_fContUptType" name="fContUptType" style="width: 150px;" data-options="editable:false,panelHeight:'auto',url:'${base}/Formulation/lookupsJson?parentCode=HTBGLX&selected=${Upt.fContUptType}',method:'POST',valueField:'code',textField:'text',editable:false">
										</td>
									</tr>
									<tr class="trbody">
									<td class="td1">
										&nbsp;&nbsp;变更附件
										<input type="file" multiple="multiple" id="f3" onchange="upFile3()" hidden="hidden">
										<input type="text" id="files3" name="files3" hidden="hidden">
									</td>
									<td colspan="4" id="tdf3">
										<%-- <c:if test="${openType=='add'||openType=='edit'}">
											<a onclick="$('#f3').click()" style="font-weight: bold;" href="#">
												<img src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
											</a>
										</c:if> --%>
										<c:forEach items="${changegattac}" var="changeatt">
											<div style="margin-top: 10px;">
												<a href='#' style="color: #666666;font-weight: bold;">${changeatt.fAttacName_AU}</a>
												<%-- <c:if test="${openType=='add'||openType=='edit'}">
														&nbsp;&nbsp;&nbsp;&nbsp;
														<img src="${base}/resource-modality/${themenurl}/sccg.png">
														&nbsp;&nbsp;&nbsp;&nbsp;
													<a id="${changeatt.fFileSrc_AU}" class="fileUrl3" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
												</c:if> --%>
											</div>
										</c:forEach>
									</td>
								</tr>
								</table>
							</div>	
							<div title="结项信息(填写)" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10">
								<table cellpadding="0" cellspacing="0"  class="ourtable">
									<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;结项类型</td>
										<td>
										<input hidden="hidden" name="fFiId" value="${Conclusion.fFiId}">
											<input class="easyui-combobox" id="finish_fFiType" <c:if test="${Conclusion.fFiType!=null}">readonly="readonly"</c:if>  style="width: 150px;" name="fFiType" data-options="editable:false,panelHeight:'auto',url:'${base}/Formulation/lookupsJson?parentCode=HTJXLX&selected=${Conclusion.fFiType}',method:'POST',valueField:'code',textField:'text',editable:false" >
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1" >&nbsp;&nbsp;结项说明</td>
										<td colspan="4">
											<input class="easyui-textbox" <c:if test="${Conclusion.fFiRemark!=null}">readonly="readonly"</c:if> type="text" id="finish_fFiRemark" name="fFiRemark" data-options="validType:'length[1,200]'"  style="width: 505px;height:100px" value="${Conclusion.fFiRemark}"/>
										</td>
									</tr>
									<tr class="trbody">
										<td class="td1">
											&nbsp;&nbsp;结项附件
											<c:if test="${conclusionattac==null}">
												<input type="file" multiple="multiple" id="f4" onchange="upFile4()" hidden="hidden">
												<input type="text" id="files4" name="files4" hidden="hidden">
											</c:if>
										</td>
										<td colspan="4" id="tdf4">
											<c:if test="${openType=='add'||openType=='edit'}">
												<a onclick="$('#f4').click()" style="font-weight: bold;" href="#">
													<img src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
												</a>
											</c:if>
											<c:forEach items="${conclusionattac}" var="changeatt">
												<div style="margin-top: 10px;">
													<a href='#' style="color: #666666;font-weight: bold;">${changeatt.fAttacName_C}</a>
													<c:if test="${openType=='add'||openType=='edit'}">
														&nbsp;&nbsp;&nbsp;&nbsp;
														<img src="${base}/resource-modality/${themenurl}/sccg.png">
														&nbsp;&nbsp;&nbsp;&nbsp;
													<a id="${changeatt.fAttacName_C}" class="fileUrl4" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
													</c:if>
												</div>
											</c:forEach>
										</td>
									</tr>
								</table>
							</div>
						</div>			
			
		
			</div>
			
			<div class="win-left-bottom-div">
				<c:if test="${openType=='add'||openType=='edit'}">
					<a href="javascript:void(0)" onclick="finishFrom();">
						<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;&nbsp;
				</c:if>
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<div class="win-right-div" data-options="region:'east',split:true">
			<jsp:include page="../../check_system.jsp" />
		</div>
	</div>
</form>
</div>
<script type="text/javascript">

$("#F_fContStartTime").datebox({
    onSelect : function(beginDate){
        $('#F_fContEndTime').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});
	/* $(document).ready(function(){ 
		var id=$('#Upt_fId_U').val();
		if(id ==null||id==""){
			$("#acc").accordion().accordion('remove','变更表');
		}
	}); */
	var c4=0;
	//附件上传
	function upFile4() {
		var url = $("#f4").val();
		var urlli = url.split(',');
		for(var i=0; i< urlli.length; i++){
			var fileurl=urlli[i];
			var filename = fileurl.split('\\');
			$('#tdf4').append(
				"<div style='margin-top: 10px;'>"+
					"<a href='#' style='color: #666666;font-weight: bold;'>"+filename[filename.length-1]+"</a>"+
					"&nbsp;&nbsp;&nbsp;&nbsp;"+
					"<img id='imgtce"+c4+"' style='display:none' src='"+base+"/resource-modality/${themenurl}/sccg.png'>"+
					"<img id='imgfce"+c4+"' style='display:none' src='"+base+"/resource-modality/${themenurl}/scsb.png'>"+
					"&nbsp;&nbsp;&nbsp;&nbsp;<a id='"+fileurl+"' class='fileUrl4' href='#' style='color:red' onclick='deleteAttac(this)'>删除</a><div>"
			);
			c4++;
			fileurl = encodeURI(encodeURI(fileurl));
			$.ajax({
				async:false,
				type:"POST",
		        url:base+"/Conclusion/conclusionFile?fileurl="+fileurl,
		        success:function(data){
			    	if($.trim(data)=="true"){
						$('#imgtce'+i).css('display','');
			    	} else {
						$('#imgfce'+i).css('display','');
			    	}
		        }
		    });
		}	
	} 
	
	//附件删除AJAX
	function deleteAttac(a){
		var filename = a.id;
		filename = encodeURI(encodeURI(filename));  
		$.ajax({
			type:"POST",
	        url:base+"/Conclusion/conclusionFileDelete?filename="+filename,
	        success:function(data){
	        	if($.trim(data)=="true"){
					//删除div
		        	$(a).parent().remove();
	        		alert("附件删除成功！");
	        	} else {
	        		alert("附件删除失败！");
	        	}
	        }
	    });
	}
	$('#finish_fcType').combobox({  
        onChange:function(newValue,oldValue){  
    	var sel2=$('#finish_fcType').combobox('getValue');
    	if(sel2!="1"){
    		$('#finish1').hide();
    		//$('#finish2').hide();
    		//$('#finish_fPurchNo').next(".textbox").show();
		}else{
    		$('#finish1').show();
    		//$('#finish2').show();
    		//$('#finish_fPurchNo').next(".textbox").hide();
		} 
        }
    }); 
	function finishFrom(){
		var s="";
		$(".fileUrl4").each(function(){
			s=s+$(this).attr("id")+",";
		});
		$("#files4").val(s); 
		
		var plan = getPlan();
    	$('#Conclusion').form('submit', {
				onSubmit:function(param){ 
					param.planJson=plan;
					flag=$(this).form('enableValidation').form('validate');
					if(flag){
						$.messager.progress();
					}
					return flag;
				}, 
				url:'${base}/Conclusion/save',
				type:'post',
				success:function(data){
					if(flag){
						$.messager.progress('close');
					}
					data=eval("("+data+")");
					if(data.success){
						$.messager.alert('系统提示', data.info, 'info');
						closeWindow();
						$('#conclusion_dg').form('clear');
						$('#conclusion_dg').datagrid('reload'); 
					}else{
						$.messager.alert('系统提示', data.info, 'error');
						closeWindow();
						$('#conclusion_dg').form('clear');
					}
				} 
			});		
		}
		function fPurchNo_DC(){
			//var node=$('#conclusion_dg').datagrid('getSelected');
			var win=creatFirstWin('选择-采购订单号',750,550,'icon-add','/PurchaseApply/PurchNoList');
			win.window('open');
		}
		function quota_DC(){
			//var node=$('#conclusion_dg').datagrid('getSelected');
			var win=creatFirstWin('选择-预算指标编号',750,550,'icon-add','/BudgetIndexMgr/contract_list');
			win.window('open');
		}
		var a =0;
		function upt_upFile() {
			/* console.log(document.getElementById("finish_fFileSrc1"));
			var src = getFilePath();
			alert(getFilePath()); */
			a ++;
			var src = $('#finish_fFileSrc1').val();
			/* var srcs =src+','+$('#finish_fi1').val();
			$('#finish_fi1').val(srcs); */
			$('#finish__f1').append("<div id='a"+a+"'><a href='#' class='file_finish' style='color: #3f7f7f;font-weight: bold;'>"+src+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a style='color: red;' href='#' onclick='deleteF1(a"+a+")'>删除</a></div>");
		} 
		function deleteF1(val){
			var child=document.getElementById(val.id);
			child.parentNode.removeChild(child);
		}
		function fresult(val, row) {
			if (val == 1) {
				return '<span style="color:green">' + " 通过" + '</span>';
			} else if (val == 0) {
				return '<span style="color:red">' + " 未通过" + '</span>';
			}
		}
	</script>
</body>