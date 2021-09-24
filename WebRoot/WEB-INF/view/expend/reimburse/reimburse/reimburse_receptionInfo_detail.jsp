<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
			<form id="reimburse_save_form" method="post"  enctype="multipart/form-data">
				<!-- 隐藏域 --> 
				<!-- 主键ID --><input type="hidden" name="rId" value="${bean.rId}" id="rId"/>
				<!-- 主键ID --><input type="hidden" name="jId" <c:if test="${operation=='edit' }"> value="${receptionBeanEdit.jId}"</c:if> id="jId"/>
				<!-- 报销单号 --><input type="hidden" name="rCode" <c:if test="${operation=='add' }">value="${applyBean.gCode}"</c:if><c:if test="${operation=='edit' }"> value="${bean.rCode}"</c:if>/>
				<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="reimburseFlowStauts" />
				<!-- 报销状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="reimburseStauts" />
				<%-- <!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}" />
				<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" /> --%>
				<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
				<!-- 报销类型 --><input type="hidden" id="reimburseTypeHi" value="${bean.type}" name="type"/>
				<!-- 报销金额 --><input type="hidden" id="reimburseAmount" name="amount" <c:if test="${operation=='edit'||operation=='detail'}">value="${bean.amount}"</c:if><c:if test="${operation=='add'}">value="${applyBean.amount}"</c:if> />
				<!-- 指标ID --><input type="hidden" name="indexId" value="${applyBean.indexId}" id=""/>
				<!-- 预算指标名称 --><input type="hidden" id="indexName" name="indexName" value="${bean.indexName}" />
				<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="indexType"/>
				<div id="panelID" class="easyui-panel" data-options="closed:true">
				<!-- 项目支出明细ID --><input type="hidden" name="proDetailId" <c:if test="${operation=='add' }"> value="${applyBean.proDetailId}"</c:if><c:if test="${operation=='edit' }"> value="${bean.proDetailId}"</c:if> id="proDetailId"/>
				<!-- 费用明细json和费用金额 -->
				<input type="hidden" id="receptionHotelJson" name="hotelJson" />
				<input type="hidden" id="receptionFoodJson" name="foodJson" />
				<input type="hidden" id="receptionOtherJson" name="otherJson" />
				<input type="hidden" id="costTraffic" name="costTraffic"  value="${receptionBeanEdit.costTraffic}"/>
				<input type="hidden" id="costRent" name="costRent"  value="${receptionBeanEdit.costRent}"/>
				<input type="hidden" id="costHotel" name="costHotel" value="${receptionBeanEdit.costHotel}"  />
				<input type="hidden" id="costFood" name="costFood" value="${receptionBeanEdit.costFood}"  />
				<input type="hidden" id="costOther" name="costOther" value="${receptionBeanEdit.costOther}"  />
				<input type="hidden" id="applyAmount" name="applyAmount" value="${applyBean.amount}" />
				<!-- 发票明细json -->
				<input type="hidden" id="json1" name="form1"/>
				<input type="hidden" id="json2" name="form2"/>
				<input type="hidden" id="json3" name="form3"/>
				<input type="hidden" id="json4" name="form4"/>
				<input type="hidden" id="json5" name="form5"/>
				<!-- 收款人json -->
				<input type="hidden" id="payerinfoJson" name="payerinfoJson"/>
				</div>
			
			<!-- 预算信息 -->
