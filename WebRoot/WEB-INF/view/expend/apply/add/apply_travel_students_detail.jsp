<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<script type="text/javascript">

function addStudents(){
	acceptStudents();
	var rows = $('#tracel_students_tab_id').datagrid('getRows');
	if(rows==''){
		alert("请添加行程清单明细！");
		return false;
	}
	var travelType = $("#travelType").combobox('getValue');
	if(travelType==''){
		alert("请选择出差类型");
		return;
	}
	for(var i=0;i<rows.length;i++){
		if(rows[i].travelDateStart==''){
			alert("请填写行程清单上的出发日期！");
			return false;
		}
		if(rows[i].travelDateEnd==''){
			alert("请填写行程清单上的撤离日期/抵津日期！");
			return false;
		}
		if(rows[i].travelAreaName==''){
			alert("请填写行程清单上的目的地！");
			return false;
		}
		if(rows[i].travelAttendPeop==''){
			alert("请填写行程清单上的人员信息！");
			return false;
		}
		if(rows[i].reason==''){
			alert("请填写行程清单上的主要工作内容！");
			return false;
		}
	}
	
	$("#addStudentId").hide();
	$("#removeStudentId").hide();
	$("#appendStudentId").hide();
	$("#editStudentId").show();
	$("#outsideRemoveitId").show();
	$("#outsideAppendId").show();
	$("#hotelRemoveId").show();
	$("#hotelAppendId").show();
	$('#travelType').combobox('readonly',true);
/* 	$('#outside_traffic_tab_id_apply').datagrid('reload');
	$('#hoteltabApply').datagrid('reload'); */
	editIndexOutsideTraffic = undefined;
	editIndexHotel = undefined;
	var hoteltabRows = $('#hoteltabApply').datagrid('getRows');//住宿费
	for (var i = hoteltabRows.length-1; i >= 0 ; i--) {
		$('#hoteltabApply').datagrid('deleteRow',i);
	}
	$('#hotelAmounts').html('0.00[元]');
	var outsideTrafficRows = $('#outside_traffic_tab_id_apply').datagrid('getRows');//城市间交通费
	for (var i = outsideTrafficRows.length-1; i >= 0 ; i--) {
		$('#outside_traffic_tab_id_apply').datagrid('deleteRow',i);
	}
	$('#applyOutsideTrafficAmount').html('0.00[元]');
	addInCityAndFoodInfo();
	maxTimeAndMinTime();//获取最大最小时间
	var outsideAmount = 0.00;
	var cityAmount = $("#cityAmount").val();
	var hotelAmount = 0.00;
	var foodAmount = $("#foodAmount").val();
	if(outsideAmount=='NaN'||outsideAmount==''||outsideAmount==undefined||outsideAmount==null){
		outsideAmount=0;
	}
	if(cityAmount=='NaN'||cityAmount==''||cityAmount==undefined||cityAmount==null){
		cityAmount=0;
	}
	if(hotelAmount=='NaN'||hotelAmount==''||hotelAmount==undefined||hotelAmount==null){
		hotelAmount=0;
	}
	if(foodAmount=='NaN'||foodAmount==''||foodAmount==undefined||foodAmount==null){
		foodAmount=0;
	}
	$("#applyTotalAmount").html(listToFixed((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount)))+"元");
	$("#applyAmount").val((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount)).toFixed(2));
	sign1 =1;
}
function editStudents(){
	sign1 = 0;
	$("#addStudentId").show();
	$("#removeStudentId").show();
	$("#appendStudentId").show();
	$("#editStudentId").hide();
	$("#outsideRemoveitId").hide();
	$("#outsideAppendId").hide();
	$("#hotelRemoveId").hide();
	$("#hotelAppendId").hide();
	$('#travelType').combobox('readonly',false);
	accepthotel();
	acceptOutsideTraffic();
}
function addOutInfo(){
	$('#tracel_students_tab_id').datagrid('acceptChanges');
	var itinerary = $("#tracel_students_tab_id").datagrid('getRows');
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
function addHotelInfo(){
	$('#tracel_students_tab_id').datagrid('acceptChanges');
	var itinerary = $("#tracel_students_tab_id").datagrid('getRows');
	var outRows = $("#hoteltabApply").datagrid('getRows');
	for(var i = outRows.length-1 ; i >= 0 ; i--){
		$('#hoteltabApply').datagrid('deleteRow',i);
	}
	for (var i = 0; i < itinerary.length; i++) {
		//console.log(itinerary[i].travelAttendPeopId);
		var days;//天数
		var day1 = Date.parse(new Date(itinerary[i].travelDateEnd));//结束时间
		var day2 = Date.parse(new Date(itinerary[i].travelDateStart));//开始时间
		days = parseInt((day1-day2)/ (1000 * 60 * 60 * 24));//核心：时间戳相减，然后除以天数
		if(!isNaN(day2)&&!isNaN(day1)){
			days+=1;
		}
		days=isNaN(days)?0:days;
		$.ajax({
			type:'post',
			async:false,
			dataType:'json',
			url:base+'/hotelStandard/calcCost?outType=travel&configId='+itinerary[i].travelAreaId+'&travelDays='+days+'&hotelDays='+(days-1)+'&userId='+itinerary[i].travelAttendPeopId+'&day1='+itinerary[i].travelDateStart+'&day2='+itinerary[i].travelDateEnd,
			success:function (data){
				$('#hoteltabApply').datagrid('appendRow', {
					checkInTime:itinerary[i].travelDateStart,
					checkOUTTime:itinerary[i].travelDateEnd,
					CityId:itinerary[i].travelAreaId,
					locationCity:itinerary[i].travelAreaName,
					travelPersonnel:itinerary[i].travelAttendPeop,
					travelPersonnelId:itinerary[i].travelAttendPeopId,
					applyAmount:parseFloat(data[0].standard)*(days-1),
				});
			}
		});
	}
	calcHotel();
}


//根据行程单更新伙食补助信息
function addInCityAndFoodInfo(){
	var travleType =$("#travelType").combobox('getValue');
	
	acceptStudents();
	var foodrows = $('#foodtab').datagrid('getRows');
	for(var i = foodrows.length-1 ; i >= 0 ; i--){
		$('#foodtab').datagrid('deleteRow',i);
	}
	var inCityTabRows = $('#in_city_tab_id').datagrid('getRows');
	for(var i = inCityTabRows.length-1 ; i >= 0 ; i--){
		$('#in_city_tab_id').datagrid('deleteRow',i);
	}
	var rows = $('#tracel_students_tab_id').datagrid('getRows');
	var travelPeop = "";
	if(rows==''){
		return false;
	}else{
		travelPeop = JSON.stringify(rows);
	}
	travelPeop =encodeURI(travelPeop);
	$.ajax({
		type:'post',
		async:false,
		dataType:'json',
		url:base+'/hotelStandard/getStandard?list='+travelPeop,
		success:function (data){
			for (var i = 0; i < data.length; i++) {
				if(travleType=='HWCXXLQ'){
					$('#foodtab').datagrid('appendRow',{
						fname:data[i][0],
						fDays:data[i][1],
						fApplyAmount:parseFloat(50)*parseFloat(data[i][1]),
					});
					$('#in_city_tab_id').datagrid('appendRow',{
						fPerson:data[i][0],
						fSubsidyDay:data[i][1],
						fApplyAmount:parseInt(50)*parseFloat(data[i][1]),
					});
				}else{
					if(travleType=='HWCXXGQ'){
						$('#foodtab').datagrid('appendRow',{
							fname:data[i][0],
							fDays:data[i][1],
							fApplyAmount:parseFloat(50)*parseFloat(data[i][1]),
						});
						
						$('#in_city_tab_id').datagrid('appendRow',{
							fPerson:data[i][0],
							fSubsidyDay:data[i][1],
							fApplyAmount:parseInt(100)*parseFloat(data[i][1]),
						});
						
					}else{
						$('#foodtab').datagrid('appendRow',{
							fname:data[i][0],
							fDays:data[i][1],
							fApplyAmount:parseFloat(data[i][3]),
						});
						
						$('#in_city_tab_id').datagrid('appendRow',{
							fPerson:data[i][0],
							fSubsidyDay:data[i][1],
							fApplyAmount:parseInt(data[i][2]),
						});
					}
				}
			}
			calcInCity();
			calcFoodCost();
		}
	});
}



//接待人员表格添加删除，保存方法
var editIndexStudents = undefined;
function endEditingStudents() {
	if (editIndexStudents == undefined) {
		return true
	}
	if ($('#tracel_students_tab_id').datagrid('validateRow', editIndexStudents)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#tracel_students_tab_id').datagrid('getEditors', editIndexStudents);
		$('#tracel_students_tab_id').datagrid('endEdit', editIndexStudents);
		userdata();
		editIndexStudents = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowStudents(index) {
	if(sign1==0){
	if (editIndexStudents != index) {
		if (endEditingStudents()) {
			$('#tracel_students_tab_id').datagrid('selectRow', index).datagrid('beginEdit',index);
			editIndexStudents = index;
			editStudents();
		} else {
			$('#tracel_students_tab_id').datagrid('selectRow', editIndexStudents);
		}
	}
	
	}else{
		alert("请先点击随行学生名单修改按钮！");
		return false;
	}
}
function appendStudents() {
	if (endEditingStudents()) {
		$('#tracel_students_tab_id').datagrid('appendRow', {
		});
		editIndexStudents = $('#tracel_students_tab_id').datagrid('getRows').length - 1;
		$('#tracel_students_tab_id').datagrid('selectRow', editIndexStudents).datagrid('beginEdit',editIndexStudents);
	}
}
function removeitStudents() {
	if (editIndexStudents == undefined) {
		return
	}
	$('#tracel_students_tab_id').datagrid('cancelEdit', editIndexStudents).datagrid('deleteRow',
			editIndexStudents);
	editIndexStudents = undefined;
	var rows = $('#tracel_students_tab_id').datagrid('getRows');
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
function acceptStudents() {
	if (endEditingStudents()) {
		$('#tracel_students_tab_id').datagrid('acceptChanges');
	}
}
	
	
//计算天数
function setDays1(newValue,oldValue) {
	
	//var totalDays = 0;
	//var fsumDays = 0;
	var index=$('#tracel_students_tab_id').datagrid('getRowIndex',$('#tracel_students_tab_id').datagrid('getSelected'));
	//var rows = $('#tracel_students_tab_id').datagrid('getRows');
    var editors = $('#tracel_students_tab_id').datagrid('getEditors', index);  
    var day1 = editors[0]; 
    var day2 = editors[1]; 
    startday = new Date(day1.target.val());
    endday = new Date(day2.target.val());
    if(day1!=''&&day2!=''){
    	if(endday<startday){
    		alert("结束日期不能小于开始日期！");
    		editors[0].target.datebox('setValue', '');
    	}
    }
	/* for(var i=0;i<rows.length;i++){
		if(i==index){
			fsumDays=setEditing(rows,i);
		}else{
			totalDays+=addNum(rows,i);
		}
		totalDays =fsumDays+totalDays;
		//$('#travelTotalDays').val(totalDays);
		//$('#hotelTotalDays').val(totalDays);
	} */
	
}

function setDays2(newValue,oldValue) {
	var totalDays = 0;
	var fsumDays = 0;
	var index=$('#tracel_students_tab_id').datagrid('getRowIndex',$('#tracel_students_tab_id').datagrid('getSelected'));
	var rows = $('#tracel_students_tab_id').datagrid('getRows');
    var editors = $('#tracel_students_tab_id').datagrid('getEditors', index);  
    var day1 = editors[0]; 
    var day2 = editors[1]; 
    startday = new Date(day1.target.val());
    endday = new Date(day2.target.val());
    if(day1!=''&&day2!=''){
    	if(endday<startday){
    		alert("结束日期不能小于开始日期！");
    		editors[1].target.datebox('setValue', '');
    	}
    }
	/* for(var i=0;i<rows.length;i++){
		if(i==index){
			fsumDays=setEditing(rows,i);
		}else{
			totalDays+=addNum(rows,i);
		}
		totalDays =fsumDays+totalDays;
		//$('#travelTotalDays').val(totalDays);
		//$('#hotelTotalDays').val(totalDays);
	} */
	
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
//对于正在编辑的行，计算天数
/* function setEditing(rows,index){
    var editors = $('#tracel_students_tab_id').datagrid('getEditors', index);  
    var day1 = editors[0]; 
    var day2 = editors[1]; 
    var travelDays =editors[8];
    var hotelDays =editors[9];
	startday = new Date(day1.target.val());
    endday = new Date(day2.target.val());
    var totalDays = (endday - startday) / 86400000 + 1;
    travelDays.target.numberbox('setValue', totalDays);
    hotelDays.target.numberbox('setValue', totalDays-1);
    return totalDays;
} */

function reload(rec){
	var row = $('#tracel_students_tab_id').datagrid('getSelected');
	var rindex = $('#tracel_students_tab_id').datagrid('getRowIndex', row); 
	var ed = $('#tracel_students_tab_id').datagrid('getEditor',{
		index:rindex,
		field : 'vehicleLevel'  
	});
	if(rec.code !='JTGJ06'){
		var url = base+'/vehicle/comboboxJson?selected=${travelBean.vehicle}&parentCode='+rec.code;
    	$(ed.target).combotree('reload', url);
	}/* else{
		$('#vehicleOther1').css('display','');
		$('#vehicleOther2').css('display','');
		$('#vehicleLevel1').css('display','none');
		$('#vehicleLevel2').css('display','none');
	}
	 $(ed.target).combobox('setValue', '2016');  */
}

var userdatajson = '';

/**
 * 保存行程中人员信息
 */
function userdata(){
	var rows = $('#tracel_students_tab_id').datagrid('getRows');
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



function studentsPeopJson(){
	acceptStudents();
	var rows2 = $('#tracel_students_tab_id').datagrid('getRows');
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

//选择地址
function selectRegionDetail(index) {
	var win = creatFirstWin('选择-地区', 640, 580, 'icon-search', '/apply/choose?index='+index+'&type=travel&tabId=tracel_students_tab_id');
	win.window('open');

}
//选择人员
function selectTravelAttendPeop(index) {
	var win = creatFirstWin('选择-人员', 640, 580, 'icon-search', '/apply/chooseUser?index='+index+'&editType=travel&tabId=tracel_students_tab_id');
	win.window('open');

}
var sign1 = 0;
//获取行程单里面的最早时间和最晚时间
function maxTimeAndMinTime(){
	var arr = [];
	var rows = $('#tracel_students_tab_id').datagrid('getRows');
	
	for (var i = 0; i < rows.length; i++) {
		var dayStart = Date.parse(new Date(rows[i].travelDateStart));
		var dayEnd = Date.parse(new Date(rows[i].travelDateEnd));
		arr.push(dayStart);
		arr.push(dayEnd);
	}
	var maxTime = Math.max.apply(null, arr);
	var minTime = Math.min.apply(null, arr);
	$("#maxTime").val(maxTime);
	$("#minTime").val(minTime);
	var gId = '${bean.gId}';
	if(gId!=''){
		$("#addStudentId").hide();
		$("#removeStudentId").hide();
		$("#appendStudentId").hide();
		$("#editStudentId").show();
		$("#outsideRemoveitId").show();
		$("#outsideAppendId").show();
		$("#hotelRemoveId").show();
		$("#hotelAppendId").show();
		$('#travelType').combobox('readonly',true);
		sign1 =1;
		//applyTotalAmount();
	}
}

function maleOrFemale(val){
	
	if(val=='1'){
		return '男';
	}else if(val=='0'){
		return '女';
	}else{
		return '';
	}
}
</script>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="tracel_students_tab_id" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#students_toolbar_Id',
	<c:if test="${!empty bean.gId}">
	url: '${base}/apply/applyStudentsPage?gId=${bean.gId}',
	</c:if>
	<c:if test="${empty bean.gId}">
	url: '',
	</c:if>
	method: 'post',
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
	                	prompt:'-请选择-',panelHeight:'atuo',editable: false}},formatter:maleOrFemale">性别</th>
				<th data-options="field:'fIdentityNumber',width:210,align:'center',editor:{type:'textbox', options:{requerd:true}}">身份证号</th>
				<th data-options="field:'fTel',width:190,align:'center',editor:{type:'numberbox', options:{requerd:true}}">联系电话</th>
			</tr>
		</thead>
	</table>
	<input type="hidden" id="hotelTotalDays"  />
	<input type="hidden" id="travelTotalDays"  />
	<input type="hidden" id="hotelTotalDays"  />
	<input type="hidden" id="studentsPeopJson" name="studentsJson" />
</div>
