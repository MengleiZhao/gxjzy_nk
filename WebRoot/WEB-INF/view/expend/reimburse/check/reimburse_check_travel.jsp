<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div  data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
			<div class="window-left-div" style="width: 755px;height: 491px;border: 1px solid #D9E3E7;" >
				<div class="window-left-top-div">
					<form id="reimburse_check_form" style="height: 0px;" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
					<!-- 隐藏域 --> 
					<!-- 主键ID --><input type="hidden" name="rId" value="${bean.rId}" id="rId"/>
					<!-- 报销单号 --><input type="hidden" name="rCode" value="${bean.rCode}" id="rCode"/>
					<!-- 收款人主键ID --><input type="hidden" name="pId" value="${payeeBean.pId}"/>
					<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="reimburseFlowStauts" />
					<!-- 报销状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="reimburseStauts" />
					<%-- <!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}" />
					<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" /> --%>
					<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
					<!-- 报销类型 --><input type="hidden" id="reimburseTypeHi" value="${bean.type}"/>
					<!-- 指标ID --><input type="hidden" name="indexId" value="${bean.indexId}" id=""/>
					<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id=""/>
					<!-- 审批结果 -->
					<!-- 报销金额 --><input type="hidden" id="reimburseAmount" name="amount" value="${bean.amount}"/>
		    		<input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
		    		<!-- 审批意见 -->
				    <input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
				    <!-- 审批附件 -->
				    <input type="hidden" name="spjlFile" id="spjlFile" value=""/>
				    <input type="hidden" id="applyAmount" name="applyAmount" value="${applyBean.amount}" />
				    
				    <input id="input_jkdid" hidden="hidden" value="${bean.loan.lId}" name="loan.lId"/>
					<input id="input_jkdamonut" value="${bean.loan.lAmount}" hidden="hidden"  />
					<input id="cxAmounts" value="${bean.cxAmount}" hidden="hidden"  />
				    <!-- 基本信息 -->
				</form>	
				<div class="tab-wrapper" id="reimburse-travelinfo-add">
					<ul class="tab-menu">
						<li class="active" onclick="onclickreimburset()">报销单</li>
						<li onclick="onclickdetail()" >申请单</li>
					</ul>
					<div class="tab-content">
						<div title="报销单" style="margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="../reimburse/reimburset_travelinfo_detail.jsp" />
						</div>
						<div title="申请单" style="overflow:auto;margin-bottom:35px;" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="../reimburse/apply_travelinfo_detail.jsp" />
						</div>
					</div>
				</div>
			</div>
			<div class="window-left-bottom-div">
				<a href="javascript:void(0)" onclick="openCheckWin('审批意见','1')">
					<img src="${base}/resource-modality/${themenurl}/button/tg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="openCheckWin('审批意见','0')">
					<img src="${base}/resource-modality/${themenurl}/button/btg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
		</div>
		<c:if test="${bean.type!=1 }">
			<div class="window-right-div" data-options="region:'east',split:true">
				<jsp:include page="../../../check_system.jsp" />
			</div>
		</c:if>
</div>
	</div>
