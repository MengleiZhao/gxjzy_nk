<%@ page language="java" pageEncoding="UTF-8"%>


    <table id="filing-edit-plan-dg" class="easyui-datagrid"  style="width:840px;height:auto;"
			data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				toolbar: '#tb',
				url: '${base}/Filing/finderReceivPlan?FcId='+${bean.fcId},
				method: 'get'
			">
		<thead>
			<tr>
				<th data-options="field:'col1',formatter:PayStauts,width:150,align:'center',editor:'textbox'">付款性质</th>
				<!-- <th data-options="field:'productid',width:100,
						formatter:function(value,row){
							return row.productname;
						},
						editor:{
							type:'combobox',
							options:{
								valueField:'productid',
								textField:'productname',
								method:'get',
								url:'products.json',
								required:true
							}
						}">计划名称</th>  -->
				<th data-options="field:'col2',width:100,align:'center'">付款阶段</th>
				<th data-options="field:'col3',width:100,align:'center'">付款条件</th>
				<th data-options="field:'col4',width:130,align:'center'">预计付款时间</th>
				<th data-options="field:'col5',width:110,align:'center'">预计付款金额</th>
				<th data-options="field:'col6',width:130,align:'center'">实际付款时间</th>
				<th data-options="field:'col7',width:110,align:'center'">实际付款金额</th>
				<!-- <th data-options="field:'col8',width:110,align:'right',editor:'numberbox'">fpid</th> -->
			</tr>
		</thead>
	</table>
	<div id="tb" style="height:auto">
		<!--<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="appendPlan()">添加计划</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeitPlan()">删除计划</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="testPl an()">test</a>-->
	</div>
	
	<script type="text/javascript">
	function PayStauts(val, row) {
		if (val == "FKXZ-02") {
			return "阶段款";
		} else if (val == "FKXZ-01") {
			return "首款";
		}else if (val == "FKXZ-03") {
			return "验收款";
		}else if (val == "FKXZ-04") {
			return "质保款";
		}
	}
		var editIndex = undefined;
		function endEditingPlan(){
			if (editIndex == undefined){return true}
			if ($('#filing-edit-plan-dg').datagrid('validateRow', editIndex)){
				$('#filing-edit-plan-dg').datagrid('endEdit', editIndex);
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
		}
		function onClickCellPlan(index, field){
			if (editIndex != index){
				if (endEditingPlan()){
					$('#filing-edit-plan-dg').datagrid('selectRow', index)
							.datagrid('beginEdit', index);
					var ed = $('#filing-edit-plan-dg').datagrid('getEditor', {index:index,field:field});
					if (ed){
						($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
					}
					editIndex = index;
				} else {
					setTimeout(function(){
						$('#filing-edit-plan-dg').datagrid('selectRow', editIndex);
					},0);
				}
			}
		}
		function appendPlan(){
			if (endEditingPlan()){
				$('#filing-edit-plan-dg').datagrid('appendRow',{});
				editIndex = $('#filing-edit-plan-dg').datagrid('getRows').length-1;
				$('#filing-edit-plan-dg').datagrid('selectRow', editIndex)
						.datagrid('beginEdit', editIndex);
			}
		}
		function removeitPlan(){
			if (editIndex == undefined){return}
			$('#filing-edit-plan-dg').datagrid('cancelEdit', editIndex)
					.datagrid('deleteRow', editIndex);
			editIndex = undefined;
		}
		function testPlan(){
			var entities= getPlan()
			 alert(entities)
		}
		function getPlan(){
			$('#filing-edit-plan-dg').datagrid('acceptChanges');
			var rows = $('#filing-edit-plan-dg').datagrid('getRows');
			var entities= '';
			for(i = 0;i < rows.length;i++){
			 entities = entities  + JSON.stringify(rows[i]) + ',';  
			}
			 entities = '[' + entities.substring(0,entities.length -1) + ']';
			 return entities;
		}
	</script>