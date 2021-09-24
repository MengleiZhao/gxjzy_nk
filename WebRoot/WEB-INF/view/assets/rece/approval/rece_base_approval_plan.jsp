<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

   <table id="Rece_approval_add_plan" class="easyui-datagrid"  style="height:auto;"
		data-options="
			iconCls: 'icon-edit',
			singleSelect: true,
			toolbar: '#tb',
			url: '${base}/Rece/lowJsonPagination?fAssReceCode=${bean.fAssReceCode }',
			method: 'post',
			onClickCell: onClickCellPlan
		">
	<thead>
		<tr>
			<c:if test="${bean.fAssType=='ZCLX-01'}">
				<%@include file="rece_low_approval_edit_plan.jsp" %>
			</c:if>
			<c:if test="${bean.fAssType=='ZCLX-02'}">
				<%@include file="rece_fixed_approval_edit_plan.jsp" %>
			</c:if>
		</tr>
	</thead>
</table>
<c:if test="${openType=='add'||openType=='edit'}">
	<div id="tb" style="height:30px">
		<a href="javascript:void(0)" onclick="removePlan()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appendPlan()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
</c:if>

<script type="text/javascript">

	/* function PayStauts(val) {
		$('#Rece_approval_add_plan').datagrid('updateRow',{
			index: editIndex,
			row: {
				fAssName_RL: val.text,
				fMeasUnit_RL: val.SftjCode,
				fAssCode_RL: val.code
			}
		}); 
		if(val.text=='新增'){
			var win=creatFirstWin('新增资产品目',840,450,'icon-search','/AssetBasicInfo/lowAddOther');
			win.window('open');
		}
} */
	var editIndex = undefined;
	function endEditingPlan(){
		if (editIndex == undefined){return true}
		if ($('#Rece_approval_add_plan').datagrid('validateRow', editIndex)){
			$('#Rece_approval_add_plan').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickCellPlan(index, field){
		if (editIndex != index){
			if (endEditingPlan()){
				$('#Rece_approval_add_plan').datagrid('selectRow', index)
						.datagrid('beginEdit', index);
				var ed = $('#Rece_approval_add_plan').datagrid('getEditor', {index:index,field:field});
				if (ed){
					($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
				}
				editIndex = index;
			} else {
				setTimeout(function(){
					$('#Rece_approval_add_plan').datagrid('selectRow', editIndex);
				},0);
			}
		}
	}
	function appendPlan(){
		if (endEditingPlan()){
			$('#Rece_approval_add_plan').datagrid('appendRow',{});
			editIndex = $('#Rece_approval_add_plan').datagrid('getRows').length-1;
			$('#Rece_approval_add_plan').datagrid('selectRow', editIndex)
					.datagrid('beginEdit', editIndex);
		}
		document.getElementById("Rece_approval_add_plan").scrollIntoView();
	}
	function removePlan(){
		if (editIndex == undefined){return };
		$('#Rece_approval_add_plan').datagrid('cancelEdit', editIndex)
				.datagrid('deleteRow', editIndex);
		editIndex = undefined;
	}
	function testPlan(){
		var entities= getPlan();
		 alert(entities);
	}
	function getPlan(){
		$('#Rece_approval_add_plan').datagrid('acceptChanges');
		var rows = $('#Rece_approval_add_plan').datagrid('getRows');
		var entities= '';
		for(i = 0;i < rows.length;i++){
		 entities = entities  + JSON.stringify(rows[i]) + ',';  
		}
		 entities = '[' + entities.substring(0,entities.length -1) + ']';
		 return entities;
	}
</script>