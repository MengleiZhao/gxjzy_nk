<%@ page language="java" pageEncoding="UTF-8"%>

	
			
    <table id="project-add-year-indexdg" class="easyui-datagrid" title="指标信息" style="width:100%;height:auto"
			data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				toolbar: '#tb_project_add_yearindex',
				<c:if test="${!empty bean.FProId}">
                url: '${base}/project/datagridYearIndex?beanId='+${bean.FProId},
                </c:if>
				method: 'post',
				onClickCell: onClickCell_yearindex
			">
		<thead>
			<tr>
				<th data-options="field:'col1',width:'8%',editor:'textbox'">序号</th>
				<th data-options="field:'col2',width:'12%',editor:'textbox'">一级指标</th>
				<th data-options="field:'col3',width:'12%',editor:'textbox'">二级指标</th>
				<th data-options="field:'col4',width:'15%',align:'center',editor:'textbox'">指标名称</th>
				<th data-options="field:'col5',width:'26%',align:'center',editor:'numberbox'">往年指标值</th>
				<th data-options="field:'col7',width:'26%',editor:'numberbox'">预期当年实现值（元）</th>
			</tr>
		</thead>
	</table>
	
	<c:if test="${operation!='detail' }">
	<div id="tb_project_add_yearindex" style="height:auto; text-align: right; padding: 10px;">
		<a href="javascript:void(0)" onclick="append_yearindex()">
			<img src="${base}/resource-modality/${themenurl}/button/tjyh1.png"
				onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/skin_/tjyh2.png')"
				onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/tjyh1.png')"
			/>
		</a>
		<a href="javascript:void(0)" onclick="removeit_yearindex()">
			<img src="${base}/resource-modality/${themenurl}/button/scyh1.png"
				onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/skin_/scyh2.png')"
				onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/scyh1.png')"
			/>
		</a>
		<!-- <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="test_yearindex()">test</a> -->
	</div>
	</c:if>
	
	<script type="text/javascript">
		var editIndex = undefined;
		function endEditing_yearindex(){
			if (editIndex == undefined){return true}
			if ($('#project-add-year-indexdg').datagrid('validateRow', editIndex)){
				$('#project-add-year-indexdg').datagrid('endEdit', editIndex);
				editIndex = undefined;
				return true;
			} else {
				return false;
			}
		}
		function onClickCell_yearindex(index, field){
			if (editIndex != index){
				if (endEditing_yearindex()){
					$('#project-add-year-indexdg').datagrid('selectRow', index)
							.datagrid('beginEdit', index);
					var ed = $('#project-add-year-indexdg').datagrid('getEditor', {index:index,field:field});
					if (ed){
						($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
					}
					editIndex = index;
				} else {
					setTimeout(function(){
						$('#project-add-year-indexdg').datagrid('selectRow', editIndex);
					},0);
				}
			}
		}
		function onEndEdit_yearindex(index, row){
			var ed = $(this).datagrid('getEditor', {
				index: index,
				field: 'productid'
			});
			row.productname = $(ed.target).combobox('getText');
		}
		function append_yearindex(){
			if (endEditing_yearindex()){
				$('#project-add-year-indexdg').datagrid('appendRow',{});
				editIndex = $('#project-add-year-indexdg').datagrid('getRows').length-1;
				$('#project-add-year-indexdg').datagrid('selectRow', editIndex)
						.datagrid('beginEdit', editIndex);
			}
		}
		function removeit_yearindex(){
			if (editIndex == undefined){return}
			$('#project-add-year-indexdg').datagrid('cancelEdit', editIndex)
					.datagrid('deleteRow', editIndex);
			editIndex = undefined;
		}
		function test_yearindex(){
			var entities= getYearIndex()
			 alert(entities)
		}
		function getYearIndex(){
			$('#project-add-year-indexdg').datagrid('acceptChanges');
			var rows = $('#project-add-year-indexdg').datagrid('getRows');
			var entities= '';
			for(i = 0;i < rows.length;i++){
			 entities = entities  + JSON.stringify(rows[i]) + ',';  
			}
			 entities = '[' + entities.substring(0,entities.length -1) + ']';
			 return entities;
		}
	</script>