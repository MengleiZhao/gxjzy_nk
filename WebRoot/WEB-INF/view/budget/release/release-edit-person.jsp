<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<body>
<div class="easyui-layout" fit="true">
	<div data-options="region:'center'" border="false" >
		<table id="arrange-add-person"  class="easyui-treegrid" style="width:100%;"
            data-options="
                <%-- url: '${base }/control/dataPersonOut', --%>
				url: '${base }/release/dataPerson2',
				striped: true,
				idField: 'id',
				treeField: 'text',
                method: 'get',
				onClickCell: onClickCell_person_arr">
        <thead>
            <tr>
                <th data-options="field:'text'" width="20%">支出预算事项</th>
                <th data-options="field:'col1'" width="15%" align="right">归口部门</th>
                <th data-options="field:'col2',editor:'numberbox'" width="20%" align="right">控制数（万元）</th>
            </tr>
        </thead>
    </table> 
	</div>
</div>

    
    

	<script type="text/javascript">
	
	var editIndex_arr_person = undefined;
	function endEditing_person(){
		if (editIndex_arr_person == undefined){return true}
		if ($('#arrange-add-person').datagrid('validateRow', editIndex_arr_person)){
			$('#arrange-add-person').datagrid('endEdit', editIndex_arr_person);
			editIndex_arr_person = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickCell_person_arr(field,row){
		//如果是最高级父节点 不进行编辑
		if(row.parentCode=='0' || row.parentCode==''){
			return;
		}
		if (editIndex_arr_person != row.id){
			if (editIndex_arr_person != undefined){
				$('#contro-add-personout').treegrid('endEdit', editIndex_arr_person);
			}
			if (row){
				//启用编辑
				editIndex_arr_person = row.id;
				/* //更新合计
				total_syysze(); */
	            $('#contro-add-personout').treegrid('beginEdit', editIndex_arr_person);
	            //获得焦点
	           /*  var ed = $('#contro-add-personout').treegrid('getEditor', {index:row,field:field});
				if (ed){
					($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
				}  */
	        }
		}
	}
	function getpersonOut(){
		$('#arrange-add-person').treegrid('endEdit',editIndex_arr_person);
		var rows = $('#arrange-add-person').treegrid('getRoots');
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
	