
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title></title>
<style type="text/css">
.tabletop{margin: 0 10px 10px 10px;background-color: #fff;font-family: "微软雅黑"}
.queryth{text-align: right;}
</style>
</head>
<body>
	<div class="easyui-layout" fit="true">
		<div data-options="region:'north'" border="false" style="width: 100%;font-size: 12px;height: 40px;">
		<table cellpadding="5" cellspacing="0" class="a_search_table" border="0" >
				<tr>
					<th class="top-table-td1">姓名：</th> 
					<td class="top-table-td2">
						<input id="M_nameAndDept_name" name="" style="width: 90px;height:25px;" class="easyui-textbox"></input>
					</td>
					<th class="top-table-td1">部门名称：</th> 
					<td class="top-table-td2">
						<input id="M_nameAndDept_departName" name=""  style="width: 90px;height:25px;" class="easyui-textbox"></input>
					</td>
					<!-- <th class="td1">角色名称：</th> 
					<td width="100px">
						<input id="M_nameAndDept_accountNo" name="" style="width: 90px;height:25px;" class="easyui-textbox"></input>
					</td> -->
					<td >
						<a href="javascript:void(0)" onclick="queryCF();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
					<td >
						<a href="javascript:void(0)"  onclick="save(${id});"><img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
					</td>
				</tr>
			</table>           
		</div>
		<div  region="center" border="false">
			<table id="M_nameAndDept_dg" 
			data-options="collapsible:true,url:'${base}/wflow/wfNameAndDepart',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'Id',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="25%">序号</th>
						<th data-options="field:'name',align:'center'" width="25%">姓名</th>
						<th data-options="field:'departName',align:'center',resizable:false,sortable:true" width="25%">部门</th>
						<th data-options="field:'roleName',align:'center',resizable:false,sortable:true" width="25%">角色</th>
					</tr>
				</thead>
			</table>
		</div>

	</div>
	


<script type="text/javascript">
//分页样式调整
$(function(){
	var pager = $('#M_nameAndDept_dg').datagrid().datagrid('getPager');	// get the pager of datagrid
	pager.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});			
});


function formatPrice(val,row){
	if (val =="1"){
		return "公开招标";
	} else if(val =="2"){
		return "待邀请招标";
	} else if(val =="3"){
		return "竞争性谈判";
	} else if(val =="4"){
		return"单一来源采购";
	}
}
function CZ(val,row){
	return '<a href="#" onclick="save('+row.fpId+')" class="easyui-linkbutton">'+"选取"+'</a>';
}
function save(id){
	var row = $('#M_nameAndDept_dg').datagrid('getSelected');
	var selections = $('#M_nameAndDept_dg').datagrid('getSelections');
	var departName="#TNC_departName"+id;
	var departId="#TNC_departId"+id;
	var pid="#TNC_pid"+id;
	id='#sb'+id;
	if (row != null && selections.length == 1) {
		//角色代码
		$(pid).val(row.roleCode); 
		//部门代码
		$(departId).val(row.dpID); 
		//角色名称
		$(id).text(row.roleName);
		
		$(departName).val(row.departName); 
		closeFirstWindow();
	} else {
		$.messager.alert('系统提示', '请选择一条数据！', 'info');
	}
}
function queryCF(){  
	$('#M_nameAndDept_dg').datagrid('load',{ 
		name:$('#M_nameAndDept_name').textbox('getValue'),
		mobileNo:$('#M_nameAndDept_departName').textbox('getValue'),
		//accountNo:$('#M_nameAndDept_accountNo').textbox('getValue'),
	} ); 
}
//时间格式化
function ChangeDateFormat(val) {
	//alert(val)
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
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) ;
}
</script>
</body>
</html>

