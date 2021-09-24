<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<style type="text/css">
.datagrid .datagrid-pager {
    margin-top: 0;
   
}
</style>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-td1">年度</td> 
					<td class="top-table-td2">
						<input id="PM_fYear1" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">一级分类代码</td> 
					<td class="top-table-td2">
						<input id="PM_fLevCode1" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">一级分类名称</td> 
					<td class="top-table-td2">
						<input id="PM_fLevName1" name="" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td style="width: 12px">
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
						<a href="#"   onclick="addPM1()" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/xz2.png')"
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
			<table id="PM_dg1" class="easyui-datagrid"
			data-options="singleSelect:true,collapsible:true,url:'${base}/ProMgrLevel/JsonPagination',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fLvId1',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'fYear1',align:'center'" width="26%">年度</th>
						<th data-options="field:'fLevCode1',align:'center',resizable:false,sortable:true" width="30%">一级分类代码</th>
						<th data-options="field:'fLevName1',align:'center',resizable:false,sortable:true" width="30%">一级分类名称</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ1" width="10%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
		
		<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-td1">项目分类</td> 
					<td class="top-table-td2">
						<input id="PM_fProType" name=""  style="width: 150px;height:25px;"data-options="url:'${base}/ProMgrLevel/lookupsJson?parentCode=PRO-CLASS',method:'POST',valueField:'code',textField:'text',editable:false" class="easyui-combobox"></input>
					</td>
					<td class="top-table-td1">二级分类代码</td> 
					<td class="top-table-td2">
						<input id="PM_fLevCode2" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">二级分类名称</td> 
					<td class="top-table-td2">
						<input id="PM_fLevName2" name="" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td> 
					<!-- <td class="top-table-td1">功能科目代码：</td> 
					<td class="top-table-td2">
						<input id="PM_fFunctionClass" name="" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td> -->
					<td style="width: 12px">
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
						<a href="#"   onclick="addPM2()" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/xz2.png')"
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
			<table id="PM_dg2" class="easyui-datagrid"
			data-options="singleSelect:true,collapsible:true,url:'${base}/ProMgrLevel/JsonPagination2',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fLvId2',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'fLevCode2',align:'center',resizable:false,sortable:true" width="30%">二级代码</th>
						<th data-options="field:'fLevName2',align:'center',resizable:false,sortable:true" width="30%">二级名称</th>
						<th data-options="field:'fProType',align:'center',formatter:xiangmufenlei2" width="26%">项目分类名称</th>
						<!-- <th data-options="field:'fEcName',align:'left'" width="15%">功能分类</th>
						<th data-options="field:'fSecrecyGrade',align:'left',formatter:miji2" width="15%">密级</th> -->
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ2" width="10%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	


<script type="text/javascript">
$(function(){
	$('#PM_dg1').datagrid({
		onLoadSuccess : function(data){   
			$('#PM_dg1').datagrid('selectRow',0);
			var node = $('#PM_dg1').datagrid('getSelected');
			//console.log(node);
			$('#PM_dg2').datagrid('load', {
				fProType : $('#PM_fProType').combobox('getValue'),
				fLevCode2 : $('#PM_fLevCode2').val(),
				fLevName2 : $('#PM_fLevName2').val(),
				fFunctionClass : $('#PM_fFunctionClass').val(),
				a : node.fLvId1,
			});
		},
	});
});
	$('#PM_dg1').datagrid({
		onClickRow: function(rowIndex,rowData){
			$('#PM_fFunctionClass').textbox('setValue',null);
			$('#PM_fProType').combobox('setValue',null);
			$('#PM_fLevCode2').textbox('setValue',null);
			$('#PM_fLevName2').textbox('setValue',null);
			$('#PM_dg2').datagrid('load', {
				fProType : $('#PM_fProType').combobox('getValue'),
				fLevCode2 : $('#PM_fLevCode2').val(),
				fLevName2 : $('#PM_fLevName2').val(),
				fFunctionClass : $('#PM_fFunctionClass').val(),
				a : rowData.fLvId1,
			});
		},
	});
