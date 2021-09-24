<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-td1">地区（城市）</td> 
					<td class="top-table-td2">
						<input id="htsd_area"  style="width: 150px;height:25px;" class="easyui-textbox"/>
					</td>
					<td style="width: 30px;"></td>
					<td style="width: 26px;">
						<a href="javascript:void(0)"  onclick="query_hstd();"><img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
					<td style="width: 8px;"></td>
					<td>
						<a href="javascript:void(0)"  onclick="clearTable_hstd();"><img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"></a>
					</td>
					<td style="width: 8px;"></td>
					
					<td align="right" style="padding-right: 10px">
						<a href="#" onclick="add_hstd()" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
					</td>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
		</div>
		<div class="list-table">
			<table id="hotestd_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/hotelStandard/pageList?outType=travel',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'id',hidden:true"></th>
						<th data-options="field:'pageOrder',align:'center'" width="5%">序号</th>
						<th data-options="field:'area',align:'center'" width="10%">地区（城市）</th>
						<th data-options="field:'normalPriceMax',align:'right'" width="11%">住宿费标准（市级）</th>
						<th data-options="field:'normalPriceMid',align:'right',resizable:false,sortable:true" width="12%">住宿费标准（局级）</th>
						<th data-options="field:'normalPriceMin',align:'right',resizable:false,sortable:true" width="15%">住宿费标准（其他人员）</th>
						<th data-options="field:'busyDateStart',align:'center',resizable:false,sortable:true,formatter:format_strToDate" width="13%">旺季期间（开始）</th>
						<th data-options="field:'busyDateEnd',align:'center',resizable:false,sortable:true,formatter:format_strToDate" width="14%">旺季期间（结束）</th>
						<th data-options="field:'busyRate',align:'center',resizable:false,sortable:true,formatter:format_wjsfbl" width="11%">旺季上浮比例（%）</th>
						<th data-options="field:'operation',align:'center',resizable:false,sortable:true,formatter:hotelstdOpe" width="10%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
</div>	
<script type="text/javascript">

//清除查询条件
function clearTable_hstd() {
	$('#htsd_area').textbox('setValue',null);
	query_hstd();
}

//TODO
function hotelstdOpe(val, row) {
	return 	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="detail_hstd(' + row.id+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
			+'</td><td style="width: 25px">'+ '<a href="#" onclick="update_hstd(' + row.id
			+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">' + '</a>'
			+'</td><td style="width: 25px">'+'<a href="#" onclick="delete_hstd(' + row.id
			+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">' + '</a>'
			+'</td></tr></table>';
}

function query_hstd() {
	var area = $('#htsd_area').textbox('getValue');
	$('#hotestd_dg').datagrid('load', {
		travel_area : area
	});
}

function add_hstd() {

	var win = creatWin('新增', 705, 580, 'icon-search', '/hotelStandard/add?outType=travel');
	win.window('open');
}

function detail_hstd(id) {
		var win = creatWin('查看', 705, 580, 'icon-search',"/hotelStandard/detail/" + id + "?outType=travel");
		win.window('open');
}

function update_hstd(id) {
	//var row = $('#hotestd_dg').datagrid('getSelected');
	var win = creatWin('修改', 705, 580, 'icon-search',"/hotelStandard/edit/" + id + "?outType=travel");
	win.window('open');
}

function delete_hstd(id) {
	if (confirm("确认删除吗？")) {
		$.ajax({
			type : 'POST',
			url : '${base}/hotelStandard/delete/' + id + '?outType=travel',
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$('#hotestd_dg').datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
}

function format_strToDate(value){
	if (value != null) {
		var date = new Date(value);
		var y = date.getFullYear();
		var m = date.getMonth()+1;
		var d = date.getDate();
		return (m<10?('0'+m):m)+'-'+(d<10?('0'+d):d); 
		//return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d); 
	} else {
		return '无';
	}
}

function format_wjsfbl(value){
	if (value=='' || value==null) {
		return '无';
	} else {
		return value;
	}
}


</script>
</body>

