<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="window-table" style="margin-top: 10px;">
    <table id="proceeds-change-plan-dg" class="easyui-datagrid" style="width:695px;height:auto;"
			data-options="
			toolbar: '#change-proceeds-td',
			<c:if test="${empty Upt.fId_U}">
			url: '${base}/Formulation/proceedsmingxi?id=${bean.fcId}&type=0',
			</c:if>
			<c:if test="${!empty Upt.fId_U}">
			url: '${base}/Change/proceedsmingxi?id=${Upt.fId_U}',
			</c:if>
			method: 'post',
			onClickCell: onClickCellPlanProceeds,
			singleSelect: true,
			scrollbarSize:0,
			rownumbers:true,
			">
		<thead>
			<tr>		
				<th data-options="field:'fStauts',hidden:true"></th>
				<th data-options="field:'fProceedsCondition',editor:{type:'textbox',options:{required:true}},validType:'length[1,50]',align:'center'"style="width: 50%">收款条件</th>
				<th data-options="field:'fProceedsTime',align:'center',formatter: ChangeDateFormat,editor:{type:'datebox',options:{required:true,precision:1}}"style="width: 25%">预计收款时间</th>
				<th data-options="field:'fProceedsAmount',align:'center',editor:{type:'numberbox',options:{required:true,precision:2,onChange:setFsumMoney}}"style="width: 25%">预计收款金额(元)</th>
			</tr>
		</thead>
	</table>
	<div id="change-proceeds-td" style="height:30px">
		<input type="hidden" id="totalAmount"/>
		<a href="javascript:void(0)" onclick="removeitPlanProceeds()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appendPlanProceeds()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
</div>
<script type="text/javascript">
//完成后计算总额并设置
var loadplan = 0;
$('#proceeds-change-plan-dg').datagrid({
	onLoadSuccess : function(data){
		//console.log(data.rows);
		var rows = data.rows;
		var amount = 0.00;
		loadplan += 1;
		for(var i = 0 ;i<rows.length; i++){
			amount = parseFloat(amount) + parseFloat(rows[i].col5);
		}
		$('#totalAmount').val(amount);
	}
});

var editIndexProceeds = undefined;
function endEditingPlanProceeds(){
	if (editIndexProceeds == undefined){return true}
	if ($('#proceeds-change-plan-dg').datagrid('validateRow', editIndexProceeds)){
		$('#proceeds-change-plan-dg').datagrid('endEdit', editIndexProceeds);
		editIndexProceeds = undefined;
		return true;
	} else {
		return false;
	}
}

function onClickCellPlanProceeds(index, field){
	if (editIndexProceeds != index){
		if (endEditingPlanProceeds()){
			var rows = $('#proceeds-change-plan-dg').datagrid('getRows');
			$.ajax({
				url:'${base}/Change/verifyProceedsPlan',
				dateType:'json',
				type:'POST',
				async:false,
				data:{'id':rows[index].fPId},
				success:function(data){
					data=eval("("+data+")");
					if(data.success){
						$('#proceeds-change-plan-dg').datagrid('selectRow', index).datagrid('beginEdit', index);
						var ed = $('#proceeds-change-plan-dg').datagrid('getEditor', {index:index,field:field});
						if (ed){
							($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
						}
						editIndexProceeds = index;
					}else{
						$('#proceeds-change-plan-dg').datagrid('endEdit', index);
						editIndexProceeds = undefined;
						alert(data.info);
						return false;
					}
				}
			});
		} else {
			setTimeout(function(){
				$('#proceeds-change-plan-dg').datagrid('selectRow', editIndexProceeds);
			},0);
		}
	}
}

function appendPlanProceeds(){
	if (endEditingPlanProceeds()){
		$('#proceeds-change-plan-dg').datagrid('appendRow',{});
		editIndexProceeds = $('#proceeds-change-plan-dg').datagrid('getRows').length-1;
		$('#proceeds-change-plan-dg').datagrid('selectRow', editIndexProceeds)
				.datagrid('beginEdit', editIndexProceeds);
	}
}

function removeitPlanProceeds(){
	if (editIndexProceeds == undefined){return}
	var rows = $('#proceeds-change-plan-dg').datagrid('getRows');
	$.ajax({
		url:'${base}/Change/verifyProceedsPlan',
		dateType:'json',
		type:'POST',
		async:false,
		data:{'id':rows[editIndexProceeds].fPId},
		success:function(data){
			data=eval("("+data+")");
			if(data.success){
				$('#proceeds-change-plan-dg').datagrid('cancelEdit', editIndexProceeds).datagrid('deleteRow', editIndexProceeds);
				editIndexProceeds = undefined;
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
	var index=$('#proceeds-change-plan-dg').datagrid('getRowIndex',$('#proceeds-change-plan-dg').datagrid('getSelected'));
	var rows = $('#proceeds-change-plan-dg').datagrid('getRows');
	for(var i=0;i<rows.length;i++){
		if(i==index){
			fsumMoney=parseFloat(newValue);
		}else{
			totalFsumMoney+=addNum(rows,i);
		}  
	}
	totalFsumMoney=(parseFloat(totalFsumMoney)+parseFloat(fsumMoney));
	totalFsumMoney=parseFloat(totalFsumMoney);
	$('#totalAmount').val(totalFsumMoney);
	$('#F_fAmount').val(totalFsumMoney);
}
//未编辑或者已经编辑完毕的行
function addNum(rows,index){
	var amount=rows[index]['col5'];
	return parseFloat(amount); 
}
function getPlanProceeds(){
	$('#proceeds-change-plan-dg').datagrid('acceptChanges');
	var rows = $('#proceeds-change-plan-dg').datagrid('getRows');
	var entities= '';
	for(var i = 0;i < rows.length;i++){
		entities = entities  + JSON.stringify(rows[i]) + ',';  
	}
	entities = '[' + entities.substring(0,entities.length -1) + ']';
	return entities;
}
</script>