//清除查询条件
function clearTable1() {
	$('#PM_fYear1').textbox('setValue',null);
	$('#PM_fLevCode1').textbox('setValue',null);
	$('#PM_fLevName1').datebox('setValue',null);
	$('#PM_fFlowStauts').textbox('setValue',null);
}
//清除查询条件
function clearTable2() {
	$('#PM_fProType').textbox('setValue',null);
	$('#PM_fLevCode2').textbox('setValue',null);
	$('#PM_fLevName2').textbox('setValue',null);
	$('#PM_fFunctionClass').textbox('setValue',null);
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
				'<a href="#" onclick="detail1(' + row.fLvId1+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
				+'</td><td style="width: 25px">'+ '<a href="#" onclick="PM_update1(' + row.fLvId1
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">' + '</a>'
				+'</td><td style="width: 25px">'+'<a href="#" onclick="PM_delete1(' + row.fLvId1
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">' + '</a>'
				+'</td></tr></table>';
	}
	function CZ2(val, row) {
		return 	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="detail2(' + row.fLvId2+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
				+'</td><td style="width: 25px">'+ '<a href="#" onclick="PM_update2(' + row.fLvId2
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">' + '</a>'
				+'</td><td style="width: 25px">'+'<a href="#" onclick="PM_delete2(' + row.fLvId2
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
		var fs=$('#PM_fFlowStauts').val();
		$('#PM_dg1').datagrid('load', {
			fYear1 : $('#PM_fYear1').val(),
			fLevCode1 : $('#PM_fLevCode1').val(),
			fLevName1 : $('#PM_fLevName1').val(),
		});
	}
	function queryPM2() {
		//var fs=$('#PM_fProType').combobox('getValue');
		var node = $('#PM_dg1').datagrid('getSelected');
		$('#PM_dg2').datagrid('load', {
			fProType : $('#PM_fProType').combobox('getValue'),
			fLevCode2 : $('#PM_fLevCode2').val(),
			fLevName2 : $('#PM_fLevName2').val(),
			fFunctionClass : $('#PM_fFunctionClass').val(),
			a : node.fLvId1,
		});
	}
	function addPM1() {
		var node = $('#PM_dg1').datagrid('getSelected');
		var win = creatWin('一级分类新增', 700, 350, 'icon-search', '/ProMgrLevel/add1');
		win.window('open');
	}
	function addPM2() {
		var node = $('#PM_dg1').datagrid('getSelected');
		if(node==null||node==''){
			$.messager.alert('系统提示',' 请先选择一级分类!','error');
		}else{
			var win = creatWin('二级分类新增', 700, 350, 'icon-search', '/ProMgrLevel/add2?a='+node.fLvId1);
			win.window('open');
		}
	}
	function detail1(id) {
			var win = creatWin('查看', 700, 350, 'icon-search',"/ProMgrLevel/detail1/" + id);
			win.window('open');
	}
	function detail2(id) {
			var win = creatWin('查看', 700, 350, 'icon-search',"/ProMgrLevel/detail2/" + id);
			win.window('open');
	}
	function PM_update1(id) {
		//var row = $('#PM_dg1').datagrid('getSelected');
		//var selections = $('#PM_dg1').datagrid('getSelections');
		var win = creatWin('修改', 700, 350, 'icon-search',"/ProMgrLevel/edit1/" + id);
		win.window('open');
	}
	function PM_update2(id) {
		//var row = $('#PM_dg1').datagrid('getSelected');
		//var selections = $('#PM_dg2').datagrid('getSelections');
		var win = creatWin('修改', 700, 350, 'icon-search',"/ProMgrLevel/edit2/" + id);
		win.window('open');
	}
	function PM_delete1(id) {
		if (confirm("如删除该一级分类,将删除该项目下的所有二级分类,确认是否删除？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/ProMgrLevel/delete1/' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#CFAddEditForm').form('clear');
						$("#PM_dg1").datagrid('reload');
						$("#PM_dg2").datagrid('reload');
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		}
	}
	function PM_delete2(id) {
		if (confirm("确认是否删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/ProMgrLevel/delete2/' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#CFAddEditForm').form('clear');
						$("#PM_dg2").datagrid('reload');
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

