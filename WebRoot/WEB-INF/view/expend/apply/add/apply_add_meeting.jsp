<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<script type="text/javascript">
function ChangeDateFormat1(val) {
	var t, y, m, d, h, i, s;
    if(val==null || val==""){
  	  return "";
    }
    t = new Date(val);
    y = t.getFullYear();
    m = t.getMonth() + 1;
    d = t.getDate();
    h = t.getHours();
    i = t.getMinutes();
    s = t.getSeconds();
    // 可根据需要在这里定义时间格式  
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) + ' ' + (h < 10 ? '0' + h : h) + ':' + (i < 10 ? '0' + i : i);
}
function ChangeDateFormatReq(val) {
	
	var t, y, m, d, h, i, s;
    if(val==null || val==""){
  	  return "";
    }
    t = new Date(val);
    y = t.getFullYear();
    m = t.getMonth() + 1;
    d = t.getDate();
    h = t.getHours();
    i = t.getMinutes();
    s = t.getSeconds();
    // 可根据需要在这里定义时间格式  
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
}
//显示详细信息手风琴页面
$(document).ready(function() {
	//var meetType = $("#meetingType")[0].value;
	//var newvalue = $("#attendNum")[0].value;//参会人数
	var meetType = $("#meetingType").val();
	var newvalue = $("#attendNum").val();//参会人数
	if(meetType == '4'){
		if(newvalue>50){
			$('#bz').show();
		}else {
			$('#bz').hide();
		} 
	}else {
		$('#bz').hide();
	}
	//设置时间
	if($("#applyReqTime").val()==""||$("#applyReqTime").val()==null){
		var date = new Date();
		date=ChangeDateFormatReq(date);
		$("#req_time").html(date);
		$("#applyReqTime").val(date);
	} else {
		var date = $("#applyReqTime").val();
		date=ChangeDateFormatReq(date);
		$("#req_time").html(date);
	}
	
	//设置支出申请扩展信息
	var h = $("#applyTypeHi").val();
	if (h != "") {
		$('#applyType').val(h);
	}
	//批复金额
	var pfAmount = $("#pfAmount").val();
	if(pfAmount !=""){
		$('#p_pfAmount').html(fomatMoney(pfAmount,2)+" [元]");
	}
/* 	//可用金额
	var syAmount = $("#syAmount").val();
	if(syAmount !=""){
		$('#p_syAmount').html(fomatMoney(syAmount,2)+" [元]");
	} */
	var applyAmount = $("#applyAmount").val();
	if(applyAmount !=""){
		$('#applyAmount_span').html(fomatMoney(applyAmount,2) + '[元]');
	}
	
	var meet_num = $("#duration")[0].value;//会议天数
	var meet_personNum = $("#attendNum")[0].value;//参会人数
	var duration = $("#duration")[0].value;//天数
	var hotelStd = $("#hotelStd").val();
	if(hotelStd !=""){
		$('#p_hotelStd').html(fomatMoney(hotelStd,2));
		$('#p_allhotelMoney').html(fomatMoney(hotelStd*duration*(meet_num+meet_personNum),2));
	}
	
	var foodStd = $("#foodStd").val();
	if(foodStd !=""){
		$('#p_foodStd').html(fomatMoney(foodStd,2));
		$('#p_allfoodMoney').html(fomatMoney(foodStd*duration*(meet_num+meet_personNum),2));
	}
	
	var otherStd = $("#otherStd").val();
	if(otherStd !=""){
		$('#p_otherStd').html(fomatMoney(otherStd,2));
		$('#p_allotherMoney').html(fomatMoney(otherStd*duration*(meet_num+meet_personNum),2));
	}
	
});


