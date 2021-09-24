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
	<div  class="easyui-layout" fit="true" >
		<%-- <div data-options="region:'north'" border="false" style="width: 100%;font-size: 12px;height: 40px;">
		<table class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-td1">申请时间：</td> 
				<td class="top-table-td2">
					<input id="" name=""  style="width: 150px;height:25px;" class="easyui-datebox"></input>
				</td>
				
				<td style="width: 30px;"></td>
				
				<td class="top-table-td1">审批状态：</td> 
				<td class="top-table-td2">
					<input id="" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
				</td>
				
				<td style="width: 30px;"></td>
				
				<td style="width: 26px;">
					<a href="#" onclick="queryApply();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td style="width: 8px;"></td>
				
				<td style="width: 26px;">
					<a href="#" onclick="clearTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
				
				<td align="right" style="padding-right: 10px">
					<a href="#" id="imput" onclick="shengcheng()">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/daoru1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				
					<a href="#" id="imput" onclick="imput()">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/daoru1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				
					<a href="#" onclick="add()">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>         
		</div> --%>
		<div  region="center" border="false">
			<table id="basicIndex" class="easyui-datagrid"
					data-options="collapsible:true,url:'${base}/quota/indexPage?indexType=1',
					method:'post',fit:true,pagination:true,singleSelect: false,
					selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns:false" >
						<thead>
							<tr>
								<th data-options="field:'bId',hidden:true"></th>
								<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
								<th data-options="field:'indexCode',align:'left'" style="width: 20%">预算指标编码</th>
								<th data-options="field:'indexName',align:'left'" style="width: 20%">预算指标名称</th>
								<th data-options="field:'ysAmount',align:'left'" style="width: 20%">指标预算金额(万元)</th>
								<th data-options="field:'deptName',align:'left'" style="width: 20%">使用部门</th>
								<th data-options="field:'appDate',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 15%">批复日期</th>
							</tr>
						</thead>
					</table>
		</div>

	</div>
	


<script type="text/javascript">
//分页样式调整
$(function(){
	var pager = $('#basicIndex').datagrid().datagrid('getPager');	// get the pager of datagrid
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
	return '<a href="#" onclick="PitchOn('+row.fpId+')" class="easyui-linkbutton">'+"选取"+'</a>';
}
function PitchOn(id){
	var row = $('#allcoa_nameAndDept_dg').datagrid('getSelected');
	var selections = $('#allcoa_nameAndDept_dg').datagrid('getSelections');
	if (row != null && selections.length == 1) {
		$("#R_fReceUser").textbox('setValue',row.authAccount); 
		$("#R_fReceDept").textbox('setValue',row.departName); 
		$("#R_fReceTel").textbox('setValue',row.mobileNo); 
		closeFirstWindow();
	} else {
		$.messager.alert('系统提示', '请选择一条数据！', 'info');
	}
}
function queryCF(){  
	$('#allcoa_nameAndDept_dg').datagrid('load',{ 
		name:$('#alloca_nameAndDept_name').textbox('getValue'),
		mobileNo:$('#alloca_nameAndDept_departName').textbox('getValue'),
		accountNo:$('#alloca_nameAndDept_accountNo').textbox('getValue'),
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

