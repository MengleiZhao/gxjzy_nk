<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">

	<table id="reimburse_outside_tab_id" class="easyui-datagrid" style="width:695px;height:auto"
	data-options="
	toolbar: '#reimburse_outside_traffic_Id',
	singleSelect: true,
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/applyOutsideTrafficPage?gId=${applyBean.gId}',
	</c:if>
	<c:if test="${!empty bean.rId&&operation=='edit'}">
	url: '${base}/reimburse/applyOutsideTrafficPage?rId=${bean.rId}',
	</c:if>
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	onClickRow: onClickRowOutsideTraffic,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'trId',hidden:true"></th>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'fStartDate',width:110,align:'center',editor:{type:'datebox', options:{onChange:setDays3,editable:false}},formatter:ChangeDateFormat">出发日期</th>
				<th data-options="field:'fEndDate',width:110,align:'center',editor:{type:'datebox',options:{onChange:setDays4,editable:false}},formatter:ChangeDateFormat">到达日期</th>
				<th data-options="field:'travelPersonnel',width:110,align:'center',
                        editor:{
                            type:'combobox',
                            options:{
                                valueField:'id',
                                textField:'text',
                                multiple: true,
                                onHidePanel:personnerId,
                                onShowPanel:onClickCellOutsideTrafficReim,
								onSelect:reloadOutPersonnelReim
                            }}">出行人员</th>
				<th data-options="field:'travelPersonnelId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'vehicle',width:110,align:'center',editor:{
							editable:true,
							type:'combotree',
							filter: function(q, row){
									var opts = $(this).combotree('options');
									return row[opts.textField].indexOf(q) == 0;
								},
							options:{
								required:true,
								valueField:'code',
								textField:'text',
								method:'post',
								url:base+'/vehicle/comboboxJson?selected=JTGJ06',
								onSelect:reloadOut
							}}">交通工具</th>
				<th data-options="field:'vehicleLevel',width:130,align:'center',editor:{
							editable:true,
							type:'combotree',
							options:{
								required:true,
								valueField:'code',
								textField:'text',
								method:'post',
								url:base+'/vehicle/comboboxJson?selected=JTGJ06&parentCode=JTGJ0602',
								onShowPanel:onShowPanelLevel,
							}}">交通工具级别</th>
				<th data-options="field:'applyAmount',width:100,align:'center',editor:{type:'numberbox',options:{editable:true,precision:2,onChange:outAmounts}}">报销金额</th>
				<th data-options="field:'travelPersonnelLevel',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'vehicleId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
			</tr>
		</thead>
	</table>
	<c:if test="${!empty operation}">
	<div id="reimburse_outside_traffic_Id" style="height:30px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">城市间交通费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<c:if test="${operation=='add'}">	
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="rOutsideTrafficAmount"><fmt:formatNumber groupingUsed="true" value="0.00" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		</c:if>
		<c:if test="${operation=='edit'}">	
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="rOutsideTrafficAmount"><fmt:formatNumber groupingUsed="true" value="${bean.outsideAmount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		</c:if>
		<a href="javascript:void(0)" onclick="removeitOutsideTraffic()" hidden="hidden" id="routsideRemoveitId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appendOutsideTraffic()" hidden="hidden" id="routsideAppendId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	</c:if>
</div>
<script type="text/javascript">
$('#outsideTeacherAmounts').numberbox({
	onChange: function (newValue, oldValue) {
		var outsideAmount = isNaN($('#outsideAmount').val())?0:parseFloat($('#outsideAmount').val());
		var outsideTeacherAmount = isNaN(newValue)?0:parseFloat(newValue);
		if(outsideAmount==0){
			return false;
		}
		var a = outsideAmount-outsideTeacherAmount;
		$('#outsideStudentAmounts').numberbox('setValue',a);
		$('#outsideTeacherAmount').val(outsideTeacherAmount);
		allTeacherList();
	}
});

