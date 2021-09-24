<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="reimburse_itinerary_tab_id" class="easyui-datagrid" style="width:695px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#reimburse_itinerary_toolbar_Id',
	<c:if test="${!empty applyBean.gId&&operation=='add'}">
	url: '${base}/apply/applyTravelPage?gId=${applyBean.gId}',
	</c:if>
	<c:if test="${!empty bean.rId&&operation=='edit'}">
	url: '${base}/reimburse/applyTravelPage?rId=${bean.rId}',
	</c:if>
	method: 'post',
	<c:if test="${!empty operation}">
	onClickRow: onClickRowItinerary,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	onLoadSuccess:maxTimeAndMinTimeReims,
	">
		<thead>
			<tr>
				<th data-options="field:'trId',hidden:true"></th>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'travelAttendPeop',width:260,align:'center',editor:{type:'textbox',options:{editable:false,icons:[{iconCls:'icon-add',handler: function(e){
					     var row = $('#reimburse_itinerary_tab_id').datagrid('getSelected');
					     var index = $('#reimburse_itinerary_tab_id').datagrid('getRowIndex',row);
					     selectTravelAttendPeop(index)
					     }}]}}">同行人（可多选）</th>
				<th data-options="field:'travelDateStart',width:120,align:'center',editor:{type:'datebox', options:{onChange:setDays1,editable:false}},formatter:ChangeDateFormat">出发日期</th>
				<th data-options="field:'travelDateEnd',width:120,align:'center',editor:{type:'datebox',options:{onChange:setDays2,editable:false}},formatter:ChangeDateFormat">撤离日期/抵津日期</th>
				<th data-options="field:'travelAreaName',width:158,align:'center',editor:{type:'textbox',options:{editable:false,icons:[{iconCls:'icon-add',handler: function(e){
									     var row = $('#reimburse_itinerary_tab_id').datagrid('getSelected');
									     var index = $('#reimburse_itinerary_tab_id').datagrid('getRowIndex',row);
									     selectRDetailReim(index)
									     }}]}}">目的地</th>
				<th data-options="field:'travelArea',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>

				<th data-options="field:'travelAttendPeopId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'travelPersonnelLevel',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
			</tr>
		</thead>
	</table>
	<c:if test="${!empty operation}">
	<div id="reimburse_itinerary_toolbar_Id" style="height:30px;padding-top : 8px">
		<a href="javascript:void(0)" onclick="editItinerary()" id="rEditId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/xg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a href="javascript:void(0)" onclick="rSaveItinerary()" id="rAddId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="rRemoveitItinerary()" id="rrmoveid" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="rAppendItinerary()" id="raddid" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	</c:if>
	
</div>
<script type="text/javascript">
var sign = 0;
var gId = '${applyBean.gId}';
if(gId!=''){
	$("#rAddId").hide();
	$("#rEditId").show();
	$("#rrmoveid").hide();
	$("#raddid").hide();
	
	$('#removeStudentId').hide();
	$('#editStudentId').show();
	$('#addStudentId').hide();
	$('#appendStudentId').hide();
	
	$("#removefoodId").show();
	$("#appendfoodId").show();
	$("#appendCityTrafficId").show();
	$("#removeitCityTrafficId").show();
	$("#routsideRemoveitId").show();
	$("#routsideAppendId").show();
	$("#rhotelRemoveId").show();
	$("#rhotelAppendId").show();
	$("#hotelRemoveId_trip_reim").show();
	$("#hotelAppendId_trip_reim").show();
	sign =1;
}

