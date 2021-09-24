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
	<div style="height: 10px;background-color:#f0f5f7 "></div>	
		<div class="tabletop" >
		<table class="topTable" style="width: 100%;font-size: 12px;height: 40px;">
				<tr>
					<td width="90px" class="queryth">费用类型：</td> 
					<td style="width: 140px">
						<input id="expenditure_tEbName1" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td width="90px" class="queryth">费用类型代码：</td> 
					<td style="width: 140px">
						<input id="expenditure_tEbCode1" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td style="width: 24px;">
						<a href="javascript:void(0)"  onclick="queryPM1();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
					<td style="width: 12px">
					</td>
					<td>
						<a href="javascript:void(0)"  onclick="clearTable1();"><img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"></a>
					</td>
					<td style="width: 12px">
					</td>
					<td align="right">
						<a href="#"   onclick="addExpenditure1()" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/skin_/xz2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/xz1.png')"></a>
					</td>
					<td style="width: 14px">
					</td>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
		</div>
		
		<div style="margin: 0 10px 0 10px;height: 220px;" >
			<table id="expenditure_dg1"
			data-options="singleSelect:true,collapsible:true,url:'${base}/ExpenditureBaseic/expenditureList1',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'tEbId',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'tEbName1',align:'left'" width="35%">费用类型（名称）</th>
						<th data-options="field:'tEbCode1',align:'left',resizable:false,sortable:true" width="35%">费用类型代码</th>
						<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ1" width="25%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
		
		<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="tabletop" >
		<table class="topTable" style="width: 100%;font-size: 12px;height: 40px;">
				<tr>
					<td width="90px" class="queryth">明细科目：</td> 
					<td style="width: 140px">
						<input id="expenditure_tEbName2" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td width="90px" class="queryth">费用类型代码：</td> 
					<td style="width: 140px">
						<input id="expenditure_tEbCode2" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td style="width: 24px;">
						<a href="javascript:void(0)"  onclick="queryPM2();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
					<td style="width: 12px">
					</td>
					<td>
						<a href="javascript:void(0)"  onclick="clearTable2();"><img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"></a>
					</td>
					<td style="width: 12px">
					</td>
					<td align="right">
						<a href="#"   onclick="addExpenditure2()" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/skin_/xz2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/xz1.png')"></a>
					</td>
					<td style="width: 14px">
					</td>
				</tr>
				<tr id="helpTr" style="display: none;">
				</tr>
			</table>           
		</div>
		
		<div style="margin: 0 10px 0 10px;height: 220px;" >
			<table id="expenditure_dg2" class="easyui-datagrid"
			data-options="singleSelect:true,collapsible:true,url:'${base}/ExpenditureBaseic/expenditureList2',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'tEbId2',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'tEbName2',align:'left'" width="20%">费用类型（名称）</th>
						<th data-options="field:'tEbCode2',align:'left',resizable:false,sortable:true" width="20%">费用类型代码</th>
						<th data-options="field:'tEbDirections',align:'left',resizable:false,sortable:true" width="20%">费用说明</th>
						<th data-options="field:'tEbRemark',align:'left',resizable:false,sortable:true" width="20%">备注</th>
						<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ2" width="15%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	


