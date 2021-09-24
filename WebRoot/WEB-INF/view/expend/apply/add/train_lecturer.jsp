<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="dg_train_lecturer" class="easyui-datagrid" 
	style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#rpl',
	<c:if test="${!empty trainingBean.tId}">
	url: '${base}/apply/trainLecturer?id=${trainingBean.tId}',
	</c:if>
	<c:if test="${empty trainingBean.tId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRow1,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'lId',hidden:true"></th>
				<th data-options="field:'lecturerName',width:120,align:'center',editor:{type:'textbox'}">讲师姓名</th>
				<th data-options="field:'fUnit',width:120,align:'center',editor:{type:'textbox'}">工作单位</th>
				<th data-options="field:'lecturerLevel',width:180,align:'center',editor:{type:'combobox',options:{
								valueField:'code',
								textField:'text',
								editable: true,
								method:'post',
								url:base+'/apply/comboboxJsonsTrainLecturer?parentCode=JSJB',
								onChange:onChangeLecturerLevelApply
							}}">职称/职务</th>
				<th data-options="field:'administrationLevel',width:180,align:'center',editor:{type:'combotree',options:{
								valueField:'code',
								textField:'text',
								method:'post',
								url:base+'/apply/comboboxJsons?parentCode=ZWJBJD',
								onSelect:setAdminCode
							}}">行政级别</th>
				<th data-options="field:'fIdentityNumber',width:180,align:'center',editor:{type:'textbox',options:{
					validType:'length[18,18]'
				}}">身份证号</th>
				<th data-options="field:'phoneNum',width:120,align:'center',editor:{type:'textbox',options:{
					validType:'length[11,11]'
				}}">手机号</th>
				<th data-options="field:'lecturerLevelCode',hidden:true,editor:'textbox'">职称/职务</th>
				<th data-options="field:'isOutside',width:90,align:'center',
					editor:{type:'combobox',options:{valueField:'id',textField:'text',data:[
	                	{id:'1',text:'是'},
	                	{id:'0',text:'否'}],
	                	prompt:'-请选择-',panelHeight:'atuo',editable: false}},formatter:isorno">是否异地</th>
				<th data-options="field:'bank',width:180,align:'center',editor:'textbox'">开户行名称</th>
				<th data-options="field:'bankCard',width:150,align:'center',editor:'textbox'">银行卡号</th>
				<th data-options="field:'administrationLevelCode',hidden:true,width:150,align:'center',editor:'textbox'">行政级别编号</th>
			</tr>
		</thead>
	</table>
	<c:if test="${empty detail}">
	<div id="rpl" style="height:30px;padding-top : 8px">
		<a href="javascript:void(0)" onclick="editLecturer()" id="editId" hidden="hidden" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/xg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a href="javascript:void(0)" onclick="saveLecturer()" id="addId" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" id="removeId" onclick="removeit1()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" id="appendId" onclick="append1()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	</c:if>
	<input type="hidden" id="trainLecturerJson" name="trainLecturer" />
</div>

	
<script type="text/javascript">
function getTrainLecturerJson(){
	accept1();
	var rows = $('#dg_train_lecturer').datagrid('getRows');
	var trainLecturer = "";
	for (var i = 0; i < rows.length; i++) {
		trainLecturer = trainLecturer + JSON.stringify(rows[i]) + ",";
	}
	$('#trainLecturerJson').val(trainLecturer);
}