function rSaveItinerary(){
	acceptItineraryReim();
	acceptOutsideTrafficReim();
	accepthotelReim();

	var rows = $('#reimburse_itinerary_tab_id').datagrid('getRows');
	if(rows==''){
		alert("请添加行程清单明细！");
		return false;
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
	
	sign =1;
	$("#rAddId").hide();
	$("#rEditId").show();
	$("#rrmoveid").hide();
	$("#raddid").hide();
	$("#routsideRemoveitId").show();
	$("#routsideAppendId").show();
	$("#rhotelRemoveId").show();
	$("#rhotelAppendId").show();
	$("#appendCityTrafficId").show();
	$("#removeitCityTrafficId").show();
	$("#hotelRemoveId").show();
	$("#hotelAppendId").show();
	$("#removefoodId").show();
	$("#appendfoodId").show();
	var hoteltabRows = $('#reimbursein_hoteltab').datagrid('getRows');//住宿费
	for (var i = hoteltabRows.length-1; i >= 0 ; i--) {
		$('#reimbursein_hoteltab').datagrid('deleteRow',i);
	}
	editIndex = undefined;
	$('#rhotelAmount').html('0.00[元]');
	var outsideTrafficRows = $('#reimburse_outside_tab_id').datagrid('getRows');//城市间交通费
	for (var i = outsideTrafficRows.length-1; i >= 0 ; i--) {
		$('#reimburse_outside_tab_id').datagrid('deleteRow',i);
	}
	editIndexOutsideTraffic = undefined;
	$('#rOutsideTrafficAmount').html('0.00[元]');
	addInCityAndFoodInfoReimburse();
	maxTimeAndMinTimeReim();
	var outsideAmount = 0.00;
	var cityAmount = $("#cityAmount").val();
	var hotelAmount = 0.00;
	var foodAmount = $("#foodAmount").val();
	if(isNaN(outsideAmount)||outsideAmount==''||outsideAmount==undefined||outsideAmount==null){
		outsideAmount=0;
	}
	if(isNaN(cityAmount) ||cityAmount==''||cityAmount==undefined||cityAmount==null){
		cityAmount=0;
	}
	if(isNaN(hotelAmount) ||hotelAmount==''||hotelAmount==undefined||hotelAmount==null){
		hotelAmount=0;
	}
	if(isNaN(foodAmount) ||foodAmount==''||foodAmount==undefined||foodAmount==null){
		foodAmount=0;
	}
	$("#rapplyTotalAmount").html(listToFixed((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount)))+"元");
	$("#p_amount").html(listToFixed((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount)))+"元");
	$("#reimburseAmount").val((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount).toFixed(2)));
	cx();

}
function editItinerary(){
	sign = 0;
	$("#rAddId").show();
	$("#rEditId").hide();
	$("#rrmoveid").show();
	$("#raddid").show();
	$("#routsideRemoveitId").hide();
	$("#routsideAppendId").hide();
	$("#rhotelRemoveId").hide();
	$("#appendCityTrafficId").hide();
	$("#removeitCityTrafficId").hide();
	$("#rhotelAppendId").hide();
	$("#hotelRemoveId").hide();
	$("#hotelAppendId").hide();
	$("#removefoodId").hide();
	$("#appendfoodId").hide();
	accepthotelReim();
	acceptOutsideTrafficReim();
	acceptfoodReim();
	acceptInCityReim();
}
function addOutInfo(){
	$('#reimburse_itinerary_tab_id').datagrid('acceptChanges');
	var itinerary = $('#reimburse_itinerary_tab_id').datagrid('getRows');
	var outRows = $("#reimburse_outside_tab_id").datagrid('getRows');
	for(var i = outRows.length-1 ; i >= 0 ; i--){
		$('#reimburse_outside_tab_id').datagrid('deleteRow',i);
	}
	for (var i = 0; i < itinerary.length; i++) {
		$('#reimburse_outside_tab_id').datagrid('appendRow', {
			fStartDate:itinerary[i].travelDateStart,
			fEndDate:itinerary[i].travelDateEnd,
			vehicle:'',
			vehicleLevel:'',
			travelAttendPeop:itinerary[i].travelAttendPeop,
			travelAttendPeopId:itinerary[i].travelAttendPeopId,
			applyAmount:parseFloat(0.00),
		});
	}
	calcOutsideTrafficCost();
}

