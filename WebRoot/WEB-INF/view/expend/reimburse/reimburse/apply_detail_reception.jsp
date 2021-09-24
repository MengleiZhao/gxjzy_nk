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
	var costFood = $("#costFood").val();
	if(costFood !=""){
		$('#costFood_span').html(fomatMoney(costFood,2)+" [元]");
	}
	var costHotel = $("#costHotel").val();
	if(costHotel !=""){
		$('#costHotel_span').html(fomatMoney(costHotel,2)+" [元]");
	}
	var costOther = $("#costOther").val();
	if(costOther !=""){
		$('#costOther_span').html(fomatMoney(costOther,2)+" [元]");
	}
	var applyAmount = $("#applyAmount").val();
	$('#applyAmount_span').html(fomatMoney(applyAmount,2)+" [元]");
	
	var plan1 = $("#diningPlacePlan1").val();
	var plan2 = $("#diningPlacePlan2").val();
	if(plan1=='1'){
    	$('#tr1').show();
	}else{
		$('#tr1').hide();
	}
	if(plan2=='1'){
    	$('#tr0').show();
	}else{
		$('#tr0').hide();
	}
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
	
});


//保存
function saveApply(flowStauts) {
	// 在后台反序列化成明细Json的对象集合
	accept();
	var type = '${type}';
	var rows;
	if(type=='1'){
		rows = $('#appli-detail-dg').datagrid('getRows');
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
	}

	//设置审批状态
	$('#applyflowStauts').val(flowStauts);
	//设置申请状态
	$('#applyStauts').val(flowStauts);

	if($('#applyAmount').textbox('getValue')==""||$('#applyAmount').textbox('getValue')=="0.00") {
		alert('请填写费用明细申请金额');
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
	//alert(newValue + ',' + oldValue);
	var type = '${type}';
	if (type!='1') {
		//bakup 2019-05-08 差旅明细使用固定配置
		
		//计算总额：1-计算非编辑行
		var rows = $('#appli-detail-dg-travel').datagrid('getRows');
		var totalPrice = 0;
		for(var i=0; i<rows.length; i++){
			var pri = parseFloat(rows[i].applySum);
			if(!isNaN(pri)){
				totalPrice = totalPrice + pri;
			}
		}
		//2-计算当前编辑行
		var row = $('#appli-detail-dg-travel').datagrid('getSelected');//获得选择行
		var index=$('#appli-detail-dg-travel').datagrid('getRowIndex',row);//获得选中行的行号
		var tr = $('#appli-detail-dg-travel').datagrid('getEditors', index);
		//var standar = parseFloat(tr[1].target.textbox('getValue'));//获得选中行的开支标准
		var standar = row.standard;
		//var price = parseFloat(tr[0].target.numberbox('getValue'));
		//var price = parseFloat(row.applySum);
		var price = parseFloat(newValue);
		var priceOld = parseFloat(row.applySum);//判断之前是否有数据
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
				/* if(isNaN(priceOld)){
					//原先无数据的，可以计入
					totalPrice = totalPrice + price;
				} else if(!isNaN(parseFloat(oldValue))){
					totalPrice = totalPrice + price;
				} */
			}
		}
		//给两个总额框赋值
		$('#applyAmount').numberbox('setValue',totalPrice);
		$('#num1').numberbox('setValue',totalPrice);
		return;
	} else {
		var row = $('#appli-detail-dg').datagrid('getSelected');//获得选择行
		var index=$('#appli-detail-dg').datagrid('getRowIndex',row);//获得选中行的行号
		var tr = $('#appli-detail-dg').datagrid('getEditors', index);
		var standar= tr[1].target.textbox('getValue');//获得选中行的开支标准
		
		if(parseFloat(newValue)>parseFloat(standar)){
			/* //改变没有通过的字体颜色
			tr[2].target.textbox('textbox').css('color','red'); */
			
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
		$('#applyAmount').textbox('setValue',num.toFixed(2));
	}
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
	$('#num1').textbox('setValue',num);
	$('#applyAmount').textbox('setValue',num);
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
	$('#applyAmount').textbox('setValue',0);
}

