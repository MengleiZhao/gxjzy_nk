<%@ page language="java" pageEncoding="UTF-8"%>

	
			
    <table id="project-add-long-indexdg" class="easyui-datagrid" title="指标信息" style="width:100%;height:auto"
			data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				toolbar: '#tb_project_add_longindex',
				<c:if test="${!empty bean.FProId}">
                url: '${base}/project/datagridLongIndex?beanId='+${bean.FProId},
                </c:if>
				method: 'post',
				onClickCell: onClickCell_longindex
			">
		<thead>
			<tr>
				<th data-options="field:'col1',width:'10%',editor:'textbox'">序号</th>
				<th data-options="field:'col2',width:'20%',editor:'textbox'">一级指标</th>
				<th data-options="field:'col3',width:'20%',editor:'textbox'">二级指标</th>
				<th data-options="field:'col4',width:'20%',editor:'textbox'">指标名称</th>
				<th data-options="field:'col5',width:'10%',align:'right',editor:'numberbox'">指标值</th>
				<th data-options="field:'col6',width:'20%',editor:'textbox'">绩效标准</th>
			</tr>
		</thead>
	</table>
	
	<c:if test="${operation!='detail' }">
	<div id="tb_project_add_longindex" style="height:auto; text-align: right; padding: 10px;">
		<a href="javascript:void(0)" onclick="append_longindex()">
			<img src="${base}/resource-modality/${themenurl}/button/tjyh1.png"
				onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/skin_/tjyh2.png')"
				onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/tjyh1.png')"
			/>
		</a>
		<a href="javascript:void(0)" onclick="removeit_longindex()">
			<img src="${base}/resource-modality/${themenurl}/button/scyh1.png"
				onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/skin_/scyh2.png')"
				onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/scyh1.png')"
			/>
		</a>
		<!-- <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="test_longindex()">test</a> -->
	</div>
	</c:if>
	
	<script type="text/javascript">
		var editIndex = undefined;
		function endEditing_longindex(){
			if (editIndex == undefined){return true}
			if ($('#project-add-long-indexdg').datagrid('validateRow', editIndex)){
				$('#project-add-long-indexdg').datagrid('endEdit', editIndex);
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
		}
		function onClickCell_longindex(index, field){
			if (editIndex != index){
				if (endEditing_longindex()){
					$('#project-add-long-indexdg').datagrid('selectRow', index)
							.datagrid('beginEdit', index);
					var ed = $('#project-add-long-indexdg').datagrid('getEditor', {index:index,field:field});
					if (ed){
						($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
					}
					editIndex = index;
				} else {
					setTimeout(function(){
						$('#project-add-long-indexdg').datagrid('selectRow', editIndex);
					},0);
				}
			}
		}
		function onEndEdit_longindex(index, row){
			var ed = $(this).datagrid('getEditor', {
				index: index,
				field: 'productid'
			});
			row.productname = $(ed.target).combobox('getText');
		}
		function append_longindex(){
			if (endEditing_longindex()){
				$('#project-add-long-indexdg').datagrid('appendRow',{});
				editIndex = $('#project-add-long-indexdg').datagrid('getRows').length-1;
				$('#project-add-long-indexdg').datagrid('selectRow', editIndex)
						.datagrid('beginEdit', editIndex);
			}
		}
		function removeit_longindex(){
			if (editIndex == undefined){return}
			$('#project-add-long-indexdg').datagrid('cancelEdit', editIndex)
					.datagrid('deleteRow', editIndex);
			editIndex = undefined;
		}
		function test_longindex(){
			var entities= getLongIndex()
			 alert(entities)
		}
		function getLongIndex(){
			$('#project-add-long-indexdg').datagrid('acceptChanges');
			var rows = $('#project-add-long-indexdg').datagrid('getRows');
			var entities= '';
			for(i = 0;i < rows.length;i++){
			 entities = entities  + JSON.stringify(rows[i]) + ',';  
			}
			 entities = '[' + entities.substring(0,entities.length -1) + ']';
			 return entities;
		}
	</script>