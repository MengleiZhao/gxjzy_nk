<%@ page language="java" pageEncoding="UTF-8"%>


   <table id="fixed_add_plan" class="easyui-datagrid"  style="height:auto;"
		data-options="
			iconCls: 'icon-edit',
			singleSelect: true,
			rownumbers:true,
			toolbar: '#tb',
			<c:if test="${fpCode!=null}">url: '${base}/Storage/cgpmJsonPagination?fpCode=${fpCode }&fAssType=${bean.fAssType }',</c:if>
			<c:if test="${fpCode==null}">url: '${base}/Storage/lowJsonPagination?fAssStorageCode=${bean.fAssStorageCode }',</c:if>
			method: 'post',
			<c:if test="${openType=='add'||openType=='edit'}">onClickCell: onClickCellPlan</c:if>
		">
	<thead>
		<tr>
			<th data-options="field:'fSysCodeR',align:'center',<c:if test="${empty fpCode}">editor:'textbox'</c:if>" style="width: 20%">资产编号</th>
			<th data-options="field:'fAssCodeR',align:'center',<c:if test="${empty fpCode}">editor:'textbox'</c:if>" style="width: 20%">资产名称系统编号</th>
			<th data-options="field:'fFinancialCodeR',align:'center',<c:if test="${empty fpCode}">editor:'textbox'</c:if>" style="width: 15%">国资分类号</th>
			<th data-options="field:'fAssNameR',align:'center',<c:if test="${empty fpCode}">editor:'textbox',</c:if>" style="width: 15%">资产名称</th>
			<th data-options="field:'fmMode',align:'center'<c:if test="${empty fpCode}">,editor:'text'</c:if>" style="width: 15%">型号</th>
			<th data-options="field:'fmSpecif',align:'center'<c:if test="${empty fpCode}">,editor:'text'</c:if>" style="width: 15%">规格</th>
			<th data-options="field:'fMeasUnitR',align:'center'<c:if test="${empty fpCode}">,editor:'textbox'</c:if>" style="width: 10%">单位</th>
			<th data-options="field:'fInsNumR',align:'center'<c:if test="${empty fpCode}">,editor:{type:'numberbox',options:{onChange:acountNum,precision:2}}</c:if>" style="width: 10%">数量</th>
			<th data-options="field:'fSignPrice',align:'right'<c:if test="${empty fpCode}">,editor:{type:'numberbox',options:{onChange:acountNum,precision:2}}</c:if>" style="width: 15%">单价(元)</th>
			<th data-options="field:'fAmount',align:'right'<c:if test="${empty fpCode}">,editor:{type:'numberbox',options:{onChange:sumAcount,precision:2}}</c:if>" style="width: 15%">总金额(元)</th>
			<th data-options="field:'fActionDate',align:'center'<c:if test="${empty fpCode}">,editor:{type:'datebox',options:{editable: false}},formatter:ChangeDateFormat</c:if>" style="width: 20%">资产验收日期</th>
			<th data-options="field:'fRemarkR',align:'left'<c:if test="${empty fpCode}">,editor:{type:'textbox'}</c:if>" style="width: 15%">备注</th>
		</tr>
	</thead>
</table>
<c:if test="${openType=='add'||openType=='edit'}">
<div id="tb" style="height:30px;">
	<a href="javascript:void(0)" onclick="removePlan()" style="float: right;">
		<img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
	</a>
	<a style="float: right;">&nbsp;&nbsp;</a>
	<a href="javascript:void(0)" id="addFixedButton" onclick="appendPlan()" style="float: right;">
		<img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
	</a>
	<a style="float: right;">&nbsp;&nbsp;</a>
	<%-- <a href="#" onclick="storage_fixed_imput()" style="float: right;">
		<img src="${base}/resource-modality/${themenurl}/button/daoru1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
	</a> --%>
</div>
</c:if>
<script type="text/javascript">

//导入
function storage_fixed_imput(){
	var win = creatFirstWin('导入明细', 500 ,300, 'icon-search',"/Storage/imput");
	win.window('open');
}

