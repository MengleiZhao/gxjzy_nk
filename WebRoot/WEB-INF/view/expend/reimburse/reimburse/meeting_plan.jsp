<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab">
	<table id="dg_meet_plan" class="easyui-datagrid" 
	style="width:655px;height:auto"
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
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'planId',hidden:true"></th>
				<th data-options="field:'times',width:180,align:'center',editor:{type:'datetimebox',options:{}},formatter:ChangeDateFormatIndex">起始时间</th>
				<th data-options="field:'timee',width:180,align:'center',editor:{type:'datetimebox',options:{}},formatter:ChangeDateFormatIndex">结束时间</th>
				<th data-options="field:'content',width:255,align:'center',editor:'textbox'">事项安排</th>
			</tr>
		</thead>
	</table>
	<input type="hidden" id="meetPlanJson" name="meetPlan" />
</div>
	
	
<script type="text/javascript">

//接待人员表格添加删除，保存方法
var editIndex = undefined;
function endEditingR() {
	if (editIndex == undefined) {
		return true
	}
	if ($('#dg_meet_plan').datagrid('validateRow', editIndex)) {
		var dmp = $('#dg_meet_plan').datagrid('getEditor', {
			index : editIndex,
			field : 'costDetail'
		});
		$('#dg_meet_plan').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRowR(index) {
	if (editIndex != index) {
		if (endEditingR()) {
			$('#dg_meet_plan').datagrid('selectRow', index).datagrid('beginEdit',
					index);
			editIndex = index;
		} else {
			$('#dg_meet_plan').datagrid('selectRow', editIndex);
		}
	}
}
function appendR() {
	if (endEditingR()) {
		$('#dg_meet_plan').datagrid('appendRow', {});
		editIndex = $('#dg_meet_plan').datagrid('getRows').length - 1;
		$('#dg_meet_plan').datagrid('selectRow', editIndex).datagrid('beginEdit',editIndex);
	}
}
function removeitR() {
	if (editIndex == undefined) {
		return
	}
	$('#dg_meet_plan').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
			editIndex);
	editIndex = undefined;
}
function acceptR() {
	if (endEditingR()) {
		$('#dg_meet_plan').datagrid('acceptChanges');
	}
}
	
	
/* 	//重新计算开支标准
	function countkzbz() {
		accept();
		//获得接待人数（有几行就是接待多少人）
		var rownum = $('#dg_meet_plan').datagrid('getRows').length;
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
</script>