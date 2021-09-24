<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table id="plan_contract_dg" class="easyui-datagrid" style="width:700px;height:auto"
data-options="
singleSelect: true,
rownumbers : true,
striped:true,
 <c:if test="${!empty bean.fcId}">
url: '${base}/Formulation/mingxi?id=${bean.fcId}&type=0',
</c:if>
<c:if test="${empty fIsContract}">
onClickRow: onClickRowContract,
</c:if>
onLoadSuccess:onLoadSuccessAmount
">
<thead>
	<tr>
		<th data-options="field:'mainId',hidden:true"></th>
		<th data-options="field:'fplId',hidden:true"></th>
		<th data-options="field:'fpId',hidden:true"></th>
		<th data-options="field:'fpurCode',hidden:true"></th>
		<th data-options="field:'fIsImp',hidden:true"></th>
		<th data-options="field:'fSiteAndPeriod',hidden:true"></th>
		<th data-options="field:'fManager',hidden:true"></th>
		<th data-options="field:'fIfEdit',hidden:true"></th>
		<th data-options="field:'fpurName',align:'center',width:154">商品名称</th>
		<th data-options="field:'fpurBrand',align:'center',width:154,editor:'textbox'">品牌</th>
		<th data-options="field:'fModel',align:'center',width:154,editor:'textbox'">型号</th>
		<th data-options="field:'fspec',align:'center',width:154,editor:'textbox'">规格</th>
		<th data-options="field:'fnum',align:'center',width:70,editor:{type:'numberbox',options:{required:true,onChange:setFnumCG}}">数量</th>
		<th data-options="field:'fmeasureUnit',align:'center',width:70">单位</th>
		<th data-options="field:'funitPrice',align:'center',width:110,editor:{type:'numberbox',options:{required:true,editable: false}}">单价(元)</th>
		<th data-options="field:'fsumMoney',align:'center',width:110,editor:{type:'numberbox',options:{required:true,precision:2,onChange:setFsumMoneyCG}}">金额(元)</th>
	</tr>
</thead>
</table>
<input type="hidden" id="mingxiJson" name="mingxi"/>
<script type="text/javascript">

//明细表格添加删除，保存方法
var editIndexContract = undefined;
function endEditingContract() {
	if (editIndexContract == undefined) {
		return true;
	}
	if ($('#plan_contract_dg').datagrid('validateRow', editIndexContract)) {
		var ed = $('#plan_contract_dg').datagrid('getEditor', {
			index : editIndexContract,
			field : 'costDetail'
		});
		$('#plan_contract_dg').datagrid('endEdit', editIndexContract);
		editIndexContract = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowContract(index) {
	if(flag!=0){
		if (editIndexContract != index) {
			if (endEditingContract()) {
				$('#plan_contract_dg').datagrid('selectRow', index).datagrid('beginEdit', index);
				editIndexContract = index;
			} else {
				$('#plan_contract_dg').datagrid('selectRow', editIndexContract);
			}
		}	
	}
}
function acceptContract() {
	if (endEditingContract()) {
		$('#plan_contract_dg').datagrid('acceptChanges');
	}
}

function contractJsons(){
	acceptContract();
	var rows2 = $('#plan_contract_dg').datagrid('getRows');
	var receiveJson = "";
	if(rows2==''){
		return false;
	}else{
		for (var i = 0; i < rows2.length; i++) {
			receiveJson = receiveJson + JSON.stringify(rows2[i]) + ",";
		}
		/* 
		for (var j = 0; j < rows2.length; j++) {
			if(rows2[j].fpurBrand=='' || rows2[j].fModel=='' || rows2[j].fspec==''){
				return false;
			}
		} */
		$('#mingxiJson').val(receiveJson);
		return true;
	}
}

function onLoadSuccessAmount(){
	var rows2 = $('#plan_contract_dg').datagrid('getRows');
	for (var j = 0; j < rows2.length; j++) {
		flag = rows2[j].fIfEdit;
	}
}

var flag = 0;
function queryCGMX(id){
	acceptContract();
	editIndexContract == undefined;
	var cg = $('#plan_contract_dg').datagrid('getRows');
	for(var i = cg.length-1 ; i >= 0 ; i--){
		$('#plan_contract_dg').datagrid('deleteRow',i);
	}
	$.ajax({
		   type : "post",
		   url : "${base}/Formulation/registerOrApplymingxi?id="+id,
		   dataType: 'json',  
		   async: false,
		   success : function(data){
			   for (var i = 0; i < data.length; i++) {
				   flag = data[i].fIfEdit;
				   $('#plan_contract_dg').datagrid('appendRow', {
					   mainId: data[i].mainId,
					   fplId: data[i].fplId,
					   fpurCode: data[i].fpurCode,
					   fIsImp: data[i].fIsImp,
					   fSiteAndPeriod: data[i].fSiteAndPeriod,
					   fManager: data[i].fManager,
					   fpurName: data[i].fpurName,
					   fpurBrand: data[i].fpurBrand,
					   fmeasureUnit: data[i].fmeasureUnit,
					   fModel: data[i].fModel,
					   fspec: data[i].fspec,
					   fnum: data[i].fnum,
					   funitPrice: data[i].funitPrice,
					   fsumMoney: data[i].fsumMoney,
					   fIfEdit: data[i].fIfEdit
					});
				}
			   $.messager.progress('close');
		   }
	   });
}

function setFnumCG(newVal,oldVal){
	var row = $('#plan_contract_dg').datagrid('getSelected');//获得选择行
	var index=$('#plan_contract_dg').datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $('#plan_contract_dg').datagrid('getEditors', index);
	var fsumMoney= parseFloat(tr[5].target.numberbox('getValue'));
	//var funitPrice= isNaN(parseFloat(row.funitPrice))?0:parseFloat(row.funitPrice);
	var fnum =isNaN(parseInt(newVal))?0:parseInt(newVal);
	if(isNaN(fsumMoney)){
		fsumMoney=0;
		tr[4].target.numberbox('setValue',0);
	}else{
		tr[4].target.numberbox('setValue',fsumMoney/fnum);
	}
}
function setFsumMoneyCG(newVal,oldVal){
	var row = $('#plan_contract_dg').datagrid('getSelected');//获得选择行
	var index=$('#plan_contract_dg').datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $('#plan_contract_dg').datagrid('getEditors', index);
	var fnum = parseFloat(tr[3].target.numberbox('getValue'));
	var fsumMoney=isNaN(parseInt(newVal))?0:parseInt(newVal);
	if(isNaN(fnum)){
		fnum=0;
		tr[4].target.numberbox('setValue',0);
	}else{
		tr[4].target.numberbox('setValue',fsumMoney/fnum);
	}
		
	var fcAmount = 0;
	var fsumMoney = 0;
	var indexS=$('#plan_contract_dg').datagrid('getRowIndex',$('#plan_contract_dg').datagrid('getSelected'));
	var rowsS = $('#plan_contract_dg').datagrid('getRows');
	for(var i=0;i<rowsS.length;i++){
		if(i==indexS){
			fsumMoney=parseFloat(newVal);
		}else{
			fcAmount+=addNumCG(rowsS,i);
		}  
	 
	}
	fcAmount=(parseFloat(fcAmount)+parseFloat(fsumMoney));
	$('#F_fcAmount').numberbox('setValue',fcAmount);
}
//未编辑或者已经编辑完毕的行
function addNumCG(rows,index){
	var amount=rows[index]['fsumMoney'];
	return parseFloat(amount); 
}
</script>