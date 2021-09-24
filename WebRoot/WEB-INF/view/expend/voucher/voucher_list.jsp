<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-search">凭证号&nbsp;
						<input id="v_fVoucher" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;摘要&nbsp;
						<input id="v_fVoucherSummary" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
						<!-- &nbsp;&nbsp;合同金额&nbsp;
						<input id="c_cAmountBegin"  name="" style="width: 150px;height:25px;" data-options="icons: [{iconCls:'icon-wanyuan'}],precision:2" validType="numberBegin[c_cAmountEnd]" class="easyui-numberbox"></input>
						&nbsp;-&nbsp;
						<input id="c_cAmountEnd" name="" style="width: 150px;height:25px;" data-options="icons: [{iconCls:'icon-wanyuan'}],precision:2" class="easyui-numberbox"></input>
						&nbsp;&nbsp; -->
						<a href="javascript:void(0)"  onclick="queryCF();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="clearTable();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"></a>
					</td> 
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
		</div>
		<div class="list-table">
			<table id="CF_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Voucher/JsonPagination',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<!-- <th data-options="field:'ck',checkbox:true"></th> -->
						<th data-options="field:'number',align:'center',resizable:false,sortable:true" width="5%">序号</th>
						<th data-options="field:'fVoucher',align:'left',resizable:false,sortable:true" width="25%">凭证号</th>
						<th data-options="field:'fVoucherSummary',align:'left',resizable:false,sortable:true" width="35%">摘要</th>
						<th data-options="field:'createTime',align:'left',formatter: ChangeDateFormat,resizable:false,sortable:true" width="20%" >生成日期</th>
						<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ" width="15%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
</div>	


<script type="text/javascript">
//清除查询条件
function clearTable() {
	$('#v_fVoucher').textbox('setValue',null);
	$('#v_fVoucherSummary').textbox('setValue',null);
	queryCF();
}
var fs
function formatPrice(val, row) {
	fs=val;
	if (val == 0) {
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + " 暂存" + '</span>';
	} else if (val == 1) {
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">' + " 待审批" + '</span>';
	}else if (val == 9) {
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已审批" + '</span>';
	}else if (val == 99) {
		return '<span style="color:#666666;">' + " 已删除" + '</span>';
	} else if (val == -1) {
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已退回" + '</span>';
	}
}
function CZ(val, row) {
	return 	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="detail(' + row.fid+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
			+'</td></tr></table>';
}
function queryCF() {
	$('#CF_dg').datagrid('load', {
		fVoucher : $('#v_fVoucher').val(),
		fVoucherSummary : $('#v_fVoucherSummary').val(),
	});
}
function detail(id) {
		var win = creatWin('查看', 970, 580, 'icon-search',"/Voucher/detail/" + id);
		win.window('open');
}
function exportFile(id) {
	/* var row = $('#CF_dg').datagrid('getSelected');
	var selections = $('#CF_dg').datagrid('getSelections'); */
	var win = creatWin('合同拟定申请', 970, 580, 'icon-search',"/Vouchern/exportFile/" + id);
	win.window('open');
	$.ajax({
		type:"post",
		url : "/Vouchern/exportFile/" + id,
		dataType: "json",
		success : function(data) {
			
		}
		
		
	})
	
}
</script>
</body>

