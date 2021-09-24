<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px;border-top: 1px solid rgba(217,227,231,1);">

	<table id="reimbursein_hoteltab" class="easyui-datagrid" style="width:695px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#reimburse_hoteltool',
	<c:if test="${!empty bean.rId&&operation=='edit'}">
	url: '${base}/reimburse/hotelJson?rId=${bean.rId}',
	</c:if>
	<c:if test="${!empty applyBean.gId&&operation=='add'}">
	url: '${base}/apply/hotelJson?gId=${applyBean.gId}',
	</c:if>
	<c:if test="${empty applyBean.gId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${!empty operation}">
	onClickRow: onClickRowhotel,
	</c:if>
	striped : true,
	nowrap : true,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'ffId',hidden:true"></th>
				<th data-options="field:'checkInTime',align:'center',editor:{type:'datebox', options:{editable:false,onChange:hotelStartTime}},formatter:ChangeDateFormat"width="18%">入住时间</th>
				<th data-options="field:'checkOUTTime',align:'center',editor:{type:'datebox',options:{editable:false,onChange:hotelEndTime}},formatter:ChangeDateFormat"width="18%">退房时间</th>
				<th data-options="field:'cityId',align:'center',hidden:true,editor:{type:'textbox',options:{editable:false,onChange:hotelCity}}">城市id</th>
				<th data-options="field:'travelPersonnelId',hidden:true,editor:{type:'textbox',options:{editable:false,onChange:hotelAtandard}}">住宿人员id</th>
				<th data-options="field:'hotelDay',align:'center',editor:{type:'textbox',options:{editable:false}}">住宿天数</th>
				<th data-options="field:'locationCity',align:'center',editor:{
                            type:'combobox',
                            options:{
                                valueField:'id',
                                textField:'text',
                                multiple: true,
                                editable:false,
                                onHidePanel:cityHotelId,
                                onShowPanel:clickCityName,
                            }}" width="20%">所在城市</th>
				<th data-options="field:'travelPersonnel',
                        editor:{
                            type:'combobox',
                            options:{
                                valueField:'id',
                                textField:'text',
                                editable:false,
                                multiple: true,
                                onHidePanel:personnerHotelIdReim,
                                onShowPanel:clickPersonnelReim,
                            }}" width="33%">住宿人员</th>
                 <th data-options="field:'travelChummage',width:150,
             editor:{
                 type:'combobox',
                 options:{
                 	editable:false,
                     valueField:'id',
                     textField:'text',
                     multiple: false,
                     onHidePanel:travelChummageReimId,
                     onShowPanel:onClickCellChummagetabReim
                 }}">合住人员</th>
				<th data-options="field:'travelChummageId',hidden:true,editor:{type:'textbox',options:{editable:false}}">合住人员id</th>
				<th data-options="field:'reimbAmount',align:'center',editor:{type:'numberbox',options:{precision:2,onChange:hotelAmounts}}" width="12%">报销金额</th>
				<th data-options="field:'standard',hidden:true,editor:{type:'textbox',options:{editable:false}}">住宿标准</th>
			</tr>
		</thead>
	</table>
	<c:if test="${!empty operation}">
	<div id="reimburse_hoteltool" style="height:20px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">住宿费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<c:if test="${operation=='add'}">
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="rhotelAmount"><fmt:formatNumber groupingUsed="true" value="0.00" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		</c:if>
		<c:if test="${operation=='edit'}">
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="rhotelAmount"><fmt:formatNumber groupingUsed="true" value="${bean.hotelAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		</c:if>
		<a href="javascript:void(0)" onclick="removehotel()" id="rhotelRemoveId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appendhotel()" id="rhotelAppendId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	</c:if>
</div>
<script type="text/javascript">
$('#hotelTeacherAmounts').numberbox({
	onChange: function (newValue, oldValue) {
		var hotelAmount = isNaN($('#hotelAmount').val())?0:parseFloat($('#hotelAmount').val());
		var hotelTeacherAmount = isNaN(newValue)?0:parseFloat(newValue);
		if(hotelAmount==0){
			return false;
		}
		var a = hotelAmount-hotelTeacherAmount;
		$('#hotelStudentAmounts').numberbox('setValue',a);
		$('#hotelTeacherAmount').val(hotelTeacherAmount);
		allTeacherList();
	}
});

