<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-table" style="margin-top: 10px;">
<table id="contract-cgconfig-dg" class="easyui-datagrid" style="margin-top: 10px;width: 695px" cellspacing="0" cellpadding="0"
data-options="
singleSelect: true,
toolbar: '#contract-cgconfig-tb',
rownumbers : true,
striped:true,
<c:if test="${empty Upt.fId_U}">
url: '${base}/Formulation/mingxi?id=${bean.fcId}&type=0',
</c:if>
<c:if test="${!empty Upt.fId_U}">
url: '${base}/Change/mingxi?id=${Upt.fId_U}&type=1',
</c:if>
<c:if test="${empty fIsContract}">
onClickRow: onClickRowUptcgconfig,
</c:if>
onLoadSuccess:onLoadSuccessAmountUpt
">
<thead>
	<tr>
		<th data-options="field:'mainId',hidden:true"></th>
		<th data-options="field:'fplId',hidden:true"></th>
		<th data-options="field:'fpurCode',hidden:true"></th>
		<th data-options="field:'fIsImp',hidden:true"></th>
		<th data-options="field:'fSiteAndPeriod',hidden:true"></th>
		<th data-options="field:'fManager',hidden:true"></th>
		<th data-options="field:'fpurName',align:'center'"style="width: 20%">商品名称</th>
		<th data-options="field:'fpurBrand',align:'center'"style="width: 15%">品牌</th>
		<th data-options="field:'fModel',align:'center'"style="width: 15%">型号</th>
		<th data-options="field:'fspec',align:'center'"style="width: 15%">规格</th>
		<th data-options="field:'fnum',align:'center',editor:{type:'numberbox',options:{onChange:setFnumBG,required:true,groupSeparator:','}}"style="width: 15%">数量</th>
		<th data-options="field:'fmeasureUnit',align:'center'"style="width: 15%">单位</th>
		<th data-options="field:'funitPrice',align:'center',editor:{type:'numberbox',options:{readonly:true,required:true,precision:2,groupSeparator:','}}"style="width: 15%">单价(元)</th>
		<th data-options="field:'fsumMoney',align:'center',editor:{type:'numberbox',options:{onChange:setFsumMoneyBG,required:true,precision:2,groupSeparator:','}},validType:'length[1,50]'"style="width: 15%">金额(元)</th>
	</tr>
</thead>
</table>
</div>
<script type="text/javascript">
/* function changefsumMoney(newValue,oldVlaue){
	var totalFsumMoney = 0;
	var fsumMoney = 0;
	var index=$('#contract-cgconfig-dg').datagrid('getRowIndex',$('#contract-cgconfig-dg').datagrid('getSelected'));
	var rows = $('#contract-cgconfig-dg').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		if(i==index){
			totalFsumMoney+=parseFloat(newValue);
		}else{
			totalFsumMoney+=parseFloat(rows[i].fsumMoney);
		}  
	}
	var ed = $('#contract-cgconfig-dg').datagrid('getEditor', {index:index,field:'funitPrice'});
	if(index!=-1){
		$(ed.target).numberbox('setValue', parseFloat(newValue)/parseFloat(rows[index].fnum));
	}
}
function changefnum(newValue,oldVlaue){
	var index=$('#contract-cgconfig-dg').datagrid('getRowIndex',$('#contract-cgconfig-dg').datagrid('getSelected'));
	var rows = $('#contract-cgconfig-dg').datagrid('getRows');
	var ed = $('#contract-cgconfig-dg').datagrid('getEditor', {index:index,field:'funitPrice'});
	if(index!=-1){
		$(ed.target).numberbox('setValue', parseFloat(rows[index].fsumMoney)/parseFloat(newValue));
	}
} */

//明细表格添加删除，保存方法
var editIndexUptcgconfig = undefined;
function endEditingUptcgconfig() {
	if (editIndexUptcgconfig == undefined) {
		return true;
	}
	if ($('#contract-cgconfig-dg').datagrid('validateRow', editIndexUptcgconfig)) {
		/* var ed = $('#contract-cgconfig-dg').datagrid('getEditor', {
			index : editIndexUptcgconfig,
			field : 'costDetail'
		}); */
		$('#contract-cgconfig-dg').datagrid('endEdit', editIndexUptcgconfig);
		editIndexUptcgconfig = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowUptcgconfig(index) {
	if (editIndexUptcgconfig != index) {
		if (endEditingUptcgconfig()) {
			$('#contract-cgconfig-dg').datagrid('selectRow', index).datagrid('beginEdit', index);
			editIndexUptcgconfig = index;
		} else {
			$('#contract-cgconfig-dg').datagrid('selectRow', editIndexUptcgconfig);
		}
	}
}
function acceptUptcgconfig() {
	if (endEditingUptcgconfig()) {
		$('#contract-cgconfig-dg').datagrid('acceptChanges');
	}
}

function getuptcgconfigJson(){
	acceptUptcgconfig();
	$('#contract-cgconfig-dg').datagrid('acceptChanges');
	var rows = $('#contract-cgconfig-dg').datagrid('getRows');
	var entities= '';
	for(var i = 0;i < rows.length;i++){
		entities = entities  + JSON.stringify(rows[i]) + ',';  
	}
	entities = '[' + entities.substring(0,entities.length -1) + ']';
	return entities;
}
function onLoadSuccessAmountUpt(){
	var rows2 = $('#contract-cgconfig-dg').datagrid('getRows');
	var amount = 0;
	for (var j = 0; j < rows2.length; j++) {
		var fsumMoney = parseFloat(rows2[j].fsumMoney);
		if(isNaN(fsumMoney)){
			fsumMoney = 0;
		}
		amount = amount +fsumMoney;
	}
	$('#F_fAmount').val(amount.toFixed(2));
}

function setFnumBG(newVal,oldVal){
	var row = $('#contract-cgconfig-dg').datagrid('getSelected');//获得选择行
	var index=$('#contract-cgconfig-dg').datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $('#contract-cgconfig-dg').datagrid('getEditors', index);
	var fsumMoney= parseFloat(tr[2].target.numberbox('getValue'));
	var fnum =isNaN(parseInt(newVal))?0:parseInt(newVal);
	
	if(isNaN(fsumMoney)){
		fsumMoney=0;
		tr[1].target.numberbox('setValue',0);
	}else{
		if(fnum==0){
			tr[0].target.numberbox('setValue',0);
			tr[1].target.numberbox('setValue',0);
		}else{
			tr[1].target.numberbox('setValue',fsumMoney/fnum);
		}
	}
}
function setFsumMoneyBG(newVal,oldVal){
	var row = $('#contract-cgconfig-dg').datagrid('getSelected');//获得选择行
	var index=$('#contract-cgconfig-dg').datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $('#contract-cgconfig-dg').datagrid('getEditors', index);
	var fnum = parseFloat(tr[0].target.numberbox('getValue'));
	var fsumMoney=isNaN(parseFloat(newVal))?0:parseFloat(newVal);
	if(isNaN(fnum)){
		fnum=0;
		tr[1].target.numberbox('setValue',0);
	}else{
		if(fnum==0){
			tr[1].target.numberbox('setValue',0);
		}else{
			tr[1].target.numberbox('setValue',fsumMoney/fnum);
		}
	}
}
</script>