<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<div id="hotel_Id" style="height:30px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">师资费-住宿费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">合计金额：<span id="hotelAmount"><fmt:formatNumber groupingUsed="true" value="${trainingBean.lessonsHotelMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		<c:if test="${empty detail}">
		<a href="javascript:void(0)" id="removeTrainHotelId" onclick="removeTrainHotel()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" id="appendTrainHotelId" onclick="appendTrainHotel()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		</c:if>
	</div>
	<table id="mingxi-hotel-dg" class="easyui-datagrid" style="width:707px;height:auto;"
	data-options="
	toolbar: 'hotel_Id',
	<c:if test="${!empty trainingBean.tId}">
	url: '${base}/apply/teacherMingxi?id=${trainingBean.tId}&costType=hotel',
	</c:if>
	<c:if test="${empty trainingBean.tId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRow5,
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
			<th data-options="field:'lecturerName',required:'required',align:'center',width:230,editor:{type:'combobox',options:{
                                valueField:'id',
                                textField:'text',
                                multiple: false,
                                onShowPanel:chooseLecturersHotel,
                                editable:false,
                                onHidePanel:onHidePanelLectureNameHotel
                            }}">讲师姓名</th>
			<th data-options="field:'administrativeLevelName',required:'required',align:'center',width:230,editor:{type:'combobox',options:{editable:false}}">行政级别</th>
			<th data-options="field:'hotelDay',required:'required',align:'center',width:230,editor:{type:'numberbox',options:{onChange:addHotelDay}}">住宿天数</th>
			<th data-options="field:'hotelStd',align:'center',editor:{type:'combobox',options:{editable:false,precision:2,
                                valueField:'text',
                                textField:'text',
                                multiple: false,
                                onShowPanel:onShowPanelHotelStd,
                                editable:false,
                                onSelect:onSelectHotelStd}}">住宿费标准（元/人•天）</th>
			<th data-options="field:'realityHotelStd',align:'center',width:230,editor:{type:'numberbox',options:{onChange:addHotelStd,precision:2}}">申请单价（元/人•天）</th>
			<c:if test="${empty detail}">
			<th data-options="field:'applySum',required:'required',align:'center',width:250,editor:{type:'numberbox',options:{onChange:addNum3,precision:2,editable:false}}">申请金额[元]</th>
			</c:if>
			<c:if test="${!empty detail}">
			<th data-options="field:'applySum',required:'required',align:'center',width:250,editor:{type:'numberbox',options:{precision:2,groupSeparator:','}}">申请金额[元]</th>
			</c:if>
			<th data-options="field:'fIdentityNumber',hidden:true,align:'center',editor:{type:'textbox'}">身份证号作为唯一标识</th>
			<th data-options="field:'administrativeLevel',hidden:true,align:'center',editor:{type:'textbox',options:{onChange:onChangeLevelHotel}}">行政级别编号</th>
		</tr>
	</thead>
	</table>
