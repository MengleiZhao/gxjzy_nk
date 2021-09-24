<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<form id="reimburse_save_form" method="post"  enctype="multipart/form-data">
				<!-- 隐藏域 --> 
				<!-- 主键ID --><input type="hidden" name="rId" value="${bean.rId}" id="rId"/>
				<!-- 报销单号 --><input type="hidden" name="rCode" value="${bean.rCode}"/>
				<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="reimburseFlowStauts" />
				<!-- 报销状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="reimburseStauts" />
				<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
				<!-- 流程id  --><input type="hidden" id="flowId"  value="${fpId}"/>
				<!-- 下一级审批节点  --><input type="hidden" id="nextKey"  value="${bean.nCode}"/>
				<!-- 报销类型 --><input type="hidden" id="reimburseTypeHi" value="${bean.type}" name="type"/>
				<!-- 报销类型 --><input type="hidden" id="reimburseAmount" name="amount" value="${bean.amount}"/>
				<!-- 预算指标名称 --><input type="hidden" id="indexName" name="indexName" value="${bean.indexName}" />
				<!-- 指标ID --><input type="hidden" name="indexId" value="${applyBean.indexId}" id=""/>
				<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="indexType"/>
				<!-- 报销人 --><input type="hidden" name="userName" value="${bean.userName}" id="input_userName"/>
				<!-- 报销部门 --><input type="hidden" name=deptName value="${bean.deptName}" id="input_deptName"/>
				<!-- 会议是否调整 --><input hidden="hidden" id="fupdateStatusid" name="fupdateStatus" value="${bean.fupdateStatus}" />
				<!-- 会议调整说明 --><input hidden="hidden" id="fupdateReasonid" name="fupdateReason" value="${bean.fupdateReason}" />
				<div id="panelID" class="easyui-panel" data-options="closed:true">
				<!-- 项目支出明细ID --><input type="hidden" name="proDetailId" value="${bean.proDetailId}" id="proDetailId"/>
				<input type="hidden" id="json1" name="form1" />
				<!-- 收款人json -->
				<input type="hidden" id="payerinfoJson" name="payerinfoJson"/>
				<!-- 转账金额 -->
				<input type="hidden" id="payeeAmount"/>
				<!-- 应转账金额转账金额 -->
				<input type="hidden" id="skAmount"/>
				<input type="hidden" id="applyAmount" name="applyAmount" value="${applyBean.amount}" />
				<input type="hidden" id="meetPlanJson" name="meetPlan" />
				<input type="hidden" id="mingxiJson" name="mingxi"/>
				<input id="input_jkdid" hidden="hidden" value="${bean.loan.lId}" name="loan.lId" />
				<input id="input_jkdamonut" value="${bean.loan.lAmount}" hidden="hidden" />
				</div>
