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

		<!-- hidden -->
		<input type=hidden id="arrange_list_menuType" value="${menuType}"/>

		<div style="height: 10px;background-color:#f0f5f7 ">
		</div>	

		<div class="tabletop" >
		<table style="width: 100%;font-size: 12px;">
				<tr>
					<td width="130px" height="25px" class="queryth">
						预算编号：
					</td>
					<td width="100px">
						<input id="arr_query_code" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					
					<td width="100px" height="25px" class="queryth">
						编制部门：
					</td>
					<td width="140px">
						<div ondblclick="choose_depart_arrlist()">
							<input id="arr_query_department"   style="width: 150px;height:25px;" class="easyui-textbox" 
							<%-- prompt="<双击选择编制部门>" readonly="readonly" --%>></input>
						</div>
					</td>
					
					<td width="70px" height="25px" class="queryth">
						年度：
					</td>
					<td width="140px">
						<input id="arr_query_year" style="width: 150px;height:25px;" class="easyui-numberbox"
						 ></input>
					</td>
					
					<!-- <td width="70px" height="25px" class="queryth">
						审批状态：
					</td>
					<td width="140px">
						<select id="arr_query_flowStatus" style="width: 150px;height:25px;" class="easyui-combobox">
							<option value="">-请选择-</option>
							<option value="0">暂存</option>
							<option value="1">一级审批</option>
							<option value="2">二级审批</option>
							<option value="3">审批通过</option>
						</select>
					</td> -->
					
					<td style="width: 24px;">
						<a href="javascript:void(0)" onclick="queryArrange();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png"
								onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"
							/>
						</a>
					</td>
					<td style="width:510px;">
						<a href="#" onclick="clearArrange();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" 
								onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"
							/>
						</a>
					</td>
					
					<td>
						<a href="#" onclick="exportArrangeTz();">
							<img src="${base}/resource-modality/${themenurl}/button/daochu1.png" 
								onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/daochu1.png')"
							/>
						</a>
					</td>
					
					
					<c:if test="${menuType=='1' }">
						<td align="right" >
							<a href="#" onclick="addArrange()">
								<img src="${base}/resource-modality/${themenurl}/button/xzysbz1.png"
									onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/xzysbz2.png')"
									onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/xzysbz1.png')"
								/>
							</a>
						</td>
					</c:if>
					
				</tr>
			</table>           
		</div>
		
		
		
		<div style="margin: 0 10px 0 10px;height: 700px;" >
			
			<table id="arrange_dg" class="easyui-datagrid" 
			data-options="collapsible:true,url:'${base}/arrange/pageData/${menuType}',
			method:'post',fit:true,pagination:true,singleSelect: true,striped: true,
			selectOnCheck: true">
				<thead>
					<tr>
						<th data-options="field:'id',hidden:true"></th>
						<th data-options="field:'pageOrder',align:'center'" width="5%">序号</th>
						<th data-options="field:'fbudgetControlNum',align:'center'" width="20%">预算编制编号</th>
						<th data-options="field:'fbudgetYear',align:'center',formatter: dateformat_arr_year" width="5%">年度</th>
						<th data-options="field:'fbudgetControlSum',align:'center'" width="15%">控制数总额（万元）</th>
						<th data-options="field:'departStr',align:'center'" width="8%">编制部门</th>
						<th data-options="field:'fuser',align:'center'" width="7%">编制人</th>
						<th data-options="field:'flowStatus',align:'center',formatter:format_arr_fflowStauts" width="11%">审批状态</th>
						<th data-options="field:'ftime',align:'center',resizable:false,sortable:true,
							formatter: dateformat_arrlist" width="12%">编制日期</th>
						<th data-options="field:'operation',align:'center',formatter:operformat_arrlist" width="15%">操作</th>
						
					</tr>
				</thead>
			</table>
		</div>
		<div region="south" border="false">