//填写总值的数据
function acountNum(newValue,oldValue){
	var row = $('#fixed_add_plan').datagrid('getSelected');//获得选择行
	var index=$('#fixed_add_plan').datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $('#fixed_add_plan').datagrid('getEditors', index);//获取选中行的数据
	var num = tr[7].target.numberbox('getValue');//获得数量
	var price = tr[8].target.numberbox('getValue');//获得单价
	tr[9].target.numberbox('setValue',num*price);//设置给后面一个
	/* var sumAmounct = $('#S_fSumAmount').numberbox('getValue');//获得合计金额
	if(null==sumAmounct||sumAmounct==''){
		sumAmounct=0.00;
	}
	sumAmounct = parseFloat(sumAmounct)+(num*price);//parseFloat
	//$('#S_fSumAmount').numberbox('setValue',sumAmounct);//设置到合计金额 */

	
}
//总值校验是否正确
function sumAcount(newValue,oldValue){
	var row = $('#fixed_add_plan').datagrid('getSelected');//获得选择行
	var index=$('#fixed_add_plan').datagrid('getRowIndex',row);//获得选中行的行号
	var tr = $('#fixed_add_plan').datagrid('getEditors', index);//获取选中行的数据
	var num = tr[7].target.numberbox('getValue');//获得数量
	var price = tr[8].target.numberbox('getValue');//获得单价
	if((num*price)!=newValue){
		tr[9].target.numberbox('setValue',num*price);//设置值一个正确的值给总值
	}
	
	//设置总额
	var rows = $('#fixed_add_plan').datagrid('getRows');//获得选择行
	var num1 = 0;
	for (var i = 0; i < rows.length; i++) {
	  if (!isNaN(parseFloat(rows[i]['fAmount']))) {
	  	num1 += parseFloat(rows[i]['fAmount']);
	  }
	}
	var num = parseFloat(newValue);
	var numOld = parseFloat(row.fAmount);
	if (!isNaN(num)) {
		if (!isNaN(numOld) && isNaN(parseFloat(oldValue))) {
			return;
		} else {
			if (!isNaN(numOld)) {
				num1 = num1 + num - numOld;
			} else {
				num1 = num1 + num;
			}
		}
	}
	$('#S_fSumAmount').numberbox('setValue', num1);
}
	function PayStauts(val) {
		$('#fixed_add_plan').datagrid('updateRow', {
			index : editIndex,
			row : {
				fAssName_R : val.text,
				fMeasUnit_R : val.SftjCode,
				fAssCode_R : val.code
			}
		});
		if (val.text == '新增') {
			var win = creatFirstWin('新增资产品目', 970, 580, 'icon-search',
					'/AssetBasicInfo/lowAddOther');
			win.window('open');
		}
	}
	var editIndex = undefined;
	function endEditingPlan() {
		if (editIndex == undefined) {
			return true
		}
		if ($('#fixed_add_plan').datagrid('validateRow', editIndex)) {
			$('#fixed_add_plan').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickCellPlan(index, field) {
		if (editIndex != index) {
			if (endEditingPlan()) {
				$('#fixed_add_plan').datagrid('selectRow', index).datagrid(
						'beginEdit', index);
				var ed = $('#fixed_add_plan').datagrid('getEditor', {
					index : index,
					field : field
				});
				if (ed) {
					($(ed.target).data('textbox') ? $(ed.target).textbox(
							'textbox') : $(ed.target)).focus();
				}
				editIndex = index;
			} else {
				setTimeout(function() {
					$('#fixed_add_plan').datagrid('selectRow', editIndex);
				}, 0);
			}
		}
	}
	function appendPlan() {
		if (endEditingPlan()) {
			$('#fixed_add_plan').datagrid('appendRow', {});
			editIndex = $('#fixed_add_plan').datagrid('getRows').length - 1;
			$('#fixed_add_plan').datagrid('selectRow', editIndex).datagrid(
					'beginEdit', editIndex);
			document.getElementById("fixed_add_plan").scrollIntoView();
		}
	}
	function removePlan() {
		if (editIndex == undefined) {
			return
		}
		;
		$('#fixed_add_plan').datagrid('cancelEdit', editIndex).datagrid(
				'deleteRow', editIndex);
		editIndex = undefined;
	}
	function testPlan() {
		var entities = getPlan();
		alert(entities);
	}
	function getPlan() {
		$('#fixed_add_plan').datagrid('acceptChanges');
		var rows = $('#fixed_add_plan').datagrid('getRows');
		var entities = '';
		for (i = 0; i < rows.length; i++) {
			entities = entities + JSON.stringify(rows[i]) + ',';
		}
		entities = '[' + entities.substring(0, entities.length - 1) + ']';
		return entities;
	}
</script>