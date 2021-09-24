<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr >
					<td class="top-table-search" class="queryth">资产编号&nbsp;
						<input id="alloca_choose_fAssCodeR" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;资产编号&nbsp;
						<input id="alloca_choose_fAssNameR" name=""  style="width: 150px;height:25px;"  class="easyui-textbox"></input>
						<!-- &nbsp;&nbsp;申请日期&nbsp;
						<input id="storage_fixed_fPurchaseDateStart" name="" style="width: 150px;height:25px;" class="easyui-datebox" editable="false"></input>
						&nbsp;-&nbsp;
						<input id="storage_fixed_fPurchaseDateEnd" name="" style="width: 150px;height:25px;" class="easyui-datebox" editable="false"></input> -->
						&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="alloca_choose_fixed_query();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="alloca_choose_fixed_clearTable();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="alloca_choose_fixed_save();">
							<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					 
					</td>
					<%-- <td align="right" style="padding-right: 10px">
						<a href="#" onclick="storage_fixed_add()" >
							<img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td> --%>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
		</div>
		
		<div class="list-table">
			<table id="alloca_chooose_fixed_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Storage/allJsonPagination',
			method:'post',fit:true,pagination:true,singleSelect:false,
			selectOnCheck: false,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'fId_S',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'fAssCodeR',align:'center'" width="15%">资产编号</th>
						<th data-options="field:'fAssNameR',align:'center',resizable:false,sortable:true" width="15%">资产名称</th>
						<th data-options="field:'fmMode',align:'center',resizable:false,sortable:true" width="10%">型号</th>
						<th data-options="field:'fmSpecif',align:'center',resizable:false,sortable:true" width="10%">规格</th>
						<th data-options="field:'fMeasUnitR',align:'center',resizable:false,sortable:true" width="10%">计量单位</th>
						<th data-options="field:'fInsNumR',align:'center',resizable:false,sortable:true" width="10%">数量</th>
						<th data-options="field:'fSignPrice',align:'center',resizable:false,sortable:true" width="10%">单价(元)</th>
						<th data-options="field:'fAmount',align:'center',resizable:false,sortable:true" width="15%">金额(元)</th>
						<!-- <th data-options="field:'fReqTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" width="15%">申请时间</th>
						<th data-options="field:'fFlowStatus',align:'center',formatter: formatPrice" width="10%" >审批状态</th>
						<th data-options="field:'fRemark_S',align:'left',resizable:false,sortable:true" width="20%">备注</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" width="10%">操作</th> -->
					</tr>
				</thead>
			</table>
		</div>
	</div>
	


<script type="text/javascript">
//保存数据到
function alloca_choose_fixed_save(){
	var rows = $('#alloca_chooose_fixed_dg').datagrid('getSelections');
	//console.log(rows);
	for (var i = 0; i < rows.length; i++) {
		$('#alloca_add_plan').datagrid('appendRow',{
			fAssCode:rows[i].fAssCodeR,//编号
			fAssName:rows[i].fAssNameR,//名称
			fSpecification:rows[i].fmSpecif,//规格
			fModel:rows[i].fmMode,//型号
			fMeasUnit:rows[i].fMeasUnitR,//计量单位
			fAssNum:rows[i].fInsNumR,//数量
			fSignPrice:rows[i].fSignPrice,//单价
			fAmount:rows[i].fAmount,//金额
		});
	}
	closeFirstWindow();
}

$("#storage_fixed_fPurchaseDateStart").datebox({
    onSelect : function(beginDate){
        $('#storage_fixed_fPurchaseDateEnd').datebox().datebox('calendar').calendar({
            validator: function(date){
                return beginDate <= date;
            }
        });
    }
});
//清除查询条件
function alloca_choose_fixed_clearTable() {
	$('#alloca_choose_fAssCodeR').textbox('setValue',null),
	$('#alloca_choose_fAssNameR').textbox('setValue',null),
	$('#storage_fixed_fPurchaseDateStart').datebox('setValue',null),
	$('#storage_fixed_fPurchaseDateEnd').datebox('setValue',null);
	alloca_choose_fixed_query();
}
//鼠标移入图片替换
function mouseOver(img){
	var src = $(img).attr("src");
	src = src.replace(/1/, "2");
	$(img).attr("src",src);
}
	
