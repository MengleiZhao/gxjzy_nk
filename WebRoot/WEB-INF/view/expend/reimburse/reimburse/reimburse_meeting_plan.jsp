<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<c:if test="${empty detail}">
		<div id="dmp1"  style="display:none;height:30px;padding-top : 8px;">
			<a href="javascript:void(0)" onclick="removeitMeet()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
			<a style="float: right;">&nbsp;&nbsp;</a>
			<a href="javascript:void(0)" onclick="append_meet()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		</div>
	</c:if>
	<table id="dg_meet_plan_reimb" class="easyui-datagrid" 
	style="width:693px;height:auto"
	data-options="
	singleSelect: true,
	<c:if test="${operation=='add'}">
	url: '${base}/apply/meetPlan?id=${applyBean.gId}',
	</c:if>
	<c:if test="${operation!='add'}">
	url: '${base}/reimburse/meetPlan?id=${bean.rId}',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRowMeet,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
			<c:if test="${operation!='add'}">
				<th data-options="field:'planId',hidden:true"></th>
			</c:if>
				<th data-options="field:'times',width:195,align:'center',editor:{type:'datebox',options:{showSeconds:false,onHidePanel:changeTime3}},formatter:ChangeDateFormatIndex">起始时间</th>
				<th data-options="field:'timee',width:195,align:'center',editor:{type:'datebox',options:{showSeconds:false,onHidePanel:changeTime4}},formatter:ChangeDateFormatIndex">结束时间</th>
				<th data-options="field:'content',width:276,align:'center',editor:'textbox'">会议事项</th>
			</tr>
		</thead>
	</table>
	
	
</div>
	
	
<script type="text/javascript">
var fupdateStatus = $(':radio[name="fupdateStatus"]:checked').val();
if(fupdateStatus == 1){
	$("#dmp1").css("display","block");
}

//接待人员表格添加删除，保存方法
	var editIndexMeet = undefined;
	function endEditingMeet() {
		if (editIndexMeet == undefined) {
			return true
		}
		if ($('#dg_meet_plan_reimb').datagrid('validateRow', editIndexMeet)) {
			var dmp = $('#dg_meet_plan_reimb').datagrid('getEditor', {
				index : editIndexMeet,
				field : 'costDetail'
			});
			$('#dg_meet_plan_reimb').datagrid('endEdit', editIndexMeet);
			editIndexMeet = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRowMeet(index) {
		var clickType=$('#fupdateStatusid').val();
		if(clickType==0){
			return false;
		}else{
			if (editIndexMeet != index) {
				if (endEditingMeet()) {
					$('#dg_meet_plan_reimb').datagrid('selectRow', index).datagrid('beginEdit',
							index);
					editIndexMeet = index;
				} else {
					$('#dg_meet_plan_reimb').datagrid('selectRow', editIndexMeet);
				}
			}
		}
	}
	function append_meet() {
		if (endEditingMeet()) {
			$('#dg_meet_plan_reimb').datagrid('appendRow', {});
			editIndexMeet = $('#dg_meet_plan_reimb').datagrid('getRows').length - 1;
			$('#dg_meet_plan_reimb').datagrid('selectRow', editIndexMeet).datagrid('beginEdit',editIndexMeet);
		}
	}
	function removeitMeet() {
		if (editIndexMeet == undefined) {
			return
		}
		$('#dg_meet_plan_reimb').datagrid('cancelEdit', editIndexMeet).datagrid('deleteRow',
				editIndexMeet);
		editIndexMeet = undefined;
	}
	function acceptMeet() {
		if (endEditingMeet()) {
			$('#dg_meet_plan_reimb').datagrid('acceptChanges');
		}
	}
	
	
/* 	//重新计算开支标准
	function countkzbz() {
		accept();
		//获得接待人数（有几行就是接待多少人）
		var rownum = $('#dg_meet_plan_reimb').datagrid('getRows').length;
		//修改明细表中的开支标准
		var rows = $('#appli-detail-dg').datagrid('getRows');
		for(var i=0;i<rows.length;i++) {
			var tr = $('#appli-detail-dg').datagrid('getEditors', i);
			//获得每一行的开支标准
			var kzbz=rows[i].standard;
			//设置开支标准
			onClickRow(i);
			tr[1].target.textbox('setValue', parseFloat(kzbz*rownum));
			accept();
		}
	} */
	function changeTime3(){
		var index=$('#dg_meet_plan_reimb').datagrid('getRowIndex',$('#dg_meet_plan_reimb').datagrid('getSelected'));
		var editors = $('#dg_meet_plan_reimb').datagrid('getEditors', index);  
		var endEditor = editors[1]; 
		var startday = Date.parse(new Date(editors[0].target.val()));
		var maxTime = Date.parse(new Date($("#meetingDateEnd").datebox('getValue')));
	    var minTime = Date.parse(new Date($("#meetingDateStart").datebox('getValue')));
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
	
	
	function changeTime4(){
		var index=$('#dg_meet_plan_reimb').datagrid('getRowIndex',$('#dg_meet_plan_reimb').datagrid('getSelected'));
		var editors = $('#dg_meet_plan_reimb').datagrid('getEditors', index);  
		var endEditor = editors[1]; 
		var startday = Date.parse(new Date(editors[0].target.val()));
		var maxTime = Date.parse(new Date($("#meetingDateEnd").datebox('getValue')));
	    var minTime = Date.parse(new Date($("#meetingDateStart").datebox('getValue')));
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