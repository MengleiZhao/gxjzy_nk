<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
 <html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />

</head>
<body style="background-color: #f0f5f7;text-align: center;">	
<%-- <link rel="stylesheet" type="text/css" href="${base}/resource-modality/css/fSelect.css">
<script type="text/javascript" src="${base}/resource-now/js/fSelect.js"></script> --%>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>

	<div class="list-top">
		<table id="white_EXP_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search">专家编号&nbsp;
					<input id="expert_white_fexpertCode" name="fexpertCode" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;专家名称
					<input id="expert_white_fexpertName" name="fexpertName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					<a href="#" onclick="search_extract();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					<a href="#" onclick="clear_extract();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td>
			</tr>
		</table>
	</div>
	
		<div style="height: 445px;">	
			<table id="expert_extract" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/expertgl/recordDetailList?idArr=${idArr }',
			method:'post',fit:true,pagination:false,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:true,striped: true,fitColumns: true">
				<thead>
					<tr>
						<th data-options="field:'feId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" width="5%">序号</th>
						<th data-options="field:'fexpertCode',align:'center',formatter:formatCellTooltip" width="20%">专家编号</th>
						<th data-options="field:'fexpertName',align:'center',formatter:formatCellTooltip" width="10%">专家名称</th>
						<th data-options="field:'fnowWork',align:'center',formatter:formatCellTooltip" width="12%">现从事专业</th>
						<th data-options="field:'fmTel',align:'center',formatter:formatCellTooltip" width="12%">联系手机</th>
						<th data-options="field:'ffield',align:'center',formatter:formatCellTooltip" width="18%">业务领域</th>
						<th data-options="field:'fbirthday',align:'center',resizable:false,sortable:true,formatter:formatAge" width="6%">年龄</th>
						<th data-options="field:'fexpertSex',align:'center',resizable:false,sortable:true,formatter:formatSex" width="6%">性别</th>
						<th data-options="field:'operation',align:'left',formatter:method_operation" width="9%">操作</th>
				</tr>
				</thead>
			</table>
		</div>

		<div class="win-left-bottom-div">
			<a href="javascript:void(0)" onclick="closeFirstWindow()">
			<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
		</div>
</div>


<script type="text/javascript">
//点击查询
function search_extract() {
	$('#expert_extract').datagrid('load', {
		fexpertCode:$('#expert_white_fexpertCode').val(),
		fexpertName:$('#expert_white_fexpertName').val(),
	});
}
//清除查询条件
function clear_extract() {
	$("#expert_white_fexpertCode").textbox('setValue','');
	$("#expert_white_fexpertName").textbox('setValue','');
	$('#expert_extract').datagrid('load',{//清空以后，重新查一次
	});
}

function method_operation(val,row) {
	var checkType=row.fcheckType;
	if(row.fcheckType=="in" && row.fcheckStauts==9 && row.fisOutStatus!=9 && row.fisOutStatus!=0 && row.fisOutStatus!=-1){
		checkType="out";
	}
	var str='<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
	'<a href="#" onclick="expert_detail_lend(' + row.feId + ',\''+checkType+'\')" class="easyui-linkbutton">'+
		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
		'</a></td>';
	return 	str+ '</tr></table>';
}
//查看
function expert_detail_lend(id,checkType) {
	var win = creatWin(' ', 970, 580, 'icon-search',"/expertgl/detail?checkType="+checkType+"&id=" + id);
	win.window('open'); 
} 
//性别
function formatSex(val, row) {
	if (val == 0) {
		return '<a style="color:#666666;">' + " 男" + '</a>';
	} else if (val ==1) {
		return '<a style="color:#666666;">' + "女" + '</a>';
	} 
}
//年龄
function formatAge(val, row) {
	 //出生时间 毫秒
    var birthDayTime = new Date(val).getTime();
    //当前时间 毫秒
    var nowTime = new Date().getTime();
    //一年毫秒数(365 * 86400000 = 31536000000)
    return Math.ceil((nowTime-birthDayTime)/31536000000);
}
</script>

</body>

</html>
