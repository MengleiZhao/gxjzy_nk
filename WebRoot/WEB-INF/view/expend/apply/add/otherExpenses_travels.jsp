<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<!-- 其他费用 -->
<div class="window-tab" style="margin-left: 0px;padding-top: 0px;">
	<table id="rec-others-dg" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#others_id',
	<c:if test="${!empty bean.gId}">
	url: '${base}/apply/receptionOthers?gId=${bean.gId}&fType=2',
	</c:if>
	<c:if test="${empty bean.gId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRows2, 
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
				<th data-options="field:'fStudentCost',required:'required',align:'center',width:239,editor:{type:'numberbox',options:{onChange:addStudentCosts,precision:2,groupSeparator:','}}">学生金额[元]</th>
				<th data-options="field:'fCost',required:'required',align:'center',hidden:true,width:191,editor:{type:'numberbox',options:{onChange:addNumOthers,precision:2,groupSeparator:','}}">申请金额[元]</th>
			</tr>
		</thead>
	</table>
	<c:if test="${empty detail}">
	<div id="others_id" style="height:20px;">
		<a style="float: left;">会务、培训费</a>
		<a href="javascript:void(0)" onclick="removeits2()" hidden="hidden" id="otherRemoveitId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appends2()" hidden="hidden" id="otherAppendId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	</c:if>
