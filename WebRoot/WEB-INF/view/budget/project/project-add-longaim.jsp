<%@ page language="java" pageEncoding="UTF-8"%>

	
			
    <table id="project-add-long-aimdg" class="easyui-datagrid" title="目标信息" style="width:100%;height:auto"
			data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				toolbar: '#tb_project_add_longaim',
				<c:if test="${!empty bean.FProId}">
                url: '${base}/project/datagridLongAim?beanId='+${bean.FProId},
                </c:if>
				method: 'post',
				onClickCell: onClickCell_longaim
			">
		<thead>
			<tr>
				<th data-options="field:'col1',width:'10%',editor:'textbox'">序号</th>
				<th data-options="field:'col2',width:'90%',editor:'textbox'">目标内容</th>
			</tr>
		</thead>
	</table>
	
	<c:if test="${operation!='detail' }">
	<div id="tb_project_add_longaim" style="height:auto; text-align: right; padding: 10px;">
		<a href="javascript:void(0)" onclick="append_longaim()">
			<img src="${base}/resource-modality/${themenurl}/button/tjyh1.png"
				onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/skin_/tjyh2.png')"
				onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/tjyh1.png')"
			/>
		</a>
		<a href="javascript:void(0)" onclick="removeit_longaim()">
			<img src="${base}/resource-modality/${themenurl}/button/scyh1.png"
				onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/skin_/scyh2.png')"
				onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/scyh1.png')"
			/>
		</a>
		<!-- <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="test_longaim()">test</a> -->
	</div>
	</c:if>
	
	<script type="text/javascript">
		var editIndex = undefined;
		function endEditing_longaim(){
			if (editIndex == undefined){return true}
			if ($('#project-add-long-aimdg').datagrid('validateRow', editIndex)){
				$('#project-add-long-aimdg').datagrid('endEdit', editIndex);
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
		}
		function onClickCell_longaim(index, field){
			if (editIndex != index){
				if (endEditing_longaim()){
					$('#project-add-long-aimdg').datagrid('selectRow', index)
							.datagrid('beginEdit', index);
					var ed = $('#project-add-long-aimdg').datagrid('getEditor', {index:index,field:field});
					if (ed){
						($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
					}
					editIndex = index;
				} else {
					setTimeout(function(){
						$('#project-add-long-aimdg').datagrid('selectRow', editIndex);
					},0);
				}
			}
		}
		function onEndEdit_longaim(index, row){
			var ed = $(this).datagrid('getEditor', {
				index: index,
				field: 'productid'
			});
			row.productname = $(ed.target).combobox('getText');
		}
		var longaim_index = 0;
		function append_longaim(){
			if (endEditing_longaim()){
				longaim_index++;
				$('#project-add-long-aimdg').datagrid('appendRow',{col1:'目标'+longaim_index});
				editIndex = $('#project-add-long-aimdg').datagrid('getRows').length-1;
				$('#project-add-long-aimdg').datagrid('selectRow', editIndex)
						.datagrid('beginEdit', editIndex);
			}
		}
		function removeit_longaim(){
			if (editIndex == undefined){return}
			$('#project-add-long-aimdg').datagrid('cancelEdit', editIndex)
					.datagrid('deleteRow', editIndex);
			editIndex = undefined;
		}
		function test_longaim(){
			var entities= getLongAim()
			 alert(entities)
		}
		function getLongAim(){
			$('#project-add-long-aimdg').datagrid('acceptChanges');
			var rows = $('#project-add-long-aimdg').datagrid('getRows');
			var entities= '';
			for(i = 0;i < rows.length;i++){
			 entities = entities  + JSON.stringify(rows[i]) + ',';  
			}
			 entities = '[' + entities.substring(0,entities.length -1) + ']';
			 return entities;
		}
	</script>