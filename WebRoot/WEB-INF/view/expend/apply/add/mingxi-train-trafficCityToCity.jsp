<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<c:if test="${type!=1}">
<!-- <div class="window-title">费用明细</div> -->
</c:if>


<div class="window-tab" style="margin-left: 0px;padding-top: 10px">

	<div id="trafficCityToCity_Id" style="height:30px;padding-top : 8px">
		<a style="float: left; font-weight: bold;color: #005E8A;font-size:12px;">师资费-城市间交通费</a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">合计金额：<span id="traffic1Amount"><fmt:formatNumber groupingUsed="true" value="${trainingBean.lessonsOutMoney}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<c:if test="${empty detail}">
		<a href="javascript:void(0)" id="removeToCityId" onclick="removeit7()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" id="appendToCityId" onclick="append7()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		</c:if>
	</div>
	<table id="mingxi-trafficCityToCity-dg" class="easyui-datagrid" style="width:707px;height:auto;"
	data-options="
	toolbar: 'trafficCityToCity_Id',
	<c:if test="${!empty trainingBean.tId}">
	url: '${base}/apply/teacherMingxi?id=${trainingBean.tId}&costType=traffic1',
	</c:if>
	<c:if test="${empty trainingBean.tId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRow7,
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
				<th data-options="field:'lecturerName',width:170,align:'center',editor:{type:'combobox',options:{
                                valueField:'id',
                                textField:'text',
                                multiple: false,
                                onShowPanel:chooseLecturers,
                                editable:false,
                                onHidePanel:onHidePanelLectureName
                            }}">讲师姓名</th>
				<th data-options="field:'administrativeLevelName',required:'required',align:'center',width:170,editor:{type:'textbox',options:{editable:false}}">行政级别</th>
					<th data-options="field:'vehicle',width:180,align:'center',editor:{
							editable:true,
							type:'combobox',
							options:{
								valueField:'text',
								textField:'text',
                                multiple: true,
								method:'post',
								url:base+'/vehicle/comboboxJson',
							}}">交通工具</th>
				<c:if test="${empty detail}">
				<th data-options="field:'applySum',required:'required',align:'center',width:180,editor:{type:'numberbox',options:{onChange:addNum5,precision:2}}">申请金额[元]</th>
				</c:if>
				<c:if test="${!empty detail}">
				<th data-options="field:'applySum',required:'required',align:'center',width:180,editor:{type:'numberbox',options:{precision:2,groupSeparator:','}}">申请金额[元]</th>
				</c:if>
				<th data-options="field:'administrativeLevel',hidden:true,align:'center',editor:{type:'textbox',options:{onChange:onChangeLevel}}">行政级别编号</th>
		</tr>
	</thead>
	</table>
	
</div>

