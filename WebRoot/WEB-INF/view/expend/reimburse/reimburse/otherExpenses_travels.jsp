<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!-- 会务、培训 -->
<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">
	<table id="rec-others-dg-reim" class="easyui-datagrid" style="width:695px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#others_reim_id',
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/receptionOthers?gId=${applyBean.gId}&fType=2',
	</c:if>
	<c:if test="${!empty bean.rId && operation=='edit'}">
	url: '${base}/reimburse/receptionOthers?rId=${bean.rId}&fType=2',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRowsReim2, 
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'ffId',hidden:true"></th>
				<th data-options="field:'fCostStd',hidden:true"></th>
				<th data-options="field:'fType',hidden:true"></th>
				<th data-options="field:'fCostName',required:'required',align:'center',width:195">费用名称</th>
				<th data-options="field:'fTeacherCost',required:'required',align:'center',width:239,editor:{type:'numberbox',options:{onChange:addTeacherCosts,precision:2,groupSeparator:','}}">教师金额[元]</th>
				<th data-options="field:'fStudentCost',required:'required',align:'center',width:233,editor:{type:'numberbox',options:{onChange:addStudentCosts,precision:2,groupSeparator:','}}">学生金额[元]</th>
				<th data-options="field:'fCost',required:'required',align:'center',hidden:true,width:191,editor:{type:'numberbox',options:{onChange:addNumOthers,precision:2,groupSeparator:','}}">申请金额[元]</th>
			</tr>
		</thead>
	</table>
	<div id="others_reim_id" style="height:20px;">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">会务、培训费</a>
	</div>
