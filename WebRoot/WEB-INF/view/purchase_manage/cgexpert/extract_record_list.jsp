<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
 <html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />

</head>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>

	<div class="list-top">
		<table id="record_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<span style="padding:6px 0 6px 0;line-height:28px; ">&nbsp;&nbsp;&nbsp;&nbsp;抽取人：
					<input id="extract_user" name="fUserName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					<a href="#" onclick="method_record();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clear_record();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					</span>
				</td>
				<td align="right">
					<a href="#" onclick="addExtract()">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/cq1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	</div>
	
		<div style="height: 445px;">	
			<table id="extract_record" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/expertgl/recordList',
			method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr>
						<th data-options="field:'fExId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" width="8%">序号</th>
						<th data-options="field:'fUserName',align:'center'" width="20%">抽取人</th>
						<th data-options="field:'fRecTime',align:'center',formatter:ChangeDateFormatIndex" width="20%">抽取时间</th>
						<th data-options="field:'fNum',align:'center'" width="16%">抽取次数</th>
						<th data-options="field:'fFlag',align:'center',formatter:formatFlag" width="16%">抽取结果</th>
						<th data-options="field:'operation',align:'left',formatter:method_operation" width="20%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
</div>

<script type="text/javascript">

//点击查询
function method_record() {
	$('#extract_record').datagrid('load', {
		fUserName:$('#extract_user').val(),
	});
}
//清除查询条件
function clear_record() {
	$('#extract_user').textbox('setValue','');
	$('#extract_record').datagrid('load',{//清空以后，重新查一次
	});
}
//操作
function method_operation(val,row) {
	var str='<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
	'<a href="#" onclick="extract_record_detail(\'' + row.fResult + '\')" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		'</a></td>';
	return 	str+ '</tr></table>';
}
function extract_record_detail(val){
	var win=creatFirstWin('专家记录',800,620,' ','/expertgl/recordDetailJsp?idArr='+val);
	win.window('open');
}

//抽取结果
function formatFlag(val, row) {
	if (val == 1) {
		return '<a style="color:#666666;">' + " 成功" + '</a>';
	} else if (val ==2) {
		return '<a style="color:#666666;">' + " 失败" + '</a>';
	} 
}
//新增抽取
function addExtract(){
	var win=creatFirstWin('抽取-专家',800,620,' ','/expertgl/extractJsp');
	win.window('open');
}
</script>

</body>

</html>
