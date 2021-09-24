<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">

	<table id="apply_outside_traffic_tab_id" class="easyui-datagrid" style="width:407px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#outside_traffic_Id',
	<c:if test="${!empty bean.gId}">
	url: '${base}/apply/applyOutsideTrafficPage?gId=${bean.gId}',
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
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'travelPersonnel',width:177,
                        editor:{
                            type:'combobox',
                            options:{
                                valueField:'id',
                                textField:'text',
                                multiple: false,
                                onShowPanel:onClickCellInternational
                            }}">出行人员</th>
				<th data-options="field:'applyAmount',width:200,align:'center',editor:{type:'numberbox',options:{editable:true,precision:2,onChange:outAmounts}}">申请费用</th>
			</tr>
		</thead>
	</table>
	<div id="outside_traffic_Id" style="height:30px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">国外城市间交通费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">申请金额：<span id="applyOutsideTrafficAmount"><fmt:formatNumber groupingUsed="true" value="${abroad.trafficMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
	</div>
</div>
<script type="text/javascript">

//接待人员表格添加删除，保存方法
var editIndexInternational = undefined;
function endEditingInternational() {
	if (editIndexInternational == undefined) {
		return true;
	}
	
	if ($('#apply_outside_traffic_tab_id').datagrid('validateRow', editIndexInternational)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		/* var tr = $('#apply_outside_traffic_tab_id').datagrid('getEditors', editIndexInternational);
		var text1=tr[2].target.combotree('getText');
		if(text1!='--请选择--'){
			tr[2].target.combotree('setValue',text1);
		}
		var text2=tr[3].target.combotree('getText');
		if(text2!='--请选择--'){
			tr[3].target.combotree('setValue',text2);
		}
		var text3=tr[4].target.combobox('getText');
		if(text3!='--请选择--'){
			tr[4].target.combobox('setValues',text3);
		} */
		$('#apply_outside_traffic_tab_id').datagrid('endEdit', editIndexInternational);
		editIndexInternational = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowInternational(index) {
	if(sign==1){
		if (editIndexInternational != index) {
			if (endEditingInternational()) {
				$('#apply_outside_traffic_tab_id').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				
				editIndexInternational = index;
			} else {
				$('#apply_outside_traffic_tab_id').datagrid('selectRow', editIndexInternational);
			}
		}
	}else{
		alert("请先保存出访计划！");
		return false;
	}
}
function appendInternational() {
	if (endEditingInternational()) {
		
		$('#apply_outside_traffic_tab_id').datagrid('appendRow', {
		});
		editIndexInternational = $('#apply_outside_traffic_tab_id').datagrid('getRows').length - 1;
		$('#apply_outside_traffic_tab_id').datagrid('selectRow', editIndexInternational).datagrid('beginEdit',editIndexInternational);
		
		var new_arrs= new_arr();
		
		var travelPersonnel = $('#apply_outside_traffic_tab_id').datagrid('getEditor',{
			index:editIndexInternational,
			field:'travelPersonnel'
		});
		$(travelPersonnel.target).combobox({
            data: new_arrs,
            valueField: 'id',
            textField: 'text',
		});
	}
}
function removeitInternational() {
	if (editIndexInternational == undefined) {
		return
	}
	$('#apply_outside_traffic_tab_id').datagrid('cancelEdit', editIndexInternational).datagrid('deleteRow',
			editIndexInternational);
	editIndexInternational = undefined;
	var rows = $('#apply_outside_traffic_tab_id').datagrid('getRows');
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
	calcOutInter();
	countMoney();
}
function acceptInternational() {
	if (endEditingInternational()) {
		$('#apply_outside_traffic_tab_id').datagrid('acceptChanges');
	}
}
	
function calcOutInter(){
	//计算总额
	var rows = $('#apply_outside_traffic_tab_id').datagrid('getRows');
	var outAmount=parseFloat(0.00);
	for(var i=0;i<rows.length;i++){
		var money = isNaN(parseFloat(rows[i].applyAmount))?0.00:parseFloat(rows[i].applyAmount);
		outAmount=outAmount+money;
	}
	$('#applyOutsideTrafficAmount').html(outAmount.toFixed(2)+'[元]');
	$('#trafficMoney').val(outAmount.toFixed(2));
}
//计算天数
function setDays3(newValue,oldValue) {
	var index=$('#apply_outside_traffic_tab_id').datagrid('getRowIndex',$('#apply_outside_traffic_tab_id').datagrid('getSelected'));
    var editors = $('#apply_outside_traffic_tab_id').datagrid('getEditors', index);  
    var day2 = editors[1]; 
    var startday = Date.parse(new Date(newValue));
    var endday = Date.parse(new Date(day2.target.val()));
    
    var maxTime = $("#maxTime").val();
    var minTime = $("#minTime").val();
    if(!isNaN(startday)&&!isNaN(endday)){
    	if((startday>=minTime &&startday<=maxTime) && endday<=maxTime){
    		if(endday<startday){
        		alert("结束日期不能小于开始日期！");
        		editors[0].target.datebox('setValue', '');
        	}
    	}else{
    		alert("所选时间不在行程范围内请重新选择！");
    		editors[0].target.datebox('setValue', '');
    	}
    	
    }else{
    	if(startday>maxTime || startday<minTime){
    		alert("所选时间不在行程范围内请重新选择！");
    		editors[0].target.datebox('setValue', '');
    	}
    }
	
}

function setDays4(newValue,oldValue) {
	var index=$('#apply_outside_traffic_tab_id').datagrid('getRowIndex',$('#apply_outside_traffic_tab_id').datagrid('getSelected'));
    var editors = $('#apply_outside_traffic_tab_id').datagrid('getEditors', index);  
    var day1 = editors[0]; 
    var startday = Date.parse(new Date(day1.target.val()));
    var endday = Date.parse(new Date(newValue));
    var maxTime = $("#maxTime").val();
    var minTime = $("#minTime").val();
    if(!isNaN(startday)&&!isNaN(endday)){
    	if((startday>=minTime &&startday<=maxTime) && endday<=maxTime){
    		if(endday<startday){
        		alert("结束日期不能小于开始日期！");
        		editors[1].target.datebox('setValue', '');
        	}
    	}else{
    		alert("所选时间不在行程范围内请重新选择！");
    		editors[1].target.datebox('setValue', '');
    	}
    	
    }else{
    	if(endday>maxTime || endday<minTime){
    		alert("所选时间不在行程范围内请重新选择！");
    		editors[1].target.datebox('setValue', '');
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
//选择人员
function selectTravelAttendPeops(index) {
	
	var win = creatFirstWin('选择-人员', 640, 580, 'icon-search', '/apply/chooseUser?index='+index+'&editType=travel&tabId=apply_outside_traffic_tab_id');
	win.window('open');

}


function outsideTrafficJson(){
	acceptInternational();
	var rows2 = $('#apply_outside_traffic_tab_id').datagrid('getRows');
	var outsideTraffic = "";
	if(rows2==''){
	}else{
		for (var i = 0; i < rows2.length; i++) {
			outsideTraffic = outsideTraffic + JSON.stringify(rows2[i]) + ",";
			}
		$('#outsideTrafficJson').val(outsideTraffic);
	}
}


function outAmounts(newVal,oldVal){
	
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	if(newVal==''){
		newVal=0.00;
	}
	var rows = $('#apply_outside_traffic_tab_id').datagrid('getRows');
	var index=$('#apply_outside_traffic_tab_id').datagrid('getRowIndex',$('#apply_outside_traffic_tab_id').datagrid('getSelected'));
     var num1 = 0;
     for(var i=0;i<rows.length;i++){
		if(i==index){
			num1+=parseFloat(newVal);
		}else{
			num1+=addNumsOut(rows,i);
		}
	}
		$("#applyOutsideTrafficAmount").html(num1.toFixed(2)+"[元]");
		$("#trafficMoney").val(num1.toFixed(2));
		countMoney();
}

function addNumsOut(rows,index){
	var num=0;
	if(rows[index].applyAmount!=''&&rows[index].applyAmount!='NaN'&&rows[index].applyAmount!=undefined){
		num = parseFloat(rows[index].applyAmount);
	}else{
		num =0;
	}
	return num;
}

//用于删除汇总报销金额
function huizongApply(){
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
	$("#applyTotalAmount").html((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount)).toFixed(2)+"元");
	$("#applyAmount").val((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount)).toFixed(2));
}



function new_arr(){
	var arr = new Array();
	var PeopName = $("#fAbroadPeople").textbox('getValue').split(',');
	for (var j = 0; j < PeopName.length; j++) {
		var idAndName = {};
		idAndName.id = PeopName[j];
		idAndName.text = PeopName[j];
		arr.push(idAndName);
	}
	return arr;
}
function onClickCellInternational(){
	
	$('#apply_outside_traffic_tab_id').datagrid('selectRow', index).datagrid('beginEdit',
			index);
	var index=$('#apply_outside_traffic_tab_id').datagrid('getRowIndex',$('#apply_outside_traffic_tab_id').datagrid('getSelected'));
		var new_arrs= new_arr();
		var travelPersonnel = $('#apply_outside_traffic_tab_id').datagrid('getEditor',{
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
</script>