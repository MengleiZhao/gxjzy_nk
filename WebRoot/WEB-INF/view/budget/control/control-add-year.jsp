<%@ page language="java" pageEncoding="UTF-8"%>
<table id="control-add-year" class="easyui-datagrid" 
	style="width:100%;height:auto"
	data-options="
				iconCls: 'icon-edit',
				singleSelect: true,
				scrollbarSize:100,
				fitColumns:true,
				toolbar: '#tb',
				url: '${base}/control/dataYearOut',
				<%-- url: '${base}/project/datagridPlan?beanId='+${bean.FProId}, --%>
				method: 'get',
				onClickCell: onClickCellYear
			">
	<thead>
		<tr>
			<th data-options="field:'fproCode',width:'20%'">项目编号</th>
			<th data-options="field:'fproName',width:'20%',formatter: formartDate_con_add_pro">项目名称</th>
			<th data-options="field:'fproClassName',width:'11%'">项目类别</th>
			<th data-options="field:'fproAppliPeople',width:'9%'">申报人</th>
			<th data-options="field:'fproAppliDepart',width:'8%'">申报部门</th>
			<th data-options="field:'fproAppliTime',align:'center',resizable:false,sortable:true,formatter: formartDate_con_add_year" width="10%">申报日期</th>
			<th data-options="field:'fproBudgetAmount',align:'right',width:'12%'">申报金额（万元）</th>
			<th data-options="field:'controlNum',width:'11%',
				editor:{
					type:'numberbox',
	               	options:{
	               	onChange:total_chae,
                		precision:2
	               	}
			}">控制数（万元）</th>
			<th data-options="field:'name',align:'right',width:'10%'">差额（万元）</th>
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
function total_chae(newValue,oldValue){
	var index=editIndex_yearout;
	var rows = $('#control-add-year').datagrid('getRows');
	var amount=rows[index].fproBudgetAmount-newValue;
	rows[index].name=amount;	
}
function total_year(){
	$('#control-add-year').datagrid('acceptChanges');
	var rows = $('#control-add-year').datagrid('getRows');
    var total = 0;
    for (var i = 0; i < rows.length ; i++) {
      var number = parseFloat(rows[i].controlNum);
      if(!isNaN(number)){
      	total += number;
      }
    }
    $('#total_year').textbox('setValue',total);
    return total;
}

var editIndex_yearout = undefined;
function endEditingYearut(){
	if (editIndex_yearout == undefined){return true}
	if ($('#control-add-year').datagrid('validateRow', editIndex_yearout)){
		$('#control-add-year').datagrid('endEdit', editIndex_yearout);
		editIndex_yearout = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickCellYear(index, field){
	if (editIndex_yearout != index){
		if (endEditingYearut()){
			$('#control-add-year').datagrid('selectRow', index)
					.datagrid('beginEdit', index);
			var ed = $('#control-add-year').datagrid('getEditor', {index:index,field:field});
			if (ed){
				($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
			}
			editIndex_yearout = index;
			//更新合计
			total_syysze(); 
			$('#control-add-year').datagrid('beginEdit', editIndex_yearout);
		} else {
			setTimeout(function(){
				$('#control-add-year').datagrid('selectRow', editIndex_yearout);
			},0);
		}
	}
	//var tr = $('#control-add-year').datagrid('getEditor', {index:index,field:field});
/* 	var rows = $('#control-add-year').datagrid('getRows');
	var amount=rows[index].fproBudgetAmount-rows[index].controlNum;
	rows[index].name=amount;	
	console.log(rows[index].name);  */
	//total_chae(index);
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
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d)  ;
}
function getYearOut(){
	$('#control-add-year').datagrid('acceptChanges');
	var rows = $('#control-add-year').datagrid('getRows');
	var entities= '';
	 for(i = 0;i < rows.length;i++){
	 	entities = entities  + JSON.stringify(rows[i]) + ',';  
	 }
	 entities = '[' + entities.substring(0,entities.length -1) + ']';
	 return entities;
}
function proDetail(proId){
	
	var win=creatFirstWin('查看-项目信息',840,450,'icon-search','/project/detail/'+proId + "?remark=control");
	win.window('open');
}
function formartDate_con_add_pro(val,row){
	var result="<a href='javascript:void(0)' style='color:blue' onclick='proDetail(\""+row.fproId+"\")'>"+val+"</a>";
	return result;
}

function test() {
	var tr = $('#dg').datagrid('getEditors', editIndex_yearout);
	tr[6].target.text();
}
</script>