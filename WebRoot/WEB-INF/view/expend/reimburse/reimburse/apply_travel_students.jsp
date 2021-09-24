<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="reim_tracel_students_tab_id" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#students_toolbar_Id',
	<c:if test="${operation=='add'}">
	url: '${base}/apply/applyStudentsPage?gId=${applyBean.gId}',
	</c:if>
	<c:if test="${operation!='add'}">
	url: '${base}/reimburse/reimbStudents?id=${bean.rId}',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRowStudentsReim,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'ftsId',hidden:true"></th>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'rId',hidden:true"></th>
				<th data-options="field:'fName',width:120,align:'center',editor:{type:'textbox', options:{requerd:true}}">姓名</th>
				<th data-options="field:'fGender',width:150,align:'center',
					editor:{type:'combobox',options:{valueField:'id',textField:'text',data:[
	                	{id:'1',text:'男'},
	                	{id:'0',text:'女'}],
	                	prompt:'-请选择-',panelHeight:'atuo',editable: false}},formatter:isorno">性别</th>
				<th data-options="field:'fIdentityNumber',width:210,align:'center',editor:{type:'textbox', options:{requerd:true}}">身份证号</th>
				<th data-options="field:'fTel',width:190,align:'center',editor:{type:'numberbox', options:{requerd:true}}">联系电话</th>
			</tr>
		</thead>
	</table>
	<c:if test="${empty detail}">
	<div id="students_toolbar_Id" style="height:30px;padding-top : 8px">
		<a href="javascript:void(0)" onclick="editStudentsReim()" id="editStudentId" hidden="hidden" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/xg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a href="javascript:void(0)" onclick="addStudentsReim()" id="addStudentId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" id="removeStudentId" onclick="removeitStudentsReim()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" id="appendStudentId" onclick="appendStudentsReim()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
	</div>
	</c:if>
	<input type="hidden" id="hotelTotalDays"  />
	<input type="hidden" id="travelTotalDays"  />
	<input type="hidden" id="hotelTotalDays"  />
	<input type="hidden" id="studentsPeopJson" name="studentsJson" />
</div>
<script type="text/javascript">
var sign1 = 0;
function addStudentsReim(){
	acceptStudentsReim();
	var rows = $('#reim_tracel_students_tab_id').datagrid('getRows');
	if(rows==''){
		alert("请添加随行学生名单！");
		return false;
	}
	$("#editStudentId").show();
	$("#addStudentId").hide();
	$("#removeStudentId").hide();
	$("#appendStudentId").hide();
	$("#outsideRemoveitId").show();
	$("#outsideAppendId").show();
	$("#hotelRemoveId").show();
	$("#hotelAppendId").show();
	$("#rAddId").show();
	$("#rEditId").hide();
	$("#rrmoveid").show();
	$("#raddid").show();
	$("#removefoodId").hide();
	$("#appendfoodId").hide();
	$("#appendCityTrafficId").hide();
	$("#removeitCityTrafficId").hide();
	$("#routsideRemoveitId").hide();
	$("#routsideAppendId").hide();
	$("#rhotelRemoveId").hide();
	$("#rhotelAppendId").hide();
	sign1 =1;
}
function editStudentsReim(){
	sign1 = 0;
	$("#addStudentId").show();
	$("#removeStudentId").show();
	$("#appendStudentId").show();
	$("#editStudentId").hide();
	$("#outsideRemoveitId").hide();
	$("#outsideAppendId").hide();
	$("#hotelRemoveId").hide();
	$("#hotelAppendId").hide();
	$("#removefoodId").hide();
	$("#appendfoodId").hide();
	$("#appendCityTrafficId").hide();
	$("#removeitCityTrafficId").hide();
	$("#routsideRemoveitId").hide();
	$("#routsideAppendId").hide();
	$("#rhotelRemoveId").hide();
	$("#rhotelAppendId").hide();
	accepthotelReim();
	acceptOutsideTrafficReim();
	acceptfoodReim();
	acceptInCityReim();
}

//接待人员表格添加删除，保存方法
var editIndexStudentsReim = undefined;
function endEditingStudentsReim() {
	if (editIndexStudentsReim == undefined) {
		return true
	}
	if ($('#reim_tracel_students_tab_id').datagrid('validateRow', editIndexStudentsReim)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#reim_tracel_students_tab_id').datagrid('getEditors', editIndexStudentsReim);
		$('#reim_tracel_students_tab_id').datagrid('endEdit', editIndexStudentsReim);
		userdata();
		editIndexStudentsReim = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowStudentsReim(index) {
	
	if(sign1==0){
	if (editIndexStudentsReim != index) {
		if (endEditingStudentsReim()) {
			$('#reim_tracel_students_tab_id').datagrid('selectRow', index).datagrid('beginEdit',index);
			editIndexStudentsReim = index;
		} else {
			$('#reim_tracel_students_tab_id').datagrid('selectRow', editIndexStudentsReim);
		}
	}
	
	}else{
		alert("请先点击随行学生名单修改按钮！");
		return false;
	}
}
function appendStudentsReim() {
	if (endEditingStudentsReim()) {
		$('#reim_tracel_students_tab_id').datagrid('appendRow', {
		});
		editIndexStudentsReim = $('#reim_tracel_students_tab_id').datagrid('getRows').length - 1;
		$('#reim_tracel_students_tab_id').datagrid('selectRow', editIndexStudentsReim).datagrid('beginEdit',editIndexStudentsReim);
	}
}
function removeitStudentsReim() {
	if (editIndexStudentsReim == undefined) {
		return
	}
	$('#reim_tracel_students_tab_id').datagrid('cancelEdit', editIndexStudentsReim).datagrid('deleteRow',
			editIndexStudentsReim);
	editIndexStudentsReim = undefined;
	var rows = $('#reim_tracel_students_tab_id').datagrid('getRows');
	var travelDays=0;
	var hotelDays=0;
	for(var i=0;i<rows.length;i++){
		if(rows[i].travelDays!=""&&rows[i].travelDays!=null){
			travelDays += parseInt(rows[i].travelDays);
		}
		if(rows[i].hotelDays!=""&&rows[i].hotelDays!=null){
			hotelDays += parseInt(rows[i].hotelDays);
		}
	}
	$('#travelTotalDays').val(travelDays);
	$('#hotelTotalDays').val(hotelDays);
}
function acceptStudentsReim() {
	if (endEditingStudentsReim()) {
		$('#reim_tracel_students_tab_id').datagrid('acceptChanges');
	}
}
	
function studentsPeopJsonReim(){
	acceptStudentsReim();
	var rows2 = $('#reim_tracel_students_tab_id').datagrid('getRows');
	var studentsPeop = "";
	if(rows2==''){
		return false;
	}else{
		for (var i = 0; i < rows2.length; i++) {
			studentsPeop = studentsPeop + JSON.stringify(rows2[i]) + ",";
		}
		$('#studentsPeopJson').val(studentsPeop);
		return true;
	}
}


function isorno(val){
	if(val=='1'){
		return '男';
	}else if(val=='0'){
		return '女';
	}else{
		return '';
	}
}
</script>