<!-- 预算信息 -->
<div class="easyui-accordion"
	style="margin-left: 20px;margin-right: 20px;">
	<div title="预算信息" data-options="collapsed:false,collapsible:false"
		style="overflow:auto;margin-left: 0px;">
		<table class="window-table" cellspacing="0" cellpadding="0"
			style="margin-top: 3px;margin-left: 0px;;margin-bottom: 0px;width: 695px;">
			<tr class="trbody">
				<td style="width: 60px"><span
					class="style1">*</span> 支出项目</td>
				<td colspan="3" style="padding-right: 5px;"><input
					class="easyui-textbox" style="width: 630px;height: 30px;"
					value="${bean.indexName}" id="F_fBudgetIndexName"
					readonly="readonly" required="required" /></td>
			</tr>
		</table>
		<table class="window-table-readonly-zc" cellspacing="0"
			cellpadding="0"
			style="margin-left:0px;;margin-bottom: 0px;width: 695px;height: 50px;">
			<tr>
			<td class="window-table-td1"><p style=" color:#0000CD;">申请金额:</p></td>
			<td class="window-table-td2"><p id="applyAmount_span">${applyBean.amount}[元]</p></td>
			<td class="window-table-td1"><p style="color: red;" >报销金额:</p></td>
			<td class="window-table-td2">${bean.amount}[元]</td>
		</tr>
			<tr>
				<td class="window-table-td1"><p>归还预算:</p></td>
				<td class="window-table-td2"><p id="ghAmount">[元]</p></td>
			</tr>
			<tr>
				<td class="window-table-td1"><p>是否冲销借款:</p></td>
				<td class="window-table-td2"><input id="hotelstd_add_sfwj"
					name="withLoan" value="1" type="radio" disabled="disabled"
					onclick="selectCxjk(this)"
					<c:if test="${bean.withLoan==1 }">checked="checked"</c:if> />是 <input
					id="hotelstd_add_sfwj" name="withLoan" value="0" type="radio"
					disabled="disabled" onclick="selectCxjk(this)"
					<c:if test="${bean.withLoan!=1}">checked="checked"</c:if> />否</td>

			</tr>
			
			<tbody id="jk">
				<tr>
					<td class="window-table-td1"><p>借款单号:</p></td>
					<td class="window-table-td2"><a href="#"> <input
							class="easyui-textbox" id="input_jkdbhs"
							style="width: 250px;height: 30px;"
							data-options="prompt: '借款单选择' ,icons: [{iconCls:'icon-sousuo'}]"
							value="${bean.loan.lCode}" readonly="readonly"> 
					</a></td>
				</tr>
				<tr>
					<td class="window-table-td1"><p>本次冲销金额:</p></td>
					<td class="window-table-td2"><p id="cxAmount">[元]</p></td>
					<td class="window-table-td1"><p>剩余应还:</p></td>
					<td class="window-table-td2"><p id="syAmount">[元]</p></td>
				</tr>
			</tbody>

		</table>
	</div>
</div>			
<!-- 基本信息 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
	<table class="window-table" style="margin-top: 3px;width: 695px;padding-right: 5px;" cellspacing="0" cellpadding="0">
		<tr class="trbody">
			<td class="td1"><span class="style1">*</span>单据编号</td>
			<td colspan="3" class="td2" >
				<input style="width: 590px;height: 30px;margin-left: 10px" readonly="readonly" name="gCode" class="easyui-textbox"
				value="${bean.gCode}" data-options="required:true" readonly="readonly"/>
			</td>
		</tr>
		<tr class="trbody">
			<td class="td1"><span class="style1">*</span>事项摘要</td>
			<td colspan="3" class="td2" >
				<input style="width: 590px; height: 30px;margin-left: 10px" readonly="readonly" id="gName"  name="gName" class="easyui-textbox"
				value="${bean.gName}" />
			</td>
		</tr>
			<jsp:include page="reimburse_meetinginfo_detail.jsp" />
			</table>
		</div>				
	</div>
</form>	
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
	<div title="会议事项调整" data-options="collapsed:false,collapsible:false"style="overflow:auto;width: 717px">
		<table class="window-table" style="margin-top: 3px;" cellspacing="0" cellpadding="0">
			<tr class="trbody">
				<td class="td1" style="width: 80px;"><span class="style1">*</span>是否存在调整</td>
				<td class="td2" colspan="4" >
					<input type="radio" value="1" onclick="javascript:return false" name="fupdateStatus" id="box1" <c:if test="${bean.fupdateStatus=='1'}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;是
					&nbsp;&nbsp;
					<input type="radio" value="0" onclick="javascript:return false" name="fupdateStatus" id="box2" <c:if test="${bean.fupdateStatus=='0'}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;否
				</td>
				<!-- <td class="td4" style="width: 67px;"></td> -->
			</tr>
			<tr id="radiofupdate" <c:if test="${bean.fupdateStatus=='0'}"> hidden="hidden" </c:if> class="trbody">
				<td class="td1" style="width: 80px;"><span class="style1">*</span>会议调整说明</td>
				<td colspan="3" class="td2" >
					<textarea name="fupdateReason"  id="fupdateReason" class="textbox-text" readonly="readonly"
							oninput="textareaNum(this,'textareaNum1')" autocomplete="off"
							style="width:595px;height:70px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:8px; margin-bottom:0px;">${bean.fupdateReason }</textarea>
				</td>
			</tr>
		</table>
	</div>				
</div>