//保存
function saveApply(flowStauts) {
	if(flowStauts!='0'){
	if($('#applyAmount_span').html()=='&nbsp;'||parseInt($('#applyAmount_span').html())<=0){
		alert('请注意填写费用明细金额！');
		return ;
	}
	}
	// 在后台反序列化成明细Json的对象集合
	var type = '${type}';
	var rows;
	$('#dg_meet_plan').datagrid('acceptChanges');
	rows = $('#dg_meet_plan').datagrid('getRows');
	if(flowStauts!='0'){
	if(rows.length==0){
		alert("请填写会议日程！");
		return ;
	}
	}
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);
	//在后台反序列化成会议日程Json的对象集合
	var h = $("#applyTypeHi").textbox().textbox('getValue');
	acceptR();
	var rows2 = $('#dg_meet_plan').datagrid('getRows');
	var meetPLan = "";
	for (var i = 0; i < rows2.length; i++) {
		meetPLan = meetPLan + JSON.stringify(rows2[i]) + ",";
	}
	$('#meetPlanJson').val(meetPLan);
	accept()
	//设置审批状态
	$('#applyflowStauts').val(flowStauts);
	//设置申请状态
	$('#applyStauts').val(flowStauts);
	if(flowStauts!='0'){
	if($('#applyAmount').val()==""||$('#applyAmount').val()=="0.00") {
		alert('请填写费用明细申请金额');
		return;
	}
	}
	//校验
	//预算指标
	var budgetIndexName = $('#F_fBudgetIndexName').val();
	if(flowStauts!='0'){
	if(budgetIndexName == ''){
		alert('请选择支出项目！');
		return;
	}
	}
	//申请金额
	var applyAmount = $('#applyAmount').val();
	if(flowStauts!='0'){
	if(applyAmount == '' || applyAmount == '0.00') {
		alert('请填写费用明细申请金额！');
		return;
	}
	}
	var attendNum = isNaN(parseFloat($('#attendNum').numberbox("getValue")))?0:parseFloat($('#attendNum').numberbox("getValue"));//参会人数
	var duration = isNaN(parseFloat($('#duration').numberbox("getValue")))?0:parseFloat($('#duration').numberbox("getValue"));//会议天数
	var staffNum = isNaN(parseFloat($('#staffNum').numberbox("getValue")))?0:parseFloat($('#staffNum').numberbox("getValue"));//工作人数
	var hotelPersonNum = parseFloat($('#hotelPersonNum').val());
	var foodPersonNum = parseFloat($('#foodPersonNum').val());
	var printingPersonNum = parseFloat($('#printingPersonNum').val());
	if (isNaN(hotelPersonNum)) {
		hotelPersonNum = 0;
	}
	if (isNaN(foodPersonNum)) {
		foodPersonNum = 0;
	}
	if (isNaN(printingPersonNum)) {
		printingPersonNum = 0;
	}
	if (((staffNum+attendNum)*(duration-1)) < hotelPersonNum ){
		$('#hotelPersonNum').val(0);
		getHotelMoney();
		alert('住宿费人·天超出标准，请重新填写！');
		return false;
	}
	if (((staffNum+attendNum)*duration) < foodPersonNum){
		$('#foodPersonNum').val(0);
		getFoodMoney();
		alert('伙食费人·天超出标准，请重新填写！');
		return false;
	}
	if ((staffNum+attendNum) < printingPersonNum){
		$('#printingPersonNum').val(0);
		getPrintingMoney();
		alert('文件印刷费人·天超出标准，请重新填写！');
		return false;
	}
	var hotelStdMoney = $('#hotelStdUpdate').val();
	var foodStdMoney = $('#foodStdUpdate').val();
	var otherStdMoney = $('#otherStdUpdate').val();
	
	var hotelMoney = $('#hotelMoney').val();
	if (hotelMoney == '' || hotelMoney == '0') {
		hotelStdMoney = 0;
	}
	var foodMoney = $('#foodMoney').val();
	if (foodMoney == '' || foodMoney == '0') {
		foodStdMoney = 0;
	}
	var otherMoney = $('#p_otherAllMoney').html();
	if (otherMoney == '' || otherMoney == '0.00元') {
		otherStdMoney = 0;
	}
	
	var stdMoney = Number(hotelStdMoney) + Number(foodStdMoney) + Number(otherStdMoney);
	if(Number(stdMoney) < Number(applyAmount)) {
		alert('申请总额不得超过定额标准总额！');
		return;
	}
	
	var syAmount = $('#syAmount').val();
	if(parseFloat(syAmount)<parseFloat(applyAmount)){
		alert('预算可用金额不足,请重新选择支出项目！');
		return;
	}
	var flag = true;
	//提交
	$('#apply_save_form').form('submit', {
		onSubmit : function() {
			if(flowStauts!='0'){
			flag = $(this).form('enableValidation').form('validate');
			 if (flag) {
				//如果校验通过，则进行下一步
				$.messager.progress();
			}else{
				//校验不通过，就打开第一个校验失败的手风琴
				openAccordion();
			}
			return flag;
			}
		},
		url : base + '/apply/save',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			} 
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#applyTab'+h).datagrid('reload');
				$('#indexdb').datagrid('reload');
				closeWindow();
				
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});
}

//打开指标选择页面
function openIndex() {
	//var win=creatFirstWin('选择指标',860,580,'icon-search','/quota/choiceIndex');
	var win=creatFirstWin('选择指标',1060,580,'icon-search','/apply/choiceIndex?menuType=beforeApply'); 
	win.window('open');
}

