<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body>
<div  data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:755px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px">
			<div class="window-left-top-div">
				<form id="reimburse_save_form" style="height: 0px;" method="post"  enctype="multipart/form-data">
				<!-- 隐藏域 --> 
				<!-- 主键ID --><input type="hidden" name="rId" value="${bean.rId}" id="rId"/>
				<!-- 报销单号 --><input type="hidden" name="rCode" value="${bean.rCode}"/>
				<!-- 申请单流水号 --><input type="hidden" name="gCode"<c:if test="${operation=='add' }">value="${applyBean.gCode}"</c:if><c:if test="${operation=='edit' }">value="${bean.gCode}"</c:if> />
				<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="reimburseFlowStauts" />
				<!-- 报销状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="reimburseStauts" />
				<%-- <!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}" />
				<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" /> --%>
				<input hidden="hidden" value="${bean.fuserId}" name="fuserId" id="fuserId"/>
				<!-- 下环节处理人名称 --><input type="hidden" id="input_userName2" name="userName2" value="${bean.userName2}"/>
				<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
				<!-- 报销类型 --><input type="hidden" id="reimburseTypeHi" value="${bean.type}" name="type"/>
				<!-- 报销金额 --><input type="hidden" id="reimburseAmount" name="amount" value="${bean.amount}" />
				<!-- 指标ID --><input type="hidden" name="indexId" value="${bean.indexId}" id=""/>
				<!-- 预算指标名称 --><input type="hidden" id="indexName" name="indexName" value="${bean.indexName}" />
				<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="indexType"/>
				<!-- 报销人 --><input type="hidden" name="userName" value="${bean.userName}" id="input_userName"/>
				<!-- 报销部门 --><input type="hidden" name=deptName value="${bean.deptName}" id="input_deptName"/>
				<!-- 报销说明 --><input type="hidden" name=reimburseReason  id="input_reimburseReason"/>
				<div id="panelID" class="easyui-panel" data-options="closed:true">
					<!-- 报销时间 --><input class="easyui-datetimebox" name="reimburseReqTime" value="${bean.reimburseReqTime}" id="input_reimburseReqTime" />
					<!-- 项目支出明细ID --><input type="hidden" name="proDetailId" value="${bean.proDetailId}" id="proDetailId"/>
					<input type="hidden" id="applyAmount" name="applyAmount" value="${applyBean.amount}" />
					<input type="hidden"  id="hskAccount" name="payeeAmount" value="${payee.payeeAmount}"/><!-- 转账金额 -->
					<input type="hidden" id="hbank" name="bank" value="${payee.bank}"  /><!-- 开户行 -->
					<input type="hidden" id="hbankAccount" name="bankAccount" value="${payee.bankAccount}" /><!-- 银行账户 -->
					<input type="hidden" id="hidCard" name="idCard" value="${payee.idCard}" /><!-- 身份证号 -->
					<input type="hidden" id="hpayeeName" name="payeeName" value="${payee.payeeName}" /><!-- 收款人 -->
					<input type="hidden" id="arry" name="arry" value="" />
					<input id="input_jkdid" hidden="hidden" value="${bean.loan.lId}" name="loan.lId"/>
					<input id="input_jkdamonut" value="${bean.loan.lAmount}" hidden="hidden"  />
				</div>
				<input type="hidden" id="json1" name="form1" />
				<input type="hidden" id="payerinfoJson" name="payerinfoJson" />
				<input type="hidden" id="mingxiJson" name="mingxi"/>
			</form>
				<div class="tab-wrapper" id="reimburse-comminfo-add">
					<ul class="tab-menu">
						<li class="active" onclick="onclickcommset()">报销单</li>
						<li onclick="onclickcommsetdeatil()" >申请单</li>
					</ul>
					<div class="tab-content">
						<div title="报销单" style="margin-bottom:35px;width: 737px" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="reimburse_comm_onlydetail.jsp" />
						</div>
						<div title="申请单" style="overflow:auto;margin-bottom:35px;width: 737px" data-options="iconCls:'icon-xxlb'">
							<jsp:include page="apply_comm_detail.jsp" />
						</div>
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
flashtab('reimburse-comminfo-add');
//防止不停重新加载
var itineraryurlcount = 0;
function onclickcommset(){
	if(itineraryurlcount>0){
		itineraryurlcount+=1;
		return false;
	}else {
		itineraryurlcount+=1;
		$('#reimburse_itinerary_tab_id').datagrid('reload');
		return true;
	}
}
var detaiurlcount = 0;
function onclickcommsetdeatil(){
	if(detaiurlcount>=1){
		detaiurlcount+=1;
		return false;
	}else {
		detaiurlcount+=1;
		$('#appli-detail-dg').datagrid('reload');
		$('#check-history-dg-comm').datagrid('reload');
		return true;
	}
}

