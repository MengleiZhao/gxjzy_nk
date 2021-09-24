<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-table" style="margin-top: 10px;">
    <table id="change-plan-dg" class="easyui-datagrid" style="width:695px;height:auto;"
	data-options="
		singleSelect: true,
		toolbar: '#tb',
		<c:if test="${!empty Upt.fId_U}">
		url: '${base}/Change/uptPlanJson?fId_U=${Upt.fId_U}',
		</c:if>
		<c:if test="${empty Upt.fId_U}">
		url: '${base}/Change/finderReceivPlan?FcId=${bean.fcId}',
		</c:if>
		method: 'post',
		onClickCell: onClickCelluptPlan,
		scrollbarSize:0,
		rownumbers:true,
	">
		<thead>
			<tr>
				<th data-options="field:'fReceProperty',align:'center',
						editor:{
							editable:false,
							type:'combotree',
							options:{
								required:true,
								valueField:'text',
								textField:'text',
								validType:'selectValid',
								method:'post',
								url:'${base}/Expiration/lookupsJson?parentCode=FKXZ',
							}
						}"style="width: 25%">付款性质</th>
				<th data-options="field:'fRecePlanTime',align:'center',formatter: ChangeDateFormat,editor:{editable:false,type:'datebox',options:{required:true,precision:1}}"style="width: 25%">预计付款时间</th>
				<th data-options="field:'fRecePlanAmount',align:'center',editor:{type:'numberbox',options:{required:true,precision:2,onChange:setFsumMoney}}"style="width: 25%">预计付款金额(元)</th>
				<th data-options="field:'fReceCondition',editor:{type:'textbox',options:{required:true}},validType:'length[1,50]',align:'center'"style="width: 25%">付款条件</th>
			</tr>
		</thead>
	</table>
	<div id="tb" style="height:30px">
		<span style="margin-left:8px;color: red;">总额:</span>&nbsp;&nbsp;<input class="easyui-numberbox" readonly="readonly" id="totalUptAmountshow" data-options="icons: [{iconCls:'icon-yuan'}],precision:2"  style="margin-left:20px;color: red;width:200px;">
		<input hidden="hidden" id="totalUptAmount"/>
		<a href="javascript:void(0)" onclick="removeituptPlan()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appenduptPlan()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
</div>
<script type="text/javascript">
//完成后计算总额并设置
$('#change-plan-dg').datagrid({
	onLoadSuccess : function(data){
		var rows = data.rows;
		var amount = 0.00;
		for(var i = 0 ;i<rows.length; i++){
			amount = parseFloat(amount) + parseFloat(rows[i].fRecePlanAmount);
		}
		$('#totalUptAmount').val(amount);
		$('#F_fAmount').val(amount);
		$('#totalUptAmountshow').numberbox('setValue',amount);
	}
})
var editIndex = undefined;
function endEditinguptPlan(){
	if (editIndex == undefined){return true}
	if ($('#change-plan-dg').datagrid('validateRow', editIndex)){
		//下面三行，是在增加一行的时候，防止原来的一行的值变成code
		var tr = $('#change-plan-dg').datagrid('getEditors', editIndex);
		var text0=tr[0].target.combotree('getText');
		if(text0!='--请选择--'){
			tr[0].target.combotree('setValue',text0);
		}
		$('#change-plan-dg').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickCelluptPlan(index, field){
	if (editIndex != index){
		if (endEditinguptPlan()){
			var rows = $('#change-plan-dg').datagrid('getRows');
			$.ajax({
				url:'${base}/Change/verifyReceivPlan',
				dateType:'json',
				type:'POST',
				async:false,
				data:{'id':rows[index].fPlanId},
				success:function(data){
					data=eval("("+data+")");
					if(data.success){
						$('#change-plan-dg').datagrid('selectRow', index).datagrid('beginEdit', index);
						editIndex = index;
					}else{
						$('#change-plan-dg').datagrid('endEdit', index);
						editIndex = undefined;
						alert(data.info);
						return false;
					}
				}
			});
		} else {
			$('#change-plan-dg').datagrid('selectRow', editIndex);
		}
	}
}
function appenduptPlan(){
	if (endEditinguptPlan()){
		$('#change-plan-dg').datagrid('appendRow',{});
		editIndex = $('#change-plan-dg').datagrid('getRows').length-1;
		$('#change-plan-dg').datagrid('selectRow', editIndex)
				.datagrid('beginEdit', editIndex);
	}
}
function removeituptPlan(){
	if (editIndex == undefined){return};
	var rows = $('#change-plan-dg').datagrid('getRows');
	$.ajax({
		url:'${base}/Change/verifyReceivPlan',
		dateType:'json',
		type:'POST',
		async:false,
		data:{'id':rows[editIndex].fPlanId},
		success:function(data){
			data=eval("("+data+")");
			if(data.success){
				$('#change-plan-dg').datagrid('cancelEdit', editIndex).datagrid('deleteRow', editIndex);
				editIndex = undefined;
				setFsumMoney(0,0);
			}else{
				alert(data.info);
				return false;
			}
		}
	});
}

//计算总额
function setFsumMoney(newValue,oldValue) {
	if(newValue==undefined || oldValue==undefined){
		return false;
	}
	var totalFsumMoney = 0;
	var fsumMoney = 0;
	var index=$('#change-plan-dg').datagrid('getRowIndex',$('#change-plan-dg').datagrid('getSelected'));
	var rows = $('#change-plan-dg').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		if(i==index){
			fsumMoney=parseFloat(newValue);
		}else{
			totalFsumMoney+=addNumUpt(rows,i);
		}  
	 
	}
	totalFsumMoney=(parseFloat(totalFsumMoney)+parseFloat(fsumMoney));
	totalFsumMoney=parseFloat(totalFsumMoney);
	$('#totalUptAmount').val(totalFsumMoney);
	$('#F_fAmount').val(totalFsumMoney);
	$('#totalUptAmountshow').numberbox('setValue',totalFsumMoney);
}
//未编辑或者已经编辑完毕的行
function addNumUpt(rows,index){
	var amount=rows[index]['fRecePlanAmount'];
	return isNaN(parseFloat(amount))?0:parseFloat(amount); 
}
function getUptPlan(){
	acceptuptPlan();
	var rows = $('#change-plan-dg').datagrid('getRows');
	var entities= '';
	for(var i = 0;i < rows.length;i++){
		entities = entities  + JSON.stringify(rows[i]) + ',';  
	}
	entities = '[' + entities.substring(0,entities.length -1) + ']';
	return entities;
}
function valuedateUptPlan(){
	acceptuptPlan();
	var fcamount = $('#F_fcAmount').numberbox('getValue');
	var rows = $('#change-plan-dg').datagrid('getRows');
	var count= 0.00;
	for(var i = 0;i < rows.length;i++){
		count = parseFloat(count) + parseFloat(rows[i].fRecePlanAmount);  
	}
	if(count>(fcamount*1.1)){
		return false;
	}else{
		return true;
	}
}


function acceptuptPlan() {
	if (endEditinguptPlan()) {
		$('#change-plan-dg').datagrid('acceptChanges');
	}
}
	</script>