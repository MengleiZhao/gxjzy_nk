<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="window-tab" style="margin-left: 0px;padding-top: 10px">

	<table id="reimburse_cart" class="easyui-datagrid" style="width:707px;height:auto"
	data-options="
	singleSelect: true,
	toolbar: '#reimburse_rph',
	url: '${base}/reimburse/applyCarPage?rId=${bean.rId}',
	method: 'post',
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
	                	prompt:'-请选择-',panelHeight:'atuo',editable: false,onHidePanel:expenseNameSelect
	                	}}">费用名称</th>
				<th data-options="field:'fUseType',width:100,align:'center',editor:{type: 'combobox',options: {valueField:'id',textField:'text',data:[
	                	{id:'公共费用',text:'公共费用'},
	                	{id:'单车费用',text:'单车费用'}],
	                	prompt:'-请选择-',panelHeight:'atuo',editable: false,onChange:editAttr}}">费用类型</th>
				<th data-options="field:'fCarNum',width:83,align:'center',editor:'textbox'">车牌号</th>
				<th data-options="field:'fCarType',width:100,align:'center',editor:'textbox'">车辆型号</th>
				<th data-options="field:'fUseAmount',width:100,align:'center',editor:{type:'numberbox',options:{onChange:addCarAmount,iconCls:'icon-yuan'}}">报销金额</th>
				<th data-options="field:'fRemark',width:150,align:'center',editor:'textbox'">备注</th>
			</tr>
		</thead>
	</table>
	<c:if test="${empty detail}">
	<div id="reimburse_rph" style="height:30px;padding-top : 8px">
	<a style="float: left;">&nbsp;&nbsp;</a>
		<a style="float: left;color: #666666;font-size:12px;">原申请金额：<span ><fmt:formatNumber groupingUsed="true" value="${applyBean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		<a style="float: left;">&nbsp;&nbsp;</a>
		<c:if test="${operation=='add'}">	
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="rOutsideTrafficAmount"><fmt:formatNumber groupingUsed="true" value="${applyBean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		</c:if>
		<c:if test="${operation=='edit'}">	
		<a style="float: left;color: #666666;font-size:12px;">报销金额：<span id="rOutsideTrafficAmount"><fmt:formatNumber groupingUsed="true" value="${bean.amount}" minFractionDigits="2" maxFractionDigits="2"/>[元]</span></a>
		</c:if>
		<a href="javascript:void(0)" onclick="removeitCar()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appendCar()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	</c:if>
</div>
<script type="text/javascript">

//接待人员表格添加删除，保存方法
	var editIndex = undefined;
	function endEditingCar() {
		if (editIndex == undefined) {
			return true;
		}
		if ($('#reimburse_cart').datagrid('validateRow', editIndex)) {
			//下面三行，是在增加一行的时候，防止原来的一行的值变成code
			$('#reimburse_cart').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRowCar(index) {
		if (editIndex != index) {
			if (endEditingCar()) {
				$('#reimburse_cart').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex = index;
			} else {
				$('#reimburse_cart').datagrid('selectRow', editIndex);
			}
		}
	}
	function appendCar() {
		
		if (endEditingCar()) {
			$('#reimburse_cart').datagrid('appendRow', {});
			editIndex = $('#reimburse_cart').datagrid('getRows').length - 1;
			$('#reimburse_cart').datagrid('selectRow', editIndex).datagrid('beginEdit',editIndex);
		}
	}
	function removeitCar() {
		if (editIndex == undefined) {
			return
		}
		$('#reimburse_cart').datagrid('cancelEdit', editIndex).datagrid('deleteRow',
				editIndex);
		editIndex = undefined;
		 var rows = $('#reimburse_cart').datagrid('getRows');
		var num=0;
		for(var i=0;i<rows.length;i++){
			if(rows[i].fUseAmount!=""&&rows[i].fUseAmount!=null){
				num += parseFloat(rows[i].fUseAmount);
			}
		}
		$('#applyAmount').val(num.toFixed(2));
		$('#applyAmount_span').html(fomatMoney(num,2)+" [元]");
	}
	function acceptCar() {
		if (endEditingCar()) {
			$('#reimburse_cart').datagrid('acceptChanges');
		}
	}
	
	
	
	function editAttr(newValue,oldValue){
		var index=$('#reimburse_cart').datagrid('getRowIndex',$('#reimburse_cart').datagrid('getSelected'));
	    var ed1 = $('#reimburse_cart').datagrid('getEditor',{
			index: index,
			field : 'fCarNum'  
		});
	    var ed2 = $('#reimburse_cart').datagrid('getEditor',{
			index: index,
			field : 'fCarType'  
		});
	    if(newValue=="公共费用"){
	    	   $(ed1.target).textbox('setValue','');
	    	   $(ed2.target).textbox('setValue','');
	    	   $(ed1.target).textbox('disable');
	    	   $(ed2.target).textbox('disable');
	    }else{
	    	$(ed2.target).textbox('enable');
	    	   $(ed1.target).textbox('enable');
	    }
	}
	function addCarAmount(newVal,oldVal){
		if(newVal==undefined || oldVal==undefined){
			return false;
		}
		var rows = $('#reimburse_cart').datagrid('getRows');
		var index=$('#reimburse_cart').datagrid('getRowIndex',$('#reimburse_cart').datagrid('getSelected'));
	    var num1 = 0;
	    for(var i=0;i<rows.length;i++){
			if(i==index){
				num1+=parseFloat(newVal);
			}else{
				num1+=addNumsCar(rows,i);
			}
		}
		$("#rOutsideTrafficAmount").html(num1+"[元]");
		$("#p_amount").html(num1+"[元]");
		$("#reimburseAmount").val(num1);
	}
	function addNumsCar(rows,index){
		var num=0;
		if(rows[index].fUseAmount!=''&&rows[index].fUseAmount!='NaN'&&rows[index].fUseAmount!=undefined){
			num = parseFloat(rows[index].fUseAmount);
		}else{
			num =0;
		}
		return num;
	}
	
function expenseNameSelect(){
	var index = $('#reimburse_cart').datagrid('getRowIndex',$('#reimburse_cart').datagrid('getSelected'));
	
	
	var fExpenseName = $('#reimburse_cart').datagrid('getEditor',{
		index:index,
		field:'fExpenseName'
	});
	
	if (fExpenseName.target.combobox('getValues') == '燃料费') {
		var varEditor = $('#reimburse_cart').datagrid('getEditor', { index: index, field: 'fUseType' });
        $(varEditor.target).combobox({
            data: [{id:'公共费用',text:'公共费用'},
    	{id:'单车费用',text:'单车费用'}],
            valueField: 'id',
            textField: 'text',
		});
	}else{
		var varEditor = $('#reimburse_cart').datagrid('getEditor', { index: index, field: 'fUseType' });
        $(varEditor.target).combobox({
           data: [{id:'单车费用',text:'单车费用'}],
           valueField: 'id',
           textField: 'text',
		});
	}
}	


function reimburseCartJson(){
	acceptCar();
	var rows2 = $('#reimburse_cart').datagrid('getRows');
	var reimburseCart = "";
	if(rows2==''){
	}else{
		for (var i = 0; i < rows2.length; i++) {
			reimburseCart = reimburseCart + JSON.stringify(rows2[i]) + ",";
		}
		$('#reimburseCartJson').val(reimburseCart);
	}
}
</script>