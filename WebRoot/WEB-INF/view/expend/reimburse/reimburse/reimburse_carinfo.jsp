<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
				<!-- 基本信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
					<table class="window-table" style="margin-top: 3px;width: 695px" cellspacing="0" cellpadding="0">
						<tr class="trbody">
							<td style="width: 70px;"><span class="style1">*</span> 单据编号</td>
							<td colspan="3" class="td2">
								<input style="width: 635px; height: 30px;margin-left: 10px" readonly="readonly" name="rCode" class="easyui-textbox"
								value="${applyBean.gCode}" data-options="prompt: '事前申请选择' ,icons: [{iconCls:'icon-sousuo'}],required:true" readonly="readonly"/>
							</td>
						</tr>
						<tr class="trbody">
							<td  style="width: 70px;"><span class="style1">*</span> 摘要</td>
							<td colspan="3" class="td2" >
								<input style="width: 635px; height: 30px;margin-left: 10px" id="gNames" class="easyui-textbox"
								value="${bean.gName}" />
							</td>
						</tr>
						 
						<tr class="trbody" style="line-height: 60px;">
							<td style="width: 70px;">报销说明</td>
							<td colspan="3" class="td2">
								<input style="width:635px;height:60px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7;" id="reimburseReasons"  name="reimburseReasons" <c:if test="${operation=='add' }"> value="${applyBean.reason}""</c:if><c:if test="${operation=='edit' }"> value="${bean.reimburseReason}"</c:if> class="easyui-textbox"
								 data-options="validType:'length[1,50]',multiline:true"/>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 付款方式</td>
							<td class="td2">
								<input class="easyui-combobox" name="paymentType" value="${bean.paymentType}" required="required" style="width: 269px; height: 30px;" data-options="editable:false,url:base+'/lookup/lookupsJson?parentCode=FKFS&selected=${bean.paymentType}',method:'POST',valueField:'code',textField:'text'"/>
							</td>
							<td class="td1" style="width: 70px;"></td>
							<td class="td2">
							</td>
						</tr>	
						<tr class="trbody" style="line-height: 36px;">
							<td style="width: 70px;">经办人</td>
							<td class="td2" >
							<input class="easyui-textbox" id="userNames" name="userNames" readonly="readonly" value="${applyBean.userNames}" style="width: 269px;height: 30px;margin-left: 10px " >
							</td>
							<td style="width: 70px;text-align: right;padding-right: 5px">部门名称</td>
							<td class="td2" >
							<input class="easyui-textbox" id="deptName" name="deptName" readonly="readonly" value="${applyBean.deptName}" style="width: 269px;height: 30px;margin-left: 10px " >
							</td>
						</tr>
						</table>
					</div>				
				</div>
				
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px; ">
					<div title="行程调整" data-options="collapsed:false,collapsible:false"style="overflow:auto;width: 717px">
						<table class="window-table" style="margin-top: 3px;" cellspacing="0" cellpadding="0">
							<tr class="trbody">
								<td class="td1" style="width: 80px;">是否调整</td>
								<td class="td2" colspan="4" >
									<input type="radio" value="1" onclick="radioyes()" name="fupdateStatus" id="box1" <c:if test="${bean.fupdateStatus=='1'}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;是
									&nbsp;&nbsp;
									<input type="radio" value="0" onclick="radiono()" name="fupdateStatus" id="box2" <c:if test="${bean.fupdateStatus=='0' || empty bean.fupdateStatus}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;否
								</td>
								<!-- <td class="td4" style="width: 67px;"></td> -->
							</tr>
							<tr id="radiofupdate" hidden="hidden" class="trbody">
								<td class="td1" style="width: 80px;"><span class="style1">*</span>调整说明</td>
								<td colspan="3" class="td2" >
									<textarea name="fupdateReasons"  id="fupdateReasons" onchange="reasonOnChange()" class="textbox-text"
											oninput="textareaNum(this,'textareaNum1')" autocomplete="off"
											style="width:595px;height:70px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:8px; margin-bottom:0px;">${bean.fupdateReason }</textarea>
								</td>
							</tr>
						</table>
					</div>				
				</div>
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
					<div title="费用明细" data-options="collapsible:false"
						style="overflow:auto;width: 717px">	
						<div style="overflow:hidden;margin-top: 0px">
							<!-- 费用明细 -->
							<jsp:include page="mingxi_car.jsp" />
						</div>
						<c:if test="${operation=='add'}">		
							<div style="overflow:hidden;margin-top: 0px">
								<!-- 公车运维发票明细 -->
								<jsp:include page="mingxi_car_invoice.jsp" />
							</div>
						</c:if>
						<c:if test="${operation=='edit'}">		
							<div style="overflow:hidden;margin-top: 0px">
								<!-- 公车运维发票明细 -->
								<jsp:include page="mingxi_car_invoice_edit.jsp" />
							</div>
						</c:if>
					</div>
				</div>
				
				<!-- 预算信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 50px">
				<div title="预算信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;margin-left: 0px;">				
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;;margin-bottom: 0px;width: 695px;">					
						<tr class="trbody">
							<td style="width: 60px;text-align: right;"><span style="text-align: left;color: red">*</span> 支出项目</td>
							<td colspan="3" style="padding-right: 5px;">
								<input class="easyui-textbox" style="width: 630px;height: 30px;"
								 value="${bean.indexName}" id="F_fBudgetIndexName"
								 readonly="readonly" required="required"/>
							</td>
						</tr>
					</table>	
					<table class="window-table-readonly-zc" cellspacing="0" cellpadding="0" style="margin-left:0px;;margin-bottom: 0px;width: 695px;height: 50px;">
							<tr>
								<td class="window-table-td1"><p style=" color:#0000CD;">申请金额:</p></td>
								<td class="window-table-td2"><p id="applyAmount_span">${applyBean.amount}[元]</p></td>
								<td class="window-table-td1"><p style="color: red;" >报销金额:</p></td>
								<c:if test="${operation=='edit'}">	
								<td class="window-table-td2"><p id="p_amount"><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</p></td>
								</c:if>
								<c:if test="${operation=='add'}">	
								<td class="window-table-td2"><p id="p_amount"><fmt:formatNumber groupingUsed="true" value="${applyBean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</p></td>
								</c:if>
							</tr>
							<tr>
								<td class="window-table-td1"><p>归还预算:</p></td>
								<td class="window-table-td2"><p id="ghAmount">[元]</p></td>
							</tr>
							<tr >
							<td class="window-table-td1"><p>是否冲销借款:</p></td>
							<td class="window-table-td2">
								<input id="hotelstd_add_sfwj" name="withLoans" value="1"
									type="radio" onclick="selectCxjk(this)" <c:if test="${bean.withLoan==1 }">checked="checked"</c:if>/>是
								<input id="hotelstd_add_sfwj" name="withLoans" value="0"
									type="radio" onclick="selectCxjk(this)" <c:if test="${bean.withLoan!=1 || empty bean.withLoan}">checked="checked"</c:if>/>否
							</td>	
								 
						</tr>
						
						<tbody id="jk">
							<tr>
							<td class="window-table-td1"><p>借款单号:</p></td>
							<td class="window-table-td2">
								<a href="#" onclick="chooseJkd()">
									<input class="easyui-textbox" id="input_jkdbh" style="width: 250px;height: 30px;" data-options="prompt: '借款单选择' ,icons: [{iconCls:'icon-sousuo'}]"
									value="${bean.loan.lCode}" readonly="readonly" >
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
				
				
				<!-- 收款人信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="收款人信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;padding:0px;">
					<input hidden="hidden" value="${payee.pId}" name="pId"/>
					<div id="" style="overflow-x:hidden;margin-top: 0px;">
						<jsp:include page="payee-info.jsp" />	
					</div>
				</div>
				</div>
				
				<!-- 附件信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
				<div title="附件信息" data-options="collapsed:false,collapsible:false"
					style="overflow:auto;">		
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
						<tr>
							<td style="width:75px;text-align: left"> 附件
								<input type="file" multiple="multiple" id="f" onchange="upladFile(this,'bxsq','zcgl01')" hidden="hidden">
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
								<c:forEach items="${attaList1}" var="att">
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
<script type="text/javascript">
//冲销借款
function cx(){
	
	var num1=parseFloat($('#input_jkdamonut').val());//借款单金额
	var num2=parseFloat($('#reimburseAmount').val());//报销金额
	var num3=parseFloat($('#applyAmount').val());//申请金额
	if(isNaN(num1)&&!isNaN(num2)){
		 $('#skAmount').val(num2);
	}
	if(!isNaN(num1)&&!isNaN(num2)){
		if(num2<num1){
			var num4=num1-num2;
			 $('#cxAmount').html(fomatMoney(num2,2)+" [元]");
			 $('#cxAmounts').val(num2.toFixed(2));
			 $('#syAmount').html(fomatMoney(num4,2)+" [元]");
			 $('#skAmount').val(0);
		}else{
			$('#cxAmount').html(fomatMoney(num1,2)+" [元]");
			$('#cxAmounts').val(num1.toFixed(2));
			$('#syAmount').html(fomatMoney(0,2)+" [元]");
			$('#skAmount').val((num2-num1).toFixed(2));
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
	var cxjk = $('input[name="withLoans"]:checked').val();
	var num2=parseFloat($('#reimburseAmount').val());
	var num3=parseFloat($('#applyAmount').val());
	if(cxjk==1){
	var num1=parseFloat(${bean.loan.leastAmount});
	if(!isNaN(num1)&&!isNaN(num2)){
		if(num2<num1){
			var num4=num1-num2;
			 $('#cxAmount').html(fomatMoney(num2,2)+" [元]");
			 $('#cxAmounts').val(num2.toFixed(2));
			 $('#syAmount').html(fomatMoney(num4,2)+" [元]");
		}else{
			$('#cxAmount').html(fomatMoney(num1,2)+" [元]");
			$('#cxAmounts').val(num1.toFixed(2));
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
	var cxjk = $('input[name="withLoans"]:checked').val();
	if(cxjk==1){
		$('#jk').show();
	} else {
		$('#jk').hide();
		$('#input_jkdamonut').val(0);
	}
	cx();
	var sts = $('input[name="fupdateStatus"]:checked').val();
	if(sts==1){
		$('#radiofupdate').show();
	} else {
		$('#radiofupdate').hide();
	}
	
	//设置申请金额
	var applyAmount = $("#applyAmount").val();
	if(applyAmount !=""){
		$('#applyAmount_span').html(fomatMoney(applyAmount,2)+" [元]");
	}
	//
	var h = $("#reimburseTypeHi").textbox().textbox('getValue');
	if (h != "") {
		$('#reimburseType').textbox().textbox('setValue', h);
		$('#reimburseType').textbox().attr('readonly', true);
	}
	//zzAmount();
	/* $("#input_jkdbh").textbox({
		onChange: function(newValue, oldValue) {
			
			cx();
		}
	}); */
});

function selectCxjk(){
	var cxjk = $('input[name="withLoans"]:checked').val();
	if(cxjk==1){
		$('#jk').show();
		$('#withLoan').val(1);
	} else {
		$('#input_jkdamonut').val(0);
		$('#input_jkdbh').textbox('setValue','');
		$('#withLoan').val(0);
		$('#jk').hide();
		cx();
	}
}

//保存
function saveReimburse(flowStauts) {
	//附件的路径地址
	
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);
	var arry = new Array();
	var str ="";
		str=$("#form1").serializeJson();
		arry.push(str);
	var arryjosn=JSON.stringify(arry);
	$("#arry").val(arryjosn);
	var nums=parseFloat($('#reimburseAmount').val());//报销金额
	var num3=parseFloat($('#applyAmount').val());//申请金额
	var payeeAmount=parseFloat($('#payeeAmount').val());//转账金额
	var skAmount=parseFloat($('#skAmount').val());//报销金额-冲销金额
	var applyAmount1 = (nums-num3).toFixed(2);
	if(isNaN(payeeAmount) || payeeAmount=='' || payeeAmount==undefined){
		payeeAmount =0;
	}
	if(isNaN(skAmount) || skAmount=='' || skAmount==undefined){
		skAmount =0;
	}
	$("#gName").val($("#gNames").textbox('getValue'));
	//下面几行是判断是否有调整
	var sts = $('input[name="fupdateStatus"]:checked').val();
	if(sts==1){//如果有调整的
		$('#fupdateStatusid').val(1);
	}else if(sts==0){//如果没有调整的
		$('#fupdateStatusid').val(0);
	}
	
	//下面几行判断是否有冲销借款
	var cxjk = $('input[name="withLoans"]:checked').val();
	if(cxjk==1){//如果有冲销借款的
		var lCode = $("#input_jkdbh").textbox('getValue');
		if(lCode==''){
			alert('请选择借款单！');
			return false;
		}else if(skAmount!=payeeAmount){
			var num1=parseFloat($('#input_jkdamonut').val());//借款单金额
			var info = '报销金额：'+nums+'\n冲销金额：'+num1+'\n转账总金额：'+payeeAmount+'\n冲销后的报销金额和转账金额不一致,请核对后在提交！';
			alert(info);
			return false;
		}
	}else if(cxjk==0){
		//没有冲销借款的
		if(nums!=payeeAmount){
			var info = '报销金额：'+nums+'\n转账总金额：'+payeeAmount+'\n报销金额和转账金额不一致,请核对后在提交！';
			alert(info);
			return false;
		}
	}
	
	//设置审批状态
	$('#reimburseFlowStauts').val(flowStauts);
	//设置报销状态
	//获取费用明细json
	reimburseCartJson();
	//获取收款人json
	getpayerinfoJson();
	$('#reimburseStauts').val(flowStauts);
	if(parseFloat(nums)>parseFloat(num3)&&flowStauts==1){
			var win=creatFirstWin(' ',360,280,'icon-search','/reimburse/overfulfil?standard='+num3+"&amount="+nums+"&applyAmount="+applyAmount1+"&sts="+flowStauts);
			win.window('open');
		}else{
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
	var win = creatFirstWin('借款单选择', 840, 450, 'icon-search', '/loan/choose?menuType=fromBxsq');
	win.window('open');
	cx();
}
//转账金额
/* function  zzAmount(){
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
	$("#skAmount").numberbox().numberbox('setValue',num1+num2);
} */

var updateradio = 0;
function radiono(){
	updateradio=1;
	$('#radiofupdate').hide();
	$('#fupdateStatusid').val(0);
}
function radioyes(){
	updateradio=0;
	$('#radiofupdate').show();
	$('#fupdateStatusid').val(1);
}

function reasonOnChange(){
	
	$("#fupdateReason").val($("#fupdateReasons").val());
}

$("#reimburseReasons").textbox({
	onChange:function(newVal,oldVal){
		
		$("#reimburseReason").val(newVal);
	}
});
</script>