</script>
<!-- 预算信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 20px;width:697px;">
				<div title="预算信息" data-options="collapsible:false" style="overflow:auto;height: 150px;margin-left: 0px;width:670px;">				
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;width:670px;">
						<tr class="trbody">
							<td style="width: 60px;float: left;"><span class="style1">*</span> 支出项目</td>
							<td colspan="3" style="">
								<input class="easyui-textbox" style="width: 635px;height: 30px;"
								value="${applyBean.indexName}"
							 readonly="readonly" required="required"/>
							</td>
						</tr>
					</table>	
					<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="margin-left: 0px;width:695px;height: 50px;">
							<tr>
								<td class="window-table-td1"><p>批复金额：</p></td>
								<td class="window-table-td2"><p id="p_pfAmount"><fmt:formatNumber groupingUsed="true" value="${bean.pfAmount}" minFractionDigits="2" maxFractionDigits="2"/>元</p></td>
								
								<td class="window-table-td1"><p>预算年度：</p></td>
								<td class="window-table-td2"><p id="p_pfDate">${fn:substring(bean.pfDate, 0, 4)}</p></td>
							</tr>
							<tr>
								<td class="window-table-td1"><p>可用额度：</p></td>
								<td class="window-table-td2"><p id="p_syAmount"><fmt:formatNumber groupingUsed="true" value="${bean.indexAmount}" minFractionDigits="2" maxFractionDigits="2"/>元</p></td>
							</tr>
					</table>				
				</div>
				</div>
				<!-- 基本信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width:670px;">
				<div title="基本信息" data-options="collapsible:false" style="overflow:false;">
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:660px;">
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span>事项摘要</td>
							<td colspan="4">
									<input class="easyui-textbox" style="width: 510px;height: 30px; " value="${applyBean.gName}"readonly="readonly" required="required" data-options="validType:'length[1,50]'"/>
							</td>
						</tr>
							<!-- 公务接待信息 -->
							<jsp:include page="reception_detail.jsp" />
					</table>
				</div>				
				</div>
				<!-- 参考观察者安排 -->
				<%-- <div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width:697px">
					<div title="参考观察安排" data-options="collapsible:false"	style="overflow:auto;">
						<div style="overflow:auto;margin-top: 0px">
						<jsp:include page="observe_plan_detail.jsp" />
						</div>
					</div>
				</div> --%>
				<%-- <div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width:697px">
					<div title="其他安排" data-options="collapsible:false"
						style="overflow:auto;">
						<div style="overflow:auto;margin-top: 0px">
						<tr style="height: 70px;">
							<td colspan="3">
								<textarea name="otherContet" readonly="readonly" id="otherContet" class="textbox-text"   autocomplete="off" 
								  style="width:688px;height:80px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:5px; margin-bottom:0px;">${receptionBean.otherContet}</textarea>
							</td>
						</tr>
						</div>
					</div>
				</div> --%>
				<!-- 费用明细 -->
				<%-- <div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width:697px;">
					<div title="费用明细" data-options="collapsible:false"
						style="overflow:auto;">
						<div style="overflow:auto;margin-top: 0px">
							<!--  公务接待申请  明细 -->
							<jsp:include page="mingxi_reception_detail.jsp" />
							<div style="overflow:auto;margin-top: 10px;">
								<span style="float: left;">
									<span style="color: red;"  >申请金额总计： </span>
									<span style="float: right;"  id="applyAmount_span" ><fmt:formatNumber groupingUsed="true" value="${applyBean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span>
								</span>
							</div>
							<div class="window-table" style="margin-bottom:10px;">
								<div style="">
									<span>被接待人员自行缴纳伙食费和交通费情况</span>
								</div>
								<div style="width:690px;margin-top:10px;display:flex">
									<div style="flex:1;">
									<label>缴费人数&nbsp;</label> 
									<input type="text" name="paymentNum" class="easyui-numberbox" readonly="readonly" style="width:150px;" value="${receptionBean.paymentNum}" />
									</div>
									<div style="flex:1;">
									<label>缴费标准&nbsp; </label> 
									<input type="text" name="paymentStd" class="easyui-textbox" readonly="readonly" style="width:150px;"value="${receptionBean.paymentStd}" />
									</div>
									<div style="flex:1;">
									<label>缴费总金额&nbsp;</label> 
									<input type="text" name="paymentAmount" class="easyui-numberbox" readonly="readonly" style="width:150px;" value="${receptionBean.paymentAmount}" data-options="icons: [{iconCls:'icon-yuan'}],precision:2"/>
									</div>
								</div>	
							</div>										
						</div>
					</div>
				</div> --%>
				
				<!-- 附件信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width:697px;">
				<div title="附件信息" data-options="collapsible:false" style="overflow:auto;width:697px;">		
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:695px;">
						<tr class="trbody">
								<td class="td1" style="width:55px;">附件</td>
								<td colspan="4">
									<c:if test="${!empty attaList}">
									<c:forEach items="${attaList}" var="att">
									<c:if test="${att.serviceType=='file'}">
										<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a><br>
									</c:if>	
									</c:forEach>
								</c:if>
								<c:if test="${empty attaList}">
									<span style="color:#999999">暂未上传附件</span>
								</c:if>
								</td>
							</tr>
						
						
					</table>
					
				</div>
				</div>
				<!-- 审批记录 事前申请 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;width: 695px">
					<div title="审批记录" data-options=" collapsible:false" style="overflow:auto;">
						<!-- <div class="window-title"> 审批记录</div> -->
							<jsp:include page="../../../check_history_reim_apply.jsp" />
					</div>
				</div>
