<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<table id="plan_dg" class="easyui-datagrid" style="width:700px;height:auto"
data-options="
singleSelect: true,
toolbar: '#tb',
rownumbers : true,
striped:true,
 <c:if test="${empty bean.fpId}">
url: '',
</c:if>
<c:if test="${!empty bean.fpId}">
url: '${base}/cgsqsp/mingxi?id=${bean.fpId}',
</c:if>
method: 'post',
<c:if test="${openType=='add'||openType=='edit' }">
onClickRow: onClickRow
</c:if>
">
<thead>
	<tr>
		<th data-options="field:'mainId',hidden:true"></th>
		<th data-options="field:'fplId',hidden:true"></th>
		<th data-options="field:'fpurCode',hidden:true"></th>
		<th data-options="field:'fpurName',align:'center',width:154,editor:'textbox'">货物或服务名称</th>
		<th data-options="field:'fnum',align:'center',width:70,editor:{type:'numberbox',options:{onChange:setFsumMoney}}">数量</th>
		<th data-options="field:'fmeasureUnit',align:'center',width:70,editor:'textbox'">单位</th>
		<th data-options="field:'funitPrice',align:'center',width:110,editor:{type:'numberbox',options:{precision:2,onChange:setFsumMoney}}">单价[元]</th>
		<th data-options="field:'fsumMoney',align:'center',width:110,editor:{type:'numberbox',options:{precision:2,readonly:true}}">预算金额[元]</th>
		<th data-options="field:'fIsImp',align:'center',width:110,editor:{type:'combobox',options:{valueField:'id',textField:'text',data:[
	                	{id:'1',text:'是'},
	                	{id:'0',text:'否'}],
	                	prompt:'-请选择-',panelHeight:'atuo',editable: false,onChange:judgeIsImp}},formatter:isorno">进口产品</th>
		<th data-options="field:'fIsArgument',align:'center',width:110,editor:{type:'combobox',options:{valueField:'id',textField:'text',data:[
	                	{id:'1',text:'是'},
	                	{id:'0',text:'否'}],
	                	prompt:'-请选择-',panelHeight:'atuo',editable: false}},formatter:isornoArgument">是否论证</th>
		<th data-options="field:'fSiteAndPeriod',align:'center',width:190,editor:'textbox'">安装使用地点服务周期</th>
		<th data-options="field:'fManager',align:'center',width:110,editor:'textbox'">负责人</th>
	</tr>
</thead>
</table>
<div id="tb" style="height:30px;margin-bottom:5px;margin-top:5px" >
	<a style="color: red;">申请总额：</a><input style="width: 100px;" id="totalPrice" name="ffinalPrice"  class="easyui-numberbox"  readonly="readonly" data-options="precision:2,icons: [{iconCls:'icon-yuan'}]"/>
	<c:if test="${openType=='add'||openType=='edit' }">
		<a href="javascript:void(0)" onclick="removeit()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="append()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</c:if>
</div>
<input type="hidden" id="mingxiJson" name="mingxi"/>
<script type="text/javascript">
//加载完以后自动计算金额
$('#plan_dg').datagrid({onLoadSuccess : function(data){
	setFsumMoney();
}});

//明细表格添加删除，保存方法
var editIndex = undefined;
function endEditing() {
	if (editIndex == undefined) {
		return true;
	}
	if ($('#plan_dg').datagrid('validateRow', editIndex)) {
		$('#plan_dg').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow(index) {
	if (editIndex != index) {
		if (endEditing()) {
			$('#plan_dg').datagrid('selectRow', index).datagrid('beginEdit', index);
			editIndex = index;
		} else {
			$('#plan_dg').datagrid('selectRow', editIndex);
		}
	}
}
function append() {//未配置采购类型不可添加采购清单
	if (endEditing()) {
		$('#plan_dg').datagrid('appendRow', {});
		editIndex = $('#plan_dg').datagrid('getRows').length - 1;
		$('#plan_dg').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
	} 
}
function removeit() {
	if (editIndex == undefined) {
		return;
	}
	$('#plan_dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
			editIndex);
	editIndex = undefined;
	//修改申请总额
	setFsumMoney(0,0);
}
function accept() {
	if (endEditing()) {
		$('#plan_dg').datagrid('acceptChanges');
	}
}
//计算总额
function setFsumMoney(newValue,oldValue) {
	var totalFsumMoney = 0;
	var fsumMoney = 0;
	var index=$('#plan_dg').datagrid('getRowIndex',$('#plan_dg').datagrid('getSelected'));
	var rows = $('#plan_dg').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		if(i==index){
			fsumMoney=setEditing(rows,i);
		}else{
			totalFsumMoney+=addNum(rows,i);
		}  
	}
	totalFsumMoney=totalFsumMoney+fsumMoney;
	$('#totalPrice').textbox('setValue',totalFsumMoney.toFixed(2));
	$('#fpAmount').val(totalFsumMoney.toFixed(2));
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
    var editors = $('#plan_dg').datagrid('getEditors', index);  
    var fnum = editors[1]; 
    var funitPrice = editors[3];   
    var fsumMoney = editors[4];
    var totalPrice = (fnum.target.val())*(funitPrice.target.val());		
    fsumMoney.target.numberbox('setValue',totalPrice);    
    return totalPrice;
}
function isorno(val){
	if(val=='1'){
		return '是';
	}else if(val=='0'){
		return '否';
	}else{
		return val;
	}
}
function isornoArgument(val){
	if(val=='1'){
		return '是';
	}else if(val=='0'){
		return '否';
	}else{
		return val;
	}
}
function judgeIsImp(n,o){
	var index=$('#plan_dg').datagrid('getRowIndex',$('#plan_dg').datagrid('getSelected'));
	var ed = $('#plan_dg').datagrid('getEditor',{
		index:index,
		field:'fIsImp'
	});
	var isImp = $('input[name="fIsImp"]:checked').val();
		if(isImp==0&&n==1){
			alert("进口商品信息冲突");
			//ed.target.combobox(setValue,'');
			ed.target.combobox('setValues', ['','']);
		}
}
</script>