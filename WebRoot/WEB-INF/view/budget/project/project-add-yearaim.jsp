<%@ page language="java" pageEncoding="UTF-8"%>

	
			
    <table id="project-add-year-aimdg" class="easyui-datagrid" title="目标信息" style="width:100%;height:auto"
			data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				toolbar: '#tb_project_add_yearaim',
				<c:if test="${!empty bean.FProId}">
                url: '${base}/project/datagridYearAim?beanId='+${bean.FProId},
                </c:if>
				method: 'post',
				onClickCell: onClickCell_yearaim
			">
		<thead>
			<tr>
				<th data-options="field:'col1',width:'10%',editor:'textbox'">序号</th>
				<th data-options="field:'col2',width:'90%',editor:'textbox'">目标内容</th>
			</tr>
		</thead>
	</table>
	
	<c:if test="${operation!='detail' }">
	<div id="tb_project_add_yearaim" style="height:auto; text-align: right; padding: 10px;">
		<a href="javascript:void(0)" onclick="append_yearaim()">
			<img src="${base}/resource-modality/${themenurl}/button/tjyh1.png"
				onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/skin_/tjyh2.png')"
				onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/tjyh1.png')"
			/>
		</a>
		<a href="javascript:void(0)" onclick="removeit_yearaim()">
			<img src="${base}/resource-modality/${themenurl}/button/scyh1.png"
				onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/skin_/scyh2.png')"
				onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/scyh1.png')"
			/>
		</a>
		<!-- <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="test_yearaim()">test</a> -->
	</div>
	</c:if>
	
	<script type="text/javascript">
		var editIndex = undefined;
		function endEditing_yearaim(){
			if (editIndex == undefined){return true}
			if ($('#project-add-year-aimdg').datagrid('validateRow', editIndex)){
				$('#project-add-year-aimdg').datagrid('endEdit', editIndex);
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
		}
		function onClickCell_yearaim(index, field){
			if (editIndex != index){
				if (endEditing_yearaim()){
					$('#project-add-year-aimdg').datagrid('selectRow', index)
							.datagrid('beginEdit', index);
					var ed = $('#project-add-year-aimdg').datagrid('getEditor', {index:index,field:field});
					if (ed){
						($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
					}
					editIndex = index;
				} else {
					setTimeout(function(){
						$('#project-add-year-aimdg').datagrid('selectRow', editIndex);
					},0);
				}
			}
		}
		function onEndEdit_yearaim(index, row){
			var ed = $(this).datagrid('getEditor', {
				index: index,
				field: 'productid'
			});
			row.productname = $(ed.target).combobox('getText');
		}
		var yearaim_index=0;
		function append_yearaim(){
			if (endEditing_yearaim()){
				yearaim_index++;
				$('#project-add-year-aimdg').datagrid('appendRow',{col1:'目标'+yearaim_index});
				editIndex = $('#project-add-year-aimdg').datagrid('getRows').length-1;
				$('#project-add-year-aimdg').datagrid('selectRow', editIndex)
						.datagrid('beginEdit', editIndex);
			}
		}
		function removeit_yearaim(){
			if (editIndex == undefined){return}
			$('#project-add-year-aimdg').datagrid('cancelEdit', editIndex)
					.datagrid('deleteRow', editIndex);
			editIndex = undefined;
		}
		function test_yearaim(){
			var entities= getYearAim()
			 alert(entities)
		}
		function getYearAim(){
			$('#project-add-year-aimdg').datagrid('acceptChanges');
			var rows = $('#project-add-year-aimdg').datagrid('getRows');
			var entities= '';
			for(i = 0;i < rows.length;i++){
			 entities = entities  + JSON.stringify(rows[i]) + ',';  
			}
			 entities = '[' + entities.substring(0,entities.length -1) + ']';
			 return entities;
		}
	</script>