<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">

	<table id="cart" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#rph',
	<c:if test="${!empty bean.gId}">
	url: '${base}/apply/officeCar?id=${bean.gId}',
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
				<th data-options="field:'focID',hidden:true"></th>
				<th data-options="field:'fExpenseName',width:150,align:'center',editor:{type: 'combobox',options: {valueField:'id',textField:'text',data:[
	                	{id:'燃料费',text:'燃料费'},
	                	{id:'维修费',text:'维修费'},
	                	{id:'过路过桥费',text:'过路过桥费'},
	                	{id:'保险费',text:'保险费'},
	                	{id:'其他',text:'其他'}],
	                	prompt:'-请选择-',panelHeight:'atuo',editable: false,onSelect: function (rec) {
                    //获取选中的值
                    
                    var varSelect = $(this).combobox('getText');
					var index = $('#cart').datagrid('getRowIndex',$('#cart').datagrid('getSelected'));
                    if (rec.text == '燃料费') {
                        //获取第二个combobox所在的datagrid Editor
                        var varEditor = $('#cart').datagrid('getEditor', { index: index, field: 'fUseType' });
                        $(varEditor.target).combobox({
				            data: [{id:'公共费用',text:'公共费用'},
	                	{id:'单车费用',text:'单车费用'}],
				            valueField: 'id',
				            textField: 'text',
						});

                    }else {
                        //获取第二个combobox所在的datagrid Editor
                        var varEditor = $('#cart').datagrid('getEditor', { index: index, field: 'fUseType' });
                         $(varEditor.target).combobox({
				            data: [{id:'单车费用',text:'单车费用'}],
				            valueField: 'id',
				            textField: 'text',
						});
                    }
                }
	                	}}">费用名称</th>
				<th data-options="field:'fUseType',width:100,align:'center',editor:{type: 'combobox',options: {valueField:'id',textField:'text',data:[
	                	{id:'公共费用',text:'公共费用'},
	                	{id:'单车费用',text:'单车费用'}],
	                	prompt:'-请选择-',panelHeight:'atuo',editable: false,onChange:onChangeType}}">费用类型</th>
				<th data-options="field:'fCarNum',width:83,align:'center',editor:'textbox'">车牌号</th>
				<th data-options="field:'fCarType',width:100,align:'center',editor:'textbox'">车辆型号</th>
				<th data-options="field:'fUseAmount',width:100,align:'center',editor:{type:'numberbox',options:{onChange:addAmount,precision:2,groupSeparator:','}}">申请费用(元)</th>
				<th data-options="field:'fRemark',width:150,align:'center',editor:'textbox'">备注</th>
			</tr>
		</thead>
	</table>
	<c:if test="${empty detail}">
	<div id="rph" style="height:30px;padding-top : 8px">
		<a href="javascript:void(0)" onclick="removeitR()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appendR()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	</c:if>
</div>
<script type="text/javascript">

//接待人员表格添加删除，保存方法
	var editIndex = undefined;
	function endEditingR() {
		if (editIndex == undefined) {
			return true
		}
		if ($('#cart').datagrid('validateRow', editIndex)) {
			//下面三行，是在增加一行的时候，防止原来的一行的值变成code
			$('#cart').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRowR(index) {
		if (editIndex != index) {
			if (endEditingR()) {
				$('#cart').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex = index;
			} else {
				$('#cart').datagrid('selectRow', editIndex);
			}
		}
	}
	function appendR() {
		if (endEditingR()) {
			$('#cart').datagrid('appendRow', {});
			editIndex = $('#cart').datagrid('getRows').length - 1;
			$('#cart').datagrid('selectRow', editIndex).datagrid('beginEdit',editIndex);
		}
	}
	function removeitR() {
		if (editIndex == undefined) {
			return
		}
		$('#cart').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
				editIndex);
		editIndex = undefined;
		 var rows = $('#cart').datagrid('getRows');
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
			$('#cart').datagrid('acceptChanges');
		}
	}
	
	
	
	function onChangeType(newValue,oldValue){
		var index=$('#cart').datagrid('getRowIndex',$('#cart').datagrid('getSelected'));
	    var ed1 = $('#cart').datagrid('getEditor',{
			index: index,
			field : 'fCarNum'  
		});
	    var ed2 = $('#cart').datagrid('getEditor',{
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