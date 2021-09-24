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
.tabDiv{padding:10px;}
.ourtable{font-size: 12px;width: 847px;}
.trtop{height: 10px;}
.trbody{height: 30px;}
.td1{width: 100px;}
.td2{height: 40px;width: 240px;}
.style1{color: red;}
.numberbox .textbox-text {
text-align: left;
}
</style> 
	<script type="text/javascript">
	$(document).ready(function(){ 
		var id=$('#Upt_fId_U').val();
		if(id ==null||id==""){
			$("#acc").accordion().accordion('remove','变更表');
		}
	});
		
	
	
	$('#upt_fcType').combobox({  
        onChange:function(newValue,oldValue){  
    	var sel2=$('#upt_fcType').combobox('getValue');
    	if(sel2!="1"){
    		$('#cg1').hide();
    		//$('#cg2').hide();
    		//$('#upt_fPurchNo').next(".textbox").show();
		}else{
    		$('#cg1').show();
    		//$('#cg2').show();
    		//$('#upt_fPurchNo').next(".textbox").hide();
		} 
        }
    }); 
	function ArchivingEditForm(){
		
		var a = $(".file_U");
		var srcs;
	    for(var i=0;i<a.length;i++){
			if(i==0){
				srcs=a[i].text;
			}else{
				srcs =srcs+','+a[i].text;
			}
			$('#upt_fi1').val(srcs);
	    }   
		
		var plan = getPlan();
		//console.log($('#upt_fFileSrc1').val());
    	$('#uptInfo').form('submit', {
				onSubmit:function(param){ 
					param.planJson=plan;
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
						$.messager.alert('系统提示', data.info, 'info');
						closeWindow();
						$('#archiving_dg').form('clear');
						$('#archiving_dg').datagrid('reload'); 
					}else{
						$.messager.alert('系统提示', data.info, 'error');
						closeWindow();
						$('#archiving_dg').form('clear');
					}
				} 
			});		
		}
		function fPurchNo_DC(){
			//var node=$('#archiving_dg').datagrid('getSelected');
			var win=creatFirstWin('选择-采购订单号',750,550,'icon-add','/PurchaseApply/PurchNoList');
			win.window('open');
		}
		function quota_DC(){
			//var node=$('#archiving_dg').datagrid('getSelected');
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
			$('#upt__f1').append("<div id='c"+c+"'><a href='#' class='file_U' style='color: #3f7f7f;font-weight: bold;'>"+src+"</a>&nbsp;&nbsp;&nbsp;&nbsp;<a style='color: red;' href='#' onclick='deleteF1(c"+c+")'>删除</a></div>");
		} 
		function deleteF1(val){
			var child=document.getElementById(val.id);
			child.parentNode.removeChild(child);
		}
	</script>
    <div class="easyui-layout" fit="true">
    	<div region="center" border="false">
			<form id="uptInfo" action="${base}/Archiving/Save"  method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	    	<%-- <form id="ArchivingEditForm" action="${base}/Formulation/save" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data"> --%>
	    		<input type="hidden" name="fcId" id="upt_fcId" value="${bean.fcId}"/>
	    		<input type="hidden" name="fFlowStauts" id="upt_fFlowStauts" value="${bean.fFlowStauts}"/>
	    		<input type="hidden" name="fContStauts" id="upt_fContStauts" value="${bean.fContStauts}"/>
	    		<input type="hidden" name="fUserName" id="upt_fUserName" value="${bean.fUserName}"/>
	    		<input type="hidden" name="fUserCode" id="upt_fUserCode" value="${bean.fUserCode}"/>
	    		<%-- <c:if test="${fn:length(bean.id)>0}">
	    			<input type="hidden" name="islocked" value="${bean.islocked}"/>
	    			<input type="hidden" name="status" value="${bean.status}"/>
	    		</c:if> --%>
	    		
	    		<table class="ourtable" border="0" style="height: 610px;">
				<tr class="trbody">
					<td style="vertical-align: top;">
						<%-- <div class="easyui-accordion" id="acc" data-options="multiple:true" style="width:860px;">
						<div title="合同信息" data-options="iconCls:'icon-xxlb',selected:true" style="overflow:auto;padding:10px;">
							<table class="ourtable" >
								<tr class="trbody">
									<td class="td1">合同编号</td>
									<td colspan="4">
										<input id="upt_fcCode" class="easyui-textbox" type="text" readonly="readonly" name="fcCode" data-options="validType:'length[1,20]'" style="width: 713" value="${bean.fcCode}"/>
									</td >
								</tr>
								<tr class="trbody">
									<td class="td1">合同名称<b style="color: red">*</b>：</td>
									<td colspan="4">
										<input class="easyui-textbox" type="text" id="upt_fcTitle" readonly="readonly" name="fcTitle"required="required" data-options="validType:'length[1,20]'" style="width: 713" value="${bean.fcTitle}"/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" >合同分类</td>
									<td >
										<select class="easyui-combobox" id="upt_fcType" name="fcType" readonly="readonly" style="width: 230px;" data-options="editable:false,panelHeight:'auto'">
											<option  id="op1" value="${bean.fcType}"></option>
											<option value="1" <c:if test="${bean.fcType=='1'}">selected="selected"</c:if>>支出合同</option>
											<option value="2" <c:if test="${bean.fcType=='2'}">selected="selected"</c:if>>收入合同</option>
											<option value="3" <c:if test="${bean.fcType=='3'}">selected="selected"</c:if>>非经济合同</option>
										</select>
									</td>
									<td style="width: 110px">&nbsp;</td>
									<td class="td1">合同份数<b style="color: red">*</b>：</td>
									<td >
										<input id="upt_fcNum"  class="easyui-textbox" type="text" readonly="readonly" required="true" name="fcNum" data-options="validType:'length[1,20]'" style="width: 230px;" value="${bean.fcNum}"/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1">合同金额</td>
									<td >
										<input class="easyui-textbox" type="text" id="upt_fcAmount" readonly="readonly" name="fcAmount" data-options="validType:'length[1,20]'" style="width: 230px;" value="${bean.fcAmount}"/>
									</td>
									<td style="width: 110px">&nbsp;</td>
									<td class="td1">申请人：</td>
									<td >
										<input id="upt_fOperator" class="easyui-textbox" type="text" readonly="readonly" name="fOperator" data-options="validType:'length[1,20]'" style="width: 230px;" value="${bean.fOperator}"/>
									</td >
								</tr>
								<tr id="cg1" hidden="hidden">
									<td class="td1">采购订单号</td>
									<td >
										<a  onclick="fPurchNo_DC()"><input  class="easyui-textbox" readonly="readonly" hidden="hidden" id="upt_fPurchNo" name="fPurchNo"  data-options="prompt:'单击选取采购订单号',validType:'length[1,50]'" style="width: 230px;" value="${bean.fPurchNo}"/></a>
									</td>
								</tr>
								<tr id="cg2" hidden="hidden">
									<td >预算指标编号</td>
									<td >
										<a onclick="quota_DC()"><input id="upt_fBudgetIndexCode" class="easyui-textbox" name="fBudgetIndexCode" data-options="prompt:'单击选取预算指标编号',validType:'length[1,50]'" style="width: 230px;" value="${bean.fBudgetIndexCode}"/></a>
									</td >
									<td >预算指标名称</td>
									<td >
										<input id="upt_fBudgetIndexName" class="easyui-textbox" name="fBudgetIndexName" data-options="validType:'length[1,20]'" style="width: 230px;" value="${bean.fBudgetIndexName}"/>
									</td >
								</tr>
								<tr class="trbody">
									<td class="td1">所属部门</td>
									<td >
										<input id="upt_fDeptName"" class="easyui-textbox" type="text" readonly="true" name="fDeptName" data-options="validType:'length[1,20]'" style="width: 230px;" value="${bean.fDeptName}"/>
									</td >
									<td style="width: 110px">&nbsp;</td>
									<td class="td1">申请时间<b style="color: red">*</b>：</td>
									<td >
										<input class="easyui-datebox" class="dfinput" id="upt_fReqtIME" readonly="true" name="fReqtIME"  data-options="validType:'length[1,20]'" style="width: 230px;" value="${bean.fReqtIME}"/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1">合同开始时间</td>
									<td >
										<input id="upt_fContStartTime" class="easyui-datebox" class="dfinput" readonly="true"  name="fContStartTime" data-options="validType:'length[1,20]'" style="width: 230px;" value="${bean.fContStartTime}"/>
									</td >
									<td style="width: 110px">&nbsp;</td>
									<td class="td1">合同结束时间</td>
									<td >
										<input class="easyui-datebox" class="dfinput"  id="upt_fContEndTime" readonly="true" name="fContEndTime"  data-options="validType:'length[1,20]'" style="width: 230px;" value="${bean.fContEndTime}"/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1">合同签署人</td>
									<td >
										<input id="upt_fSignUser"  class="easyui-textbox" type="text" readonly="readonly" name="fSignUser" data-options="validType:'length[1,20]'" style="width: 230px;" value="${bean.fSignUser}"/>
									</td >
									<td style="width: 110px">&nbsp;</td>
									<td class="td1">合同签署时间</td>
									<td >
										<input class="easyui-datebox" class="dfinput"  id="upt_fSignTime" readonly="true" name="fSignTime"  data-options="validType:'length[1,20]'" style="width: 230px;" value="${bean.fSignTime}"/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1">保证金金额</td>
									<td >
										<input id="upt_fMarginAmount"  class="easyui-textbox" type="text" readonly="readonly" name="fMarginAmount" data-options="validType:'length[1,20]'" style="width: 230px;" value="${bean.fMarginAmount}"/>
									</td >
									<td style="width: 110px">&nbsp;</td>
									<td class="td1">是否委托授权</td>
									<td>
										<select class="easyui-combobox" id="upt_fIsAuthor" name="fIsAuthor" readonly="readonly"  style="width: 230px;" data-options="editable:false,panelHeight:'auto'">
											<option value="${bean.fIsAuthor}"></option>
											<option value="0" <c:if test="${bean.fIsAuthor=='0'}">selected="selected"</c:if>>否</option>
											<option value="1" <c:if test="${bean.fIsAuthor=='1'}">selected="selected"</c:if>>是</option>
										</select>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1">质保期</td>
									<td >
										<input class="easyui-textbox" type="text" id="upt_fWarrantyPeriod" readonly="readonly" name="fWarrantyPeriod"  data-options="validType:'length[1,20]'" style="width: 230px;" value="${bean.fcAmount}"/>
									</td>
								</tr>
								<tr class="trbody">
										<td class="td1">&nbsp;&nbsp;附件</td>
										<td id="upt__f1">
											<a onclick="$('#upt_fFileSrc1').click()" style="font-weight: bold;" href="#">上传文件</a>
											<input readonly="readonly" type="file" id="upt_fFileSrc1"  style="width: 584px;" onchange="upt_upFile()"  hidden="hidden"></br>
											<input type="text" id="upt_fi1" name="fFileSrc_AU" hidden="hidden">
										</td>
									</tr>
								<tr class="trbody">
									<td class="td1">合同说明</td>
									<td colspan="4">
										<input class="easyui-textbox" type="text" id="CF_fRupt_ark" readonly="readonly" name="fRemark" data-options="validType:'length[1,50]',multiline:true"   style="width:713px;height:100px" value="${bean.fRemark}"/>
									</td>
								</tr>
							</table>
						</div>
						<div title="基本信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;padding:10px;">
							<table class="ourtable">
								<input type="hidden" name="fSignId" id="upt_fSignId" value="${signInfo.fSignId}"/>
									<tr class="trbody">
										<td class="td1">签约方信息</td>
										<td>
											<input id="f_fSignName" readonly="readonly" class="easyui-textbox" type="text"  name="fSignName" data-options="validType:'length[1,20]'" style="width: 230px;" value="${signInfo.fSignName}"/>
										</td>
										<td style="width: 110px">&nbsp;</td>
										<td class="td1">签约方类型</td>
										<td>
											<select class="easyui-combobox" readonly="readonly" id="f_fSignType" name="fSignType" style="width: 230px;" data-options="editable:false,panelHeight:'auto'">
												<option value="1" <c:if test="${signInfo.fSignType=='1'}">selected="selected"</c:if>>单位</option>
												<option value="2" <c:if test="${signInfo.fSignType=='2'}">selected="selected"</c:if>>个人</option>
											</select>
										</td>
									</tr>	
									<tr class="trbody">
										<td class="td1">开户银行</td>
										<td>
											<input id="f_fBankName" readonly="readonly" class="easyui-textbox" type="text" name="fBankName" data-options="validType:'length[1,20]'" style="width: 230px;" value="${signInfo.fBankName}"/>
										</td>
										<td style="width: 110px">&nbsp;</td>
										<td class="td1">银行账户</td>
										<td>
											<input id="f_fCardNo" readonly="readonly" class="easyui-textbox" type="text"  name="fCardNo" data-options="validType:'length[1,20]'" style="width: 230px;" value="${signInfo.fCardNo}"/>
										</td>
									</tr>						
									<tr class="trbody">
										<td class="td1">联系人</td>
										<td>
											<input id="f_fConcUser" readonly="readonly" class="easyui-textbox" type="text"  name="fConcUser" data-options="validType:'length[1,20]'" style="width: 230px;" value="${signInfo.fConcUser}"/>
										</td>
										<td style="width: 110px">&nbsp;</td>
										<td class="td1">联系电话</td>
										<td>
											<input id="f_fConcTel" readonly="readonly" class="easyui-textbox" type="text"  name="fConcTel" data-options="validType:'length[1,20]'" style="width: 230px;" value="${signInfo.fConcTel}"/>
										</td>
									</tr>						
									<tr class="trbody">
										<td class="td1">签署人</td>
										<td>
											<input id="f_fSignUser_SI" readonly="readonly" class="easyui-textbox" type="text"  name="fSignUser_SI" data-options="validType:'length[1,20]'" style="width: 230px;" value="${signInfo.fSignUser_SI}"/>
										</td>
										<td style="width: 110px">&nbsp;</td>
										<td class="td1">签署时间</td>
										<td>
											<input id="f_fSignTime" readonly="readonly" class="easyui-datebox" class="dfinput" name="f_SignTime" data-options="validType:'length[1,20]'" style="width: 230px;" value="${signInfo.f_SignTime}"/>
										</td>
									</tr>						
								</table>		
							</div>
						<div title="付款计划" data-options="iconCls:'icon-xxlb'" style="overflow:auto;padding:10px;">
							<%@ include file="archiving-edit-plan.jsp" %>
							<jsp:include page="filing-edit-plan.jsp"/> 
						</div>
						<div title="附件信息" data-options="iconCls:'icon-xxlb'" style="overflow:auto;padding:10px;">
							<jsp:include page="filing_annex.jsp"/> 
							<%@ include file="archiving_annex.jsp" %>
						</div>
						<div title="变更表" data-options="iconCls:'icon-xxlb'" style="overflow:auto;padding:10px;"> 
							<table class="ourtable">
								<tr style="height: 109px;">
									<td class="td1"  >预变更内容</td>
									<td colspan="4">
										<input hidden="hidden" type="text" id="Upt_fId_U" name="fId_U" value="${upt.fId_U}"/>
										<input class="easyui-textbox" readonly="readonly" id="Upt_fCoOld" name="fCoOld" data-options="validType:'length[1,50]'"   style="width:713px;height:100px" value="${upt.fCoOld}"/>
									</td>
								</tr>
								<tr style="height: 109px;">
									<td class="td1" >变更后内容</td>
									<td colspan="4">
										<input class="easyui-textbox" readonly="readonly" type="text" id="Upt_fCoNew" name="fCoNew" data-options="validType:'length[1,50]'"   style="width:713px;height:100px" value="${upt.fCoNew}"/>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1" >变更类型</td>
									<td colspan="4">
										<select class="easyui-combobox" id="Upt_fContUptType" name="fContUptType" readonly="readonly" style="width: 230px;" data-options="editable:false,panelHeight:'auto'">
											<option value="1" <c:if test="${upt.fContUptType=='1'}">selected="selected"</c:if>>补充合同</option>
											<option value="2" <c:if test="${upt.fContUptType=='2'}">selected="selected"</c:if>>变更合同</option>
										</select>
									</td>
								</tr>
								<tr class="trbody">
									<td class="td1">&nbsp;&nbsp;附件</td>
									<td id="upt__f1">
										<a onclick="$('#upt_fFileSrc1').click()" style="font-weight: bold;" href="#">上传文件</a>
										<input readonly="readonly" type="file" id="upt_fFileSrc1"  style="width: 584px;" onchange="upt_upFile()"  hidden="hidden"></br>
										<input type="text" id="upt_fi1" name="fFileSrc_AU" hidden="hidden">
									</td>
								</tr>
								</table>
							</div>	--%>
						<div title="归档信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;padding:10px;">
							<table class="ourtable">
								<tr class="trbody">
									<td class="td1">归档位置</td>
									<td colspan="4">
										<input class="easyui-textbox"  id="a_fToPosition" name="fToPosition" <c:if test="${archiving.fToPosition!=null}">readonly="readonly"</c:if> required="required" data-options="validType:'length[1,50]',prompt:'请填写具体归档位置'" style="width: 713" value="${archiving.fToPosition}"/>
									</td>
								</tr>
							</table>
						</div>
					</div>
			</form>
		</div>
		<div region="south" border="false" class="south">
			<a href="javascript:void(0)" onclick="ArchivingEditForm()"><img src="${base}/resource-modality/${themenurl}/skin_/baocun.png"></a> 
			<a href="javascript:void(0)"  onclick="closeWindow()"><img src="${base}/resource-modality/${themenurl}/skin_/guanbi.png"></a>
			<!-- <a href="javascript:void(0)" class="easyui-linkbutton"  onclick="deleteCF();">删除</a> -->
		</div>
	</div>
	
</body>
</html>