</div>
<script type="text/javascript">
//接待人员表格添加删除，保存方法
var editIndexsReim2 = undefined;
function endEditingsReim2() {
	if (editIndexsReim2 == undefined) {
		return true;
	}
	if ($('#rec-others-dg-reim').datagrid('validateRow', editIndexsReim2)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		$('#rec-others-dg-reim').datagrid('endEdit', editIndexsReim2);
		editIndexsReim2 = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowsReim2(index) {
	if (editIndexsReim2 != index) {
		if (endEditingsReim2()) {
			$('#rec-others-dg-reim').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndexsReim2 = index;
		}
	}
}
function appends2() {
	if (endEditingsReim2()) {
		$('#rec-others-dg-reim').datagrid('appendRow', {});
		editIndexsReim2 = $('#rec-others-dg-reim').datagrid('getRows').length - 1;
		$('#rec-others-dg-reim').datagrid('selectRow', editIndexsReim2).datagrid('beginEdit',editIndexsReim2);
	}
}
function removeits2() {
	if (editIndexsReim2 == undefined) {
		return
	}
	$('#rec-others-dg-reim').datagrid('cancelEdit', editIndexsReim2).datagrid('deleteRow',
			editIndexsReim2);
	editIndexsReim2 = undefined;
}
function acceptsReim2() {
	if (endEditingsReim2()) {
		$('#rec-others-dg-reim').datagrid('acceptChanges');
	}
}

//计算金额
function addNumOthers(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	if(newVal==''){
		newVal=0.00;
	}
	var rows = $('#rec-others-dg-reim').datagrid('getRows');
	var index=$('#rec-others-dg-reim').datagrid('getRowIndex',$('#rec-others-dg-reim').datagrid('getSelected'));
     var num1 = 0;
     for(var i=0;i<rows.length;i++){
		if(i==index){
			num1+=parseFloat(newVal);
		}else{
			num1+=addNumsOthers(rows,i);
		}
	}
	$("#meetTrainAmount").val(num1.toFixed(2));
	allProIndexList();
}
function addNumsOthers(rows,index){
	var num=0;
	if(rows[index].fCost!=''&&rows[index].fCost!='NaN'&&rows[index].fCost!=undefined){
		num = parseFloat(rows[index].fCost);
	}else{
		num =0;
	}
	return num;
}

function onClickCellType(){
	var row = $('#rec-hotel-dg').datagrid('getSelected');
	var rindex = $('#rec-hotel-dg').datagrid('getRowIndex', row); 
	var positions = $('#rec-hotel-dg').datagrid('getEditor',{
		index:rindex,
		field : 'position'  
	});
	var ed = $('#rec-hotel-dg').datagrid('getEditor',{
		index:rindex,
		field : 'fRoomType'  
	});
	var position = $(positions.target).combotree('getValues');
	$(ed.target).combotree('setValue', '');
	var url = base+'/apply/lookupsJson?parentCode='+position;
   	$(ed.target).combotree('reload', url);
}


function getOtherJsons(){
	acceptsReim2();
	var rows3 = $('#rec-others-dg-reim').datagrid('getRows');
	var otherJson = "";
	for (var i = 0; i < rows3.length; i++) {
		otherJson = otherJson + JSON.stringify(rows3[i]) + ",";
	}
	$('#otherJson').val(otherJson);
}

function addTeacherCosts(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	var teacher = isNaN(parseFloat(newVal))?0:parseFloat(newVal);
	var row = $('#rec-others-dg-reim').datagrid('getSelected');
	var index=$('#rec-others-dg-reim').datagrid('getRowIndex',row);
    var student = $('#rec-others-dg-reim').datagrid('getEditor',{
		index: index,
		field : 'fStudentCost'  
	});
    var studentA = isNaN(parseFloat($(student.target).numberbox('getValue')))?0:parseFloat($(student.target).numberbox('getValue'));
    var cost = $('#rec-others-dg-reim').datagrid('getEditor',{
		index: index,
		field : 'fCost'
	});
    $(cost.target).numberbox('setValue',studentA+teacher);
    var rowsIndex = $('#index_reim_tab_id').datagrid('getRows');
    for (var i = 0; i < rowsIndex.length; i++) {
    	if(row.fCostName=='会务费'){
			if(rowsIndex[i].fCostName=='会务费' && rowsIndex[i].fCostTheir=='教师费用'){
				$('#index_reim_tab_id').datagrid('updateRow',{
					index: i,
					row: {
						fCostAmount: teacher
					}
				});
			}
    	}
    	if(row.fCostName=='培训费'){
			if(rowsIndex[i].fCostName=='培训费' && rowsIndex[i].fCostTheir=='教师费用'){
				$('#index_reim_tab_id').datagrid('updateRow',{
					index: i,
					row: {
						fCostAmount: teacher
					}
				});
			}
    	}
    }
}

function addStudentCosts(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	var student= isNaN(parseFloat(newVal))?0:parseFloat(newVal);
	var row = $('#rec-others-dg-reim').datagrid('getSelected');
	var index=$('#rec-others-dg-reim').datagrid('getRowIndex',row);
    var teacher = $('#rec-others-dg-reim').datagrid('getEditor',{
		index: index,
		field : 'fTeacherCost'  
	});
    var teacherA = isNaN(parseFloat($(teacher.target).numberbox('getValue')))?0:parseFloat($(teacher.target).numberbox('getValue'));
    var cost = $('#rec-others-dg-reim').datagrid('getEditor',{
		index: index,
		field : 'fCost'
	});
    $(cost.target).numberbox('setValue',teacherA+student);

    var rowsIndex = $('#index_reim_tab_id').datagrid('getRows');
    for (var i = 0; i < rowsIndex.length; i++) {
    	if(row.fCostName=='会务费'){
			if(rowsIndex[i].fCostName=='会务费' && rowsIndex[i].fCostTheir=='学生费用'){
				$('#index_reim_tab_id').datagrid('updateRow',{
					index: i,
					row: {
						fCostAmount: student
					}
				});
			}
    	}
    	if(row.fCostName=='培训费'){
			if(rowsIndex[i].fCostName=='培训费' && rowsIndex[i].fCostTheir=='学生费用'){
				$('#index_reim_tab_id').datagrid('updateRow',{
					index: i,
					row: {
						fCostAmount: student
					}
				});
			}
    	}
    }
}
</script>