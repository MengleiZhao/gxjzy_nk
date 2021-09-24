<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" id="rcurrent-edit-div" style="margin-left: 0px;padding-top: 10px">
	<div id="rcurrent-edit-tb" style="height:30px;padding-top : 8px">
		<a style="float: left;color: #666666;font-size:12px;font-weight:bold;">报销金额：<span id="rcurrenteditAmount"><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		<a href="javascript:void(0)" onclick="currentremoveit()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="currentappend()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	<table id="rcurrent-edit-tab" class="easyui-datagrid" style="width:693px;height:auto"
	data-options="
	toolbar: '#rcurrent-edit-tb',
	<c:if test="${operation=='add'}">		
	url: '${base}/apply/mingxi?id=${applyBean.gId}',
	</c:if>
	<c:if test="${operation=='edit'}">
	url: '${base}/reimburse/mingxiTY?rId=${bean.rId}',
	</c:if>
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	onClickRow: currentonClickRow,
	scrollbarSize:0,
	singleSelect: true,
	">
		<thead>
			<tr>
				<th data-options="field:'cId',hidden:true"></th>
				<th data-options="field:'costDetail',align:'center',editor:{type:'textbox',options:{required:'true'}}" width='50%'>费用名称</th>
				<th data-options="field:'applySum',hidden:true,align:'center',editor:{type:'numberbox',options:{readonly:'true',precision:2,groupSeparator:',',icons:[{iconCls:'icon-yuan'}]}}"  width='20%'>申请金额</th>
				<th data-options="field:'remibAmount',align:'center',editor:{type:'numberbox',options:{onChange:rcommaddNum,required:'true',precision:2,groupSeparator:',',icons:[{iconCls:'icon-yuan'}]}}"  width='50%'>报销金额</th>
				<th data-options="field:'remark',hidden:true,required:'required',align:'center',editor:'textbox'" width='40%'>描述</th>
			</tr>
		</thead>
	</table>
	
</div>
<script type="text/javascript">
var rcommomey = 0.00;
//明细表格添加删除，保存方法
var editIndex = undefined;
function commendEditing() {
	if (editIndex == undefined) {
		return true
	}
	if ($('#rcurrent-edit-tab').datagrid('validateRow', editIndex)) {
		var ed = $('#rcurrent-edit-tab').datagrid('getEditor', {
			index : editIndex,
			field : 'costDetail'
		});
		$('#rcurrent-edit-tab').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function currentonClickRow(index) {
	if (editIndex != index) {
		if (commendEditing()) {
			$('#rcurrent-edit-tab').datagrid('selectRow', index).datagrid('beginEdit',index);
			editIndex = index;
		} else {
			$('#rcurrent-edit-tab').datagrid('selectRow', editIndex);
		}
	}
}
function currentappend() {
	if (commendEditing()) {
		$('#rcurrent-edit-tab').datagrid('appendRow', {});
		editIndex = $('#rcurrent-edit-tab').datagrid('getRows').length - 1;
		$('#rcurrent-edit-tab').datagrid('selectRow', editIndex).datagrid('beginEdit',
				editIndex);
	}

	/* //页面随滚动条置底
	var div = document.getElementById('rcurrent-edit-div');
	div.scrollTop = div.scrollHeight; */
}
function currentremoveit() {
	if (editIndex == undefined) {
		return
	}
	$('#rcurrent-edit-tab').datagrid('cancelEdit', editIndex).datagrid('deleteRow',editIndex);
	editIndex = undefined;
	
	//修改申请总额
	var num = 0;
	var remibAmount = 0;
	var rows = $('#rcurrent-edit-tab').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		if(rows[i].applySum!=""&&rows[i].applySum!=null){
			num += parseFloat(rows[i].applySum);
		}
		if(rows[i].remibAmount!=""&&rows[i].remibAmount!=null){
			remibAmount += parseFloat(rows[i].remibAmount);
		}
	}
	$('#num1').textbox('setValue',num.toFixed(2));
	$('#applyAmount').val(num.toFixed(2));
	$('#rcurrenteditAmount').html(remibAmount.toFixed(2)+'[元]');
	$('#p_amount').html(remibAmount.toFixed(2)+'[元]');
	$('#reimburseAmount').val(remibAmount.toFixed(2));//报销总额
}
function commaccept() {
	if (commendEditing()) {
		$('#rcurrent-edit-tab').datagrid('acceptChanges');
	}
}
function rcommaddNum (oldValue,newValue){
	var rcurrenteditAmount = 0.00;
	var rows = $('#rcurrent-edit-tab').datagrid('getRows' );
	for (var i = 0; i < rows.length; i++) {
		if(i==editIndex){
			var row = $('#rcurrent-edit-tab').datagrid('getSelected');//获得选择行
			var index=$('#rcurrent-edit-tab').datagrid('getRowIndex',row);//获得选中行的行号
			var tr = $('#rcurrent-edit-tab').datagrid('getEditors', index);
			var remibAmount = isNaN(tr[2].target.numberbox('getValue'))?0.00:tr[2].target.numberbox('getValue');
			rcurrenteditAmount = parseFloat(rcurrenteditAmount) +  parseFloat(remibAmount);
		}else {
			var remibAmount = isNaN(parseFloat(rows[i].remibAmount))?parseFloat(0.00):parseFloat(rows[i].remibAmount);
			rcurrenteditAmount = parseFloat(rcurrenteditAmount) +  parseFloat(remibAmount);
		}
	}
	$('#rcurrenteditAmount').html(rcurrenteditAmount.toFixed(2)+'[元]');
	$('#p_amount').html(rcurrenteditAmount.toFixed(2)+'[元]');
	$('#reimburseAmount').val(rcurrenteditAmount.toFixed(2));//报销总额
}
function commjson(){
	var mingxi = "";
	var rows = $('#rcurrent-edit-tab').datagrid('getRows' );
	for (var i = 0; i < rows.length; i++) {
		mingxi = mingxi + JSON.stringify(rows[i]) + ",";
		rcommomey = parseFloat(rcommomey) + parseFloat(rows[i].remibAmount);
	}
	//console.log(mingxi);
	$('#mingxiJson').val(mingxi);
}

</script>