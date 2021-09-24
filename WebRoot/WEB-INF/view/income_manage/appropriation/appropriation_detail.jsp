<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<form id="appropriation_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="window-div">
		<div class="window-left-div" style="width:765px;height: 491px;border: 1px solid #D9E3E7;margin-top: 20px;">
			<div class="win-left-top-div">
				<!-- 隐藏域 --> 
				<!-- 主键ID --><input type="hidden" name="aId" value="${bean.aId}" />
				<!-- 审批状态 --><input type="hidden" name="fFlowStatus" value="${bean.fFlowStatus}" id="appropriationFlowStauts" />
				<!-- 下节点节点编码 --><input type="hidden" name="fNextCode" value="${bean.fNextCode}" />
				
				<!-- 对方单位名称 --><input type="hidden" id="unitNameHidden" name="unitName" value="${bean.unitName}" />
				<!-- 金额 --><input type="hidden" id="amountHidden" name="amount" value="${bean.amount}" />
				<!-- 来款日期 --><input type="hidden" id="paymentDateHidden" name="paymentDate" value="${bean.paymentDate}" />
				<!-- 开票种类 --><input type="hidden" id="invoiceTypeHidden" name="invoiceType" value="${bean.invoiceType}" />
				
				<!-- 基本信息 -->
				<div id="sqsqjbxx" style="overflow:auto;margin-top: 0px;">			
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px">
				<div title="基本信息" data-options="collapsed:false,collapsible:false" style="overflow:auto;">
					<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;">
						<tr class="trbody">
							<td class="td1" >
								<span class="style1">*</span>登记单号
							</td>
							<td class="td2">
								<input class="easyui-textbox" id="registerCode"
								name="registerCode" readonly="readonly" value="${bean.registerCode}"
								style="width: 200px;height: 30px;margin-left: 10px ">
							</td>
							<td class="td1"><span class="style1">*</span> 登记日期</td>
							<td class="td2">
								<input name="fApplyDate" id="fApplyDate" value="${bean.fApplyDate}" class="easyui-datebox" style="width:200px;height:30px"/>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1" ><span class="style1">*</span>
								登记部门</td>
							<td class="td2"><input class="easyui-textbox" id="fDeptName"
								name="fDeptName" readonly="readonly" value="${bean.fDeptName}"
								style="width: 200px;height: 30px;margin-left: 10px "></td>
							<td class="td1" ><span class="style1">*</span>
								登记人</td>
							<td class="td2"><input class="easyui-textbox" id="fOperatorName"
								name="fOperatorName" readonly="readonly" value="${bean.fOperatorName}"
								style="width: 200px;height: 30px;margin-left: 10px "></td>
						</tr>
						<tr class="trbody">
							<td class="td1" ><span class="style1">*</span> 拨款收入类型</td>
							<td class="td2">
								<input id="fundType" class="easyui-combobox" style="width: 200px; height: 30px;" name="fundType" value="${bean.fundType}" required="required" readonly="readonly"
									data-options="prompt: '-请选择-' ,valueField: 'fundType',textField: 'value',editable: false,
									data: [{fundType: '1',value: '财政拨款收入'},{fundType: '2',value: '上级拨款收入'},{fundType: '3',value: '非同级财政收入'}]"/>
							</td>
							<td class="td1"></td>
							<td class="td2" style="width: 200px;">
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span> 来款项目名称</td>
							<td colspan="3">
								<input class="easyui-textbox" style="width: 550px; height: 30px;" name="projectName" readonly="readonly"
								value="${bean.projectName}" required="required" data-options="validType:'length[1,100]'"/>
							</td>
						</tr>
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span>依据及简要说明</td>
							<td colspan="3"><input class="easyui-textbox"
								data-options="multiline:true,required:true,validType:'length[0,250]'"
								name="remark" style="width:550px;height:70px;"
								value="${bean.remark }" readonly="readonly"></td>
						</tr>
						<c:if test="${bean.fConfirmStatus=='1' }">
						<tr class="trbody">
							<td class="td1"><span class="style1">*</span>实际来款日期</td>
							<td class="td2">
								<input id="paymentActualDate" readonly="readonly" name="paymentActualDate" value="${bean.paymentActualDate}" class="easyui-datebox"
								 editable="false" style="width:200px;height:30px;margin-left: 10px"/>
							</td>
							<td class="td1" >
								<span class="style1">*</span> 会计凭证号
							</td>
							<td class="td2">
								<input class="easyui-textbox" readonly="readonly" id="accountingDocument"
								name="accountingDocument" value="${bean.accountingDocument}"
								style="width: 200px;height: 30px">
							</td>
						</tr>
						</c:if>
					</table>
				</div>				
				</div>
				</div>
				
				<!-- 来款明细 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 40px">
					<div title="来款明细" data-options="collapsible:false" style="overflow:auto;">
						<div style="overflow:auto;margin-top: 20px;">
							<jsp:include page="appropriation_info_add.jsp" />
						</div>
						<table class="window-table" cellspacing="0" cellpadding="0" style="margin-top: 3px;width:707px;">
						<tr>
							<td class="td1" style="width:55px;text-align: left"><span class="style1">*</span>
								附件:
								<input type="file" multiple="multiple" id="f" onchange="upladFile(this,null,'bklsr')" hidden="hidden">
								<input type="text" id="files" name="files" hidden="hidden">
							</td>
							<td colspan="3" id="tdf">
								<div id="progid" style="background:#EFF5F7;width:300px;height:10px;margin-top:5px;display: none" >
									<div id="progressNumber" style="background:#3AF960;width:0px;height:10px" >
									 </div>文件上传中...&nbsp;&nbsp;<font id="percent">0%</font> 
								</div>
								<c:forEach items="${attaList}" var="att">
									<div style="margin-top: 5px;">
									<a href='${base}/attachment/download/${att.id}' style="color: #666666;font-weight: bold;">${att.originalName}</a>
									</div>
								</c:forEach>
							</td>
						</tr>
						
						
					</table>
					</div>
				</div>
				
				<c:if test="${operation!='add' }">
				<!-- 审批记录 -->
				<div class="easyui-accordion" style="margin-left: 20px;margin-right: 20px;margin-top: 40px">
					<div title="审批记录" data-options="collapsible:false" style="overflow:auto;padding-top:10px;">
						<jsp:include page="../../check_history.jsp" />
					</div>
				</div>
				</c:if>
			</div>
			
			<div class="window-left-bottom-div" style="margin-top: 55px;">
				<a href="javascript:void(0)" onclick="closeWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>
			
		</div>
		<c:if test="${type!=1 }">
			<div class="window-right-div" style="width:254px;height: auto;padding-bottom: 20px;">
				<jsp:include page="../../check_system.jsp" />
			</div>
		</c:if>
	</div>