//根据行程单更新伙食补助信息
function addInCityInfo(){
	$('#reimburse_itinerary_tab_id').datagrid('acceptChanges');
	var rows = $('#reimburse_itinerary_tab_id').datagrid('getRows');
	var inCityRows = $('#reimbursein_city_tabs_id').datagrid('getRows');
	for(var i = inCityRows.length-1 ; i >= 0 ; i--){
		$('#reimbursein_city_tabs_id').datagrid('deleteRow',i);
	}
	for(var i = 0 ; i < rows.length ; i++){
		var days;//天数
		var day1 = Date.parse(new Date(rows[i].travelDateEnd));
		var day2 = Date.parse(new Date(rows[i].travelDateStart));
		days = parseInt((day1-day2)/ (1000 * 60 * 60 * 24));//核心：时间戳相减，然后除以天数
		if(!isNaN(day2)&&!isNaN(day1)){
			days+=1;
		}
		var ids = rows[i].travelAttendPeop;
		var idsarray = ids.split(',');
		days=isNaN(days)?0:days;
		var username = rows[i].travelAttendPeop;
		$('#reimbursein_city_tabs_id').datagrid('appendRow',{
			fPerson:username,
			fSubsidyDay:days*parseFloat(idsarray.length),
			fApplyAmount:80*parseFloat(days)*parseFloat(idsarray.length),
		});
	}
	calcInCity();
}

