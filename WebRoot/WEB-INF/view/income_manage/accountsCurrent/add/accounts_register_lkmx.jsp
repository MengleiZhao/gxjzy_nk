<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!-- 其他费用 -->
<div class="window-tab" style="margin-left: 0px;padding-top: 0px;">
	<table id="register_tab_id" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	<c:if test="${operation!='add'}">
	url: '${base}/accountsRegister/registerMX?id=${bean.fMSId}&type=2',
	</c:if>
	<c:if test="${operation=='add'}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${operation!='detail' && operation!='check'}">
	onClickRow: onClickRowRegister, 
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'frId',hidden:true"></th>
				<th data-options="field:'fMSId',hidden:true"></th>
				<th data-options="field:'oppositeUnit',align:'center',width:195,editor:{type:'textbox',options:{required:true}}">对方单位名称</th>
				<th data-options="field:'planMoney',align:'center',width:191,editor:{type:'numberbox',options:{required:true,onChange:onChangeMoney,precision:2,groupSeparator:','}}">金额（元）</th>
				<th data-options="field:'planTime',required:'true',width:140,align:'center',editor:{type:'datebox', options:{required:true,editable:false}}">预计来款日期</th>
				<th data-options="field:'invoiceKindShow',width:150, editor:{
                 type:'combobox',
                 options:{
                 	required:true,
                 	editable:false,
                 	<!-- validType:'selectValid', -->
                     valueField:'code',
                     textField:'text',
                     multiple: false,
                     url:base+'/Formulation/lookupsJson?parentCode=KPZL',
                     onHidePanel:invoiceKindSetCode
                 }}">开票种类</th>
				<th data-options="field:'invoiceKind',align:'center',width:195,hidden:true,editor:{type:'textbox'}"></th>
			</tr>
		</thead>
	</table>
	<%-- <div id="register_id" style="height:20px;">
		<a href="javascript:void(0)" onclick="removeit2()" id="otherRemoveitId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="append2()" id="otherAppendId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div> --%>
</div>
<input type="hidden" id="registerJson" name="registerJson"/>
<script type="text/javascript">
//接待人员表格添加删除，保存方法
var editIndexRegister = undefined;
function endEditingRegister() {
	if (editIndexRegister == undefined) {
		return true;
	}
	if ($('#register_tab_id').datagrid('validateRow', editIndexRegister)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#register_tab_id').datagrid('getEditors', editIndexRegister);
		var text3=tr[3].target.combobox('getText');
		if(text3!='--请选择--'){
			tr[3].target.combobox('setValue',text3);
		}
		$('#register_tab_id').datagrid('endEdit', editIndexRegister);
		editIndexRegister = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowRegister(index) {
	if (editIndexRegister != index) {
		if (endEditingRegister()) {
			var rows = $('#register_tab_id').datagrid('getRows');
			var index=$('#register_tab_id').datagrid('getRowIndex',$('#register_tab_id').datagrid('getSelected'));
		     if(rows[index].fCostName!='市内交通费' && rows[index].fCostName!='伙食补助费'){
				$('#register_tab_id').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndexRegister = index;
		     }
		} else {
			$('#register_tab_id').datagrid('selectRow', editIndexRegister);
		}
	}
}
function appendRegister() {
	if (endEditingRegister()) {
		$('#register_tab_id').datagrid('appendRow', {});
		editIndexRegister = $('#register_tab_id').datagrid('getRows').length - 1;
		$('#register_tab_id').datagrid('selectRow', editIndexRegister).datagrid('beginEdit',editIndexRegister);
	}
}
function removeitRegister() {
	if (editIndexRegister == undefined) {
		return
	}
	$('#register_tab_id').datagrid('cancelEdit', editIndexRegister).datagrid('deleteRow',
			editIndexRegister);
	editIndexRegister = undefined;
}
function acceptRegister() {
	if (endEditingRegister()) {
		$('#register_tab_id').datagrid('acceptChanges');
	}
}

function getRegisterJson(){
	acceptRegister();
	var rows3 = $('#register_tab_id').datagrid('getRows');
	var registerJson = "";
	var lkmxFlag = true;
	for (var y = 0; y < rows3.length; y++) {
		if(!(isNotEmpty(rows3[y].oppositeUnit) && isNotEmpty(rows3[y].planMoney) && isNotEmpty(rows3[y].planTime) && isNotEmpty(rows3[y].invoiceKindShow))){
			lkmxFlag = false;
			break;
		}
	}
	for (var i = 0; i < rows3.length; i++) {
		registerJson = registerJson + JSON.stringify(rows3[i]) + ",";
	}
	$('#registerJson').val(registerJson);
	return lkmxFlag;
}

function invoiceKindSetCode(){
	var index=$('#register_tab_id').datagrid('getRowIndex',$('#register_tab_id').datagrid('getSelected'));
	var invoiceKind = $('#register_tab_id').datagrid('getEditor',{
		index:index,
		field:'invoiceKind'
	});
	var invoiceKindShow = $('#register_tab_id').datagrid('getEditor',{
		index:index,
		field:'invoiceKindShow'
	});
	$(invoiceKind.target).textbox('setValue', $(invoiceKindShow.target).combobox('getValues'));
}
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

function onChangeMoney(newVal,oldVal){
	$('#registerMoney').val(newVal);
}
</script>