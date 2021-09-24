<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div id="panelID" class="easyui-panel" data-options="closed:true">
<table id="appli-detail-dg" class="easyui-datagrid" >
</table>
</div>

<div class="window-tab">
<!-- 填写支出明细 -->
<table id="appli-detail-dg-travel" class="easyui-datagrid" style="width:707px;height:auto"
        data-options="singleSelect:true,
        toolbar: '#appli-detail-tb',
        method:'post',
        rownumbers:true,
        striped : true,
		nowrap : false,
		scrollbarSize:0,
		onClickCell: onClickCell,
        <c:if test="${!empty bean.gId}">url: '${base}/apply/mingxi?id=${bean.gId}'</c:if>
        "
        
        >

	<thead>
		<tr>
			<th data-options="field:'costDetail',required:'required',align:'center',width:150,editor:{type:'textbox'}">支出明细</th>
			
			<th data-options="field:'standard',required:'required',align:'center',width:130,editor:{type:'textbox'}">支出标准</th>
			
			<th data-options="field:'applySum',required:'required',align:'right',width:150,
									styler: function (value, row, index) { return 'background-color:#CEECC8;color:red;font-weight:bold;border-bottom:1px solid white';},editor:{type:'numberbox',options:{onChange:addNum,precision:2,groupSeparator:','}}">申请金额[元]</th>
			
			<th data-options="field:'remark',required:'required',align:'center',width:185,editor:{type:'textbox'}">描述</th>
		</tr>
	</thead>

</table>
</div>

<!-- 保存明细json -->
<input type="hidden" id="mingxiJson" name="mingxi"/>


<script type="text/javascript">
/* TEST */
function onBeginEdit(index,row){
	alert(1)
	alert(row.applySum+"!")
}
function onEndEdit(index,row,changes){
	alert(2)
	alert(row.applySum+"?")
}
function onAfterEdit(index,row,changes){
	alert(3)
	alert(row.applySum+"*")
}
</script>

<script type="text/javascript">

/* 该script实现datagrid动态增删行功能 */

function appendMx(){
	$('#appli-detail-dg-travel').datagrid('appendRow',{status:'P'});
	$('#appli-detail-dg-travel').datagrid('selectRow', editIndex)
			.datagrid('beginEdit', editIndex);
}
function removeMx(){
	if (editIndex == undefined){return}
	$('#appli-detail-dg-travel').datagrid('cancelEdit', editIndex)
			.datagrid('deleteRow', editIndex);
	editIndex = undefined;
}
</script>

<script type="text/javascript">

	var editIndex = undefined;
	function endEditing(){
		if (editIndex == undefined){return true}
		if ($('#appli-detail-dg-travel').datagrid('validateRow', editIndex)){
			$('#appli-detail-dg-travel').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickCell(index, field){//index-行数 field-字段
	
		//验证该项是否能编辑
		{
			$('#appli-detail-dg-travel').datagrid('selectRow', index)
			.datagrid('beginEdit', index);
			var ed = $('#appli-detail-dg-travel').datagrid('getEditor', {index:index,field:field});
			
			var rows = $('#appli-detail-dg-travel').datagrid('getRows');
			var row = rows[index];
			//如果是配置项已有的，不能修改'支出明细'和'指出标准'
			if(row.status == undefined && (ed.field=='costDetail' || ed.field=='standard')){
				//alert('该标准已经配置，无法在此处修改！');
				$('#appli-detail-dg-travel').datagrid('acceptChanges');
				return;
			}
		}
		//easyui-demo中的标准化单元格编辑方法
		if (editIndex != index){
			if (endEditing()){
				$('#appli-detail-dg-travel').datagrid('selectRow', index)
						.datagrid('beginEdit', index);
				var ed = $('#appli-detail-dg-travel').datagrid('getEditor', {index:index,field:field});
				
				if (ed){
					($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
				}
				editIndex = index;
			} else {
				setTimeout(function(){
					$('#appli-detail-dg-travel').datagrid('selectRow', editIndex);
				},0);
			}
		}
	}
	function onEndEdit(index, row){
		var ed = $(this).datagrid('getEditor', {
			index: index,
			field: 'productid'
		});
		row.productname = $(ed.target).combobox('getText');
	}
	function append(){
		if (endEditing()){
			$('#appli-detail-dg-travel').datagrid('appendRow',{status:'P'});
			editIndex = $('#appli-detail-dg-travel').datagrid('getRows').length-1;
			$('#appli-detail-dg-travel').datagrid('selectRow', editIndex)
					.datagrid('beginEdit', editIndex);
		}
	}
	function removeit(){
		if (editIndex == undefined){return}
		$('#appli-detail-dg-travel').datagrid('cancelEdit', editIndex)
				.datagrid('deleteRow', editIndex);
		editIndex = undefined;
	}
	function accept(){
		if (endEditing()){
			$('#appli-detail-dg-travel').datagrid('acceptChanges');
		}
	}
	function reject(){
		$('#appli-detail-dg-travel').datagrid('rejectChanges');
		editIndex = undefined;
	}
	function getChanges(){
		var rows = $('#appli-detail-dg-travel').datagrid('getChanges');
		alert(rows.length+' rows are changed!');
	}

</script>

<script type="text/javascript">

/* 该script实现dadagrid的cellEdit功能 */

$.extend($.fn.datagrid.methods, {
	editCell: function(jq,param){
		return jq.each(function(){
			var opts = $(this).datagrid('options');
			var fields = $(this).datagrid('getColumnFields',true).concat($(this).datagrid('getColumnFields'));
			for(var i=0; i<fields.length; i++){
				var col = $(this).datagrid('getColumnOption', fields[i]);
				col.editor1 = col.editor;
				if (fields[i] != param.field){
					col.editor = null;
				}
			}
			$(this).datagrid('beginEdit', param.index);
            var ed = $(this).datagrid('getEditor', param);
            if (ed){
                if ($(ed.target).hasClass('textbox-f')){
                    $(ed.target).textbox('textbox').focus();
                } else {
                    $(ed.target).focus();
                }
            }
			for(var i=0; i<fields.length; i++){
				var col = $(this).datagrid('getColumnOption', fields[i]);
				col.editor = col.editor1;
			}
		});
	},
    enableCellEditing: function(jq){
        return jq.each(function(){
            var dg = $(this);
            var opts = dg.datagrid('options');
            opts.oldOnClickCell = opts.onClickCell;
            opts.onClickCell = function(index, field){
                if (opts.editIndex != undefined){
                    if (dg.datagrid('validateRow', opts.editIndex)){
                        dg.datagrid('endEdit', opts.editIndex);
                        opts.editIndex = undefined;
                    } else {
                        return;
                    }
                }
                dg.datagrid('selectRow', index).datagrid('editCell', {
                    index: index,
                    field: field
                });
                opts.editIndex = index;
                opts.oldOnClickCell.call(this, index, field);
            }
        });
    }
});

$(function(){
	
	$('#appli-detail-dg-travel').datagrid().datagrid('enableCellEditing');
	
});
</script>