</form>

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
	$('#fApplyDate').attr("readonly","readonly");
	//$('#fApplyDate').datetimebox().datetimebox('setValue', formatterDate(new Date()));
	
});

function formatterDate(date){
	var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
	var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
	+ (date.getMonth() + 1);
	var hor = date.getHours();
	var min = date.getMinutes();
	var sec = date.getSeconds();
	return date.getFullYear() + '-' + month + '-' + day+" "+hor+":"+min+":"+sec;
}

//保存
function saveAppropriation(flowStauts) {
	// 来款明细
	acceptExpense();
	var rows = $('#appropriation_info_dg').datagrid('getRows');
	console.log(rows);
	console.info(rows[0].unitName)
	console.info(rows[0].amount)
	console.info(rows[0].paymentDate)
	console.info(rows[0].invoiceType)
	$('#unitNameHidden').val(rows[0].unitName);
	$('#amountHidden').val(rows[0].amount);
	$('#paymentDateHidden').val(rows[0].paymentDate);
	$('#invoiceTypeHidden').val(rows[0].invoiceType);
	//附件的路径地址
	var s="";
	$(".fileUrl").each(function(){
		s=s+$(this).attr("id")+",";
	});
	if(s==''){
		alert('请上传附件');
		return
	}
	$("#files").val(s);
	
	//设置审批状态
	$('#appropriationFlowStauts').val(flowStauts);
	
	//提交
	$('#appropriation_save_form').form('submit', {
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
		url : base + '/appropriation/save',
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

function accept() {
	if (endEditing()) {
		$('#dg_meet_plan').datagrid('acceptChanges');
	}
}

</script>