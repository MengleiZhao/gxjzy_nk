<%@ page language="java" pageEncoding="UTF-8"%>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>
</head>
<body>
	<table id="control_subject_dg" class="easyui-datagrid" 
		data-options="collapsible:true,url:'${base}/basicExpent/dataSubject',
		method:'post',fit:true,pagination:false,singleSelect: true,
		selectOnCheck: true,
				onLoadSuccess: onLoadSuccess_subject">
		<thead>
			<tr>
				<th data-options="field:'id',hidden:true"></th>
				<th data-options="field:'col1',align:'center'" width="12%">支出科目</th>
				<th data-options="field:'col2',align:'center'" width="12%">归口部门</th>
				<th data-options="field:'col3',align:'center'" width="12%">年度</th>
				<th data-options="field:'col4',align:'center'" width="12%">控制数部门总额（万元）</th>
				<!-- <th data-options="field:'col5',align:'center'" width="10%">控制数科目总额（万元）</th> -->
				<th data-options="field:'col8',align:'center'" width="12%">当年执行额（万元）</th>
				<th data-options="field:'col9',align:'center'" width="12%">当年执行率（%）</th>
				<th data-options="field:'col6',align:'center'" width="14%">控制数操作人</th>
				<th data-options="field:'col7',align:'center'" width="14%">控制数操作日期</th>
			</tr>
		</thead>
	</table>
</body>
<script type="text/javascript">
function onLoadSuccess_subject(data){
	mergeCol1_sub();
}
function mergeCol1_sub(){
	var rows = $('#control_subject_dg').datagrid('getRows');
	if (rows.length>1) {
		var index = [0];
		for(var i=1; i<rows.length; i++){
			if(rows[i].col1 != rows[i-1].col1){
				index.push(i);
			}
		}
		if(index.length>1){
			for (var i=1; i<index.length; i++) {
				$('#control_subject_dg').datagrid('mergeCells',{
					index: index[i-1],
					field: 'col1',
					rowspan: index[i] - index[i-1]
				});
			}
		}
		$('#control_subject_dg').datagrid('mergeCells',{
			index: index[index.length - 1],
			field: 'col1',
			rowspan: rows.length - index[index.length-1] 
		});
	}
}
</script>
</html>

