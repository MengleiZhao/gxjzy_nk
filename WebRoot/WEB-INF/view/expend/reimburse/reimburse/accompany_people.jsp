<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-table">
<c:if test="${empty detail}">
	<div id="recac" style="height:30px;padding-top : 8px">
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="removeitAc()"  style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appendAc()"  style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	</c:if>
	<table id="dg_accompany_people_reimb" class="easyui-datagrid" style="width:694px;height:auto"
	data-options="
	singleSelect: true,
	<c:if test="${!empty receptionBeanEdit.jId}">
	url: '${base}/apply/accompanyPeop?id=${receptionBeanEdit.jId}',
	</c:if>
	<c:if test="${empty receptionBeanEdit.jId}">
	url: '',
	</c:if>
	method: 'post',
	<c:if test="${empty detail}">
	onClickRow: onClickRowAc,
	</c:if>
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	">
		<thead>
			<tr>
				<th data-options="field:'acId',hidden:true"></th>
				<th data-options="field:'receptionPeopName',width:330,align:'center',editor:'textbox'">姓名</th>
				<th data-options="field:'position',width:335,align:'center',editor:'textbox'">职务</th>				
			</tr>
		</thead>
	</table>
	
</div>
<script type="text/javascript">
//接待人员表格添加删除，保存方法
	var editIndexAc = undefined;
	function endEditingAc() {
		if (editIndexAc == undefined) {
			return true;
		}
		if ($('#dg_accompany_people_reimb').datagrid('validateRow', editIndexAc)) {
			$('#dg_accompany_people_reimb').datagrid('endEdit', editIndexAc);
			editIndexAc = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRowAc(index) {
			if (editIndexAc != index) {
				if (endEditingAc()) {
					$('#dg_accompany_people_reimb').datagrid('selectRow', index).datagrid('beginEdit',
							index);
					editIndexAc = index;
				} else {
					$('#dg_accompany_people_reimb').datagrid('selectRow', editIndexAc);
				}
		}
	}
	function appendAc() {
		if (endEditingAc()) {
			$('#dg_accompany_people_reimb').datagrid('appendRow', {});
			editIndexAc = $('#dg_accompany_people_reimb').datagrid('getRows').length - 1;
			$('#dg_accompany_people_reimb').datagrid('selectRow', editIndexAc).datagrid('beginEdit',editIndexAc);
		}
	}
	function removeitAc() {
		if (editIndexAc == undefined) {
			return
		}
		$('#dg_accompany_people_reimb').datagrid('cancelEdit', editIndexAc).datagrid('deleteRow',
				editIndexAc);
		editIndexAc = undefined;
	}
	function acceptAc() {
		if (endEditingAc()) {
			$('#dg_accompany_people_reimb').datagrid('acceptChanges');
		}
	}
	function accompanyPeopJson(){
		acceptAc();
		var rows2 = $('#dg_accompany_people_reimb').datagrid('getRows');
		var accompanyPeopJson = "";
		if(rows2==''){
			return false;
		}else{
			for (var i = 0; i < rows2.length; i++) {
				accompanyPeopJson = accompanyPeopJson + JSON.stringify(rows2[i]) + ",";
			}
			$('#accompanyPeopJson').val(accompanyPeopJson);
			return true;
		}
	}
</script>