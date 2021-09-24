<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
    <table id="proceeds-edit-plan-dg" class="easyui-datagrid" style="width:700px;height:auto;"
			data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				toolbar: '#tbProceeds',
				<c:if test="${openType != 'add'}">
				url: '${base}/Formulation/proceedsmingxi?id=${bean.fcId}&type=0',
				</c:if>
				method: 'post',
				onClickCell: onClickCellPlanProceeds,
				scrollbarSize:0,
				rownumbers:true,
				checkOnSelect:false
			">
		<thead>
			<tr>
				<th data-options="field:'id',hidden:true"></th>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'fProceedsProperty',align:'center',
						editor:{
							editable:true,
							type:'combotree',
							options:{
								required:false,
								valueField:'text',
								textField:'text',
								validType:'selectValid',
								method:'post',
								url:'${base}/Expiration/lookupsJson?parentCode=FKXZ'
							}
						}"style="width: 15%">收款性质</th>
				<th data-options="field:'fProceedsCondition',editor:{type:'textbox',options:{required:false}},validType:'length[1,50]',align:'center'"style="width: 37%">收款条件</th>
				<th data-options="field:'fProceedsTime',align:'center',editor:{type:'datebox',options:{required:false,precision:1,showSeconds:false,editable:false}},formatter:ChangeDateFormat"style="width: 22%">预计收款时间</th>
				<th data-options="field:'fProceedsAmount',align:'center',editor:{type:'numberbox',options:{required:false,precision:2,onChange:setFsumMoney}}"style="width: 21%">预计收款金额(元)</th>
			</tr>
		</thead>
	</table>
	<div id="tbProceeds" style="height:30px">
		<a href="javascript:void(0)" onclick="removeitPlanProceeds()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appendPlanProceeds()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	<script type="text/javascript">
	//获取付款性质，重复不可选
	/* function isfProceedsProperty(fProceedsProperty){
		var tr = $('#proceeds-edit-plan-dg').datagrid('getEditors', editIndexProceeds);
		var text0=tr[0].target.combotree('getText');
		var rows = $('#proceeds-edit-plan-dg').datagrid('getRows');
		if(text0 != "阶段款"){
		for(var i=0;i<rows.length;i++){
			if(text0 == rows[i].fProceedsProperty){
				alert("已选择"+text0);
				tr[0].target.combotree('setValue','--请选择--');
			}
		}
		}
	} */
	
	//完成后计算总额并设置
	var loadplan = 0;
	$('#proceeds-edit-plan-dg').datagrid({
		onLoadSuccess : function(data){
			//console.log(data.rows);
			var rows = data.rows;
			var amount = 0.00;
			loadplan += 1;
			for(var i = 0 ;i<rows.length; i++){
				amount = parseFloat(amount) + parseFloat(rows[i].fProceedsAmount);
			}
			$('#totalAmount').val(amount);
			$('#F_fcAmount').numberbox('setValue',amount);
		}
	})
		var editIndexProceeds = undefined;
		function endEditingPlanProceeds(){
			if (editIndexProceeds == undefined){return true}
			if ($('#proceeds-edit-plan-dg').datagrid('validateRow', editIndexProceeds)){
				//下面三行，是在增加一行的时候，防止原来的一行的值变成code
				var tr = $('#proceeds-edit-plan-dg').datagrid('getEditors', editIndexProceeds);
				var text0=tr[0].target.combotree('getText');
				if(text0!='--请选择--'){
					tr[0].target.combotree('setValue',text0);
				}
				$('#proceeds-edit-plan-dg').datagrid('endEdit', editIndexProceeds);
				editIndexProceeds = undefined;
				return true;
			} else {
				return false;
			}
		}
		function onClickCellPlanProceeds(index, field){
			if (editIndexProceeds != index){
				if (endEditingPlanProceeds()){
					$('#proceeds-edit-plan-dg').datagrid('selectRow', index).datagrid('beginEdit', index);
					editIndexProceeds = index;
				} else {
					$('#proceeds-edit-plan-dg').datagrid('selectRow', editIndexProceeds);
				}
			}
		}
		function appendPlanProceeds(){
			var iskjht = $('input[name="iskjht"]:checked').val();
			if(iskjht == '1'){
				alert("此合同为框架合同！");
				return;
			}
			if (endEditingPlanProceeds()){
				$('#proceeds-edit-plan-dg').datagrid('appendRow',{});
				editIndexProceeds = $('#proceeds-edit-plan-dg').datagrid('getRows').length-1;
				$('#proceeds-edit-plan-dg').datagrid('selectRow', editIndexProceeds)
						.datagrid('beginEdit', editIndexProceeds);
			}
		}
		function removeitPlanProceeds(){
			//if (editIndexProceeds == undefined){return}
			obj = document.getElementsByName("ck");
			for(var i=0;i<obj.length;i++){
			  if(obj[i].checked){
				  $('#proceeds-edit-plan-dg').datagrid('cancelEdit', i)
					.datagrid('deleteRow', i);
				i--;
				}
				}
			
			var fsumMoney = 0;
			var rows = $('#proceeds-edit-plan-dg').datagrid('getRows');
			for(var i=0;i<rows.length;i++){
				fsumMoney += isNaN(parseFloat(rows[i].fProceedsAmount))?0:parseFloat(rows[i].fProceedsAmount);
			}
			//totalFsumMoney=(parseFloat(totalFsumMoney)+parseFloat(fsumMoney));
			//totalFsumMoney=parseFloat(totalFsumMoney);
			$('#totalAmount').val(fsumMoney);
			acceptPlanProceeds();
			editIndexProceeds = undefined;
		}
		
		//计算总额
function setFsumMoney(newValue,oldValue) {
			if(newValue==undefined || oldValue==undefined){
				return false;
			}
			var totalFsumMoney = 0;
			var fsumMoney = 0;
			var index=$('#proceeds-edit-plan-dg').datagrid('getRowIndex',$('#proceeds-edit-plan-dg').datagrid('getSelected'));
			var rows = $('#proceeds-edit-plan-dg').datagrid('getRows');
			for(var i=0;i<rows.length;i++){
				if(i == index){
					fsumMoney += isNaN(parseFloat(newValue))?0:parseFloat(newValue);
				}else{
				fsumMoney += isNaN(parseFloat(rows[i].fProceedsAmount))?0:parseFloat(rows[i].fProceedsAmount);
				}
				//fsumMoney=parseFloat(newValue);
				//totalFsumMoney+=addNum(rows,i);
				//fsumMoney = rows[i].fProceedsAmount;
				//totalFsumMoney=(parseFloat(totalFsumMoney)+parseFloat(fsumMoney));
			}
			//totalFsumMoney=(parseFloat(totalFsumMoney)+parseFloat(fsumMoney));
			//totalFsumMoney=parseFloat(totalFsumMoney);
			$('#totalAmount').val(fsumMoney);
		}
		//未编辑或者已经编辑完毕的行
		function addNum(rows,index){
			var amount=rows[index]['fProceedsAmount'];
			return parseFloat(amount); 
		}
		function getPlanProceeds(){
			acceptPlanProceeds();
			var rows = $('#proceeds-edit-plan-dg').datagrid('getRows');
			var entities= '';
			for(var i = 0;i < rows.length;i++){
			 entities = entities  + JSON.stringify(rows[i]) + ',';  
			}
			 entities = '[' + entities.substring(0,entities.length -1) + ']';
			 return entities;
		}
function acceptPlanProceeds() {
	if (endEditingPlanProceeds()) {
		$('#proceeds-edit-plan-dg').datagrid('acceptChanges');
	}
}
	</script>