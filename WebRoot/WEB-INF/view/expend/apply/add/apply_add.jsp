<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>


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
	/* //可用金额
	var syAmount = $("#syAmount").val();
	if(syAmount !=""){
		$('#p_syAmount').html(fomatMoney(syAmount,2)+" [元]");
	} */
	var applyAmount = $("#applyAmount").val();
	if(applyAmount !=""){
		$('#applyAmount_span').html(fomatMoney(applyAmount,2)+" [元]");
	}
	
});


//保存
function saveApply(flowStauts) {
	accept();
	var reasonString = $("#reason").val();
	if(flowStauts!='0'){
	if(reasonString==''){
		alert('请填写申请事由！');
		return false;
	}

		var fcostType = $('#fcostType').combobox('getValue');
		if(fcostType==''){
			alert('请选择费用类型！');
			return false;
		}
	}
	if(flowStauts!='0'){
	if($('#applyAmount_span').html()=='&nbsp;'||parseInt($('#applyAmount_span').html())<=0){
		alert('请注意填写费用明细金额！');
		return ;
	}
	}
	
	//预算指标
	var budgetIndexName = $('#F_fBudgetIndexName').val();
	if(flowStauts!='0'){
	if(budgetIndexName == ''){
		alert('请选择支出项目！');
		return;
	}
	}
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);
	/* 	if(s==''){
		alert('请上传附件！');
		return false;
	} */
	// 在后台反序列化成明细Json的对象集合
	
	var type = '${type}';
	var rows;
	//校验会议的人数
	if(type==2 && !validateMeetStd()){
		return;
	}
	//校验会议的总支出费用
	if (type==2 && !validateTotalMoney()) {
		return;
	}
	//校验其他
	if(type=='1' || type=='6'){
		rows = $('#appli-detail-dg').datagrid('getRows');
		/* if(type=='1'){
			var userName2 = $('#userName2').textbox('getValue');
			if(userName2==null){
				alert('请先选择下级审批人');
			}
		} */
	}else{
		/* //bakup 2019-05-08 差旅明细使用固定配置
		$('#appli-detail-dg-travel').datagrid('acceptChanges');
		rows = $('#appli-detail-dg-travel').datagrid('getRows'); */
	}
	var mingxi = "";
	for (var i = 0; i < rows.length; i++) {
		mingxi = mingxi + JSON.stringify(rows[i]) + ",";
	}
	$('#mingxiJson').val(mingxi);
	
	
	
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
	if(flowStauts!='0'){
	if($('#applyAmount').val()==""||$('#applyAmount').val()=="0.00") {
		alert('请填写费用明细申请金额');
		return;
	}
	}
	
	//校验
	
	//申请金额
	var applyAmount = $('#applyAmount').val();
	var syAmount = $('#syAmount').val();
	if(flowStauts!='0'){
	if(applyAmount == '' || applyAmount == '0.00') {
		alert('请填写费用明细申请金额！');
		return;
	}
	}
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
	var userid = '${userid}';
	if(userid==nextUserId){
		alert('下级审批人不能是自己，请重新选择！');
		return;
	}
