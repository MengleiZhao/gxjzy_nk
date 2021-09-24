<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="window-div">
<form id="loan_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div">
				<div class="easyui-accordion" data-options="" id="easyAcc" style="margin-left: 20px;margin-right: 20px">
					<div title="基本信息" id="jksqjbxx" data-options="collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
						<table class="ourtable" cellpadding="0" cellspacing="0">
						<c:if test="${openType=='edit' }">
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span> 借款单号</td>
								<td colspan="4">
									<input style="width: 558px;height: 30px;" name="gCode" class="easyui-textbox"
									value="${bean.lCode}" data-options="required:true" readonly="readonly"/>
								</td>
							</tr>
						</c:if>
						<tr class="trbody">
								<td class="td1"><span class="style1">*</span>借款单摘要</td>
								<td colspan="4">
									<input style="width: 558px;"
									name="loanPurpose" class="easyui-textbox"
									value="${bean.loanPurpose}" data-options="required:true,validType:'length[1,50]'"/>
								</td>
							</tr>
							<tr class="trbody">
								<td class="td1"><span class="style1">*</span> 借款金额</td>
								<td class="td2">
									<input style="width: 200px;" id="lAmount" name="lAmount" class="easyui-numberbox" 
									value="${bean.lAmount}" precision="2" data-options="icons: [{iconCls:'icon-yuan'}],required:true,formatter:function(value,row,index){return fomatMoney(value,2);}"/>
								</td>
								<td class="td4">
									<!-- 隐藏域 --> 
									<!-- 主键ID --><input type="hidden" name="lId" value="${bean.lId}" />
									<!-- 借款单编号 --><input type="hidden" name="lCode" value="${bean.lCode}" />
									<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="loanflowStauts"/> 
									<!-- 申请状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="loanStauts" />
									<!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}"/>
									<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" />
									<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
									<!-- 指标ID --><input type="hidden" name="indexId" value="${bean.indexId}" id="F_fBudgetIndexCode"/>
									<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="F_indexType"/>
									<!-- 指标剩余金额 --><input type="hidden" name="indexAmount" value="${bean.indexAmount}" id="indexAmount"/>
									<!-- 剩余还款金额 --><input type="hidden" id="leastAmount" name="leastAmount" value="${bean.leastAmount }">
									<!-- 指标明细id --><input type="hidden" id="F_proDetailId" name="proDetailId" value="${bean.proDetailId}">
								<td class="td1"><span class="style1">*</span> 计划还款时间</td>

								<td class="td2">
									<input style="width: 200px;" id="estChargeTime"
									name="estChargeTime" class="easyui-datebox"
									value="${bean.estChargeTime}"  required="required" editable="false"/>
								</td>
							</tr>
							<tr style="height:5px;"></tr>
							<tr style="height: 70px;">
								<td class="td1" valign="top"><span class="style1">*</span> 借款事由</td>
								<td colspan="4">
									<textarea name="loanReason"  id="loanReason" class="textbox-text" required="required" oninput="textareaNum(this,'textareaNum1')" autocomplete="off"   style="border-radius: 5px;border: 1px solid #D9E3E7;width:551px;height:70px;resize:none">${bean.loanReason}</textarea>
								</td>
							</tr>
							<tr>
								<td align="right" colspan="5">
								可输入剩余数：<span id="textareaNum1" class="250">250</span>
								</td>
							</tr>
						</table>
					</div>
					<div title="收款人信息" id="jksqjxrxx"  data-options="collapsed:false,collapsible:false" style="overflow:auto;margin-top: 10px;">
						<input hidden="hidden" value="${payee.rId}" name="rId"/>
						<jsp:include page="../payee-info-loan.jsp" />
					</div>
				</div>
			</div>
			
			<div class="window-left-bottom-div">
				<a href="javascript:void(0)" onclick="saveLoan(0)">
				<img src="${base}/resource-modality/${themenurl}/button/zhanchun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" onclick="saveLoan(1)">
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
			<jsp:include page="../../check_system.jsp" />
		</div>
</form>
</div>
<script type="text/javascript">

/* function estChargeTime(){
	
	var loanReqTime = $('#loanReqTime').datebox('getValue');
	var estChargeTime = $('#estChargeTime').datebox('getValue');
	
	if(estChargeTime < loanReqTime){
		alert("预计冲账时间必须大于借款时间,请重新选择");
		$('#estChargeTime').datebox('setValue',null);
	}
	
} */

/* 
$('#estChargeTime').datebox({
	onChange: function(newValue, oldValue){
		
		var loanReqTime = $('#loanReqTime').datebox('getValue');
		estChargeTime = ChangeDateFormat(newValue);
		if(estChargeTime < loanReqTime && estChargeTime != ""){
			alert("预计冲账时间必须大于借款时间,请重新选择");
			$('#estChargeTime').datebox('setValue',null);
			newValue=null;
		}
	}
}); */

//保存
function saveLoan(flowStauts) {
	//设置审批状态
	$('#loanflowStauts').val(flowStauts);
	//设置申请状态
	$('#loanStauts').val(flowStauts);
	var lAmount=$('#lAmount').textbox('getValue'); //借款金额
	var indexAmount=$('#indexAmount').val(); //剩余金额
	if(parseFloat(lAmount)>10000){
		$.messager.alert('系统提示', "借款金额不能大于10000", 'info');
		return false;
	}
	if(parseFloat(lAmount)>parseFloat(indexAmount)){
		$.messager.alert('系统提示', "借款金额不能大于指标剩余金额", 'info');
		return false;
	}
	//提交
	$('#loan_save_form').form('submit', {
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
		url : base + '/loan/save',
		success : function(data) {
			if (flag) {
				$.messager.progress('close');
			}
			data = eval("(" + data + ")");
			if (data.success) {
				$.messager.alert('系统提示', data.info, 'info');
				closeWindow();
				$('#loan_save_form').form('clear');
				$('#loanTab').datagrid('reload');
				$('#indexdb').datagrid('reload');
			} else {
				$.messager.alert('系统提示', data.info, 'error');
			}
		}
	});
}

//打开指标选择页面
function openIndex() {
	/* var win=creatFirstWin(' ',860,580,'icon-search','/quota/choiceIndex');
	win.window('open'); */
	var win=creatFirstWin('选择指标',1060,580,'icon-search','/apply/choiceIndex?menuType=loanApply'); 
	win.window('open');
}
</script>
</body>