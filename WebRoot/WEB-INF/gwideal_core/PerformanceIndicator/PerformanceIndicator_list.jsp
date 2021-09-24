<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body >
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-td1">一级指标代码：</td> 
					<td class="top-table-td2">
						<input id="per_fPerCode1" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">一级指标名称：</td> 
					<td class="top-table-td2">
						<input id="per_fPerName1" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
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
						<a href="#"   onclick="addPer1()" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/xz2.png')"
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
			<table id="Per_dg1" class="easyui-datagrid"
			data-options="singleSelect:true,collapsible:true,url:'${base}/PerformanceIndicator/PerformanceList1',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fPerId1',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'fPerName1',align:'left'" width="35%">一级绩效指标名称</th>
						<th data-options="field:'fPerCode1',align:'left',resizable:false,sortable:true" width="35%">一级绩效指标代码</th>
						<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ1" width="25%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
		
		<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top" >
		<table class="topTable" style="width: 100%;font-size: 12px;height: 40px;">
				<tr>
					<td class="top-table-td1">二级指标代码：</td> 
					<td class="top-table-td2">
						<input id="Per_fPerCode2" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">二级指标名称：</td> 
					<td class="top-table-td2">
						<input id="Per_fPerName2" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
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
						<a href="#"   onclick="addPer2()" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/xz2.png')"
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
			<table id="Per_dg2" class="easyui-datagrid"
			data-options="singleSelect:true,collapsible:true,url:'${base}/PerformanceIndicator/PerformanceList2',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fPerId2',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'fPerName2',align:'left'" width="35%">二级绩效指标名称</th>
						<th data-options="field:'fPerCode2',align:'left',resizable:false,sortable:true" width="35%">二级绩效指标代码</th>
						<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:CZ2" width="25%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
	


<script type="text/javascript">
$(function(){
	$('#Per_dg1').datagrid({
		onLoadSuccess : function(data){   
			$('#Per_dg1').datagrid('selectRow',0);
			var node = $('#Per_dg1').datagrid('getSelected');
			$('#Per_dg2').datagrid('load', {
				fPerCode2 : $('#Per_fPerCode2').val(),
				fPerName2 : $('#Per_fPerName2').val(),
				fP1 : node.fPerId1,
			}); 
		},
	});
});
	 $('#Per_dg1').datagrid({
		onClickRow: function(rowIndex,rowData){
			$('#Per_dg2').datagrid('load', {
				fPerCode2 : $('#Per_fPerCode2').textbox('getValue'),
				fPerName2 : $('#Per_fPerName2').textbox('getValue'),
				fP1 : rowData.fPerId1,
			});
		}
	});
//清除查询条件
function clearTable1() {
	$('#per_fPerCode1').textbox('setValue',null);
	$('#per_fPerName1').textbox('setValue',null);
	$("#Per_dg1").datagrid('load',{});
}
//清除查询条件
function clearTable2() {
	$('#Per_fPerCode2').textbox('setValue',null);
	$('#Per_fPerName2').textbox('setValue',null);
	$("#Per_dg2").datagrid('load',{});
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
				'<a href="#" onclick="detail1(' + row.fPerId1+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
				+'</td><td style="width: 25px">'+ '<a href="#" onclick="expenditure_update1(' + row.fPerId1
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">' + '</a>'
				+'</td><td style="width: 25px">'+'<a href="#" onclick="expenditure_delete1(' + row.fPerId1
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">' + '</a>'
				+'</td></tr></table>';
	}
	function CZ2(val, row) {
		return 	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'+
				'<a href="#" onclick="detail2(' + row.fPerId2+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>'
				+'</td><td style="width: 25px">'+ '<a href="#" onclick="expenditure_update2(' + row.fPerId2
				+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">' + '</a>'
				+'</td><td style="width: 25px">'+'<a href="#" onclick="expenditure_delete2(' + row.fPerId2
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
		$('#Per_dg1').datagrid('load', {
			fPerCode1 : $('#per_fPerCode1').val(),
			fPerName1 : $('#per_fPerName1').val(),
		});
	}
	function queryPM2() {
		var fs=$('#expenditure_fFlowStauts').val();
		$('#Per_dg2').datagrid('load', {
			fPerCode2 : $('#Per_fPerCode2').val(),
			fPerName2 : $('#Per_fPerName2').val(),
		});
	}
	function addPer1() {
		var node = $('#Per_dg1').datagrid('getSelected');
		var win = creatWin('一级绩效指标新增', 700, 250, 'icon-search', '/PerformanceIndicator/add?leixing=1');
		win.window('open');
	}
	function addPer2() {
		var node = $('#Per_dg1').datagrid('getSelected');
		if(node==null||node==''){
			$.messager.alert('系统提示',' 请先选择一级绩效指标!','error');
		}else{
			var win = creatWin('二级绩效指标新增', 700, 350, 'icon-search', '/PerformanceIndicator/add?fP1='+node.fPerId1+'&leixing=2');
			win.window('open');
		}
	}
	function detail1(id) {
			var win = creatWin('查看', 700, 350, 'icon-search','/PerformanceIndicator/detail/' + id+'?leixing=1');
			win.window('open');
	}
	function detail2(id) {
			var win = creatWin('查看', 700, 350, 'icon-search','/PerformanceIndicator/detail/' + id+'?leixing=2');
			win.window('open');
	}
	function expenditure_update1(id) {
		var win = creatWin('修改', 700, 350, 'icon-search','/PerformanceIndicator/edit/' + id+'?leixing=1');
		win.window('open');
	}
	function expenditure_update2(id) {
		var win = creatWin('修改', 700, 350, 'icon-search',"/PerformanceIndicator/edit/" + id+'?leixing=2');
		win.window('open');
	}
	function expenditure_delete1(id) {
		if (confirm("如删除该一级绩效指标,将删除该绩效指标下的所有二级绩效指标,确认是否删除？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/PerformanceIndicator/delete/' + id+'?leixing=1',
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#CFAddEditForm').form('clear');
						$("#Per_dg1").datagrid('reload');
						$("#Per_dg2").datagrid('reload');
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
				url : '${base}/PerformanceIndicator/delete/' + id+'?leixing=2',
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#CFAddEditForm').form('clear');
						$("#Per_dg2").datagrid('reload');
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

