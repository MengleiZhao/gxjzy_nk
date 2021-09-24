<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body>
<div  data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:755px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="window-left-top-div">
			<form id="directly_reimburse_save_form" method="post"  enctype="multipart/form-data">
			<!-- 隐藏域 --> 
			<!-- 主键ID --><input type="hidden" name="drId" value="${bean.drId}" />
			<!-- 报销单编号 --><input type="hidden" name="drCode" value="${bean.drCode}" />
			<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="drFlowStauts" />
			<!-- 申请状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="drStauts" />
			<!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}" />
			<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" />
			<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
			<!-- 指标ID --><input type="hidden" name="indexId" <c:if test="${detail=='edit' }">value="${bean.type}"</c:if><c:if test="${detail=='add' }">value="${bean.indexId}"</c:if> id="F_fBudgetIndexCode"/>
			<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="F_indexType"/>
			<div id="panelID" class="easyui-panel" data-options="closed:true">
				<!-- 报销时间 --><input class="easyui-datetimebox" name="reqTime" value="${bean.reqTime}" id="input_reqTime" />
				<!-- 项目支出明细ID --><input type="hidden" id="F_proDetailId" name="proDetailId" value="${bean.proDetailId }">
				<!-- 报销金额 --><input type="hidden"  id="amount" name="amount" value="${bean.amount}" >
				<!-- 指标剩余金额 --><input type="hidden"  id="syjeamount" name="syjeamount" value="${bean.syAmount}" >
				<input type="hidden" id="arry" name="arry" value="" />
				<!-- 附件 --><input type="text" id="files" name="files" hidden="hidden">
			</div>
			<input type="hidden" id="json1" name="form1" />
			<input type="hidden" id="applyAmount" name="applyAmount" value="${bean.amount}" />
			<!-- 报销类型 --><input type="hidden" id="reimburseTypeHi" value="${bean.type}" name="type"/>
			<!-- 预算指标名称 --><input type="hidden" id="indexName" name="indexName" value="${bean.indexName}" />
			<input type="hidden" name="trId" value="${travelBean.trId}" />
			<input type="hidden" name="travelRId" value="${tPeopBean.travelRId}" />
			<input type="hidden" id="travelTypeHi" value="${travelBean.travelType}" />
			<input type="hidden" id="wagesPlanHi" value="${travelBean.wagesPlan}" />
			<input type="hidden" id="expensePlanHi" value="${travelBean.expensePlan}" />
			<!-- json -->
			<input type="hidden" id="payerinfoJson" name="payerinfoJson" />
			<input type="hidden" id="mingxiJson" name="mingxi"/>
				<!-- 预算信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
				<div title="预算信息" data-options="collapsed:false,collapsible:false"style="overflow:auto;margin-left: 0px;height: auto">				
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;;margin-bottom: 0px;width: 695px;">					
						<tr class="trbody">
							<td style="width: 60px;"><span class="style1">*</span> 支出项目</td>
							<td colspan="3" style="padding-right: 5px;">
								<input class="easyui-textbox" style="width: 630px;height: 30px;"
								name="indexName" value="${bean.indexName}" id="F_fBudgetIndexName"
								data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo'}]" readonly="readonly" required="required"/>
							</td>
						</tr>
					</table>	
					<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="margin-left:0px;;margin-bottom: 0px;width: 695px;height: 50px;">
						<tr>
							<td class="window-table-td1"><p>使用部门:</p></td>
							<td class="window-table-td2"><p id="p_pfDepartName">${bean.pfDepartName}</p></td>
							
							<td class="window-table-td1"><p>批复时间:</p></td>
							<td class="window-table-td2"><p id="p_pfDate">${bean.pfDate}</p></td>
						</tr>
						<tr hidden="hidden">
							<td class="window-table-td1"><p>批复金额:</p></td>
							<td class="window-table-td2"><p id="p_pfAmount"><fmt:formatNumber groupingUsed="true" value="${bean.pfAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</p></td>
							
							<td class="window-table-td1"><p>可用余额:</p></td>
							<td class="window-table-td2"><p id="p_syAmount"><fmt:formatNumber groupingUsed="true" value="${bean.indexAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</p></td>
						</tr>
						<tr>
							<td class="window-table-td1"><p style="color: red;" >报销金额:</p></td>
							<td class="window-table-td2"><p id="p_amount"><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</p></td>
						</tr>
						<tr >
							<td class="window-table-td1"><p>是否冲销借款</p></td>
							<td class="window-table-td2">
								<input id="hotelstd_add_sfwj" name="withLoan" value="1" disabled="disabled"
									type="radio" onclick="selectCxjk(this)" <c:if test="${bean.withLoan==1 }">checked="checked"</c:if>/>是
								<input id="hotelstd_add_sfwj" name="withLoan" value="0" disabled="disabled"
									type="radio" onclick="selectCxjk(this)" <c:if test="${bean.withLoan!=1 }">checked="checked"</c:if>/>否
							</td>	
						</tr>
						<tbody id="jk">
							<tr>
								<td class="window-table-td1"><p>借款单号:</p></td>
								<td class="window-table-td2">
									<a href="#">
										<input class="easyui-textbox" id="input_jkdbh" style="width: 250px;height: 30px;" data-options="prompt: '借款单选择' ,icons: [{iconCls:'icon-sousuo'}]"
										value="${bean.loan.lCode}" readonly="readonly" >
										<input id="input_jkdid" hidden="hidden" value="${bean.loan.lId}" name="loan.lId"/>
										<input id="input_jkdamonut" value="${bean.loan.lAmount}" hidden="hidden"  />
									</a>
								</td>
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
			<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
				<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
					<table class="window-table" style="margin-top: 3px;width: 695px" cellspacing="0" cellpadding="0">
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span>事项摘要</td>
							<td class="td2" >
								<input style="width: 265px; height: 30px;margin-left: 10px" readonly="readonly" name="summary"  id="summary" class="easyui-textbox"
								value="${bean.summary}" />
							</td>
							<td class="td1" style="width: 70px;">报销类型</td>
							<td class="td2" >
								<input class="easyui-combobox" id="dirType" readonly="readonly" name="dirType" value="${bean.dirType}" style="width: 257px;height: 30px;margin-left: 10px"
								 data-options="
								url:'${base}/directlyReimburse/lookupsJson?parentCode=ZJBXLX&selected=${bean.dirType}',
								method:'get',
								valueField:'code',
								textField:'text',
								editable:false,
								validType:'length[1,100]',
								onSelect:onselectDirTypeDetail"
								/>
							</td>
						</tr>
						<tr class="trbody">
							<td  style="width: 70px;"><span class="style1">*</span>单据编号</td>
							<td colspan="3" class="td2" >
								<input style="width: 625px;height: 30px;margin-left: 10px" readonly="readonly"  class="easyui-textbox"
								value="${bean.drCode}" data-options="required:true" readonly="readonly"/>
							</td>
						</tr>
						<tr class="trbody">
							<td style="width: 70px;"><span class="style1">*</span>报销事由</td>
							<td colspan="3" class="td2" >
								<input style="width: 625px; height: 60px;margin-left: 10px;margin-top: 5px;" readonly="readonly" data-options="multiline:true" required="required" name="reason"  id="reason" class="easyui-textbox" value="${bean.reason}" />
							</td>
						</tr>
						<tr class="trbody">
							<td style="width: 100px;"><span class="style1">*</span>常规支出</td>
							<td class="td2">
								<input type="radio" name="standard" value="1" disabled="disabled" <c:if test="${bean.isconvention==1}">checked="checked"</c:if> />是
								<input type="radio" name="standard" value="0" <c:if test="${bean.isconvention !=1}">checked="checked"</c:if> />否
							</td>
						</tr>
						<tr class="trbody">
							<td  class="td1"style="width: 70px;">经办人</td>
							<td class="td2" >
								<input class="easyui-textbox" id="userNames" name="userName" readonly="readonly" value="${bean.userName}" style="width: 255px;height: 30px;margin-left: 10px " >
							</td>
							<td class="td1" style="width: 70px;">经办部门</td>
							<td class="td2" >
								<input class="easyui-textbox" id="deptName" name="deptName" readonly="readonly" value="${bean.deptName}" style="width: 260px;height: 30px;margin-left: 10px " >
							</td>
						</tr>
						<tr id="ktname" class="trbody" hidden="hidden">
							<td  class="td1"style="width: 70px;">课题名称</td>
							<td class="td2" >
								<input class="easyui-textbox" id="taskname" name="taskname"  readonly="readonly" value="${bean.taskname}" style="width: 265px;height: 30px;margin-left: 10px " >
							</td>
						</tr>
						<tr class="trbody" hidden="hidden"> 
							<td class="td1" style="width: 70px;">报销时间</td>
							<td class="td2" >
								<input class="easyui-datebox" id="reqTime" name="reqTime" readonly="readonly" value="${bean.reqTime}" style="height: 30px;margin-left: 10px; margin-bottom: 5px;" >
							</td>
							<td class="td1" style="width: 70px;"><span class="style1">*</span></td>
							<td class="td2" >
							</td>
						</tr>

					</table>
				</div>				
			</div>
			</form>
				<!-- 报销明细 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 40px;width: 695px">
					<div title="费用明细" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
						<div style="overflow:auto;">
							<!--  通用事项申请明细 -->
							<jsp:include page="directly_mingxi_detail.jsp" />
						</div>
						<div style="overflow:hidden;margin-top: 0px">
							<!-- 通用事项发票明细 -->
							<jsp:include page="mingxi_directly_detail.jsp" />
						</div>
					</div>
				</div>

				<!-- 收款人信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
					<div id="tongyongDeatilId" hidden="hidden">
						<div title="收款人信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;padding:0px;">
							<div id="" style="overflow-x:hidden;margin-top: 0px;">
								<jsp:include page="payee-info_detail.jsp" />	
							</div>
						</div>
					</div>
					<div id="xueshengDeatilId" hidden="hidden">
						<div title="学生收款人信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;padding:0px;">
							<div id="" style="overflow-x:hidden;margin-top: 0px;">
								<jsp:include page="payee-info-student-detail.jsp" />	
							</div>
						</div>
					</div>
					<div id="jianhangDeatilId" hidden="hidden">
						<div title="建行收款人信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;padding:0px;">
							<div id="" style="overflow-x:hidden;margin-top: 0px;">
								<jsp:include page="payee-info-ccb-detail.jsp" />	
							</div>
						</div>
					</div>
					<div id="feijianhangDeatilId" hidden="hidden">
						<div title="非建行收款人信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;padding:0px;">
							<div id="" style="overflow-x:hidden;margin-top: 0px;">
								<jsp:include page="payee-info-no-ccb-detail.jsp" />	
							</div>
						</div>
					</div>
				</div>
				<!-- 附件信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
				<div title="附件信息" data-options="collapsed:false,collapsible:false"style="overflow:auto;">		
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
						<tr>
							<td class="td1" style="text-align: left;width: 50px;"><span class="style1"></span>
								附件
								<input type="file" multiple="multiple" id="f" onchange="upladFile(this,null,'zcgl01')" hidden="hidden">
								<input type="text" id="files" name="files" hidden="hidden">
							</td>
							<td colspan="4" id="tdf">
								<a onclick="$('#f').click()" style="font-weight: bold;" href="#">
									<%-- <img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">  --%>
								</a>
								<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
									<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
									 </div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
								</div>
								<c:forEach items="${attaList}" var="att">
									<div style="margin-top: 0px;">
									<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<%-- <img style="margin-top: 5px;" src="${base}/resource-modality/${themenurl}/sccg.png">
									&nbsp;&nbsp;&nbsp;&nbsp;
									<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a> --%>
									</div>
								</c:forEach>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!-- 审批记录 -->
			<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
				<div title="审批记录" data-options="collapsed:false,collapsible:false" style="overflow:auto;padding:0px;">
					<!-- <div class="window-title"> 审批记录</div> -->
						<jsp:include page="../../../check_history.jsp" />
				</div>
			</div>
		</div>
		
		<div class="window-left-bottom-div">
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
$(document).ready(function() {
	//是否显示 冲销借款信息
	jk()
	selectCxjk();
	//设置时间
	if ($("#input_reqTime").val() == "") {
		var date = new Date();
		date=ChangeDateFormat(date);
		$("#input_reqTime").val(date);
		$("#p_reqTime").html(date);
	}
	var amount = $("#amount").val();
	if(amount !=""){
		$('#applyAmount_span').html(fomatMoney(amount,2)+" [元]");
	}
	$('#form_0').hide(); 
	var taskname = $("#taskname").val();
	if(taskname !="" && taskname != null){
		$('#ktname').show();
	}else{
		$('#ktname').hide();
	}
});