function standardFlag() {
	var row = $('#appli-detail-dg1').datagrid('getRows');
	for(var i=0;i<row.length;i++) {
		if(row[i].standard!="据实列支") {//当开支标准不等于据实列支是，判断
			if(parseFloat(row[i].applySum)>parseFloat(row[i].standard)){
				alert('申请金额不能大于开支标准，请核对！');
				return false;
			}
		}
	}
	return true;
}

//计算申请总额
function addNum1(newValue,oldValue) {
		var row = $('#appli-detail-dg1').datagrid('getSelected');//获得选择行
		var index=$('#appli-detail-dg1').datagrid('getRowIndex',row);//获得选中行的行号
		var tr = $('#appli-detail-dg1').datagrid('getEditors', index);
		var standar= parseFloat(row.totalStandard);//获得选中行的开支标准
		if(isNaN(standar)){
			standar=0;
		}
		/* if(parseFloat(newValue)>parseFloat(standar)){
			
			alert('申请金额不能大于开支标准，请核对！');
			tr[0].target.numberbox('setValue',0);
			newValue=0;
		} */
		
		var num = 0;
		var rows = $('#appli-detail-dg1').datagrid('getRows');
		for(var i=0;i<rows.length;i++){
			if(i!=index){
				if(rows[i].applySum!=""&&rows[i].applySum!=null){
					num += parseFloat(rows[i].applySum);
				}
			}
		}
		if(newValue!=""&&newValue!=null) {
			num += parseFloat(newValue);
		}
		$('#applyAmount').val(num.toFixed(2));
		$('#applyAmount_span').html(fomatMoney(num,2));
}
//未编辑或者已经编辑完毕的行
function addNums(rows,index){
	
	var amount=rows[index]['applySum'];
	if(amount==null){
		amount=0;
		return parseFloat(amount);
	}
	return parseFloat(amount); 
}
//明细表格添加删除，保存方法
var editIndex = undefined;
function endEditing() {
	if (editIndex == undefined) {
		return true
	}
	if ($('#appli-detail-dg1').datagrid('validateRow', editIndex)) {
		var ed = $('#appli-detail-dg1').datagrid('getEditor', {
			index : editIndex,
			field : 'costDetail'
		});
		$('#appli-detail-dg1').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow(index) {
	if (editIndex != index) {
		if (endEditing()) {
			$('#appli-detail-dg1').datagrid('selectRow', index).datagrid('beginEdit',index);
			editIndex = index;
		} else {
			$('#appli-detail-dg1').datagrid('selectRow', editIndex);
		}
	}
}
function append() {
	if (endEditing()) {
		$('#appli-detail-dg1').datagrid('appendRow', {});
		editIndex = $('#appli-detail-dg1').datagrid('getRows').length - 1;
		$('#appli-detail-dg1').datagrid('selectRow', editIndex).datagrid('beginEdit',
				editIndex);
	}

	//页面随滚动条置底
	var div = document.getElementById('easyAcc');
	div.scrollTop = div.scrollHeight;
}
function removeit() {
	if (editIndex == undefined) {
		return
	}
	$('#appli-detail-dg1').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
			editIndex);
	editIndex = undefined;
	
	//修改申请总额
	var num = 0;
	var rows = $('#appli-detail-dg1').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		if(rows[i].applySum!=""&&rows[i].applySum!=null){
			num += parseFloat(rows[i].applySum);
		}
	}
	$('#num1').textbox('setValue',num.toFixed(2));
	$('#applyAmount').val(num.toFixed(2));
	$('#applyAmount_span').html(fomatMoney(num,2)+" [元]");
}
function accept() {
	if (endEditing()) {
		$('#dg_meet_plan').datagrid('acceptChanges');
	}
}

//明细只加载一遍(在改变表格内容时如果有url他会优先加载url而不会加载手写的内容，所以只加载一遍会使表格不去请求url中的内容)
var mingxinum=1;
$("#appli-detail-dg1").datagrid({
	onBeforeLoad: function () {
		if(mingxinum != 1) {
			return false;
		} else {
			mingxinum = mingxinum + 1;
			return true;
		}
	}
});

