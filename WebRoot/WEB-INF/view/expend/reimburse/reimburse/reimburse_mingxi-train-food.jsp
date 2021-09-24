<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<div id="food_Id" style="height:30px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">师资费-伙食费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">申请金额：<span ><fmt:formatNumber groupingUsed="true" value="${trainingBean.lessonsFoodMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<c:if test="${operation=='add'}">
		<a style="float: left;color: #666666;font-size:12px;">汇总金额：<span id="foodAmount"><fmt:formatNumber groupingUsed="true" value="${reimbTrainingBean.lessonsFoodMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		</c:if>
		<c:if test="${operation!='add'}">
		<a style="float: left;color: #666666;font-size:12px;">汇总金额：<span id="foodAmount"><fmt:formatNumber groupingUsed="true" value="${reimbTrainingBean.lessonsFoodMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		</c:if>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" id="removeToCityId" onclick="removeit6()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" id="appendToCityId" onclick="append6()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		
	</div>
	<table id="mingxi-food-dg" class="easyui-datagrid" style="width:693px;height:auto;"
	data-options="
	toolbar: 'food_Id',
	<c:if test="${!empty reimbTrainingBean.tId}">
	url: '${base}/apply/teacherMingxi?id=${reimbTrainingBean.tId}&costType=food',
	</c:if>
	<c:if test="${empty reimbTrainingBean.tId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRow6,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:false,
	scrollbarSize:0,
	singleSelect: true,
	">
	<thead>
		<tr>
			<th data-options="field:'thId',hidden:true"></th>
			<th data-options="field:'lecturerName',required:'required',align:'center',width:130,editor:{type:'combobox',options:{
                                valueField:'id',
                                textField:'text',
                                multiple: false,
                                onShowPanel:chooseLecturersFoodReim,
                                editable:false,
                                onHidePanel:onHidePanelLectureNameFoodReim
                            }}">讲师姓名</th>
			<th data-options="field:'foodDay',required:'required',align:'center',width:130,editor:{type:'numberbox',options:{onChange:addFoodDayReim}}">用餐天数</th>
			<th data-options="field:'foodStd',align:'center',editor:{type:'textbox',options:{editable:false}}">伙食费标准（元/人•天）</th>
			<th data-options="field:'realityFoodStd',align:'center',width:155,editor:{type:'numberbox',options:{onChange:addFoodStdReim,precision:2,groupSeparator:','}}">报销单价（元/人•天）</th>
			<c:if test="${empty detail}">
			<th data-options="field:'reimbSum',required:'required',align:'center',width:130,editor:{type:'numberbox',options:{onChange:addNum4,precision:2,groupSeparator:','}}">报销金额[元]</th>
			</c:if>
			<c:if test="${!empty detail}">
			<th data-options="field:'reimbSum',required:'required',align:'center',width:130,editor:{type:'numberbox',options:{precision:2,groupSeparator:','}}">报销金额[元]</th>
			</c:if>
			<th data-options="field:'fIdentityNumber',hidden:true,align:'center',editor:{type:'textbox'}">身份证号作为唯一标识</th>
		</tr>
	</thead>
	</table>
</div>
<script type="text/javascript">
function getFoodJson(){
	accept6();
	var rows = $('#mingxi-food-dg').datagrid('getRows');
	var foodJson = "";
	for (var i = 0; i < rows.length; i++) {
		foodJson = foodJson + JSON.stringify(rows[i]) + ",";
	}
	$('#foodJson').val(foodJson);
}

