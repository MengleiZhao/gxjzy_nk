<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-tab" style="margin-left: 0px;padding-top: 10px">
	<table id="appropriation_info_dg" class="easyui-datagrid" style="width:670px;height:auto"
	data-options="
	singleSelect: true,
	<c:if test="${operation!='add'}">
	url: '${base}/accountsRegister/registerMX?id=${bean.aId}&type=3',
	</c:if>
	method: 'post',
	striped : true,
	nowrap : false,
	rownumbers:true,
	scrollbarSize:0,
	<c:if test="${operation=='add'}">
	onBeforeLoad:getExpenseData,
	</c:if>
	<c:if test="${operation=='add'|| operation=='edit'}">
	onClickRow:applyAmountEdit,
	</c:if>
	">
		<thead>
			<tr>
				<th data-options="field:'oppositeUnit',width:177,align:'center',editor:{type:'textbox',options:{required:true}}">对方单位名称</th>
				<th data-options="field:'planMoney',width:150,align:'center',editor:{type:'numberbox',options:{editable:true,precision:2,required:true}}">金额（元）</th>
				<th data-options="field:'planTime',width:160,align:'center',editor:{type:'datebox',options:{required:true,editable: false}}">预计来款日期</th>
				<th data-options="field:'invoiceKindShow',width:150,align:'center',
					editor:{type:'combobox',options:{valueField:'id',textField:'text',data:[
	                	{id:'发票',text:'发票'},
	                	{id:'收据',text:'收据'},
	                	{id:'其他',text:'其他'}],
	                	prompt:'-请选择-',panelHeight:'atuo',editable: false,required:true}}">开票种类</th>
			</tr>
		</thead>
	</table>
	<input type="hidden" id="registerJson" name="registerJson" hidden="hidden"/>
</div>
<script type="text/javascript">
	var editIndexExpense = undefined;
	function endEditingExpense() {
		if (editIndexExpense == undefined) {
			return true;
		}
		
		if ($('#appropriation_info_dg').datagrid('validateRow', editIndexExpense)) {
			$('#appropriation_info_dg').datagrid('endEdit', editIndexExpense);
			editIndexExpense = undefined;
			return true;
		} else {
			return false;
		}
	}

	function getExpenseData(){
		$('#appropriation_info_dg').datagrid('insertRow',{
		    index: 0,
		    row: {
		    	oppositeUnit: '',
		    	planMoney: '',
		    	planTime: '',
		    	invoiceKindShow: '',
		    	fType:3
		    }
		});
	}
	
	function applyAmountEdit(index, field, value){
   		if (editIndexExpense != index) {
   			if (endEditingExpense()) {
   				$('#appropriation_info_dg').datagrid('beginEdit', index);
   				editIndexExpense = index;
   			} else {
   				$('#appropriation_info_dg').datagrid('selectRow', editIndexExpense);
   			}
   		}
	}
	
	function acceptExpense() {
		if (endEditingExpense()) {
			$('#appropriation_info_dg').datagrid('acceptChanges');
		}
	}
	
	function outAmounts(newVal,oldVal){
		if(newVal==undefined || oldVal==undefined){
			return false;
		}
		if(newVal==''){
			newVal=0.00;
		}
		
		var rows = $('#appropriation_info_dg').datagrid('getRows');
		var index = $('#appropriation_info_dg').datagrid('getRowIndex',$('#appropriation_info_dg').datagrid('getSelected'));
		var num1 = 0;
		for(var i=0;i<rows.length;i++){
			if(i==index){
				num1+=parseFloat(newVal);
			}else{
				num1+=addNumsOut(rows,i);
			}
		}
		$("#applyAmountAbroad").html(num1.toFixed(2) + "元");
		$('#applyAmount').val(num1.toFixed(2));
	}
	
	function addNumsOut(rows,index){
		var num=0;
		if(rows[index].applyAmount!=''&&rows[index].applyAmount!='NaN'&&rows[index].applyAmount!=undefined){
			num = parseFloat(rows[index].applyAmount);
		}else{
			num =0;
		}
		return num;
	}
	
function appropriationJson(){
	acceptExpense();
	var rows2 = $('#appropriation_info_dg').datagrid('getRows');
	var registerJson = "";
	if(rows2==''){
		return false;
	}else{
		for (var i = 0; i < rows2.length; i++){
			if(rows2[i].oppositeUnit=='' || rows2[i].planMoney=='' || rows2[i].planTime=='' || rows2[i].invoiceKindShow==''){
				return false;
			}
		}
		for (var i = 0; i < rows2.length; i++){
			registerJson = registerJson + JSON.stringify(rows2[i]) + ",";
		}
		$('#registerJson').val(registerJson);
		return true;
	}
}
</script>