<input type="hidden" id="trafficJson1" name="trafficJson1"/>
<script type="text/javascript">
function getTrafficJson1(){
	accept7();
	var rows = $('#mingxi-trafficCityToCity-dg').datagrid('getRows');
	var trafficJson1 = "";
	for (var i = 0; i < rows.length; i++) {
		trafficJson1 = trafficJson1 + JSON.stringify(rows[i]) + ",";
	}
	$('#trafficJson1').val(trafficJson1);
}
function append7(){
	if (endEditing7()) {
		$('#mingxi-trafficCityToCity-dg').datagrid('appendRow', {});
		editIndex7 = $('#mingxi-trafficCityToCity-dg').datagrid('getRows').length - 1;
		$('#mingxi-trafficCityToCity-dg').datagrid('selectRow', editIndex7).datagrid('beginEdit',editIndex7);
	}
}
function removeit7(){
	if (editIndex7 == undefined) {
		return false;
	}
	$('#mingxi-trafficCityToCity-dg').datagrid('cancelEdit', editIndex7).datagrid('deleteRow',
			editIndex7);
	editIndex7 = undefined;
}
//接待人员表格添加删除，保存方法
var editIndex7 = undefined;
function endEditing7() {
	if (editIndex7 == undefined) {
		return true
	}
	if ($('#mingxi-trafficCityToCity-dg').datagrid('validateRow', editIndex7)) {
		var tr = $('#mingxi-trafficCityToCity-dg').datagrid('getEditors', editIndex7);
		var text0=tr[0].target.combobox('getText');
		if(text0!='--请选择--'){
			tr[0].target.combobox('setValue',text0);
		}
		var text2=tr[2].target.combobox('getText');
		if(text2!='--请选择--'){
			tr[2].target.combobox('setValue',text2);
		}
		$('#mingxi-trafficCityToCity-dg').datagrid('endEdit', editIndex7);
		editIndex7 = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow7(index) {
		if (editIndex7 != index) {
			if (endEditing7()) {
				$('#mingxi-trafficCityToCity-dg').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex7 = index;
			} else {
				$('#mingxi-trafficCityToCity-dg').datagrid('selectRow', editIndex7);
			}
		}
}
function accept7() {
	if (endEditing7()) {
		$('#mingxi-trafficCityToCity-dg').datagrid('acceptChanges');
	}
}
function reloadOut(rec){
	var row = $('#mingxi-trafficCityToCity-dg').datagrid('getSelected');
	var rindex = $('#mingxi-trafficCityToCity-dg').datagrid('getRowIndex', row); 
	var ed = $('#mingxi-trafficCityToCity-dg').datagrid('getEditor',{
		index:rindex,
		field : 'vehicleLevel'  
	});
	var administrativeLevel = $('#mingxi-trafficCityToCity-dg').datagrid('getEditor',{
		index:rindex,
		field : 'administrativeLevel'  
	});
	var level='';
	if($(administrativeLevel.target).textbox('getValue')=='市级及相当职务人员'){
		level=1;
	}else{
		if($(administrativeLevel.target).textbox('getValue')=='处级、正高级及相当职务人员'){
			level=2;
		}else{
			if($(administrativeLevel.target).textbox('getValue')=='其他人员'){
				level=3;
			}
		}
	}
		$(ed.target).combotree('setValue', '');
		var url = base+'/vehicle/comboboxJsons?selected=${travelBean.vehicle}&parentCode='+rec.code+'&level='+level+',';
    	$(ed.target).combotree('reload', url);
}
//计算申请金额
function addNum5(newValue,oldValue) {
		var num = 0;
		var rows = $('#mingxi-trafficCityToCity-dg').datagrid('getRows');
		var row = $('#mingxi-trafficCityToCity-dg').datagrid('getSelected');//获得选择行
		var index=$('#mingxi-trafficCityToCity-dg').datagrid('getRowIndex',row);//获得选中行的行号
		var tr = $('#mingxi-trafficCityToCity-dg').datagrid('getEditors', index);
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
		$('#lessonsOutMoney').val(num.toFixed(2));
		$('#traffic1Amount').html(fomatMoney(num,2)+"[元]");
		addTotalAmount()
}
function chooseLecturers(){
	$('#mingxi-trafficCityToCity-dg').datagrid('selectRow', editIndex7).datagrid('beginEdit',
			editIndex7);
	var index=$('#mingxi-trafficCityToCity-dg').datagrid('getRowIndex',$('#mingxi-trafficCityToCity-dg').datagrid('getSelected'));
		var new_arrs= lecturerArrCarFare();
		var lecturer = $('#mingxi-trafficCityToCity-dg').datagrid('getEditor',{
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

function onHidePanelLectureName(){
	
	var row = $('#mingxi-trafficCityToCity-dg').datagrid('getSelected');//获得选择行
	var index=$('#mingxi-trafficCityToCity-dg').datagrid('getRowIndex',row);
	var administrativeLevel = $('#mingxi-trafficCityToCity-dg').datagrid('getEditor',{
		index:index,
		field:'administrativeLevel'
	});
	var lecturer = $('#mingxi-trafficCityToCity-dg').datagrid('getEditor',{
		index:index,
		field:'lecturerName'
	});
	var lecturerId = $(lecturer.target).combobox('getValue');
	$(administrativeLevel.target).textbox('setValue',lecturerId);

	var rows = $('#mingxi-trafficCityToCity-dg').datagrid('getRows');
	var num = "";
	for(var i=0;i<rows.length;i++){
		if(i!=index){
			if(rows[i].administrativeLevel!=""&&rows[i].administrativeLevel!=null){
				if(num==""){
					num = rows[i].administrativeLevel;
				}else{
				num = num+","+rows[i].administrativeLevel;
				}
			}
		}
	}
	if(lecturerId!=""&&lecturerId!=null) {
		if(num==""){
			num = lecturerId;
		}else{
			num =num+","+lecturerId;
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
	$("#applyShengJiId").empty();
	var shengji = '省级人员可乘坐火车软席（软座、软卧），高铁/动车商务座，全列软席列车一等软座；轮船（不包括旅游船）一等舱；飞机头等舱<br/>';
	var tingji = '厅级人员可乘坐火车软席（软座、软卧），高铁/动车一等座，全列软席列车一等软座；轮船（不包括旅游船）二等舱；飞机经济舱<br/>';
	var qita = '其他人员可乘坐火车硬席（硬座、硬卧），高铁/动车二等座、全列软席列车二等软座；轮船（不包括旅游船）三等舱；飞机经济舱<br/>';
	var trafficHint = ''
	for ( var i in arrs) {
		if(arrs[i]=='ZWJBJD-01'){
			trafficHint += shengji;
		}
		if(arrs[i]=='ZWJBJD-02'){
			trafficHint += tingji;
		}
		if(arrs[i]=='ZWJBJD-03'){
			trafficHint += qita;
		}
	}
	$("#applyShengJiId").html(trafficHint);
	$("#fTrafficHint").val(trafficHint);
}

function onChangeLevel(newVal,oldVal){
	var row = $('#mingxi-trafficCityToCity-dg').datagrid('getSelected');//获得选择行
	var index=$('#mingxi-trafficCityToCity-dg').datagrid('getRowIndex',row);
	if(newVal=="ZWJBJD-01"){
		var administrativeLevelName = $('#mingxi-trafficCityToCity-dg').datagrid('getEditor',{
			index:index,
			field:'administrativeLevelName'
		});
		$(administrativeLevelName.target).textbox('setValue',"省级");
	}
	if(newVal=="ZWJBJD-02"){
		var administrativeLevelName = $('#mingxi-trafficCityToCity-dg').datagrid('getEditor',{
			index:index,
			field:'administrativeLevelName'
		});
		$(administrativeLevelName.target).textbox('setValue',"厅级");
		
	}
	if(newVal=="ZWJBJD-03"){
		var administrativeLevelName = $('#mingxi-trafficCityToCity-dg').datagrid('getEditor',{
			index:index,
			field:'administrativeLevelName'
		});
		$(administrativeLevelName.target).textbox('setValue',"其他人员");
		
	}
}
</script>
