<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-table" style="margin-bottom:10px">
<table id="course_gys_dg" class="easyui-datagrid" style="margin-top: 10px;width:695px;height:auto;"
data-options="
singleSelect: true,
toolbar: '#course_gys_tb',
rownumbers : true,
striped:true,
<c:if test="${!empty br.fbId}">
url: '${base}/cgprocess/tenderingmingxi?id=${br.fbId}',
</c:if>
<c:if test="${empty br.fbId}">
url: '${base}/cgsqsp/mingxi?id=${bean.fpId}',
</c:if>
method: 'post',
onClickRow: onClickRow
">
<thead>
	<tr>
		<th data-options="field:'mainId',hidden:true"></th>
		<th data-options="field:'fplId',hidden:true"></th>
		<th data-options="field:'fpurCode',hidden:true"></th>
		<th data-options="field:'fpurName',align:'center',width:154,editor:{type:'textbox',options:{required:true}}">商品名称</th>
		<th data-options="field:'fpurBrand',align:'center',width:154,editor:{type:'textbox',options:{required:true}}">品牌</th>
		<th data-options="field:'fModel',align:'center',width:154,editor:{type:'textbox',options:{required:true}}">型号</th>
		<th data-options="field:'fspec',align:'center',width:154,editor:{type:'textbox',options:{required:true}}">规格</th>
		<th data-options="field:'fnum',align:'center',width:70,editor:{type:'numberbox',options:{readonly:true,required:true}}">数量</th>
		<th data-options="field:'funitPrice',align:'center',width:110,editor:{type:'numberbox',options:{precision:2,readonly:true}}">单价(元)</th>
		<th data-options="field:'fsumMoney',align:'center',width:110,editor:{type:'numberbox',options:{precision:2,required:true,onChange:setFunitPrice}}">中标金额(元)</th>
		<th data-options="field:'fcommProp',align:'center',width:190,editor:'textbox'">备注</th>
	</tr>
</thead>
</table>
<div id="course_gys_tb" style="height:30px;margin-bottom: 5px;">
	<a style="color: red;">小计金额：</a><input style="width: 100px;" id="totalPrice" name="ffinalPrice"  class="easyui-numberbox"  readonly="readonly" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]"/>
	<c:if test="${openType=='add'||openType=='edit' }">
		<a href="javascript:void(0)" onclick="course_gys_removeit()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="course_gys_append()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</c:if>
</div>
<input type="hidden" id="mingxiJson" name="mingxi"/>
</div>
<script type="text/javascript">
//加载完以后自动计算金额
$('#course_gys_dg').datagrid({onLoadSuccess : function(data){
	setFunitPrice();
}});

//明细表格添加删除，保存方法
var editIndex = undefined;
function endEditing() {
	if (editIndex == undefined) {
		return true;
	}
	if ($('#course_gys_dg').datagrid('validateRow', editIndex)) {
		var ed = $('#course_gys_dg').datagrid('getEditor', {
			index : editIndex,
			field : 'costDetail'
		});
		$('#course_gys_dg').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow(index) {
	if (editIndex != index) {
		if (endEditing()) {
			$('#course_gys_dg').datagrid('selectRow', index).datagrid('beginEdit', index);
			editIndex = index;
		} else {
			$('#course_gys_dg').datagrid('selectRow', editIndex);
		}
	}
}
function course_gys_append() {//未配置采购类型不可添加采购清单
	if (endEditing()) {
		$('#course_gys_dg').datagrid('appendRow', {});
		editIndex = $('#course_gys_dg').datagrid('getRows').length - 1;
		$('#course_gys_dg').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
	} 
	document.getElementById('#cgqddiv').scrollIntoView();
}
function course_gys_removeit() {
	if (editIndex == undefined) {
		return;
	}
	$('#course_gys_dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
			editIndex);
	editIndex = undefined;
	//修改申请总额
	setFunitPrice(0,0);
}
function accept() {
	if (endEditing()) {
		$('#course_gys_dg').datagrid('acceptChanges');
	}
}
//计算总额
function setFunitPrice(newValue,oldValue) {
	var totalFsumMoney = 0;
	var fsumMoney = 0;
	var index=$('#course_gys_dg').datagrid('getRowIndex',$('#course_gys_dg').datagrid('getSelected'));
	var rows = $('#course_gys_dg').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		if(i==index){
			totalFsumMoney+=parseFloat(newValue);
		}else{
			totalFsumMoney+=parseFloat(rows[i].fsumMoney);
		}  
	}
	var ed = $('#course_gys_dg').datagrid('getEditor', {index:index,field:'funitPrice'});
	if(index!=-1){
		$(ed.target).numberbox('setValue', newValue/rows[index].fnum);
	}
	$('#totalPrice').numberbox('setValue',totalFsumMoney.toFixed(2));
	$('#F_fbidAmount').numberbox('setValue',totalFsumMoney.toFixed(2));
}
//未编辑或者已经编辑完毕的行，计算优惠后总价
function addNum(rows,index){
	var totalPrice=0;
	var fnum=rows[index]['fnum'];
	var funitPrice=rows[index]['funitPrice'];
	if(fnum!='' && fnum!=null && funitPrice!='' && funitPrice!=null){
		totalPrice= parseFloat(fnum)*(parseFloat(funitPrice));
	}
	return totalPrice;
}
//对于正在编辑的行，计算优惠后总价
function setEditing(rows,index){
    var editors = $('#course_gys_dg').datagrid('getEditors', index);  
    var fnum = editors[1]; 
    var funitPrice = editors[2];   
    var fsumMoney = editors[3];
    var totalPrice = (fnum.target.val())*(funitPrice.target.val());		
    fsumMoney.target.numberbox('setValue',totalPrice);    
    return totalPrice;
}
//获得json数据
function getcourseinfoJson(){
	$('#course_gys_dg').datagrid('acceptChanges');
	var rows = $('#course_gys_dg').datagrid('getRows');
	var entities= '';
	for(var i = 0 ;i < rows.length;i++){
		entities = entities  + JSON.stringify(rows[i]) + ',';  
	}
	$("#mingxiJson").val(entities);
}	
</script>