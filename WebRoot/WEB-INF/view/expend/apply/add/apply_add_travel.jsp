<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<style>
.under{
	outline: none;
	width:25px;
    border-bottom: 1px solid #000;
    border-top: 0px;
    border-left: 0px;
    border-right: 0px;
}
</style>
<script type="text/javascript">
function ChangeDateFormat1(val) {
	var t, y, m, d, h, i, s;
    if(val==null){
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
	/* //设值时间
	if ($("#applyReqTime").textbox().textbox('getValue') == "") {
		$("#applyReqTime").textbox().textbox('setValue', 'date');
	} */
	//设置时间
	if($("#applyReqTime").val()==""||$("#applyReqTime").val()==null){
		var date = new Date();
		date=ChangeDateFormat1(date);
		$("#req_time").html(date);
		$("#applyReqTime").val(date);
	} else {
		var date = $("#applyReqTime").val();
		date=ChangeDateFormat1(date);
		$("#req_time").html(date);
	}
	
	//设置支出申请扩展信息
	var h = $("#applyTypeHi").textbox().textbox('getValue');
	if (h != "") {
		$('#applyType').val(h);
	}
	
	if (h == 1) {
		
		$('#sqsqhyxx').remove();
		$('#sqsqpxxx').remove();
		$('#sqsqclxx').remove();
		$('#sqsqjdxx').remove();
		$('#sqsqjdrymd').remove();
		$('#sqsqgwyc').remove();
		$('#sqsqgwcg').remove();
		/* $("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息'); */
	}
	if (h == 2) {//会议
		$('#sqsqpxxx').remove();
		$('#sqsqclxx').remove();
		$('#sqsqjdxx').remove();
		$('#sqsqjdrymd').remove();
		$('#sqsqgwyc').remove();
		$('#sqsqgwcg').remove();
	}
	if (h == 3) {//培训
		$('#sqsqhyxx').remove();
		$('#sqsqclxx').remove();
		$('#sqsqjdxx').remove();
		$('#sqsqjdrymd').remove();
		$('#sqsqgwyc').remove();
		$('#sqsqgwcg').remove();
	}
	if (h == 4) {//差旅
		$('#sqsqhyxx').remove();
		$('#sqsqpxxx').remove();
		$('#sqsqjdxx').remove();
		$('#sqsqjdrymd').remove();
		$('#sqsqgwyc').remove();
		$('#sqsqgwcg').remove();
	}
	if (h == 5) {//接待
		$('#sqsqhyxx').remove();
		$('#sqsqpxxx').remove();
		$('#sqsqclxx').remove();
		$('#sqsqgwyc').remove();
		$('#sqsqgwcg').remove();
	}
	if (h == 6) {//公务用车
		$('#sqsqhyxx').remove();
		$('#sqsqpxxx').remove();
		$('#sqsqclxx').remove();
		$('#sqsqjdxx').remove();
		$('#sqsqjdrymd').remove();
		$('#sqsqgwcg').remove();
	}
	if (h == 7) {//公务出国
		$('#sqsqhyxx').remove();
		$('#sqsqpxxx').remove();
		$('#sqsqclxx').remove();
		$('#sqsqjdxx').remove();
		$('#sqsqjdrymd').remove();
		$('#sqsqgwyc').remove();
	}
	//批复金额
	var pfAmount = $("#pfAmount").val();
	if(pfAmount !=""){
		$('#p_pfAmount').html(fomatMoney(pfAmount,2)+" [元]");
	}
	//可用金额
	var syAmount = $("#syAmount").val();
	if(syAmount !=""){
		$('#p_syAmount').html(fomatMoney(syAmount,2)+" [元]");
	}
	//批复时间
	var pfDate = $("#pfDate").val();
	if(pfDate !=""){
		$('#p_pfDate').html(pfDate);
	}
	var applyAmount = $("#applyAmount").val();
	if(applyAmount !=""){
		$('#applyAmount_span').html(fomatMoney(applyAmount,2)+" [元]");
	}
	
});


