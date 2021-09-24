<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<!-- <style type="text/css">
.datagrid-btable{
	width:100%;
}
</style> -->
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-td1">地区（城市）：</td> 
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
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
		</div>
		
		<div class="list-table" >
			<table id="hotestd_choose_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/hotelStandard/pageList?outType=travel',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'id',hidden:true"></th>
						<th data-options="field:'pageOrder',align:'center'" width="15%">序号</th>
						<th data-options="field:'area',align:'center'" width="85%">地区（城市）</th>
					</tr>
				</thead>
			</table>
		</div>
</div>	


<script type="text/javascript">

$(function(){
	initDg_hotel_add();
});

//初始化datagrid点击事件
function initDg_hotel_add(){
	$('#hotestd_choose_dg').datagrid({
		onDblClickRow:function(index,row){
			$('#travel_add_placeEnd_id').textbox('setValue',row.id);
			$('#travel_add_placeEnd').textbox('setValue',row.area);
			closeFirstWindow();
		}
	});
}

//清除查询条件
function clearTable_hstd() {
	$('#htsd_area').textbox('setValue',null);
	query_hstd();
}


function query_hstd() {
	var area = $('#htsd_area').textbox('getValue');
	$('#hotestd_choose_dg').datagrid('load', {
		area : area
	});
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