<script type="text/javascript">
//分页样式调整
$(function(){
	var pager = $('#arrange_dg').datagrid().datagrid('getPager');	
	pager.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});			
});


function queryArrange(){  
	$('#arrange_dg').datagrid({
		url:'${base}/arrange/pageData/1',
		queryParams:{
			FBudgetControlNum:$('#arr_query_code').textbox('getValue'),
			departName:$('#arr_query_department').textbox('getValue'),
			FBudgetYear:$('#arr_query_year').numberbox('getValue'),
			flowStatus:$('#arr_query_flowStatus').combobox('getValue')
		}
	});
}
function addArrange(){
	 var win=creatWin('新增-部门预算编制',840,450,'icon-search','/arrange/add');
	 win.window('open');
}
function editArrange(id){
	var win=creatWin('修改-部门预算编制',840,450,'icon-search','/arrange/edit/'+id);
	win.window('open');
}
function detailArrange(){
	var win=creatWin('查看-部门预算编制',840,450,'icon-search','/arrange/detail/'+id);
	win.window('open');
}
function deleteArrange(id){
	if(confirm("确认删除吗？")){
		$.ajax({ 
			type: 'POST', 
			url: '${base}/arrange/delete/'+id,
			dataType: 'json',  
			success: function(data){ 
				if(data.success){
					$.messager.alert('系统提示',data.info,'info');
					$("#arrange_dg").datagrid('reload');
				}else{
					$.messager.alert('系统提示',data.info,'error');
				}
			} 
		}); 
	}
}
//时间格式化
function dateformat_arrlist(val) {
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
function dateformat_arr_year(val){
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
function detailArrange(arrangeId){
	var win=creatWin('查看-预算控制数',840,450,'icon-search','/arrange/detail/'+arrangeId);
	win.window('open');
}
function operformat_arrlist(value, row, index){
	var menuType = $('#arrange_list_menuType').val(); 
	var btn = "";
	//查看
	var btn1 = "<a href='javascript:void(0)' style='color:blue' onclick='detailArrange("+row.fdcid+")'>"
				+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/select1.png'>"
				+ "</a>";
	//删除
	var btn2 = "<a href='javascript:void(0)' style='color:blue' onclick='deleteArrange("+row.fdcid+")'>"
				/* + "<img onmouseover='picVerdictOut(this)' onmouseout='picVerdictOver(this)' src='"+base+"/resource-modality/${themenurl}/verdict2.png'>" */
				+ "</a>";
	//修改
	var btn3 = "<a href='javascript:void(0)' style='color:blue' onclick='editArrange("+row.fdcid+")'>"
			+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/update1.png'>"
			+"</a>";
	//审批
	var btn4 = "<a href='javascript:void(0)' style='color:blue' onclick='approveArr("+row.fdcid+")'>"
	+ "<img onmouseover='arrApproveOver(this)' onmouseout='arrApproveOut(this)' src='"+base+"/resource-modality/${themenurl}/verdict2.png'>"
	+ "</a>";
	
	
	btn = btn1;
	if(row.flowStatus=='0' || row.flowStatus=='-1'){
		btn = btn + "    " + btn3;
	}
	if (menuType=='2') {
		btn = btn + "    " + btn4;
	}
	return btn ;
}
function approveArr(id){
	var win=creatWin('审批-部门预算编制',840,450,'icon-search','/arrange/approve/'+id);
	win.window('open');
}
function arrApproveOver(obj){
	obj.src=base+'/resource-modality/${themenurl}/verdict1.png';
}
function arrApproveOut(obj){
	obj.src=base+'/resource-modality/${themenurl}/verdict2.png';
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
function exportArrangeTz(){
	alert("导出数据！");
}
function format_arr_fflowStauts(val,row){
	if (val == 0) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</a>';
	} else if (val == 1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
	} else if (val == 2) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</a>';
	} else if (val == 3) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</a>';
	} else if (val == -1) {
		return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 已退回" + '</a>';
	}
}
</script>
</body>
</html>