function selectCxjk(){
	var cxjk = $('input[name="withLoan"]:checked').val();
	if(cxjk==1){
		$('tr.cxjk').css('display','');
	} else {
		$('tr.cxjk').css('display','none');
	}
}

//打开借款单选择页面
function chooseJkd(){
	var win = creatFirstWin('借款单选择', 840, 450, 'icon-search', '/loan/choose?menuType=fromBxsq');
	win.window('open');
}
//打开指标选择页面
function openIndex() {
	//var win=creatFirstWin('选择指标',860,580,'icon-search','/quota/choiceIndex');
	var win=creatFirstWin('选择指标',1060,580,'icon-search','/apply/choiceIndex?menuType=beforeApply'); 
	win.window('open');
}
//保存
function saveReimburse(flowStauts) {
	directlyjson();
	getpayerinfoJson();
	var jsonStr1 = $("#form1").serializeJson();
	// 在后台反序列话成明细Json的对象集合
	$('#json1').val(jsonStr1);
	
	var payerMoney = 0.00;
	var reimburseAmount = parseFloat($("#amount").val());
	var payerrows = $('#payer_info_tab').datagrid('getRows');
	for(var i=0;i<payerrows.length;i++){
		payerMoney = parseFloat(payerMoney) + parseFloat(payerrows[i].payeeAmount);
	}
	if(payerMoney>reimburseAmount){
		alert('转账金额不得超过报销金额');
		return false;
	}
	var IndexName=$("#F_fBudgetIndexName").textbox().textbox('getValue');
	if(''==IndexName){
		alert("请选择指标！");
		return false;
	}
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);
	if($("#files").val()==null||$("#files").val()==''){
		alert('请上传附件');
		return false;
	}
	//设置审批状态
	$('#drFlowStauts').val(flowStauts);
	//设置申请状态
	$('#drStauts').val(flowStauts);
	
	//报销金额
	var applyAmount = $('#amount').val();
	//指标剩余金额
	var syjeamount = $('#syjeamount').val();
	var syAmount =0;
	//剩余金额
	syAmount = parseFloat(syjeamount);
	
	if(applyAmount>syAmount){
		alert("预算剩余金额不足！请调整申报金额.");
		return false;
	}else{
		//提交
		$('#directly_reimburse_save_form').form('submit', {
			onSubmit : function() {
				flag = $(this).form('enableValidation').form('validate');
				if (flag) {
					//如果校验通过，则进行下一步
					//报销类型为0直接报销
					$('#drType').textbox('setValue','0');
					$.messager.progress();
				}else{
					//校验不通过，就打开第一个校验失败的手风琴
					openAccordion();
				}
				return flag;
			},
			url : base + '/directlyReimburse/save',
			success : function(data) {
				if (flag) {
					$.messager.progress('close');
				}
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$('#directlyReimbTab').datagrid('reload');
					$('#indexdb').datagrid('reload');
					closeWindow();
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
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

//打开指标选择页面
function openIndex() {
	var win=creatFirstWin('选择指标',1060,580,'icon-search','/apply/choiceIndex?menuType=reimburse'); 
	win.window('open');
}
	
//计算总额
function setFsumMoneys(newValue,oldValue) {
	
	if(newValue==undefined || oldValue==undefined){
		return false;
	}
	var totalFsumMoney = 0;
	var fsumMoney = 0;
	var index=$('#drmxdg').datagrid('getRowIndex',$('#drmxdg').datagrid('getSelected'));
	var rows = $('#drmxdg').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		if(i==index){
			fsumMoney=parseFloat(newValue);
		}else{
			totalFsumMoney+=addNum1(rows,i);
		}  
	 
	}
	totalFsumMoney=(parseFloat(totalFsumMoney)+parseFloat(fsumMoney));
	totalFsumMoney=parseFloat(totalFsumMoney);
	$('#amount').val(totalFsumMoney,2);
	$('#applyAmount_span').html(fomatMoney(totalFsumMoney,2)+" [元]");
}
//未编辑或者已经编辑完毕的行
function addNum1(rows,index){
		var amount=rows[index]['applySum'];
	if(amount==null){
		return 0;
	}else{
	return parseFloat(amount); 
	}
}

//冲销借款
function cx(){
	
	var num1=parseFloat($('#input_jkdamonut').val());
	var num2=parseFloat($("#amount").val());
	var num3=parseFloat($('#applyAmount').val());
	if(isNaN(num1)&&!isNaN(num2)){
		 $('#skAccount').numberbox('setValue',num2.toFixed(2));
	}
	if(!isNaN(num1)&&!isNaN(num2)){
		if(num2<num1){
			var num4=num1-num2;
			 $('#cxAmount').html(fomatMoney(num2,2)+" [元]");
			 $('#syAmount').html(fomatMoney(num4,2)+" [元]");
			 $('#skAccount').numberbox('setValue',0);
		}else{
			$('#cxAmount').html(fomatMoney(num1,2)+" [元]");
			$('#syAmount').html(fomatMoney(0,2)+" [元]");
			$('#skAccount').numberbox('setValue',(num2-num1).toFixed(2));
		}
	}
	if(!isNaN(num2)){
		if(num2<num3){
			var num5=num3-num2;
			$('#ghAmount').html(fomatMoney(num5,2)+" [元]");
		}else{
			$('#ghAmount').html(fomatMoney(0,2)+" [元]");
		}
	}
}

function jk(){
	
	var cxjk = $('input[name="withLoan"]:checked').val();
	var num2=parseFloat($("#amount").val());
	var num3=parseFloat($('#applyAmount').val());
	if(cxjk==1){
	var num1=parseFloat(${bean.loan.leastAmount});
	if(!isNaN(num1)&&!isNaN(num2)){
		if(num2<num1){
			var num4=num1-num2;
			 $('#cxAmount').html(fomatMoney(num2,2)+" [元]");
			 $('#syAmount').html(fomatMoney(num4,2)+" [元]");
		}else{
			$('#cxAmount').html(fomatMoney(num1,2)+" [元]");
			$('#syAmount').html(fomatMoney(0,2)+" [元]");
		}
	}
	}
	if(!isNaN(num2)){
		if(num2<num3){
			var num5=num3-num2;
			$('#ghAmount').html(fomatMoney(num5,2)+" [元]");
		}else{
			$('#ghAmount').html(fomatMoney(0,2)+" [元]");
		}
	}
}

function selectCxjk(){
	var num1=parseFloat($('#input_jkdamonut').val());//借款金额
	var num2=parseFloat($("#amount").val());//报销金额
	var num3=parseFloat($('#applyAmount').val());//申请金额
	var cxjk = $('input[name="withLoan"]:checked').val();
	if(cxjk==1){
		$('#jk').show();
		if(!isNaN(num1)&&!isNaN(num2)){
			if(num2<num1){
				var num4=num1-num2;
				 $('#cxAmount').html(fomatMoney(num2,2)+" [元]");
				 $('#syAmount').html(fomatMoney(num4,2)+" [元]");
				 $('#skAccount').numberbox('setValue',0);
			}else{
				$('#cxAmount').html(fomatMoney(num1,2)+" [元]");
				$('#syAmount').html(fomatMoney(0,2)+" [元]");
				$('#skAccount').numberbox('setValue',(num2-num1).toFixed(2));
			}
		}
		if(!isNaN(num2)){
			if(num2<num3){
				var num5=num3-num2;
				$('#ghAmount').html(fomatMoney(num5,2)+" [元]");
			}else{
				$('#ghAmount').html(fomatMoney(0,2)+" [元]");
			}
		}
	} else {
		$('#jk').hide();
		//$('#input_jkdamonut').val(0);
		$('#skAccount').numberbox('setValue',num2.toFixed(2));
	}
}

function onselectDirTypeDetail(data){
	//判断是否通用
	if(data.code=='TONGYONG'){
		$("#tongyongDeatilId").show();
		$("#xueshengDeatilId").hide();
		$("#jianhangDeatilId").hide();
		$("#feijianhangDeatilId").hide();
		$.parser.parse('#tongyongDeatilId');
	}
	if(data.code=='XUESHENG'){
		$("#tongyongDeatilId").hide();
		$("#xueshengDeatilId").show();
		$("#jianhangDeatilId").hide();
		$("#feijianhangDeatilId").hide();
		$.parser.parse('#xueshengDeatilId');
	}
	if(data.code=='JIANHANG'){
		$("#tongyongDeatilId").hide();
		$("#xueshengDeatilId").hide();
		$("#jianhangDeatilId").show();
		$("#feijianhangDeatilId").hide();
		$.parser.parse('#jianhangDeatilId');
	}
	if(data.code=='FEIJIANHANG'){
		$("#tongyongDeatilId").hide();
		$("#xueshengDeatilId").hide();
		$("#jianhangDeatilId").hide();
		$("#feijianhangDeatilId").show();
		$.parser.parse('#feijianhangDeatilId');
	}
}
</script>

</body>