<script type="text/javascript">
$(function(){
	//分页样式调整
	var pager1 = $('#expenditure_dg1').datagrid().datagrid('getPager');	// get the pager of datagrid
	pager1.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});			
	var pager2 = $('#expenditure_dg2').datagrid().datagrid('getPager');	// get the pager of datagrid
	pager2.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});			
	$('#expenditure_dg1').datagrid({
		onClickRow: function(rowIndex,rowData){
			$('#expenditure_fFunctionClass').textbox('setValue',null);
			$('#expenditure_dg2').datagrid('load', {
				tEbName2 : $('#expenditure_tEbName2').val(),
				tEbCode2 : $('#expenditure_tEbCode2').val(),
				tEbIdTemp : rowData.tEbId,
			});
		}
	});
});
//清除查询条件
function clearTable1() {
	$('#expenditure_tEbName1').textbox('setValue',null);
	$('#expenditure_tEbCode1').textbox('setValue',null);
	$('#expenditure_fLevName1').datebox('setValue',null);
	$('#expenditure_fFlowStauts').textbox('setValue',null);
}
//清除查询条件
function clearTable2() {
	$('#expenditure_tEbName2').textbox('setValue',null);
	$('#expenditure_tEbCode2').textbox('setValue',null);
	$('#expenditure_fLevName2').textbox('setValue',null);
	$('#expenditure_fFunctionClass').textbox('setValue',null);
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
function xiangmufenlei2(val,row){
	if(val=='PRO-CLASS-1'){
		return '重大改革发展项目';
	}else if(val=='PRO-CLASS-2'){
		return '专项业务费项目';
	}else if(val=='PRO-CLASS-9'){
		return '其他项目';
	}
}
function miji2(val,row){
	if(val=='0'){
		return '无';
	}else if(val=='1'){
		return '机密';
	}else if(val=='2'){
		return '绝密';
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
	function CZ1(val, row) {
		return 	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="detail1(' + row.tEbId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
				+'</td><td style="width: 25px">'+ '<a href="#" onclick="expenditure_update1(' + row.tEbId
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">' + '</a>'
				+'</td><td style="width: 25px">'+'<a href="#" onclick="expenditure_delete1(' + row.tEbId
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">' + '</a>'
				+'</td></tr></table>';
	}
	function CZ2(val, row) {
		return 	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="detail2(' + row.tEbId2+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
				+'</td><td style="width: 25px">'+ '<a href="#" onclick="expenditure_update2(' + row.tEbId2
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">' + '</a>'
				+'</td><td style="width: 25px">'+'<a href="#" onclick="expenditure_delete2(' + row.tEbId2
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">' + '</a>'
				+'</td></tr></table>';
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
	function queryPM1() {
		var fs=$('#expenditure_fFlowStauts').val();
		$('#expenditure_dg1').datagrid('load', {
			tEbName1 : $('#expenditure_tEbName1').val(),
			tEbCode1 : $('#expenditure_tEbCode1').val(),
		});
	}
	function queryPM2() {
		var fs=$('#expenditure_fFlowStauts').val();
		$('#expenditure_dg2').datagrid('load', {
			tEbName2 : $('#expenditure_tEbName2').val(),
			tEbCode2 : $('#expenditure_tEbCode2').val(),
		});
	}
	function addExpenditure1() {
		var node = $('#expenditure_dg1').datagrid('getSelected');
		var win = creatWin('支出明细事项新增', 700, 250, 'icon-search', '/ExpenditureBaseic/add?leixing=1');
		win.window('open');
	}
	function addExpenditure2() {
		var node = $('#expenditure_dg1').datagrid('getSelected');
		if(node==null||node==''){
			$.messager.alert('系统提示',' 请先选择支出明细事项!','error');
		}else{
			var win = creatWin('明细科目新增', 700, 350, 'icon-search', '/ExpenditureBaseic/add?tEbIdTemp='+node.tEbId+'&leixing=2');
			win.window('open');
		}
	}
	function detail1(id) {
			var win = creatWin('查看', 700, 350, 'icon-search','/ExpenditureBaseic/detail/' + id+'?leixing=1');
			win.window('open');
	}
	function detail2(id) {
			var win = creatWin('查看', 700, 350, 'icon-search','/ExpenditureBaseic/detail/' + id+'?leixing=2');
			win.window('open');
	}
	function expenditure_update1(id) {
		//var row = $('#expenditure_dg1').datagrid('getSelected');
		//var selections = $('#expenditure_dg1').datagrid('getSelections');
		var win = creatWin('修改', 700, 350, 'icon-search','/ExpenditureBaseic/edit/' + id+'?leixing=1');
		win.window('open');
	}
	function expenditure_update2(id) {
		//var row = $('#expenditure_dg1').datagrid('getSelected');
		//var selections = $('#expenditure_dg2').datagrid('getSelections');
		var win = creatWin('修改', 700, 350, 'icon-search',"/ExpenditureBaseic/edit/" + id+'?leixing=2');
		win.window('open');
	}
	function expenditure_delete1(id) {
		if (confirm("如删除该支出明细事项,将删除该明细事项下的所有明细科目,确认是否删除？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/ExpenditureBaseic/delete/' + id+'?leixing=1',
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#CFAddEditForm').form('clear');
						$("#expenditure_dg1").datagrid('reload');
						$("#expenditure_dg2").datagrid('reload');
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		}
	}
	function expenditure_delete2(id) {
		if (confirm("确认是否删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/ExpenditureBaseic/delete/' + id+'?leixing=2',
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#CFAddEditForm').form('clear');
						$("#expenditure_dg2").datagrid('reload');
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
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
</script>
</body>
</html>