$('#hotelStudentAmounts').numberbox({
	onChange: function (newValue, oldValue) {
		var hotelAmount = isNaN($('#hotelAmount').val())?0:parseFloat($('#hotelAmount').val());
		var hotelStudentAmount = isNaN(newValue)?0:parseFloat(newValue);
		if(hotelAmount==0){
			return false;
		}
		var a = hotelAmount-hotelStudentAmount;
		$('#hotelTeacherAmounts').numberbox('setValue',a);
		$('#hotelStudentAmount').val(hotelStudentAmount);
		allStudentList();
	}
});
//伙食表格添加删除
var editIndex = undefined;
function endEditinghotelReim() {
	if (editIndex == undefined) {
		return true;
	}
	if ($('#reimbursein_hoteltab').datagrid('validateRow', editIndex)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#reimbursein_hoteltab').datagrid('getEditors', editIndex);
		var text=tr[7].target.combobox('getText');
		if(text!='--请选择--'){
			tr[7].target.combobox('setValue',text);
		}
		var text=tr[5].target.combobox('getText');
		if(text!='--请选择--'){
			tr[5].target.combobox('setValue',text);
		}
		var text6=tr[6].target.combobox('getText');
		if(text6!='--请选择--'){
			tr[6].target.combobox('setValue',text6);
		}
		$('#reimbursein_hoteltab').datagrid('endEdit', editIndex);
		calcHotelCost();
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowhotel(index) {
	if (editIndex != index) {
		if (endEditinghotelReim()) {
			$('#reimbursein_hoteltab').datagrid('selectRow', index).datagrid('beginEdit',index);
			editIndex = index;
		} else {
			$('#reimbursein_hoteltab').datagrid('selectRow', editIndex);
		}
	}
}
function appendhotel() {
	if (endEditinghotelReim()) {
		$('#reimbursein_hoteltab').datagrid('appendRow', {});
		editIndex = $('#reimbursein_hoteltab').datagrid('getRows').length - 1;
		$('#reimbursein_hoteltab').datagrid('selectRow', editIndex).datagrid('beginEdit',editIndex);
		var new_arrs= new_arr_hotel();
		var travelPersonnel = $('#reimbursein_hoteltab').datagrid('getEditor',{
			index:editIndex,
			field:'travelPersonnel'
		});
		$(travelPersonnel.target).combobox({
            data: new_arrs,
            valueField: 'id',
            textField: 'text',
		});
	}
}
function removehotel() {
	if (editIndex == undefined) {
		return
	}
	$('#reimbursein_hoteltab').datagrid('cancelEdit', editIndex).datagrid('deleteRow',editIndex);
	editIndex = undefined;
	calcHotelCost();
	huizong();

	var cxjk = $('input[name="withLoan"]:checked').val();
	if(cxjk==1){
		var lCode = $("#input_jkdbh").textbox('getValue');
		if(lCode!=''){
			cx();
		}
	}
}
function accepthotelReim() {
	if (endEditinghotelReim()) {
		$('#reimbursein_hoteltab').datagrid('acceptChanges');
		calcHotelCost();
	}
}
//获得json数据
function getHotelJson(){
	accepthotelReim();
	$('#reimbursein_hoteltab').datagrid('acceptChanges');
	var rows = $('#reimbursein_hoteltab').datagrid('getRows');
	var entities= '';
	for(var i = 0 ;i < rows.length;i++){
	 entities = entities  + JSON.stringify(rows[i]) + ',';  
	}
	$("#hotelJson").val(entities);
}	
function calcHotelCost(){
	//计算总额
	var rows = $('#reimbursein_hoteltab').datagrid('getRows');
	var HotelAmount=parseFloat(0.00);
	for(var i=0;i<rows.length;i++){
		var money = isNaN(parseFloat(rows[i].reimbAmount))?0.00:parseFloat(rows[i].reimbAmount);
		HotelAmount=HotelAmount+money;
	}
	$('#rhotelAmount').html(HotelAmount.toFixed(2)+'[元]');
	$('#hotelAmount').html(HotelAmount.toFixed(2));
}	
//选中时给出行人员设置id
function travelChummageReimId(){
	
	var index=$('#reimbursein_hoteltab').datagrid('getRowIndex',$('#reimbursein_hoteltab').datagrid('getSelected'));
	var travelChummageId = $('#reimbursein_hoteltab').datagrid('getEditor',{
		index:index,
		field:'travelChummageId'
	});
	var travelChummage = $('#reimbursein_hoteltab').datagrid('getEditor',{
		index:index,
		field:'travelChummage'
	});
	$(travelChummageId.target).textbox('setValue', travelChummage.target.combobox('getValues'));
}
function reload(rec){
	var row = $('#reimbursein_hoteltab').datagrid('getSelected');
	var rindex = $('#reimbursein_hoteltab').datagrid('getRowIndex', row); 
	var ed = $('#reimbursein_hoteltab').datagrid('getEditor',{
		index:rindex,
		field : 'vehicleLevel'  
	});
	if(rec.code !='JTGJ06'){
		var url = base+'/vehicle/comboboxJson?selected=${travelBean.vehicle}&parentCode='+rec.code;
    	$(ed.target).combotree('reload', url);
	}
}

//选择出差地区
function chooseArea(index,editType){
	var win = creatFirstWin('选择-出差地区', 640, 580, 'icon-search', '/hotelStandard/choose?index='+index+'&editType=4&tabId=reimbursein_hoteltab');
	win.window('open');
}
//选择人员
function chooseUser(index,editType){
	var win = creatFirstWin('选择-出差人员', 640, 580, 'icon-search', '/hotelStandard/chooseUser?index='+index+'&editType=4&tabId=reimbursein_hoteltab');
	win.window('open');
}


function hotelAmounts(newVal,oldVal){
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	if(isNaN(parseFloat(newVal))||newVal==''){
		newVal = 0;
	}
	var rows = $('#reimbursein_hoteltab').datagrid('getRows');
	var index=$('#reimbursein_hoteltab').datagrid('getRowIndex',$('#reimbursein_hoteltab').datagrid('getSelected'));
	
	var standard = $('#reimbursein_hoteltab').datagrid('getEditor',{
		index:index,
		field : 'standard'  
	});
	
	var std = $(standard.target).textbox('getValue');
	if(isNaN(parseFloat(std))){
		std = 0;
	}
	if(newVal>parseFloat(std)){
		alert('住宿费报销金额超出标准！');
		var ed = $('#reimbursein_hoteltab').datagrid('getEditor',{
			index:index,
			field : 'reimbAmount'  
		});
		$(ed.target).numberbox('setValue', 0);
		return false;
	}
	
     var num1 = 0;
     for(var i=0;i<rows.length;i++){
		if(i==index){
			num1+=parseFloat(newVal);
		}else{
			num1+=addNumsHotel(rows,i);
		}
	}
		$("#rhotelAmount").html(num1.toFixed(2)+"[元]");
		$("#hotelAmount").val(num1.toFixed(2));
		allProIndexList();
		cx();
		indexAmountName();
}

function addNumsHotel(rows,index){
	var num=0;
	if(rows[index].reimbAmount!=''&&rows[index].reimbAmount!='NaN'&&rows[index].reimbAmount!=undefined){
		num = parseFloat(rows[index].reimbAmount);
	}else{
		num =0;
	}
	return num;
}




function hotelAtandard(newVal,oldVal){
	var index=$('#reimbursein_hoteltab').datagrid('getRowIndex',$('#reimbursein_hoteltab').datagrid('getSelected'));
    var editors = $('#reimbursein_hoteltab').datagrid('getEditors', index);  
	
    var day0 = editors[0]; //入住时间
    var day1 = editors[1]; //退房时间
    var city = editors[2].target[0].value; //所在城市
    var userId = newVal; //出行人员
    var startday = Date.parse(new Date(day0.target[0].value));//入住时间
    var endday = Date.parse(new Date(day1.target[0].value));//退房时间
    if(startday==''||endday==''||isNaN(startday) ||isNaN(endday)){
    	//alert("请选择入住时间和退房时间！");
    	return false;
    }
    if(city==''||userId==''){
    	//alert("请选择所在城市和入住人员！");
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
				
				var ed = $('#reimbursein_hoteltab').datagrid('getEditor',{
					index:index,
					field : 'reimbAmount'  
				});
				var standard = $('#reimbursein_hoteltab').datagrid('getEditor',{
					index:index,
					field : 'standard'  
				});
				
				$(standard.target).textbox('setValue', data[0].standard);
				$(ed.target).numberbox('setValue', data[0].standard);
			}
});
}


