<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<body>
<div class="easyui-layout" fit="true">
	<div data-options="region:'center'" border="false" >
		<table id="contro-edit-personout"  class="easyui-datagrid" style="width:100%;"
            data-options="
                url: '${base }/control/dataPersonOutEdit?numId=${bean.fCId }',
                method: 'get',
                rownumbers: true,
                method: 'get',
				checkbox: true,
				onClickCell: onClickCell_person">
        <thead>
            <tr>
                <th data-options="field:'name'" width="20%">支出预算事项</th>
                <th data-options="field:'fdepartment'" width="15%" align="right">归口部门</th>
                <th data-options="field:'fcontrol',editor:'numberbox'" width="20%" align="right">控制数（万元）</th>
            </tr>
        </thead>
    </table> 
	</div>
</div>

    
    

	<script type="text/javascript">
	
	var editIndex_person = undefined;
	function endEditing_person(){
		if (editIndex_person == undefined){return true}
		if ($('#contro-edit-personout').datagrid('validateRow', editIndex_person)){
			$('#contro-edit-personout').datagrid('endEdit', editIndex_person);
			editIndex_person = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickCell_person(index, field){
		if (editIndex_person != index){
			if (endEditing_person()){
				$('#contro-edit-personout').datagrid('selectRow', index)
						.datagrid('beginEdit', index);
				var ed = $('#contro-edit-personout').datagrid('getEditor', {index:index,field:field});
				if (ed){
					($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
				}
				editIndex_person = index;
			} else {
				setTimeout(function(){
					$('#contro-edit-personout').datagrid('selectRow', editIndex_person);
				},0);
			}
		}
	}
	function getpersonOut(){
		$('#contro-edit-personout').datagrid('acceptChanges');
		var rows = $('#contro-edit-personout').datagrid('getRows');
		var entities= '';
		 for(i = 0;i < rows.length;i++){
		 	entities = entities  + JSON.stringify(rows[i]) + ',';  
		 }
		 entities = '[' + entities.substring(0,entities.length -1) + ']';
		 return entities;
	}
	</script>
</body>

</html>
	