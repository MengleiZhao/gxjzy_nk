<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<form id="ApprovalSealForm" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div">
				<!-- 隐藏域 --> 
				<!-- 合同主键 -->		<input type="hidden" id="F_fcId" name="fcId" value="${bean.fcId}"/>
				<div class="tab-wrapper" id="contract-seal-edit">
					<ul class="tab-menu">
						<li class="active">合同信息</li>
						<c:if test="${!empty Upt.fId_U }">
							<li  onclick="tabChange()">变更表</li>
						</c:if>
					</ul>
					<div class="tab-content">
						<div title="基本信息" style="margin-bottom:35px;width: 737px;">
							<jsp:include page="../../sealInfo/formulation_detail_base_seal.jsp" />
						</div>
						<c:if test="${!empty Upt.fId_U }">
							<div title="变更表" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
								<jsp:include page="../../base/contract-change-base-detail.jsp"/>
							</div>
						</c:if>
					</div>
				</div>
			</div>
			<div class="win-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveSeal();">
					<img src="${base}/resource-modality/${themenurl}/button/htgz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
	</div>
</form>
<script type="text/javascript">
flashtab('contract-seal-edit');
$('#F_fcTypeName').combobox({  
    onChange:function(newValue,oldValue){  
    	var fcType = '${bean.fcType}';
    	if(fcType=="HTFL-01"){
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
    	
    	if(fcType=="HTFL-02"){
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
    	if(fcType=="HTFL-03"){
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
}); 


//保存盖章信息
function saveSeal(){
	var infoid = '';
	if(${type}==0){
		infoid = '${bean.fcId}';
	}else {
		infoid = '${Upt.fId_U}';
	}
	
	//附件的路径地址
	var s="";
	$(".ygzhtwbfileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#ygzhtwbfiles").val(s);
	
	if(s==""){
		alert('请上传盖章合同！');
		return false;
	}
	if(confirm("确认盖章？")){
		$('#ApprovalSealForm').form('submit', {
			onSubmit: function(){ 
				flag = $(this).form('enableValidation').form('validate');
				if(flag){
					$.messager.progress();
				}
				return flag;
			}, 
			url: base + '/sealInfo/saveSeal?id=' + ${fcId}+'&infoid='+infoid+'&type='+${type},
			success:function(data){
				if(flag){
					$.messager.progress('close');
				}
				data = eval("("+data+")");
				if(data.success){
					$.messager.alert('系统提示', data.info, 'info');
					if(${type}==0){
						$("#contractTabSeal").datagrid('reload');
					}else {
						$("#updateOrendingTabSeal").datagrid('reload');
					}
					closeWindow();
				}else{
					$.messager.alert('系统提示', data.info, 'error');
				}
			} 
		});	
		
	}
}
</script>