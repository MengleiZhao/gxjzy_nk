<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">

	<table id="international_traveling_expense_id-reim" class="easyui-datagrid" style="width:695px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#traveling_id',
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/getInternationalTravelingExpense?gId=${applyBean.gId}',
	</c:if>
	<c:if test="${!empty abroadEdit.rId&&operation=='edit'}">
	url: '${base}/reimburse/internationalTravelingExpense?rId=${abroadEdit.rId}',
	</c:if>
	<c:if test="${empty applyBean.gId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRowTravelingExpenseRime,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	
	">
		<thead>
			<tr>
				<th data-options="field:'gId',hidden:true"></th>
				<th data-options="field:'timeStart',width:110,align:'center',editor:{type:'datebox', options:{onChange:setDaysStartRime,editable:false}},formatter:ChangeDateFormat">出发日期</th>
				<th data-options="field:'timeEnd',width:110,align:'center',editor:{type:'datebox',options:{onChange:setDaysEndRime,editable:false}},formatter:ChangeDateFormat">到达日期</th>
				<th data-options="field:'startCity',width:115,align:'center',editor:{type:'textbox',options:{editable:true}}">出发地</th>
				<th data-options="field:'arriveCity',width:115,align:'center',editor:{type:'textbox',options:{editable:true}}">目的地</th>
				<th data-options="field:'vehicle',hidden:true,width:120,align:'center',editor:{type:'textbox',options:{editable:true,
							options:{
								onChange:onChange2
							}}}">交通工具</th>
				<th data-options="field:'vehicleText',width:130,align:'center',editor:{
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
								onClick: reloadSubsidiesReim,
								onSelect:reloadWay
								<!-- onHidePanel:reloadSubsidiesReim -->
							}}">交通工具</th>
				<th data-options="field:'vehicleLevel',width:160,align:'center',editor:{
							editable:true,
							type:'combotree',
							options:{
								required:true,
								valueField:'code',	
								textField:'text',
								method:'post',
								url:base+'/vehicle/comboboxJson?selected=JTGJ06&parentCode=JTGJ0602',
								onShowPanel:loadVehcleLevel
							}}">交通工具级别</th>			
				<th data-options="field:'applyAmount',width:87,align:'center',editor:{type:'numberbox',options:{editable:true,precision:2,onChange:travelingExpenseAmountsRime}}">报销金额(人民币)</th>
				<th data-options="field:'trainSubsidies',hidden:true,width:170,align:'center',editor:{type:'numberbox',options:{editable:true,precision:2}}">其中国际列车补助（美元）</th>
			</tr>
		</thead>
	</table>
	<div id="traveling_id" style="height:30px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">国际旅费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">申请金额：<span id=""><fmt:formatNumber groupingUsed="true" value="${abroad.travelMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="applyTravelingExpense"><fmt:formatNumber groupingUsed="true" value="${abroadEdit.travelMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		<a href="javascript:void(0)" onclick="removeitTravelingExpense()" id="travelingExpenseId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appendTravelingExpenseRime()" id="travelingAppendId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
</div>
<script type="text/javascript">
function reloadWay(rec){
	var row = $('#international_traveling_expense_id-reim').datagrid('getSelected');
	var rindex = $('#international_traveling_expense_id-reim').datagrid('getRowIndex', row); 
	var ed = $('#international_traveling_expense_id-reim').datagrid('getEditor',{
		index:rindex,
		field : 'vehicleLevel'  
	});
	var ed1 = $('#international_traveling_expense_id-reim').datagrid('getEditor',{
		index:rindex,
		field : 'vehicle'  
	});
	ed1.target.textbox('setValue',rec.code);
		var url = base+'/vehicle/comboboxJson?parentCode='+rec.code;
    	$(ed.target).combotree('reload', url);
    	ed.target.textbox('setValue','--请选择--');
}
function loadVehcleLevel(){
	var row = $('#international_traveling_expense_id-reim').datagrid('getSelected');
	var rindex = $('#international_traveling_expense_id-reim').datagrid('getRowIndex', row); 
	var ed = $('#international_traveling_expense_id-reim').datagrid('getEditor',{
		index:rindex,
		field : 'vehicleLevel'  
	});
	var ed1 = $('#international_traveling_expense_id-reim').datagrid('getEditor',{
		index:rindex,
		field : 'vehicle'  
	});
	var code =ed1.target.textbox('getValue');
	var url = base+'/vehicle/comboboxJson?selected=${abroad.fVehicle}&parentCode='+code;
	$(ed.target).combotree('reload', url);
}
//接待人员表格添加删除，保存方法
var editIndexTravelingExpenseRime = undefined;
function endEditingTravelingExpenseRime() {
	if (editIndexTravelingExpenseRime == undefined) {
		return true;
	}
	if ($('#international_traveling_expense_id-reim').datagrid('validateRow', editIndexTravelingExpenseRime)) {
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#international_traveling_expense_id-reim').datagrid('getEditors', editIndexTravelingExpenseRime);
		var text5=tr[5].target.combotree('getText');
		if(text5!='--请选择--'){
			tr[5].target.combotree('setValues',text5);
		}
		var text6=tr[6].target.combotree('getText');
		if(text6!='--请选择--'){
			tr[6].target.combotree('setValues',text6);
		}
		$('#international_traveling_expense_id-reim').datagrid('endEdit', editIndexTravelingExpenseRime);
		editIndexTravelingExpenseRime = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowTravelingExpenseRime(index) {
	if(sign==1){
		if (editIndexTravelingExpenseRime != index) {
			if (endEditingTravelingExpenseRime()) {
				$('#international_traveling_expense_id-reim').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				var row = $('#international_traveling_expense_id-reim').datagrid('getSelected');
		    	var rindex = $('#international_traveling_expense_id-reim').datagrid('getRowIndex', row); 
		    	var ed = $('#international_traveling_expense_id-reim').datagrid('getEditor',{
		    		index:rindex,
		    		field : 'vehicle'  
		    	});
		    	var ed1 = $('#international_traveling_expense_id-reim').datagrid('getEditor',{
		    		index:rindex,
		    		field : 'trainSubsidies'  
		    	});
				if($(ed.target).textbox('getValue') !='JTGJ06'){
		    		$(ed1.target).numberbox('setValue',0);
					$(ed1.target).numberbox('disable');
				}
				editIndexTravelingExpenseRime = index;
			} else {
				$('#international_traveling_expense_id-reim').datagrid('selectRow', editIndexTravelingExpenseRime);
			}
		}
	}else{
		alert("请先保存出访计划！");
		return false;
	}
}
function appendTravelingExpenseRime() {
	if (endEditingTravelingExpenseRime()) {
		
		$('#international_traveling_expense_id-reim').datagrid('appendRow', {
		});
		editIndexTravelingExpenseRime = $('#international_traveling_expense_id-reim').datagrid('getRows').length - 1;
		$('#international_traveling_expense_id-reim').datagrid('selectRow', editIndexTravelingExpenseRime).datagrid('beginEdit',editIndexTravelingExpenseRime);
	}
}
function removeitTravelingExpense() {
	if (editIndexTravelingExpenseRime == undefined) {
		return
	}
	$('#international_traveling_expense_id-reim').datagrid('cancelEdit', editIndexTravelingExpenseRime).datagrid('deleteRow',
			editIndexTravelingExpenseRime);
	editIndexTravelingExpenseRime = undefined;
	var rows = $('#international_traveling_expense_id-reim').datagrid('getRows');
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
	calcOut();
	countMoney();
}
function acceptTravelingExpenseRime() {
	if (endEditingTravelingExpenseRime()) {
		$('#international_traveling_expense_id-reim').datagrid('acceptChanges');
	}
}
	
function calcOut(){
	//计算总额
	var rows = $('#international_traveling_expense_id-reim').datagrid('getRows');
	var outAmount=parseFloat(0.00);
	for(var i=0;i<rows.length;i++){
		var money = isNaN(parseFloat(rows[i].applyAmount))?0.00:parseFloat(rows[i].applyAmount);
		outAmount=outAmount+money;
	}
	$('#applyTravelingExpense').html(outAmount.toFixed(2)+'[元]');
	$('#travelMoney').val(outAmount.toFixed(2));
}
//计算天数
function setDaysStartRime(newValue,oldValue) {
	if(newValue==undefined || oldValue==undefined ||newValue==''){
		return false;
	}
	
	var index=$('#international_traveling_expense_id-reim').datagrid('getRowIndex',$('#international_traveling_expense_id-reim').datagrid('getSelected'));
    var editors = $('#international_traveling_expense_id-reim').datagrid('getEditors', index);  
    var day2 = editors[1]; 
    var startday = Date.parse(new Date(newValue));
    var endday = Date.parse(new Date(day2.target.val()));
    var maxTime = Date.parse(new Date($("#abroadDateEnd").datebox('getValue')));
    var minTime = Date.parse(new Date($("#abroadDateStart").datebox('getValue')));
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

function setDaysEndRime(newValue,oldValue) {
	if(newValue==undefined || oldValue==undefined ||newValue==''){
		return false;
	}
	
	var index=$('#international_traveling_expense_id-reim').datagrid('getRowIndex',$('#international_traveling_expense_id-reim').datagrid('getSelected'));
    var editors = $('#international_traveling_expense_id-reim').datagrid('getEditors', index);  
    var day1 = editors[0]; 
    var startday = Date.parse(new Date(day1.target.val()));
    var endday = Date.parse(new Date(newValue));
    var maxTime = Date.parse(new Date($("#abroadDateEnd").datebox('getValue')));
    var minTime = Date.parse(new Date($("#abroadDateStart").datebox('getValue')));
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
//对于正在编辑的行，计算天数
/* function setEditing(rows,index){
    var editors = $('#international_traveling_expense_id-reim').datagrid('getEditors', index);  
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
	
	var win = creatFirstWin('选择-人员', 640, 580, 'icon-search', '/apply/chooseUser?index='+index+'&editType=travel&tabId=international_traveling_expense_id-reim');
	win.window('open');

}


function outsideTrafficJson(){
	acceptTravelingExpenseRime();
	var rows2 = $('#international_traveling_expense_id-reim').datagrid('getRows');
	var outsideTraffic = "";
	if(rows2==''){
	}else{
		for (var i = 0; i < rows2.length; i++) {
			outsideTraffic = outsideTraffic + JSON.stringify(rows2[i]) + ",";
			}
		$('#outsideTrafficJson').val(outsideTraffic);
	}
}


function reloadSubsidiesReim(node){
    	var row = $('#international_traveling_expense_id-reim').datagrid('getSelected');
    	var rindex = $('#international_traveling_expense_id-reim').datagrid('getRowIndex', row); 
    	var ed = $('#international_traveling_expense_id-reim').datagrid('getEditor',{
    		index:rindex,
    		field : 'trainSubsidies'  
    	});
    	var ed1 = $('#international_traveling_expense_id-reim').datagrid('getEditor',{
    		index:rindex,
    		field : 'vehicle'  
    	});
    	$(ed1.target).textbox('setValue',node.code);
		if(node.code =='JTGJ06'){
    	$("#international_traveling_expense_id-reim").datagrid('showColumn', "trainSubsidies");
    	$(ed.target).numberbox('enable');
    	$(ed.target).numberbox('setValue',0);
		}else{
			$(ed.target).numberbox('disable');
		}
}
function onChange2(newVal,oldVal){
    	var row = $('#international_traveling_expense_id-reim').datagrid('getSelected');
    	var rindex = $('#international_traveling_expense_id-reim').datagrid('getRowIndex', row); 
    	var ed = $('#international_traveling_expense_id-reim').datagrid('getEditor',{
    		index:rindex,
    		field : 'trainSubsidies'  
    	});
    	var ed1 = $('#international_traveling_expense_id-reim').datagrid('getEditor',{
    		index:rindex,
    		field : 'vehicleLevel'  
    	});
    		
		if(newVal =='JTGJ06'){
    	$("#international_traveling_expense_id-reim").datagrid('showColumn', "trainSubsidies");
    	 $(ed.target).numberbox('enable');
    	$(ed.target).numberbox('setValue',0);
		}else{
			$(ed.target).numberbox('disable');
		}
}

function travelingExpenseAmountsRime(newVal,oldVal){
	
	if(newVal==undefined || oldVal==undefined){
		return false;
	}
	if(newVal==''){
		newVal=0.00;
	}
	var rows = $('#international_traveling_expense_id-reim').datagrid('getRows');
	var index=$('#international_traveling_expense_id-reim').datagrid('getRowIndex',$('#international_traveling_expense_id-reim').datagrid('getSelected'));
     var num1 = 0;
     for(var i=0;i<rows.length;i++){
		if(i==index){
			num1+=parseFloat(newVal);
		}else{
			num1+=addNumsOut(rows,i);
		}
	}
		$("#applyTravelingExpense").html(fomatMoney(num1,2)+"[元]");
		$("#travelMoney").val(num1.toFixed(2));
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


//选中时给出行人员设置id
function personnerId(){
	
	var index=$('#international_traveling_expense_id-reim').datagrid('getRowIndex',$('#international_traveling_expense_id-reim').datagrid('getSelected'));
	var travelPersonnelId = $('#international_traveling_expense_id-reim').datagrid('getEditor',{
		index:index,
		field:'travelPersonnelId'
	});
	var travelPersonnel = $('#international_traveling_expense_id-reim').datagrid('getEditor',{
		index:index,
		field:'travelPersonnel'
	});
	$(travelPersonnelId.target).textbox('setValue', $(travelPersonnel.target).combobox('getValues'));
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


function travelJson(){
	acceptTravelingExpenseRime();
	var rows1 = $('#international_traveling_expense_id-reim').datagrid('getRows');
	var travel = "";
	for (var i = 0; i < rows1.length; i++) {
		travel = travel + JSON.stringify(rows1[i]) + ",";
	}
	$('#travelJson').val(travel);
}
</script>