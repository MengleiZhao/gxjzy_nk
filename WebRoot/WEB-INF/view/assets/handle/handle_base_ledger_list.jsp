<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-search">处置单号&nbsp;
						<input id="handle_fixed_fAssHandleCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;申请部门&nbsp;
						<input id="handle_fixed_fRecDept" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;申请人&nbsp;
						<input id="handle_fixed_fReqUser" name="" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="queryFixedStorage();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')">
						</a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="reg_fixed_clearTable();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')">
						</a>
					</td>
					<%-- <td align="right" style="padding-right: 10px">
						<a href="#" onclick="reg_fixed_add()" >
							<img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)" >
						</a>
					</td> --%>
					
					<%-- <td class="top-table-td1">处置物资编号：</td> 
					<td class="top-table-td2">
						<input id="handle_fixed_fAssHandleCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">处置资产名称：</td> 
					<td class="top-table-td2">
						<input id="handle_fixed_fAssName" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">处置方式：</td> 
					<td class="top-table-td2">
						 <input id="handle_fixed_fHandleKind" name="" style="width: 150px;height:25px;" data-options="url:'${base}/Handle/lookupsJson?parentCode=CZFS',method:'POST',valueField:'code',textField:'text',editable:false" class="easyui-combobox"></input>
					</td>
					<td class="top-table-td1">申请日期：</td> 
					<td class="top-table-td2">
						<input id="handle_fixed_fReqTime" name="" style="width: 150px;height:25px;" class="easyui-datebox"></input>
					</td>
					<td style="width: 12px">
					</td>
					<td style="width: 24px;">
						<a href="javascript:void(0)"  onclick="queryFixedStorage();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
					<td style="width: 12px">
					</td>
					<td >
						<a href="javascript:void(0)"  onclick="reg_fixed_clearTable();"><img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"></a>
					</td>
					<td style="width: 12px">
					</td>
					<td align="right">
						<a href="#" onclick="reg_fixed_add()" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)" ></a>
					</td>
					<td style="width: 14px">
					</td> --%>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
				
		</div>
		
		<div style="margin: 0 10px 0 10px;height: 420px;" >
			<table id="handle_base_ledger_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Handle/ledgerJson?fAssType.code=ZCLX-02',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fId',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'fAssHandleCode',align:'center'" width="21%">处置单单号</th>
						<th data-options="field:'fRecDept',align:'center',resizable:false,sortable:true" width="20%">申请部门</th>
						<th data-options="field:'fReqUser',align:'center',resizable:false,sortable:true" width="15%">申请人</th>
						<th data-options="field:'fReqTime',align:'center',formatter: ChangeDateFormat" width="20%" >申请日期</th>
						<th data-options="field:'fFlowStauts',align:'center',formatter:formatPrice,resizable:false,sortable:true" width="10%">审批状态</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" width="10%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	


<script type="text/javascript">
//清除查询条件
function reg_fixed_clearTable() {
	$('#handle_fixed_fAssHandleCode').textbox('setValue',null),
	$('#handle_fixed_fReqUser').textbox('setValue',null),
	$('#handle_fixed_fRecDept').textbox('setValue',null),
	queryFixedStorage();
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
function CheckYou() {
	var flag = true;
	var regu = "^[a-zA-Z\u4e00-\u9fa5]+$";
	 if(!regu.test($('#"allcoa_fAssCode_R"').val()) && flag == true){
	    	alert("请输入中文或英文！");
	    	flag = false;
	    } 	
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
function CZFS(val, row) {
	if(val=='CZFS-01'){
		return '报废';
	}else if(val=='CZFS-02'){
		return '变卖';
	}else if(val=='CZFS-03'){
		return '报损';
	}else if(val=='CZFS-04'){
		return '遗失';
	}else if(val=='CZFS-05'){
		return '非转经';
	}
}
function CZ(val, row) {
	if(fs==9||fs==1){
		return '<table><tr style="width: 105px;height:20px"><td style="width: 25px">'
				+'<a href="#" onclick="reg_fixed_detail(' + row.fId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>   '
				+'</td></tr></table>';
	}else {
		return '<table><tr style="width: 105px;height:20px"><td style="width: 25px">'
				+'<a href="#" onclick="reg_fixed_detail(' + row.fId
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
				+'</td><td style="width: 25px">'
				+ '<a href="#" onclick="reg_fixed_update(' + row.fId
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">' + '</a>'
				+'</td><td style="width: 25px">'
				+'<a href="#" onclick="reg_fixed_delete(' + row.fId
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">' + '</a>'
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
function queryFixedStorage() {
	$('#handle_base_ledger_dg').datagrid('load', {
		fAssHandleCode : $('#handle_fixed_fAssHandleCode').val(),
		fReqUser : $('#handle_fixed_fReqUser').val(),
		fRecDept : $('#handle_fixed_fRecDept').val()
	});
}
function reg_fixed_add() {
	var win = creatWin('资产处置申请', 970,580, 'icon-search',"/Handle/addApplication?fAssType=ZCLX-02");
	win.window('open');
}
function reg_fixed_detail(id) {
		var win = creatWin('资产处置明细', 970,580, 'icon-search',"/Handle/detail/" + id);
		win.window('open');
}
function reg_fixed_update(id) {
	//var row = $('#handle_base_ledger_dg').datagrid('getSelected');
	var win = creatWin('资产处置-修改', 970,580, 'icon-search',
			"/Handle/edit/" + id);
	win.window('open');
}
function reg_fixed_delete(id) {
	if (confirm("确认删除吗？")) {
		$.ajax({
			type : 'POST',
			url : '${base}/Handle/delete/' + id,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					$.messager.alert('系统提示', data.info, 'info');
					$('#handle_base_ledger_dg').form('clear');
					$('#handle_base_ledger_dg').datagrid('reload');
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

