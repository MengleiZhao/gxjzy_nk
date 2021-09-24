<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<c:if test="${type!=1}">
<!-- <div class="window-title">费用明细</div> -->
</c:if>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<div id="lessons_Id" style="height:30px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">师资费-讲课费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">合计金额：<span id="lessonsAmount"><fmt:formatNumber groupingUsed="true" value="${trainingBean.lessonsMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
	<table id="mingxi-lessons-dg" class="easyui-datagrid" style="width:707px;height:auto;"
	data-options="
	toolbar: 'lessons_Id',
	<c:if test="${!empty trainingBean.tId}">
	url: '${base}/apply/teacherMingxi?id=${trainingBean.tId}&costType=lesson',
	</c:if>
	<c:if test="${empty trainingBean.tId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRow4,
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
				<th data-options="field:'lecturerName',required:'required',align:'center',width:190">讲师姓名</th>
				<th data-options="field:'fIdentityNumber',align:'center',hidden:true">身份证号</th>
				<th data-options="field:'lessonTime',required:'required',width:140,align:'center'">学时</th>
				<th data-options="field:'lessonStd',required:'required',align:'center',width:190">标准课时费标准（元/学时）</th>
				<th data-options="field:'realityLessonStd',required:'required',align:'center',width:190,editor:{
				type:'numberbox',
				options:{
				onChange:addNums,
				precision:2,
				editable: true
				}}">税后课时费标准（元/学时）</th>
				<th data-options="field:'lessonStdTotal',required:'required',align:'center',width:180,hidden:true">正常标准[元]</th>
				<th data-options="field:'lessonStdTotalUp',required:'required',align:'center',width:180,hidden:true">上浮后标准[元]</th>
				<th data-options="field:'fNetAmount',editor:{type:'numberbox',options:{precision:2,editable:false}}">税后金额[元]</th>
				<th data-options="field:'fIndividualIncomeTax',editor:{type:'numberbox',options:{precision:2,editable:false}}">预扣预缴税款[元]</th>
				<c:if test="${empty detail}">
				<th data-options="field:'applySum',required:'required',align:'center',width:190,editor:{type:'numberbox',options:{onChange:addNum2,precision:2,editable:false}}">申请金额[元]</th>
				</c:if>
				<c:if test="${!empty detail}">
				<th data-options="field:'applySum',required:'required',align:'center',width:190,editor:{type:'numberbox',options:{precision:2,groupSeparator:','}}">申请金额[元]</th>
				</c:if>
				<th data-options="field:'isOutside',hidden:true"></th>
		</tr>
	</thead>
	</table>
</div>
<input type="hidden" id="lessonJson" name="lessonJson"/>
<script type="text/javascript">
function getLessonJson(){
	accept4();
	var rows = $('#mingxi-lessons-dg').datagrid('getRows');
	var lessonJson = "";
	for (var i = 0; i < rows.length; i++) {
		lessonJson = lessonJson + JSON.stringify(rows[i]) + ",";
	}
	$('#lessonJson').val(lessonJson);
}

