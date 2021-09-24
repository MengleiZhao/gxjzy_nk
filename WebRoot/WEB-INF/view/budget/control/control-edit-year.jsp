<%@ page language="java" pageEncoding="UTF-8"%>
<table id="control-edit-year" class="easyui-datagrid" 
	style="width:100%;height:auto"
	data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				toolbar: '#tb',
				url: '${base}/control/dataYearOutEdit?numId=${bean.fCId }',
				<%-- url: '${base}/project/datagridPlan?beanId='+${bean.FProId}, --%>
				method: 'get',
				onClickCell: onClickCell_year
			">
	<thead>
		<tr>
			<th data-options="field:'fProCode',width:'15%'">项目编号</th>
			<th data-options="field:'fProName',width:'20%'">项目名称</th>
			<th data-options="field:'fProType',width:'10%',formatter:leibie">项目类别</th>
			<th data-options="field:'fProHead',width:'10%'">项目负责人</th>
			<th data-options="field:'fProAppliDepart',width:'10%'">申报部门</th>
			<th data-options="field:'fProAppTime',align:'center',resizable:false,sortable:true,formatter: formartDate_con_add_year" width="10%">申报时间</th>
			<th data-options="field:'fProBudgetAmount',width:'13%'">申报金额（万元）</th>
			<th data-options="field:'fControlAmount',width:'10%',
				editor:{
						type:'numberbox',
		               	options:{
		               		<!-- onChange:total_syysze, -->
	                		precision:2}
		               	}">控制数（万元）</th>
		</tr>
	</thead>
</table>
<table hidden="hidden">
   	<tr>
   		<td style="font-size: 12">
	     	&nbsp;&nbsp;合计：
   		</td>
   		<td>
	     	<input
	     	 class="easyui-textbox" readonly="readonly" id="total_year"/>
   		</td>
   	</tr>
</table>
<script type="text/javascript">
function total_year(){
	$('#control-edit-year').datagrid('acceptChanges');
	var rows = $('#control-edit-year').datagrid('getRows');
    var total = 0;
    for (var i = 0; i < rows.length ; i++) {
      var number = parseFloat(rows[i].fControlAmount);
      if(!isNaN(number)){
      	total += number;
      }
    }
    $('#total_year').textbox('setValue',total);
    return total;
}
var editIndex_year = undefined;
function endEditing_year(){
	if (editIndex_year == undefined){return true}
	if ($('#control-edit-year').datagrid('validateRow', editIndex_year)){
		$('#control-edit-year').datagrid('endEdit', editIndex_year);
		editIndex_year = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickCell_year(index, field){
	$('#control-edit-year').datagrid('selectRow', index).datagrid('beginEdit', index);
	if (editIndex_year != index){
		if (endEditing_year()){
			$('#control-edit-year').datagrid('selectRow', index).datagrid('beginEdit', index);
			var ed = $('#control-edit-year').datagrid('getEditor', {index:index,field:field});
			if (ed){
				($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
			}
			editIndex_year = index;
			//更新合计
			total_syysze(); 
			$('#control-edit-year').datagrid('beginEdit', editIndex_year);
		} else {
			setTimeout(function(){
				$('#control-edit-year').datagrid('selectRow', editIndex_year);
			},0);
		}
	}
}
function formartDate_con_add_year(val) {
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
function leibie(val,row){
	if(val=='PRO-TYPE-1'){
		return '重大改革发展项目';
	}
	if(val=='PRO-TYPE-2'){
		return '专项业务费项目';
	}
	if(val=='PRO-TYPE-9'){
		return '其他项目';
	}
}
function getYearOut(){
	$('#control-edit-year').datagrid('acceptChanges');
	var rows = $('#control-edit-year').datagrid('getRows');
	var entities= '';
	 for(i = 0;i < rows.length;i++){
	 	entities = entities  + JSON.stringify(rows[i]) + ',';  
	 }
	 entities = '[' + entities.substring(0,entities.length -1) + ']';
	 return entities;
}
</script>