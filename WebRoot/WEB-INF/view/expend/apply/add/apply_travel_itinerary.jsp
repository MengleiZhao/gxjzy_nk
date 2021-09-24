<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">

	<table id="tracel_itinerary_tab_id" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#itinerary_toolbar_Id',
	<c:if test="${!empty bean.gId}">
	url: '${base}/apply/applyTravelPage?gId=${bean.gId}&travelType=${bean.travelType}',
	</c:if>
	<c:if test="${empty bean.gId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRowItinerary,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'trId',hidden:true"></th>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'travelAttendPeop',width:130,align:'center',editor:{type:'textbox',options:{editable:false,icons:[{iconCls:'icon-add',handler: function(e){
					     var row = $('#tracel_itinerary_tab_id').datagrid('getSelected');
					     var index = $('#tracel_itinerary_tab_id').datagrid('getRowIndex',row);
					     selectTravelAttendPeop(index)
					     }}]}}">出行人（可多选）</th>
				<th data-options="field:'travelDateStart',width:140,align:'center',editor:{type:'datebox', options:{onChange:setDays1,editable:false,showSeconds:false}},formatter:ChangeDateFormat1">出发日期</th>
				<th data-options="field:'travelDateEnd',width:140,align:'center',editor:{type:'datebox',options:{onChange:setDays2,editable:false,showSeconds:false}},formatter:ChangeDateFormat1">结束日期</th>
				<th data-options="field:'travelAreaName',width:158,align:'center',editor:{type:'textbox',options:{editable:false,icons:[{iconCls:'icon-add',handler: function(e){
									     var row = $('#tracel_itinerary_tab_id').datagrid('getSelected');
									     var index = $('#tracel_itinerary_tab_id').datagrid('getRowIndex',row);
									     selectRegionDetail(index)
									     }}]}}">目的地</th>
				<th data-options="field:'vehicle',width:190,align:'center',editor:{
									type:'combobox',
									options:{
									prompt:'--请选择--',
									editable:false,
										valueField:'text',
                               			multiple: true,
										textField:'text',
										method:'post',
										url:base+'/apply/comboboxJson',
										onHidePanel:reloadOut
									}}">交通工具</th>
				<th data-options="field:'vehicleId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'travelArea',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'travelAttendPeopId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'travelPersonnelLevel',hidden:true,editor:{type:'textbox',options:{editable:false,onChange:onChangeApplyPersonnelLeve}}"></th>
			</tr>
		</thead>
	</table>
	<c:if test="${empty detail}">
	<div id="itinerary_toolbar_Id" style="height:30px;padding-top : 8px">
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" id="removeId" onclick="removeitItinerary()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" id="appendId" onclick="appendItinerary()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
	</div>
	</c:if>
	<input type="hidden" id="hotelTotalDays"  />
	<input type="hidden" id="travelTotalDays"  />
	<input type="hidden" id="hotelTotalDays"  />
	<input type="hidden" id="travelPeopJson" name="travelPeop" />
</div>
<script type="text/javascript">

function addOutInfo(){
	$('#tracel_itinerary_tab_id').datagrid('acceptChanges');
	var itinerary = $("#tracel_itinerary_tab_id").datagrid('getRows');
	var outRows = $("#outside_traffic_tab_id").datagrid('getRows');
	for(var i = outRows.length-1 ; i >= 0 ; i--){
		$('#outside_traffic_tab_id').datagrid('deleteRow',i);
	}
	for (var i = 0; i < itinerary.length; i++) {
		$('#outside_traffic_tab_id').datagrid('appendRow', {
			fStartDate:itinerary[i].travelDateStart,
			fEndDate:itinerary[i].travelDateEnd,
			vehicle:'',
			vehicleLevel:'',
			travelPersonnel:itinerary[i].travelAttendPeop,
			travelPersonnelId:itinerary[i].travelAttendPeopId,
			applyAmount:0.00
		});
	}
	calcOut();
}

