<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table id="dg" class="easyui-datagrid" style="width:660px;height:auto"
data-options="
singleSelect: true,
toolbar: '#tb',
rownumbers : true,
 <c:if test="${empty bean.fplId}">
url: '',
</c:if>
<c:if test="${!empty bean.fplId}">
url: '${base}/cgconfplan/mingxi?id=${bean.fplId}',
</c:if>
method: 'post',
onClickRow: onClickRow
">

</table>
<div id="tb" style="height:30px">
	<a style="color: red;">配置计划总额：</a><input style="width: 100px;" id="totalPrice" name="ffinalPrice"  class="easyui-numberbox"  readonly="readonly" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]"/>
	(填写配置计划清单后自动计算)
	<a href="javascript:void(0)" onclick="removeit()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<a style="float: right;">&nbsp;&nbsp;</a>
	<a href="javascript:void(0)" onclick="append()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
</div>
<input type="hidden" id="mingxiJson" name="mingxi"/>
<script type="text/javascript">
//加载完以后自动计算金额
$('#dg').datagrid({
	onLoadSuccess : function(data){
		setFsumMoney();
	}
});

//填写清单信息   设置列固定  左右滚动
$('#dg').datagrid({
	frozenColumns: [[
                	 {field:'mainId', title:'主ID', width:100, hidden:true},
                	 {field:'fplId', title:'外键ID', width:100, hidden:true},
                	 {field:'fpId', title:'外键ID', width:100, hidden:true}
           		   ]],
	columns:[[
			  {field:'fpurName', title:'采购名称', align:'center', width:100, editor:'textbox'},
			  {field:'fmeasureUnit', title:'计量单位', align:'center', width:70, editor:'textbox'},
			  {field:'fpurBrand', title:'采购品牌',align:'center', width:100, editor:'textbox'},
			  {field:'fspecifModel', title:'规格型号', align:'center',  width:100, editor:'textbox'},
			  {field:'fnum', title:'采购数量', width:100, align:'center', editor:{type:'numberbox', options:{onChange:setFsumMoney}}},
			  {field:'funitPrice', title:'单价[元]', align:'center', width:100, editor:{type:'numberbox', options:{precision:2, onChange:setFsumMoney}}},
			  {field:'fsumMoney', title:'金额[元]', align:'center', width:100, editor:{type:'numberbox', options:{precision:2, readonly:true}}},
/* 			  {field:'fneedTime', title:'需求时间', align:'center', width:100, editor:'datebox', formatter:ChangeDateFormat},//特殊时间格式化！！！！ */
			  {field:'fcommProp', title:'商品属性', align:'center', width:100, editor:'textbox'}
			]]

}); 
//明细表格添加删除，保存方法
var editIndex = undefined;
function endEditing() {
	if (editIndex == undefined) {
		return true;
	}
	if ($('#dg').datagrid('validateRow', editIndex)) {
		var ed = $('#dg').datagrid('getEditor', {
			index : editIndex,
			field : 'costDetail'
		});
		$('#dg').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow(index) {
	if (editIndex != index) {
		if (endEditing()) {
			$('#dg').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndex = index;
		} else {
			$('#dg').datagrid('selectRow', editIndex);
		}
	}
}
function append() {//未配置采购类型不可添加采购清单
	var fprocurType = $('#F_fprocurType').combobox('getValue'); 
	if(fprocurType == "0"){
		alert("请采购类型");
	}else {
		 if (endEditing()) {
				$('#dg').datagrid('appendRow', {
					status : 'P'
				});
				editIndex = $('#dg').datagrid('getRows').length - 1;
				$('#dg').datagrid('selectRow', editIndex).datagrid('beginEdit',
						editIndex);
			} 
	} 
	//页面随滚动条置底
	/* var div = document.getElementById('westDiv');
	div.scrollTop = div.scrollHeight; */
}
function removeit() {
	if (editIndex == undefined) {
		return
	}
	$('#dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
			editIndex);
	editIndex = undefined;
}

function accept() {
	if (endEditing()) {
		$('#dg').datagrid('acceptChanges');
	}
}


//计算配置计划总额
function setFsumMoney(newValue,oldValue) {
	var totalFsumMoney = 0;
	var fsumMoney = 0;
	var index=$('#dg').datagrid('getRowIndex',$('#dg').datagrid('getSelected'));
	var rows = $('#dg').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		if(i==index){
			fsumMoney=setEditing(rows,i);
		}else{
			totalFsumMoney+=addNum(rows,i);
		}  
	 
	}
	totalFsumMoney=totalFsumMoney+fsumMoney;
	$('#totalPrice').textbox('setValue',totalFsumMoney.toFixed(2));
	
	//根据上报阶段设置申报金额
	var freportStage = $('#cgconfplan_list_freportStage').val();
	if(freportStage == 1){
		$('#F_purFirstAmount').numberbox('setValue',totalFsumMoney.toFixed(2));
	}else if(freportStage == 2){
		$('#F_purSecondAmount').numberbox('setValue',totalFsumMoney.toFixed(2));
	}
}
//未编辑或者已经编辑完毕的行，计算优惠后总价
function addNum(rows,index){
	var totalPrice=0;
	var fnum=rows[index]['fnum'];
	var funitPrice=rows[index]['funitPrice'];
	if(fnum!="" && fnum!=null && funitPrice!="" && funitPrice!=null){
		totalPrice= parseFloat(fnum)*(parseFloat(funitPrice));
	}
	return totalPrice;
}
//对于正在编辑的行，计算优惠后总价
function setEditing(rows,index){
    var editors = $('#dg').datagrid('getEditors', index);  
    var fnum = editors[4]; 
    var funitPrice = editors[5];   
    var fsumMoney = editors[6];
    var totalPrice = (fnum.target.val())*(funitPrice.target.val());		
    fsumMoney.target.numberbox('setValue', totalPrice);    
    return totalPrice;
}
//存入json
function getMingxiJson(){
	accept();
	var rows = $('#dg').datagrid('getRows');
	var mingxi = '';
	for (var i = 0; i < rows.length; i++) {
		mingxi = mingxi + JSON.stringify(rows[i]) + ',';
	}
	$('#mingxiJson').val(mingxi);
}
</script>