$('#outsideStudentAmounts').numberbox({
	onChange: function (newValue, oldValue) {
		var outsideAmount = isNaN($('#outsideAmount').val())?0:parseFloat($('#outsideAmount').val());
		var outsideStudentAmount = isNaN(newValue)?0:parseFloat(newValue);
		if(outsideAmount==0){
			return false;
		}
		var a = outsideAmount-outsideStudentAmount;
		$('#outsideTeacherAmounts').numberbox('setValue',a);
		$('#outsideStudentAmount').val(outsideStudentAmount);
		allStudentList();
	}
});


//接待人员表格添加删除，保存方法
var editIndexOutsideTraffic = undefined;
function endEditingOutsideTraffic() {
	if (editIndexOutsideTraffic == undefined) {
		return true;
	}
	if ($('#reimburse_outside_tab_id').datagrid('validateRow', editIndexOutsideTraffic)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#reimburse_outside_tab_id').datagrid('getEditors', editIndexOutsideTraffic);
		var text2=tr[2].target.combobox('getText');
		if(text2!='--请选择--'){
			tr[2].target.combobox('setValues',text2);
		}
		var text4=tr[4].target.combotree('getText');
		if(text4!='--请选择--'){
			tr[4].target.combotree('setValue',text4);
		}
		var text5=tr[5].target.combotree('getText');
		if(text5!='--请选择--'){
			tr[5].target.combotree('setValue',text5);
		}
		$('#reimburse_outside_tab_id').datagrid('endEdit', editIndexOutsideTraffic);
		editIndexOutsideTraffic = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowOutsideTraffic(index) {
	if(sign==1){
	if (editIndexOutsideTraffic != index) {
		if (endEditingOutsideTraffic()) {
			$('#reimburse_outside_tab_id').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndexOutsideTraffic = index;
		} else {
			$('#reimburse_outside_tab_id').datagrid('selectRow', editIndexOutsideTraffic);
		}
	}
	}else{
		alert("请先保存行程清单！");
		return false;
	}
}
function appendOutsideTraffic() {
	if (endEditingOutsideTraffic()) {
		$('#reimburse_outside_tab_id').datagrid('appendRow', {
		});
		editIndexOutsideTraffic = $('#reimburse_outside_tab_id').datagrid('getRows').length - 1;
		$('#reimburse_outside_tab_id').datagrid('selectRow', editIndexOutsideTraffic).datagrid('beginEdit',editIndexOutsideTraffic);
	var new_arrs= new_arr_reim();
		
		var travelPersonnel = $('#reimburse_outside_tab_id').datagrid('getEditor',{
			index:editIndexOutsideTraffic,
			field:'travelPersonnel'
		});
		$(travelPersonnel.target).combobox({
            data: new_arrs,
            valueField: 'id',
            textField: 'text',
		});
	}
}

function reloadOut(rec){
	var row = $('#reimburse_outside_tab_id').datagrid('getSelected');
	var rindex = $('#reimburse_outside_tab_id').datagrid('getRowIndex', row); 
	var ed = $('#reimburse_outside_tab_id').datagrid('getEditor',{
		index:rindex,
		field : 'vehicleLevel'  
	});
	var level = $('#reimburse_outside_tab_id').datagrid('getEditor',{
		index:rindex,
		field : 'travelPersonnelLevel'  
	});
	var vehicleId = $('#reimburse_outside_tab_id').datagrid('getEditor',{
		index:rindex,
		field : 'vehicleId'  
	});
	$(vehicleId.target).textbox('setValue', rec.code);
   	$(ed.target).combotree('setValue', '');
	var url = base+'/vehicle/comboboxJsons?parentCode='+rec.code+'&level='+$(level.target).textbox('getValue');
   	$(ed.target).combotree('reload', url);
}
function removeitOutsideTraffic() {
	if (editIndexOutsideTraffic == undefined) {
		return
	}
	$('#reimburse_outside_tab_id').datagrid('cancelEdit', editIndexOutsideTraffic).datagrid('deleteRow',
			editIndexOutsideTraffic);
	editIndexOutsideTraffic = undefined;
	var rows = $('#reimburse_outside_tab_id').datagrid('getRows');
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
	calcOutsideTrafficCost();
	huizong();
	$('#travelTotalDays').val(travelDays);
	$('#hotelTotalDays').val(hotelDays);
	
	var cxjk = $('input[name="withLoan"]:checked').val();
	if(cxjk==1){
		var lCode = $("#input_jkdbh").textbox('getValue');
		if(lCode!=''){
			cx();
		}
	}
}
function acceptOutsideTrafficReim() {
	if (endEditingOutsideTraffic()) {
		$('#reimburse_outside_tab_id').datagrid('acceptChanges');
	}
}
	
	
//计算时间
function setDays3(newValue,oldValue) {
	var index=$('#reimburse_outside_tab_id').datagrid('getRowIndex',$('#reimburse_outside_tab_id').datagrid('getSelected'));
    var editors = $('#reimburse_outside_tab_id').datagrid('getEditors', index);  
    var day2 = editors[1]; 
    startday =  Date.parse(new Date(newValue));
    endday =  Date.parse(new Date(day2.target.val()));
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
    	if(startday>maxTime ||startday<minTime){
    		alert("所选时间不在行程范围内请重新选择！");
    		editors[0].target.datebox('setValue', '');
    	}
    }
}

function setDays4(newValue,oldValue) {
	var index=$('#reimburse_outside_tab_id').datagrid('getRowIndex',$('#reimburse_outside_tab_id').datagrid('getSelected'));
    var editors = $('#reimburse_outside_tab_id').datagrid('getEditors', index);  
    var day1 = editors[0]; 
    var startday = Date.parse(new Date(day1.target.val()));
    var endday = Date.parse(new Date(newValue));
    var maxTime = $("#maxTime").val();
    var minTime = $("#minTime").val();
    
    if(!isNaN(startday)&&!isNaN(endday)){
    	if((startday>=minTime && startday<=maxTime) && endday<=maxTime){
    		if(endday<startday){
        		alert("结束日期不能小于开始日期！");
        		editors[1].target.datebox('setValue', '');
        	}
    	}else{
    		alert("所选时间不在行程范围内请重新选择！");
    		editors[1].target.datebox('setValue', '');
    	}
    	
    }else{
    	if(endday>maxTime ||endday<minTime){
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
function calcOutsideTrafficCost(){
	//计算总额
	var rows = $('#reimburse_outside_tab_id').datagrid('getRows');
	var applyAmount=parseFloat(0.00);
	for(var i=0;i<rows.length;i++){
		var money = isNaN(parseFloat(rows[i].applyAmount))?0.00:parseFloat(rows[i].applyAmount);
		applyAmount=applyAmount+money;
	}
	$('#rOutsideTrafficAmount').html(applyAmount.toFixed(2)+'[元]');
	$('#outsideAmount').val(applyAmount.toFixed(2));
}	

function outsideTrafficJson(){
	acceptOutsideTrafficReim();
	var rows2 = $('#reimburse_outside_tab_id').datagrid('getRows');
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
	if(isNaN(newVal)||newVal==''){
		newVal = 0;
	}
	var rows = $('#reimburse_outside_tab_id').datagrid('getRows');
	var index=$('#reimburse_outside_tab_id').datagrid('getRowIndex',$('#reimburse_outside_tab_id').datagrid('getSelected'));
    var num1 = 0;
    for(var i=0;i<rows.length;i++){
		if(i==index){
			num1+=parseFloat(newVal);
		}else{
			num1+=addNumsOut(rows,i);
		}
	}
	$("#rOutsideTrafficAmount").html(num1.toFixed(2)+"[元]");
	$("#outsideAmount").val(num1.toFixed(2));
	allProIndexList();
	cx();
	
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

function selectTravelAttendPeopsReim(index) {
	var win = creatFirstWin('选择-人员', 640, 580, 'icon-search', '/apply/chooseUser?index='+index+'&editType=travel&tabId=reimburse_outside_tab_id');
	win.window('open');
}

function onClickCellOutsideTrafficReim(){
	var index=$('#reimburse_outside_tab_id').datagrid('getRowIndex',$('#reimburse_outside_tab_id').datagrid('getSelected'));
	$('#reimburse_outside_tab_id').datagrid('selectRow', index).datagrid('beginEdit',
			index);
		var new_arrs= new_arr_reim();
		var travelPersonnel = $('#reimburse_outside_tab_id').datagrid('getEditor',{
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

function new_arr_reim(){
	var rows = $('#reimburse_itinerary_tab_id').datagrid('getRows');
	var arr = new Array();
	for (var i = 0; i < rows.length; i++) {
		var PeopId = rows[i].travelAttendPeopId.split(',');
		var PeopName = rows[i].travelAttendPeop.split(',');
		var level = rows[i].travelPersonnelLevel.split(',');
		if(PeopId.length>1){
			for (var j = 0; j < PeopId.length; j++) {
				var idAndName = {};
				idAndName.id = PeopId[j];
				idAndName.text = PeopName[j];
				idAndName.level = level[j];
				arr.push(idAndName);
			}
		}else{
			var idAndName = {};
			idAndName.id = rows[i].travelAttendPeopId;
			idAndName.text = rows[i].travelAttendPeop;
			idAndName.level = rows[i].travelPersonnelLevel;
			arr.push(idAndName);
		}
	}
	for (var h = 0; h < arr.length; h++) {
		for (var c =h+1; c <arr.length; ) {
		    if (arr[h].id == arr[c].id ) {//通过id属性进行匹配；
		    	arr.splice(c, 1);//去除重复的对象；
			}else {
			c++;
			}
		}
		}
	return arr;
}

//选中时给出行人员设置id
function personnerId(newVal,oldVal){
	
	var index=$('#reimburse_outside_tab_id').datagrid('getRowIndex',$('#reimburse_outside_tab_id').datagrid('getSelected'));
	var travelPersonnelId = $('#reimburse_outside_tab_id').datagrid('getEditor',{
		index:index,
		field:'travelPersonnelId'
	});
	var travelPersonnel = $('#reimburse_outside_tab_id').datagrid('getEditor',{
		index:index,
		field:'travelPersonnel'
	});
	$(travelPersonnelId.target).textbox('setValue', $(travelPersonnel.target).combobox('getValues'));
}
function reloadOutPersonnelReim(rec){
	var row = $('#reimburse_outside_tab_id').datagrid('getSelected');
	var rindex = $('#reimburse_outside_tab_id').datagrid('getRowIndex', row); 
	var ed = $('#reimburse_outside_tab_id').datagrid('getEditor',{
		index:rindex,
		field : 'travelPersonnelLevel'  
	});
	$(ed.target).textbox('setValue', rec.level);
}

//现实下拉框数据
function onShowPanelLevel(){
	var row = $('#reimburse_outside_tab_id').datagrid('getSelected');
	var rindex = $('#reimburse_outside_tab_id').datagrid('getRowIndex', row); 
	var ed = $('#reimburse_outside_tab_id').datagrid('getEditor',{
		index:rindex,
		field : 'vehicleLevel'  
	});
	var level = $('#reimburse_outside_tab_id').datagrid('getEditor',{
		index:rindex,
		field : 'travelPersonnelLevel'  
	});
	var vehicleId = $('#reimburse_outside_tab_id').datagrid('getEditor',{
		index:rindex,
		field : 'vehicleId'  
	});
	$(ed.target).combotree('setValue', '');
	var url = base+'/vehicle/comboboxJsons?parentCode='+$(vehicleId.target).textbox('getValue')+'&level='+$(level.target).textbox('getValue');
   	$(ed.target).combotree('reload', url);
}
</script>