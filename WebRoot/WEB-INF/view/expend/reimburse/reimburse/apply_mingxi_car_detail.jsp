<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px;width:693px;">

	<table id="apply_cart" class="easyui-datagrid" style="width:693px;height:auto"
	data-options="
	singleSelect: true,
	<c:if test="${!empty applyBean.gId}">
	url: '${base}/apply/officeCar?id=${applyBean.gId}',
	</c:if>
	<c:if test="${empty applyBean.gId}">
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
				<th data-options="field:'focID',hidden:true"></th>
				<th data-options="field:'fExpenseName',width:150,align:'center'">费用名称</th>
				<th data-options="field:'fUseType',width:100,align:'center'">费用类型</th>
				<th data-options="field:'fCarNum',width:83,align:'center',editor:'textbox'">车牌号</th>
				<th data-options="field:'fCarType',width:95,align:'center',editor:'textbox'">车辆型号</th>
				<th data-options="field:'fUseAmount',width:90,align:'center',editor:{type:'numberbox'}">申请费用(元)</th>
				<th data-options="field:'fRemark',width:150,align:'center',editor:'textbox'">备注</th>
			</tr>
		</thead>
	</table>
</div>
<script type="text/javascript">

//接待人员表格添加删除，保存方法
	var editIndex = undefined;
	function endEditingR() {
		if (editIndex == undefined) {
			return true
		}
		if ($('#apply_cart').datagrid('validateRow', editIndex)) {
			//下面三行，是在增加一行的时候，防止原来的一行的值变成code
			$('#apply_cart').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRowR(index) {
		if (editIndex != index) {
			if (endEditingR()) {
				$('#apply_cart').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex = index;
			} else {
				$('#apply_cart').datagrid('selectRow', editIndex);
			}
		}
	}
	function appendR() {
		if (endEditingR()) {
			$('#apply_cart').datagrid('appendRow', {});
			editIndex = $('#apply_cart').datagrid('getRows').length - 1;
			$('#apply_cart').datagrid('selectRow', editIndex).datagrid('beginEdit',editIndex);
		}
	}
	function removeitR() {
		if (editIndex == undefined) {
			return
		}
		$('#apply_cart').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
				editIndex);
		editIndex = undefined;
		 var rows = $('#apply_cart').datagrid('getRows');
		var num=0;
		for(var i=0;i<rows.length;i++){
			if(rows[i].fUseAmount!=""&&rows[i].fUseAmount!=null){
				num += parseFloat(rows[i].fUseAmount);
			}
		}
		$('#applyAmount').val(num.toFixed(2));
		$('#applyAmount_span').html(fomatMoney(num,2)+" [元]");
	}
	function acceptR() {
		if (endEditingR()) {
			$('#apply_cart').datagrid('acceptChanges');
		}
	}
	
	
	
	function onChangeType(newValue,oldValue){
		var index=$('#apply_cart').datagrid('getRowIndex',$('#apply_cart').datagrid('getSelected'));
	    var ed1 = $('#apply_cart').datagrid('getEditor',{
			index: index,
			field : 'fCarNum'  
		});
	    var ed2 = $('#apply_cart').datagrid('getEditor',{
			index: index,
			field : 'fCarType'  
		});
	    if(newValue=="公共费用"){
	    	   $(ed1.target).combobox('disable');
	    	   $(ed2.target).combobox('disable');
	    }else{
	    	$(ed2.target).combobox('enable');
	    	   $(ed1.target).combobox('enable');
	    }
	}

</script>