//根据行程单更新伙食补助信息
function addInCityAndFoodInfo(){
	acceptItinerary();
	accept2();
	var recOtherDg = $('#rec-other-dg').datagrid('getRows');//城市间交通费
	for (var i = recOtherDg.length-1; i >= 0 ; i--) {
		$('#rec-other-dg').datagrid('deleteRow',i);
	}
	accepts2();
	var recOthersDg = $('#rec-others-dg').datagrid('getRows');//城市间交通费
	for (var i = recOthersDg.length-1; i >= 0 ; i--) {
		$('#rec-others-dg').datagrid('deleteRow',i);
	}
	$('#applyTotalAmount').html('0.00[元]');
	var rows = $('#tracel_itinerary_tab_id').datagrid('getRows');
	var travelPeop = "";
	if(rows==''){
		return false;
	}else{
		travelPeop = JSON.stringify(rows);
	}
	$.ajax({
		type:'post',
		async:false,
		dataType:'json',
		url:base+'/hotelStandard/getStandard',
		data:{
			list:travelPeop
			},
		success:function (data){
			var foodAmountTeacher = 0.00;
			var foodAmountStudent = 0.00;
			var cityAmountTeacher = 0.00;
			var cityAmountStudent = 0.00;
			for (var i = 0; i < data.length; i++) {
				if(data[i][6]=="teacher"){
					foodAmountTeacher = foodAmountTeacher+parseFloat(data[i][3]);
					cityAmountTeacher = cityAmountTeacher+parseFloat(data[i][2]);
				}else{
					foodAmountStudent = foodAmountStudent+parseFloat(data[i][3]);
					cityAmountStudent = cityAmountStudent+parseFloat(data[i][2]);
				}
				
			}
			$('#rec-other-dg').datagrid('appendRow', {
				fCostName: '城市间交通费',
				fType: 1
			});
			$('#rec-other-dg').datagrid('appendRow', {
				fCostName: '住宿费',
				fType: 1
			});
			$('#rec-other-dg').datagrid('appendRow', {
				fCostName: '伙食补助费',
				fCostStd: foodAmountTeacher,
				fStudentCostStd:foodAmountStudent,
				fType: 1
			});
			$('#rec-other-dg').datagrid('appendRow', {
				fCostName: '市内交通费',
				fCostStd: cityAmountTeacher,
				fStudentCostStd:cityAmountStudent,
				fType: 1
			});
			$('#rec-others-dg').datagrid('appendRow', {
				fCostName: '会务费',
				fType: 2
			});
			$('#rec-others-dg').datagrid('appendRow', {
				fCostName: '培训费',
				fType: 2
			});
		}
	});
}



