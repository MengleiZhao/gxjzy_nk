<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="dg_meet_plan" class="easyui-datagrid" 
	style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#dmp',
	<c:if test="${!empty bean.gId}">
	url: '${base}/apply/meetPlan?id=${bean.gId}',
	</c:if>
	<c:if test="${empty bean.gId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRowR,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'planId',hidden:true"></th>
				<th data-options="field:'times',width:195,align:'center',editor:{type:'datetimebox',options:{showSeconds:false,onHidePanel:changeTime1,editable: false}},formatter:ChangeDateFormat1">起始时间</th>
				<th data-options="field:'timee',width:195,align:'center',editor:{type:'datetimebox',options:{showSeconds:false,onHidePanel:changeTime2,editable: false}},formatter:ChangeDateFormat1">结束时间</th>
				<th data-options="field:'content',width:290,align:'center',editor:'textbox'">会议事项</th>
				<!-- <th data-options="field:'content',width:290,align:'center',editor:'number'">会期提示</th> -->
			</tr>
		</thead>
	</table>
	<c:if test="${empty detail}">
	<div id="dmp" style="height:30px;padding-top : 8px">
		<a href="javascript:void(0)" onclick="removeitR()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appendR()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	<a style="float: left; font-weight: bold;color: red;font-size:12px;">提示：会期不得超过1天</a>
	</c:if>
	<input type="hidden" id="meetPlanJson" name="meetPlan" />
</div>
<script type="text/javascript">
//接待人员表格添加删除，保存方法
	var editIndex1 = undefined;
	function endEditingR() {
		if (editIndex1 == undefined) {
			return true
		}
		if ($('#dg_meet_plan').datagrid('validateRow', editIndex1)) {
			var dmp = $('#dg_meet_plan').datagrid('getEditor', {
				index : editIndex1,
				field : 'costDetail'
			});
			$('#dg_meet_plan').datagrid('endEdit', editIndex1);
			editIndex1 = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRowR(index) {
		if (editIndex1 != index) {
			if (endEditingR()) {
				$('#dg_meet_plan').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex1 = index;
			} else {
				$('#dg_meet_plan').datagrid('selectRow', editIndex1);
			}
		}
	}
	function appendR() {
		if (endEditingR()) {
			$('#dg_meet_plan').datagrid('appendRow', {});
			editIndex1 = $('#dg_meet_plan').datagrid('getRows').length - 1;
			$('#dg_meet_plan').datagrid('selectRow', editIndex1).datagrid('beginEdit',editIndex1);
		}
	}
	function removeitR() {
		if (editIndex1 == undefined) {
			return
		}
		$('#dg_meet_plan').datagrid('cancelEdit', editIndex1).datagrid('deleteRow',
				editIndex1);
		editIndex1 = undefined;
	}
	function acceptR() {
		if (endEditingR()) {
			$('#dg_meet_plan').datagrid('acceptChanges');
		}
	}
	function changeTime1(){
		var index=$('#dg_meet_plan').datagrid('getRowIndex',$('#dg_meet_plan').datagrid('getSelected'));
		var editors = $('#dg_meet_plan').datagrid('getEditors', index);  
		var endEditor = editors[1];
		var startday = Date.parse(new Date(editors[0].target.val()));
		var maxTime = Date.parse(new Date($("#meetingDateEnd").datebox('getValue')))+ (16 * 60 * 60 * 1000);
	    var minTime = Date.parse(new Date($("#meetingDateStart").datebox('getValue')))- (8 * 60 * 60 * 1000);
	    var meetType = $('#meetingType').combobox('getValue');
	   /*  if(meetType==1){
	    	var minTime1=
	    } */
		var endday = Date.parse(new Date(endEditor.target.val()));
		if(!isNaN(startday)){
	    	if((startday>=minTime &&startday<=maxTime) ){
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
	}
	
	
	function changeTime2(){
		var index=$('#dg_meet_plan').datagrid('getRowIndex',$('#dg_meet_plan').datagrid('getSelected'));
		var editors = $('#dg_meet_plan').datagrid('getEditors', index);  
		var endEditor = editors[1]; 
		var startday = Date.parse(new Date(editors[0].target.val()));
		var maxTime = Date.parse(new Date($("#meetingDateEnd").datebox('getValue')))+ (16 * 60 * 60 * 1000);
	    var minTime = Date.parse(new Date($("#meetingDateStart").datebox('getValue')))- (8 * 60 * 60 * 1000);
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
</script>