<!-- 调整后会议日程 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
	<div title="会议日程" data-options="collapsed:false,collapsible:false"style="overflow:auto;width: 717px">
		<div style="overflow:auto;margin-top: 0px;">
			<jsp:include page="reimburse_meeting_plan.jsp" />
		</div>
	</div>
</div>
<!-- 费用明细 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 40px">
	<div title="费用明细" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
		
		<div style="overflow:auto;">
		<div style="margin-top: 20px">
							<a style="margin-bottom: 5px;float: right;">原申请金额：<span style="color: #0000CD"  id="applyAmount_span"><fmt:formatNumber groupingUsed="true" value="${applyBean.amount}" minFractionDigits="2" maxFractionDigits="2"/></span></a>
							</div>
			<jsp:include page="reimburse-mingxi-meeting1.jsp" />
			<div style="margin-top: 10px;">
				<div style="float: left;margin-left: 10px;">
					<span >汇总金额：</span>
					<span style="color: #D7414E">
							<fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]
					</span>
				</div>
				<div style="float: right;">
					<span >标准金额：</span>
					<span id="stdAmount_span" style="color: #D7414E"></span>
				</div>
			</div>
		</div>
			<div style="overflow:hidden;margin-top: 10px">
				<!-- 发票明细 -->
				<jsp:include page="mingxi_meeting_invoice_detail.jsp" />
			</div>
		
	</div>
</div>

<!-- 收款人信息 -->
<div class="easyui-accordion"
	style="margin-left: 20px;margin-right: 20px">
	<div title="收款人信息" data-options="collapsed:false,collapsible:false"
		style="overflow:auto;padding:0px;">
		<input hidden="hidden" value="${payee.pId}" name="pId" />
		<div id="" style="overflow-x:hidden;margin-top: 0px;">
			<jsp:include page="payee-info_detail.jsp" />
		</div>
	</div>
</div>

<!-- 附件信息 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
	<div title="附件信息" data-options="collapsed:false,collapsible:false"
		style="overflow:auto;">		
		<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
			<tr class="trbody">
					<td style="width: 60px;text-align: left">附件</td>
					<td colspan="4">
						<c:if test="${!empty attaList1}">
						<c:forEach items="${attaList1}" var="att">
							<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a><br>
						</c:forEach>
					</c:if>
					<c:if test="${empty attaList1}">
						<span style="color:#999999">暂未上传附件</span>
					</c:if>
					</td>
				</tr>						
		</table>			
	</div>
</div>
		<!-- 审批记录报销 -->
		<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
			<div title="审批记录" data-options=" collapsible:false" style="overflow:auto;padding:0px;">
				<!-- <div class="window-title"> 审批记录</div> -->
					<jsp:include page="../../../check_history.jsp" />
			</div>
		</div>			
