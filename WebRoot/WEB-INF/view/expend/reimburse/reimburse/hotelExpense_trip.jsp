<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px;">
	<table id="hoteltabApplyTripReim" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#hoteltoolTripReim',
	<c:if test="${!empty bean.rId&&operation=='edit'}">
	url: '${base}/reimburse/hotelJson?rId=${bean.rId}',
	</c:if>
	<c:if test="${!empty applyBean.gId&&operation=='add'}">
	url: '${base}/apply/hotelJson?gId=${applyBean.gId}&travelType=GWCX',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRowhotelTripReim,
	</c:if>
	striped : true,
	nowrap : true,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'ffId',hidden:true"></th>
				<th data-options="field:'travelType',hidden:true"></th>
				<th data-options="field:'checkInTime',width:140,align:'center',editor:{type:'datebox', options:{editable:false,onChange:hotelStartTimeTripReim}},formatter:ChangeDateFormat" >入住时间</th>
				<th data-options="field:'checkOUTTime',width:140,align:'center',editor:{type:'datebox',options:{editable:false,onChange:hotelEndTimeTripReim}},formatter:ChangeDateFormat" >退房时间</th>
				<th data-options="field:'cityId',hidden:true,editor:{type:'textbox',options:{editable:false,onChange:hotelCityTripReim}}">城市id</th>
				<th data-options="field:'travelPersonnelId',hidden:true,editor:{type:'textbox',options:{editable:false,onChange:hotelAtandardTripReim}}">住宿人员id</th>
				<th data-options="field:'locationCity',width:150,align:'center',
                        editor:{
                            type:'combobox',
                            options:{
                                valueField:'id',
                                textField:'text',
                                editable:false,
                                multiple:false,
                                onHidePanel:cityHotelIdTripReim,
                                onShowPanel:clickComboxCityTripReim
                            }}">所在辖区</th>
					<th data-options="field:'travelPersonnel',width:130,align:'center',
                        editor:{
                            type:'combobox',
                            options:{
                                valueField:'id',
                                textField:'text',
                                editable:false,
                                multiple: true,
                                onHidePanel:personnerHotelIdTripReim,
                                onShowPanel:onClickCellHoteltabTripReim
                            }}">住宿人员</th>
                    <th data-options="field:'travelChummage',width:150,
				         editor:{
				             type:'combobox',
				             options:{
				             	editable:false,
				                 valueField:'id',
				                 textField:'text',
				                 multiple: false,
				                 onHidePanel:travelChummageReimTripId,
				                 onShowPanel:onClickCellChummagetabReimTrip
				             }}">合住人员</th>
				<th data-options="field:'travelChummageId',hidden:true,editor:{type:'textbox',options:{editable:false}}">合住人员id</th>
				<th data-options="field:'applyAmount',align:'center',width:120,editor:{type:'numberbox',options:{editable:true,precision:2,onChange:hotelAmountsTripReim}}">报销费用</th>
			</tr>
		</thead>
	</table>
	<div id="hoteltoolTripReim" style="height:20px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">住宿费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">原申请金额：<span ><fmt:formatNumber groupingUsed="true" value="${applyBean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<c:if test="${operation=='add'}">
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="hotelAmountsTripReim"><fmt:formatNumber groupingUsed="true" value="${applyBean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		</c:if>
		<c:if test="${operation=='edit'}">
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="hotelAmountsTripReim"><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		</c:if>
		<a href="javascript:void(0)" onclick="removehotelTripReim()" id="hotelRemoveId_trip_reim" hidden="hidden" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appendhotelTripReim()" id="hotelAppendId_trip_reim" hidden="hidden" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	<table style="width:707px;height:auto">
		<tr class="trbody">
			<td style="width: 120px;text-align: right;">教师金额合计（元）：</td>
			<td style="width: 1px;text-align: left;" >
			<input class="easyui-numberbox" id="hotelTeacherAmounts" value="${bean.hotelTeacherAmount}"style="width: 85px;height: 30px;margin-left: 10px " >
			</td>
			<td style="width: 120px;text-align: right;">学生金额合计（元）：</td>
			<td style="width: 1px;text-align: left;" >
			<input class="easyui-numberbox" id="hotelStudentAmounts" value="${bean.hotelStudentAmount}" style="width: 85px;height: 30px;margin-left: 10px " >
			</td>
		</tr>
	</table>
</div>
<script type="text/javascript">
$('#hotelTeacherAmounts').numberbox({
	onChange: function (newValue, oldValue) {
		var reimburseAmount = isNaN($('#reimburseAmount').val())?0:parseFloat($('#reimburseAmount').val());
		var hotelTeacherAmount = isNaN(newValue)?0:parseFloat(newValue);
		if(reimburseAmount>0){
			var a = reimburseAmount-hotelTeacherAmount;
			$('#hotelStudentAmounts').numberbox('setValue',a);
		}
		$('#hotelTeacherAmount').val(hotelTeacherAmount);
		acceptIndexReim();
	    var rowsIndex = $('#index_reim_tab_id').datagrid('getRows');
	    for (var i = 0; i < rowsIndex.length; i++) {
			if(rowsIndex[i].fCostName=='差旅费' && rowsIndex[i].fCostTheir=='教师费用'){
				$('#index_reim_tab_id').datagrid('updateRow',{
					index: i,
					row: {
						fCostAmount: hotelTeacherAmount
					}
				});
			}
		}
	}
});

$('#hotelStudentAmounts').numberbox({
	onChange: function (newValue, oldValue) {
		var reimburseAmount = isNaN($('#reimburseAmount').val())?0:parseFloat($('#reimburseAmount').val());
		var hotelStudentAmount = isNaN(newValue)?0:parseFloat(newValue);
		if(reimburseAmount>0){
			var a = reimburseAmount-hotelStudentAmount;
			$('#hotelTeacherAmounts').numberbox('setValue',a);
		}
		$('#hotelStudentAmount').val(hotelStudentAmount);
		acceptIndexReim();
	    var rowsIndex = $('#index_reim_tab_id').datagrid('getRows');
	    for (var i = 0; i < rowsIndex.length; i++) {
			if(rowsIndex[i].fCostName=='差旅费' && rowsIndex[i].fCostTheir=='学生费用'){
				$('#index_reim_tab_id').datagrid('updateRow',{
					index: i,
					row: {
						fCostAmount: hotelStudentAmount
					}
				});
			}
		}
	}
});

//伙食表格添加删除
var editIndexHotelTripReim = undefined;
function endEditinghotelTripReim() {
	
	if (editIndexHotelTripReim == undefined) {
		return true;
	}
	if ($('#hoteltabApplyTripReim').datagrid('validateRow', editIndexHotelTripReim)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		
		var tr = $('#hoteltabApplyTripReim').datagrid('getEditors', editIndexHotelTripReim);
		var text4=tr[4].target.combobox('getText');
		if(text4!='--请选择--'){
			tr[4].target.combobox('setValue',text4);
		}
		var text5=tr[5].target.combobox('getText');
		if(text5!='--请选择--'){
			tr[5].target.combobox('setValue',text5);
		}
		var text6=tr[6].target.combobox('getText');
		if(text6!='--请选择--'){
			tr[6].target.combobox('setValue',text6);
		}
		$('#hoteltabApplyTripReim').datagrid('endEdit', editIndexHotelTripReim);
		calcHotelCostTripReim();
		editIndexHotelTripReim = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowhotelTripReim(index) {
	
	if(sign==1){
	if (editIndexHotelTripReim != index) {
		if (endEditinghotelTripReim()) {
			$('#hoteltabApplyTripReim').datagrid('selectRow', index).datagrid('beginEdit',index);
			editIndexHotelTripReim = index;
		} else {
			$('#hoteltabApplyTripReim').datagrid('selectRow', editIndexHotelTripReim);
		}
	}
	}else{
		alert("请先保存行程清单！");
		return false;
	}
}
function appendhotelTripReim() {
	if (endEditinghotelTripReim()) {
		$('#hoteltabApplyTripReim').datagrid('appendRow', {});
		editIndexHotelTripReim = $('#hoteltabApplyTripReim').datagrid('getRows').length - 1;
		$('#hoteltabApplyTripReim').datagrid('selectRow', editIndexHotelTripReim).datagrid('beginEdit',editIndexHotelTripReim);
		
		var new_arrs= new_arr_hotel_ReimTrip();
		
		var travelPersonnel = $('#hoteltabApplyTripReim').datagrid('getEditor',{
			index:editIndexHotelTripReim,
			field:'travelPersonnel'
		});
		$(travelPersonnel.target).combobox({
            data: new_arrs,
            valueField: 'id',
            textField: 'text',
		});
	}
}
function removehotelTripReim() {
	if (editIndexHotelTripReim == undefined) {
		return
	}
	$('#hoteltabApplyTripReim').datagrid('cancelEdit', editIndexHotelTripReim).datagrid('deleteRow',editIndexHotelTripReim);
	editIndexHotelTripReim = undefined;
	calcHotelCostTripReim();
}
function accepthotelTripReim() {
	if (endEditinghotelTripReim()) {
		$('#hoteltabApplyTripReim').datagrid('acceptChanges');
		calcHotelCostTripReim();
	}
}
//获得json数据
function getHotelJsonTripReim(){
	accepthotelTripReim();
	$('#hoteltabApplyTripReim').datagrid('acceptChanges');
	var rows = $('#hoteltabApplyTripReim').datagrid('getRows');
	var entities= '';
	for(var i = 0 ;i < rows.length;i++){
	 entities = entities  + JSON.stringify(rows[i]) + ',';  
	}
	$("#hotelJson").val(entities);
}	
function calcHotelCostTripReim(){
	//计算总额
	var rows = $('#hoteltabApplyTripReim').datagrid('getRows');
	var HotelAmount=parseFloat(0.00);
	for(var i=0;i<rows.length;i++){
		var money = isNaN(parseFloat(rows[i].applyAmount))?0.00:parseFloat(rows[i].applyAmount);
		HotelAmount=HotelAmount+money;
	}
	$('#hotelAmountsTripReim').html(HotelAmount.toFixed(2)+'[元]');
	$('#hotelAmount').val(HotelAmount.toFixed(2));
}	
function reload(rec){
	var row = $('#hoteltabApplyTripReim').datagrid('getSelected');
	var rindex = $('#hoteltabApplyTripReim').datagrid('getRowIndex', row); 
	var ed = $('#hoteltabApplyTripReim').datagrid('getEditor',{
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

//选择出差地区
function chooseArea(index,editType){
	var win = creatFirstWin('选择-出差地区', 640, 580, 'icon-search', '/hotelStandard/choose?index='+index+'&editType=4');
	win.window('open');
}
//选择人员
function chooseUser(index,editType){
	var win = creatFirstWin('选择-出差人员', 640, 580, 'icon-search', '/hotelStandard/chooseUser?index='+index+'&editType=4');
	win.window('open');
}


function calcHotel(){
	//计算总额
	var rows = $('#hoteltabApplyTripReim').datagrid('getRows');
	var hotelAmount=parseFloat(0.00);
	for(var i=0;i<rows.length;i++){
		var money = isNaN(parseFloat(rows[i].applyAmount))?0.00:parseFloat(rows[i].applyAmount);
		hotelAmount=hotelAmount+money;
	}
	$('#hotelAmountsTripReim').html(hotelAmount.toFixed(2)+'[元]');
	$('#hotelAmount').val(hotelAmount.toFixed(2));
}



function hotelAmountsTripReim(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	if(newVal==''){
		newVal=0.00;
	}
	
	var rows = $('#hoteltabApplyTripReim').datagrid('getRows');
	var index=$('#hoteltabApplyTripReim').datagrid('getRowIndex',$('#hoteltabApplyTripReim').datagrid('getSelected'));
     var num1 = 0;
     for(var i=0;i<rows.length;i++){
		if(i==index){
			num1+=parseFloat(newVal);
		}else{
			num1+=addNumsHotel(rows,i);
		}
	}
		$("#hotelAmountsTripReim").html(num1.toFixed(2)+"[元]");
		$("#hotelAmount").val(num1.toFixed(2));
		$("#applyTotalAmountTripReim").html(listToFixed((parseFloat(num1)))+"[元]");
		$("#p_amount").html(listToFixed((parseFloat(num1)))+"[元]");
		$("#reimburseAmount").val((parseFloat(num1)).toFixed(2));
		cx();
}

function addNumsHotel(rows,index){
	var num=0;
	if(rows[index].applyAmount!=''&&rows[index].applyAmount!='NaN'&&rows[index].applyAmount!=undefined){
		num = parseFloat(rows[index].applyAmount);
	}else{
		num =0;
	}
	return num;
}

function hotelAtandardTripReim(newVal,oldVal){
	var index=$('#hoteltabApplyTripReim').datagrid('getRowIndex',$('#hoteltabApplyTripReim').datagrid('getSelected'));
    var editors = $('#hoteltabApplyTripReim').datagrid('getEditors', index);  
	
    var day0 = editors[0]; //入住时间
    var day1 = editors[1]; //退房时间
    var city = editors[2].target[0].value; //所在城市
    var userId = newVal; //出行人员
    var startday = Date.parse(new Date(day0.target[0].value));//入住时间
    var endday = Date.parse(new Date(day1.target[0].value));//退房时间
    if(startday==''||endday==''||isNaN(startday) ||isNaN(endday)){
    	var ed = $('#hoteltabApplyTripReim').datagrid('getEditor',{
			index:index,
			field : 'applyAmount'  
		});
		$(ed.target).numberbox('setValue', 0.00);
    	return false;
    }
    if(city==''||userId==''){
    	var ed = $('#hoteltabApplyTripReim').datagrid('getEditor',{
			index:index,
			field : 'applyAmount'  
		});
		$(ed.target).numberbox('setValue', 0.00);
    	return false;
    }
		var days;//天数
		days = parseInt((endday-startday)/ (1000 * 60 * 60 * 24));//核心：时间戳相减，然后除以天数
		if(!isNaN(startday)&&!isNaN(endday)){
			days+=1;
		}
		days=isNaN(days)?0:days;
		$.ajax({
			type:'post',
			async:false,
			dataType:'json',
			url:base+'/hotelStandard/calcCost?outType=travel&configId='+city+'&travelDays='+days+'&hotelDays='+(parseFloat(days)-1)+'&userId='+userId+'&day1='+startday+'&day2='+endday,
			success:function (data){
				
				var ed = $('#hoteltabApplyTripReim').datagrid('getEditor',{
					index:index,
					field : 'applyAmount'  
				});
				
				$(ed.target).numberbox('setValue', data[0].standard);
			}
});
}


function hotelStartTimeTripReim(newVal,oldVal){
	var index=$('#hoteltabApplyTripReim').datagrid('getRowIndex',$('#hoteltabApplyTripReim').datagrid('getSelected'));
    var editors = $('#hoteltabApplyTripReim').datagrid('getEditors', index);  
    var day2 = editors[1]; 
    startday = Date.parse(new Date(newVal));
    endday = Date.parse(new Date(day2.target.val()));
    var maxTime = $("#maxTime").val();
    var minTime = $("#minTime").val();
    if(!isNaN(startday)&&!isNaN(endday)){
    	if((startday>=minTime && startday<=maxTime) && endday<=maxTime){
    		if(endday<startday){
	    		alert("到达日期不能小于出发日期！");
	    		editors[0].target.datebox('setValue', '');
	    		editors[6].target.numberbox('setValue', 0.00);
    		}
    	}else{
    		alert("所选时间不在行程范围内请重新选择！");
    		editors[0].target.datebox('setValue', '');
    		editors[6].target.numberbox('setValue', 0.00);
    	}
    }else{
    	if(startday>maxTime || startday<minTime){
    		alert("所选时间不在行程范围内请重新选择！");
    		editors[0].target.datebox('setValue', '');
    	}
    }
    var day1 = editors[1]; //所在城市
    var city = editors[2].target[0].value; //所在城市
    var userId = editors[3].target[0].value; //出行人员
    var startday = Date.parse(new Date(newVal));//入住时间
    var endday = Date.parse(new Date(day1.target[0].value));//退房时间
    if(startday==''||endday==''||isNaN(startday) ||isNaN(endday)){
    	return false;
    }
    if(city==''||userId==''){
    	return false;
    }
		var days;//天数
		days = parseInt((endday-startday)/ (1000 * 60 * 60 * 24));//核心：时间戳相减，然后除以天数
		if(!isNaN(startday)&&!isNaN(endday)){
			days+=1;
		}
		days=isNaN(days)?0:days;
		$.ajax({
			type:'post',
			async:false,
			dataType:'json',
			url:base+'/hotelStandard/calcCost?outType=travel&configId='+city+'&travelDays='+days+'&hotelDays='+(parseFloat(days)-1)+'&userId='+userId+'&day1='+startday+'&day2='+endday,
			success:function (data){
				
				var ed = $('#hoteltabApplyTripReim').datagrid('getEditor',{
					index:index,
					field : 'applyAmount'  
				});
				
				$(ed.target).numberbox('setValue', data[0].standard);
			}
});
}
function hotelEndTimeTripReim(newVal,oldVal){
	var index=$('#hoteltabApplyTripReim').datagrid('getRowIndex',$('#hoteltabApplyTripReim').datagrid('getSelected'));
    var editors = $('#hoteltabApplyTripReim').datagrid('getEditors', index);  
    var day1 = editors[0]; 
    var day2 = editors[1]; 
    startday = Date.parse(new Date(day1.target.val()));
    endday = Date.parse(new Date(newVal));
    var maxTime = $("#maxTime").val();
    var minTime = $("#minTime").val();
    if(!isNaN(startday)&&!isNaN(endday)){
    	if((startday>=minTime && startday<=maxTime) && endday<=maxTime){
    		if(endday<startday){
	    		alert("到达日期不能小于出发日期！");
	    		editors[1].target.datebox('setValue', '');
	    		editors[6].target.numberbox('setValue', 0.00);
    		}
    	}else{
    		alert("所选时间不在行程范围内请重新选择！");
    		editors[1].target.datebox('setValue', '');
    		editors[6].target.numberbox('setValue', 0.00);
    	}
    }else{
    	if(endday>maxTime || endday<minTime){
    		alert("所选时间不在行程范围内请重新选择！");
    		editors[1].target.datebox('setValue', '');
    		editors[6].target.numberbox('setValue', 0.00);
    	}
    }
    var day0 = editors[0]; //入住时间
    var city = editors[2].target[0].value; //所在城市
    var userId = editors[3].target[0].value; //入住人员
    var startday = Date.parse(new Date(day0.target[0].value));//入住时间
    var endday = Date.parse(new Date(newVal));//退房时间
    if(startday==''||endday==''||isNaN(startday) ||isNaN(endday)){
    	var ed = $('#hoteltabApplyTripReim').datagrid('getEditor',{
			index:index,
			field : 'applyAmount'  
		});
		$(ed.target).numberbox('setValue', 0.00);
    	return false;
    }
    if(city==''||userId==''){
    	return false;
    }
		var days;//天数
		days = parseInt((endday-startday)/ (1000 * 60 * 60 * 24));//核心：时间戳相减，然后除以天数
		if(!isNaN(startday)&&!isNaN(endday)){
			days+=1;
		}
		days=isNaN(days)?0:days;
		$.ajax({
			type:'post',
			async:false,
			dataType:'json',
			url:base+'/hotelStandard/calcCost?outType=travel&configId='+city+'&travelDays='+days+'&hotelDays='+(parseFloat(days)-1)+'&userId='+userId+'&day1='+startday+'&day2='+endday,
			success:function (data){
				
				var ed = $('#hoteltabApplyTripReim').datagrid('getEditor',{
					index:index,
					field : 'applyAmount'  
				});
				
				$(ed.target).numberbox('setValue', data[0].standard);
			}
});
}


function hotelCityTripReim(newVal,oldVal){
	var index=$('#hoteltabApplyTripReim').datagrid('getRowIndex',$('#hoteltabApplyTripReim').datagrid('getSelected'));
    var editors = $('#hoteltabApplyTripReim').datagrid('getEditors', index);  
	
    var day0 = editors[0]; //入住时间
    var day1 = editors[1]; //退房时间
    var city = newVal; //所在城市
    var userId = editors[3].target[0].value; //入住人员
    var startday = Date.parse(new Date(day0.target[0].value));//入住时间
    var endday = Date.parse(new Date(day1.target[0].value));//退房时间
    if(startday==''||endday==''||isNaN(startday) ||isNaN(endday)){
    	var ed = $('#hoteltabApplyTripReim').datagrid('getEditor',{
			index:index,
			field : 'applyAmount'  
		});
		$(ed.target).numberbox('setValue', 0.00);
    	return false;
    }
    if(city==''||userId==''){
    	var ed = $('#hoteltabApplyTripReim').datagrid('getEditor',{
			index:index,
			field : 'applyAmount'  
		});
		$(ed.target).numberbox('setValue', 0.00);
    	return false;
    }
		var days;//天数
		days = parseInt((endday-startday)/ (1000 * 60 * 60 * 24));//核心：时间戳相减，然后除以天数
		if(!isNaN(startday)&&!isNaN(endday)){
			days+=1;
		}
		days=isNaN(days)?0:days;
		$.ajax({
			type:'post',
			async:false,
			dataType:'json',
			url:base+'/hotelStandard/calcCost?outType=travel&configId='+city+'&travelDays='+days+'&hotelDays='+(parseFloat(days)-1)+'&userId='+userId+'&day1='+startday+'&day2='+endday,
			success:function (data){
				
				var ed = $('#hoteltabApplyTripReim').datagrid('getEditor',{
					index:index,
					field : 'applyAmount'  
				});
				
				$(ed.target).numberbox('setValue', data[0].standard);
			}
	});
}
function onClickCellHoteltabTripReim(){
	
	var index=$('#hoteltabApplyTripReim').datagrid('getRowIndex',$('#hoteltabApplyTripReim').datagrid('getSelected'));
	$('#hoteltabApplyTripReim').datagrid('selectRow', index).datagrid('beginEdit',index);
		var new_arrs= new_arr_hotel_ReimTrip();
		var travelPersonnel = $('#hoteltabApplyTripReim').datagrid('getEditor',{
			index:index,
			field:'travelPersonnel'
		});
		$(travelPersonnel.target).combobox({
            data: new_arrs,
            valueField: 'id',
            multiple: true,
            textField: 'text',
		});
}

function new_arr_hotel_ReimTrip(){
	var rows = $('#tracel_itinerary_trip_reim_tab_id').datagrid('getRows');
	var arrs = new Array();
	for (var i = 0; i < rows.length; i++) {
	var PeopId = rows[i].travelAttendPeopId.split(',');
	var PeopName = rows[i].travelAttendPeop.split(',');
	if(PeopId.length>1){
		for (var j = 0; j < PeopId.length; j++) {
			var idAndName = {};
			idAndName.id = PeopId[j];
			idAndName.text = PeopName[j];
			arrs.push(idAndName);
		}
	}else{
		var idAndName = {};
		idAndName.id = rows[i].travelAttendPeopId;
		idAndName.text = rows[i].travelAttendPeop;
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

//选中时给出行人员设置id
function personnerHotelIdTripReim(){
	
	var index=$('#hoteltabApplyTripReim').datagrid('getRowIndex',$('#hoteltabApplyTripReim').datagrid('getSelected'));
	var travelPersonnelId = $('#hoteltabApplyTripReim').datagrid('getEditor',{
		index:index,
		field:'travelPersonnelId'
	});
	var travelPersonnel = $('#hoteltabApplyTripReim').datagrid('getEditor',{
		index:index,
		field:'travelPersonnel'
	});
	$(travelPersonnelId.target).textbox('setValue', travelPersonnel.target.combobox('getValues'));
}
//选中时给出行人员设置id
function cityHotelIdTripReim(){
	
	var index=$('#hoteltabApplyTripReim').datagrid('getRowIndex',$('#hoteltabApplyTripReim').datagrid('getSelected'));
	var cityId = $('#hoteltabApplyTripReim').datagrid('getEditor',{
		index:index,
		field:'cityId'
	});
	var locationCity = $('#hoteltabApplyTripReim').datagrid('getEditor',{
		index:index,
		field:'locationCity'
	});
	$(cityId.target).textbox('setValue', locationCity.target.combobox('getValues'));
}
function clickComboxCityTripReim(){
	
	var index=$('#hoteltabApplyTripReim').datagrid('getRowIndex',$('#hoteltabApplyTripReim').datagrid('getSelected'));
	$('#hoteltabApplyTripReim').datagrid('selectRow', index).datagrid('beginEdit',index);
		var locationCity = $('#hoteltabApplyTripReim').datagrid('getEditor',{
			index:index,
			field:'locationCity'
		});
		$(locationCity.target).combobox({
            data: [{
                "id":38,
                "text":"天津（宁河区）"
            },{
                "id":13,
                "text":"天津（除宁河区以外的区县）"
            }],
            valueField: 'id',
            multiple: false,
            textField: 'text',
		});
}

//选中时给出行人员设置id
function travelChummageReimTripId(){
	
	var index=$('#hoteltabApplyTripReim').datagrid('getRowIndex',$('#hoteltabApplyTripReim').datagrid('getSelected'));
	var travelChummageId = $('#hoteltabApplyTripReim').datagrid('getEditor',{
		index:index,
		field:'travelChummageId'
	});
	var travelChummage = $('#hoteltabApplyTripReim').datagrid('getEditor',{
		index:index,
		field:'travelChummage'
	});
	$(travelChummageId.target).textbox('setValue', travelChummage.target.combobox('getValues'));
}


function onClickCellChummagetabReimTrip(){
	var index=$('#hoteltabApplyTripReim').datagrid('getRowIndex',$('#hoteltabApplyTripReim').datagrid('getSelected'));
	$('#hoteltabApplyTripReim').datagrid('selectRow', index).datagrid('beginEdit',index);
		var new_arrs= new_arr_hotel_ReimTrip();
		var travelChummage = $('#hoteltabApplyTripReim').datagrid('getEditor',{
			index:index,
			field:'travelChummage'
		});
		$(travelChummage.target).combobox({
            data: new_arrs,
            valueField: 'id',
            multiple: false,
            textField: 'text',
		});
}


function new_arr_hotel_ReimTrip(){
	var rows = $('#tracel_itinerary_trip_reim_tab_id').datagrid('getRows');
	var arrs = new Array();
	for (var i = 0; i < rows.length; i++) {
		var PeopId = rows[i].travelAttendPeopId.split(',');
		var PeopName = rows[i].travelAttendPeop.split(',');
		if(PeopId.length>1){
			for (var j = 0; j < PeopId.length; j++) {
				var idAndName = {};
				idAndName.id = PeopId[j];
				idAndName.text = PeopName[j];
				arrs.push(idAndName);
			}
		}else{
			var idAndName = {};
			idAndName.id = rows[i].travelAttendPeopId;
			idAndName.text = rows[i].travelAttendPeop;
			arrs.push(idAndName);
		}
	}
	for (var x = 0; x < rows.length; x++) {
		var fIdentityNumber = rows[x].fIdentityNumber.split(',');
		var fName = rows[x].fName.split(',');
		if(fIdentityNumber.length>1){
			for (var y = 0; y < fIdentityNumber.length; y++) {
				var idAndName = {};
				idAndName.id = fIdentityNumber[y];
				idAndName.text = fName[y];
				arrs.push(idAndName);
			}
		}else{
			var idAndName = {};
			idAndName.id = rows[x].fIdentityNumber;
			idAndName.text = rows[x].fName;
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
</script>