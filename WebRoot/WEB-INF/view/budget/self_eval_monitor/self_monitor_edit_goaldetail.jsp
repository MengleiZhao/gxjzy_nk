<%@ page language="java" pageEncoding="UTF-8"%>


    <table id="self_monitor_edit_goaldetail" class="easyui-datagrid"  style="height:auto;"
			data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				toolbar: '#tb',
				url: '${base}/pfmmonitor/PGDJsonPagination?goal1=${bean.pid }',
				method: 'post',
				onClickCell: onClickCellPlan
			">
		<thead>
			<tr>
					<th data-options="field:'fmonthRemark',editor:'textbox',align:'center',width:150">当前月执行情况</th>
					<th data-options="field:'fYearRemark',editor:'textbox',width:200,align:'center'">全年预计完成情况</th>
					<th data-options="field:'fFundingDeviation',editor:'textbox',width:150,align:'center'">经费保障偏差原因</th>
					<th data-options="field:'fGuarantee',editor:'textbox',width:150,align:'center'">制度保障偏差原因</th>
					<th data-options="field:'fPersonnelProtection',editor:'textbox',width:150,align:'center'">人员保障偏差原因</th>
					<th data-options="field:'fHardwareProtection',editor:'textbox',width:150,align:'center'">硬件保障偏差目标</th>
					<th data-options="field:'fOtherProtection',editor:'textbox',width:150,align:'center'">其他偏差原因</th>
					<th data-options="field:'fAchieveGoals',formatter:mubiao, width:150,align:'center',editor:{
							editable:true,
							type:'combobox',
							options:{
								valueField:'code',
								textField:'text',
								method:'post',
								url:'${base}/pfmmonitor/lookupsJson?parentCode=wcmbknx',
							}
						}">完成目标可能性</th>
					<th data-options="field:'fProtectionRemark',editor:'textbox',width:150,align:'center'">偏差原因备注</th>
				
				<!-- <th data-options="field:'fRemark_R',width:240,editor:'textbox',align:'center'">备注</th> -->
				<!-- <th data-options="field:'col8',width:110,align:'right',editor:'numberbox'">fpid</th> -->
			</tr>
		</thead>
	</table>
	
	<script type="text/javascript">
	function mubiao (val){
		if(val=="1"){
			return "确定能";
		}else if(val=="2"){
			return "有可能";
		}else if(val=="3"){
			return "完全不可能";
		}
	}
		/* function PayStauts(val) {
			$('#self_monitor_edit_goaldetail').datagrid('updateRow',{
				index: editIndex,
				row: {
					fAssName_RL: val.text,
					fMeasUnit_RL: val.SftjCode,
					fAssCode_RL: val.code
				}
			}); 
			if(val.text=='新增'){
				var win=creatFirstWin('新增物资品目',840,450,'icon-search','/AssetBasicInfo/lowAddOther');
				win.window('open');
			}
	} */
		var editIndex = undefined;
		function endEditingPlan(){
			if (editIndex == undefined){return true}
			if ($('#self_monitor_edit_goaldetail').datagrid('validateRow', editIndex)){
				$('#self_monitor_edit_goaldetail').datagrid('endEdit', editIndex);
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
		}
		function onClickCellPlan(index, field){
			if (editIndex != index){
				if (endEditingPlan()){
					$('#self_monitor_edit_goaldetail').datagrid('selectRow', index)
							.datagrid('beginEdit', index);
					var ed = $('#self_monitor_edit_goaldetail').datagrid('getEditor', {index:index,field:field});
					if (ed){
						($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
					}
					editIndex = index;
				} else {
					setTimeout(function(){
						$('#self_monitor_edit_goaldetail').datagrid('selectRow', editIndex);
					},0);
				}
			}
		}
		function appendPlan(){
			if (endEditingPlan()){
				$('#self_monitor_edit_goaldetail').datagrid('appendRow',{});
				editIndex = $('#self_monitor_edit_goaldetail').datagrid('getRows').length-1;
				$('#self_monitor_edit_goaldetail').datagrid('selectRow', editIndex)
						.datagrid('beginEdit', editIndex);
			}
		}
		function removePlan(){
			if (editIndex == undefined){return };
			$('#self_monitor_edit_goaldetail').datagrid('cancelEdit', editIndex)
					.datagrid('deleteRow', editIndex);
			editIndex = undefined;
		}
		function testPlan(){
			var entities= getPlan();
			 alert(entities);
		}
		function getPlan(){
			$('#self_monitor_edit_goaldetail').datagrid('acceptChanges');
			var rows = $('#self_monitor_edit_goaldetail').datagrid('getRows');
			var entities= '';
			for(i = 0;i < rows.length;i++){
			 entities = entities  + JSON.stringify(rows[i]) + ',';  
			}
			 entities = '[' + entities.substring(0,entities.length -1) + ']';
			 return entities;
		}
	</script>