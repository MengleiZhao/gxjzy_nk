<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-top:10px;padding-top: 0px;margin-left: 0px;">
	<c:if test="${empty detail}">
		<div style="margin-right:0px;float:right">
			<a href="javascript:void(0)" onclick="saveAbroadPerson()" id="saveAbroadPerson" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
			<a style="float: right;">&nbsp;&nbsp;</a>
			<a href="javascript:void(0)" onclick="editAbroadPerson()" id="editAbroadPerson" hidden="hidden" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/xg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
			<a style="float: right;">&nbsp;&nbsp;</a>
			<a href="javascript:void(0)" onclick="removeitPerson1()" id="removeitPerson1" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
			<a style="float: right;">&nbsp;&nbsp;</a>
			<a href="javascript:void(0)" onclick="appendPerson1()" id="appendPerson1"  style="float: right; "><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		</div>
	</c:if>
	<table id="abroad-person-dg" class="easyui-datagrid" style="width:707px;height:auto;"
	data-options="
	toolbar: '#dmp',
	<c:if test="${!empty abroad.faId}">
	url: '${base}/apply/abroadPeople?id=${abroad.faId}',
	</c:if>
	<c:if test="${empty abroad.faId}">
	url: '',
	</c:if>
	<c:if test="${empty detail}">
	onClickRow: onClickRowPerson1,
	</c:if>
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
	<thead>
		<tr>
			<th data-options="field:'frId',hidden:true"></th>			
			<th data-options="field:'travelPeopName',align:'center',width:100,editor:{type:'textbox',options:{editable:false,icons:[{iconCls:'icon-add',handler: function(e){
									     var row = $('#abroad-person-dg').datagrid('getSelected');
									     var index = $('#abroad-person-dg').datagrid('getRowIndex',row);
									     choosePeop(index)
									     }}]}}">姓名</th>
			<th data-options="field:'idCard',align:'center',width:140,editor:{type:'textbox'}">身份证号</th>
			<th data-options="field:'fPassport',align:'center',width:140,editor:{type:'textbox'}">护照号</th>
			<th data-options="field:'position',align:'center',width:140,editor:{type:'textbox',options:{editable: false}}">职务</th>
			<th data-options="field:'phoneNum',align:'center',width:140,editor:{type:'textbox'}">联系方式</th>
			<th data-options="field:'travelPeopId',required:'required',hidden:true,editor:{type:'textbox',options:{editable: false}}"></th>
			<th data-options="field:'travelPersonnelLevel',required:'required',hidden:true,editor:{type:'textbox',options:{editable: true}}"></th>
		</tr>
	</thead>
</table>
</div>

<script type="text/javascript">
var flag =0;
var gId = '${bean.gId}';

if(gId!=''){
	$("#editAbroadPerson").show();
	$("#removeitPerson1").hide();
	$("#appendPerson1").hide();
	$("#saveAbroadPerson").hide();
	$("#removeWayId").show();
	$("#appendWayId").show();
	flag=1;
}

function editAbroadPerson(){
	$("#editAbroadPerson").hide();
	$("#removeitPerson1").show();
	$("#appendPerson1").show();
	$("#saveAbroadPerson").show();
	$("#removeWayId").hide();
	$("#appendWayId").hide();
	flag=0;

}
function saveAbroadPerson(){
	acceptPerson1();
	var rows = $('#abroad-person-dg').datagrid('getRows');
	if(rows==''){
		alert("请添加出国人员信息！");
		return false;
	}
	for(var i=0;i<rows.length;i++){
		if(rows[i].travelPeopName==''){
			alert("请填写出国人员信息上的姓名！");
			return false;
		}
		if(rows[i].idCard==''){
			alert("请填写出国人员信息上的身份证号！");
			return false;
		}
		if(rows[i].fPassport==''){
			alert("请填写出国人员信息上的护照号！");
			return false;
		}
		if(rows[i].phoneNum==''){
			alert("请填写出国人员信息上的联系方式！");
			return false;
		}
	}
	peopleArray();
	$("#editAbroadPerson").show();
	$("#removeitPerson1").hide();
	$("#appendPerson1").hide();
	$("#saveAbroadPerson").hide();
	$("#removeWayId").show();
	$("#appendWayId").show();
	flag=1;
}
	
function appendPerson1() {
	if (endEditingPerson1()) {
		$('#abroad-person-dg').datagrid('appendRow', {});
		editIndexPerson1 = $('#abroad-person-dg').datagrid('getRows').length - 1;
		$('#abroad-person-dg').datagrid('selectRow', editIndexPerson1).datagrid('beginEdit',editIndexPerson1);
	}
	/* var win = creatFirstWin('选择-人员', 640, 580, 'icon-search', '/apply/chooseUser?editType=abroad&tabId=apply_abroadtab');
	win.window('open'); */
}
	
//选择人员
function choosePeop(index) {
	var win = creatFirstWin('选择-人员', 640, 580, 'icon-search', '/apply/chooseUser?index='+index+'&editType=abroad&tabId=abroad-person-dg');
	win.window('open');

}	
function removeitPerson1() {
	if (editIndexPerson1 == undefined) {
		return
	}
	$('#abroad-person-dg').datagrid('cancelEdit', editIndexPerson1).datagrid('deleteRow',
			editIndexPerson1);
	editIndexPerson1 = undefined;
	peopleArray();
}
var editIndexPerson1 = undefined;
function endEditingPerson1() {
	if (editIndexPerson1 == undefined) {
		return true;
	}
	if ($('#abroad-person-dg').datagrid('validateRow', editIndexPerson1)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		$('#abroad-person-dg').datagrid('endEdit', editIndexPerson1);
		$('#abroad-person-dg').datagrid('unselectRow', editIndexPerson1);
		editIndexPerson1 = undefined;
		return true;
	} else {
		return false;
	}
}	

function onClickRowPerson1(index) {
	if(flag==1){
		return false;
	}
	if (editIndexPerson1 != index) {
		if (endEditingPerson1()) {
			$('#abroad-person-dg').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndexPerson1 = index;
		} else {
			$('#abroad-person-dg').datagrid('selectRow', editIndexPerson1);
		}
	}
}

function acceptPerson1() {
	if (endEditingPerson1()) {
		$('#abroad-person-dg').datagrid('acceptChanges');
	}
}

function peopleArray(){
	peopleArr =new Array();
	var rows1 = $('#abroad-person-dg').datagrid('getRows');
	for (var i = 0; i < rows1.length; i++) {
		var people ={};
		people.id=rows1[i].travelPeopName;
		people.text=rows1[i].travelPeopName;
		people.userId=rows1[i].travelPeopId;
		peopleArr.push(people);
	}
}
function abroadPersonJson(){
	acceptPerson1();
	var rows1 = $('#abroad-person-dg').datagrid('getRows');
	var abroadPeople = "";
	for (var i = 0; i < rows1.length; i++) {
		abroadPeople = abroadPeople + JSON.stringify(rows1[i]) + ",";
	}
	$('#abroadPeople').val(abroadPeople);
}
</script>