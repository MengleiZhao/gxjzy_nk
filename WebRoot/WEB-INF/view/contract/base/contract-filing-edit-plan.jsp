<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
    <table id="filing-edit-plan-dg" class="easyui-datagrid" style="width:700px;height:auto;"
			data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				toolbar: '#tb',
				<c:if test="${openType != 'add'}">
				url: '${base}/Filing/finderReceivPlan?FcId='+${bean.fcId},
				</c:if>
				method: 'post',
				onClickCell: onClickCellPlan,
				scrollbarSize:0,
				rownumbers:true,
				striped : true,
				checkOnSelect:false
			">
		<thead>
			<tr>
				<th data-options="field:'id',hidden:true"></th>
				<th data-options="field:'ck',checkbox:true"></th>
				<th data-options="field:'col1',align:'center',
						editor:{
							editable:true,
							type:'combotree',
							options:{
								required:false,
								editable:false,
								valueField:'text',
								textField:'text',
								validType:'selectValid',
								method:'post',
								url:'${base}/Expiration/lookupsJson?parentCode=FKXZ'
							}
						}"style="width: 19%">付款性质</th>
				<th data-options="field:'col4',align:'center',editor:{type:'datebox',options:{required:false,editable:false,precision:1}}"style="width: 26%">预计付款时间</th>
				<th data-options="field:'col3',editor:{type:'textbox',options:{required:false,editable:true}},validType:'length[1,50]',align:'center'"style="width: 26%">付款条件</th>
				<th data-options="field:'col5',align:'center',editor:{type:'numberbox',options:{required:false,precision:2,onChange:setFsumMoney}}"style="width: 28%">预计付款金额(元)</th>
			</tr>
		</thead>
	</table>
	<div id="tb" style="height:30px">
		<a href="javascript:void(0)" onclick="removeitPlan()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)" onclick="appendPlan()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
<script type="text/javascript">
	//完成后计算总额并设置
	$('#filing-edit-plan-dg').datagrid({
		onLoadSuccess : function(data){
			//console.log(data.rows);
			var rows = data.rows;
			var amount = 0.00;
			for(var i = 0 ;i<rows.length; i++){
				amount = parseFloat(amount) + parseFloat(rows[i].col5);
			}
			$('#totalAmount').val(amount);
			$('#F_fcAmount').numberbox('setValue',amount);
		}
	})
		var editIndex = undefined;
		function endEditingPlan(){
			if (editIndex == undefined){return true}
			if ($('#filing-edit-plan-dg').datagrid('validateRow', editIndex)){
				//下面三行，是在增加一行的时候，防止原来的一行的值变成code
				var tr = $('#filing-edit-plan-dg').datagrid('getEditors', editIndex);
				var text0=tr[0].target.combotree('getText');
				if(text0!='--请选择--'){
					tr[0].target.combotree('setValue',text0);
				}
				$('#filing-edit-plan-dg').datagrid('endEdit', editIndex);
				editIndex = undefined;
				return true;
			}  else {
				return false;
			} 
		}
		function onClickCellPlan(index, field){
			
			if (editIndex != index){
				if (endEditingPlan()){
					$('#filing-edit-plan-dg').datagrid('selectRow', index)
							.datagrid('beginEdit', index);
					editIndex = index;
				} else {
					$('#filing-edit-plan-dg').datagrid('selectRow', editIndex);
				}
			}
		}
		function appendPlan(){
			var iskjht = $('input[name="iskjht"]:checked').val();
			if(iskjht == '1'){
				alert("此合同为框架合同！");
				return;
			}
			if (endEditingPlan()){
				$('#filing-edit-plan-dg').datagrid('appendRow',{});
				editIndex = $('#filing-edit-plan-dg').datagrid('getRows').length-1;
				$('#filing-edit-plan-dg').datagrid('selectRow', editIndex)
						.datagrid('beginEdit', editIndex);
				
			}
		}
		function removeitPlan(){
			//if (editIndex == undefined){return}
			obj = document.getElementsByName("ck");
			for(var i=0;i<obj.length;i++){
			  if(obj[i].checked){
				$('#filing-edit-plan-dg').datagrid('cancelEdit', i)
						.datagrid('deleteRow', i);
				i--;
				}
				}
			var fsumMoney = 0;
			var rows = $('#filing-edit-plan-dg').datagrid('getRows');
			for(var i=0;i<rows.length;i++){
				fsumMoney += isNaN(parseFloat(rows[i]['col5']))?0:parseFloat(rows[i]['col5']);
				//fsumMoney=parseFloat(newValue);
				//totalFsumMoney+=fsumMoney;
				//totalFsumMoney=(parseFloat(totalFsumMoney)+parseFloat(fsumMoney)); 
			}
			$('#totalAmount').val(fsumMoney);
			acceptPlan();
			editIndex = undefined;
		}
		
		//计算总额
		function setFsumMoney(newValue,oldValue) {
			if(newValue==undefined || oldValue==undefined){
				return false;
			}
			var totalFsumMoney = 0;
			var fsumMoney = 0;
			var index=$('#filing-edit-plan-dg').datagrid('getRowIndex',$('#filing-edit-plan-dg').datagrid('getSelected'));
			var rows = $('#filing-edit-plan-dg').datagrid('getRows');
			for(var i=0;i<rows.length;i++){
				if(i == index){
					fsumMoney += isNaN(parseFloat(newValue))?0:parseFloat(newValue);
				}else{
				fsumMoney += isNaN(parseFloat(rows[i]['col5']))?0:parseFloat(rows[i]['col5']);
				}
				//fsumMoney=parseFloat(newValue);
				//totalFsumMoney+=fsumMoney;
				//totalFsumMoney=(parseFloat(totalFsumMoney)+parseFloat(fsumMoney)); 
			}
			$('#totalAmount').val(fsumMoney);
			//totalFsumMoney=(parseFloat(totalFsumMoney)+parseFloat(fsumMoney));
			//totalFsumMoney=parseFloat(totalFsumMoney);
		}
		//未编辑或者已经编辑完毕的行
		function addNums(rows,index){
			var amount=rows[index]['col5'];
			return parseFloat(amount); 
		}
		//获取付款性质，重复不可选
		function iscol1(newValue){
			var tr = $('#filing-edit-plan-dg').datagrid('getEditors', editIndex);
			var text0=tr[0].target.combotree('getText');
			if(text0 != "阶段款"){
			var rows = $('#filing-edit-plan-dg').datagrid('getRows');
			for(var i=0;i<rows.length;i++){
				if(text0 == rows[i].col1){
					alert("已选择"+text0);
					tr[0].target.combotree('setValue','--请选择--');
				}
			}
			}
		}
		
		function getPlan(){
			acceptPlan();
			var rows = $('#filing-edit-plan-dg').datagrid('getRows');
			var entities= '';
			for(var i = 0;i < rows.length;i++){
			 entities = entities  + JSON.stringify(rows[i]) + ',';  
			}
			 entities = '[' + entities.substring(0,entities.length -1) + ']';
			 return entities;
		}
		
function acceptPlan() {
	if (endEditingPlan()) {
		$('#filing-edit-plan-dg').datagrid('acceptChanges');
	}
}
	</script>