<script type="text/javascript">
flashtab('reimburse-travelinfo-add');
//防止不停重新加载
var itineraryurlcount = 0;
function onclickreimburset(){
	if(itineraryurlcount>0){
		itineraryurlcount+=1;
		return false;
	}else {
		itineraryurlcount+=1;
		$('#reimburse_itinerary_tab_id').datagrid('reload');
		$('#reimburse_outside_tab_id').datagrid('reload');
		$('#reimbursein_city_tab_id').datagrid('reload');
		$('#reimbursein_hoteltab').datagrid('reload');
		$('#reimbursein_foodtab').datagrid('reload');
		$('#payer_info_tab').datagrid('reload');
		$('#reimburse_itinerary_detail_tab_id').datagrid('reload');
		$('#tracel_itinerary_trip_reim_detail_tab_id').datagrid('reload');
		$('#in_city_trip_reim_detail_tab_id').datagrid('reload');
		$('#foodtabTripReimDetail').datagrid('reload');
		$('#hoteltabApplyTripReimDetail').datagrid('reload');
		$('#check-history-dg').datagrid('reload');
		return true;
	}
}
var detaiurlcount = 0;
function onclickdetail(){
	if(detaiurlcount>=1){
		detaiurlcount+=1;
		return false;
	}else {
		detaiurlcount+=1;
		$('#tracel_itinerary_tab_id_detail').datagrid('reload');
		$('#tracel_students_tab_apply_id').datagrid('reload');
		$('#rec-other-dg-detail-apply').datagrid('reload');
		$('#outside_traffic_tab_id_detail_apply').datagrid('reload');
		$('#in_city_tab_id_detail').datagrid('reload');
		$('#index_detail_apply_tab_id').datagrid('reload');
		$('#rec-others-detail-dg-apply').datagrid('reload');
		$('#rec-other-detail-apply-dg').datagrid('reload');
		$('#itinerary_toolbar_trip_detail_Id').datagrid('reload');
		$('#tracel_itinerary_detail_trip_tab_apply_id').datagrid('reload');
		$('#rec-other-trip-detail-apply-dg').datagrid('reload');
		$('#check-history-reim-apply-dg').datagrid('reload');
		$.parser.parse("#tracel_itinerary_trip_reim_detail_tab_id");
		return true;
	}
}
//显示详细信息手风琴页面
$(document).ready(function() {
	jk();
	//是否显示 冲销借款信息
	var cxjk = $('input[name="withLoan"]:checked').val();
	if(cxjk==1){
		$('#jk').show();
	} else {
		$('#jk').hide();
		$('#input_jkdamonut').val(0);
	}
	var sts = $('input[name="fupdateStatus"]:checked').val();
	if(sts==1){
		$('#radiofupdate').show();
	} else {
		$('#radiofupdate').hide();
	}
	var h = $("#reimburseTypeHi").textbox().textbox('getValue');
	if (h != "") {
		$('#reimburseType').textbox().textbox('setValue', h);
		$('#reimburseType').textbox().attr('readonly', true);
	}
	zzAmount();
});


//审批
function check(result) {
	$("#fcheckResult").val(result);
	$("#reimburseFlowStauts").val(result);
	var nums = $("#reimburseAmount").val();
	var num3 = $("#applyAmount").val();
	if(result=='1'){
		if(parseFloat(nums)>parseFloat(num3)){
			var win=creatFirstWin(' ',360,280,'icon-search','/reimburse/overfulfils?standard='+num3+"&amount="+nums+"&applyAmount="+(nums-num3)+"&sts="+result);
			win.window('open');
		}else{
		
		$('#reimburse_check_form').form('submit', {
			onSubmit : function() {
				
				/* flag = $(this).form('enableValidation').form('validate');
				if (flag) { */
					$.messager.progress();
				/* }
				return flag; */
			},
			url : base + '/reimburseCheck/checkResult',
			success : function(data) {
				
				/* if (flag) { */
					$.messager.progress('close');
				/* } */
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					$('#reimburse_check_form').form('clear');
					$('#reimburseCheckTab').datagrid('reload'); 
					$("#indexdb").datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
		
	}
	}else{
		$('#reimburse_check_form').form('submit', {
			onSubmit : function() {
				/* flag = $(this).form('enableValidation').form('validate');
				if (flag) { */
					$.messager.progress();
				/* }
				return flag; */
			},
			url : base + '/reimburseCheck/checkResult',
			success : function(data) {
				$.messager.progress('close');
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					$('#reimburse_check_form').form('clear');
					$('#reimburseCheckTab').datagrid('reload'); 
					$("#indexdb").datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
}

//转账金额
function  zzAmount(){
	var num1=parseFloat($('#input_jkdamonut').val());
	var num2=parseFloat($('#reimburseAmount').val());
	var num3=parseFloat($('#applyAmount').val());
	if(isNaN(num1)){
		num1=0;
	}
	if(isNaN(num2)){
		num2=0;
	}
	if(isNaN(num3)){
		num3=0;
	}
	$("#skAccount").numberbox().numberbox('setValue',num1+num2);
}


</script>
</body>