function hotelStartTime(newVal,oldVal){
	var index=$('#reimbursein_hoteltab').datagrid('getRowIndex',$('#reimbursein_hoteltab').datagrid('getSelected'));
    var editors = $('#reimbursein_hoteltab').datagrid('getEditors', index);  
    var day1 = editors[0]; 
    var day2 = editors[1];
    
    startday = Date.parse(new Date(newVal));
    endday = Date.parse(new Date(day2.target.val()));
    var maxTime = Date.parse(new Date($("#travelDateEnd").datebox('getValue')))+(1000 * 60 * 60 * 16);
    var minTime = Date.parse(new Date($("#travelDateStart").datebox('getValue')))-(1000 * 60 * 60 * 8);
    if(!isNaN(startday)&&!isNaN(endday)){
    	if((startday>=minTime && startday<=maxTime) && endday<=maxTime){
    		if(endday<startday){
	    		alert("到达日期不能小于出发日期！");
	    		editors[0].target.datebox('setValue', '');
	    		editors[4].target.textbox('setValue', 0);
	    		editors[7].target.numberbox('setValue', 0.00);
    		}
    	}else{
    		alert("所选时间不在行程范围内请重新选择！");
    		editors[0].target.datebox('setValue', '');
    		editors[4].target.textbox('setValue', 0);
    		editors[7].target.numberbox('setValue', 0.00);
    	}
    }else{
    	if(startday>maxTime || startday<minTime){
    		alert("所选时间不在行程范围内请重新选择！");
    		editors[0].target.datebox('setValue', '');
    		editors[4].target.textbox('setValue', 0);
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
	var days;//天数
	days = parseInt((endday-startday)/ (1000 * 60 * 60 * 24));//核心：时间戳相减，然后除以天数
	if(!isNaN(startday)&&!isNaN(endday)){
		days+=1;
	}
	days=isNaN(days)?0:days;
	editors[4].target.textbox('setValue', days-1);
    if(city==''||userId==''){
    	return false;
    }

		$.ajax({
			type:'post',
			async:false,
			dataType:'json',
			url:base+'/hotelStandard/calcCost?outType=travel&configId='+city+'&travelDays='+days+'&hotelDays='+(parseFloat(days)-1)+'&userId='+userId+'&day1='+startday+'&day2='+endday,
			success:function (data){
				
				var ed = $('#reimbursein_hoteltab').datagrid('getEditor',{
					index:index,
					field : 'reimbAmount'  
				});
				var standard = $('#reimbursein_hoteltab').datagrid('getEditor',{
					index:index,
					field : 'standard'  
				});
				
				$(standard.target).textbox('setValue', data[0].standard);
				$(ed.target).numberbox('setValue', data[0].standard);
			}
});
}
function hotelEndTime(newVal,oldVal){
	var index=$('#reimbursein_hoteltab').datagrid('getRowIndex',$('#reimbursein_hoteltab').datagrid('getSelected'));
    var editors = $('#reimbursein_hoteltab').datagrid('getEditors', index);  
    
    
    var day1 = editors[0]; 
    var day2 = editors[1]; 
    startday = Date.parse(new Date(day1.target.val()));
    endday = Date.parse(new Date(newVal));
    var maxTime = Date.parse(new Date($("#travelDateEnd").datebox('getValue')))+(1000 * 60 * 60 * 16);
    var minTime = Date.parse(new Date($("#travelDateStart").datebox('getValue')))-(1000 * 60 * 60 * 8);
    if(!isNaN(startday)&&!isNaN(endday)){
    	if((startday>=minTime && startday<=maxTime) && endday<=maxTime){
    		if(endday<startday){
	    		alert("到达日期不能小于出发日期！");
	    		editors[1].target.datebox('setValue', '');
	    		editors[4].target.textbox('setValue', 0);
	    		editors[7].target.numberbox('setValue', 0.00);
    		}
    	}else{
    		alert("所选时间不在行程范围内请重新选择！");
    		editors[1].target.datebox('setValue', '');
    		editors[4].target.textbox('setValue', 0);
    		editors[7].target.numberbox('setValue', 0.00);
    	}
    }else{
    	if(endday>maxTime || endday<minTime){
    		alert("所选时间不在行程范围内请重新选择！");
    		editors[1].target.datebox('setValue', '');
    		editors[4].target.textbox('setValue', 0);
    		editors[7].target.numberbox('setValue', 0.00);
    	}
    }
    var day0 = editors[0]; //入住时间
    var city = editors[2].target[0].value; //所在城市
    var userId = editors[3].target[0].value; //入住人员
    var startday = Date.parse(new Date(day0.target[0].value));//入住时间
    var endday = Date.parse(new Date(newVal));//退房时间
    if(startday==''||endday==''||isNaN(startday) ||isNaN(endday)){
    	//alert("请选择入住时间和退房时间！");
    	return false;
    }
	var days;//天数
	days = parseInt((endday-startday)/ (1000 * 60 * 60 * 24));//核心：时间戳相减，然后除以天数
	if(!isNaN(startday)&&!isNaN(endday)){
		days+=1;
	}
	days=isNaN(days)?0:days;
	editors[4].target.textbox('setValue', days-1);
    if(city==''||userId==''){
    	//alert("请选择所在城市和入住人员！");
    	return false;
    }

		$.ajax({
			type:'post',
			async:false,
			dataType:'json',
			url:base+'/hotelStandard/calcCost?outType=travel&configId='+city+'&travelDays='+days+'&hotelDays='+(parseFloat(days)-1)+'&userId='+userId+'&day1='+startday+'&day2='+endday,
			success:function (data){
				
				var ed = $('#reimbursein_hoteltab').datagrid('getEditor',{
					index:index,
					field : 'reimbAmount'  
				});
				var standard = $('#reimbursein_hoteltab').datagrid('getEditor',{
					index:index,
					field : 'standard'  
				});
				
				$(standard.target).textbox('setValue', data[0].standard);
				$(ed.target).numberbox('setValue', data[0].standard);
			}
});
}


function hotelCity(newVal,oldVal){
	var index=$('#reimbursein_hoteltab').datagrid('getRowIndex',$('#reimbursein_hoteltab').datagrid('getSelected'));
    var editors = $('#reimbursein_hoteltab').datagrid('getEditors', index);  
	
    var day0 = editors[0]; //入住时间
    var day1 = editors[1]; //退房时间
    var city = newVal; //所在城市
    var userId = editors[3].target[0].value; //入住人员
    var startday = Date.parse(new Date(day0.target[0].value));//入住时间
    var endday = Date.parse(new Date(day1.target[0].value));//退房时间
    if(startday==''||endday==''||isNaN(startday) ||isNaN(endday)){
    	//alert("请选择入住时间和退房时间！");
    	return false;
    }
    if(city==''||userId==''){
    	//alert("请选择所在城市和入住人员！");
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
				
				var ed = $('#reimbursein_hoteltab').datagrid('getEditor',{
					index:index,
					field : 'reimbAmount'  
				});
				var standard = $('#reimbursein_hoteltab').datagrid('getEditor',{
					index:index,
					field : 'standard'  
				});
				
				$(standard.target).textbox('setValue', data[0].standard);
				$(ed.target).numberbox('setValue', data[0].standard);
			}
});
}
function clickPersonnelReim(){
	var index=$('#reimbursein_hoteltab').datagrid('getRowIndex',$('#reimbursein_hoteltab').datagrid('getSelected'));
	$('#reimbursein_hoteltab').datagrid('selectRow', index).datagrid('beginEdit',index);
		var new_arrs= new_arr_reim();
		var travelPersonnel = $('#reimbursein_hoteltab').datagrid('getEditor',{
			index:index,
			field:'travelPersonnel'
		});
		$(travelPersonnel.target).combobox({
            data: new_arrs,
            valueField: 'id',
            multiple: false,
            textField: 'text',
		});
}

