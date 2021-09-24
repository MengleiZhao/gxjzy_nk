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
<body style="background-color: #f0f5f7;text-align: center;">

		<div style="height: 10px;background-color:#f0f5f7 ">
		</div>	

		<div class="tabletop" >
		<table style="width: 100%;font-size: 12px;">
				<tr>
					<!-- <td width="130px" height="25px" class="queryth">
						预算控制数编号：
					</td>
					<td width="100px">
						<input id="con_query_fBudgetControlBum" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td> -->
					<td width="70px" height="25px" class="queryth">
						预算年份：
					</td>
					<td width="140px">
						<input id="con_query_fBudgetYear" style="width: 150px;height:25px;" class="easyui-numberbox"></input>
					</td>
					<!-- <td width="180px" height="25px" class="queryth">
						预算控制数总额（万元）：
					</td>
					<td width="210px">
						<input id="con_query_NumMin" style="width: 90px;height:25px;" class="easyui-numberbox"></input>
						&nbsp;-&nbsp;
						<input id="con_query_NumMax" style="width: 90px;height:25px;" class="easyui-numberbox"></input>
					</td> -->
					
					<td style="width: 24px;">
						<a href="javascript:void(0)" onclick="queryControl();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png"
								onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"
							/>
						</a>
					</td>
					<td >
						<a href="#" onclick="clearConQuery();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" 
								onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"
							/>
						</a>
					</td>
					
					<td align="right" >
					<input type="button" value="申报"/>
					<input type="button" value="查看流转">
					</td>
				</tr>
			</table>           
		</div>
		
		
		
		<div style="margin: 0 10px 0 10px;height: 700px;" >
			
			<table id="control_dg" class="easyui-datagrid" 
			data-options="collapsible:true,url:'${base}/control/dataControlList',
			method:'post',fit:true,pagination:false,singleSelect: true,striped: true,
			selectOnCheck: true">
				<thead>
					<tr>
						<th data-options="field:'fCId',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'fBudgetControlBum',align:'center'" width="10%">项目编号</th>
						<th data-options="field:'name',align:'center'" width="10%">项目名称</th>
						<th data-options="field:'fBudgetYear',align:'center',formatter: dateformat_year" width="10%">预算年度</th>
						<th data-options="field:'ssyj',align:'center'" width="10%">一级分类名称</th>
						<th data-options="field:'fAllAmount',align:'center'" width="15%">项目预算金额[万元]</th>
						<th data-options="field:'fBasicExpAmount',align:'center'" width="10%">项目控制数[万元]</th>
						<th data-options="field:'fProExpAmount',align:'center'" width="20%">备注</th>
						<th data-options="field:'operation',align:'center',formatter:operformat_controllist" width="10%">操作</th>
						
					</tr>
				</thead>
			</table>
		</div>
		<div region="south" border="false">


<script type="text/javascript">
//分页样式调整
$(function(){
	var pager = $('#control_dg').datagrid().datagrid('getPager');	// get the pager of datagrid
	pager.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});			
});
function clearConQuery(){
	$('#con_query_fBudgetControlBum').textbox('setValue','');
	$('#con_query_fBudgetYear').numberbox('setValue','');
	$('#con_query_NumMin').numberbox('setValue','');
	$('#con_query_NumMax').numberbox('setValue','');
	queryControl();
}
function queryControl(){  
	$('#control_dg').datagrid({
		url:'${base}/control/dataControlList',
		queryParams:{
			fBudgetControlBum:$('#con_query_fBudgetControlBum').textbox('getValue'),
			fBudgetYear:$('#con_query_fBudgetYear').numberbox('getValue'),
			/* NumMin:$('#con_query_NumMin').numberbox('getValue'),
			NumMax:$('#con_query_NumMax').numberbox('getValue') */
		}
	});
}
function addControl(){
	 var win=creatWin('新增-预算控制数分解',1260,500,'icon-search','/control/add');
	  win.window('open');
}
function editControl(id){
	var win=creatWin('修改-预算控制数',1260,500,'icon-search','/control/edit/'+id);
	win.window('open');
}
function deleteControl(id){
		if(confirm("确认删除吗？")){
			$.ajax({ 
				type: 'POST', 
				url: '${base}/control/delete/'+id,
				dataType: 'json',  
				success: function(data){ 
					if(data.success){
						$.messager.alert('系统提示',data.info,'info');
						$("#control_dg").datagrid('reload');
					}else{
						$.messager.alert('系统提示',data.info,'error');
					}
				} 
			}); 
		}
}
//时间格式化
function dateformat_controllist(val) {
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
function dateformat_year(val){
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
    return y ;
}
function detailControl(controlId){
	var win=creatWin('查看-预算控制数',970,500,'icon-search','/control/detail/'+controlId);
	win.window('open');
}
function operformat_controllist(value, row, index){
	var btn1 = "<a href='javascript:void(0)' style='color:blue' onclick='detailControl("+row.fCId+")'>"
				+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/select1.png'>"
				+ "</a>";
	var btn2 = "<a href='javascript:void(0)' style='color:blue' onclick='deleteControl("+row.fCId+")'>"
				/* + "<img onmouseover='picVerdictOut(this)' onmouseout='picVerdictOver(this)' src='"+base+"/resource-modality/${themenurl}/verdict2.png'>" */
				+ "</a>";
	var btn3 = "";
	btn3 = "<a href='javascript:void(0)' style='color:blue' onclick='editControl("+row.fCId+")'>"
			+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/update1.png'>"
			+"</a>";
	return btn1 ;
}
function showA(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
}
function showB(obj){
	obj.src=base+'/resource-modality/${themenurl}/select2.png';
}
function showC(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/update1.png';
}
function showD(obj){
	obj.src=base+'/resource-modality/${themenurl}/update2.png';
}
</script>
</body>
</html>