function isorno(val){
	if(val=='1'){
		return '是';
	}else if(val=='0'){
		return '否';
	}else{
		return val;
	}
}
function saveLecturer(){
	accept1();
	var rows = $('#dg_train_lecturer').datagrid('getRows');
	if(rows==''){
		alert("请添加讲师信息明细！");
		return false;
	}
	var ary = new Array();
	for (var y = 0; y < rows.length; y++) {
		var fIdentityNumber = rows[y].fIdentityNumber;
		ary.push(fIdentityNumber);
	}
	var nary = ary.sort();
	var sign = true;
	for(var i = 0; i < nary.length - 1; i++){
	   if (nary[i] == nary[i+1]){
	       sign = false;
	       break;
	    }
	}
	if(!sign){
		alert('讲师信息中有身份证号重复，请重新填写！');
		return false;
	}
	
	flag2=1;
	$("#addId").hide();
	$("#removeId").hide();
	$("#appendId").hide();
	$("#editId").show();
	$("#rph").show();
	accept1();
	for (var i = rows.length-1; i >= 0; i--) {
		if(rows[i].lecturerName==''&&rows[i].lecturerLevel==''&&rows[i].lecturerLevelCode==''&&rows[i].isOutside==''&&rows[i].bankCard==''&&rows[i].bank==''&&rows[i].phoneNum==''){
			$('#dg_train_lecturer').datagrid('deleteRow',i);
		}
	}
	
	accept2();
	var rowsPlan = $('#dg_train_plan').datagrid('getRows');
	for (var z = rowsPlan.length-1; z >= 0; z--) {
		$('#dg_train_plan').datagrid('deleteRow',z);
	}
	editIndex2 = undefined;
	var allWeak =  getAllWeak();
	for (var m = 0; m<rows.length; m++) {
		for (var x = 0; x<allWeak.length; x++) {
			$('#dg_train_plan').datagrid('appendRow', {
				timeStart:allWeak[x],
				startHourMinute:'09:00',
				endHourMinute:'18:00',
				arrange:'',
				lecturerName:rows[m].lecturerName,
				lessonTime:'8',
				lecturerNumber:rows[m].fIdentityNumber
			});
		}
	}
	
	flag1=0;
	$('#trDateStart').datebox('readonly',true);
	$('#trDateEnd').datebox('readonly',true);
	$('#trAttendNum').numberbox('readonly',true);
	$('#trStaffNum').numberbox('readonly',true);
	$('#fProvinceId').combobox('readonly',true);
	$('#fCityId').combobox('readonly',true);
	$('#fDistrictId').combobox('readonly',true);
	$('#trPlace').textbox('readonly',true);
	
	lecturerArr()
	loadDatas()
}
function editLecturer(){
	flag2 = 0;
	$("#addId").show();
	$("#removeId").show();
	$("#appendId").show();
	$("#editId").hide();
	$("#rph").hide();
	$("#addId1").show();
	$("#removeId1").show();
	$("#appendId1").show();
	$("#editId1").hide();
	accept2();
	flag1=1;
	$('#trDateStart').datebox('readonly',false);
	$('#trDateEnd').datebox('readonly',false);
	$('#trAttendNum').numberbox('readonly',false);
	$('#trStaffNum').numberbox('readonly',false);
	$('#fProvinceId').combobox('readonly',false);
	$('#fCityId').combobox('readonly',false);
	$('#fDistrictId').combobox('readonly',false);
	$('#trPlace').textbox('readonly',false);
}
//表格添加删除，保存方法
	var editIndex1 = undefined;
	function endEditing1() {
		if (editIndex1 == undefined) {
			return true
		}
		if ($('#dg_train_lecturer').datagrid('validateRow', editIndex1)) {
			var tr = $('#dg_train_lecturer').datagrid('getEditors', editIndex1);
			var text2=tr[2].target.combobox('getText');
			if(text2!='--请选择--'){
				tr[2].target.combobox('setValue',text2);
			}
			var text3=tr[3].target.combotree('getText');
			if(text3!='--请选择--'){
				tr[3].target.combotree('setValue',text3);
			}
			$('#dg_train_lecturer').datagrid('endEdit', editIndex1);
			editIndex1 = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRow1(index) {
		
		if(flag2==1){
			return false;
		}else{
			if (editIndex1 != index) {
				if (endEditing1()) {
					$('#dg_train_lecturer').datagrid('selectRow', index).datagrid('beginEdit',
							index);
					editIndex1 = index;
				} else {
					$('#dg_train_lecturer').datagrid('selectRow', editIndex1);
				}
			}
		}
	}
	function append1() {
		if (endEditing1()) {
			$('#dg_train_lecturer').datagrid('appendRow', {});
			editIndex1 = $('#dg_train_lecturer').datagrid('getRows').length - 1;
			$('#dg_train_lecturer').datagrid('selectRow', editIndex1).datagrid('beginEdit',editIndex1);
		}
	}
	function removeit1() {
		if (editIndex1 == undefined) {
			return
		}
		$('#dg_train_lecturer').datagrid('cancelEdit', editIndex1).datagrid('deleteRow',
				editIndex1);
		editIndex1 = undefined;
	}
	function accept1() {
		if (endEditing1()) {
			$('#dg_train_lecturer').datagrid('acceptChanges');
		}
	}
	
	function setCodeLevel(rec){
		
		var row = $('#dg_train_lecturer').datagrid('getSelected');
		var rindex = $('#dg_train_lecturer').datagrid('getRowIndex', row); 
		var ed = $('#dg_train_lecturer').datagrid('getEditor',{
			index:rindex,
			field : 'lecturerLevelCode'  
		});
			$(ed.target).textbox('setValue', rec.code);
	}
	function setAdminCode(rec){
		var row = $('#dg_train_lecturer').datagrid('getSelected');
		var rindex = $('#dg_train_lecturer').datagrid('getRowIndex', row); 
		var administrationLevelCode = $('#dg_train_lecturer').datagrid('getEditor',{
			index:rindex,
			field : 'administrationLevelCode'  
		});
			$(administrationLevelCode.target).textbox('setValue', rec.code);
	}
	//讲师姓名数组
	function lecturerArr(){
		var rows = $('#dg_train_lecturer').datagrid('getRows');
		var arr = new Array();
		for (var i = 0; i < rows.length; i++) {
		var fIdentityNumber = rows[i].fIdentityNumber;
		var lecturerName = rows[i].lecturerName;
				var idAndName = {};
				idAndName.id = fIdentityNumber;
				idAndName.text = lecturerName;
				arr.push(idAndName);
		}
		return arr;
	}
	//讲师姓名数组用于教师费-城市间交通费
	function lecturerArrCarFare(){
		var rows = $('#dg_train_lecturer').datagrid('getRows');
		var arr = new Array();
		for (var i = 0; i < rows.length; i++) {
		var lecturerName = rows[i].lecturerName;
		var administrationLevelCode = rows[i].administrationLevelCode;
				var idAndName = {};
				idAndName.id = administrationLevelCode;
				idAndName.text = lecturerName;
				arr.push(idAndName);
		}
		return arr;
	}
	//加载各项费用列表
	function loadDatas(){
		var nameArr = lecturerArr();
		loadLessons();
		loadHotel(nameArr);
		loadFood(nameArr);
		loadTraffic1(nameArr);
//		loadTraffic2(nameArr);
		updatePlan(nameArr);
	}
	//加载住宿费列表
	function loadHotel(nameArr){
		var data = new Array();
		$('#mingxi-hotel-dg').datagrid('loadData',data);
		editIndex5 = undefined;
		$('#lessonsHotelMoney').val(0);
		$('#hotelAmount').html('0.00[元]');
	}
	//加载伙食费列表
	function loadFood(nameArr){
		var data = new Array();
		$('#mingxi-food-dg').datagrid('loadData',data);
		editIndex6 = undefined;
		$('#lessonsFoodMoney').val(0);
		$('#foodAmount').html('0.00[元]');
	}
	//加载城市间交通费列表
	function loadTraffic1(nameArr){
		var data = new Array();
		$('#mingxi-trafficCityToCity-dg').datagrid('loadData',data);
		editIndex7 = undefined;
		$('#lessonsOutMoney').val(0);
		$('#traffic1Amount').html('0.00[元]');
	}
	//加载市内交通费列表
	function loadTraffic2(nameArr){
		var data = new Array();
		$('#mingxi-trafficInCity-dg').datagrid('loadData',data);
		editIndex8 = undefined;
	}
	//加载讲课费列表
	function loadLessons(){
		
		var data = new Array();
		$('#mingxi-lessons-dg').datagrid('loadData',data);
		$('#lessonsMoney').val(0);
		$('#lessonsAmount').html('0.00[元]');
		editIndex4 = undefined;
		var rows = $('#dg_train_lecturer').datagrid('getRows');
		for (var i = 0; i < rows.length; i++) {
			var lecturerName = rows[i].lecturerName;
			var fIdentityNumber = rows[i].fIdentityNumber;
			var lecturerLevelCode =rows[i].lecturerLevelCode;
				var lessonStd=0;
				if(lecturerLevelCode=='JSJB-01'){
					lessonStd=$('#lesson1Std').val();
				}else if(lecturerLevelCode=='JSJB-02'){
					lessonStd=$('#lesson2Std').val();
				}else if(lecturerLevelCode=='JSJB-03'){
					lessonStd=$('#lesson3Std').val();
				}
			var isOutside =rows[i].isOutside;
			$('#mingxi-lessons-dg').datagrid('appendRow', {
				lecturerName: lecturerName,
				lessonStd: lessonStd,
				isOutside: isOutside,
				fIdentityNumber: fIdentityNumber
			});
		}
	}
	//刷新讲课费列表
	function updateLessons(arr){
		
		var rows = $('#mingxi-lessons-dg').datagrid('getRows');
		for (var i = 0; i < rows.length; i++) {
			for (var j = 0; j < arr.length; j++){
				if(rows[i].fIdentityNumber==arr[j].id){
					var hours =arr[j].hours;
					var isOutside =rows[i].isOutside;
					var lessonStd =rows[i].lessonStd;
					var lessonStdTotal=0;
					if(hours!=''){
					 lessonStdTotal = parseFloat(lessonStd)*parseFloat(hours);
					}
					if(isOutside=='1'){
						lessonStdTotal = lessonStd*1.3;
					}else{
						lessonStdTotal = lessonStd;
					}
					$('#mingxi-lessons-dg').datagrid('updateRow',{
						index: i,
						row: {
							lessonStd: lessonStdTotal,
							lessonTime:hours
						}
					});
				}
			}
		}
		editIndex4 = undefined;
	}
	//刷新培训日程
	function updatePlan(arr){
		var rows = $('#dg_train_plan').datagrid('getRows');
		for (var i = 0; i < rows.length; i++) {
				if( JSON.stringify(arr).indexOf(rows[i].lecturerName) == -1 ) {
					$('#dg_train_plan').datagrid('deleteRow',
							i);
				}
		}
	}
	
function onChangeLecturerLevelApply(newVal,oldVal){
	var row = $('#dg_train_lecturer').datagrid('getSelected');
	var rindex = $('#dg_train_lecturer').datagrid('getRowIndex', row); 
	var ed = $('#dg_train_lecturer').datagrid('getEditor',{
		index:rindex,
		field : 'lecturerLevelCode'  
	});
	var lecturerLevel = $('#dg_train_lecturer').datagrid('getEditor',{
		index:rindex,
		field : 'lecturerLevel'  
	});
	var newVal = $(lecturerLevel.target).combobox('getValue');
	if(newVal=='院士、全国知名专家'||newVal=='JSJB-01'||newVal=='正高级技术职称专业人员'||newVal=='JSJB-02'||newVal=='副高级技术职称专业人员'||newVal=='JSJB-03'){
		if(newVal=='JSJB-01'||newVal=='JSJB-02'||newVal=='JSJB-03'){
			$(ed.target).textbox('setValue', newVal);
		}
	}else{
		$(ed.target).textbox('setValue', 'JSJB-03');
	}
	
}


/**
 * 获取日期段所有的日期字符串
 * var weak = getAllWeak(begintime,endtime)+"," 加“，”  //调用方法将动态的开始时间，结束时间放    
 * 入参数中
 * weak.split(",")[i]  //将获取的字符串截取
 * @returns  返回所有日期的字符串
 */
function getAllWeak(){
	var maxTime = Date.parse(new Date($("#trDateEnd").datebox('getValue')));
    var minTime = Date.parse(new Date($("#trDateStart").datebox('getValue')));
	var begin = new Date(minTime), end = new Date(maxTime);
	var begin_time = begin.getTime(), maxTime = end.getTime(), time_diff = maxTime - begin_time;
	var all_d = [];
	for (var i = 0; i <= time_diff; i += 86400000){
	    var ds = new Date(begin_time + i);
	    all_d.push(ds.getFullYear()+"-"+(ds.getMonth()+1)+"-"+ds.getDate());
	}
	return all_d;
}
</script>