//重新计算开支标准的方法（重新计算开支标准，清空申请金额）
function calculateStandard(newValue, oldValue) {
	accept();//先保存明细
	var rows = $('#appli-detail-dg1').datagrid('getRows');
	var mingxi = "";
	
	for (var i = 0; i < rows.length; i++) {
		if(i==0) {
			rows[i].applySum=0;//清空申请金额
			rows[i].standard=parseFloat((rows[i].standard/oldValue)*newValue);//重新计算开支标准
			mingxi = mingxi + "["+JSON.stringify(rows[i]);
		} else {
			rows[i].applySum=0;//清空申请金额
			rows[i].standard=parseFloat((rows[i].standard/oldValue)*newValue);//重新计算开支标准
			mingxi = mingxi + "," + JSON.stringify(rows[i]);
		}
	}
	mingxi = mingxi + "]";
	var data = $.parseJSON(mingxi); 
	$('#appli-detail-dg1').datagrid('loadData', data);
	$('#num1').textbox('setValue',0);
	$('#applyAmount').val(0);
	$('#applyAmount_span').html(fomatMoney(0,2)+" [元]");
}


</script>
<form id="apply_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div">
				<!-- 隐藏域 --> 
				<!-- 主键ID --><input type="hidden" name="gId" value="${bean.gId}" />
				<!-- 申请单流水号 --><input type="hidden" name="gCode" value="${bean.gCode}" />
				<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="applyflowStauts" />
				<!-- 申请状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="applyStauts" />
				<%-- <!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}" />
				<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" /> --%>
				<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
				<!-- 申请类型 --><input type="hidden" id="applyTypeHi" value="${bean.type}" />
				<!-- 指标ID --><input type="hidden" name="indexId" value="${bean.indexId}" id="F_fBudgetIndexCode"/>
				<!-- 项目支出明细ID --><input type="hidden" name="proDetailId" value="${bean.proDetailId}" id="F_proDetailId"/>
				<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="F_indexType"/>
				<!-- 申请时间  --><input type="hidden" id="applyReqTime" name="reqTime" value="${bean.reqTime}"/>
				<!-- 申请事项  --><input type="hidden" id="applyType" name="type" value="${bean.type}"/>
				<!-- 申请总额  --><input type="hidden" id="applyAmount" name="amount" value="${bean.amount}"/>
				<!-- 可用金额  --><input type="hidden" id="syAmount" value="${bean.syAmount}"/>
				<!-- 批复金额  --><input type="hidden" id="pfAmount" value="${bean.pfAmount}"/>
				<!-- 批复时间  --><input type="hidden" id="pfDate"  value="${bean.pfDate}"/>
				<!-- 流程id  --><input type="hidden" id="flowId"  value="${fpId}"/>
				<!--历史审批节点  --><input type="hidden" id="historyNodes"  value="${historyNodes}"/>
				<!-- 下一级审批节点  --><input type="hidden" id="nextKey"  value="${bean.nCode}"/>
				
				<!-- 预算信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 0px">
				<div title="预算信息" data-options="collapsible:false" style="overflow:auto;margin-left: 0px;height: auto">				
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;width:707px;">
						<tr class="trbody">
							<td style="width: 60px;float: left;"><span style="text-align: left;color: red">*</span> 支出项目</td>
							<td colspan="3"  style="padding-right: 5px;">
								<a onclick="openIndex()" href="#">
								<input class="easyui-textbox" style="width: 642px;height: 30px;"
								name="indexName" value="${bean.indexName}" id="F_fBudgetIndexName"
								data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo'}]" readonly="readonly" required="required"/>
								</a>
							</td>
						</tr>
					</table>	
					<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="margin-left: 0px;width:707px;height: 50px;">
							<tr >
								<td class="window-table-td1"><p>预算年度：</p></td>
								<td class="window-table-td2"><p id="p_pfDate">${bean.pfDate}</p></td>
								<td class="window-table-td1" style="width: 128px"><p></p></td>
								<td class="window-table-td2"><p></p></td>
								
							</tr>
							
							<tr hidden="hidden">
								<td class="window-table-td1" style="width: 128px"><p>批复金额：</p></td>
								<td class="window-table-td2"><p id="p_pfAmount">${bean.pfAmount}元</p></td>
								<td class="window-table-td1"><p>可用额度：</p></td>
								<td class="window-table-td2"><p id="p_syAmount">${bean.indexAmount}</p></td>
								
								<%-- <td class="window-table-td1"><p>累计支出:</p></td>
								<td class="window-table-td2"><p id="p_syAmount">${bean.syAmount}万元</p></td> --%>
							</tr>
					</table>				
				</div>
				</div>
				
				<!-- 基本信息 -->
				<div id="sqsqjbxx" style="overflow:auto;margin-top: 0px;">			
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 事项摘要</td>
							<td colspan="5">
								<c:if test="${operation=='add' }">
									<input class="easyui-textbox" style="width: 590px;height: 30px; " value="${draftAdd}" name="gName" required="required" data-options="validType:'length[1,50]'"/>
								</c:if>
								<c:if test="${operation!='add' }">
									<input class="easyui-textbox" style="width: 590px;height: 30px; " value="${bean.gName}" name="gName" required="required" data-options="validType:'length[1,50]'"/>
								</c:if>
							</td>
						</tr>
						<tr style="height:3px">
						</tr>
						<%-- <tr class="trbody">
								<td class="td1"><span class="style1">*</span>申请事由</td>
							<td colspan="3"><input class="easyui-textbox"
								data-options="multiline:true,required:true,validType:'length[0,250]'"
								name="reason" style="width:590px;height:70px;"
								value="${bean.reason }"></td>
						</tr> --%>
						<c:if test="${type==2 }">
							<!-- 会议信息 -->
							<jsp:include page="meeting.jsp" />
						</c:if>
					</table>
				</div>				
				</div>
				</div>
				
				<!-- 会议日程 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="会议日程" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
					<div style="overflow:auto;margin-top: 0px">
						<jsp:include page="meeting_plan.jsp" />
					</div>
				</div>
				</div>
				
				<!-- 费用明细 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 40px">
					<div title="费用明细" data-options="collapsible:false" style="overflow:auto;padding:10px;">
						<div style="overflow:auto;margin-top: 0px">
							<!--  会议申请  明细 -->
							<jsp:include page="mingxi_meeting1.jsp" />
							<div style="overflow:auto;margin-top: 10px;margin-right: 52px;">
									<span style="float: left;margin-left: 10px;">
										&nbsp;&nbsp;
										<span style="color: red;">申请总额： </span>
										<span id="applyAmount_span">0.00[元]</span>
									</span>
									<span style="float: right;">
										&nbsp;&nbsp;
										<span style="color: red;">定额标准总额： </span>
										<span  id="stdAmount_span">&nbsp;</span>
									</span>
							</div>
						</div>
					</div>
				</div>
				
				
				
				<!-- 附件信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="附件信息" data-options="collapsible:false"
					style="overflow:auto;">		
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
						<tr>
							<td class="td1" style="width:55px;text-align: left">
								附件:
								<input type="file" multiple="multiple" id="f" onchange="upladFile(this,null,'zcgl01')" hidden="hidden">
								<input type="text" id="files" name="files" hidden="hidden">
							</td>
							<td colspan="3" id="tdf">
								&nbsp;&nbsp;
								<a onclick="$('#f').click()" style="font-weight: bold;  " href="#">
									<img style="vertical-align:bottom;margin-bottom: 5px;" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
								</a>
								<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
									<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
									 </div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
								</div>
								<c:forEach items="${attaList}" var="att">
									<div style="margin-top: 5px;">
									<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<img style="margin-top: 5px;" src="${base}/resource-modality/${themenurl}/sccg.png">
									&nbsp;&nbsp;&nbsp;&nbsp;
									<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
									</div>
								</c:forEach>
							</td>
						</tr>
					</table>
				</div>
				</div>
				<%-- <c:if test="${operation!='add' }">
				<!-- 审批记录 -->
				<div class="easyui-accordion" style="">
					<div title="审批记录" data-options="iconCls:'icon-xxlb',collapsible:false" style="overflow:auto;padding:10px;">
						<!-- <div class="window-title"> 审批记录</div> -->
						<c:if test="${type!=1 }">
							<jsp:include page="../../../check_history.jsp" />
						</c:if>												
						
						<c:if test="${type==1 }">
							<jsp:include page="../check/check_history.jsp" />												
						</c:if>												
					</div>
				</div>
				</c:if> --%>
			</div>
			<div class="window-left-bottom-div" style="margin-top: 55px;">
				<a href="javascript:void(0)" onclick="saveApply(0)">
				<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveApply(1)">
				<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="closeWindow()">
				<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				&nbsp;&nbsp;
				 <a href="${base }/systemcentergl/list?typeStr=支出管理" target="blank">
					<img src="${base}/resource-modality/${themenurl}/button/xgzd1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a> 
				&nbsp;&nbsp;
				<%-- <a href="javascript:void(0)" onclick="showFlowDesinger()">
				<img src="${base}/resource-modality/${themenurl}/button/CCLCT1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a> --%> 
			</div>
			
		</div>
		<c:if test="${type!=1 }">
			<div class="window-right-div" id="check_system_div" style="width:254px;height: auto;padding-bottom: 20px;">
				<jsp:include page="../../../check_system.jsp" />
			</div>
		</c:if>
	</div>
</form>
