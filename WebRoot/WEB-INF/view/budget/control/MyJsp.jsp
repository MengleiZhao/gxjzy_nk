<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<body>
	<h2>Editable TreeGrid</h2>
	<p>Select one node and click edit button to perform editing.</p>
	<div style="margin:20px 0;">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="edit()">Edit</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="save()">Save</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="cancel()">Cancel</a>
	</div>
	<table id="tg" class="easyui-treegrid" title="Editable TreeGrid" style="width:700px;height:250px"
			data-options="
				url: '${base}/project/dataPersonOut',
				method: 'get',
				idField: 'code',
                treeField: 'text',
				showFooter: true,
				onClickCell: onClickCellPersonOut
			">
		<thead>
			<tr>
				<th data-options="field:'text'" width="50%">支出预算事项</th>
                <th data-options="field:'code'" width="15%" align="right">科目代码</th>
                <th data-options="field:'id'" width="15%" align="right">科目id</th>
                <th data-options="field:'parentCode',editor:'text'" width="20%" align="right">上级科目代码</th>
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
	
		function onClickCellPersonOut(field,row){
				
	            if (row){
                editingId = row.id
				alert(editingId)
                $('#tg').treegrid('beginEdit', editingId);
            }
			
		
		}
		function formatProgress(value){
	    	if (value){
		    	var s = '<div style="width:100%;border:1px solid #ccc">' +
		    			'<div style="width:' + value + '%;background:#cc0000;color:#fff">' + value + '%' + '</div>'
		    			'</div>';
		    	return s;
	    	} else {
		    	return '';
	    	}
		}
		var editingId;
		function edit(){
			if (editingId != undefined){
				$('#tg').treegrid('select', editingId);
				return;
			}
			var row = $('#tg').treegrid('getSelected');
			if (row){
				editingId = row.id
				alert(editingId)
				$('#tg').treegrid('beginEdit', editingId);
			}
		}
		function save(){
			if (editingId != undefined){
				var t = $('#tg');
				t.treegrid('endEdit', editingId);
				editingId = undefined;
				var persons = 0;
				var rows = t.treegrid('getChildren');
				for(var i=0; i<rows.length; i++){
					var p = parseInt(rows[i].persons);
					if (!isNaN(p)){
						persons += p;
					}
				}
				var frow = t.treegrid('getFooterRows')[0];
				frow.persons = persons;
				t.treegrid('reloadFooter');
			}
		}
		function cancel(){
			if (editingId != undefined){
				$('#tg').treegrid('cancelEdit', editingId);
				editingId = undefined;
			}
		}
	</script>

</body>
</html>
	