//表格添加删除，保存方法
var editIndex4 = undefined;
function endEditing4() {
	if (editIndex4 == undefined) {
		return true
	}
	if ($('#mingxi-lessons-dg').datagrid('validateRow', editIndex4)) {
		$('#mingxi-lessons-dg').datagrid('endEdit', editIndex4);
		editIndex4 = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow4(index) {
		if (editIndex4 != index) {
			if (endEditing4()) {
				$('#mingxi-lessons-dg').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex4 = index;
			} else {
				$('#mingxi-lessons-dg').datagrid('selectRow', editIndex4);
			}
		}
}
function accept4() {
	if (endEditing4()) {
		$('#mingxi-lessons-dg').datagrid('acceptChanges');
	}
}
//计算申请金额
function addNum2(newValue,oldValue) {
	if(newValue==undefined || oldValue==undefined){
		return false;
	}
	var newValues = parseFloat(newValue);
	if(isNaN(newValues)){
		newValues = 0;
	}
	var num = 0;
	var rows = $('#mingxi-lessons-dg').datagrid('getRows');
	var index=$('#mingxi-lessons-dg').datagrid('getRowIndex',$('#mingxi-lessons-dg').datagrid('getSelected'));//获得选中行的行号
	var tr = $('#mingxi-lessons-dg').datagrid('getEditors', index);
	var lessonTime = parseFloat(rows[index].lessonTime);
	if(isNaN(lessonTime)){
		lessonTime = 0;
	}
	for(var i=0;i<rows.length;i++){
		if(i!=index){
			if(rows[i].applySum!=""&&rows[i].applySum!=null){
				num += parseFloat(rows[i].applySum);
			}
		}
	}
	if(newValues!=""&&newValues!=null) {
		num += parseFloat(newValues);
	}
	$('#lessonsMoney').val(num.toFixed(2));
	$('#lessonsAmount').html(fomatMoney(num,2)+"[元]");
	addTotalAmount();
	num1=1;
	if(num0==0){
		var fIndividualIncomeTax = 0;			//个税金额
		var netAmount = 0;						//税后金额
		if(newValues<20000){
			fIndividualIncomeTax = newValues*0.2;
			netAmount = newValues-newValues*0.2;
		}
		if((20000<=newValues)&&(newValues<50000)){
			fIndividualIncomeTax = newValues*0.3-2000;
			netAmount = newValues-(newValues*0.3-2000);
		}
		if(50000<=(newValues)){
			fIndividualIncomeTax = newValues*0.4-7000;
			netAmount = newValues-(newValues*0.4-7000);
		}
		
		
		tr[0].target.numberbox('setValue',newValues/lessonTime);
		tr[2].target.numberbox('setValue',fIndividualIncomeTax);
		tr[1].target.numberbox('setValue',netAmount);
		num0=0;
		num1=0;
	}
}
var num0=0;
var num1=0;
//计算申请金额
function addNums(newValue,oldValue) {
	
	var row = $('#mingxi-lessons-dg').datagrid('getSelected');//获得选择行
	var index=$('#mingxi-lessons-dg').datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $('#mingxi-lessons-dg').datagrid('getEditors', index);
	var realityLessonStd = parseFloat(newValue);//获得选中行的开支标准
	if(isNaN(realityLessonStd)){
		realityLessonStd=0;
	}
	var standar = parseFloat(row.lessonStd);//获得选中行的开支标准
	if(isNaN(standar)){
		standar=0;
	}
	if(realityLessonStd>standar){
		alert('课时费超出标准，请核对！');
		tr[0].target.numberbox('setValue',0);		//课时费标准
		return false;
	}
	var lessonTime = parseFloat(row.lessonTime);//获得选中行的学时
	if(isNaN(lessonTime)){
		lessonTime=0;
	}
	var periodStd = 0;						//学时标准制度
	var fIndividualIncomeTax = 0;			//个税金额
	var netAmount = 0;						//税后金额
	if(lessonTime*realityLessonStd<=800){
		periodStd = 0;						//学时标准制度
		fIndividualIncomeTax = 0;			//个税金额
		netAmount = 0;						//税后金额
	}
	if(lessonTime*realityLessonStd>800 && lessonTime*realityLessonStd<3360){
		fIndividualIncomeTax = ((lessonTime*realityLessonStd)*1.25-200)-(lessonTime*realityLessonStd);
		netAmount = lessonTime*realityLessonStd;
		periodStd = netAmount/lessonTime;
	}
	
	if(lessonTime*realityLessonStd>=3360&&lessonTime*realityLessonStd<=21000){
		fIndividualIncomeTax = (25/21*lessonTime*realityLessonStd)-(lessonTime*realityLessonStd);
		netAmount = lessonTime*realityLessonStd;
		periodStd = netAmount/lessonTime;
	}
	if((21000<lessonTime*realityLessonStd)&&(lessonTime*realityLessonStd<=49500)){
		fIndividualIncomeTax = (100/76*(lessonTime*realityLessonStd)-(50000/19))-(lessonTime*realityLessonStd);
		netAmount = lessonTime*realityLessonStd;
		periodStd = netAmount/lessonTime;
	}
	if(49500<(lessonTime*realityLessonStd)){
		fIndividualIncomeTax = (25/17*(lessonTime*realityLessonStd))-(175000/17)-(lessonTime*realityLessonStd);
		netAmount = lessonTime*realityLessonStd;
		periodStd = netAmount/lessonTime;
	}
	if(periodStd>parseFloat(standar)){
		alert('实际的课时费标准不能大于制度标准，请核对！');
		tr[0].target.numberbox('setValue',0);		//课时费标准
		tr[1].target.numberbox('setValue',0);		//实发金额
		tr[2].target.numberbox('setValue',0);		//个税
		tr[3].target.numberbox('setValue',0);		//申请金额
		newValue=0;
	}else{
		num0=1;
		if(num1==0){
			tr[3].target.numberbox('setValue',fIndividualIncomeTax+netAmount);//申请金额
			tr[2].target.numberbox('setValue',fIndividualIncomeTax);//个税
			tr[1].target.numberbox('setValue',netAmount);//实发金额
			num1=0;
			num0=0;
		}
	}
}
</script>
