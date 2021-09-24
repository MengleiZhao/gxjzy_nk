<%@ page language="java" pageEncoding="UTF-8"%>
<table id="control-add-leave" class="easyui-datagrid" 
	style="width:100%;height:auto"
	data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				toolbar: '#tb',
				url: '${base}/arrange/dataLeast2',
				<%-- url: '${base}/project/datagridPlan?beanId='+${bean.FProId}, --%>
				method: 'get',
				onClickCell: onClickCellLeave
			">
	<thead>
		<tr>
			<th data-options="field:'pro_code',width:'18%'">项目编号</th>
			<th data-options="field:'pro_name',width:'18%'">项目名称</th>
			<th data-options="field:'pro_type',width:'12%'">项目类别</th>
			<th data-options="field:'pro_person',width:'10%'">申报人</th>
			<th data-options="field:'pro_depart',width:'9%'">申报部门</th>
			<th data-options="field:'pro_time',align:'center',resizable:false,sortable:true,formatter: formartDate_con_add_leave" width="10%">申报时间</th>
			<th data-options="field:'pro_money',width:'14%',align:'center'">申报金额（万元）</th>
			<th data-options="field:'fbudgetControl',width:'12%',
				editor:{
					type:'numberbox',
	               	options:{
	               		onChange:total_least
	               	}
				}">控制数（万元）</th>
		</tr>
	</thead>
</table>
<table>
   	<tr>
   		<td style="font-size: 12">
	     	&nbsp;&nbsp;合计：
   		</td>
   		<td onclick="total_least()">
	     	<input
	     	 class="easyui-textbox" readonly="readonly" id="total_least" prompt="点击此处获取合计值" />
   		</td>
   	</tr>
</table>

<script type="text/javascript">
function total_least(){
	$('#control-add-leave').datagrid('acceptChanges');
	var rows = $('#control-add-leave').datagrid('getRows');
    var total = 0;
    for (var i = 0; i < rows.length ; i++) {
      var number = parseFloat(rows[i].controlNum);
      if(!isNaN(number)){
      	total += number;
      }
    }
    $('#total_least').textbox('setValue',total);
    return total;
}

var editIndex_leaveout = undefined;
function endEditingPersonOut(){
	if (editIndex_leaveout == undefined){return true}
	if ($('#control-add-leave').datagrid('validateRow', editIndex_leaveout)){
		$('#control-add-leave').datagrid('endEdit', editIndex_leaveout);
		editIndex_leaveout = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickCellLeave(index, field){
	if (editIndex_leaveout != index){
		if (endEditingPersonOut()){
			$('#control-add-leave').datagrid('selectRow', index)
					.datagrid('beginEdit', index);
			var ed = $('#control-add-leave').datagrid('getEditor', {index:index,field:field});
			if (ed){
				($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
			}
			editIndex_leaveout = index;
			//更新合计
			total_syysze();
			$('#control-add-leave').datagrid('beginEdit', editIndex_leaveout);
		} else {
			setTimeout(function(){
				$('#control-add-leave').datagrid('selectRow', editIndex_leaveout);
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
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d)  ;
}
function getLeaveOut(){
	$('#control-add-leave').treegrid('endEdit', editIndex_leaveout);
	//$('#control-add-leave').datagrid('acceptChanges');
	var rows = $('#control-add-leave').datagrid('getRows');
	var entities= '';
	 for(i = 0;i < rows.length;i++){
	 	entities = entities  + JSON.stringify(rows[i]) + ',';  
	 }
	 entities = '[' + entities.substring(0,entities.length -1) + ']';
	 return entities;
}
</script>