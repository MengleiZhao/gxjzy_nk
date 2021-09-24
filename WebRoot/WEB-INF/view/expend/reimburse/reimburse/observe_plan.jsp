<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-table">

	<table id="dg_observe_plan_reimb" class="easyui-datagrid" style="width:694px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#reco',
	<c:if test="${!empty receptionBeanEdit.jId}">
	url: '${base}/apply/observe?id=${receptionBeanEdit.jId}',
	</c:if>
	<c:if test="${empty receptionBeanEdit.jId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRowO,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'oId',hidden:true"></th>
				<th data-options="field:'observeTime',width:150,align:'center',editor:{type:'datetimebox',options:{showSeconds:false}},formatter:ChangeDateFormatIndex">时间</th>
				<th data-options="field:'fProject',width:200,align:'center',editor:'textbox'">项目</th>
				<th data-options="field:'personNum',width:150,align:'center',editor:'numberbox'">人数</th>
				<th data-options="field:'accompanyPerson',width:180,align:'center',editor:'textbox'">其中陪同人员</th>				
			</tr>
		</thead>
	</table>
	<c:if test="${empty detail}">
	<div id="reco" style="height:30px;padding-top : 8px">
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="removeitO()"  style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appendO()"  style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	</c:if>
</div>
<script type="text/javascript">
$.fn.datetimebox.defaults.parser = function(s){
	 var t = Date.parse(s);
	 if (!isNaN(t)){
	  return new Date(t);
	 } else {
	  return new Date();
	 }
	};
	
	$.fn.datebox.defaults.parser = function(s){
		 var t = Date.parse(s);
		 if (!isNaN(t)){
		  return new Date(t);
		 } else {
		  return new Date();
		 }
		};
//接待人员表格添加删除，保存方法
	var editIndexO = undefined;
	function endEditingO() {
		if (editIndexO == undefined) {
			return true
		}
		if ($('#dg_observe_plan_reimb').datagrid('validateRow', editIndexO)) {
			$('#dg_observe_plan_reimb').datagrid('endEdit', editIndexO);
			editIndexO = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRowO(index) {
			if (editIndexO != index) {
				if (endEditingO()) {
					$('#dg_observe_plan_reimb').datagrid('selectRow', index).datagrid('beginEdit',
							index);
					editIndexO = index;
				} else {
					$('#dg_observe_plan_reimb').datagrid('selectRow', editIndexO);
				}
		}
	}
	function appendO() {
		if (endEditingO()) {
			$('#dg_observe_plan_reimb').datagrid('appendRow', {});
			editIndexO = $('#dg_observe_plan_reimb').datagrid('getRows').length - 1;
			$('#dg_observe_plan_reimb').datagrid('selectRow', editIndexO).datagrid('beginEdit',editIndexO);
		}
	}
	function removeitO() {
		if (editIndexO == undefined) {
			return
		}
		$('#dg_observe_plan_reimb').datagrid('cancelEdit', editIndexO).datagrid('deleteRow',
				editIndexO);
		editIndexO = undefined;
	}
	function acceptO() {
		if (endEditingO()) {
			$('#dg_observe_plan_reimb').datagrid('acceptChanges');
		}
	}
	function observePlanJson(){
		acceptO();
		var rows2 = $('#dg_observe_plan_reimb').datagrid('getRows');
		var observePlanJson = "";
		if(rows2==''){
			return false;
		}else{
			for (var i = 0; i < rows2.length; i++) {
				observePlanJson = observePlanJson + JSON.stringify(rows2[i]) + ",";
			}
			$('#observePlanJson').val(observePlanJson);
			return true;
		}
	}
</script>