//接待人员表格添加删除，保存方法
var editIndexItinerary = undefined;
function endEditingItinerary() {
	if (editIndexItinerary == undefined) {
		return true;
	}
	if ($('#tracel_itinerary_tab_id').datagrid('validateRow', editIndexItinerary)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#tracel_itinerary_tab_id').datagrid('getEditors', editIndexItinerary);
		var text4=tr[4].target.combobox('getText');
		if(text4!='--请选择--'){
			tr[4].target.combobox('setValue',text4);
		}
		$('#tracel_itinerary_tab_id').datagrid('endEdit', editIndexItinerary);
		
		userdata();
		editIndexItinerary = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowItinerary(index) {
	if (editIndexItinerary != index) {
		if (endEditingItinerary()) {
			$('#tracel_itinerary_tab_id').datagrid('selectRow', index).datagrid('beginEdit',index);
			editIndexItinerary = index;
		} else {
			$('#tracel_itinerary_tab_id').datagrid('selectRow', editIndexItinerary);
		}
	}
}
function appendItinerary() {
	if (endEditingItinerary()) {
		$('#tracel_itinerary_tab_id').datagrid('appendRow', {
		});
		editIndexItinerary = $('#tracel_itinerary_tab_id').datagrid('getRows').length - 1;
		$('#tracel_itinerary_tab_id').datagrid('selectRow', editIndexItinerary).datagrid('beginEdit',editIndexItinerary);
	}
}
function removeitItinerary() {
	if (editIndexItinerary == undefined) {
		return
	}
	$('#tracel_itinerary_tab_id').datagrid('cancelEdit', editIndexItinerary).datagrid('deleteRow',
			editIndexItinerary);
	editIndexItinerary = undefined;
	var rows = $('#tracel_itinerary_tab_id').datagrid('getRows');
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
function acceptItinerary() {
	if (endEditingItinerary()) {
		$('#tracel_itinerary_tab_id').datagrid('acceptChanges');
	}
}
	
//计算天数
function setDays1(newValue,oldValue) {
	var index=$('#tracel_itinerary_tab_id').datagrid('getRowIndex',$('#tracel_itinerary_tab_id').datagrid('getSelected'));
    var editors = $('#tracel_itinerary_tab_id').datagrid('getEditors', index);  
    var day1 = editors[0]; 
    var day2 = editors[1]; 
    startday = new Date(day1.target.val());
    endday = new Date(day2.target.val());
    if(day1!=''&&day2!=''){
    	if(endday<startday){
    		alert("结束日期不能小于开始日期！");
    		editors[0].target.datetimebox('setValue', '');
    	}
    }
}

function setDays2(newValue,oldValue) {
	var totalDays = 0;
	var fsumDays = 0;
	var index=$('#tracel_itinerary_tab_id').datagrid('getRowIndex',$('#tracel_itinerary_tab_id').datagrid('getSelected'));
	var rows = $('#tracel_itinerary_tab_id').datagrid('getRows');
    var editors = $('#tracel_itinerary_tab_id').datagrid('getEditors', index);  
    var day1 = editors[0]; 
    var day2 = editors[1]; 
    startday = new Date(day1.target.val());
    endday = new Date(day2.target.val());
    if(day1!=''&&day2!=''){
    	if(endday<startday){
    		alert("结束日期不能小于开始日期！");
    		editors[1].target.datetimebox('setValue', '');
    	}
    }
}
//未编辑或者已经编辑完毕的行，计算天数
function addNum(rows,index){
	var totalDays=0;
	var startday=new Date(rows[index]['startTime']);
	var endday=new Date (rows[index]['endTime']);
	if(startday!="" && startday!=null && endday!="" && endday!=null){
		totalDays = (endday - startday) / 86400000 + 1;
	}
	return totalDays;
}

function reload(rec){
	var row = $('#tracel_itinerary_tab_id').datagrid('getSelected');
	var rindex = $('#tracel_itinerary_tab_id').datagrid('getRowIndex', row); 
	var ed = $('#tracel_itinerary_tab_id').datagrid('getEditor',{
		index:rindex,
		field : 'vehicleLevel'  
	});
	if(rec.code !='JTGJ06'){
		var url = base+'/vehicle/comboboxJson?selected=${travelBean.vehicle}&parentCode='+rec.code;
    	$(ed.target).combotree('reload', url);
	}
}

var userdatajson = '';

/**
 * 保存行程中人员信息
 */
function userdata(){
	var rows = $('#tracel_itinerary_tab_id').datagrid('getRows');
	if(rows==''){
		return false;
	}else{
		userdatajson='';
		for (var i = 0; i < rows.length; i++) {
			userdatajson=userdatajson+'{label:\''+rows[i].travelAttendPeop+'\',value:\''+rows[i].travelAttendPeopid+'\'},';
		}
		userdatajson = userdatajson.substring(0,userdatajson.length-1);
		userdatajson='['+userdatajson+']';
		return true;
	}
}



function isineraryJson(){
	acceptItinerary();
	var rows2 = $('#tracel_itinerary_tab_id').datagrid('getRows');
	var travelPeop = "";
	if(rows2==''){
		return false;
	}else{
		for (var i = 0; i < rows2.length; i++) {
			travelPeop = travelPeop + JSON.stringify(rows2[i]) + ",";
		}
		$('#travelPeopJson').val(travelPeop);
		return true;
	}
}

//选择地址
function selectRegionDetail(index) {
	var travelPersonnelLevel = $('#tracel_itinerary_tab_id').datagrid('getEditor',{
		index:index,
		field : 'travelPersonnelLevel'  
	});
	var travelArea = $('#tracel_itinerary_tab_id').datagrid('getEditor',{
		index:index,
		field : 'travelArea'  
	});
	var level = $(travelPersonnelLevel.target).textbox('getValue');
	var areaId = $(travelArea.target).textbox('getValue');
	if(level==""){
		alert("请先选择出行人员！");
		return false;
	}
	
	var win = creatFirstWin('选择-地区', 640, 580, 'icon-search', '/apply/choose?index='+index+'&type=travel&tabId=tracel_itinerary_tab_id'+'&areaId='+areaId);
	win.window('open');

}
//选择人员
function selectTravelAttendPeop(index) {
	var travelAttendPeopId = $('#tracel_itinerary_tab_id').datagrid('getEditor',{
		index:index,
		field : 'travelAttendPeopId'  
	});
	var peopId = $(travelAttendPeopId.target).textbox('getValue');
	var win = creatFirstWin('选择-人员', 640, 580, 'icon-search', '/apply/chooseUser?index='+index+'&editType=travel&tabId=tracel_itinerary_tab_id'+'&peopId='+peopId);
	win.window('open');

}
var sign = 0;
//获取行程单里面的最早时间和最晚时间
function onClickCellStudenttab(){
	var index=$('#tracel_itinerary_tab_id').datagrid('getRowIndex',$('#tracel_itinerary_tab_id').datagrid('getSelected'));
	$('#tracel_itinerary_tab_id').datagrid('selectRow', index).datagrid('beginEdit',index);
		var new_arrs= new_arr_students();
		var fName = $('#tracel_itinerary_tab_id').datagrid('getEditor',{
			index:index,
			field:'fName'
		});
		$(fName.target).combobox({
            data: new_arrs,
            valueField: 'id',
            multiple: true,
            textField: 'text',
		});
}

//选中时给出行人员设置id
function personnerStudentId(){
	var index=$('#tracel_itinerary_tab_id').datagrid('getRowIndex',$('#tracel_itinerary_tab_id').datagrid('getSelected'));
	var fIdentityNumber = $('#tracel_itinerary_tab_id').datagrid('getEditor',{
		index:index,
		field:'fIdentityNumber'
	});
	var fName = $('#tracel_itinerary_tab_id').datagrid('getEditor',{
		index:index,
		field:'fName'
	});
	$(fIdentityNumber.target).textbox('setValue', fName.target.combobox('getValues'));
}

function new_arr_students(){
	var rows = $('#tracel_students_tab_id').datagrid('getRows');
	var arrs = new Array();
	for (var i = 0; i < rows.length; i++) {
	var fIdentityNumber = rows[i].fIdentityNumber.split(',');
	var fName = rows[i].fName.split(',');
	if(fIdentityNumber.length>1){
		for (var j = 0; j < fIdentityNumber.length; j++) {
			var idAndName = {};
			idAndName.id = fIdentityNumber[j];
			idAndName.text = fName[j];
			arrs.push(idAndName);
		}
	}else{
		var idAndName = {};
		idAndName.id = rows[i].fIdentityNumber;
		idAndName.text = rows[i].fName;
		arrs.push(idAndName);
	}
	}
	for (var h = 0; h < arrs.length; h++) {
		for (var c =h+1; c <arrs.length; ) {
		    if (arrs[h].id == arrs[c].id ) {//通过id属性进行匹配；
		    	arrs.splice(c, 1);//去除重复的对象；
			}else {
			c++;
			}
		}
		}
	return arrs;
}


function isornos(val){
	if(val=='1'){
		return '男';
	}else if(val=='0'){
		return '女';
	}else{
		return '';
	}
}

function addProInfo(){
	acceptIndex();
	var indexRows = $("#index_tab_id").datagrid('getRows');
	for(var i = indexRows.length-1 ; i >= 0 ; i--){
		$('#index_tab_id').datagrid('deleteRow',i);
	}
	$('#index_tab_id').datagrid('appendRow', {
		fCostName:'差旅费',
		fCostTheir:'教师费用',
		fCostAmount:0,
		fCostClassify:'',
		fIndexId:'',
		fIndexType:''
	});
	$('#index_tab_id').datagrid('appendRow', {
		fCostName:'差旅费',
		fCostTheir:'学生费用',
		fCostAmount:0,
		fCostClassify:'',
		fIndexId:'',
		fIndexType:''
	});
	$('#index_tab_id').datagrid('appendRow', {
		fCostName:'会务费',
		fCostTheir:'教师费用',
		fCostAmount:0,
		fCostClassify:'',
		fIndexId:'',
		fIndexType:''
	});
	$('#index_tab_id').datagrid('appendRow', {
		fCostName:'会务费',
		fCostTheir:'学生费用',
		fCostAmount:0,
		fCostClassify:'',
		fIndexType:''
	});
	$('#index_tab_id').datagrid('appendRow', {
		fCostName:'培训费',
		fCostTheir:'教师费用',
		fCostAmount:0,
		fCostClassify:'',
		fIndexType:''
	});
	$('#index_tab_id').datagrid('appendRow', {
		fCostName:'培训费',
		fCostTheir:'学生费用',
		fCostAmount:0,
		fCostClassify:'',
		fIndexType:''
	});
}

function reloadOut(rec){
	var row = $('#tracel_itinerary_tab_id').datagrid('getSelected');
	var rindex = $('#tracel_itinerary_tab_id').datagrid('getRowIndex', row); 
	var vehicleId = $('#tracel_itinerary_tab_id').datagrid('getEditor',{
		index:rindex,
		field : 'vehicleId'  
	});
	var vehicle = $('#tracel_itinerary_tab_id').datagrid('getEditor',{
		index:rindex,
		field : 'vehicle'  
	});
	$(vehicleId.target).textbox('setValue', $(vehicle.target).combotree('getValues'));
}


function onChangeApplyPersonnelLeve(newVal,oldVal){
	var row = $('#tracel_itinerary_tab_id').datagrid('getSelected');//获得选择行
	var index=$('#tracel_itinerary_tab_id').datagrid('getRowIndex',row);//获得选中行的行号
	var rows = $('#tracel_itinerary_tab_id').datagrid('getRows');
	var num = "";
	for(var i=0;i<rows.length;i++){
		if(i!=index){
			if(rows[i].travelPersonnelLevel!=""&&rows[i].travelPersonnelLevel!=null){
				if(num==""){
					num = rows[i].travelPersonnelLevel;
				}else{
				num = num+","+rows[i].travelPersonnelLevel;
				}
			}
		}
	}
	if(newVal!=""&&newVal!=null) {
		if(num==""){
			num = newVal;
		}else{
			num =num+","+newVal;
		}
	}
	var numArray = num.split(',');
	var arrs = new Array();
	for (var j = 0; j < numArray.length; j++) {
		var leve = {};
		leve = numArray[j];
		arrs.push(leve);
	}
	for (var h = 0; h < arrs.length; h++) {
		for (var c =h+1; c <arrs.length; ) {
		    if (arrs[h]== arrs[c]) {//通过id属性进行匹配；
		    	arrs.splice(c, 1);//去除重复的对象；
			}else {
			c++;
			}
		}
	}
	$("#applyTrafficHintLeadId").remove();
	$("#applyTrafficHintStaffId").remove();
	if(arrs.length>1){
		$("#applyTrafficHintId").html('<a id="applyTrafficHintLeadId" style="color: red">党委书记或校长可乘坐火车软席（软座、软卧），高铁/动车一等座，全列软席列车一等软座 ；轮船（不包括旅游船）二等舱；飞机经济舱<br>其他人员可乘坐火车硬席（硬座、硬卧），高铁/动车二等座、全列软席列车二等软座；轮船（不包括旅游船）三等舱；飞机经济舱</a>');
		$("#fTrafficHint").val("党委书记或校长可乘坐火车软席（软座、软卧），高铁/动车一等座，全列软席列车一等软座 ；轮船（不包括旅游船）二等舱；飞机经济舱<br>其他人员可乘坐火车硬席（硬座、硬卧），高铁/动车二等座、全列软席列车二等软座；轮船（不包括旅游船）三等舱；飞机经济舱");
	}else{
		if(arrs[0]==2){
			$("#applyTrafficHintId").html('<a id="applyTrafficHintLeadId" style="color: red">党委书记或校长可乘坐火车软席（软座、软卧），高铁/动车一等座，全列软席列车一等软座 ；轮船（不包括旅游船）二等舱；飞机经济舱</a>');
		$("#fTrafficHint").val("党委书记或校长可乘坐火车软席（软座、软卧），高铁/动车一等座，全列软席列车一等软座 ；轮船（不包括旅游船）二等舱；飞机经济舱");
		}else{
			if(arrs[0]==3){
				$("#applyTrafficHintId").html('<a id="applyTrafficHintStaffId" style="color: red">其他人员可乘坐火车硬席（硬座、硬卧），高铁/动车二等座、全列软席列车二等软座；轮船（不包括旅游船）三等舱；飞机经济舱</a>');
		$("#fTrafficHint").val("其他人员可乘坐火车硬席（硬座、硬卧），高铁/动车二等座、全列软席列车二等软座；轮船（不包括旅游船）三等舱；飞机经济舱");
			}
		}
	}
}

function onChangeApplyAreaId(shiId){
    var row = $('#tracel_itinerary_tab_id').datagrid('getSelected');
    var index = $('#tracel_itinerary_tab_id').datagrid('getRowIndex',row);
	var rows = $('#tracel_itinerary_tab_id').datagrid('getRows');
	var travelArea = $('#tracel_itinerary_tab_id').datagrid('getEditor',{
		index:index,
		field : 'travelArea'  
	});
	var travelPersonnelLevel = $('#tracel_itinerary_tab_id').datagrid('getEditor',{
		index:index,
		field : 'travelPersonnelLevel'  
	});
	var levels = $(travelPersonnelLevel.target).textbox('getValue');
	var num = "";
	for(var i=0;i<rows.length;i++){
		if(i!=index){
			if(rows[i].travelPersonnelLevel!=""&&rows[i].travelPersonnelLevel!=null){
				if(num==""){
					num = rows[i].travelPersonnelLevel;
				}else{
				num = num+","+rows[i].travelPersonnelLevel;
				}
			}
		}
	}
	if(levels!=""&&levels!=null) {
		if(num==""){
			num = levels;
		}else{
			num =num+","+levels;
		}
	}
	

	var id = $(travelArea.target).textbox('getValue');
	var num1 = "";
	for(var j=0;j<rows.length;j++){
		if(j!=index){
			if(rows[j].travelArea!=""&&rows[j].travelArea!=null){
				if(num1==""){
					num1 = rows[j].travelArea;
				}else{
					num1 = num1+","+rows[j].travelArea;
				}
			}
		}
	}
	if(id!=""&&id!=null) {
		if(num1==""){
			num1 = id;
		}else{
			num1 =num1+","+id;
		}
	}
	var idString = shuzuquchong(num1);//数组地区ID去重
	var levesString = shuzuquchong(num);//数组级别去重
	
	$("#applyHotelHintLeadId").remove();
	$.ajax({
		type:'post',
		async:false,
		dataType:'json',
		url:base+'/hotelStandard/getHotelStandardRegionId?id='+shiId+'&level='+levesString,
		success:function (data){
			$("#applyHotelHintId").html('<a id="applyHotelHintLeadId" style="color: red">'+data+'</a>');
			$("#fHotelHint").val(data);
		}
	});
}

function shuzuquchong(num){
	var numArray = num.split(',');
	var arrs = new Array();
	for (var j = 0; j < numArray.length; j++) {
		var leve = {};
		leve = numArray[j];
		arrs.push(leve);
	}
	for (var h = 0; h < arrs.length; h++) {
		for (var c =h+1; c <arrs.length; ) {
		    if (arrs[h]== arrs[c]) {//通过id属性进行匹配；
		    	arrs.splice(c, 1);//去除重复的对象；
			}else {
			c++;
			}
		}
	}
	return arrs.toString();
}
</script>