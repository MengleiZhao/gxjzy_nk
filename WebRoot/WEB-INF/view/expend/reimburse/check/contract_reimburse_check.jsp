<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body>
<div  data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:755px;height: 491px;border: 1px solid #D9E3E7;margin-top:20px">
			<div class="window-left-top-div">
				<div class="tab-wrapper" id="reimburse-contract-check">
					<ul class="tab-menu">
						<li class="active" onclick="onclickreimburset()">付款内容</li>
						<li onclick="onclickcontract()" >原合同信息</li>
						<c:if test="${bean.fUpdateStatus==1 }"><li onclick="onclickchange()" >变更合同信息</li></c:if>
					</ul>
					<div class="tab-content">
						<div title="付款内容" style="margin-bottom:35px;width: 737px" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="../../../contract/enforcing/enforcing_detail_base.jsp" />
						</div>
						<div title="原合同信息"  style="margin-bottom:35px;width: 737px" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="../../../contract/formulation/formulation_detail_base.jsp" /> 
						</div>
						<c:if test="${bean.fUpdateStatus==1 }">
						<div title="变更合同信息"  style="margin-bottom:35px;width: 737px" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="../../../contract/base/contract-change-base-detail.jsp" />
						</div>
						</c:if>
					</div>
				</div>
			</div>
			<div class="window-left-bottom-div" >
				<a href="javascript:void(0)" onclick="openCheckWin('审批意见','1')">
					<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="openCheckWin('审批意见','0')">
					<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="${base }/systemcentergl/list?typeStr=支出管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		<div class="window-right-div" data-options="region:'east',split:true">
				<jsp:include page="../../../check_system.jsp" />
		</div>
	</div>
</div>

<script type="text/javascript">
flashtab('reimburse-contract-check');
var detaiurlcount = 0;
function onclickchange(){
	if(detaiurlcount>=1){
		detaiurlcount+=1;
		return false;
	}else {
		detaiurlcount+=1;
		$('#contract-cgconfig-detail-dg').datagrid('reload');
		$('#change-plan-detail-dg').datagrid('reload');
		$('#check-history-dg-bg').datagrid('reload');
		return true;
	}
}
function onclickcontract(){
	if(detaiurlcount>=1){
		detaiurlcount+=1;
		return false;
	}else {
		detaiurlcount+=1;
		fcTypeOnClik();
		$('#filing-edit-plan-dg-detail').datagrid('reload');
		$('#plan_contract_dg_detail').datagrid('reload');
		$('#check-history-dg-contract').datagrid('reload');
		return true;
	}
}
//审批
function check(result) {
	$("#fcheckResult").val(result);
	$("#reimburseFlowStauts").val(result);
	var checkSame =$('#isSame').val();
	if(checkSame=='0'){
		if(confirm('收款人信息与签约方信息不一致，是否通过？')==false){
			return;
		}
	}
	$('#enforcing_check_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				$.messager.progress();
			}
			return flag;
		},
		url : base + '/reimburseCheck/contractCheckResult',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#contract_reimburse_check_form').form('clear');
				$('#contractReimbCheckTab').datagrid('reload'); 
				$("#indexdb").datagrid('reload');
				closeWindow();
			} else {
				$.messager.alert('系统提示', data.info, 'error');
				closeWindow();
				$('#contract_reimburse_check_form').form('clear');
			}
		}
	});
}
function onSelect2(date) {
	endday2 = date;
	startday2 = new Date(startday2);
	var d = (endday2 - startday2) / 86400000 + 1;
	if (d > 0) {
		$('#duration').numberbox("setValue", d);
	} else {
		$('#duration').numberbox("setValue", "");
	}
}

//寻找相关制度
function findSystemFile(id) {
	$.ajax({ 
		url: base+"/cheter/systemFind?id="+id, 
		success: function(data){
			data=data.replace('\"','');
			data=data.replace('\"','');
			window.open(data);
    }});
}


</script>
</body>

