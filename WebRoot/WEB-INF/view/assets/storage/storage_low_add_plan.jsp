<%@ page language="java" pageEncoding="UTF-8"%>


    <table id="low_add_plan" class="easyui-datagrid"  style="height:auto;"
			data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				rownumbers:true,
				toolbar: '#tb',
				<c:if test="${fpCode!=null}">url: '${base}/Storage/cgpmJsonPagination?fpCode=${fpCode }&fAssType=${bean.fAssType}',</c:if>
				<c:if test="${fpCode==null}">url: '${base}/Storage/lowJsonPagination?fAssStorageCode=${bean.fAssStorageCode }',</c:if>
				method: 'post',
				onClickCell: onClickCellPlan
			">
		<thead>
			<tr>
				<th data-options="field:'fAssName_R',align:'center',width:200,<c:if test="${fpCode==null}">editor:'textbox',</c:if>
						<%-- editor:{
							editable:true,
							type:'combobox',
							options:{
								valueField:'fAssName',
								textField:'fAssName',
								method:'post',
								url:'${base}/Storage/lookupsJsonAssName',
								onSelect:function(item){
											if(item.fAssName=='新增'){
												var win=creatFirstWin('新增资产品目',840,450,'icon-search','/AssetBasicInfo/lowAddOther');
												win.window('open');
											}
											if(item.fAssName.length!=0) {
												var index=$('#low_add_plan').datagrid('getRowIndex',$('#low_add_plan').datagrid('getSelected'));
												var tr = $('#low_add_plan').datagrid('getEditors', index);
												tr[1].target.textbox('setValue', item.fAssCode)
												tr[1].target.textbox('textbox').attr('readonly',true);
												tr[2].target.textbox('setValue', item.fMeasUnit)
												tr[2].target.textbox('textbox').attr('readonly',true);
											} else {
												var index=$('#low_add_plan').datagrid('getRowIndex',$('#low_add_plan').datagrid('getSelected'));
												var tr = $('#low_add_plan').datagrid('getEditors', index);
												tr[1].target.textbox('setValue', '')
												tr[2].target.textbox('setValue', '')
												tr[3].target.textbox('setValue', '')
											}
										}
								}
							} --%>
						">资产名称</th>
				<th data-options="field:'fInsNum_R',width:100,align:'center'<c:if test="${fpCode==null}">,editor:'numberbox'</c:if>">入库数量</th>
				<th data-options="field:'fMeasUnit_R',width:150,align:'center'<c:if test="${fpCode==null}">,editor:'textbox'</c:if>">计量单位</th>
				<th data-options="field:'fmSpecif',width:200,align:'center'<c:if test="${fpCode==null}">,editor:'textbox'</c:if>">规格型号</th>
				<!-- <th data-options="field:'fRemark_R',width:240,editor:'textbox',align:'center'">备注</th> -->
				<!-- <th data-options="field:'col8',width:110,align:'right',editor:'numberbox'">fpid</th> -->
			</tr>
		</thead>
	</table>
	<c:if test="${openType=='add'||openType=='edit'}">
	<div id="tb" style="height:30px">
		<a href="javascript:void(0)" onclick="removePlan()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	<a style="float: right;">&nbsp;&nbsp;</a>
		<a href="javascript:void(0)"  id="addLowButton"  onclick="appendPlan()" style="float: right;"><img src="${base}/resource-modality/${themenurl}/button/tjyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
	</div>
	</c:if>
	<script type="text/javascript">

		function PayStauts(val) {
			$('#low_add_plan').datagrid('updateRow',{
				index: editIndex,
				row: {
					fAssName_R: val.text,
					fMeasUnit_R: val.SftjCode,
					fAssCode_R: val.code
				}
			}); 
			if(val.text=='新增'){
				var win=creatFirstWin('新增资产品目',970,580,'icon-search','/AssetBasicInfo/lowAddOther');
				win.window('open');
			}
	}
		var editIndex = undefined;
		function endEditingPlan(){
			if (editIndex == undefined){return true}
			if ($('#low_add_plan').datagrid('validateRow', editIndex)){
				$('#low_add_plan').datagrid('endEdit', editIndex);
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
		}
		function onClickCellPlan(index, field){
			if (editIndex != index){
				if (endEditingPlan()){
					$('#low_add_plan').datagrid('selectRow', index)
							.datagrid('beginEdit', index);
					var ed = $('#low_add_plan').datagrid('getEditor', {index:index,field:field});
					if (ed){
						($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
					}
					editIndex = index;
				} else {
					setTimeout(function(){
						$('#low_add_plan').datagrid('selectRow', editIndex);
					},0);
				}
			}
		}
		function appendPlan(){
			if (endEditingPlan()){
				$('#low_add_plan').datagrid('appendRow',{});
				editIndex = $('#low_add_plan').datagrid('getRows').length-1;
				$('#low_add_plan').datagrid('selectRow', editIndex).datagrid('beginEdit', editIndex);
			}
		}
		function removePlan(){
			if (editIndex == undefined){return };
			$('#low_add_plan').datagrid('cancelEdit', editIndex)
					.datagrid('deleteRow', editIndex);
			editIndex = undefined;
		}
		function testPlan(){
			var entities= getPlan();
			 alert(entities);
		}
		function getPlan(){
			$('#low_add_plan').datagrid('acceptChanges');
			var rows = $('#low_add_plan').datagrid('getRows');
			var entities= '';
			for(i = 0;i < rows.length;i++){
			 entities = entities  + JSON.stringify(rows[i]) + ',';  
			}
			 entities = '[' + entities.substring(0,entities.length -1) + ']';
			 return entities;
		}
	</script>