//保存
function saveApply(flowStauts) {
	// 在后台反序列化成明细Json的对象集合
	accept();
	var type = '${type}';
	var rows;
	if(type=='1' || type=='6'){
		rows = $('#appli-detail-dg').datagrid('getRows');
		if(type=='1'){
			var userName2 = $('#userName2').textbox('getValue');
			if(userName2==null){
				alert('请先选择下级审批人');
			}
		}
	}else{
		//bakup 2019-05-08 差旅明细使用固定配置
		$('#appli-detail-dg-travel').datagrid('acceptChanges');
		rows = $('#appli-detail-dg-travel').datagrid('getRows');
	}
	var mingxi = "";
	for (var i = 0; i < rows.length; i++) {
		mingxi = mingxi + JSON.stringify(rows[i]) + ",";
	}
	$('#mingxiJson').val(mingxi);
	
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);
	//在后台反序列话成被接待人员Json的对象集合
	var h = $("#applyTypeHi").textbox().textbox('getValue');
	if (h == 5) {
		acceptR();
		var rows2 = $('#rpt').datagrid('getRows');
		var recePeop = "";
		for (var i = 0; i < rows2.length; i++) {
			recePeop = recePeop + JSON.stringify(rows2[i]) + ",";
		}
		$('#recePeopJson').val(recePeop);
		var rptrows = $("#rpt").datagrid("getRows");
		var rePeopNum = $("#rePeopNum").numberbox('getValue');
		if(rptrows.length!=rePeopNum){
			alert('接待对象人数与接待人员名单人数不匹配');
			return;
		}
	}

	//设置审批状态
	$('#applyflowStauts').val(flowStauts);
	//设置申请状态
	$('#applyStauts').val(flowStauts);

	if($('#applyAmount').val()==""||$('#applyAmount').val()=="0.00") {
		alert('请填写费用明细申请金额');
		return;
	}
	
	//校验
	//预算指标
	var budgetIndexName = $('#F_fBudgetIndexName').val();
	if(budgetIndexName == ''){
		alert('请选择支出项目！');
		return;
	}
	//申请金额
	var applyAmount = $('#applyAmount').val();
	if(applyAmount == '' || applyAmount == '0.00') {
		alert('请填写费用明细申请金额！');
		return;
	}
	var syAmount = $('#syAmount').val();
	if(parseFloat(syAmount)<parseFloat(applyAmount)){
		alert('预算可用金额不足,请重新选择支出项目！');
		return;
	}
	//下一级审批人
	var nextUserName = $('#userName2').val();
	if(nextUserName == ''){
		alert('请选择下一级审批人！');
		return;
	}
	//下级审批人id
	var nextUserId = $('#fuserId').val();
	//校验标记
	var checkFlag = 0;
	$.ajax({
		url : base + '/apply/checkNextUser?id='+nextUserId,
		type : 'post',
		dataType : 'json',
		async: false,//取消异步
		success : function(data){
			if(!data){
				alert('下级审批人不能为会计岗，请重新选择！');
				checkFlag = 1;
			}
		}
	});
	if(checkFlag == 1){
		return;
	}
	
	//提交
	$('#apply_save_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if(!standardFlag()) {//standardFlag()方法在mingxi.jsp
				$(".easyui-accordion").accordion('select','费用明细'); 
				flag = false;
			} else if (flag) {
				//如果校验通过，则进行下一步
				$.messager.progress();
			}else{
				//校验不通过，就打开第一个校验失败的手风琴
				openAccordion();
			}
			return flag;
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
	var row = $('#appli-detail-dg').datagrid('getRows');
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
function addNum(newValue,oldValue) {
	var type = '${type}';
	
	if (type!='1' && type!='6') {
		//bakup 2019-05-08 差旅明细使用固定配置
		
		//2-计算当前编辑行
		var row = $('#appli-detail-dg-travel').datagrid('getSelected');//获得选择行
		var index=$('#appli-detail-dg-travel').datagrid('getRowIndex',$('#appli-detail-dg-travel').datagrid('getSelected'));//获得选中行的行号
		var tr = $('#appli-detail-dg-travel').datagrid('getEditors', index);
		var standar = row.standard;
		var price = parseFloat(newValue);
		var priceOld = parseFloat(row.applySum);//判断之前是否有数据
		//计算总额：1-计算非编辑行
		var rows = $('#appli-detail-dg-travel').datagrid('getRows');
		var totalPrice = 0;
		var pri = 0;
		for(var i=0; i<rows.length; i++){
			
			if(i==index){
				pri =parseFloat(newValue);
			}else{
				totalPrice+=addNums(rows,i);
			} 
		}
		//3-两类数值相加得到总额
		if(!isNaN(price)){
			if(parseFloat(newValue) > standar){
				alert('申请金额不能大于开支标准，请核对！');
				tr[0].target.numberbox('setValue','0');
				newValue=0;
			} else {
				//原先有数据且未改动的，不能进入总额合计
				if(!isNaN(priceOld) && isNaN(parseFloat(oldValue))){
					return;
				} else {
					totalPrice = totalPrice + price;
				}
			}
		}
		//给两个总额框赋值
		$('#applyAmount').val(totalPrice.toFixed(2));
		$('#applyAmount_span').html(fomatMoney(totalPrice,2)+" [元]");
		$('#num1').numberbox('setValue',totalPrice.toFixed(2));
		return;
	} else {
		var row = $('#appli-detail-dg').datagrid('getSelected');//获得选择行
		var index=$('#appli-detail-dg').datagrid('getRowIndex',row);//获得选中行的行号
		var tr = $('#appli-detail-dg').datagrid('getEditors', index);
		var standar= tr[1].target.textbox('getValue');//获得选中行的开支标准
		
		if(parseFloat(newValue)>parseFloat(standar)){
			
			alert('申请金额不能大于开支标准，请核对！');
			tr[2].target.textbox('setValue','0');
			newValue=0;
		}
		
		var num = 0;
		var rows = $('#appli-detail-dg').datagrid('getRows');
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
		$('#num1').textbox('setValue',num.toFixed(2));
		$('#applyAmount').val(num.toFixed(2));
		$('#applyAmount_span').html(fomatMoney(num,2)+" [元]");
	}
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
	if ($('#appli-detail-dg').datagrid('validateRow', editIndex)) {
		var ed = $('#appli-detail-dg').datagrid('getEditor', {
			index : editIndex,
			field : 'costDetail'
		});
		$('#appli-detail-dg').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow(index) {
	if (editIndex != index) {
		if (endEditing()) {
			$('#appli-detail-dg').datagrid('selectRow', index).datagrid('beginEdit',index);
			editIndex = index;
		} else {
			$('#appli-detail-dg').datagrid('selectRow', editIndex);
		}
	}
}
function append() {
	if (endEditing()) {
		$('#appli-detail-dg').datagrid('appendRow', {});
		editIndex = $('#appli-detail-dg').datagrid('getRows').length - 1;
		$('#appli-detail-dg').datagrid('selectRow', editIndex).datagrid('beginEdit',
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
	$('#appli-detail-dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
			editIndex);
	editIndex = undefined;
	
	//修改申请总额
	var num = 0;
	var rows = $('#appli-detail-dg').datagrid('getRows');
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
		$('#appli-detail-dg').datagrid('acceptChanges');
	}
}

//明细只加载一遍(在改变表格内容时如果有url他会优先加载url而不会加载手写的内容，所以只加载一遍会使表格不去请求url中的内容)
var mingxinum=1;
$("#appli-detail-dg").datagrid({
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
	var rows = $('#appli-detail-dg').datagrid('getRows');
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
	$('#appli-detail-dg').datagrid('loadData', data);
	$('#num1').textbox('setValue',0);
	$('#applyAmount').val(0);
	$('#applyAmount_span').html(fomatMoney(0,2)+" [元]");
}

var startday4='${travelBean.travelDateStart}';
var endday4='${travelBean.travelDateEnd}';

$("#travel_add_ksrq").datebox({
    onSelect : function(beginDate){
    	
    	startday4 = beginDate;
    	var d = (endday4 - startday4) / 86400000 + 1;
    	if (d > 0) {
    		$('#travelDayNum').textbox("setValue", d);
    		$('#hotelDayNum').textbox("setValue", d - 1);
    	} else {
    		$('#travelDayNum').textbox("setValue", "");
    		$('#hotelDayNum').textbox("setValue", "");
    	}
        $('#travel_add_jsrq').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});
	$(document).ready(function() {
		//设值复选框的值
		var h = $("#travelTypeHi").textbox().textbox('getValue');
		if (h != "") {
			$('#travelType').textbox().textbox('setValue', h);
		}
		var n = $("#wagesPlanHi").textbox().textbox('getValue');
		if (n != "") {
			$('#wagesPlan').textbox().textbox('setValue', n);
		}
		var j = $("#expensePlanHi").textbox().textbox('getValue');
		if (j != "") {
			$('#expensePlan').textbox().textbox('setValue', j);
		}
		
		//修改出差地区/开始日期/结束日期 时，自动计算支出明细
		$('#travel_add_placeEnd').textbox({
			onChange:function(newValue,oldValue){
				calcTravelCost();
			}
		});
		$('#travel_add_ksrq').datebox({
			onChange:function(newValue,oldValue){
				calcTravelCost();
			}
		});
		$('#travel_add_jsrq').datebox({
			onChange:function(newValue,oldValue){
				calcTravelCost();
			}
		});
	});


	function onSelect6(date) {
		endday4 = date;
		startday4 = new Date(startday4);
		var d = (endday4 - startday4) / 86400000 + 1;
		if (d > 0) {
			$('#travelDayNum').textbox("setValue", d);
			$('#hotelDayNum').textbox("setValue", d - 1);
		} else {
			$('#travelDayNum').textbox("setValue", "");
			$('#hotelDayNum').textbox("setValue", "");
		}
	}

	$('#wagesPlan').combobox({
		onChange : function(newValue, oldValue) {
			if (newValue != 1) {
				$('#foodDayNum').numberbox('disable');
			} else {
				$('#foodDayNum').numberbox('enable');
			}
		}
	});
	$('#expensePlan').combobox({
		onChange : function(newValue, oldValue) {
			if (newValue != 1) {
				$('#traDayNum').numberbox('disable');
			} else {
				$('#traDayNum').numberbox('enable');
			}
		}
	});
	
	//自动获得费用明细
	function calcTravelCost(){
		
		var configId = $('#travel_add_placeEnd_id').textbox('getValue');
		var realDates = $('#travel_add_ksrq').datebox('getValue');
		var realDatee = $('#travel_add_jsrq').datebox('getValue');
		if(configId=='' || realDates=='' || realDatee==''){
			return;
		}
		
		$('#appli-detail-dg-travel').datagrid({
			url: base+'/hotelStandard/calcCost?outType=travel',
			queryParams:{
				configId: configId,
				travelDates: realDates,
				travelDatee: realDatee
			}
		});
	}
	
	function chooseArea(){
		var win = creatFirstWin('选择-出差地区', 640, 580, 'icon-search', '/hotelStandard/choose');
		win.window('open');
	}
	$(function(){
		$("#hotelDayNum").numberbox({
			onChange: function(newValue, oldValue) {
				calcTravelCost();//住宿天数改变，重新计算开支标准
			}
		});
	});
</script>

<form id="apply_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:720px;height: 491px">
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
								<input type="hidden" name="trId" value="${travelBean.trId}" />
								<input type="hidden" name="travelRId" value="${tPeopBean.travelRId}" />
								<input type="hidden" id="travelTypeHi" value="${travelBean.travelType}" />
								<input type="hidden" id="wagesPlanHi" value="${travelBean.wagesPlan}" />
								<input type="hidden" id="expensePlanHi" value="${travelBean.expensePlan}" />
				<!-- 基本信息 -->
				<div class="easyui-accordion" style="margin-left:0px;">
				<div title="基本信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false"
					style="overflow:auto;padding:10px;">				
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
						<%-- <tr>
							<td class="td1">单据编号</td>
							<td>
								<input class="easyui-textbox" style="width: 590px;height: 30px; " value="${bean.gCode}" name="gCode" required="required" data-options="validType:'length[1,50]'"/>
							</td>
						</tr> --%>
						<tr>
							<td class="td1"><span class="style1">*</span>摘要</td>
							<td colspan="4">
								<input class="easyui-textbox" style="width: 590px;height: 30px; " value="${draftAdd}" name="gName" required="required" data-options="validType:'length[1,50]'"/>
							</td>
						</tr>
						<tr>
							<td class="td1"><span class="style1">*</span>出差事由</td>
							<td colspan="4">
								<input class="easyui-textbox" oninput="textareaNum(this,'textareaNum1')" autocomplete="off" style="width: 590px;height: 30px; " value="${bean.reason }" name="reason" id="reason" required="required" data-options="validType:'length[1,50]'"/>
							</td>
							<%-- <td>
								<textarea name="reason" id="reason" class="textbox-text"
										oninput="textareaNum(this,'textareaNum1')" autocomplete="off"
										style="width:590px;height:30px;resize:none">${bean.reason }</textarea>
							</td> --%>
						</tr>
						
					</table>
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 1px;">
								<!-- 隐藏域 -->
								
						<c:if test="${!empty travelBean.placeStart}">
						<tr class="trbody">
							<td colspan="5"><span style="color:#ff6800">系统已智能为您匹配常用的出差地区</span></td>
						</tr>
						</c:if>
					
						<!-- 选择出差地区 -->
						<tr class="trbody">
							<td class="td1" style="width: 12%"><span class="style1">*</span> 出差类型</td>
							<td class="td2">
								<select id="travelType" class="easyui-combobox" name="travelType" style="width: 200px; height: 30px;" required="required" editable="false">
									<option value="1">公务出差</option>
									<option value="2">非公务出差</option>
							</select>
							</td>
							<td class="td4" ></td>
							<td class="td1"><span class="style1">*</span> 出差地区</td>
							<td class="td2" onclick="chooseArea()">
								<input id="travel_add_placeEnd" name="travelArea.area" value="${travelBean.travelArea.area}" class="easyui-textbox" style="width: 200px; height: 30px;" 
								data-options="editable:false,prompt: '选择出差地' ,icons: [{iconCls:'icon-sousuo'}]"  required="required"/>
							</td>
							
							<%-- <td class="td4" style="width: 65px;"></td>
							
							<td class="td1"><!-- <span class="style1">*</span>差旅配置id --></td>
							<td class="td2">
								<div class="easyui-panel" data-options="closed:true">
									<input id="travel_add_placeEnd_id" name="travelArea.id" value="${travelBean.travelArea.id}" class="easyui-textbox" style="width: 200px; height: 30px;" 
									data-options="editable:false"/>
								</div>
							</td> --%>
						</tr>
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 交通工具</td>
							<td class="td2">
								<%-- <input class="easyui-textbox" style="width: 200px; height: 30px;" name="vehicle" value="${travelBean.vehicle}" required="required" data-options="validType:'length[1,10]'"> --%>
								<input class="easyui-combobox" style="width: 200px;height: 30px;" name="vehicle" id="vehicle"
								data-options="url:base+'/vehicle/comboboxJson?selected=${travelBean.vehicle}',
											method:'get',valueField:'code',textField:'text',editable:false,
											onSelect: function(rec){
											//如果选择其他，就显示手动输入框
									    	if(rec.code !='JTGJ06'){
												$('#vehicleLevel1').css('display','');
												$('#vehicleLevel2').css('display','');
												$('#vehicleOther1').css('display','none');
												$('#vehicleOther2').css('display','none');
												var url = base+'/vehicle/comboboxJson?selected=${travelBean.vehicle}&parentCode='+rec.code;
										    	$('#vehicleLevel').combobox('reload', url);
											}else{
												$('#vehicleOther1').css('display','');
												$('#vehicleOther2').css('display','');
												$('#vehicleLevel1').css('display','none');
												$('#vehicleLevel2').css('display','none');
											}
										    }"/>
							</td>
					
							<td class="td4" style="width: 65px;"></td>
							<td class="td1" id="vehicleLevel1"><span class="style1">*</span> 交通工具等级</td>
							<td class="td2"  id="vehicleLevel2">
								<input class="easyui-combobox" style="width: 200px;height: 30px;" name="vehicleLevel" id="vehicleLevel"
								data-options="url:base+'/vehicle/comboboxJson?selected=${travelBean.vehicleLevel}&parentCode=${travelBean.vehicle}',
											method:'get',valueField:'code',textField:'text',editable:false"/>
							</td>
							<td class="td1" id="vehicleOther1" style="display: none"><span class="style1">*</span> 其他交通工具</td>
							<td class="td2" id="vehicleOther2" style="display: none">
								<input class="easyui-textbox" style="width: 200px; height: 30px;" name="vehicleOther"
								value="${travelBean.vehicleOther}" data-options="validType:'length[1,100]'"/>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 开始日期</td>
							<td class="td2">
								<input id="travel_add_ksrq" class="easyui-datebox" style="width: 200px; height: 30px;" name="travelDateStart"
								data-options="" value="${travelBean.travelDateStart}" required="required" editable="false"/>
							</td>
					
							<td class="td4" style="width: 65px;"></td>
					
							<td class="td1"><span class="style1">*</span> 结束日期</td>
							<td class="td2">
								<input id="travel_add_jsrq" class="easyui-datebox" style="width: 200px; height: 30px;" name="travelDateEnd"
								data-options="onSelect:onSelect6" value="${travelBean.travelDateEnd}" required="required" editable="false"/>
							</td>
						</tr>
					
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 出差天数</td>
							<td class="td2">
								<input class="easyui-numberbox" style="width: 200px; height: 30px;" id="travelDayNum" name="travelDayNum"
								value="${travelBean.travelDayNum}" readonly="readonly" required="required" data-options="validType:'length[1,2]'"/>
							</td>
					
							<td class="td4" style="width: 65px;"></td>
					
							<td class="td1"><span class="style1">*</span> 住宿天数</td>
							<td class="td2">
								<input class="easyui-numberbox" style="width: 200px; height: 30px;" id="hotelDayNum" name="hotelDayNum"
								value="${travelBean.hotelDayNum}"  required="required"  data-options="validType:'length[1,2]'"/>
							</td>
						</tr>					
						<%-- <tr class="trbody">
							<td class="td1"><span class="style1">*</span> 出差类型</td>
							<td class="td2">
								<select id="travelType" class="easyui-combobox" name="travelType" style="width: 200px; height: 30px;" required="required" editable="false">
									<option value="1">公务出差</option>
									<option value="2">非公务出差</option>
							</select>
							</td>
					
							<td class="td4" style="width: 65px;"></td>
					
							<td class="td1"><span class="style1">*</span> 出差人</td>
							<td class="td2">
								<input class="easyui-textbox" style="width: 200px; height: 30px;" name="travelAttendPeop"
								value="${bean.userName}" readonly="readonly" required="required" data-options="validType:'length[1,100]'"/>
							</td>
						</tr> --%>				
						<%-- <tr class="trbody">
							<td class="td1"><span class="style1">*</span> 伙食费用安排</td>
							<td class="td2">
								<select id="wagesPlan" class="easyui-combobox" name="wagesPlan" style="width: 200px; height: 30px;" required="required" editable="false">
									<option value="1">单位支付</option>
									<option value="2">自行安排</option>
								</select>
							</td>
					
							<td class="td4" style="width: 65px;"></td>
					
							<td class="td1"><span class="style1">*</span> 住宿费用安排</td>
							<td class="td2">
								<select id="expensePlan" class="easyui-combobox" name="expensePlan" style="width: 200px; height: 30px;" required="required" editable="false">
									<option value="1">单位支付</option>
									<option value="2">自行安排</option>
								</select>
							</td>
						</tr>
					
						<tr class="trbody">
							<td class="td1">伙食费补助天数</td>
							<td class="td2">
								<input class="easyui-numberbox" style="width: 200px; height: 30px;" id="foodDayNum" name="foodDayNum"
								value="${travelBean.foodDayNum}" data-options="required:false,validType:'length[0,2]'">
							</td>
					
							<td class="td4" style="width: 65px;"></td>
					
							<td class="td1">住宿费补助天数</td>
							<td class="td2">
								<input class="easyui-numberbox" style="width: 200px; height: 30px;" id="traDayNum" name="traDayNum"
								value="${travelBean.traDayNum}" data-options="required:false,validType:'length[0,2]'"/>
							</td>
						</tr> --%>
						<!-- 临时存放后台计算后返回的费用 -->
						<input id="container_travelCost" type="hidden"/>
					
						<%-- <tr class="trbody">
							<td class="td1">&nbsp;&nbsp;人员备注</td>
							<td colspan="4">
								<input class="easyui-textbox" name="traPeopRemark" style="width:555px;"
								value="${tPeopBean.traPeopRemark}" data-options="required:false,validType:'length[0,250]'"></td>
						</tr> --%>
					
					
					</table>
				</div>				
				
	<!-- 		<!-- 出差人员名单 -->
				<div title="出差人员名单" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false"style="overflow:auto;padding:10px;">
				<div style="overflow:auto;margin-top: 0px;">
					<jsp:include page="travel_people.jsp" />
					</div>
				</div>
				
				<!-- 费用明细 -->
				<div title="费用明细" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false"
							style="overflow:hidden;padding:10px;">
							<div style="overflow:hidden;margin-top: 0px;">
								<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
									<tr class="trbody">
										<td class="td1">费用名称：</td>
										<td class="td2">
											住宿费(自动)
										</td>						
										<td class="td4" style="width: 40px;"></td>
										<td class="td1">计算标准：</td>
										<td class="td2">（人数<input class="under" type="text">*人/天<input class="under" type="text">元*<input class="under" type="text">天）</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>申请金额：</td>
										<td class="td2">
											<input class="easyui-numberbox" id="" name="" style="width: 200px; height: 30px;" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]"
											value="" required="required">
										</td>						
										<td class="td4" style="width: 40px;"></td>
										<td class="td1"></td>
										<td class="td2"></td>
									</tr>
									<tr class="trbody">
										<td class="td1">费用名称：</td>
										<td class="td2">
											伙食补助费(自动)
										</td>						
										<td class="td4" style="width: 40px;"></td>
										<td class="td1">计算标准：</td>
										<td class="td2">（人数<input class="under" type="text">*人/天<input class="under" type="text">元*<input class="under" type="text">天）</td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>申请金额：</td>
										<td class="td2">
											<input class="easyui-numberbox"  id="" name="" style="width: 200px; height: 30px;" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]"
											value="" required="required">
										</td>						
										<td class="td4" style="width: 40px;"></td>
										<td class="td1"></td>
										<td class="td2"></td>
									</tr>
									<tr class="trbody">
										<td class="td1">费用名称：</td>
										<td class="td2">
											长途交通费(自动)
										</td>						
										<td class="td4" style="width: 40px;"></td>
										<td class="td1"></td>
										<td class="td2"></td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>申请金额：</td>
										<td class="td2">
											<input class="easyui-numberbox"  id="" name="" style="width: 200px; height: 30px;" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]"
											value="" required="required">
										</td>						
										<td class="td4" style="width: 40px;"></td>
										<td class="td1"></td>
										<td class="td2"></td>
									</tr>
									<tr class="trbody">
										<td class="td1">费用名称：</td>
										<td class="td2">
											室内交通费(自动)
										</td>						
										<td class="td4" style="width: 40px;"></td>
										<td class="td1"></td>
										<td class="td2"></td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>申请金额：</td>
										<td class="td2">
											<input class="easyui-numberbox"  id="" name="" style="width: 200px; height: 30px;" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]"
											value="" required="required">
										</td>						
										<td class="td4" style="width: 40px;"></td>
										<td class="td1"></td>
										<td class="td2"></td>
									</tr>
									<tr class="trbody">
										<td class="td1">费用名称：</td>
										<td class="td2">
											其他费用(自动)
										</td>						
										<td class="td4" style="width: 40px;"></td>
										<td class="td1"></td>
										<td class="td2"></td>
									</tr>
									<tr class="trbody">
										<td class="td1"><span class="style1">*</span>申请金额：</td>
										<td class="td2">
											<input class="easyui-numberbox"  id="" name="" style="width: 200px; height: 30px;" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]"
											value="" required="required">
										</td>						
										<td class="td4" style="width: 40px;"></td>
										<td class="td1"></td>
										<td class="td2"></td>
									</tr>
									<tr class="trbody">
										<td class="td1"></td>
										<td class="td2"></td>						
										<td class="td4" style="width: 40px;"></td>
										<td class="td1"></td>
										<td class="td2"><a style="color: red;">申请总额：</a><input style="width: 100px;height: 30px;" class="easyui-numberbox" value="" readonly="readonly"/></td>
									</tr>
								</table>
							</div>
					</div>
				
				<!-- 预算信息 -->
				<!-- <div class="easyui-accordion" style=""> -->
				<div title="预算信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false"
					style="overflow:auto;padding:10px;">				
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 支出项目</td>
							<td colspan="3" style="padding-right: 5px;">
								<a onclick="openIndex()" href="#">
								<input class="easyui-textbox" style="width: 590px;height: 30px;"
								name="indexName" value="${bean.indexName}" id="F_fBudgetIndexName"
								data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo'}]" readonly="readonly" required="required"/>
								</a>
							</td>
						</tr>
					</table>	
					<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0">
							<tr>
								<td class="window-table-td1"><p>批复金额:</p></td>
								<td class="window-table-td2"><p id="p_pfAmount">${bean.pfAmount}万元</p></td>
								
								<td class="window-table-td1"><p>预算年度:</p></td>
								<td class="window-table-td2"><p id="p_pfDate">${bean.pfDate}</p></td>
							</tr>
							
							<tr>
								<td class="window-table-td1"><p>可用额度:</p></td>
								<td class="window-table-td2"><p id="p_pfDepartName">${bean.pfDepartName}</p></td>
								
								<td class="window-table-td1"><p>累计支出:</p></td>
								<td class="window-table-td2"><p id="p_syAmount">${bean.syAmount}万元</p></td>
							</tr>
					</table>				
				</div>
				
				<div title="附件信息" data-options="iconCls:'icon-xxlb',collapsed:false,collapsible:false" style="overflow:auto;padding:10px;">
					<table>
						<tr>
							<td class="td1">
								&nbsp;&nbsp;附件
								<input type="file" multiple="multiple" id="f" onchange="upladFile(this,null,'zcgl01')" hidden="hidden">
								<input type="text" id="files" name="files" hidden="hidden">
							</td>
							<td colspan="4" id="tdf">
								<a onclick="$('#f').click()" style="font-weight: bold;" href="#">
									<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
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
				
				<!-- 差旅信息 -->
				<%-- <div id="sqsqclxx"  style="overflow:auto;margin-top: 10px;">
					<div class="window-title">差旅信息</div>
					<jsp:include page="travel.jsp" />
				</div> --%>
				</div>					
		
			
			<div class="window-left-bottom-div">
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
				<a href="javascript:void(0)" onclick="showFlowDesinger()">
				<img src="${base}/resource-modality/${themenurl}/button/CCLCT1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
			
		</div>
		<c:if test="${type!=1 }">
			<div class="window-right-div" style="width:254px;height: auto;padding-bottom: 20px;">
				<jsp:include page="../../../check_system.jsp" />
			</div>
		</c:if>
	</div>
</form>
