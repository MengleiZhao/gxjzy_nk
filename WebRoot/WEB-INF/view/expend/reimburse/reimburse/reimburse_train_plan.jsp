<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<c:if test="${empty detail}">
	<div id="rp1" hidden="hidden" style="height:30px;padding-top : 8px">
		<a href="javascript:void(0)" onclick="editPlan()" id="editId1" hidden="hidden" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/xg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a href="javascript:void(0)" onclick="savePlan()" id="addId1" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="removeit2()" id="removeId1" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="append2()" id="appendId1" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	</c:if>
	<table id="dg_train_plan" class="easyui-datagrid" 
	style="width:693px;height:auto"
	data-options="
	singleSelect: true,
	<c:if test="${!empty reimbTrainingBean.tId}">
	url: '${base}/apply/trainPlan?id=${reimbTrainingBean.tId}',
	</c:if>
	<c:if test="${empty reimbTrainingBean.tId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRow2,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'planId',hidden:true"></th>
				<th data-options="field:'timeStart',width:140,align:'center',editor:{type:'datebox',options:{showSeconds:false,onHidePanel:changeTime3,editable:false}},formatter:ChangeDateFormatTrain">起始时间</th>
				<th data-options="field:'startHourMinute',width:130,align:'center',editor:{type:'timespinner',options:{showSeconds:false,editable:true,onChange:onChangeStartTimesReim}}">起始时间</th>
				<th data-options="field:'endHourMinute',width:130,align:'center',editor:{type:'timespinner',options:{showSeconds:false,editable:true,onChange:onChangeEndTimesReim}}">结束时间</th>
				<th data-options="field:'arrange',width:175,align:'center',editor:'textbox'">培训内容</th>
				<th data-options="field:'lecturerName',width:130,align:'center',editor:{type:'combobox',options:{
                                valueField:'id',
                                textField:'text',
                                multiple: true,
                                onShowPanel:chooseLecturer,
                                onHidePanel:onHidePanelLecturer,
                                editable:false,
                                onChange:onChangeLessonNameReim
                            }}">讲师姓名</th>
				<th data-options="field:'lessonTime',width:80,align:'center',
					editor:{type:'numberbox',options:{onChange:onChangeLessonTimesReim}}">学时</th>
                <th data-options="field:'lecturerNumber',hidden:true,editor:'textbox'">讲师身份证号</th>
			</tr>
		</thead>
	</table>
</div>
<script type="text/javascript">
$.fn.datebox.defaults.parser = function(s){
	 var t = Date.parse(s);
	 if (!isNaN(t)){
	  return new Date(t);
	 } else {
	  return new Date();
	 }
	};
function savePlan(){
	flag1=1;
	var rows = $('#dg_train_plan').datagrid('getRows');
	if(rows==''){
		alert("请添加会议日程！");
		return false;
	}
	$("#addId1").hide();
	$("#removeId1").hide();
	$("#appendId1").hide();
	$("#editId1").show();
	accept2();
	var arr=lecturerHoursArr();
	
	updateLessons(arr);
}

function editPlan(){
	flag1 = 0;
	$("#addId1").show();
	$("#removeId1").show();
	$("#appendId1").show();
	$("#editId1").hide();
}

