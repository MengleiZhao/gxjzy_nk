<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<script type="text/javascript">
$(document).ready(function() {
	//设值时间
	if($("#applyReqTime").val()==""||$("#applyReqTime").val()==null){
		var date = new Date();
		date=ChangeDateFormat(date);
		$("#req_time").html(date);
	} else {
		var date = $("#applyReqTime").val();
		date=ChangeDateFormat(date);
		$("#req_time").html(date);
	}
});


//打开指标选择页面
function openIndex() {
	var win=creatFirstWin(' ',860,580,'icon-search','/quota/choiceIndex');
	win.window('open');
}


//计算申请总额
function addNum(newValue,oldValue) {
	var type = '${type}';
	if (type=='4') {
		$('#appli-detail-dg-travel').datagrid('acceptChanges');
		var rows = $('#appli-detail-dg-travel').datagrid('getRows');
		var totalPrice = 0;
		for(var i=0; i<rows.length; i++){
			var pri = parseFloat(rows[i].applySum);
			if(!isNaN(pri)){
				totalPrice = totalPrice + pri;
			}
		}
		//给两个总额框赋值
		$('#applyAmount').numberbox('setValue',totalPrice);
		$('#num1').numberbox('setValue',totalPrice);
		return;
	} else {
		var row = $('#appli-detail-dg').datagrid('getSelected');//获得选择行
		var index=$('#appli-detail-dg').datagrid('getRowIndex',row);//获得选中行的行号
		var tr = $('#appli-detail-dg').datagrid('getEditors', 2);
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

	/* //页面随滚动条置底
	var div = document.getElementById('easyAcc');
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
	$('#num1').textbox('setValue',num);
	$('#applyAmount').textbox('setValue',num);
}
function accept() {
	if (endEditing()) {
		$('#appli-detail-dg').datagrid('acceptChanges');
	}
}
</script>

<form id="apply_save_form" method="post" data-options="novalidate:true" class="easyui-form" enctype="multipart/form-data">
	<div class="win-div">
		<div class="win-left-div" style="width:705px;height: 491px">
			<!-- 隐藏域 --> 
			<!-- 主键ID --><input type="hidden" name="gId" value="${bean.gId}" />
			<!-- 申请单流水号 --><input type="hidden" name="gCode" value="${bean.gCode}" />
			<!-- 审批状态 --><input type="hidden" name="flowStauts" value="${bean.flowStauts}" id="applyflowStauts" />
			<!-- 申请状态 --><input type="hidden" name="stauts" value="${bean.stauts}" id="applyStauts" />
			<!-- 下环节处理人姓名 --><input type="hidden" name="userName2" value="${bean.userName2}" />
			<!-- 下环节处理人编码 --><input type="hidden" name="userId" value="${bean.userId}" />
			<!-- 下节点节点编码 --><input type="hidden" name="nCode" value="${bean.nCode}" />
			<!-- 申请类型 --><input type="hidden" id="applyTypeHi" value="${bean.type}" />
			<!-- 指标ID --><input type="hidden" name="indexId" value="${bean.indexId}" id="F_fBudgetIndexCode"/>
			<!-- 指标类型 --><input type="hidden" name="indexType" value="${bean.indexType}" id="F_indexType"/>
			<!-- 申请时间  --><input type="hidden" id="applyReqTime" name="reqTime" value="${bean.reqTime}"/>
		
		
			<!-- ------------------------------------------基本信息---------------------------------------------------  -->
		
			<div class="win-title">基本信息</div>
			
			<table class="win-table win-table-readonly" cellspacing="0" cellpadding="0">
				<tr>
					<td class="win-table-td1"><p>申请人:</p></td>
					<td class="win-table-td2"><p>${bean.userName}</p></td>
					
					<td class="win-table-td1"><p>申请部门:</p></td>
					<td class="win-table-td2"><p>${bean.deptName}</p></td>
				</tr>
				
				<tr>
					<td class="win-table-td1"><p>申请时间:</p></td>
					<td colspan="3"><p id="req_time">${bean.reqTime}</p></td>
				</tr>
			</table>
			
			<table class="win-table" cellspacing="0" cellpadding="0">
				<tr>
					<td class="win-table-td1"><p>摘要名称:</p></td>
					<td colspan="3">
						<input class="easyui-textbox" style="width: 570px;height: 25px" value="${bean.gName}" name="gName" required="required" data-options="validType:'length[1,50]'"/>
					</td>
				</tr>
				
				<tr>
					<td class="win-table-td1"><p>支出项目:</p></td>
					<td colspan="3">
						<a onclick="openIndex()" href="#">
							<input class="easyui-textbox" style="width: 570px;height: 25px" value="${bean.indexName}" name="indexName" id="F_fBudgetIndexName"
								data-options="prompt: '选择指标' ,icons: [{iconCls:'icon-sousuo'}]" readonly="readonly" required="required"/>
						</a>
					</td>
				</tr>
				
				<!-- <tr>
					<td class="win-table-td1"></td>
					<td colspan="3">
						
					</td>
				</tr> -->
				
				<tr>
					<td class="win-table-td1"><p>附件:</p></td>
					<td colspan="3" id="tdf">
						<input type="file" multiple="multiple" id="f" onchange="upladFile(this,null,'zcgl01')" hidden="hidden">
						<input type="text" id="files" name="files" hidden="hidden">
						<a onclick="$('#f').click()" style="display:block;font-weight: bold;height: 24px;width: 64px" href="#">
							<img src="${base}/resource-modality/${themenurl}/button/shangchuan1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"> 
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
			</table>
			
			<!-- ------------------------------------------费用明细---------------------------------------------------  -->
			
			<div class="win-title">费用明细
				<a href="javascript:void(0)" onclick="removeit()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
				<a style="float: right;">&nbsp;&nbsp;</a>
				<a href="javascript:void(0)" onclick="append()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
			</div>
			
			<div class="win-tab">
				<jsp:include page="mingxi.jsp" />
			</div>
			
			<!-- ------------------------------------------审批记录---------------------------------------------------  -->

			<div class="win-title">审批记录</div>
			
			<div class="win-tab">
				<jsp:include page="../check/apply_check_history.jsp" />
			</div>
		</div>
	
		<div class="win-right-div" style="width:254px;height: 491px">
			<jsp:include page="../../../check_system.jsp" />
		</div>
	</div>
</form>