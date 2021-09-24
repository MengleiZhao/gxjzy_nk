<%@ page language="java" pageEncoding="UTF-8"%>

<!-- <style type="text/css">
.pro_plan_th {
	background: #c1e3f2;
	font-weight: bold;
	color: #333333;
}
.pro_plan_table td {
	border-left:1px solid black;
	border-bottom:1px solid black;
	margin: 0;
	padding: 0
}
.pro_plan_input{
	border: 1px solid #fff;
	background-color: #f0f5f7;
	vertical-align: middle;
}
</style> -->



    <table id="dg" class="easyui-datagrid"  style="width:100%;height:300px"
			data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				fitColumns:true,
				scrollbarSize:0,
				toolbar: '#tb_project_add_yearindex',
				<c:if test="${!empty bean.FProId}">
                url: '${base}/project/yearTargerJiXiao?beanId='+${bean.FProId},
                </c:if>
				method: 'post',
				onClickCell: onClickRow
			">
		<thead>
			<tr>
				<th data-options="field:'pid',align:'center'" style="display:none;width: 5%">ID</th>
				<th data-options="field:'longName1',align:'left'" style="width: 13%">一级指标</th>
				<th data-options="field:'longName2',align:'left'" style="width: 13%">二级指标</th>
				<th data-options="field:'longName3',align:'left'" style="width: 13%">三级指标</th>
				<th data-options="field:'longAmount3',align:'left'" style="width: 10%">预期实现值</th>
				<th data-options="field:'factFinish',align:'left',editor:'numberbox'" style="width: 11%">实际完成值</th>
				<th data-options="field:'factGoal',align:'left',editor:'numberbox'" style="width: 8%">分值</th>
				<th data-options="field:'factScore',align:'left',editor:'numberbox'" style="width: 8%">得分</th>
				<th data-options="field:'factRemark',align:'left',editor:'textbox'" style="width: 20%">未完成原因分析</th>
			</tr>
		</thead>
	</table>
	<input type="hidden" id="mingxiJson" name="mingxi"/>
	
	
	<script type="text/javascript">
	//明细表格添加删除，保存方法
	var editIndex = undefined;
	function endEditing() {
		if (editIndex == undefined) {
			return true
		}
		if ($('#dg').datagrid('validateRow', editIndex)) {
			var ed = $('#dg').datagrid('getEditor', {
				index : editIndex,
				field : 'costDetail'
			});
			$('#dg').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRow(index) {
		if (editIndex != index) {
			if (endEditing()) {
				$('#dg').datagrid('selectRow', index).datagrid('beginEdit',
						index);
				editIndex = index;
			} else {
				$('#dg').datagrid('selectRow', editIndex);
			}
		}
	}
	</script>