function new_arr_hotel(){
	var rows = $('#reimburse_itinerary_tab_id').datagrid('getRows');
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
function personnerHotelIdReim(newVal,oldVal){
	
	var index=$('#reimbursein_hoteltab').datagrid('getRowIndex',$('#reimbursein_hoteltab').datagrid('getSelected'));
	var travelPersonnelId = $('#reimbursein_hoteltab').datagrid('getEditor',{
		index:index,
		field:'travelPersonnelId'
	});
	var travelPersonnel = $('#reimbursein_hoteltab').datagrid('getEditor',{
		index:index,
		field:'travelPersonnel'
	});
	$(travelPersonnelId.target).textbox('setValue', travelPersonnel.target.combobox('getValues'));
}


//选中时给出行人员设置id
function cityHotelId(){
	
	var index=$('#reimbursein_hoteltab').datagrid('getRowIndex',$('#reimbursein_hoteltab').datagrid('getSelected'));
	var cityId = $('#reimbursein_hoteltab').datagrid('getEditor',{
		index:index,
		field:'cityId'
	});
	var locationCity = $('#reimbursein_hoteltab').datagrid('getEditor',{
		index:index,
		field:'locationCity'
	});
	$(cityId.target).textbox('setValue', locationCity.target.combobox('getValues'));
}
function clickCityName(){
	var index=$('#reimbursein_hoteltab').datagrid('getRowIndex',$('#reimbursein_hoteltab').datagrid('getSelected'));
	$('#reimbursein_hoteltab').datagrid('selectRow', index).datagrid('beginEdit',index);
	var fProvinceId = $("#fProvinceId").combobox('getValue');
	var fProvinceName = $("#fProvinceId").combobox('getText');
	var fCityId = $("#fCityId").combobox('getValue');
	var fCityName = $("#fCityId").combobox('getText');
	var fDistrictId = $("#fDistrictId").combobox('getValue');
	var fDistrictName = $("#fDistrictId").combobox('getText');
	if(fProvinceId==''){
		alert('请选择所在省份！');
		return false;
	}
	if(fCityId==''){
		alert('请选择所在城市！');
		return false;
	}
	if(fDistrictId==''){
		alert('请选择所在区域！');
		return false;
	}
		var locationCity = $('#reimbursein_hoteltab').datagrid('getEditor',{
			index:index,
			field:'locationCity'
		});
		$(locationCity.target).combobox({
            data: [{
                "id": fDistrictId,
                "text": fProvinceName+"("+fCityName+fDistrictName+")"
            }],
            valueField: 'id',
            multiple: false,
            textField: 'text',
		});
}

function new_arr_city(){
	var rows = $('#reimburse_itinerary_tab_id').datagrid('getRows');
	var arrs = new Array();
	for (var i = 0; i < rows.length; i++) {
		var idAndName = {};
		idAndName.id = rows[i].travelArea;
		idAndName.text = rows[i].travelAreaName;
		arrs.push(idAndName);
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

function onClickCellChummagetabReim(){
	var index=$('#reimbursein_hoteltab').datagrid('getRowIndex',$('#reimbursein_hoteltab').datagrid('getSelected'));
	$('#reimbursein_hoteltab').datagrid('selectRow', index).datagrid('beginEdit',index);
		var new_arrs= new_arr_reim();
		var travelChummage = $('#reimbursein_hoteltab').datagrid('getEditor',{
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

</script>