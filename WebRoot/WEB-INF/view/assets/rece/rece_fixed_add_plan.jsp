<%@ page language="java" pageEncoding="UTF-8"%>


    <table id="Rece_low_add_plan" class="easyui-datagrid"  style="height:auto;"
			data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				toolbar: '#tb',
				url: '${base}/Rece/lowJsonPagination?fAssReceCode=${bean.fAssReceCode }',
				method: 'post',
				onClickCell: onClickCellPlan
			">
		<thead>
			<tr>
				<c:if test="${openType=='add'}">
					<th data-options="field:'fAssName_RL',align:'center',width:150,
							editor:{
								editable:true,
								type:'combobox',
								options:{
									valueField:'fAssName',
									textField:'fAssName',
									method:'post',
									url:'${base}/Rece/lookupsJsonAssName?type=ZCLX-02',
									onSelect:function(item){
												if(item.fAssName.length!=0) {
													var index=$('#Rece_low_add_plan').datagrid('getRowIndex',$('#Rece_low_add_plan').datagrid('getSelected'));
													var tr = $('#Rece_low_add_plan').datagrid('getEditors', index);
													tr[1].target.textbox('setValue', item.fAssCode)
													tr[1].target.textbox('textbox').attr('readonly',true);
													tr[2].target.textbox('setValue', item.fMeasUnit)
													tr[2].target.textbox('textbox').attr('readonly',true);
													tr[4].target.textbox('setValue', item.stockNum)
													tr[4].target.textbox('textbox').attr('readonly',true);
												} else {
													var index=$('#Rece_low_add_plan').datagrid('getRowIndex',$('#Rece_low_add_plan').datagrid('getSelected'));
													var tr = $('#Rece_low_add_plan').datagrid('getEditors', index);
													tr[1].target.textbox('setValue', '')
													tr[2].target.textbox('setValue', '')
													tr[3].target.textbox('setValue', '')
												}
											}
								}
							}">资产名称</th>
					<th data-options="field:'fAssCode_RL',width:200,editor:'textbox',align:'center'">资产编码</th>
					<th data-options="field:'fMeasUnit_RL',width:150,editor:'textbox',align:'center'">计量单位</th>
					<th data-options="field:'fReceNum_RL',width:150,editor:'numberbox',align:'center'">领用数量</th>
					<th data-options="field:'stockNum',width:150,editor:'numberbox',align:'center'">可用数量</th>
				</c:if>
				<c:if test="${openType=='detail'||openType=='app'}">
					<th data-options="field:'fAssName_RL',align:'center',width:200">资产名称</th>
					<th data-options="field:'fAssCode_RL',width:180,align:'center'">资产编码</th>
					<th data-options="field:'fMeasUnit_RL',width:150,align:'center'">计量单位</th>
					<th data-options="field:'fReceNum_RL',width:150,align:'center'">领用数量</th>
				</c:if>
				
				<!-- <th data-options="field:'fRemark_R',width:240,editor:'textbox',align:'center'">备注</th> -->
				<!-- <th data-options="field:'col8',width:110,align:'right',editor:'numberbox'">fpid</th> -->
			</tr>
		</thead>
	</table>
	<c:if test="${openType=='add'||openType=='edit'}">
		<div id="tb" style="height:30px">
			<a href="javascript:void(0)" onclick="removePlan()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		<a style="float: right;">&nbsp;&nbsp;</a>
			<a href="javascript:void(0)" onclick="appendPlan()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
		</div>
	</c:if>
	
	<script type="text/javascript">

		/* function PayStauts(val) {
			$('#Rece_low_add_plan').datagrid('updateRow',{
				index: editIndex,
				row: {
					fAssName_RL: val.text,
					fMeasUnit_RL: val.SftjCode,
					fAssCode_RL: val.code
				}
			}); 
			if(val.text=='新增'){
				var win=creatFirstWin('新增资产品目',840,450,'icon-search','/AssetBasicInfo/lowAddOther');
				win.window('open');
			}
	} */
		var editIndex = undefined;
		function endEditingPlan(){
			if (editIndex == undefined){return true}
			if ($('#Rece_low_add_plan').datagrid('validateRow', editIndex)){
				$('#Rece_low_add_plan').datagrid('endEdit', editIndex);
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
		}
		function onClickCellPlan(index, field){
			if (editIndex != index){
				if (endEditingPlan()){
					$('#Rece_low_add_plan').datagrid('selectRow', index)
							.datagrid('beginEdit', index);
					var ed = $('#Rece_low_add_plan').datagrid('getEditor', {index:index,field:field});
					if (ed){
						($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
					}
					editIndex = index;
				} else {
					setTimeout(function(){
						$('#Rece_low_add_plan').datagrid('selectRow', editIndex);
					},0);
				}
			}
		}
		function appendPlan(){
			if (endEditingPlan()){
				$('#Rece_low_add_plan').datagrid('appendRow',{});
				editIndex = $('#Rece_low_add_plan').datagrid('getRows').length-1;
				$('#Rece_low_add_plan').datagrid('selectRow', editIndex)
						.datagrid('beginEdit', editIndex);
			}
		}
		function removePlan(){
			if (editIndex == undefined){return };
			$('#Rece_low_add_plan').datagrid('cancelEdit', editIndex)
					.datagrid('deleteRow', editIndex);
			editIndex = undefined;
		}
		function testPlan(){
			var entities= getPlan();
			 alert(entities);
		}
		function getPlan(){
			$('#Rece_low_add_plan').datagrid('acceptChanges');
			var rows = $('#Rece_low_add_plan').datagrid('getRows');
			var entities= '';
			for(i = 0;i < rows.length;i++){
			 entities = entities  + JSON.stringify(rows[i]) + ',';  
			}
			 entities = '[' + entities.substring(0,entities.length -1) + ']';
			 return entities;
		}
	</script>