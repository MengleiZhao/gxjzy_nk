<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">

	<table id="outside_traffic_tab_id_apply" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#outside_traffic_Id',
	<c:if test="${!empty bean.gId}">
	url: '${base}/apply/applyOutsideTrafficPage?gId=${bean.gId}&travelType=GWCC',
	</c:if>
	<c:if test="${empty bean.gId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRowOutsideTraffic,
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
				<th data-options="field:'fStartDate',width:110,align:'center',editor:{type:'datebox', options:{onChange:setDays3,editable:false}},formatter:ChangeDateFormat1">出发日期</th>
				<th data-options="field:'fEndDate',width:110,align:'center',editor:{type:'datebox',options:{onChange:setDays4,editable:false}},formatter:ChangeDateFormat1">到达日期</th>
				<th data-options="field:'travelPersonnel',width:110,align:'center',
                        editor:{
                            type:'combobox',
                            options:{
                            	editable:false,
                                valueField:'id',
                                textField:'text',
                                multiple: true,
                                onHidePanel:personnerId,
                                onShowPanel:onClickCellOutsideTraffic,
								onSelect:reloadOutPersonnel
                            }}">出行人员</th>
				<th data-options="field:'travelPersonnelId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'vehicle',width:190,align:'center',editor:{
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
				<th data-options="field:'vehicleLevel',width:153,align:'center',editor:{
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
				<th data-options="field:'travelPersonnelLevel',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
				<th data-options="field:'vehicleId',hidden:true,editor:{type:'textbox',options:{editable:false}}"></th>
			</tr>
		</thead>
	</table>
	<c:if test="${empty detail}">
	<div id="outside_traffic_Id" style="height:30px;">
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="removeitOutsideTraffic()" hidden="hidden" id="outsideRemoveitId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appendOutsideTraffic()" hidden="hidden" id="outsideAppendId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	</c:if>
	<input type="hidden" id="hotelTotalDays"  />
	<input type="hidden" id="travelTotalDays"  />
	<input type="hidden" id="hotelTotalDays"  />
	<input type="hidden" id="outsideTrafficJson" name="outsideTraffic" />
</div>
<script type="text/javascript">

