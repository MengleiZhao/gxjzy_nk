<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<body>
<div class="easyui-layout" fit="true">
	<div data-options="region:'center'" border="false" >
		<table id="control-add-commout"  class="easyui-treegrid" style="width:100%;"
            data-options="
                url: '${base }/arrange/dataComm',
                method: 'get',
                striped: true,
				idField: 'id',
				treeField: 'text',
                method: 'get',
				onClickCell: onClickCellCommOut
            ">
	        <thead>
	            <tr>
	                <th data-options="field:'text'" width="50%">支出预算事项</th>
	                <th data-options="field:'col1'" width="15%" align="right">归口部门</th>
	                <th data-options="field:'col2',
	                editor:{
	                	type:'numberbox',
	                	options:{
	                		onChange:total_gyzc
	                	}
	                }" width="20%" align="right">控制数（万元）</th>
	            </tr>
	        </thead>
	    </table> 
	    <table>
	    	<tr>
	    		<td style="font-size: 12">
			     	&nbsp;&nbsp;合计：
	    		</td>
	    		<td>
			     	<input
			     	 class="easyui-textbox" readonly="readonly" id="total_comm"/>
	    		</td>
	    	</tr>
	    </table>
	</div>
</div>

    
    

	<script type="text/javascript">
	
	function total_gyzc(){
		$('#control-add-commout').treegrid('endEdit', editIndex_commout);
		var roots1 = $('#control-add-commout').treegrid('getRoots');
	    var total = 0;
	    for (var i = 0; i < roots1.length ; i++) {
	    	var root1 = roots1[i];
	    	var children = root1.children;
	    	if(children != null){
		    	for(var i = 0; i < children.length ; i++){
		    		var number = parseFloat(children[i].col2);
		    		if(!isNaN(number)){
		    			total += parseFloat(number);
		    		}
		    	}
	    	}
	    }
		$('#total_comm').textbox('setValue',total);
		return total;
	}
	
	var editIndex_commout = undefined;
	function endEditingPersonOut(){
		if (editIndex_commout == undefined){return true}
		if ($('#control-add-commout').treegrid('validateRow', editIndex_commout)){
			$('#control-add-commout').treegrid('endEdit', editIndex_commout);
			editIndex_commout = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickCellCommOut(field,row){
		if (editIndex_commout != row.code){
			if (editIndex_commout != undefined){
				$('#control-add-commout').treegrid('endEdit', editIndex_commout);
			}
			if (row){
				//启用编辑
				editIndex_commout = row.code;
				//更新合计
				total_syysze();
	            $('#control-add-commout').treegrid('beginEdit', editIndex_commout);
	            /* //获得焦点
	            var ed = $('#control-add-commout').treegrid('getEditor', {index:row,field:field});
				if (ed){
					($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
				} */
	        }
		}
	}
	function getCommOut(){
		$('#control-add-commout').treegrid('endEdit',editIndex_commout);
		var rows = $('#control-add-commout').treegrid('getRoots');
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
	