<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-table" style="margin-top: 10px;">
<table id="contract-cgconfig-detail-dg" class="easyui-datagrid" style="margin-top: 10px;width: 695px" cellspacing="0" cellpadding="0"
data-options="
singleSelect: true,
rownumbers : true,
striped:true,
url: '${base}/Change/mingxi?id=${Upt.fId_U}&type=1',
">
<thead>
	<tr>
		<th data-options="field:'mainId',hidden:true"></th>
		<th data-options="field:'fplId',hidden:true"></th>
		<th data-options="field:'fpurCode',hidden:true"></th>
		<th data-options="field:'fIsImp',hidden:true"></th>
		<th data-options="field:'fSiteAndPeriod',hidden:true"></th>
		<th data-options="field:'fManager',hidden:true"></th>
		<th data-options="field:'fpurName',align:'center',width:154">商品名称</th>
		<th data-options="field:'fpurBrand',align:'center',width:154">品牌</th>
		<th data-options="field:'fModel',align:'center',width:154">型号</th>
		<th data-options="field:'fspec',align:'center',width:154">规格</th>
		<th data-options="field:'fnum',align:'center',width:154,editor:{type:'numberbox',options:{readonly:true,required:true,precision:2,groupSeparator:','}},validType:'length[1,50]'">数量</th>
		<th data-options="field:'fmeasureUnit',align:'center',width:70">单位</th>
		<th data-options="field:'funitPrice',align:'center',width:154,editor:{type:'numberbox',options:{readonly:true,required:true,precision:2,groupSeparator:','}}">单价(元)</th>
		<th data-options="field:'fsumMoney',align:'center',width:154,editor:{type:'numberbox',options:{readonly:true,required:true,precision:2,groupSeparator:','}},validType:'length[1,50]'">金额(元)</th>
	</tr>
</thead>
</table>
</div>
<script type="text/javascript">
function changefsumMoney(newValue,oldVlaue){
	var totalFsumMoney = 0;
	var fsumMoney = 0;
	var index=$('#contract-cgconfig-detail-dg').datagrid('getRowIndex',$('#contract-cgconfig-detail-dg').datagrid('getSelected'));
	var rows = $('#contract-cgconfig-detail-dg').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		if(i==index){
			totalFsumMoney+=parseFloat(newValue);
		}else{
			totalFsumMoney+=parseFloat(rows[i].fsumMoney);
		}  
	}
	var ed = $('#contract-cgconfig-detail-dg').datagrid('getEditor', {index:index,field:'funitPrice'});
	if(index!=-1){
		$(ed.target).numberbox('setValue', parseFloat(newValue)/parseFloat(rows[index].fnum));
	}
	//$('#totalPrice').numberbox('setValue',totalFsumMoney.toFixed(2));
	//$('#F_fbidAmount').numberbox('setValue',totalFsumMoney.toFixed(2));
	
}
function changefnum(newValue,oldVlaue){
	var index=$('#contract-cgconfig-detail-dg').datagrid('getRowIndex',$('#contract-cgconfig-detail-dg').datagrid('getSelected'));
	var rows = $('#contract-cgconfig-detail-dg').datagrid('getRows');
	var ed = $('#contract-cgconfig-detail-dg').datagrid('getEditor', {index:index,field:'funitPrice'});
	if(index!=-1){
		$(ed.target).numberbox('setValue', parseFloat(rows[index].fsumMoney)/parseFloat(newValue));
	}
	//$('#totalPrice').numberbox('setValue',totalFsumMoney.toFixed(2));
	//$('#F_fbidAmount').numberbox('setValue',totalFsumMoney.toFixed(2));
	
}

//明细表格添加删除，保存方法
var editIndexUptcgconfig = undefined;
function endEditingUptcgconfig() {
	if (editIndexUptcgconfig == undefined) {
		return true;
	}
	if ($('#contract-cgconfig-detail-dg').datagrid('validateRow', editIndexUptcgconfig)) {
		/* var ed = $('#contract-cgconfig-detail-dg').datagrid('getEditor', {
			index : editIndexUptcgconfig,
			field : 'costDetail'
		}); */
		$('#contract-cgconfig-detail-dg').datagrid('endEdit', editIndexUptcgconfig);
		editIndexUptcgconfig = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowUptcgconfig(index) {
	if (editIndexUptcgconfig != index) {
		if (endEditingUptcgconfig()) {
			$('#contract-cgconfig-detail-dg').datagrid('selectRow', index).datagrid('beginEdit', index);
			editIndexUptcgconfig = index;
		} else {
			$('#contract-cgconfig-detail-dg').datagrid('selectRow', editIndexUptcgconfig);
		}
	}
}
function acceptUptcgconfig() {
	if (endEditingUptcgconfig()) {
		$('#contract-cgconfig-detail-dg').datagrid('acceptChanges');
	}
}

function getuptcgconfigJson(){
	acceptUptcgconfig();
	$('#contract-cgconfig-detail-dg').datagrid('acceptChanges');
	var rows = $('#contract-cgconfig-detail-dg').datagrid('getRows');
	var entities= '';
	for(var i = 0;i < rows.length;i++){
		entities = entities  + JSON.stringify(rows[i]) + ',';  
	}
	entities = '[' + entities.substring(0,entities.length -1) + ']';
	return entities;
}

function onLoadSuccessAmount(){
	var rows2 = $('#contract-cgconfig-detail-dg').datagrid('getRows');
	var amount = 0;
	for (var j = 0; j < rows2.length; j++) {
		var fsumMoney = parseFloat(rows2[j].fsumMoney);
		if(isNaN(fsumMoney)){
			fsumMoney = 0;
		}
		amount = amount +fsumMoney;
	}
	$('#F_facpAmount').val(amount.toFixed(2));
}
</script>