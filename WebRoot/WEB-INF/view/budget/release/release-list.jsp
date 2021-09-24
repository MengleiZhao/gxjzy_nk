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
					<td width="130px" height="25px" class="queryth">
						指标下达编号：
					</td>
					<td width="100px">
						<input id="jbzb_query_code" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					
					<td width="80px" height="25px" class="queryth">
						指标名称：
					</td>
					<td width="140px">
						<input id="jbzb_query_name" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					
					<td width="70px" height="25px" class="queryth">
						年度：
					</td>
					<td width="140px">
						<input id="jbzb_query_year" style="width: 150px;height:25px;" class="easyui-numberbox"
						 ></input>
					</td>
					
					<td width="70px" height="25px" class="queryth">
						操作人：
					</td>
					<td width="140px">
						<input id="jbzb_query_person" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					
					<td style="width: 24px;">
						<a href="javascript:void(0)" onclick="queryJbzb();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png"
								onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"
							/>
						</a>
					</td>
					<td >
						<a href="#" onclick="clearJbzb();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" 
								onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"
							/>
						</a>
					</td>
					
					<%-- <td align="right" >
						<a href="#" onclick="addJbzb()">
							<img src="${base}/resource-modality/${themenurl}/button/xz1.png"
								onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/skin_/xz2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/xz1.png')"
							/>
						</a>
					</td> --%>
				</tr>
			</table>           
		</div>
		
		
		
		<div style="margin: 0 10px 0 10px;height: 700px;" >
			
			<table id="jbzb_dg" class="easyui-datagrid" 
			data-options="collapsible:true,url:'${base}/release/pageData',
			method:'post',fit:true,pagination:true,singleSelect: true,striped: true,
			selectOnCheck: true">
				<thead>
					<tr>
						<th data-options="field:'id',hidden:true"></th>
						<th data-options="field:'pageOrder',align:'center'" width="5%">序号</th>
						<th data-options="field:'year',align:'center'" width="5%">年度</th>
						<th data-options="field:'amount',align:'center'" width="10%">批复总额（万元）</th>
						<th data-options="field:'status',align:'center',formatter:format_release_xdzt" width="10%">下达状态</th>
						<th data-options="field:'process',align:'center',formatter:format_relaease_xdjd" width="10%">下达进度（万元）</th>
						<th data-options="field:'operation',align:'center',formatter:operformat_jbzblist" width="6%">操作</th>
						
					</tr>
				</thead>
			</table>
		</div>
		<div region="south" border="false">
		
		</div>


<script type="text/javascript">
//分页样式调整
$(function(){
	var pager = $('#jbzb_dg').datagrid().datagrid('getPager');	
	pager.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});			
});


function queryJbzb(){  
	$('#jbzb_dg').datagrid({
		url:'${base}/basicRelease/pageData',
		queryParams:{
			//编号 名称 年度 操作人
			code:$('#jbzb_query_code').textbox('getValue'),
			name:$('#jbzb_query_name').textbox('getValue'),
			year:$('#jbzb_query_year').numberbox('getValue'),
			person:$('#jbzb_query_person').textbox('getValue')
		}
	});
}
function clearJbzb(){
	$('#jbzb_query_code').textbox('');
	$('#jbzb_query_name').textbox('');
	$('#jbzb_query_year').numberbox('');
	$('#jbzb_query_person').textbox('');
	queryJbzb();
}
function addJbzb(id){
	 var win=creatWin('新增-基本支出指标下达',840,450,'icon-search','/release/add/'+id);
	 win.window('open');
}
function editJbzb(id){
	var win=creatWin('修改-基本支出指标下达',840,450,'icon-search','/release/edit/'+id);
	win.window('open');
}
function detailJbzb(){
	var win=creatWin('查看-基本支出指标下达',840,450,'icon-search','/release/detail/'+id);
	win.window('open');
}
function deleteJbzb(id){
	if(confirm("确认删除吗？")){
		$.ajax({ 
			type: 'POST', 
			url: '${base}/basicRelease/delete/'+id,
			dataType: 'json',  
			success: function(data){ 
				if(data.success){
					$.messager.alert('系统提示',data.info,'info');
					$("#jbzb_dg").datagrid('reload');
				}else{
					$.messager.alert('系统提示',data.info,'error');
				}
			} 
		}); 
	}
}
//时间格式化
function dateformat_ymd(val) {
	//alert(val)
    var t, y, m, d, h, i, s;
    if(val==null){
  	  return "";
    }
    t = new Date(val);
    y = t.getFullYear();
    m = t.getMonth() + 1;
    d = t.getDate();
    // 可根据需要在这里定义时间格式  
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) ;
}
function detailJbzb(id){
	var win=creatWin('查看-预算控制数',840,450,'icon-search','/basicRelease/detail/'+id);
	win.window('open');
}
function operformat_jbzblist(value, row, index){
	var btn = "<table><tr style='width: 105px; height:20px'>";//操作按钮
	var status = row.status;//下达状态
	//查看
	var btn1 =    "<td style='width:25px'>"
				+ "<a href='javascript:void(0)' style='color:blue' onclick='detailJbzb("+row.pid+")'>"
				+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/select1.png'>"
				+ "</a>"
				+ "</td>";
	//删除
	var btn2 =    "<td style='width:15px'>"
				+ "<a href='javascript:void(0)' style='color:blue' onclick='deleteJbzb("+row.pid+")'>"
				/* + "<img onmouseover='picVerdictOut(this)' onmouseout='picVerdictOver(this)' src='"+base+"/resource-modality/${themenurl}/verdict2.png'>" */
				+ "</a>"
				+ "</td>";
	//新增
	var btn3 =
			  "<td style='width:15px'>"
			+ "<a href='javascript:void(0)' style='color:blue' onclick='addJbzb("+row.pid+")'>"
			+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/update1.png'>"
			+ "</a>"
			+ "</td>";
	//修改
	var btn4 =
			  "<td style='width:15px'>"
			+ "<a href='javascript:void(0)' style='color:blue' onclick='editJbzb("+row.pid+")'>"
			+ "<img onmouseover='listMouseOver(this)' onmouseout='listMouseOut(this)' src='"+base+"/resource-modality/${themenurl}/list/update1.png'>"
			+ "</a>"
			+ "</td>";
	
	btn = btn + btn1 + btn2 ;
	if (status!=1 && status!=2) {//如果是未下达，则使用新增按钮
		btn = btn + btn3;
	} else {
		btn = btn + btn3;
	}
	btn = btn + "</tr></table>";
	return btn ;
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
function format_release_xdzt(val, row){
	if (val == '0') {
		return '未下达';
	} else if (val == '1') {
		return '下达中';
	} else if (val == '2') {
		return '已下达';
	}
	return '';
}
function format_relaease_xdjd(val, row){
	return val;
}
</script>
</body>
</html>