//接待人员表格添加删除，保存方法
var editIndexOutsideTraffic = undefined;
function endEditingOutsideTraffic() {
	if (editIndexOutsideTraffic == undefined) {
		return true;
	}
	
	if ($('#outside_traffic_tab_id_apply').datagrid('validateRow', editIndexOutsideTraffic)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#outside_traffic_tab_id_apply').datagrid('getEditors', editIndexOutsideTraffic);
		var text1=tr[2].target.combobox('getText');
		if(text1!='--请选择--'){
			tr[2].target.combobox('setValue',text1);
		}
		
		var text4=tr[4].target.combotree('getText');
		if(text4!='--请选择--'){
			tr[4].target.combotree('setValues',text4);
		}
		
		var text5=tr[5].target.combotree('getText');
		if(text5!='--请选择--'){
			tr[5].target.combotree('setValues',text5);
		}
		$('#outside_traffic_tab_id_apply').datagrid('endEdit', editIndexOutsideTraffic);
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
			$('#outside_traffic_tab_id_apply').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			
			editIndexOutsideTraffic = index;
		} else {
			$('#outside_traffic_tab_id_apply').datagrid('selectRow', editIndexOutsideTraffic);
		}
	}
	}else{
		alert("请先保存行程清单！");
		return false;
	}
}
function appendOutsideTraffic() {
	if (endEditingOutsideTraffic()) {
		
		$('#outside_traffic_tab_id_apply').datagrid('appendRow', {
		});
		editIndexOutsideTraffic = $('#outside_traffic_tab_id_apply').datagrid('getRows').length - 1;
		$('#outside_traffic_tab_id_apply').datagrid('selectRow', editIndexOutsideTraffic).datagrid('beginEdit',editIndexOutsideTraffic);
		
		var new_arrs= new_arr();
		
		var travelPersonnel = $('#outside_traffic_tab_id_apply').datagrid('getEditor',{
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
function removeitOutsideTraffic() {
	if (editIndexOutsideTraffic == undefined) {
		return
	}
	$('#outside_traffic_tab_id_apply').datagrid('cancelEdit', editIndexOutsideTraffic).datagrid('deleteRow',
			editIndexOutsideTraffic);
	editIndexOutsideTraffic = undefined;
	var rows = $('#outside_traffic_tab_id_apply').datagrid('getRows');
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
	//calcOut();
	huizongApply();
	
	$('#travelTotalDays').val(travelDays);
	$('#hotelTotalDays').val(hotelDays);
}
function acceptOutsideTraffic() {
	if (endEditingOutsideTraffic()) {
		$('#outside_traffic_tab_id_apply').datagrid('acceptChanges');
	}
}
	
function calcOut(){
	//计算总额
	var rows = $('#outside_traffic_tab_id_apply').datagrid('getRows');
	var outAmount=parseFloat(0.00);
	for(var i=0;i<rows.length;i++){
		var money = isNaN(parseFloat(rows[i].applyAmount))?0.00:parseFloat(rows[i].applyAmount);
		outAmount=outAmount+money;
	}
	$('#applyOutsideTrafficAmount').html(outAmount.toFixed(2)+'[元]');
	$('#outsideAmount').val(outAmount.toFixed(2));
}
//计算天数
function setDays3(newValue,oldValue) {
	var index=$('#outside_traffic_tab_id_apply').datagrid('getRowIndex',$('#outside_traffic_tab_id_apply').datagrid('getSelected'));
    var editors = $('#outside_traffic_tab_id_apply').datagrid('getEditors', index);  
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
	var totalDays = 0;
	var fsumDays = 0;
	var index=$('#outside_traffic_tab_id_apply').datagrid('getRowIndex',$('#outside_traffic_tab_id_apply').datagrid('getSelected'));
	var rows = $('#outside_traffic_tab_id_apply').datagrid('getRows');
    var editors = $('#outside_traffic_tab_id_apply').datagrid('getEditors', index);  
    var day1 = editors[0]; 
    var day2 = editors[1]; 
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
    var editors = $('#outside_traffic_tab_id_apply').datagrid('getEditors', index);  
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
//选择人员
function selectTravelAttendPeops(index) {
	
	var win = creatFirstWin('选择-人员', 640, 580, 'icon-search', '/apply/chooseUser?index='+index+'&editType=travel&tabId=outside_traffic_tab_id_apply');
	win.window('open');

}


function outsideTrafficJson(){
	acceptOutsideTraffic();
	var rows2 = $('#outside_traffic_tab_id_apply').datagrid('getRows');
	var outsideTraffic = "";
	if(rows2==''){
	}else{
		for (var i = 0; i < rows2.length; i++) {
			outsideTraffic = outsideTraffic + JSON.stringify(rows2[i]) + ",";
			}
		$('#outsideTrafficJson').val(outsideTraffic);
	}
}


function reloadOut(rec){
	var row = $('#outside_traffic_tab_id_apply').datagrid('getSelected');
	var rindex = $('#outside_traffic_tab_id_apply').datagrid('getRowIndex', row); 
	var ed = $('#outside_traffic_tab_id_apply').datagrid('getEditor',{
		index:rindex,
		field : 'vehicleLevel'  
	});
	var level = $('#outside_traffic_tab_id_apply').datagrid('getEditor',{
		index:rindex,
		field : 'travelPersonnelLevel'  
	});
	var vehicleId = $('#outside_traffic_tab_id_apply').datagrid('getEditor',{
		index:rindex,
		field : 'vehicleId'  
	});
	$(ed.target).combotree('setValue', '');
	$(vehicleId.target).textbox('setValue', rec.code);
	var url = base+'/vehicle/comboboxJsons?selected=${travelBean.vehicle}&parentCode='+rec.code+'&level='+$(level.target).textbox('getValue');
   	$(ed.target).combotree('reload', url);
}

function outAmounts(newVal,oldVal){
	
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	if(newVal==''){
		newVal=0.00;
	}
	
	var rows = $('#outside_traffic_tab_id_apply').datagrid('getRows');
	var index=$('#outside_traffic_tab_id_apply').datagrid('getRowIndex',$('#outside_traffic_tab_id_apply').datagrid('getSelected'));
     var num1 = 0;
     for(var i=0;i<rows.length;i++){
		if(i==index){
			num1=parseFloat(num1)+parseFloat(newVal);
		}else{
			num1+=addNumsOut(rows,i);
		}
	}
		$("#applyOutsideTrafficAmount").html(num1.toFixed(2)+"[元]");
		$("#outsideAmount").val(num1.toFixed(2));
		var cityAmount = $("#cityAmount").val();
		var hotelAmount = $("#hotelAmount").val();
		var foodAmount = $("#foodAmount").val();
		if(cityAmount=='NaN'||cityAmount==''||cityAmount==undefined||cityAmount==null){
			cityAmount=0;
		}
		if(hotelAmount=='NaN'||hotelAmount==''||hotelAmount==undefined||hotelAmount==null){
			hotelAmount=0;
		}
		if(foodAmount=='NaN'||foodAmount==''||foodAmount==undefined||foodAmount==null){
			foodAmount=0;
		}
		$("#applyTotalAmount").html(listToFixed((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(num1)))+"元");
		$("#applyAmount").val((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(num1)).toFixed(2));
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
	$("#applyTotalAmount").html((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount))+"元");
	$("#applyAmount").val((parseFloat(foodAmount)+parseFloat(hotelAmount)+parseFloat(cityAmount)+parseFloat(outsideAmount)).toFixed(2));
}

//选中时给出行人员设置id
function personnerId(){
	var index=$('#outside_traffic_tab_id_apply').datagrid('getRowIndex',$('#outside_traffic_tab_id_apply').datagrid('getSelected'));
	var travelPersonnelId = $('#outside_traffic_tab_id_apply').datagrid('getEditor',{
		index:index,
		field:'travelPersonnelId'
	});
	var travelPersonnel = $('#outside_traffic_tab_id_apply').datagrid('getEditor',{
		index:index,
		field:'travelPersonnel'
	});
	$(travelPersonnelId.target).textbox('setValue', $(travelPersonnel.target).combobox('getValues'));
}

//现实下拉框数据
function onShowPanelLevel(){
	
	var row = $('#outside_traffic_tab_id_apply').datagrid('getSelected');
	var rindex = $('#outside_traffic_tab_id_apply').datagrid('getRowIndex', row); 
	var ed = $('#outside_traffic_tab_id_apply').datagrid('getEditor',{
		index:rindex,
		field : 'vehicleLevel'  
	});
	var level = $('#outside_traffic_tab_id_apply').datagrid('getEditor',{
		index:rindex,
		field : 'travelPersonnelLevel'  
	});
	var vehicleId = $('#outside_traffic_tab_id_apply').datagrid('getEditor',{
		index:rindex,
		field : 'vehicleId'  
	});
	$(ed.target).combotree('setValue', '');
	var url = base+'/vehicle/comboboxJsons?parentCode='+$(vehicleId.target).textbox('getValue')+'&level='+$(level.target).textbox('getValue');
   	$(ed.target).combotree('reload', url);
}


function new_arr(){
	
	var rows = $('#tracel_itinerary_tab_id').datagrid('getRows');
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
	for (var x = 0; x < rows.length; x++) {
		var fIdentityNumber = rows[x].fIdentityNumber.split(',');
		var fName = rows[x].fName.split(',');
		if(fIdentityNumber.length>1){
			for (var y = 0; y < fIdentityNumber.length; y++) {
				var idAndName = {};
				idAndName.id = fIdentityNumber[y];
				idAndName.text = fName[y];
				idAndName.level = 3;
				arr.push(idAndName);
			}
		}else{
			var idAndName = {};
			idAndName.id = rows[x].fIdentityNumber;
			idAndName.text = rows[x].fName;
			idAndName.level = 3;
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
function onClickCellOutsideTraffic(){
	
	$('#outside_traffic_tab_id_apply').datagrid('selectRow', index).datagrid('beginEdit',
			index);
	var index=$('#outside_traffic_tab_id_apply').datagrid('getRowIndex',$('#outside_traffic_tab_id_apply').datagrid('getSelected'));
		var new_arrs= new_arr();
		var travelPersonnel = $('#outside_traffic_tab_id_apply').datagrid('getEditor',{
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

//时间格式化
function ChangeDateFormat1(val) {
	var t, y, m, d, h, i, s;
	if (val == null || val == "") {
		return "";
	}
	t = new Date(val);
	y = t.getFullYear();
	m = t.getMonth() + 1;
	d = t.getDate();
	h = t.getHours();
	i = t.getMinutes();
	s = t.getSeconds();
	// 可根据需要在这里定义时间格式  
	return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
}

function reloadOutPersonnel(rec){
	
	var row = $('#outside_traffic_tab_id_apply').datagrid('getSelected');
	var rindex = $('#outside_traffic_tab_id_apply').datagrid('getRowIndex', row); 
	var ed = $('#outside_traffic_tab_id_apply').datagrid('getEditor',{
		index:rindex,
		field : 'travelPersonnelLevel'  
	});
	$(ed.target).textbox('setValue', rec.level);
}
</script>