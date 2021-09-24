<%@ page language="java" pageEncoding="UTF-8"%>
<table id="control-edit-leave" class="easyui-datagrid" 
	style="width:100%;height:auto"
	data-options="
				singleSelect: true,
				url: '${base}/control/dataLeaveOutEdit?numId=${bean.fCId }',
				method: 'post'
			">
	<thead>
		<tr>
			<th data-options="field:'xmbh',width:'10%'">项目编号</th> 
			<th data-options="field:'xmmc',width:'20%'">项目名称</th>
			<th data-options="field:'xmlb',width:'10%'">项目类别</th>
			<th data-options="field:'sbr',width:'10%'">申报人</th>
			<th data-options="field:'sbbm',width:'10%'">申报部门</th>
			<th data-options="field:'sbsj',align:'center',resizable:false,sortable:true,formatter: formartDate_con_add_leave" width="10%">申报时间</th>
			<th data-options="field:'sbje',width:'20%'">申报金额（万元）</th>
			<th data-options="field:'controlNum',width:'10%',editor:'numberbox'">控制数（万元）</th>
		</tr>
	</thead>
</table>

<script type="text/javascript">
var editIndex_leaveout = undefined;
function endEditingPersonOut(){
	if (editIndex_leaveout == undefined){return true}
	if ($('#control-edit-leave').datagrid('validateRow', editIndex_leaveout)){
		$('#control-edit-leave').datagrid('endEdit', editIndex_leaveout);
		editIndex_leaveout = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickCellLeave(index, field){
	if (editIndex_leaveout != index){
		if (endEditingPersonOut()){
			$('#control-edit-leave').datagrid('selectRow', index)
					.datagrid('beginEdit', index);
			var ed = $('#control-edit-leave').datagrid('getEditor', {index:index,field:field});
			if (ed){
				($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
			}
			editIndex_leaveout = index;
		} else {
			setTimeout(function(){
				$('#control-edit-leave').datagrid('selectRow', editIndex_leaveout);
			},0);
		}
	}
}
function formartDate_con_add_leave(val) {
    var t, y, m, d, h, i, s;
    if(val==null){
  	  return "";
    }
    t = new Date(val)
    y = t.getFullYear();
    m = t.getMonth() + 1;
    d = t.getDate();
    h = t.getHours();
    i = t.getMinutes();
    s = t.getSeconds();
    // 可根据需要在这里定义时间格式  
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) + ' ' + (h < 10 ? '0' + h : h) + ':' + (i < 10 ? '0' + i : i) ;
}
function getLeaveOut(){
	$('#control-edit-leave').datagrid('acceptChanges');
	var rows = $('#control-edit-leave').datagrid('getRows');
	var entities= '';
	 for(i = 0;i < rows.length;i++){
	 	entities = entities  + JSON.stringify(rows[i]) + ',';  
	 }
	 entities = '[' + entities.substring(0,entities.length -1) + ']';
	 return entities;
}

</script>