</div>
<input type="hidden" id="otherJsons" name="otherJsons"/>
<script type="text/javascript">
//接待人员表格添加删除，保存方法
var editIndexs2 = undefined;
function endEditings2() {
	if (editIndexs2 == undefined) {
		return true;
	}
	if ($('#rec-others-dg').datagrid('validateRow', editIndexs2)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		$('#rec-others-dg').datagrid('endEdit', editIndexs2);
		editIndexs2 = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRows2(index) {
	if (editIndexs2 != index) {
		if (endEditings2()) {
			$('#rec-others-dg').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndexs2 = index;
		}
	}
}
function appends2() {
	if (endEditings2()) {
		$('#rec-others-dg').datagrid('appendRow', {});
		editIndexs2 = $('#rec-others-dg').datagrid('getRows').length - 1;
		$('#rec-others-dg').datagrid('selectRow', editIndexs2).datagrid('beginEdit',editIndexs2);
	}
}
function removeits2() {
	if (editIndexs2 == undefined) {
		return
	}
	$('#rec-others-dg').datagrid('cancelEdit', editIndexs2).datagrid('deleteRow',
			editIndexs2);
	editIndexs2 = undefined;
	calcOtherCosts();
}
function accepts2() {
	if (endEditings2()) {
		$('#rec-others-dg').datagrid('acceptChanges');
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
	
	var rows = $('#rec-others-dg').datagrid('getRows');
	var index=$('#rec-others-dg').datagrid('getRowIndex',$('#rec-others-dg').datagrid('getSelected'));
     var num1 = 0;
     for(var i=0;i<rows.length;i++){
		if(i==index){
			num1+=parseFloat(newVal);
		}else{
			num1+=addNumsOthers(rows,i);
		}
	}
	$("#meetTrainAmount").val(num1.toFixed(2));
	var meetTrainAmount = parseFloat(num1);
	var travelAmount = parseFloat($('#travelAmount').val());
    if(isNaN(meetTrainAmount)){
   	 meetTrainAmount = 0;
    }
    if(isNaN(travelAmount)){
    	travelAmount = 0;
    }
    $("#applyTotalAmount").html(fomatMoney((meetTrainAmount+travelAmount),2)+"[元]");
	$("#applyAmount").val((meetTrainAmount+travelAmount).toFixed(2));
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
function calcOtherCosts(){
	//计算总额
	var rows = $('#rec-others-dg').datagrid('getRows');
	var otherAmount=parseFloat(0.00);
	for(var i=0;i<rows.length;i++){
		var money = isNaN(parseFloat(rows[i].fCost))?0.00:parseFloat(rows[i].fCost);
		otherAmount=otherAmount+money;
	}
	$('#otherAmounts').html(listToFixed(otherAmount)+'元');
	$('#totalOtherMoney').val(otherAmount.toFixed(2));
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
	accepts2();
	var rows3 = $('#rec-others-dg').datagrid('getRows');
	var otherJson = "";
	for (var i = 0; i < rows3.length; i++) {
		otherJson = otherJson + JSON.stringify(rows3[i]) + ",";
	}
	$('#otherJsons').val(otherJson);
}

function addTeacherCosts(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	var teacher = isNaN(parseFloat(newVal))?0:parseFloat(newVal);
	var row = $('#rec-others-dg').datagrid('getSelected');
	var index=$('#rec-others-dg').datagrid('getRowIndex',row);
    var student = $('#rec-others-dg').datagrid('getEditor',{
		index: index,
		field : 'fStudentCost'  
	});
    var studentA = isNaN(parseFloat($(student.target).numberbox('getValue')))?0:parseFloat($(student.target).numberbox('getValue'));
    var cost = $('#rec-others-dg').datagrid('getEditor',{
		index: index,
		field : 'fCost'
	});
    $(cost.target).numberbox('setValue',studentA+teacher);
    
    var rowsIndex = $('#index_tab_id').datagrid('getRows');
    for (var i = 0; i < rowsIndex.length; i++) {
    	if(row.fCostName=='会务费'){
			if(rowsIndex[i].fCostName=='会务费' && rowsIndex[i].fCostTheir=='教师费用'){
				if(rowsIndex[i].fCostClassify==''){
					$('#index_tab_id').datagrid('updateRow',{
						index: i,
						row: {
							fCostAmount: teacher
						}
					});
				}else{
					$('#index_tab_id').datagrid('updateRow',{
						index: i,
						row: {
							fCostAmount: teacher,
							fIndexKYAmount: '',
							fProDetailId:  '',
							fIndexId: '',
							fIndexName: '',
							fIndexPFAmount: '',
							fIndexType: '',
							fBudgetYear: '',
							fCostClassify: '',
							fCostClassifyShow: '',
						}
					});
					editIndexIndex = undefined;
				}
			}
    	}
    	if(row.fCostName=='培训费'){
			if(rowsIndex[i].fCostName=='培训费' && rowsIndex[i].fCostTheir=='教师费用'){
				if(rowsIndex[i].fCostClassify==''){
					$('#index_tab_id').datagrid('updateRow',{
						index: i,
						row: {
							fCostAmount: teacher
						}
					});
				}else{
					$('#index_tab_id').datagrid('updateRow',{
						index: i,
						row: {
							fCostAmount: teacher,
							fIndexKYAmount: '',
							fProDetailId:  '',
							fIndexId: '',
							fIndexName: '',
							fIndexPFAmount: '',
							fIndexType: '',
							fBudgetYear: '',
							fCostClassify: '',
							fCostClassifyShow: '',
						}
					});
					editIndexIndex = undefined;
				}
			}
    	}
    }
}

function addStudentCosts(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	var student= isNaN(parseFloat(newVal))?0:parseFloat(newVal);
	var row = $('#rec-others-dg').datagrid('getSelected');
	var index=$('#rec-others-dg').datagrid('getRowIndex',row);
    var teacher = $('#rec-others-dg').datagrid('getEditor',{
		index: index,
		field : 'fTeacherCost'  
	});
    var teacherA = isNaN(parseFloat($(teacher.target).numberbox('getValue')))?0:parseFloat($(teacher.target).numberbox('getValue'));
    var cost = $('#rec-others-dg').datagrid('getEditor',{
		index: index,
		field : 'fCost'
	});
    $(cost.target).numberbox('setValue',teacherA+student);

    var rowsIndex = $('#index_tab_id').datagrid('getRows');
    for (var i = 0; i < rowsIndex.length; i++) {
    	if(row.fCostName=='会务费'){
			if(rowsIndex[i].fCostName=='会务费' && rowsIndex[i].fCostTheir=='学生费用'){
				if(rowsIndex[i].fCostClassify==''){
					$('#index_tab_id').datagrid('updateRow',{
						index: i,
						row: {
							fCostAmount: student
						}
					});
				}else{
					$('#index_tab_id').datagrid('updateRow',{
						index: i,
						row: {
							fCostAmount: student,
							fIndexKYAmount: '',
							fProDetailId:  '',
							fIndexId: '',
							fIndexName: '',
							fIndexPFAmount: '',
							fIndexType: '',
							fBudgetYear: '',
							fCostClassify: '',
							fCostClassifyShow: '',
						}
					});
					editIndexIndex = undefined;
				}
			}
    	}
    	if(row.fCostName=='培训费'){
			if(rowsIndex[i].fCostName=='培训费' && rowsIndex[i].fCostTheir=='学生费用'){
				if(rowsIndex[i].fCostClassify==''){
					$('#index_tab_id').datagrid('updateRow',{
						index: i,
						row: {
							fCostAmount: student
						}
					});
				}else{
					$('#index_tab_id').datagrid('updateRow',{
						index: i,
						row: {
							fCostAmount: student,
							fIndexKYAmount: '',
							fProDetailId:  '',
							fIndexId: '',
							fIndexName: '',
							fIndexPFAmount: '',
							fIndexType: '',
							fBudgetYear: '',
							fCostClassify: '',
							fCostClassifyShow: '',
						}
					});
					editIndexIndex = undefined;
				}
			}
    	}
    }
}
</script>