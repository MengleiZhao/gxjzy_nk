<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<form id="ApprovalSealUptForm" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div">
				<!-- 隐藏域 --> 
				<!-- 合同主键 -->		<input type="hidden" id="F_fcId" name="fcId" value="${bean.fcId}"/>
				<div class="tab-wrapper" id="contract-seal-edit">
					<ul class="tab-menu">
						<li >变更表</li>
					</ul>
					<div class="tab-content">
						<div title="变更表" style="margin-bottom:35px;overflow:auto" data-options="iconCls:'icon-xxlb'" >
							<jsp:include page="../../sealInfo/contract-change-base-detail-seal.jsp"/>
						</div>
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
	$(".bgygzhtwbfileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#bgygzhtwbfiles").val(s);
	
	if(s==""){
		alert('请上传盖章合同！');
		return false;
	}
	if(confirm("确认盖章？")){
		$('#ApprovalSealUptForm').form('submit', {
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
if ($('#uptOpenType').val() == 'Cdetail') {
	$('#change-upt-datagr-div').show();
	$.parser.parse($('#change-upt-datagr-div').parent());
	$('#change-upt-cgconf-div').show();
	$.parser.parse($('#change-upt-cgconf-div').parent());
}

$('#upt_fContName_edit').attr("readonly", "readonly");
$('#Upt_fUptReason_edit').attr("readonly", "readonly");

function tabChange(){
	$('#filing-edit-plan-dg-detail').datagrid('reload');
	$('#contract_cgplan_dg_detail1').datagrid('reload');
}
</script>