<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<body>
<div class="easyui-layout" fit="true">
	<div data-options="region:'center'" border="false" >
		<table id="control-edit-commout"  class="easyui-datagrid" style="width:100%;"
            data-options="
                url: '${base }/control/dataCommOutEdit?numId=${bean.fCId }',
                method: 'get',
                rownumbers: true,
                method: 'get',
				checkbox: true,
				onClickCell: onClickCell_comm
            ">
        <thead>
            <tr>
                <th data-options="field:'name'" width="50%">支出预算事项</th>
                <th data-options="field:'fdepartment'" width="15%" align="right">归口部门</th>
                <th data-options="field:'fcontrol',editor:'numberbox'" width="20%" align="right">控制数（万元）</th>
            </tr>
        </thead>
    </table> 
	</div>
</div>

    
    

	<script type="text/javascript">
	
	var editIndex_comm = undefined;
	function endEditing_comm(){
		if (editIndex_comm == undefined){return true}
		if ($('#control-edit-commout').datagrid('validateRow', editIndex_comm)){
			$('#control-edit-commout').datagrid('endEdit', editIndex_comm);
			editIndex_comm = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickCell_comm(index, field){
		if (editIndex_comm != index){
			if (endEditing_comm()){
				$('#control-edit-commout').datagrid('selectRow', index)
						.datagrid('beginEdit', index);
				var ed = $('#control-edit-commout').datagrid('getEditor', {index:index,field:field});
				if (ed){
					($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
				}
				editIndex_comm = index;
			} else {
				setTimeout(function(){
					$('#control-edit-commout').datagrid('selectRow', editIndex_comm);
				},0);
			}
		}
	}
	function getCommOut(){
		$('#control-edit-commout').datagrid('acceptChanges');
		var rows = $('#control-edit-commout').datagrid('getRows');
		var entities= '';
		 for(i = 0;i < rows.length;i++){
			 //alert(JSON.stringify(rows[i]))
		 	entities = entities  + JSON.stringify(rows[i]) + ',';  
		 }
		 entities = '[' + entities.substring(0,entities.length -1) + ']';
		 return entities;
	}
	</script>
</body>

</html>
	