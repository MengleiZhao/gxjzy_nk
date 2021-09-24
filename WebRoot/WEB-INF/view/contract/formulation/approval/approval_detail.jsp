<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
<style type="text/css">
.textbox-text:read-only{background-color: #f6f6f6;color: #999999} 
.textbox-readonly{background-color: #f6f6f6;color: #999999}
.textbox-text{color:#666666;height: 25px; line-height: 25px}
.style1{color: red;height: 40px;}
.numberbox .textbox-text {text-align: left;}
.tabDiv{padding:10px;}
.ourtable{font-size: 12px;width: 550px;color: #666666;font-family: "微软雅黑"}
.ourtable2{font-size: 12px;color: #666666;font-family: "微软雅黑"}
.td1{width: 100px;}
.td2{height: 30px;width: 150px;}
.trtop{height: 10px;}
.trbody{height: 30px;}
</style>  
	<script type="text/javascript">
    $('#F_fcType').combobox({  
        onChange:function(newValue,oldValue){  
    	var sel2=$('#F_fcType').combobox('getValue');
    	if(sel2!="1"){
    		$('#cg1').hide();
    		//$('#cg2').hide();
    		//$('#F_fPurchNo').next(".textbox").show();
		}else{
    		$('#cg1').show();
    		//$('#cg2').show();
    		//$('#F_fPurchNo').next(".textbox").hide();
		} 
        }
    }); 
		function approve(stauts){
			$('#ApprovalAddEditForm').form('submit', {
   				onSubmit: function(){ 
   					flag=$(this).form('enableValidation').form('validate');
   					if(flag){
   						$.messager.progress();
   					}
   					return flag;
   				}, 
   				url:'${base}/Approval/approve/'+stauts,
   				data:{'fFlowStauts':stauts,'Id':${bean.fcId}},
   				success:function(data){
   					if(flag){
   						$.messager.progress('close');
   					}
   					data=eval("("+data+")");
   					if(data.success){
   						$.messager.alert('系统提示', data.info, 'info');
   						closeFirstWindow();
   						$('#ApprovalAddEditForm').form('clear');
   						$("#CF_app_dg").datagrid('reload'); 
   					}else{
   						$.messager.alert('系统提示', data.info, 'error');
   						closeFirstWindow();
   						$('#ApprovalAddEditForm').form('clear');
   					}
   				} 
   			});		
		}
		
		function fPurchNo_DC(){
			//var node=$('#CF_dg').datagrid('getSelected');
			var win=creatFirstWin('选择-采购订单号',750,550,'icon-add','/PurchaseApply/PurchNoList');
			win.window('open');
		}
		function quota_DC(){
			//var node=$('#CF_dg').datagrid('getSelected');
			var win=creatFirstWin('选择-预算指标编号',750,550,'icon-add','/BudgetIndexMgr/contract_list');
			win.window('open');
		}
		

		$("#F_fContStartTime").datebox({
		    onSelect : function(beginDate){
		        $('#F_fContEndTime').datebox().datebox('calendar').calendar({
		            validator: function(date){
		                return beginDate <= date;
		            }
		        });
		    }
		});
	</script>
    <div class="easyui-layout" fit="true" >
	    	<form id="ApprovalAddEditForm" action="${base}/Formulation/save" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	    		<%-- <input type="hidden" name="fcId" id="C_fcId" value="${bean.fcId}"/> --%>
	    		<input type="hidden" name="Id" id="C_fcId" value="${bean.fcId}"/>
	    		
	    		<%-- <c:if test="${fn:length(bean.id)>0}">
	    			<input type="hidden" name="islocked" value="${bean.islocked}"/>
	    			<input type="hidden" name="status" value="${bean.status}"/>
	    		</c:if> --%>
	    		<div data-options="region:'west',split:true"style="width:600px;border-color: dce5e9" id="westDiv">
	    		<table >
				<tr>
					<td style="vertical-align: top;">
						<div class="easyui-accordion" style="width:555px;margin-left: 20px;">
							<div title="合同信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top:10px;">	
								<table cellpadding="0" cellspacing="0" class="ourtable" border="0">
									<tr class="trbody">
										<td class="td1">合同编号</td>
										<td  colspan="4">
											<input id="F_fcCode" class="easyui-textbox" type="text" readonly="readonly" name="fcCode" data-options="prompt:'系统自动生成',validType:'length[1,20]'" value="${bean.fcCode}" style="width: 450"/> 
										</td>								
									</tr>
									
									<tr class="trbody">
										<td class="td1">合同名称</td>
										<td  colspan="4">
											<input class="easyui-textbox" type="text" id="F_fcTitle" readonly="readonly" name="fcTitle"required="required" data-options="validType:'length[1,50]'" value="${bean.fcTitle}" style="width: 450"/>
										</td>
									</tr>
									
									<tr class="trbody">
										<td class="td1">合同分类</td>
										<td class="td2">
											<select class="easyui-combobox" id="F_fcType" name="fcType" readonly="readonly" style="width: 150px;" data-options="editable:false,panelHeight:'auto',url:'${base}/Formulation/lookupsJson?parentCode=HTFL&seleted=${bean.fcCode}',method:'POST',valueField:'code',textField:'text',editable:false">
												<%-- <option value="2" <c:if test="${bean.fcCode=='2' }" >selected="selected"</c:if>>收入合同</option>
												<option value="1" <c:if test="${bean.fcCode=='1' }" >selected="selected"</c:if>>支出合同</option>
												<option value="3"<c:if test="${bean.fcCode=='3' }" >selected="selected"</c:if>>非经济合同</option> --%>
											</select>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1">合同份数</td>
										<td class="td2">
											<input id="F_fcNum"  class="easyui-numberbox" readonly="readonly" type="text" required="true" name="fcNum" data-options="validType:'length[1,20]'"  value="${bean.fcNum}" style="width: 150"/>
										</td>
									</tr>
									
									<tr class="trbody">
										<td class="td1">合同金额</td>
										<td class="td2">
											<input class="easyui-numberbox" type="text" readonly="readonly" id="F_fcAmount" name="fcAmount" data-options="icons: [{iconCls:'icon-wanyuan'}]" value="${bean.fcAmount}" style="width: 150"/>
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1">质保期</td>
										<td class="td2">
											<input class="easyui-textbox" type="text" readonly="readonly" id="F_fWarrantyPeriod" name="fWarrantyPeriod"  data-options="validType:'length[1,20]'" style="width: 150" value="${bean.fWarrantyPeriod}"/>
										</td>
										<%-- <td class="td1">申请时间</td>
										<td class="td2">
											<input class="easyui-datebox" class="dfinput" id="F_fReqtIME" name="fReqtIME"  data-options="validType:'length[1,20]'" style="width: 150" value="${bean.fReqtIME}"/>
										</td> --%>
									</tr>
									
									
									
									<tr class="trbody">
										<td class="td1">合同开始时间</td>
										<td class="td2">
											<input id="F_fContStartTime" class="easyui-datebox" readonly="readonly" class="dfinput"  name="fContStartTime" data-options="validType:'length[1,20]'" style="width: 150" value="${bean.fContStartTime}"/>					
										</td>
										
										<td class="td4">&nbsp;</td>
										
										<td class="td1">合同结束时间</td>
										<td class="td2">
											<input class="easyui-datebox" class="dfinput" readonly="readonly" id="F_fContEndTime" name="fContEndTime"  data-options="validType:'length[1,20]'" style="width: 150" value="${bean.fContEndTime}"/>
										</td>
									</tr>
									
									<tr class="trbody">
										<td class="td1">合同签署人</td>
										<td class="td2">
											<input id="F_fSignUser"  class="easyui-textbox" readonly="readonly" type="text" name="fSignUser" data-options="validType:'length[1,20]'" style="width: 150" value="${bean.fSignUser}"/>					
										</td>
										
										<td class="td4">&nbsp;</td>
										
										<td class="td1">合同签署时间</td>
										<td class="td2">
											<input class="easyui-datebox" class="dfinput" readonly="readonly" id="F_fSignTime" name="fSignTime"  data-options="validType:'length[1,20]'" style="width: 150" value="${bean.fSignTime}"/>
										</td>
									</tr>
									
									<tr class="trbody">
										<td class="td1">保证金金额</td>
										<td class="td2">
											<input id="F_fMarginAmount"  class="easyui-numberbox" readonly="readonly" type="text" name="fMarginAmount" data-options="validType:'length[1,20]',prompt:'(元)',precision:2" style="width: 150" value="${bean.fMarginAmount}"/>
										</td >
										<td class="td4">&nbsp;</td>
										<td class="td1">是否委托授权</td>
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
										<td class="td1">采购订单号</td>
										<td  colspan="4">
											<a onclick="fPurchNo_DC()"><input id="F_fPurchNo" readonly="readonly" class="easyui-textbox" name="fPurchNo" data-options="prompt:'单击打开选取采购订单号',validType:'length[1,50]'" value="${bean.fPurchNo}" style="width: 450"/></a>
										</td>
									</tr>
									<tr id="cg2" hidden="hidden" class="trbody">
										<td class="td1">预算指标名称</td>
										<td >
											<input id="F_fBudgetIndexName" class="easyui-textbox" readonly="readonly" name="fBudgetIndexName" data-options="validType:'length[1,20]'" style="width: 150" value="${bean.fBudgetIndexName}"/>
										</td >
										<td class="td4">&nbsp;</td>
										<td class="td1">预算指标金额</td>
										<td >
											<input id="F_fAvailableAmount" class="easyui-textbox" readonly="readonly" name="fAvailableAmount" style="width: 150"  value="${bean.fAvailableAmount}"/>
											<input id="F_fBudgetIndexCode" hidden="hidden"  name="fBudgetIndexCode" style="width: 150"  value="${bean.fBudgetIndexCode}"/>
										</td >
									</tr>
									<tr class="trbody">
										<td class="td1">申请人</td>
										<td class="td2">
											<input id="F_fOperator"  class="easyui-textbox" readonly="readonly" name="fOperator" data-options="validType:'length[1,20]'" style="width: 150" value="${bean.fOperator}"/>					
										</td>
										<td class="td4">&nbsp;</td>
										<td class="td1">申请时间</td>
										<td class="td2">
											<input id="F_fReqtIME"  class="easyui-datebox" readonly="readonly" name="fReqtIME" data-options="validType:'length[1,20]'" style="width: 150" value="${bean.fReqtIME}"/>					
										</td>
									</tr>
									<%--<tr class="trbody">
										<td class="td1">质保期</td>
										<td class="td2">
											<input class="easyui-textbox" type="text" id="F_fWarrantyPeriod" name="fWarrantyPeriod"  data-options="validType:'length[1,20]'" style="width: 150" value="${bean.fWarrantyPeriod}"/>
										</td>
										 <td class="td4">&nbsp;</td>
										<td class="td1"><span class="style1">*</span>项目编号</td>
										<td class="td2">
											<a onclick="fProCode_DC()"><input class="easyui-textbox" type="text" id="F_fProCode" name="fProCode"  data-options="prompt:'单击打开选取项目编号',validType:'length[1,20]'" style="width: 150" value="${bean.fProCode}"/></a>
										</td> 
									</tr>--%>
									
									<tr class="trbody">
										<td class="td1">
											附件
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
													
													<img src="${base}/resource-modality/${themenurl}/sccg.png">
													
													<a id="${att.fAttacName}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
												</div>
											</c:forEach>
										</td>
									</tr>
									
									<tr style="height: 70px;">
										<td class="td1" valign="top">合同说明</td>
										<td  colspan="4">
											<input class="easyui-textbox" readonly="readonly" data-options="multiline:true" id="CF_fRemark" name="fRemark" style="width:450px;height:70px" value="${bean.fRemark}">  
											<input type="text" id="CF_fFlowStauts" name="fFlowStauts" hidden="hidden" value="0"/>
										</td>
									</tr>
								</table>
							</div>
							</div>
				</tr>
				<%-- <tr style="height: 50px;text-align: center;">
					<td>
						<a href="javascript:void(0)" onclick="closeWindow();"><img src="${base}/resource-modality/${themenurl}/skin_/guanbi.png"></a>
					</td>
				</tr> --%>
			</table>
			</div>
			<div data-options="region:'center',split:true"
				style="width: 8xp;height: 100%;background-color: #f0f5f7;border-color: #f0f5f7"></div>


			<div data-options="region:'east',split:true" style="width:190px;border-color: #dce5e9">
				<table class="ourtable2" style="width: 150px;margin-left: 20px;" cellpadding="0" cellspacing="0">
					<tr>
						<td style="height: 28px;"><span style="color: ff6800">相关制度</span></td>
					</tr>
					<tr>
					<td valign="top">
						<img src="${base}/resource-modality/${themenurl}/skin_/hengxian.png" style="width: 150px">
					</td>
					</tr>
					<tr>
						<td style="height: 31px;">
							<input class="easyui-textbox" style="width:150px;"
							data-options="prompt: '搜索' ,icons: [{iconCls:'icon-sousuo',handler: function(e){}}]">
						</td>
					</tr>
					<c:forEach items="${cheterInfo}" var="li">
						<tr style="height: 30px;">
							<td>
								<a style="color: #666666" id="file${li.systemId}" href="#" onclick="findSystemFile(${li.systemId})">${li.fileName}</a>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			
			<div data-options="region:'south'" style="height: 51px;width: 100%; border: 0px;">
					<div style="width:598px;height: 50px;text-align: center;float: left;border:1px solid #dce5e9;border-top: 0px">
						<a href="javascript:void(0)" onclick="closeWindow()">
							<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</div>
					<div style="width: 8px;height:50px;border: 1px solid #f0f5f7;border-left:0px;border-right:0px; border-top:0px ;background-color: #f0f5f7;float: left;"></div>
					<div style="width: 188px;height:50px;border:1px solid #dce5e9;float: left;border-top: 0px"></div>
			</div>	
			</form>
		</div>
	</div>
</body>
</html>