<script type="text/javascript">
var updateradio = 0;
function radiono(){
	updateradio=1;
	$('#radiofupdate').hide();
	$("#dmp1").css("display","none");
	endEditingMeet();
	$('#fupdateStatusid').val(0);
}
function radioyes(){
	updateradio=0;
	$("#dmp1").css("display","block");
	$('#radiofupdate').show();
	$('#fupdateStatusid').val(1);
}
//接待人员表格添加删除，保存方法
var editIndex1 = undefined;
function endEditingR() {
	if (editIndex1 == undefined) {
		return true
	}
	if ($('#dg_meet_plan').datagrid('validateRow', editIndex1)) {
		var dmp = $('#dg_meet_plan').datagrid('getEditor', {
			index : editIndex1,
			field : 'costDetail'
		});
		$('#dg_meet_plan').datagrid('endEdit', editIndex1);
		editIndex1 = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowR(index) {
	if (editIndex1 != index) {
		if (endEditingR()) {
			$('#dg_meet_plan').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndex1 = index;
		} else {
			$('#dg_meet_plan').datagrid('selectRow', editIndex1);
		}
	}
}
function appendR() {
	if (endEditingR()) {
		$('#dg_meet_plan').datagrid('appendRow', {});
		editIndex1 = $('#dg_meet_plan').datagrid('getRows').length - 1;
		$('#dg_meet_plan').datagrid('selectRow', editIndex1).datagrid('beginEdit',editIndex1);
	}
}
function removeitR() {
	if (editIndex1 == undefined) {
		return
	}
	$('#dg_meet_plan').datagrid('cancelEdit', editIndex1).datagrid('deleteRow',
			editIndex1);
	editIndex1 = undefined;
}
function acceptR() {
	if (endEditingR()) {
		$('#dg_meet_plan').datagrid('acceptChanges');
	}
}


/* 	//重新计算开支标准
function countkzbz() {
	accept();
	//获得接待人数（有几行就是接待多少人）
	var rownum = $('#dg_meet_plan').datagrid('getRows').length;
	//修改明细表中的开支标准
	var rows = $('#appli-detail-dg').datagrid('getRows');
	for(var i=0;i<rows.length;i++) {
		var tr = $('#appli-detail-dg').datagrid('getEditors', i);
		//获得每一行的开支标准
		var kzbz=rows[i].standard;
		//设置开支标准
		onClickRow(i);
		tr[1].target.textbox('setValue', parseFloat(kzbz*rownum));
		accept();
	}
} */
function changeTime1(){
	var index=$('#dg_meet_plan').datagrid('getRowIndex',$('#dg_meet_plan').datagrid('getSelected'));
	var editors = $('#dg_meet_plan').datagrid('getEditors', index);  
	var endEditor = editors[1]; 
	var startday = Date.parse(new Date(editors[0].target.val()));
	var maxTime = Date.parse(new Date($("#meetingDateEnd").datetimebox('getValue')));
    var minTime = Date.parse(new Date($("#meetingDateStart").datetimebox('getValue')));
	var endday = Date.parse(new Date(endEditor.target.val()));
	if(!isNaN(startday)){
    	if((startday>=minTime &&startday<=maxTime) ){
    		if(!isNaN(endday)){
	    		if(endday<startday){
	        		alert("结束日期不能小于开始日期！");
	        		editors[0].target.datetimebox('setValue', '');
	        	}
    		}
    	}else{
    		if(startday>maxTime || startday<minTime){
	    	alert("所选时间不在行程范围内请重新选择！");
    		editors[0].target.datetimebox('setValue', '');
    		}
    	}
    	
    } 
}


function changeTime2(){
	var index=$('#dg_meet_plan').datagrid('getRowIndex',$('#dg_meet_plan').datagrid('getSelected'));
	var editors = $('#dg_meet_plan').datagrid('getEditors', index);  
	var endEditor = editors[1]; 
	var startday = Date.parse(new Date(editors[0].target.val()));
	var maxTime = Date.parse(new Date($("#meetingDateEnd").datetimebox('getValue')));
    var minTime = Date.parse(new Date($("#meetingDateStart").datetimebox('getValue')));
	var endday = Date.parse(new Date(endEditor.target.val()));
	if(!isNaN(endday)){
    	if((endday>=minTime &&endday<=maxTime) ){
    		if(!isNaN(startday)){
	    		if(endday<startday){
	        		alert("结束日期不能小于开始日期！");
	        		editors[1].target.datetimebox('setValue', '');
	        	}
    		}
    	}else{
    		if(endday>maxTime || endday<minTime){
	    	alert("所选时间不在行程范围内请重新选择！");
    		editors[1].target.datetimebox('setValue', '');
    		}
    	}
    	
    } 
}


//审批
function checkReimbursement(result) {
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
			var win=creatFirstWin(' ',360,280,'icon-search','/reimburse/overfulfils?standard='+num3.toFixed(2)+"&amount="+nums.toFixed(2)+"&applyAmount="+applyAmount1.toFixed(2)+"&sts="+result);
			win.window('open');
		}else{
		
		$('#reimburse_check_form_car').form('submit', {
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
					$('#reimburse_check_form_car').form('clear');
					$('#reimburseCheckTab').datagrid('reload'); 
					$("#indexdb").datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
		
	}
	}else{
		$('#reimburse_check_form_car').form('submit', {
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
					$('#reimburse_check_form_car').form('clear');
					$('#reimburseCheckTab').datagrid('reload'); 
					$("#indexdb").datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
}
</script>