//接待人员表格添加删除，保存方法
var editIndexItinerary = undefined;
function endEditingItinerary() {
	if (editIndexItinerary == undefined) {
		return true
	}
	if ($('#reimburse_itinerary_tab_id').datagrid('validateRow', editIndexItinerary)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		$('#reimburse_itinerary_tab_id').datagrid('endEdit', editIndexItinerary);
		editIndexItinerary = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowItinerary(index) {
	if(sign==0){
		if (editIndexItinerary != index) {
			if (endEditingItinerary()) {
				$('#reimburse_itinerary_tab_id').datagrid('selectRow', index).datagrid('beginEdit',index);
				editIndexItinerary = index;
			} else {
				$('#reimburse_itinerary_tab_id').datagrid('selectRow', editIndexItinerary);
			}
		}
	}else{
		alert("请先点击行程清单修改按钮！");
		return false;
	}
}
function rAppendItinerary() {
	if (endEditingItinerary()) {
		$('#reimburse_itinerary_tab_id').datagrid('appendRow', {
		});
		editIndexItinerary = $('#reimburse_itinerary_tab_id').datagrid('getRows').length - 1;
		$('#reimburse_itinerary_tab_id').datagrid('selectRow', editIndexItinerary).datagrid('beginEdit',editIndexItinerary);
	}
}
function rRemoveitItinerary() {
	if (editIndexItinerary == undefined) {
		return
	}
	$('#reimburse_itinerary_tab_id').datagrid('cancelEdit', editIndexItinerary).datagrid('deleteRow',
			editIndexItinerary);
	editIndexItinerary = undefined;
	var rows = $('#reimburse_itinerary_tab_id').datagrid('getRows');
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
function acceptItineraryReim() {
	if (endEditingItinerary()) {
		$('#reimburse_itinerary_tab_id').datagrid('acceptChanges');
	}
}
	
	
//计算天数
function setDays1(newValue,oldValue) {
	var totalDays = 0;
	var fsumDays = 0;
	var index=$('#reimburse_itinerary_tab_id').datagrid('getRowIndex',$('#reimburse_itinerary_tab_id').datagrid('getSelected'));
	var rows = $('#reimburse_itinerary_tab_id').datagrid('getRows');
    var editors = $('#reimburse_itinerary_tab_id').datagrid('getEditors', index);  
    var day1 = editors[1]; 
    var day2 = editors[2]; 
    startday = new Date(day1.target.datebox('getValue'));
    endday = new Date(day2.target.datebox('getValue'));
    if(day1!=''&&day2!=''){
    	if(endday<startday){
    		alert("结束日期不能小于开始日期！");
    		editors[1].target.datetimebox('setValue', '');
    	}
    }
}

function setDays2(newValue,oldValue) {
	var totalDays = 0;
	var fsumDays = 0;
	var index=$('#reimburse_itinerary_tab_id').datagrid('getRowIndex',$('#reimburse_itinerary_tab_id').datagrid('getSelected'));
	var rows = $('#reimburse_itinerary_tab_id').datagrid('getRows');
    var editors = $('#reimburse_itinerary_tab_id').datagrid('getEditors', index);  
    var day1 = editors[1]; 
    var day2 = editors[2]; 
    startday = new Date(day1.target.datebox('getValue'));
    endday = new Date(day2.target.datebox('getValue'));
    if(day1!=''&&day2!=''){
    	if(endday<startday){
    		alert("结束日期不能小于开始日期！");
    		editors[2].target.datetimebox('setValue', '');
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
	var row = $('#reimburse_itinerary_tab_id').datagrid('getSelected');
	var rindex = $('#reimburse_itinerary_tab_id').datagrid('getRowIndex', row); 
	var ed = $('#reimburse_itinerary_tab_id').datagrid('getEditor',{
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
	var rows = $('#reimburse_itinerary_tab_id').datagrid('getRows');
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
	acceptItineraryReim();
	var rows2 = $('#reimburse_itinerary_tab_id').datagrid('getRows');
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
function selectRDetailReim(index) {
	
	var travelPersonnelLevel = $('#reimburse_itinerary_tab_id').datagrid('getEditor',{
		index:index,
		field : 'travelPersonnelLevel'  
	});
	var travelArea = $('#reimburse_itinerary_tab_id').datagrid('getEditor',{
		index:index,
		field : 'travelArea'  
	});
	var level = $(travelPersonnelLevel.target).textbox('getValue');
	var areaId = $(travelArea.target).textbox('getValue');
	if(level==""){
		alert("请先选择出行人员！");
		return false;
	}
	var win = creatFirstWin('选择-地区', 640, 580, 'icon-search', '/reimburse/choose?index='+index+'&type=travel&tabId=reimburse_itinerary_tab_id'+'&areaId='+areaId);
	win.window('open');

}
//选择地址
function selectTravelAttendPeop(index) {
	var travelAttendPeopId = $('#reimburse_itinerary_tab_id').datagrid('getEditor',{
		index:index,
		field : 'travelAttendPeopId'  
	});
	var peopId = $(travelAttendPeopId.target).textbox('getValue');
	var win = creatFirstWin('选择-人员', 640, 580, 'icon-search', '/reimburse/chooseUser?index='+index+'&editType=travel&tabId=reimburse_itinerary_tab_id'+'&peopId='+peopId);
	win.window('open');
}
//根据行程单更新伙食补助信息
function addfoodInfo(){
	
	$('#reimburse_itinerary_tab_id').datagrid('acceptChanges');
	var rows = $('#reimburse_itinerary_tab_id').datagrid('getRows');
	var foodrows = $('#reimbursein_foodtab').datagrid('getRows');
	for(var i = foodrows.length-1 ; i >= 0 ; i--){
		$('#reimbursein_foodtab').datagrid('deleteRow',i);
	}
	for(var i = 0 ; i < rows.length ; i++){
		var days;//天数
		var day1 = Date.parse(new Date(rows[i].travelDateEnd));
		var day2 = Date.parse(new Date(rows[i].travelDateStart));
		days = parseInt((day1-day2)/ (1000 * 60 * 60 * 24));//核心：时间戳相减，然后除以天数
		if(!isNaN(day2)&&!isNaN(day1)){
			days+=1;
		}
		days=isNaN(days)?0:days;
		var username = rows[i].travelAttendPeop;
		$.ajax({
			type:'post',
			async:false,
			dataType:'json',
			url:base+'/hotelStandard/calcCost?outType=travel&configId='+rows[i].travelAreaId+'&travelDays='+days+'&hotelDays='+(days-1)+'&userId='+rows[i].travelAttendPeopId,
			success:function (data){
				var ids = rows[i].travelAttendPeop;
				var idsarray = ids.split(',');
				$('#reimbursein_foodtab').datagrid('appendRow',{
					fname:username,
					fDays:days*parseFloat(idsarray.length),
					fApplyAmount:parseFloat(data[1].standard)*parseFloat(idsarray.length),
				});
			}
		});
	}
	if('edit'!='${operation}'){
		$('#reimbursein_foodtab').datagrid('acceptChanges');
	}
	calcFoodCost();
}

function addHotelInfo(){
	$('#reimburse_itinerary_tab_id').datagrid('acceptChanges');
	var itinerary = $("#reimburse_itinerary_tab_id").datagrid('getRows');
	var outRows = $("#reimbursein_hoteltab").datagrid('getRows');
	for(var i = outRows.length-1 ; i >= 0 ; i--){
		$('#reimbursein_hoteltab').datagrid('deleteRow',i);
	}
	for (var i = 0; i < itinerary.length; i++) {
		var days;//天数
		
		console.log(itinerary[i].travelDateEnd);
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
			url:base+'/hotelStandard/calcCost?outType=travel&configId='+itinerary[i].travelAreaId+'&travelDays='+days+'&hotelDays='+(days-1)+'&userId='+itinerary[i].travelAttendPeopId+'&day1='+day1+'&day2='+day2,
			success:function (data){
				$('#reimbursein_hoteltab').datagrid('appendRow', {
					checkInTime:itinerary[i].travelDateStart,
					checkOUTTime:itinerary[i].travelDateEnd,
					CityId:itinerary[i].travelAreaId,
					locationCity:itinerary[i].travelAreaName,
					travelPersonnel:itinerary[i].travelAttendPeop,
					travelPersonnelId:itinerary[i].travelAttendPeopId,
					applyAmount:parseFloat(data[0].standard),
				});
			}
		});
	}
	calcHotelCost();
}


//根据行程单更新伙食补助信息
function addInCityAndFoodInfoReimburse(){
	var travleType ='${applyBean.travelType}';
	acceptItineraryReim();
	acceptfoodReim();
	acceptInCityReim();
	var foodrows = $('#reimbursein_foodtab').datagrid('getRows');
	for(var i = foodrows.length-1 ; i >= 0 ; i--){
		$('#reimbursein_foodtab').datagrid('deleteRow',i);
	}
	var inCityTabRows = $('#reimbursein_city_tabs_id').datagrid('getRows');
	for(var i = inCityTabRows.length-1 ; i >= 0 ; i--){
		$('#reimbursein_city_tabs_id').datagrid('deleteRow',i);
	}
	var rows = $('#reimburse_itinerary_tab_id').datagrid('getRows');

	var arrs = new Array();
	if(rows==''){
		return false;
	}else{
		for (var h = 0; h < rows.length; h++){
			var days;//天数
			var day1 = Date.parse(new Date(rows[h].travelDateEnd));
			var day2 = Date.parse(new Date(rows[h].travelDateStart));
			days = parseInt((day1-day2)/ (1000 * 60 * 60 * 24));//核心：时间戳相减，然后除以天数
			if(!isNaN(day2)&&!isNaN(day1)){
				days+=1;
			}
			days=isNaN(days)?0:days;
			var travelPeop = rows[h].travelAttendPeop.split(',');
			var travelPeopId = rows[h].travelAttendPeopId.split(',');
			for (var y = 0; y < travelPeop.length; y++) {
				var idAndName = {};
				idAndName.id = travelPeopId[y];
				idAndName.name = travelPeop[y];
				idAndName.day = days;
				arrs.push(idAndName);
			}
		}
	}
	var arrsNew = new Array();
	for (var h = 0; h < arrs.length; h++) {
		for (var c =h+1; c <arrs.length; ) {
		    if (arrs[h].id == arrs[c].id ) {//通过id属性进行匹配；
		    	arrs[h].day = arrs[h].day+arrs[c].day;
		    	arrs.splice(c, 1);//去除重复的对象；
			}else {
			c++;
			}
		}
		}
	for (var q = 0; q < arrs.length; q++) {
		$('#reimbursein_foodtab').datagrid('appendRow',{
			fname: arrs[q].name,
			fnameId: arrs[q].id,
			fDays: arrs[q].day,
			fStdAmount: 100,
			fApplyAmount:parseFloat(arrs[q].day)*100,
		});
		$('#reimbursein_city_tabs_id').datagrid('appendRow',{
			fPersonId: arrs[q].id,
			fPerson: arrs[q].name,
			fSubsidyDay: arrs[q].day,
			fStdAmount: 80,
			fApplyAmount:parseFloat(arrs[q].day)*80,
		});
	}
	calcInCity();
	calcFoodCost();
	allProIndexList();
}

//用于删除汇总报销金额
function huizong(){
	var outsideAmount = $("#outsideAmount").val();
	var cityAmount = $("#cityAmount").val();
	var hotelAmount = $("#hotelAmount").val();
	var foodAmount = $("#foodAmount").val();
	if(isNaN(outsideAmount)||outsideAmount==''||outsideAmount==undefined||outsideAmount==null){
		outsideAmount=0;
	}
	if(isNaN(cityAmount)||cityAmount==''||cityAmount==undefined||cityAmount==null){
		cityAmount=0;
	}
	if(isNaN(hotelAmount)||hotelAmount==''||hotelAmount==undefined||hotelAmount==null){
		hotelAmount=0;
	}
	if(isNaN(foodAmount)||foodAmount==''||foodAmount==undefined||foodAmount==null){
		foodAmount=0;
	}
	$("#rapplyTotalAmount").html((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount)).toFixed(2)+"元");
	$("#p_amount").html((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount)).toFixed(2)+"元");
	$("#reimburseAmount").val((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount)).toFixed(2));
}

//获取行程单里面的最早时间和最晚时间
function maxTimeAndMinTimeReims(){
	var arr = [];
	var rows = $('#reimburse_itinerary_tab_id').datagrid('getRows');
	for (var i = 0; i < rows.length; i++) {
		var dayStartNew =ChangeDateFormat(rows[i].travelDateStart);
		var dayStart = Date.parse(new Date(dayStartNew));
		var dayEndNew =ChangeDateFormat(rows[i].travelDateEnd);
		var dayEnd = Date.parse(new Date(dayEndNew));
		arr.push(dayStart);
		arr.push(dayEnd);
	}
	var maxTime = Math.max.apply(null, arr);
	var minTime = Math.min.apply(null, arr);
	$("#maxTime").val(maxTime+(1000 * 60 * 60 * 16));
	$("#minTime").val(minTime-(1000 * 60 * 60 * 8));
	var operation='${operation}';
	if(operation=='add'){
		addInCityAndFoodInfoReimburse();
	}
}
//获取行程单里面的最早时间和最晚时间
function maxTimeAndMinTimeReim(){
	var arr = [];
	var rows = $('#reimburse_itinerary_tab_id').datagrid('getRows');
	for (var i = 0; i < rows.length; i++) {
		var dayStart = Date.parse(new Date(rows[i].travelDateStart));
		var dayEnd = Date.parse(new Date(rows[i].travelDateEnd));
		arr.push(dayStart);
		arr.push(dayEnd);
	}
	var maxTime = Math.max.apply(null, arr);
	var minTime = Math.min.apply(null, arr);
	$("#maxTime").val(maxTime+(1000 * 60 * 60 * 16));
	$("#minTime").val(minTime-(1000 * 60 * 60 * 8));
}

//选中时给出行人员设置id
function personnerStudentReimIdReim(){
	var index=$('#reimburse_itinerary_tab_id').datagrid('getRowIndex',$('#reimburse_itinerary_tab_id').datagrid('getSelected'));
	var fIdentityNumber = $('#reimburse_itinerary_tab_id').datagrid('getEditor',{
		index:index,
		field:'fIdentityNumber'
	});
	var fName = $('#reimburse_itinerary_tab_id').datagrid('getEditor',{
		index:index,
		field:'fName'
	});
	$(fIdentityNumber.target).textbox('setValue', fName.target.combobox('getValues'));
}

function onClickCellStudenttabReim(){
	var index=$('#reimburse_itinerary_tab_id').datagrid('getRowIndex',$('#reimburse_itinerary_tab_id').datagrid('getSelected'));
	$('#reimburse_itinerary_tab_id').datagrid('selectRow', index).datagrid('beginEdit',index);
		var new_arrs= new_arr_studentsReim();
		var fName = $('#reimburse_itinerary_tab_id').datagrid('getEditor',{
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
	
function new_arr_studentsReim(){
	var rows = $('#reim_tracel_students_tab_id').datagrid('getRows');
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

//根据行程单更新伙食补助信息
function allInCityAndFoodInfoReimburse(){
	var rows = $('#reimburse_itinerary_tab_id').datagrid('getRows');
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
		contentType:"application/x-www-form-urlencoded; charset=utf-8",
		data:{
			list:travelPeop
		},
		url:base+'/hotelStandard/getStandard',
		success:function (data){
			for (var i = 0; i < data.length; i++) {
				$('#reimbursein_city_tabs_id').datagrid('appendRow',{
					fPerson:data[i][0],
					fSubsidyDay:data[i][1],
					fStdAmount:data[i][4],
					fApplyAmount:parseFloat(data[i][2]),
				});
				$('#reimbursein_foodtab').datagrid('appendRow',{
					fname:data[i][0],
					fDays:data[i][1],
					fStdAmount:data[i][5],
					fApplyAmount:parseFloat(data[i][3]),
				});
			}
			calcInCity();
			calcFoodCost();
		}
	});
}

function allProIndexList(){
	var outsideAmount = $("#outsideAmount").val();
	var cityAmount = $("#cityAmount").val();
	var hotelAmount = $("#hotelAmount").val();
	var foodAmount = $("#foodAmount").val();
	var meetTrainAmount = $("#meetTrainAmount").val();
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
	if(meetTrainAmount=='NaN'||meetTrainAmount==''||meetTrainAmount==undefined||meetTrainAmount==null){
		meetTrainAmount=0;
	}
	$('#travelAmount').val((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount)).toFixed(2));
	$("#rapplyTotalAmount").html((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount)+parseFloat(meetTrainAmount)).toFixed(2)+"元");
	$("#p_amount").html((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount)+parseFloat(meetTrainAmount)).toFixed(2)+"元");
	$("#reimburseAmount").val((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount)+parseFloat(meetTrainAmount)).toFixed(2));
}

function allTeacherList(){
	acceptIndexReim();
	var outsideTeacherAmount = parseFloat($('#outsideTeacherAmount').val());
	var cityTeacherAmount = parseFloat($('#cityTeacherAmount').val());
	var hotelTeacherAmount = parseFloat($('#hotelTeacherAmount').val());
	var foodTeacherAmount = parseFloat($('#foodTeacherAmount').val());
	if(outsideTeacherAmount=='NaN'||outsideTeacherAmount==''||outsideTeacherAmount==undefined||outsideTeacherAmount==null){
		outsideTeacherAmount=0;
	}
	if(cityTeacherAmount=='NaN'||cityTeacherAmount==''||cityTeacherAmount==undefined||cityTeacherAmount==null){
		cityTeacherAmount=0;
	}
	if(hotelTeacherAmount=='NaN'||hotelTeacherAmount==''||hotelTeacherAmount==undefined||hotelTeacherAmount==null){
		hotelTeacherAmount=0;
	}
	if(foodTeacherAmount=='NaN'||foodTeacherAmount==''||foodTeacherAmount==undefined||foodTeacherAmount==null){
		foodTeacherAmount=0;
	}
	var teacher = foodTeacherAmount+hotelTeacherAmount+cityTeacherAmount+outsideTeacherAmount;
	var rowsIndex = $('#index_reim_tab_id').datagrid('getRows');
    for (var i = 0; i < rowsIndex.length; i++) {
		if(rowsIndex[i].fCostName=='差旅费' && rowsIndex[i].fCostTheir=='教师费用'){
			$('#index_reim_tab_id').datagrid('updateRow',{
				index: i,
				row: {
					fCostAmount: teacher
				}
			});
		}
    }
}


function allStudentList(){
	acceptIndexReim();
	var outsideStudentAmount = parseFloat($('#outsideStudentAmount').val());
	var cityStudentAmount = parseFloat($('#cityStudentAmount').val());
	var hotelStudentAmount = parseFloat($('#hotelStudentAmount').val());
	var foodStudentAmount = parseFloat($('#foodStudentAmount').val());
	if(outsideStudentAmount=='NaN'||outsideStudentAmount==''||outsideStudentAmount==undefined||outsideStudentAmount==null){
		outsideStudentAmount=0;
	}
	if(cityStudentAmount=='NaN'||cityStudentAmount==''||cityStudentAmount==undefined||cityStudentAmount==null){
		cityStudentAmount=0;
	}
	if(hotelStudentAmount=='NaN'||hotelStudentAmount==''||hotelStudentAmount==undefined||hotelStudentAmount==null){
		hotelStudentAmount=0;
	}
	if(foodStudentAmount=='NaN'||foodStudentAmount==''||foodStudentAmount==undefined||foodStudentAmount==null){
		foodStudentAmount=0;
	}
	var student = outsideStudentAmount+cityStudentAmount+hotelStudentAmount+foodStudentAmount;
	var rowsIndex = $('#index_reim_tab_id').datagrid('getRows');
    for (var i = 0; i < rowsIndex.length; i++) {
		if(rowsIndex[i].fCostName=='差旅费' && rowsIndex[i].fCostTheir=='学生费用'){
			$('#index_reim_tab_id').datagrid('updateRow',{
				index: i,
				row: {
					fCostAmount: student
				}
			});
		}
    }
}


</script>