/* 	var checkFlag = 0;
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
	} */
	var flag = true;
	//提交
	$('#apply_save_form').form('submit', {
		onSubmit : function() {
			if(flowStauts!='0'){
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
		$('#applyAmount_span').html(totalPrice.toFixed(2)+" [元]");
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
		$('#applyAmount_span').html(num.toFixed(2)+" [元]");
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
	/* var div = document.getElementById('easyAcc');
	div.scrollTop = div.scrollHeight; */
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
	$('#applyAmount_span').html(num.toFixed(2)+" [元]");
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
var flagProcessNum = 0;
function reloadProcessComm(rec) {
	if (rec.value != '') {
		$('#check_system_div').load('${base}/apply/refreshApplyProcessComm?type='+rec.value);
	}
}
$("#fcostType").combobox({
	          onSelect: function (rec) {
	        	  if(flagProcessNum > 1){
		        	  reloadProcessComm(rec);
	        	  }
	        	  flagProcessNum +=1;
	         }
	     })

</script>

<form id="apply_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;"">
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
				<!-- 项目ID --><input type="hidden" name="proId" value="${bean.proId}" id="F_proId"/>
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
				<div title="预算信息" data-options="collapsible:false"style="overflow:auto;margin-left: 0px;height: auto">				
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;width:707px;">
						<tr class="trbody">
							<td style="width: 60px;float: left;"><span style="text-align: left;color: red">*</span> 支出项目</td>
							<td colspan="3" style="padding-right: 5px;">
								<a onclick="openIndex()" href="#">
								<input class="easyui-textbox" style="width: 642px;height: 30px;"
								name="indexName" value="${bean.indexName}" id="F_fBudgetIndexName"
								data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo'}]" readonly="readonly" required="required"/>
								</a>
							</td>
						</tr>
					</table>	
					<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="margin-left: 0px;width:707px;height: 50px;">
							<tr>
								
								<td class="window-table-td1"><p>预算年度：</p></td>
								<td class="window-table-td2"><p id="p_pfDate">${bean.pfDate}</p></td>
								<td class="window-table-td1" style="width: 128px"><p></p></td>
								<td class="window-table-td2"><p></p></td>
							</tr>
							
							<tr hidden="hidden">
								<td class="window-table-td1" style="width: 128px"><p>批复金额：</p></td>
								<td class="window-table-td2"><p id="p_pfAmount">${bean.pfAmount}元</p></td>
								<td class="window-table-td1"><p>可用额度：</p></td>
								<td class="window-table-td2"><p id="p_syAmount">${bean.indexAmount}元</p></td>
							</tr>
					</table>				
				</div>
				</div>
				<!-- 基本信息 -->
				<div id="sqsqjbxx" style="overflow:auto;margin-top: 0px;">			
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="基本信息" data-options="collapsed:false,collapsible:false"style="overflow:auto;">
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
						<%-- <tr>
							<td class="td1">单据编号</td>
							<td colspan="3">
								<c:if test="${operation=='add' }">
									<input class="easyui-textbox" style="width: 590px;height: 30px; " value="${applyCodeAdd}" name="gCode" required="required" 
									data-options="validType:'length[1,50]',editable:false" />
								</c:if>
								<c:if test="${operation!='add' }">
									<input class="easyui-textbox" style="width: 590px;height: 30px; " value="${bean.gCode}" name="gCode" required="required" 
									data-options="validType:'length[1,50]',editable:false"/>
								</c:if>
							</td>
						</tr> --%>
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 事项摘要</td>
							<td colspan="3">
								<c:if test="${operation=='add' }">
									<input class="easyui-textbox" style="width: 590px;height: 30px; " value="${draftAdd}" name="gName" required="required" data-options="validType:'length[1,50]'"/>
								</c:if>
								<c:if test="${operation!='add' }">
									<input class="easyui-textbox" style="width: 590px;height: 30px; " value="${bean.gName}" name="gName" required="required" data-options="validType:'length[1,50]'"/>
								</c:if>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span>申请事由</td>
							<td colspan="3">
								<textarea name="reason" id="reason" class="textbox-text" 
										oninput="textareaNum(this,'textareaNum1')" autocomplete="off"
										style="width:584px;height:70px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:8px; margin-bottom:0px;">${bean.reason }</textarea>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 经办人</td>
							<td class="td2" >
								<input class="easyui-textbox" id="userNames" name="userNames" readonly="readonly" value="${bean.userNames}" style="width: 245px;height: 30px;margin-left: 10px " >
							</td>
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 部门名称</td>
							<td class="td2" >
								<input class="easyui-textbox" id="deptName" name="deptName" readonly="readonly" value="${bean.deptName}" style="width: 245px;height: 30px;margin-left: 10px " >
							</td>
						</tr>
						 <tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 费用类型</td>
							<td class="td2">
							<select id="fcostType" class="easyui-combobox"
								name="fcostType" style="width: 245px; height: 30px;" data-options="required:true" required="required" editable="false" data-options="onselect:reloadProcessComm">
									<option value="" <c:if test="${bean.fcostType==''}"> selected="selected" </c:if>>--请选择--</option>
									<option value="1" <c:if test="${bean.fcostType=='1'}"> selected="selected" </c:if>>人员经费-基本工资、基础绩效、伙食补助、离休费</option>
									<option value="2" <c:if test="${bean.fcostType=='2'}"> selected="selected" </c:if>>人员经费-纳入奖励性绩效工资的人员经费</option>
									<option value="3" <c:if test="${bean.fcostType=='3'}"> selected="selected" </c:if>>人员经费-职工探亲费</option>
									<option value="4" <c:if test="${bean.fcostType=='4'}"> selected="selected" </c:if>>部门日常办公经费</option>
									<option value="5" <c:if test="${bean.fcostType=='5'}"> selected="selected" </c:if>>部门日常办公经费（发放劳务费）</option>
									<option value="6" <c:if test="${bean.fcostType=='6'}"> selected="selected" </c:if>>因公出国经费（使用“三公经费”出国）</option>
									<option value="7" <c:if test="${bean.fcostType=='7'}"> selected="selected" </c:if>>因公出国经费（使用科研经费、财政专项拨款出国）</option>
									<option value="8" <c:if test="${bean.fcostType=='8'}"> selected="selected" </c:if>>科研经费/教研经费</option>
									<option value="9" <c:if test="${bean.fcostType=='9'}"> selected="selected" </c:if>>其他公用经费</option>
							</select>
							</td>
						</tr> 
					</table>
				</div>				
				</div>
				</div>
				<!-- 费用明细 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 40px">
					<div title="费用明细" data-options="collapsible:false"
						style="overflow:auto;">
						<div style="overflow:auto;margin-top: 0px">
							<c:if test="${type!=1 &&  type !=6 && type!=2 && type!=3 }">
								<jsp:include page="mingxi_travel.jsp" />
							</c:if>
							<c:if test="${type==1 || type==6}">
								<!--  通用事项申请 和 公车运维申请  明细 -->
								<jsp:include page="mingxi.jsp" />
							</c:if>
							<div style="overflow:auto;margin-top: 10px;margin-right: 52px;">
								<span style="float: right;">
									<span style="color: red;"  >申请总额： </span>
									<span style="float: right;"  id="applyAmount_span" >&nbsp;</span>
								</span>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 附件信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="附件信息" data-options="collapsible:false"style="overflow:auto;">		
					
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
						<tr>
							<td class="td1" style="width:55px;text-align: left"><!-- <span class="style1">*</span> -->
								附件
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
	
				<%-- <!-- 下级审批人 -->
				<div class="easyui-accordion" style="">
					<c:if test="${type==1 }">
						<div title="下级审批人" data-options="collapsible:false" 
						style="overflow:auto;padding:10px; ">
							<c:if test="${type!=1}">
							</c:if>
							<jsp:include page="nextrole.jsp" />
						</div>
					</c:if>
				</div> --%>
				
				
				<c:if test="${operation!='add' }">
				<!-- 审批记录 -->
				<div class="easyui-accordion" style="">
					<div title="审批记录" data-options="collapsible:false" style="overflow:auto;padding:10px;">
						<!-- <div class="window-title"> 审批记录</div> -->
						<c:if test="${type!=1 }">
							<jsp:include page="../../../check_history.jsp" />
						</c:if>												
						
						<c:if test="${type==1 }">
							<jsp:include page="../check/check_history.jsp" />												
						</c:if>												
					</div>
				</div>
				</c:if>
				
				
				
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
		<div class="window-right-div" id="check_system_div" style="width:254px;height: auto;padding-bottom: 20px;">
			<jsp:include page="../../../check_system.jsp" />
		</div>
	</div>
</form>
