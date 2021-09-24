<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<body>
<form id="directly_reimburse_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
<div class="window-div">
	<div class="window-left-div" style="width:720px;height: 491px">
		<div class="window-left-top-div">
			<!-- 隐藏域 --> 
			<!-- 主键ID --><input type="hidden" name="drId" value="${bean.drId}" />
			<!-- 报销单编号 --><input type="hidden" name="drCode" value="${bean.drCode}" />
			<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="drFlowStauts" />
			<!-- 申请状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="drStauts" />
			<!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}" />
			<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" />
			<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
			<!-- 指标ID --><input type="hidden" name="indexId" value="${bean.indexId}" id="F_fBudgetIndexCode"/>
			<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="F_indexType"/>
			<!-- 报销人 --><input type="hidden" name="userName" value="${bean.userName}" id="input_userName"/>
			<!-- 报销部门 --><input type="hidden" name=deptName value="${bean.deptName}" id="input_deptName"/>
			<div id="panelID" class="easyui-panel" data-options="closed:true">
			<!-- 报销时间 --><input class="easyui-datetimebox" name="reqTime" value="${bean.reqTime}" id="input_reqTime" />
			<!-- 项目支出明细ID --><input type="hidden" id="F_proDetailId" name="proDetailId" value="${bean.proDetailId }">
			<!-- 报销金额 --><input type="hidden"  id="amount" name="amount" value="${bean.amount}" >
			<!-- 指标剩余金额 --><input type="hidden"  id="syjeamount" name="syjeamount" value="${bean.syAmount}" >
			</div>
		
				<!-- 基本信息 -->
				<div id="zjbxjbxx" style="overflow:auto;">
				
					<div class="window-title">基本信息</div>
					
					<table class="window-table-readonly" cellspacing="0" cellpadding="0">
						<tr>
							<td class="window-table-td1"><p>报销人:</p></td>
							<td class="window-table-td2"><p>${bean.userName}</p></td>
							
							<td class="window-table-td1"><p>报销部门:</p></td>
							<td class="window-table-td2"><p>${bean.deptName}</p></td>
						</tr>
						
						<tr>
							<td class="window-table-td1"><p>报销时间:</p></td>
							<td colspan="3"><p id="p_reqTime">${bean.reqTime}</p></td>
						</tr>
						
					</table>
				
					<table class="window-table" style="margin-top: 10px" cellspacing="0" cellpadding="0">
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 报销摘要</td>
							<td colspan="4">
								<input style="width: 590px; height: 30px;" name="summary" class="easyui-textbox"
								value="${bean.summary}" required="required" data-options="validType:'length[1,50]'"/>
							</td>
						</tr>
					
						<%-- <tr class="trbody">
							<td class="td1"><span class="style1">*</span> 报销类别</td>
							<td class="td2">
							<input style="width: 200px;height: 30px;"
								value="直接报销" readonly="readonly" id="drType"
								name="type" class="easyui-textbox"/>
							</td>
	
							<td class="td1" style="width: 182px;"><span class="style1">*</span> 报销总额</td>
							<td class="td2" style="text-align: right;">
								<input class="easyui-numberbox" id="directlyReimburseAmount" name="amount" style="width: 200px;height: 30px;text-align: right" data-options="precision:2,icons: [{iconCls:'icon-yuan'}],required:true"
								value="${bean.amount}" readonly="readonly">
							</td>

						</tr> --%>

						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 支出项目</td>
							<td colspan="3">
								<a onclick="openIndex()" href="#">
								<input class="easyui-textbox" style="width: 590px;height: 30px;"
								name="indexName" value="${bean.indexName}" id="F_fBudgetIndexName"
								data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo'}]" readonly="readonly" required="required"/>
								</a>
							</td>

						</tr>
						
						</table>

						<table class="window-table-readonly" cellspacing="0" cellpadding="0">
							<tr>
								<td class="window-table-td1"><p>批复金额:</p></td>
								<td class="window-table-td2"><p id="p_pfAmount">${bean.pfAmount}[元]</p></td>
								
								<td class="window-table-td1"><p>批复时间:</p></td>
								<td class="window-table-td2"><p id="p_pfDate">${bean.pfDate}</p></td>
							</tr>
							
							<tr>
								<td class="window-table-td1"><p>使用部门:</p></td>
								<td class="window-table-td2"><p id="p_pfDepartName">${bean.pfDepartName}</p></td>
								
								<td class="window-table-td1"><p>可用余额:</p></td>
								<td class="window-table-td2"><p id="p_syAmount">${bean.syAmount}[元]</p></td>
							</tr>
							
						
						</table>

						<table class="window-table" cellspacing="0" cellpadding="0">
						
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 冲销借款</td>
							<td class="td2">
								<input id="hotelstd_add_sfwj" name="withLoan" value="1"
									type="radio" onclick="selectCxjk(this)" <c:if test="${bean.withLoan==1 }">checked="checked"</c:if>/>是
								<input id="hotelstd_add_sfwj" name="withLoan" value="0"
									type="radio" onclick="selectCxjk(this)" <c:if test="${bean.withLoan!=1 }">checked="checked"</c:if>/>否
							</td>		 
						</tr>
						
						<tr class="trbody cxjk">
							<td class="td1">借款单号</td>
							<td class="td2">
								<a href="#" onclick="chooseJkd()">
									<input class="easyui-textbox" id="input_jkdbh" style="width: 590px;height: 30px;" data-options="prompt: '借款单选择' ,icons: [{iconCls:'icon-sousuo'}]"
									value="${bean.loan.lCode}" readonly="readonly">
									<input id="input_jkdid" type="hidden" name="bean.loan.lId"/>
								</a>
							</td>
						</tr>

						<tr class="trbody">
							<td class="td1">
								&nbsp;&nbsp;附件
								<input type="file" multiple="multiple" id="f" onchange="upladFile(this,null,'zcgl03')" hidden="hidden">
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
									<div style="margin-top: 10px;">
									<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/sccg.png">
									&nbsp;&nbsp;&nbsp;&nbsp;
									<a id="${att.id}" class="fileUrl" href="#" style="color:red" onclick="deleteAttac(this)">删除</a>
									</div>
								</c:forEach>
							</td>
						</tr>
						
						<tr style="height:5px;"></tr>

						<tr style="margin-top: 10px;">
							<td class="td1" valign="top"><p style="margin-top: 8px"><span class="style1">*</span> 申请事由</p></td>
							<td class="td2" colspan="4">
								<%-- <input class="easyui-textbox"data-options="multiline:true,required:false,validType:'length[0,250]'" name="reason" style="width:590px;height:70px;" value="${bean.reason}"> --%>
								<textarea name="reason"  id="reason"   oninput="textareaNum(this,'textareaNum1')" autocomplete="off"   style="width:590px;height:70px;resize:none">${bean.reason}</textarea>
							</td>
						</tr>
						<tr>
							<td align="right" colspan="5">
							可输入剩余数：<span id="textareaNum1" class="250">
							<c:if test="${empty bean.reason}">250</c:if><c:if test="${!empty bean.reason}">${250-bean.reason.length()}</c:if>
							</span>
							</td>
						</tr>
					</table>
				</div>

				<!-- 报销明细 -->
				<div style="overflow:auto;margin-top: 10px;" id="zjbxmxxx">
					<div class="window-title">报销明细</div>
					<jsp:include page="directly_reimburse_mingxi.jsp" />
					<div style="overflow:auto;margin-top: 10px;margin-right: 22px;">
						<span style="float: right;">
							<span style="color: red;"  >申请总额: </span>
							<span style="float: right;"  id="applyAmount_span" ></span>
						</span>
					</div>
				</div>
				
				<%-- <div title="发票信息" id="zjbxfpxx" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
					<jsp:include page="directly_reimburse_invoice.jsp" />
				</div> --%>
				
				<!-- 收款人信息 -->
				<div style="overflow:auto;margin-top: 10px;">
				
					<div class="window-title">收款人信息</div>
					
					<input hidden="hidden" value="${payee.pId}" name="pId"/>
					<jsp:include page="../../payee-info.jsp" />	
					<input hidden="hidden" id="num2" name="payeeAmount" value="${payee.payeeAmount}" readonly="readonly" precision="2"/>
				</div>
				
				<div title="审批记录" data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top: 10px;">
					<div class="window-title">审批记录</div>
					<jsp:include page="../../../check_history.jsp" />												
				</div>
				
				<%-- <!-- 资金信息 -->
				<div id="spbxzjxx" style="overflow:auto;margin-top: 10px;">
					<div class="window-title">资金信息</div>
					<jsp:include page="../../apply/check/fundCheck.jsp" />
				</div> --%>
		
	
		</div>
		
		<div class="window-left-bottom-div">
			<a href="javascript:void(0)" onclick="saveReimburse(0)">
				<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>&nbsp;&nbsp;
			<a href="javascript:void(0)" onclick="saveReimburse(1)">
				<img src="${base}/resource-modality/${themenurl}/button/songshen1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>&nbsp;&nbsp;
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
</form>

<script type="text/javascript">
$(document).ready(function() {
	//是否显示 冲销借款信息
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

//保存
function saveReimburse(flowStauts) {
	// 在后台反序列话成明细Json的对象集合
	accept();
	var rows = $('#drmxdg').datagrid('getRows');
	var mingxi = "";
	for (var i = 0; i < rows.length; i++) {
		mingxi = mingxi + JSON.stringify(rows[i]) + ",";
	}
	$('#drMingxiJson').val(mingxi);
	
	/* // 在后台反序列话成发票Json的对象集合
	accept2();
	var rows2 = $('#drfpdg').datagrid('getRows');
	var fapiao = "";
	for (var i = 0; i < rows2.length; i++) {
		fapiao = fapiao + JSON.stringify(rows2[i]) + ",";
	}
	$('#drfpJson').val(fapiao); */
	
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	$("#files").val(s);

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
					$('#directly_reimburse_save_form').form('clear');
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

</script>

</body>