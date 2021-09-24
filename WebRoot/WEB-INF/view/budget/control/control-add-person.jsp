<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<body>
<div class="easyui-layout" fit="true">
	<div data-options="region:'center'" border="false"  >
		<table id="contro-add-personout"  class="easyui-treegrid" style="width:95%;"
            data-options="
                url: '${base }/control/dataPersonOut',
                striped: true,
                method: 'get',
                idField: 'code',
                treeField: 'text',
                method: 'get',
				onClickCell: onClickCellPersonOut
            ">
        <thead>
            <tr>
                <th data-options="field:'text'" width="40%">支出预算事项</th>
                <th data-options="field:'col1'" width="25%" align="right">归口部门</th>
                <th data-options="field:'col2',
                editor:{
                	type:'numberbox',
                	options:{
                		onChange:total_ryzc,
                		precision:2
                	}
                }
                " width="28%" align="right">控制数（万元）</th>
            </tr>
        </thead>
    </table> 
    <table>
    	<tr>
    		<td style="font-size: 12">
		     	&nbsp;&nbsp;合计：
    		</td>
    		<td>
		     	<input style="color: black"
		     	 class="easyui-textbox" readonly="readonly" id="total_person"/>
    		</td>
    	</tr>
    </table>
	</div>
</div>

    
    

	<script type="text/javascript">
	
	function total_ryzc(){
		$('#contro-add-personout').treegrid('endEdit', editIndex_personout);
		var roots1 = $('#contro-add-personout').treegrid('getRoots');
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
		$('#total_person').textbox('setValue',total);
		return total;
	}
	
	var editIndex_personout = undefined;
	function endEditingPersonOut(){
		if (editIndex_personout == undefined){return true}
		if ($('#contro-add-personout').treegrid('validateRow', editIndex_personout)){
			$('#contro-add-personout').treegrid('endEdit', editIndex_personout);
			editIndex_personout = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickCellPersonOut(field,row){
		//如果是最高级父节点 不进行编辑
		if(row.parentCode=='0'){
			return;
		}
		if (editIndex_personout != row.code){
			if (editIndex_personout != undefined){
				$('#contro-add-personout').treegrid('endEdit', editIndex_personout);
			}
			if (row){
				//启用编辑
				editIndex_personout = row.code;
				//更新合计
				total_syysze();
	            $('#contro-add-personout').treegrid('beginEdit', editIndex_personout);
	            //获得焦点
	           /*  var ed = $('#contro-add-personout').treegrid('getEditor', {index:row,field:field});
				if (ed){
					($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
				}  */
	        }
		}
	}
	function getpersonOut(){
		$('#contro-add-personout').treegrid('endEdit', editIndex_personout);
		//$('#contro-add-personout').treegrid('acceptChanges');
		var rows = $('#contro-add-personout').treegrid('getRoots');
		var entities= '';
		 for(i = 0;i < rows.length;i++){
			/*  alert(rows[i].children[3].col2)
			 alert(rows[i].children[4].col2) */
		 	entities = entities  + JSON.stringify(rows[i]) + ',';  
		 }
		 entities = '[' + entities.substring(0,entities.length -1) + ']';
		 return entities;
	}
	</script>
</body>

</html>
	