</div>
<input type="hidden" id="hotelJson" name="hotelJson"/>
<script type="text/javascript">
function getHotelJson(){
	accept5();
	var rows = $('#mingxi-hotel-dg').datagrid('getRows');
	var hotelJson = "";
	for (var i = 0; i < rows.length; i++) {
		hotelJson = hotelJson + JSON.stringify(rows[i]) + ",";
	}
	$('#hotelJson').val(hotelJson);
}
//接待人员表格添加删除，保存方法
var editIndex5 = undefined;
function endEditing5() {
	if (editIndex5 == undefined) {
		return true
	}
	if ($('#mingxi-hotel-dg').datagrid('validateRow', editIndex5)) {
		var tr = $('#mingxi-hotel-dg').datagrid('getEditors', editIndex5);
		var text0=tr[0].target.combobox('getText');
		if(text0!='--请选择--'){
			tr[0].target.combobox('setValue',text0);
		}
		var text1=tr[1].target.combobox('getText');
		if(text1!='--请选择--'){
			tr[1].target.combobox('setValue',text1);
		}
		$('#mingxi-hotel-dg').datagrid('endEdit', editIndex5);
		editIndex5 = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow5(index) {
		if (editIndex5 != index) {
			if (endEditing5()) {
				$('#mingxi-hotel-dg').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex5 = index;
			} else {
				$('#mingxi-hotel-dg').datagrid('selectRow', editIndex5);
			}
		}
}
function accept5() {
	if (endEditing5()) {
		$('#mingxi-hotel-dg').datagrid('acceptChanges');
	}
}
function appendTrainHotel(){
	if (endEditing5()) {
		$('#mingxi-hotel-dg').datagrid('appendRow', {});
		editIndex5 = $('#mingxi-hotel-dg').datagrid('getRows').length - 1;
		$('#mingxi-hotel-dg').datagrid('selectRow', editIndex5).datagrid('beginEdit',editIndex5);
	}
}
function removeTrainHotel(){
	if (editIndex5 == undefined) {
		return false;
	}
	$('#mingxi-hotel-dg').datagrid('cancelEdit', editIndex5).datagrid('deleteRow',
			editIndex5);
	editIndex5 = undefined;
}
//计算申请金额
function addHotelDay(newValue,oldValue) {
	var row = $('#mingxi-hotel-dg').datagrid('getSelected');//获得选择行
	var index=$('#mingxi-hotel-dg').datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $('#mingxi-hotel-dg').datagrid('getEditors', index);
	var trDayNum = parseInt($('#trDayNum').numberbox('getValue'));//工作天数
	var standar= parseFloat(tr[3].target.combobox('getValue'));//获得选中行的开支标准
	var hotelPersonNum= parseFloat(newValue);//获得选中行的开支标准
	var realityHotelStd = isNaN(parseFloat(tr[4].target.numberbox('getValue')))?0:parseFloat(tr[4].target.numberbox('getValue'));
	
	if(isNaN(realityHotelStd)){
		realityHotelStd=0;
	}
	if(isNaN(trDayNum)){
		trDayNum=0;
	}
	if(isNaN(standar)){
		standar=0;
	}
	if(isNaN(hotelPersonNum)){
		hotelPersonNum=0;
	}
	if(hotelPersonNum > trDayNum){
		alert('申请单价超出标准，请重新填写！');
		tr[2].target.numberbox('setValue',0);
	}else{
		tr[5].target.numberbox('setValue',realityHotelStd*hotelPersonNum);
	}
}
//计算申请金额
function addHotelStd(newValue,oldValue) {
	
	var row = $('#mingxi-hotel-dg').datagrid('getSelected');//获得选择行
	var index=$('#mingxi-hotel-dg').datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $('#mingxi-hotel-dg').datagrid('getEditors', index);
	var standar= isNaN(parseFloat(tr[3].target.combobox('getValue')))?0:parseFloat(tr[3].target.combobox('getValue'));//获得选中行的开支标准
	var realityHotelStd= parseFloat(newValue);//获得选中行的开支标准
	var hotelDay = isNaN(parseFloat(tr[2].target.numberbox('getValue')))?0:parseFloat(tr[2].target.numberbox('getValue'));
	if(isNaN(realityHotelStd)){
		realityHotelStd=0;
	}
	if(standar<realityHotelStd){
		alert('超出费用标准，请重新填写！');
		tr[4].target.numberbox('setValue',0);
		return false;
	}else{
		tr[5].target.numberbox('setValue',realityHotelStd*hotelDay);
	}
/* 	if(isNaN(hotelPersonNum)){
		hotelPersonNum=0;
	}
	if(isNaN(standar)){
		standar=0;
	}
	num5=1;
	if(num4==0){
		tr[5].target.numberbox('setValue',realityHotelStd*hotelDay);
		num4=0;
		num5=0;
	} */
}
var num4=0;
var num5=0;
//计算申请金额
function addNum3(newValue,oldValue) {
		var row = $('#mingxi-hotel-dg').datagrid('getSelected');//获得选择行
		var index=$('#mingxi-hotel-dg').datagrid('getRowIndex',row);//获得选中行的行号
		var tr = $('#mingxi-hotel-dg').datagrid('getEditors', index);
		var standar= parseFloat(tr[3].target.combobox('getValue'));//获得选中行的开支标准
		if(isNaN(standar)){
			standar=0;
		}
		var hotelDay= parseFloat(tr[2].target.numberbox('getValue'));
		if(isNaN(hotelDay)){
			hotelDay=0;
		}
		if(parseFloat(newValue)>parseFloat(standar*hotelDay)){
			alert('申请金额不能大于开支标准，请核对！');
			tr[5].target.numberbox('setValue',0);
			newValue=0;
		}
		var num = 0;
		var rows = $('#mingxi-hotel-dg').datagrid('getRows');
		for(var i=0;i<rows.length;i++){
			if(i!=index){
				if(rows[i].applySum!=""&&rows[i].applySum!=null){
					num += parseFloat(rows[i].applySum);
				}
			}
		}
		if(newValue!=""&&newValue!=null) {
			num += parseFloat(newValue);
		}
		/* var hotelDay1 = parseFloat(tr[2].target.numberbox('getValue'));
		if(isNaN(hotelDay1)){
			alert('住宿天数不能为空，请重新填写！');
			tr[2].target.numberbox('setValue',0);
		}else{
			num4=1;
			if(num5==0){
				tr[4].target.numberbox('setValue',(parseFloat(newValue)/hotelDay).toFixed(2));
				num5=0;
				num4=0;
			}
		} */
		$('#lessonsHotelMoney').val(num.toFixed(2));
		$('#hotelAmount').html(fomatMoney(num,2)+"[元]");
		addTotalAmount();
}



function chooseLecturersHotel(){
	$('#mingxi-hotel-dg').datagrid('selectRow', editIndex5).datagrid('beginEdit',
			editIndex5);
	var index=$('#mingxi-hotel-dg').datagrid('getRowIndex',$('#mingxi-hotel-dg').datagrid('getSelected'));
		var new_arrs= lecturerArrCarFare();
		var lecturer = $('#mingxi-hotel-dg').datagrid('getEditor',{
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

function onHidePanelLectureNameHotel(){
	var row = $('#mingxi-hotel-dg').datagrid('getSelected');//获得选择行
	var index=$('#mingxi-hotel-dg').datagrid('getRowIndex',row);
	var administrativeLevel = $('#mingxi-hotel-dg').datagrid('getEditor',{
		index:index,
		field:'administrativeLevel'
	});
	var lecturer = $('#mingxi-hotel-dg').datagrid('getEditor',{
		index:index,
		field:'lecturerName'
	});
	var lecturerId = $(lecturer.target).combobox('getValue');
	$(administrativeLevel.target).textbox('setValue',lecturerId);
}

function onChangeLevelHotel(newVal,oldVal){
	var row = $('#mingxi-hotel-dg').datagrid('getSelected');//获得选择行
	var index=$('#mingxi-hotel-dg').datagrid('getRowIndex',row);
	if(newVal=="ZWJBJD-01"){
		var administrativeLevelName = $('#mingxi-hotel-dg').datagrid('getEditor',{
			index:index,
			field:'administrativeLevelName'
		});
		$(administrativeLevelName.target).textbox('setValue',"省级");
	}
	if(newVal=="ZWJBJD-02"){
		var administrativeLevelName = $('#mingxi-hotel-dg').datagrid('getEditor',{
			index:index,
			field:'administrativeLevelName'
		});
		$(administrativeLevelName.target).textbox('setValue',"厅级");
		
	}
	if(newVal=="ZWJBJD-03"){
		var administrativeLevelName = $('#mingxi-hotel-dg').datagrid('getEditor',{
			index:index,
			field:'administrativeLevelName'
		});
		$(administrativeLevelName.target).textbox('setValue',"其他人员");
		
	}
	var day0 = $("#trDateStart").datebox('getValue'); //开始时间
	var day1 = $("#trDateEnd").datebox('getValue'); //结束时间
	var startday = Date.parse(new Date(day0));//入住时间
	var endday = Date.parse(new Date(day1));//退房时间
	var fDistrictId = $("#fDistrictId").combobox('getValue')
	$.ajax({
		type:'post',
		async:false,
		dataType:'json',
		url:base+'/hotelStandard/getHotelStandardByRegionId?id='+fDistrictId+'&level='+newVal+'&day1='+startday+'&day2='+endday,
		success:function (data){
			var hotelStd = $('#mingxi-hotel-dg').datagrid('getEditor',{
				index:index,
				field:'hotelStd'
			});
			$(hotelStd.target).combobox('setValue',data);
		}
	});
}

function onShowPanelHotelStd(){
	$('#mingxi-hotel-dg').datagrid('selectRow', editIndex5).datagrid('beginEdit', editIndex5);
	var index=$('#mingxi-hotel-dg').datagrid('getRowIndex',$('#mingxi-hotel-dg').datagrid('getSelected'));
	var administrativeLevel = $('#mingxi-hotel-dg').datagrid('getEditor',{
		index:index,
		field:'administrativeLevel'
	});
	var level = $(administrativeLevel.target).textbox('getValue');
	var fDistrictId = $("#fDistrictId").combobox('getValue');
	var day0 = $("#trDateStart").datebox('getValue'); //开始时间
	var day1 = $("#trDateEnd").datebox('getValue'); //结束时间
	var startday = Date.parse(new Date(day0));//入住时间
	var endday = Date.parse(new Date(day1));//退房时间
	
	$.ajax({
		type:'post',
		async:false,
		dataType:'json',
		url:base+'/hotelStandard/getHotelStandardByRegionId?id='+fDistrictId+'&level='+level+'&day1='+startday+'&day2='+endday,
		success:function (data){
			var hotelStd = $('#mingxi-hotel-dg').datagrid('getEditor',{
				index:index,
				field:'hotelStd'
			});
			$(hotelStd.target).combobox({
	            data: data,
	            valueField: 'id',
	            multiple: false,
	            textField: 'text',
			});
		}
	});
}


function onSelectHotelStd(rec){
	
	var index=$('#mingxi-hotel-dg').datagrid('getRowIndex',$('#mingxi-hotel-dg').datagrid('getSelected'));
	var hotelDay = $('#mingxi-hotel-dg').datagrid('getEditor',{
		index:index,
		field:'hotelDay'
	});
	var realityHotelStd = $('#mingxi-hotel-dg').datagrid('getEditor',{
		index:index,
		field:'realityHotelStd'
	});
	var applySum = $('#mingxi-hotel-dg').datagrid('getEditor',{
		index:index,
		field:'applySum'
	});
	var day = isNaN(parseFloat($(hotelDay.target).numberbox('getValue')))?0:parseFloat($(hotelDay.target).numberbox('getValue'));
	var applySums = isNaN(parseFloat($(applySum.target).numberbox('getValue')))?0:parseFloat($(applySum.target).numberbox('getValue'));
	var realityHotelStds = isNaN(parseFloat($(realityHotelStd.target).numberbox('getValue')))?0:parseFloat($(realityHotelStd.target).numberbox('getValue'));
	var hotelStd = rec.id;
	if(day*hotelStd<applySums){
		alert('申请金额超出标准，请重新填写！');
		$(realityHotelStd.target).numberbox('setValue',0)
		$(hotelDay.target).numberbox('setValue',0)
		return false;
	}
}
</script>
