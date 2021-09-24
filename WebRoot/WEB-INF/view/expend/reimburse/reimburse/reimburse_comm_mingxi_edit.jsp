<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" id="rcomm-edit-div" style="margin-left: 0px;padding-top: 10px">
	<div id="rcomm-edit-tb" style="height:30px;padding-top : 8px">
		<a style="float: left;color: #666666;font-size:12px;">申请金额：<span ><fmt:formatNumber groupingUsed="true" value="${applyBean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="rcommeditAmount"><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		<a href="javascript:void(0)" onclick="commremoveit()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="commappendRow()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	<table id="rcomm-edit-tab" class="easyui-datagrid" style="width:693px;height:auto"
	data-options="
	toolbar: '#rcomm-edit-tb',
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
	onClickRow: commonClickRow,
	scrollbarSize:0,
	singleSelect: true,
	">
		<thead>
			<tr>
				<th data-options="field:'cId',hidden:true"></th>
				<th data-options="field:'costDetail',align:'center',editor:{type:'textbox',options:{required:'true'}}" width='30%'>费用名称</th>
				<th data-options="field:'applySum',hidden:true,align:'center',editor:{type:'numberbox',options:{readonly:'true',precision:2,groupSeparator:',',icons:[{iconCls:'icon-yuan'}]}}"  width='20%'>申请金额</th>
				<th data-options="field:'remibAmount',align:'center',editor:{type:'numberbox',options:{onChange:rcommaddNum,required:'true',precision:2,groupSeparator:',',icons:[{iconCls:'icon-yuan'}]}}"  width='30%'>报销金额</th>
				<th data-options="field:'remark',required:'required',align:'center',editor:'textbox'" width='40%'>描述</th>
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
	if ($('#rcomm-edit-tab').datagrid('validateRow', editIndex)) {
		var ed = $('#rcomm-edit-tab').datagrid('getEditor', {
			index : editIndex,
			field : 'costDetail'
		});
		$('#rcomm-edit-tab').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function commonClickRow(index) {
	if (editIndex != index) {
		if (commendEditing()) {
			$('#rcomm-edit-tab').datagrid('selectRow', index).datagrid('beginEdit',index);
			editIndex = index;
		} else {
			$('#rcomm-edit-tab').datagrid('selectRow', editIndex);
		}
	}
}
function commappendRow() {
	if (commendEditing()) {
		$('#rcomm-edit-tab').datagrid('appendRow', {});
		editIndex = $('#rcomm-edit-tab').datagrid('getRows').length - 1;
		$('#rcomm-edit-tab').datagrid('selectRow', editIndex).datagrid('beginEdit',
				editIndex);
	}

	/* //页面随滚动条置底
	var div = document.getElementById('rcomm-edit-div');
	div.scrollTop = div.scrollHeight; */
}
function commremoveit() {
	if (editIndex == undefined) {
		return
	}
	$('#rcomm-edit-tab').datagrid('cancelEdit', editIndex).datagrid('deleteRow',editIndex);
	editIndex = undefined;
	
	//修改申请总额
	var num = 0;
	var remibAmount = 0;
	var rows = $('#rcomm-edit-tab').datagrid('getRows');
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
	$('#rcommeditAmount').html(remibAmount.toFixed(2)+'[元]');
	$('#p_amount').html(remibAmount.toFixed(2)+'[元]');
	$('#reimburseAmount').val(remibAmount.toFixed(2));//报销总额
	jk();
}
function commaccept() {
	if (commendEditing()) {
		$('#rcomm-edit-tab').datagrid('acceptChanges');
	}
}
function rcommaddNum (oldValue,newValue){
	var rcommeditAmount = 0.00;
	var rows = $('#rcomm-edit-tab').datagrid('getRows' );
	for (var i = 0; i < rows.length; i++) {
		if(i==editIndex){
			var row = $('#rcomm-edit-tab').datagrid('getSelected');//获得选择行
			var index=$('#rcomm-edit-tab').datagrid('getRowIndex',row);//获得选中行的行号
			var tr = $('#rcomm-edit-tab').datagrid('getEditors', index);
			var remibAmount = isNaN(tr[2].target.numberbox('getValue'))?0.00:tr[2].target.numberbox('getValue');
			rcommeditAmount = parseFloat(rcommeditAmount) +  parseFloat(remibAmount);
		}else {
			var remibAmount = isNaN(parseFloat(rows[i].remibAmount))?parseFloat(0.00):parseFloat(rows[i].remibAmount);
			rcommeditAmount = parseFloat(rcommeditAmount) +  parseFloat(remibAmount);
		}
	}
	$('#rcommeditAmount').html(rcommeditAmount.toFixed(2)+'[元]');
	$('#p_amount').html(rcommeditAmount.toFixed(2)+'[元]');
	$('#reimburseAmount').val(rcommeditAmount.toFixed(2));//报销总额
	jk();
}
function commjson(){
	var mingxi = "";
	var rows = $('#rcomm-edit-tab').datagrid('getRows' );
	for (var i = 0; i < rows.length; i++) {
		mingxi = mingxi + JSON.stringify(rows[i]) + ",";
		rcommomey = parseFloat(rcommomey) + parseFloat(rows[i].remibAmount);
	}
	//console.log(mingxi);
	$('#mingxiJson').val(mingxi);
}

</script>