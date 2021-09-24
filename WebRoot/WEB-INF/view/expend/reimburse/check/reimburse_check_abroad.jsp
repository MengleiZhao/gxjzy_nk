<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="window-div">
		<div class="window-left-div"  style="width:755px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;" data-options="region:'west',split:true">
			<div class="window-left-top-div">
				<form id="reimburse_check_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data" style="height: 0px">
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
		    		<input type="hidden" name="fcheckResult" id="fcheckResult" value=""/>
		    		<!-- 审批意见 -->
				    <input type="hidden" name="fcheckRemake" id="fcheckRemake" value=""/>
				    <!-- 审批附件 -->
				    <input type="hidden" name="spjlFile" id="spjlFile" value=""/>
				    <input type="hidden" id="applyAmount" name="applyAmount" value="${applyBean.amount}" />
			
				
				</form>		
				
				<div class="tab-wrapper" id="reimburse-abroad-check">
					<ul class="tab-menu">
						<li class="active" onclick="onclickreimburset()">报销单</li>
						<li onclick="onclickdetail()" >申请单</li>
					</ul>
					<div class="tab-content">
						<div title="报销单" style="width: 737px" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="../reimburse/reimburse_abroadInfo_detail.jsp" />
						</div>
						<div title="申请单" style="margin-bottom:35px;width: 737px" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="../reimburse/apply_detail_abroad.jsp" />
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
				<c:if test="${bean.type==1 }">
					<a href="javascript:void(0)" onclick="checkReimbursement('2')">
						<img src="${base}/resource-modality/${themenurl}/button/tybzz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;
				</c:if>
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
	
<script type="text/javascript">


flashtab('reimburse-abroad-check');

//防止不停重新加载
var abroadcount = 0;
function onclickreimburset(){
	if(abroadcount>0){
		abroadcount+=1;
		return false;
	}else {
		abroadcount+=1;
		$('#abroad-plan-dg-reim').datagrid('reload');
		$('#international_traveling_expense_id-reim').datagrid('reload');
		$('#apply_outside_traffic_tab_id-reim').datagrid('reload');
		$('#hoteltabApply-reim').datagrid('reload');
		$('#foodtab-reim').datagrid('reload');
		$('#rec-fee-dg-reim').datagrid('reload');
		$('#rec-fete-dg-reim').datagrid('reload');
		$('#rec-other-dg-reim').datagrid('reload');
		return true;
	}
}
var abroadDetailcount = 0;
function onclickdetail(){
	if(abroadDetailcount>=1){
		abroadDetailcount+=1;
		return false;
	}else {
		abroadDetailcount+=1;
		$('#abroad-plan-dg').datagrid('reload');
		$('#abroad-person-detail-dg').datagrid('reload');
		$('#travel-way-dg').datagrid('reload');
		$('#apply_expense_detail_tab_id').datagrid('reload');
		$('#international_traveling_expense_id').datagrid('reload');
		$('#apply_outside_traffic_tab_id').datagrid('reload');
		$('#hoteltabApply').datagrid('reload');
		$('#foodtab').datagrid('reload');
		$('#rec-fee-dg').datagrid('reload');
		$('#rec-fete-dg').datagrid('reload');
		$('#rec-other-dg').datagrid('reload');
		$('#check-history-reim-apply-dg').datagrid('reload');
		return true;
	}
}
//显示详细信息手风琴页面
$(document).ready(function() {
	//是否显示 冲销借款信息
	var cxjk = $('input[name="withLoan"]:checked').val();
	if(cxjk==1){
		$('#jk').show();
	} else {
		$('#jk').hide();
		$('#input_jkdamonut').val(0);
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
	var applyType = $('#reimburseTypeHi').val();
	
	if(1==applyType){
		//通用事项申请
		var userName2 = $('#userName2').textbox('getValue');
		if( result==1 && userName2==""){
			alert('请先选择下级审批人');
			return false;
		}
	}
	$("#fcheckResult").val(result);
	$("#reimburseFlowStauts").val(result);
	var applyAmount1 = $("#applyAmount1").val();
	var nums = $("#nums").val();
	var num3 = $("#num3").val();
	if(result=='1' || result=='2'){
		if(parseFloat(nums)>parseFloat(num3)){
			var win=creatFirstWin(' ',360,280,'icon-search','/reimburse/overfulfils?standard='+num3+"&amount="+nums+"&applyAmount="+applyAmount1+"&sts="+result);
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