function getTrainPlanJson(){
	accept2();
	var rows = $('#dg_train_plan').datagrid('getRows');
	var trainPlan = "";
	for (var i = 0; i < rows.length; i++) {
		trainPlan = trainPlan + JSON.stringify(rows[i]) + ",";
	}
	$('#trainPlan').val(trainPlan);
}
//接待人员表格添加删除，保存方法
	var editIndex2 = undefined;
	function endEditing2() {
		if (editIndex2 == undefined) {
			return true
		}
		if ($('#dg_train_plan').datagrid('validateRow', editIndex2)) {
			//下面三行，是在增加一行的时候，防止原来的一行的值变成code
			var tr = $('#dg_train_plan').datagrid('getEditors', editIndex2);
			var text4=tr[4].target.combobox('getText');
			if(text4!='--请选择--'){
				tr[4].target.combobox('setValue',text4);
			}
			$('#dg_train_plan').datagrid('endEdit', editIndex2);
			editIndex2 = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRow2(index) {
		if(flag1==1){
			return false;
		}else{
		if (editIndex2 != index) {
			if (endEditing2()) {
				$('#dg_train_plan').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex2 = index;
			} else {
				$('#dg_train_plan').datagrid('selectRow', editIndex2);
			}
		}
	}
}
	function append2() {
		if (endEditing2()) {
			$('#dg_train_plan').datagrid('appendRow', {});
			editIndex2 = $('#dg_train_plan').datagrid('getRows').length - 1;
			$('#dg_train_plan').datagrid('selectRow', editIndex2).datagrid('beginEdit',editIndex2);
		}
	}
	function removeit2() {
		if (editIndex2 == undefined) {
			return
		}
		$('#dg_train_plan').datagrid('cancelEdit', editIndex2).datagrid('deleteRow',
				editIndex2);
		editIndex2 = undefined;
	}
	function accept2() {
		if (endEditing2()) {
			$('#dg_train_plan').datagrid('acceptChanges');
		}
	}
	//计算学时
	function addHour(){
		var index=$('#dg_train_plan').datagrid('getRowIndex',$('#dg_train_plan').datagrid('getSelected'));
	    var editors = $('#dg_train_plan').datagrid('getEditors', index); 
	    var ed1 = editors[0]; 
	    var ed2 = editors[1]; 
	    var time1 =new Date(ed1.target.val());
	    var time2 =new Date(ed2.target.val());
	    if(!isNaN(time1) &&!isNaN(time2) ){
	   	 	var h = ((time2-time1)/3600000).toFixed(1);
	        	editors[3].target.textbox('setValue', h);
	        }
	}
	
	//计算学时合计
	function addStuHour(newValue,oldValue){
		var price = parseFloat(newValue);
		var row = $('#dg_train_plan').datagrid('getSelected');//获得选择行
		var index=$('#dg_train_plan').datagrid('getRowIndex',row);//获得选中行的行号
		var tr = $('#dg_train_plan').datagrid('getEditors', index);
		
		var num = 0;
		var rows = $('#dg_train_plan').datagrid('getRows');
		for(var i=0;i<rows.length;i++){
			if(i!=index){
				if(rows[i].lessonTime!=""&&rows[i].lessonTime!=null){
					num += parseFloat(rows[i].lessonTime);
				}
			}
		}
		if(newValue!=""&&newValue!=null) {
			num += parseFloat(newValue);
		}
	}
	function changeTime3(){
		
		var index=$('#dg_train_plan').datagrid('getRowIndex',$('#dg_train_plan').datagrid('getSelected'));
		var editors = $('#dg_train_plan').datagrid('getEditors', index);  
		var endEditor = editors[1]; 
		var startday = Date.parse(new Date(editors[0].target.val()));
		var maxTime = Date.parse(new Date($("#trDateEnd").datebox('getValue')))+ (16 * 60 * 60 * 1000);
	    var minTime = Date.parse(new Date($("#trDateStart").datebox('getValue')))- (8 * 60 * 60 * 1000);
		var endday = Date.parse(new Date(endEditor.target.val()));
		if(!isNaN(startday)){
	    	if(startday>=minTime &&startday<=maxTime){
	    		if(!isNaN(endday)){
		    		if(endday<startday){
		        		alert("结束日期不能小于开始日期！");
		        		editors[0].target.datebox('setValue', '');
		        	}
	    		}
	    	}else{
	    		if(startday>maxTime || startday<minTime){
		    	alert("所选时间不在日程范围内请重新选择！");
	    		editors[0].target.datebox('setValue', '');
	    		}
	    	}
	    	
	    } 
		
		
		var timeStart = $('#dg_train_plan').datagrid('getEditor',{//培训时间
			index:index,
			field:'timeStart'
		});
		var lessonTimes = $('#dg_train_plan').datagrid('getEditor',{//学时
			index:index,
			field:'lessonTime'
		});
		var lecturerNumber = $('#dg_train_plan').datagrid('getEditor',{ //身份证号
			index:index,
			field:'lecturerNumber'
		});
		
		
		var timeStarts = $(timeStart.target).datebox('getValue');
		var lecturerNumbers = $(lecturerNumber.target).textbox('getValue');
		var lessonTime = $(lessonTimes.target).textbox('getValue');
		if(timeStarts=='' || lecturerNumbers=='' || lessonTime==''){
			return false;
		}
		var flag = lecturerHoursArrsReim(index,lessonTime,timeStarts,lecturerNumbers);
		if(!flag){
			alert('每天的标准学时不能超过8小时！');
			$(lessonTimes.target).numberbox('setValue','');
			return false;
		}
	}
	
	
	function changeTime4(){
		
		var index=$('#dg_train_plan').datagrid('getRowIndex',$('#dg_train_plan').datagrid('getSelected'));
		var editors = $('#dg_train_plan').datagrid('getEditors', index);  
		var endEditor = editors[1]; 
		var startday = Date.parse(new Date(editors[0].target.val()));
		var maxTime = Date.parse(new Date($("#trDateEnd").datebox('getValue')))+ (16 * 60 * 60 * 1000);
	    var minTime = Date.parse(new Date($("#trDateStart").datebox('getValue')))- (8 * 60 * 60 * 1000);
		var endday = Date.parse(new Date(endEditor.target.val()));
		if(!isNaN(endday)){
	    	if((endday>=minTime &&endday<=maxTime) ){
	    		if(!isNaN(startday)){
		    		if(endday<startday){
		        		alert("结束日期不能小于开始日期！");
		        		editors[1].target.datebox('setValue', '');
		        	}
	    		}
	    	}else{
	    		if(endday>maxTime || endday<minTime){
		    	alert("所选时间不在日程范围内请重新选择！");
	    		editors[1].target.datebox('setValue', '');
	    		}
	    	}
	    	
	    } 
	}
	
	function chooseLecturer(){
		
		$('#dg_train_plan').datagrid('selectRow', index).datagrid('beginEdit',
				index);
		var index=$('#dg_train_plan').datagrid('getRowIndex',$('#dg_train_plan').datagrid('getSelected'));
			var new_arrs= lecturerArr();
			var lecturer = $('#dg_train_plan').datagrid('getEditor',{
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
	
function onHidePanelLecturer(){
		var index=$('#dg_train_plan').datagrid('getRowIndex',$('#dg_train_plan').datagrid('getSelected'));
		var lecturerNumber = $('#dg_train_plan').datagrid('getEditor',{
			index:index,
			field:'lecturerNumber'
		});
		var lecturerName = $('#dg_train_plan').datagrid('getEditor',{
			index:index,
			field:'lecturerName'
		});
		$(lecturerNumber.target).textbox('setValue', $(lecturerName.target).combobox('getValues'));
	}
	//讲师姓名、学时数组
	function lecturerHoursArr(){
		
		var rows = $('#dg_train_plan').datagrid('getRows');
		var arr = new Array();
		for (var i = 0; i < rows.length; i++) {
		var lecturerName = rows[i].lecturerName;
		var lessonTime = rows[i].lessonTime;
		var lecturerNumber = rows[i].lecturerNumber;
				var idAndName = {};
				idAndName.id = lecturerNumber;
				idAndName.name = lecturerName;
				idAndName.hours = lessonTime;
				arr.push(idAndName);
		}
		var b = [];//记录数组a中的id 相同的下标
        for(var h = 0; h < arr.length;h++){
            for(var j = arr.length-1;j>h;j--){
                if(arr[h].id == arr[j].id){
                	arr[h].hours = (parseFloat(arr[h].hours) + parseFloat(arr[j].hours)).toString();
                    b.push(j);
                }
            }
        }
        for(var k = 0; k<b.length;k++){
            arr.splice(b[k],1);
        }
		return arr;
	}
	
	function onChangeStartTimesReim(newVal,oldVal){
		if(newVal==undefined || oldVal==undefined){
			return false;
		}
		var index=$('#dg_train_plan').datagrid('getRowIndex',$('#dg_train_plan').datagrid('getSelected'));
		var endHourMinute = $('#dg_train_plan').datagrid('getEditor',{//培训时间
			index:index,
			field:'endHourMinute'
		});
		
		if($(endHourMinute.target).timespinner('getValue')==''){
			return false;
		}
		var index=$('#dg_train_plan').datagrid('getRowIndex',$('#dg_train_plan').datagrid('getSelected'));
		var lessonTimes = $('#dg_train_plan').datagrid('getEditor',{//学时
			index:index,
			field:'lessonTime'
		});
		var lessonTime = dateTimeDifferenceReim(newVal, $(endHourMinute.target).timespinner('getValue'), "HH");
		if(lessonTime>8){
			$(lessonTimes.target).textbox('setValue','8');
		}else{
			$(lessonTimes.target).textbox('setValue',lessonTime);
		}
	}
	function onChangeEndTimesReim(newVal,oldVal){
		if(newVal==undefined || oldVal==undefined){
			return false;
		}
		var index=$('#dg_train_plan').datagrid('getRowIndex',$('#dg_train_plan').datagrid('getSelected'));
		var startHourMinute = $('#dg_train_plan').datagrid('getEditor',{//培训时间
			index:index,
			field:'startHourMinute'
		});
		if($(startHourMinute.target).timespinner('getValue')==''){
			return false;
		}
		var index=$('#dg_train_plan').datagrid('getRowIndex',$('#dg_train_plan').datagrid('getSelected'));
		var lessonTimes = $('#dg_train_plan').datagrid('getEditor',{//学时
			index:index,
			field:'lessonTime'
		});
		var lessonTime = dateTimeDifferenceReim($(startHourMinute.target).timespinner('getValue'),newVal, "HH");
		if(lessonTime>8){
			$(lessonTimes.target).textbox('setValue','8');
		}else{
			$(lessonTimes.target).textbox('setValue',lessonTime);
		}
	}
	
	function onChangeLessonNameReim(newVal,oldVal){
		if(newVal==undefined || oldVal==undefined){
			return false;
		}
		
		var index=$('#dg_train_plan').datagrid('getRowIndex',$('#dg_train_plan').datagrid('getSelected'));
		
		var timeStart = $('#dg_train_plan').datagrid('getEditor',{//培训时间
			index:index,
			field:'timeStart'
		});
		var lessonTimes = $('#dg_train_plan').datagrid('getEditor',{//学时
			index:index,
			field:'lessonTime'
		});
		var timeStarts = $(timeStart.target).datebox('getValue');
		var lessonTime = $(lessonTimes.target).textbox('getValue');
		var flag = lecturerHoursArrsReim(index,lessonTime,timeStarts,newVal);
		if(!flag){
			alert('每天的标准学时不能超过8小时！');
			$(lessonTimes.target).numberbox('setValue','');
			return false;
		}
			
	}
	function onChangeLessonTimesReim(newVal,oldVal){
		if(newVal==undefined || oldVal==undefined){
			return false;
		}
		
		var index=$('#dg_train_plan').datagrid('getRowIndex',$('#dg_train_plan').datagrid('getSelected'));
		
		var timeStart = $('#dg_train_plan').datagrid('getEditor',{//培训时间
			index:index,
			field:'timeStart'
		});
		var startHourMinute = $('#dg_train_plan').datagrid('getEditor',{//开始时分
			index:index,
			field:'startHourMinute'
		});
		var endHourMinute = $('#dg_train_plan').datagrid('getEditor',{//结束时分
			index:index,
			field:'endHourMinute'
		});
		var lessonTimes = $('#dg_train_plan').datagrid('getEditor',{//学时
			index:index,
			field:'lessonTime'
		});
		var lecturerNumber = $('#dg_train_plan').datagrid('getEditor',{ //身份证号
			index:index,
			field:'lecturerNumber'
		});
		var lessonTime = dateTimeDifferenceReim($(startHourMinute.target).timespinner('getValue'), $(endHourMinute.target).timespinner('getValue'), "HH");
		var aa = isNaN(parseInt(lessonTime))?0:parseInt(lessonTime);
		
		if(parseInt(newVal)>aa){
			alert('填写学时超出当前时间段学时的最大值！');
			$(lessonTimes.target).numberbox('setValue','');
			return false;
		}
		if(parseInt(newVal)>8){
			alert('每天的标准学时不能超过8小时！');
			$(lessonTimes.target).numberbox('setValue','');
			return false;
		}
		
		
		var timeStarts = $(timeStart.target).datebox('getValue');
		var lecturerNumbers = $(lecturerNumber.target).textbox('getValue');
		var flag =true;
		if(aa>8  &&  newVal<=8){
			flag = lecturerHoursArrsReim(index,newVal,timeStarts,lecturerNumbers);
		}
		if(aa<=8  &&  newVal<=aa){
			flag = lecturerHoursArrsReim(index,newVal,timeStarts,lecturerNumbers);
		}
		if(!flag){
			alert('每天的标准学时不能超过8小时！');
			$(lessonTimes.target).numberbox('setValue','');
			return false;
		}
			
	}
	

	/**
	 * 
	 * @param {any} oneTime 开始时间 yyyy-mm-dd hh24:min:sec
	 * @param {any} twoTime 结束时间 yyyy-mm-dd hh24:min:sec
	 * @param {any} stype   返回类型:
	                        1.SEC:相差秒数，
	                        2.MIN:相差分钟数，
	                        3.HH:相差小时数，
	                        4.HH:MIN:SEC:相差 “时：分：秒” 数，
	                        5.DD:相差天数，
	                        6.MM:相差月数，
	                        7.YY：相差年数。
	 */
	function dateTimeDifferenceReim(oneTime, twoTime, stype) {
	    oneTime = "2021-03-13 "+oneTime;
	    twoTime = "2021-03-13 "+twoTime;
	    if (oneTime == null || oneTime == "") return 0;
	    if (twoTime == null || twoTime == "") return 0;
	    var myoneTime = new Date(oneTime.replace(/\-/g, "/"));
	    var mytwoTime = new Date(twoTime.replace(/\-/g, "/"));
	    if (myoneTime == null || myoneTime == "") return 0;
	    if (mytwoTime == null || mytwoTime == "") return 0;
	    if (myoneTime > mytwoTime) return 0;

	    if (stype == "SEC") {
	        return (mytwoTime - myoneTime) / 1000 ;//+ "sec"
	    } else if (stype == "MIN") {
	        return ((mytwoTime - myoneTime) / 1000) / 60 ;//+ "min"
	    } else if (stype == "HH") {
	        return (((mytwoTime - myoneTime) / 1000) / 60) / 60 ;//+ "h"
	    } else if (stype == "DD") {
	        return ((((mytwoTime - myoneTime) / 1000) / 60) / 60) / 24 ;//+ "D"
	    } else if (stype == "MM") {
	        return (((((mytwoTime - myoneTime) / 1000) / 60) / 60) / 24) / 31 ;//+ "M"
	    } else if (stype == "YY") {
	        return ((((((mytwoTime - myoneTime) / 1000) / 60) / 60) / 24) / 31) / 365 ;//+ "Y"
	    } else if (stype == "HH:MIN:SEC") {
	        var seconds = (mytwoTime - myoneTime) / 1000;
	        if (seconds <= 60) {
	            return seconds + "sec";
	        } else if (60 < seconds <= 3600) {
	            return Math.floor(seconds / 60) + ":" + (seconds % 60) + "min";
	        } else if (3600 < seconds <= 216000) {
	            return Math.floor(seconds / 3600) + ":" + Math.floor((seconds % 3600) / 60) + ":" + ((seconds % 3600) % 60) + "h";
	        }
	    } else {
	        return mytwoTime - myoneTime;
	    }

	}
	 
		//根据讲师培训日期、身份证号、学时数组
		function lecturerHoursArrsReim(index,hours,timeStarts,lecturerNumbers){ 
			
			var rows = $('#dg_train_plan').datagrid('getRows');
			var arr = new Array();
			for (var i = 0; i < rows.length; i++) {
				var idAndName = {};
				var timeStart = '';
				var lessonTime = '';
				var lecturerNumber = '';
				if(i==index){
					timeStart = timeStarts;
					lessonTime = hours;
					lecturerNumber = lecturerNumbers;
					idAndName.id = lecturerNumber;
					idAndName.timeStart = timeStart;
					idAndName.hours = lessonTime;
				}else{
					timeStart = rows[i].timeStart;
					lessonTime = rows[i].lessonTime;
					lecturerNumber = rows[i].lecturerNumber;
					idAndName.id = lecturerNumber;
					idAndName.timeStart = timeStart;
					idAndName.hours = lessonTime;
				}
				arr.push(idAndName);
			}
			var b = [];//记录数组a中的id 相同的下标
	     for(var h = 0; h < arr.length;h++){
	         for(var j = arr.length-1;j>h;j--){
	             if(arr[h].id == arr[j].id && arr[h].timeStart == arr[j].timeStart){
	             	arr[h].hours = (parseFloat(arr[h].hours) + parseFloat(arr[j].hours)).toString();
	                 b.push(j);
	             }
	         }
	     }
	     for(var k = 0; k<b.length;k++){
	         arr.splice(b[k],1);
	     }
		var flag = true;
		for(var h = 0; h < arr.length;h++){
			if(arr[h].id == lecturerNumbers && arr[h].hours>8){
				flag = false;
			}
		}
	    	 return flag;
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