<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
<div title="预算信息" data-options="collapsed:false,collapsible:false"style="overflow:auto;margin-left: 0px;">				
	<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;margin-left: 0px;;margin-bottom: 0px;width: 695px;">					
		<tr class="trbody">
			<td style="width: 60px;"><span class="style1">*</span> 支出项目</td>
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
			<td class="window-table-td2"><p id="p_amount"><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</p></td>
		</tr>
		<tr>
			<td class="window-table-td1"><p>归还预算:</p></td>
			<td class="window-table-td2"><p id="ghAmount">[元]</p></td>
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
				<!-- 基本信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="基本信息" data-options="collapsible:false" style="overflow:auto;width: 707px">
					<table class="window-table" style="margin-top: 10px;width: 695px" cellspacing="0" cellpadding="0">
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 单据编号</td>
							<td colspan="4">
								<input style="width: 587px;height: 30px;" name="gCode" class="easyui-textbox" value="${bean.gCode}"
								 data-options="prompt: '事前申请选择' ,icons: [{iconCls:'icon-sousuo'}],required:true" readonly="readonly"/>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 事项摘要</td>
							<td colspan="4">
								<input style="width: 587px; height: 30px;" name="gName" class="easyui-textbox"
								value="${bean.gName}" readonly="readonly"/>
							</td>
						</tr>
							<!-- 公务接待信息 -->
							<jsp:include page="reception_detail_reim.jsp" />
						</table>
					</div>				
				</div>
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
					<div title="公务接待调整" data-options="collapsed:false,collapsible:false"style="overflow:auto;width: 717px">
						<table class="window-table" style="margin-top: 3px;" cellspacing="0" cellpadding="0">
							<tr class="trbody">
								<td class="td1"style="width: 80px;"><span class="style1">*</span>是否存在调整</td>
								<td class="td2" colspan="3" >
									<input type="radio" value="1" onclick="radioyes()" disabled="disabled" name="fupdateStatus" id="box3" <c:if test="${bean.fupdateStatus=='1'}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;是
									&nbsp;&nbsp;
									<input type="radio" value="0" onclick="radiono()" disabled="disabled" readonly="readonly" name="fupdateStatus" id="box4" <c:if test="${bean.fupdateStatus=='0'}">checked="checked" </c:if> style="vertical-align: middle;"/>&nbsp;&nbsp;否
								</td>
								<!-- <td class="td4" style="width: 67px;"></td> -->
							</tr>
							<tr id="radiofupdate" hidden="hidden" class="trbody">
								<td class="td1"  style="width: 80px;"><span class="style1">*</span>调整说明</td>
								<td colspan="3" class="td2" >
									<textarea name="fupdateReason"  id="fupdateReason" class="textbox-text" readonly="readonly"
											oninput="textareaNum(this,'textareaNum1')" autocomplete="off"
											style="width:595px;height:70px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:8px; margin-bottom:0px;">${bean.fupdateReason }</textarea>
								</td>
							</tr>
						</table>
					</div>				
				</div>
			</form>		
				<!-- 接待人员名单 -->
				<%-- <div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="接待人员名单" data-options="collapsible:false"
						style="overflow:auto;width: 717px">
						<div style="overflow:hidden;margin-top: 0px">
						<jsp:include page="reception_people_reimb_detail.jsp" />
						</div>
					</div>
				</div> --%>
				<!-- 参考观察者安排 -->
				<%-- <div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="参考观察安排" data-options="collapsible:false"
						style="overflow:auto;">
						<div style="overflow:auto;margin-top: 0px">
						<jsp:include page="observe_plan_reimb_detail.jsp" />
						</div>
					</div>
				</div> --%>
				<%-- <div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="其他安排" data-options="collapsible:false"
						style="overflow:auto;">
						<div style="overflow:auto;margin-top: 0px">
						<tr style="height: 70px;">
							<td colspan="3">
								<textarea id="otherText"   class="textbox-text" readonly="readonly"  autocomplete="off" 
								  style="width:688px;height:80px;resize:none; border-radius: 5px;border: 1px solid #D9E3E7; margin-top:5px; margin-bottom:0px;">${receptionBeanEdit.otherContet}</textarea>
							</td>
						</tr>
						</div>
					</div>
				</div> --%>
				<!-- 陪同人员名单 -->
				<%-- <div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;">
					<div title="陪同人员名单" data-options="collapsible:false"
						style="overflow:auto;">
						<div style="overflow:auto;margin-top: 0px">
						<jsp:include page="accompany_people_reimb_detail.jsp" />
						</div>
					</div>
				</div> --%>
				<%--  <div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
					<div title="费用明细" data-options="collapsible:false" style="overflow:auto;width: 717px">	
						<div style="overflow:hidden;margin-top: 0px">
							<!-- 费用明细 -->
							<jsp:include page="mingxi_reception_detail_reim.jsp" />
						</div>
						<div style="overflow:auto;margin-top: 10px;">
								<span style="float: left;">
									<span style="color: red;">报销金额总计： </span>
									<span style="float: right;"  id="reimAmount_span" ><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span>
								</span>
							</div>
					</div>
				</div>  --%>
				<div style="overflow:hidden;margin-top: 0px">
				<!-- 餐费发票明细 -->
				<jsp:include page="mingxi_reception_food_detail.jsp" />
				</div>
				<!-- 收款人信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="收款人信息" data-options="collapsible:false" style="overflow:auto;width: 717px">
					<div id="" style="overflow-x:hidden;">
						<jsp:include page="payee-info_detail.jsp" />	
					</div>
					<input hidden="hidden" id="num2" name="payeeAmount" value="${payee.payeeAmount}" readonly="readonly" precision="2"/>
				</div>
				</div>
				
				<!-- 附件信息 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="附件信息" data-options="collapsible:false" style="overflow:auto;">		
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
						<tr class="trbody">
								<td style="width:55px;text-align: left">附件</td>
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
	$('#removeit2Id').hide();
	$('#append2Id').hide();
	$('#fupdateStatusid').val(0);
}
function radioyes(){
	updateradio=0;
	$('#skAccount').numberbox('setValue',num2);
	$('#receptionObject').textbox('readonly',false);
	$('#receptionLevel').combobox('readonly',false);
	$('#rePeopNum').numberbox('readonly',false);
	$('#reDateStart').datebox('readonly',false);
	$('#reDateEnd').datebox('readonly',false);
	$('#diningPlace').textbox('readonly',false);
	$('#fFeteTime').datebox('readonly',false);
	$('#unitFeteSite').textbox('readonly',false);
	$('#unitFeteNum').numberbox('readonly',false);
	$('#attendPeopNum').numberbox('readonly',false);
	$('#box1').removeAttr("disabled");//去除input元素的disabled属性
	$('#box2').removeAttr("disabled");//去除input元素的disabled属性
	$('#receptionContent').removeAttr("disabled");//去除input元素的disabled属性
	$('#removeit2Id').show();
	$('#append2Id').show();
	$('#radiofupdate').show();
	$('#fupdateStatusid').val(1);
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
	//设置申请金额
	var applyAmount = $("#applyAmount").val();
	if(applyAmount !=""){
		$('#applyAmount_span').html(fomatMoney(applyAmount,2)+" [元]");
	}
	var sts = $('input[name="fupdateStatus"]:checked').val();
	if(sts==1){
		updateradio=0;
		$('#radiofupdate').show();
		$('#removeit2Id').show();
		$('#append2Id').show();
	} else {
		$('#radiofupdate').hide();
		$('#removeit2Id').hide();
		$('#append2Id').hide();
		updateradio=1;
	}
	var diningPlacePlan1 = '${receptionBeanEdit.diningPlacePlan1}';
	if(diningPlacePlan1=='1'){
		$('#tr1').show();
	}
	var diningPlacePlan2 = '${receptionBeanEdit.diningPlacePlan2}';
	if(diningPlacePlan2=='1'){
		$('#tr0').show();
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
	$('#indexName').val($('#F_fBudgetIndexName').textbox('getValue'));//预算指标名称
	$('#fupdateReasonid').val($('#fupdateReason').val());//接待调整说明
	
	var plan1 = $("#diningPlacePlan1").val();
	var plan2 = $("#diningPlacePlan2").val();
	if(plan1=='1'){
		var yanqing = requiredValidatebox();
		if(yanqing==false){
			alert('宴请信息不完整,请填写完整！');
			return false;
		}
	}
	if(plan2=='1'){
		var diningPlace = $("#diningPlace").textbox('getValue');
		if(diningPlace==''){
			alert('工作餐就餐地点未填写,请填写完整！');
			return false;
		}
	}
	
	var jsonStr1 = $("#form2").serializeJson();
	var jsonStr2 = $("#formFood").serializeJson();
	var jsonStr3 = $("#form1").serializeJson();
	var jsonStr4 = $("#formCostRent").serializeJson();
	var jsonStr5 = $("#formOther").serializeJson();
	// 在后台反序列话成明细Json的对象集合
		$('#json1').val(jsonStr1);
		$('#json2').val(jsonStr2);
		$('#json3').val(jsonStr3);
		$('#json4').val(jsonStr4);
		$('#json5').val(jsonStr5);
		//附件的路径地址
		var s="";
		$(".fileUrl").each(function(){
			s=s+$(this).attr("id")+",";
		});
		$("#files").val(s);
		/* 以下是住宿费、餐费、其他费用的json */
		receptionHotelJson();
		receptionFoodJson();
		receptionOtherJson();
		//收款人json
		getpayerinfoJson();
	var nums=parseFloat($('#reimburseAmount').val());
	var num3=parseFloat($('#applyAmount').val());
	var applyAmount1 = (nums-num3).toFixed(2);
	//设置审批状态
	$('#reimburseFlowStauts').val(flowStauts);
	var h = $('#reimburseTypeHi').val();
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
		//提交
		$('#reimburse_save_form').form('submit', {
			onSubmit : function() {
				/* flag = $(this).form('enableValidation').form('validate');
				if (flag) { */
					$.messager.progress();
					//如果校验通过，则进行下一步
				/* }else{
					//校验不通过，就打开第一个校验失败的手风琴
					openAccordion();
				}
				return flag; */
			},
			url : base + '/reimburse/save',
			success : function(data) {
				/* if (flag) { */
					$.messager.progress('close');
				/* } */
				data = eval("(" + data + ")");
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					closeWindow();
					$('#reimburse_save_form').form('clear');
					$('#reimburseTab'+h).datagrid('reload');
					$('#indexdb').datagrid('reload');
					
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
</script>