//接待人员表格添加删除，保存方法
var editIndex6 = undefined;
function endEditing6() {
	if (editIndex6 == undefined) {
		return true
	}
	if ($('#mingxi-food-dg').datagrid('validateRow', editIndex6)) {
		
		var tr = $('#mingxi-food-dg').datagrid('getEditors', editIndex6);
		var text0=tr[0].target.combobox('getText');
		if(text0!='--请选择--'){
			tr[0].target.combobox('setValue',text0);
		}
		$('#mingxi-food-dg').datagrid('endEdit', editIndex6);
		editIndex6 = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow6(index) {
		if (editIndex6 != index) {
			if (endEditing6()) {
				$('#mingxi-food-dg').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex6 = index;
			} else {
				$('#mingxi-food-dg').datagrid('selectRow', editIndex6);
			}
		}
}
function accept6() {
	if (endEditing6()) {
		$('#mingxi-food-dg').datagrid('acceptChanges');
	}
}

function append6(){
	if (endEditing6()) {
		$('#mingxi-food-dg').datagrid('appendRow', {});
		editIndex6 = $('#mingxi-food-dg').datagrid('getRows').length - 1;
		$('#mingxi-food-dg').datagrid('selectRow', editIndex6).datagrid('beginEdit',editIndex6);
	}
}
function removeit6(){
	if (editIndex6 == undefined) {
		return false;
	}
	$('#mingxi-food-dg').datagrid('cancelEdit', editIndex6).datagrid('deleteRow',
			editIndex6);
	editIndex6 = undefined;
}
//计算申请金额
function addNum4(newValue,oldValue) {
		var row = $('#mingxi-food-dg').datagrid('getSelected');//获得选择行
		var index=$('#mingxi-food-dg').datagrid('getRowIndex',row);//获得选中行的行号
		var tr = $('#mingxi-food-dg').datagrid('getEditors', index);
		var standar= parseFloat(tr[2].target.numberbox('getValue'));//获得选中行的开支标准
		if(isNaN(standar)){
			standar=0;
		}
		var foodDay= parseFloat(tr[1].target.numberbox('getValue'));
		if(isNaN(foodDay)){
			foodDay=0;
		}
		var num = 0;
		var rows = $('#mingxi-food-dg').datagrid('getRows');
		for(var i=0;i<rows.length;i++){
			if(i!=index){
				if(rows[i].reimbSum!=""&&rows[i].reimbSum!=null){
					num += parseFloat(rows[i].reimbSum);
				}
			}
		}
		if(newValue!=""&&newValue!=null) {
			num += parseFloat(newValue);
		}
		
		$('#lessonsFoodMoney').val(num.toFixed(2));
		$('#foodAmount').html(fomatMoney(num,2)+"[元]");
		addTotalAmounts();
}
var num2=0;
var num3=0;
//计算申请金额
function addNumDay(newValue,oldValue) {
		var row = $('#mingxi-food-dg').datagrid('getSelected');//获得选择行
		var index=$('#mingxi-food-dg').datagrid('getRowIndex',row);//获得选中行的行号
		var tr = $('#mingxi-food-dg').datagrid('getEditors', index);
		var standar= parseFloat(tr[2].target.textbox('getValue'));
		if(isNaN(standar)){
			standar=0;
		}
		var foodDay= parseFloat(tr[1].target.numberbox('getValue'));
		if(isNaN(foodDay)){
			foodDay=0;
		}
		if(parseFloat(newValue)>parseFloat(standar*foodDay)){
			alert('报销金额不能大于开支标准，请核对！');
			tr[0].target.numberbox('setValue',0);
			tr[1].target.numberbox('setValue',0);
			newValue=0;
		}
		
		var num = 0;
		var rows = $('#mingxi-food-dg').datagrid('getRows');
		for(var i=0;i<rows.length;i++){
			if(i!=index){
				if(rows[i].reimbSum!=""&&rows[i].reimbSum!=null){
					num += parseFloat(rows[i].reimbSum);
				}
			}
		}
		if(newValue!=""&&newValue!=null) {
			num += parseFloat(newValue);
		}
		$('#lessonsFoodMoney').val(num.toFixed(2));
		$('#foodAmount').html(fomatMoney(num,2)+"[元]");
		addTotalAmounts();
}
//计算申请金额
function addFoodStdReim(newValue,oldValue) {
	var row = $('#mingxi-food-dg').datagrid('getSelected');//获得选择行
	var index=$('#mingxi-food-dg').datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $('#mingxi-food-dg').datagrid('getEditors', index);
	var standar= parseFloat(tr[2].target.textbox('getValue'));//获得选中行的开支标准
	var realityFoodStd= parseFloat(newValue);//获得选中行的开支标准
	var foodPersonNum = parseFloat(tr[1].target.numberbox('getValue'));
	if(isNaN(realityFoodStd)){
		realityFoodStd=0;
	}
	if(isNaN(foodPersonNum)){
		foodPersonNum=0;
	}

	if(isNaN(standar)){
		standar=0;
	}
	if(standar<realityFoodStd){
		alert('超出费用标准，请重新填写！');
		tr[3].target.numberbox('setValue',0);
		return false;
	}else{
		tr[4].target.numberbox('setValue',realityFoodStd*foodPersonNum);
	}

		
}
//计算申请金额
function addFoodDayReim(newValue,oldValue) {
	var row = $('#mingxi-food-dg').datagrid('getSelected');//获得选择行
	var index=$('#mingxi-food-dg').datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $('#mingxi-food-dg').datagrid('getEditors', index);
	var trDayNum = parseInt($('#trDayNum').numberbox('getValue'));//工作天数
	var standar= parseFloat(tr[2].target.numberbox('getValue'));//获得选中行的开支标准
	var foodPersonNum= parseFloat(newValue);//获得选中行的开支标准
	var realityFoodStd = parseFloat(tr[3].target.numberbox('getValue'));

	if(isNaN(realityFoodStd)){
		realityFoodStd=0;
	}
	if(isNaN(trDayNum)){
		trDayNum=0;
	}
	if(isNaN(standar)){
		standar=0;
	}
	if(isNaN(foodPersonNum)){
		foodPersonNum=0;
	}
	if(foodPersonNum>trDayNum){
		alert('伙食费人·天超出标准，请重新填写！');
		tr[1].target.numberbox('setValue',0);
	}else{
		tr[4].target.numberbox('setValue',realityFoodStd*foodPersonNum);
	}
}

function onLoadSuccessFood(){
	var rows = $('#mingxi-food-dg').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		var realityFoodStd = parseFloat(rows[i].realityFoodStd);//获得选中行的开支标准
		if(isNaN(realityFoodStd)){
			realityFoodStd=0;
		}
		var foodDay = parseFloat(rows[i].foodDay);//获得选中行的开支标准
		if(isNaN(foodDay)){
			foodDay=0;
		}
		var countMoney = foodDay*realityFoodStd;
		$('#mingxi-food-dg').datagrid('updateRow',{
			index: i,
			row: {
				reimbSum: countMoney
			}
		});
	}
}

function chooseLecturersFoodReim(){
	$('#mingxi-food-dg').datagrid('selectRow', editIndex6).datagrid('beginEdit',
			editIndex6);
	var index=$('#mingxi-food-dg').datagrid('getRowIndex',$('#mingxi-food-dg').datagrid('getSelected'));
		var new_arrs= lecturerArr();
		var lecturer = $('#mingxi-food-dg').datagrid('getEditor',{
			index:index,
			field:'lecturerName'
		});
		$(lecturer.target).combobox({
            data: new_arrs,
            valueField: 'id',
            multiple: false,
            textField: 'text',
		});
}

function onHidePanelLectureNameFoodReim(){
	var row = $('#mingxi-food-dg').datagrid('getSelected');//获得选择行
	var index=$('#mingxi-food-dg').datagrid('getRowIndex',row);
	var fIdentityNumber = $('#mingxi-food-dg').datagrid('getEditor',{
		index:index,
		field:'fIdentityNumber'
	});
	var lecturer = $('#mingxi-food-dg').datagrid('getEditor',{
		index:index,
		field:'lecturerName'
	});
	var foodStd = $('#mingxi-food-dg').datagrid('getEditor',{
		index:index,
		field:'foodStd'
	});
	var lecturerId = $(lecturer.target).combobox('getValue');
	$(fIdentityNumber.target).textbox('setValue',lecturerId);
	
	var rows = $('#dg_train_lecturer').datagrid('getRows');
	for (var y = 0; y < rows.length; y++) {
		if(lecturerId==rows[y].fIdentityNumber){
			if(rows[y].isOutside=='0'){//否
				$(foodStd.target).textbox('setValue',150);
			}else{
				$(foodStd.target).textbox('setValue',120);
			}
			
		}
	}
}
</script>
