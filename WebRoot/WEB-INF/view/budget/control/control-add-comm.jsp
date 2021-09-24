<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<body>
<div class="easyui-layout" fit="true">
	<div data-options="region:'center'" border="false" >
		<table id="control-add-commout"  class="easyui-treegrid" style="width:95%;"
            data-options="
                url: '${base }/control/dataCommOut',
                method: 'get',
                idField: 'code',
                treeField: 'text',
                method: 'get',
				onClickCell: onClickCellCommOut
            ">
	        <thead>
	            <tr>
	                <th data-options="field:'text'" width="40%">支出预算事项</th>
	                <th data-options="field:'col1'" width="25%" align="right">归口部门</th>
	                <th data-options="field:'col2',
	                editor:{
	                	type:'numberbox',
	                	options:{
	                		onChange:total_gyzc,
                			precision:2
	                	}
	                }" width="28%" align="right">控制数（万元）</th>
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
	function onClickCellCommOut(field,row){
		//如果是最高级父节点 不进行编辑
		if(row.parentCode=='0'){
			return;
		}
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
		$('#control-add-commout').treegrid('acceptChanges');
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
	