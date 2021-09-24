<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
				<!-- 基本信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
					<table class="window-table" style="margin-top: 3px;width: 695px" cellspacing="0" cellpadding="0">
						<tr class="trbody">
							<td style="width: 70px;"><span class="style1">*</span> 单据编号</td>
							<td colspan="3" class="td2">
								<input style="width: 635px; height: 30px;margin-left: 10px" readonly="readonly" name="gCode" class="easyui-textbox"
								value="${applyBean.gCode}" data-options="prompt: '事前申请选择' ,icons: [{iconCls:'icon-sousuo'}],required:true" readonly="readonly"/>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 摘要</td>
							<td colspan="3" class="td2" >
								<input style="width: 635px; height: 30px;margin-left: 10px" name="gName" class="easyui-textbox" value="${bean.gName}" readonly="readonly"/>
							</td>
						</tr>
						 
						<tr class="trbody" style="line-height: 62px">
							<td style="width: 70px;"><span class="style1">*</span>报销说明</td>
							<td colspan="3" class="td2">
								<input style="width:634px;height:60px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:7px; margin-bottom:0px;" name="reimburseReason" value="${bean.reimburseReason}" class="easyui-textbox" readonly="readonly"
								 data-options="validType:'length[1,50]'"/>
						</tr>
						<tr class="trbody">
							<td class="td1" style="width: 70px;"><span class="style1">*</span> 付款方式</td>
							<td class="td2">
								<input class="easyui-combobox" readonly="readonly" value="${bean.paymentType}" style="width: 269px; height: 30px;" data-options="editable:false,url:base+'/lookup/lookupsJson?parentCode=FKFS&selected=${bean.paymentType}',method:'POST',valueField:'code',textField:'text'"/>
							</td>
							<td class="td1" style="width: 70px;"></td>
							<td class="td2">
							</td>
						</tr>							
						<tr class="trbody" style="line-height: 36px">
							<td class="td1" style="width: 70px;">经办人</td>
							<td class="td2" >
							<input class="easyui-textbox" id="userNames" name="userNames" readonly="readonly" value="${applyBean.userNames}" style="width: 265px;height: 30px;margin-left: 10px " >
							</td>
							<td class="td1" style="width: 70px;text-align: right;padding-right: 5px">部门名称</td>
							<td class="td2" >
							<input class="easyui-textbox" id="deptName" name="deptName" readonly="readonly" value="${applyBean.deptName}" style="width: 267px;height: 30px;margin-left: 10px " >
							</td>
						</tr>
						</table>
					</div>				
				</div>
				
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px; ">
					<div title="行程调整" data-options="collapsed:false,collapsible:false"style="overflow:auto;width: 717px">
						<table class="window-table" style="margin-top: 3px;" cellspacing="0" cellpadding="0">
							<tr class="trbody">
								<td class="td1" style="width: 80px;"><span class="style1">*</span>行程是否调整</td>
								<td class="td2" colspan="4" >
									<input type="radio" value="1" disabled="disabled" onclick="radioyes()" name="fupdateStatus" id="box1" <c:if test="${bean.fupdateStatus=='1'}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;是
									&nbsp;&nbsp;
									<input type="radio" value="0" disabled="disabled" onclick="radiono()" name="fupdateStatus" id="box2" <c:if test="${bean.fupdateStatus=='0' || empty bean.fupdateStatus}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;否
								</td>
								<!-- <td class="td4" style="width: 67px;"></td> -->
							</tr>
							<tr id="radiofupdate" hidden="hidden" class="trbody">
								<td class="td1" style="width: 80px;"><span class="style1">*</span>行程调整说明</td>
								<td colspan="3" class="td2" >
									<textarea name="fupdateReason"  readonly="readonly" id="fupdateReason" class="textbox-text"
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
							<jsp:include page="mingxi_car_detail.jsp" />
						</div>
							<div style="overflow:hidden;margin-top: 0px">
								<!-- 公车运维发票明细 -->
								<jsp:include page="mingxi_car_invoice_detail.jsp" />
							</div>
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
								<td class="window-table-td2"><p id="p_amount">${bean.amount}[元]</p></td>
							</tr>
							<tr>
								<td class="window-table-td1"><p>归还预算:</p></td>
								<td class="window-table-td2"><p id="ghAmount">[元]</p></td>
							</tr>
							<tr >
							<td class="window-table-td1"><p>是否冲销借款:</p></td>
							<td class="window-table-td2">
								<input id="hotelstd_add_sfwj" name="withLoan" value="1"
									type="radio" disabled="disabled" onclick="selectCxjk(this)" <c:if test="${bean.withLoan==1 }">checked="checked"</c:if>/>是
								<input id="hotelstd_add_sfwj" name="withLoan" value="0"
									type="radio" disabled="disabled" onclick="selectCxjk(this)" <c:if test="${bean.withLoan!=1}">checked="checked"</c:if>/>否
							</td>	
								 
						</tr>
						
						<tbody id="jk">
							<tr>
							<td class="window-table-td1"><p>借款单号:</p></td>
							<td class="window-table-td2">
								<a href="#">
									<input class="easyui-textbox" id="input_jkdbhs" style="width: 250px;height: 30px;" data-options="prompt: '借款单选择' ,icons: [{iconCls:'icon-sousuo'}]"
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
				
				
				<!-- 收款人信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="收款人信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;padding:0px;">
					<input hidden="hidden" value="${payee.pId}" name="pId"/>
					<div id="" style="overflow-x:hidden;margin-top: 0px;">
						<jsp:include page="payee-info_detail.jsp" />	
					</div>
				</div>
				</div>
				
				<!-- 附件信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="附件信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">		
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
	zzAmount();
	if (h == 1) {
		$('#spbxhyxx').remove();
		$('#spbxpxxx').remove();
		$('#spbxclxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwyc').remove();
		$('#spbxgwcg').remove();
		/* $("#easyAcc").accordion().accordion('remove', '会议信息');
		$("#easyAcc").accordion().accordion('remove', '培训信息');
		$("#easyAcc").accordion().accordion('remove', '差旅信息');
		$("#easyAcc").accordion().accordion('remove', '接待信息');
		$("#easyAcc").accordion().accordion('remove', '接待人员名单');
		$("#easyAcc").accordion().accordion('remove', '公务用车信息');
		$("#easyAcc").accordion().accordion('remove', '公务出国信息'); */
	}
	if (h == 2) {//会议
		$('#spbxpxxx').remove();
		$('#spbxclxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwyc').remove();
		$('#spbxgwcg').remove();
	}
	if (h == 3) {//培训
		$('#spbxhyxx').remove();
		$('#spbxclxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwyc').remove();
		$('#spbxgwcg').remove();
	}
	if (h == 4) {//差旅
		$('#spbxhyxx').remove();
		$('#spbxpxxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwyc').remove();
		$('#spbxgwcg').remove();
	}
	if (h == 5) {//接待
		$('#spbxhyxx').remove();
		$('#spbxpxxx').remove();
		$('#spbxclxx').remove();
		$('#spbxgwyc').remove();
		$('#spbxgwcg').remove();
	}
	if (h == 6) {//公务用车
		$('#spbxhyxx').remove();
		$('#spbxpxxx').remove();
		$('#spbxclxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwcg').remove();
	}
	if (h == 7) {//公务出国
		$('#spbxhyxx').remove();
		$('#spbxpxxx').remove();
		$('#spbxclxx').remove();
		$('#spbxjdxx').remove();
		$('#spbxjdrymd').remove();
		$('#spbxgwyc').remove();
	}
	$("#input_jkdbhs").textbox({
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
	var nums=parseFloat($('#reimburseAmount').val());
	var num3=parseFloat($('#applyAmount').val());
	var applyAmount1 = (nums-num3).toFixed(2);
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
</script>
