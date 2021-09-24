<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-td1">资产处置单号：</td> 
					<td class="top-table-td2">
						<input id="handle_fAssHandleCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">处置物资名称：</td> 
					<td class="top-table-td2">
						<input id="handle_fAssName" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">处置方式：</td> 
					<td class="top-table-td2">
						 <input id="handle_fHandleKind" name="" style="width: 150px;height:25px;" data-options="url:'${base}/Handle/lookupsJson?parentCode=CZFS',method:'POST',valueField:'code',textField:'text',editable:false" class="easyui-combobox"></input>
					</td>
					<td class="top-table-td1">申请时间：</td> 
					<td class="top-table-td2">
						<input id="handle_fReqTime" name="" style="width: 150px;height:25px;" class="easyui-datebox"></input>
					</td>
					<td style="width: 12px">
					</td>
					<td style="width: 24px;">
						<a href="javascript:void(0)"  onclick="handle_query();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
					<td style="width: 12px">
					</td>
					<td >
						<a href="javascript:void(0)"  onclick="handle_clearTable();"><img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"></a>
					</td>
					<td style="width: 12px">
					</td>
					<td align="right">
						<a href="#" onclick="handle_add()" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)" ></a>
					</td>
					<td style="width: 14px">
					</td>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
				
		</div>
		
		<div class="list-table">
			<table id="handle_application_dg" 
			data-options="collapsible:true,url:'${base}/Handle/applicationJson',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fId',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'fAssHandleCode',align:'left'" width="25%">资产处置单号（流水号）</th>
						<th data-options="field:'fAssName',align:'left',resizable:false,sortable:true" width="15%">处置物资名称</th>
						<th data-options="field:'fHandleKind',align:'left',formatter: CZFS" width="10%" >处置方式</th>
						<th data-options="field:'fHandleUser',align:'left',resizable:false,sortable:true" width="10%">处置人</th>
						<th data-options="field:'fReqTime',align:'left',formatter: ChangeDateFormat" width="15%" >申请时间</th>
						<th data-options="field:'fFlowStauts',align:'left',formatter:formatPrice,resizable:false,sortable:true" width="10%">审批状态</th>
						<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ" width="11%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	


<script type="text/javascript">
//分页样式调整
$(function(){
	var pager = $('#handle_application_dg').datagrid().datagrid('getPager');	// get the pager of datagrid
	pager.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});	
});
//清除查询条件
function handle_clearTable() {
	$('#handle_fAssHandleCode').textbox('setValue',null),
	$('#handle_fAssName').textbox('setValue',null),
	$('#handle_fReqTime').datebox('setValue',null),
	$('#handle_fHandleKind').textbox('setValue',null);
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
			return '便卖';
		}else if(val=='CZFS-03'){
			return '报损';
		}else if(val=='CZFS-04'){
			return '遗失';
		}else if(val=='CZFS-05'){
			return '非转经';
		}
	}
	function CZ(val, row) {
		if(fs==9){
			return '<a href="#" onclick="handle_detail(' + row.fId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>   '
		}
		if(fs==1){
			return '<a href="#" onclick="handle_detail(' + row.fId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>   '
		}
		return '<a href="#" onclick="handle_detail(' + row.fId
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>   '
				+'&nbsp;&nbsp;&nbsp;&nbsp;'+ '<a href="#" onclick="handle_update(' + row.fId
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">' + '</a>'
				+'&nbsp;&nbsp;&nbsp;&nbsp;'+'<a href="#" onclick="handle_delete(' + row.fId
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">' + '</a>';
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
	function handle_query() {
		$('#handle_application_dg').datagrid('load', {
			fAssHandleCode : $('#handle_fAssHandleCode').val(),
			fAssName : $('#handle_fAssName').val(),
			fReqTime : $('#handle_fReqTime').val(),
			fHandleKind : $('#handle_fHandleKind').val()
		});
	}
	function handle_add() {
		var win = creatWin('新增申请', 840, 450, 'icon-search',"/Handle/addApplication");
		win.window('open');
	}
	function handle_detail(id) {
			var win = creatWin('查看', 840, 450, 'icon-search',"/Handle/detail/" + id);
			win.window('open');
	}
	/* function editCF() {
		var row = $('#handle_application_dg').datagrid('getSelected');
		var selections = $('#handle_application_dg').datagrid('getSelections');
		if (row != null && selections.length == 1) {
			var win = creatWin(' ', 840, 450, 'icon-search',
					"/Storage/edit/" + row.fId);
			win.window('open');
		} else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
		}
	} */
	function handle_update(id) {
		//var row = $('#handle_application_dg').datagrid('getSelected');
		var win = creatWin('修改', 840, 450, 'icon-search',
				"/Handle/edit/" + id);
		win.window('open');
	}
	function handle_delete(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/Handle/delete/' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#handle_application_dg').form('clear');
						$('#handle_application_dg').datagrid('reload');
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
	//时间格式化
	function ChangeDateFormat(val) {
		//alert(val)
		var t, y, m, d, h, i, s;
		if (val == null) {
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
		return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
	}
	//在线帮助
	function helpDemo() {
		window.open("./resource/onlinehelp/zzzx/demo/help.html");
	}
	function test(val) {
		alert('test')
	}
	function formatOper(value, row, index) {
		return 'sfsdf';
		//return '<a href="#" onclick="test('+index+')">修改</a>';  
		//    return '<a href="javascript:void(0);" onclick="openviewzfrw(\''+row.person+'\',\''+row.data_status+'\')"><font color="blue">走访</font></a>'; 
	}
</script>
</body>
</html>