function mouseOut(img) {
	var src = $(img).attr("src");
	src = src.replace(/2/, "1");
	$(img).attr("src",src);
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
	if(row.fFlowStatus==0||row.fFlowStatus==-1){
		return 	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'
				+'<a href="#" onclick="storage_fixed_detail(' + row.fId_S+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
				+'</td><td style="width: 25px">'
				+'<a href="#" onclick="storage_fixed_update(' + row.fId_S
				+ ')" class="easyui-linkbutton"><img <img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">' + '</a>'
				+'</td><td style="width: 25px">'
				+'<a href="#" onclick="storage_fixed_delete(' + row.fId_S
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">' + '</a>'
				+'</td></tr></table>';
	}else {
		return 	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'
				+'</td><td style="width: 25px">'
				+'<a href="#" onclick="storage_fixed_detail(' + row.fId_S+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
				+ '</a>'
				+'</td></tr></table>';
	}
	
}
function showB(obj){
	obj.src=base+'/resource-modality/${themenurl}/select2.png';
}
function showA(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
}
function showC(obj){
	obj.src=base+'/resource-modality/${themenurl}/update2.png';
}
function showD(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/update1.png';
}
function showE(obj){
	obj.src=base+'/resource-modality/${themenurl}/delete2.png';
}
function showF(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/delete1.png';
}
/* $(function() {
	//定义双击事件
	$('#alloca_chooose_fixed_dg').datagrid({
		onDblClickRow : function(rowIndex, rowData) {
			detailDemo();
		}
	});
}); */
function alloca_choose_fixed_query() {
	$('#alloca_chooose_fixed_dg').datagrid('load', {
		fAssCodeR : $('#alloca_choose_fAssCodeR').val(),
		fAssNameR : $('#alloca_choose_fAssNameR').val(),
		/* fPurchaseDateStart : $('#storage_fixed_fPurchaseDateStart').val(),
		fPurchaseDateEnd : $('#storage_fixed_fPurchaseDateEnd').val() */
	});
}
function storage_fixed_add() {
	var node = $('#alloca_chooose_fixed_dg').datagrid('getSelected');
	var win = creatWin('资产申请', 970,580, 'icon-search', '/Storage/fixedadd');
	if (null != node) {
		win = creatWin('资产申请', 970,580, 'icon-search',
				'/Storage/fixedadd');
	}
	win.window('open');
}
function storage_fixed_detail(id) {
		var win = creatWin('资产明细', 970 ,580, 'icon-search',"/Storage/detail/" + id);
		win.window('open');
}
/* function editCF() {
	var row = $('#alloca_chooose_fixed_dg').datagrid('getSelected');
	var selections = $('#alloca_chooose_fixed_dg').datagrid('getSelections');
	if (row != null && selections.length == 1) {
		var win = creatWin(' ', 970,580, 'icon-search',
				"/Storage/edit/" + row.fcId);
		win.window('open');
	} else {
		$.messager.alert('系统提示', '请选择一条数据！', 'info');
	}
} */
function storage_fixed_update(id) {
	//var row = $('#alloca_chooose_fixed_dg').datagrid('getSelected');
	var selections = $('#alloca_chooose_fixed_dg').datagrid('getSelections');
	var win = creatWin('资产-修改', 970, 580, 'icon-search',
			"/Storage/edit/" + id);
	win.window('open');
}
function storage_fixed_delete(id) {
	if (confirm("确认删除吗？")) {
		$.ajax({
			type : 'POST',
			url : '${base}/Storage/delete/' + id,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$('#CFAddEditForm').form('clear');
					$("#alloca_chooose_fixed_dg").datagrid('reload');
				} else {
					$.messager.alert('系统提示', data.info, 'error');
				}
			}
		});
	}
}
function expListlawHelp() {
	//var win=creatWin('导出-法律服务接待登记表',400,120,'icon-search','/demo/exportList');
	//win.window('open');
	if (confirm("按当前查询条件导出？")) {
		var queryForm = document.getElementById("lawHelp_list_form");
		queryForm.setAttribute("action", "${base}/demo/expList");
		queryForm.submit();
	}
}
</script>
</body>
</html>