//冲销借款
function cx(){
	var num1=parseFloat($('#input_jkdamonut').val());
	var num2=parseFloat($('#reimburseAmount').val());
	var num3=parseFloat($('#applyAmount').val());
	if(isNaN(num1)&&!isNaN(num2)){
		 $('#skAccount').numberbox('setValue',num2);
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
			$('#skAccount').numberbox('setValue',num2-num1);
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
	var num2=parseFloat($('#reimburseAmount').val());
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
	//设置申请金额
	var applyAmount = $("#applyAmount").val();
	if(applyAmount !=""){
		$('#applyAmount_span').html(fomatMoney(applyAmount,2)+" [元]");
	}
	var h = $("#reimburseTypeHi").textbox().textbox('getValue');
	if (h != "") {
		$('#reimburseType').textbox().textbox('setValue', h);
		$('#reimburseType').textbox().attr('readonly', true);
	}
	zzAmount();
	$("#input_jkdbh").textbox({
		onChange: function(newValue, oldValue) {
			cx();
		}
	});
});

function selectCxjk(){
	var cxjk = $('input[name="withLoan"]:checked').val();
	if(cxjk==1){
		$('#jk').show();
	} else {
		$('#jk').hide();
		$('#input_jkdamonut').val(0);
		cx();
	}
}


//保存
function saveReimburse(flowStauts) {
	getpayerinfoJson();
	commaccept();
	commjson();
	var jsonStr1 = $("#form1").serializeJson();
	// 在后台反序列话成明细Json的对象集合
	$('#json1').val(jsonStr1);
	$('#input_userName2').val($('#userName2').textbox('getValue'));//下级审批人名称
	
	$('#input_reimburseReason').val($('#commreason').textbox('getValue'));//报销说明
	$('#indexName').val($('#F_fBudgetIndexName').textbox('getValue'));//预算指标名称
	var arry = new Array();
	var str ="";
	var j=${index};
	for(var i=0; i<=j-1; i++){
		str=$("#form_"+i).serializeJson();
		arry.push(str);
	}
	var arryjosn=JSON.stringify(arry);
	$("#arry").val(arryjosn);
	var nums=parseFloat($('#reimburseAmount').val());
	var num3=parseFloat($('#applyAmount').val());
	var applyAmount1 = (nums-num3).toFixed(2);
	//设置审批状态
	$('#reimburseFlowStauts').val(flowStauts);
	//设置报销状态
	$('#reimburseStauts').val(flowStauts);
	if(parseFloat(nums)>parseFloat(num3)&&flowStauts==1){
		/* var rows = $('#rmxdg').datagrid('getRows');
		for (var i = 0; i < rows.length; i++) {
			if(rows[i].standard!="据实列支"&&rows[i].standard!=null){
				if(parseFloat(rows[i].reimbSum)>parseFloat(rows[i].standard)){
					alert("报销金额不能超过支出标准！")
					return;
				}
			}
		} */
			var win=creatFirstWin(' ',360,280,'icon-search','/reimburse/overfulfil?standard='+num3+"&amount="+nums+"&applyAmount="+applyAmount1+"&sts="+flowStauts);
			win.window('open');
		}else{
	// 在后台反序列话成明细Json的对象集合
	 
	
	/* // 在后台反序列话成发票Json的对象集合
	accept2();
	var rows2 = $('#drfpdg').datagrid('getRows');
	var fapiao = "";
	for (var i = 0; i < rows2.length; i++) {
		fapiao = fapiao + JSON.stringify(rows2[i]) + ",";
	}
	$('#rfpJson').val(fapiao); */
	
	
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);


	var h = $("#reimburseTypeHi").textbox().textbox('getValue');
	
	//提交
	$('#reimburse_save_form').form('submit', {
		onSubmit : function() {
			flag = $(this).form('enableValidation').form('validate');
			if (flag) {
				//如果校验通过，则进行下一步
				$.messager.progress();
			}else{
				//校验不通过，就打开第一个校验失败的手风琴
				openAccordion();
			}
			return flag;
		},
		url : base + '/reimburse/save',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				$('#reimburse_save_form').form('clear');
				$('#reimburseTab'+h).datagrid('reload');
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
//打开借款单选择页面
function chooseJkd(){
	var win = creatFirstWin('借款单选择', 840, 550, 'icon-search', '/loan/choose?menuType=fromBxsq');
	win.window('open');
	cx();
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
function chooseUserid(){
	var win=creatSecondWin('选择归口部门',860,580,'icon-search','/user/chooseNextRole'); 
	win.window('open');
}
</script>
</body>

