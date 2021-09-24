<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="win-div">
<form id="changeInfo" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 10px;">
			<div class="win-left-top-div">
				<input type="hidden" name="fcId" id="F_fcId" value="${bean.fcId}"/>
	    		<input type="hidden" name="fUptFlowStauts" id="F_fUptFlowStauts" value="${Upt.fUptFlowStauts}"/>
	    		<input type="hidden" name="fId_U" id="F_fId_U" value="${Upt.fId_U}"/>
	    		<input type="hidden" name="fContId_U" id="F_fContId_U" value="${Upt.fContId_U}"/>
	    		<input type="hidden" name="fUptCode" id="F_fUptCode" value="${Upt.fUptCode}"/>
	    		<input type="hidden" name="fUptStatus" id="F_fUptStatus" value="${Upt.fUptStatus}"/>
	    		<input type="hidden" name="fOperatorID" id="F_fOperatorID" value="${Upt.fOperatorID}"/>
	    		<input type="hidden" name="fOperator" id="F_fOperator" value="${Upt.fOperator}"/>
	    		<input type="hidden" name="fDeptID" id="F_fDeptID" value="${Upt.fDeptID}"/>
	    		<input type="hidden" name="fReqTime" id="F_fReqTime" value="${Upt.fReqTime}"/>
	    		<input type="hidden" name="fUserName" id="F_fUserName" value="${Upt.fUserName}"/>
	    		<input type="hidden" name="fUserCode" id="F_fUserCode" value="${Upt.fUserCode}"/>
	    		<input type="hidden" name="fNCode" id="F_fNCode" value="${Upt.fNCode}"/>
	    		<div class="tab-wrapper" id="contract-change-edit">
					<ul class="tab-menu">
						<li class="active">变更合同信息</li>
						<li onclick="fcTypeOnClik()">原合同信息</li>
						<c:if test="${!empty disputeShow}">
						<li>合同纠纷</li>
						</c:if>
					</ul>
					<div class="tab-content">
						<div title="变更合同信息" style="margin-bottom:35px;width: 737px;">
							<%@ include file="../base/contract-change-base-detail.jsp" %>
						</div>
						<div title="原合同信息" style="margin-bottom:35px;width: 737px;">
							<%@ include file="../formulation/formulation_detail_base.jsp" %>
						</div>
						<c:if test="${!empty disputeShow}">
						<div title="纠纷信息" style="margin-bottom:35px;width: 737px;">
							<%@ include file="../base/contract-dispute-base-detail.jsp" %>
						</div>
						</c:if>
					</div>
				</div>
			</div>
			<div class="window-left-bottom-div">
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	
		<%-- <div class="window-right-div" id="check_system_div" style="width:254px;height: auto;padding-bottom: 20px;">
			<jsp:include page="../../check_system.jsp" />
		</div> --%>
	</div>
</form>
</div>
<script type="text/javascript">
flashtab('contract-change-edit');

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
   //送审
function changeEditFormSS(){
	var plan = getPlan1();
	$('#F_fUptFlowStauts').val("1");
	var a = $('#F_fcTitle').val();
	$('#fContName').val(a);
	var fContUptType=$('#Upt_fContUptType').combobox('getValue');
	var filesValue = $("#htbgfiles").val(); 
	if(fContUptType==''||fContUptType==null){
		alert("请选择变更类型！");
	}else if(filesValue==null||filesValue==''){
		alert("请上传附件");
	}else {
   		$('#changeInfo').form('submit', {
			onSubmit:function(param){ 
				param.planJson=plan;
				flag=$(this).form('enableValidation').form('validate');
				if(flag){
					$.messager.progress();
				}
				return flag;
			}, 
			url:base+'/Change/Save',
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
					$('#changeInfo').form('clear');
					$('#change_dg').datagrid('reload');
					$('#indexdb').datagrid('reload'); 
				}else{
					$.messager.alert('系统提示', data.info, 'error');
				}
			} 
		});	
   	
	}
}
//暂存
function changeeditFrom(){
	var plan = getPlan1();
	$('#F_fUptFlowStauts').val("0");
	$('#changeInfo').form('submit', {
		onSubmit: function(param){ 
			param.planJson=plan;
				flag=$(this).form('enableValidation').form('validate');
				if(flag){
					$.messager.progress();
				}
				return flag;
			}, 
			
			url:base+'/Change/Save',
			success:function(data){
				if(flag){
					$.messager.progress('close');
				}
				data=eval("("+data+")");
				if(data.success){
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					$('#changeInfo').form('clear');
					$("#change_dg").datagrid('reload'); 
				}else{
					$.messager.alert('系统提示', data.info, 'error');
				}
			} 
		});		
}
function fPurchNo_DC(){
	//var node=$('#c_c_dg').#check-history-dgd('getSelected');
	var win=creatFirstWin('选择-采购订单号',750,550,'icon-add','/PurchaseApply/PurchNoList');
	win.window('open');
}
function quota_DC(){
	//var node=$('#c_c_dg').datagrid('getSelected');
	var win=creatFirstWin('选择-预算指标编号',750,550,'icon-add','/BudgetIndexMgr/contract_list');
	win.window('open');
}
/* var c =0;
function upt_upFile() {
	 console.log(document.getElementById("upt_fFileSrc1"));
	var src = getFilePath();
	alert(getFilePath()); 
	c ++;
	var src = $('#upt_fFileSrc1').val();
	 var srcs =src+','+$('#upt_fi1').val();
	$('#upt_fi1').val(srcs); 
	$('#upt__f1').append("<div id='c"+c+"'><a href='#' class='file_U' style='color: #3f7f7f;font-weight: bold;'>"+src+"</a><a style='color: red;' href='#' onclick='deleteF1(c"+c+")'>删除</a></div>");
}  */
function deleteF1(val){
	var child=document.getElementById(val.id);
	child.parentNode.removeChild(child);
}
//时间格式化
function ChangeDateFormat(val) {
	//alert(val)
	var t, y, m, d, h, i, s;
	if (val == null) {
		return "";
	}
	t = new Date(val)
	y = t.getFullYear();
	m = t.getMonth() + 1;
	d = t.getDate();
	h = t.getHours();
	i = t.getMinutes();
	s = t.getSeconds();
	// 可根据需要在这里定义时间格式  
	return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
}
</script>
</body>