<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
			   <tr>
						<td class="top-table-td1">流程显示名称:</td> 
						<td class="top-table-td2">
							<input id="M_FPName" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						</td>
						<td class="top-table-td1">流程定义代码：</td> 
						<td class="top-table-td2">
							<input id="M_FPCode" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
						</td>
						<td style="width: 12px">
						</td>
						<td style="width: 24px;">
							<a href="javascript:void(0)"  onclick="queryWF();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
									onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
						</td>
						<td style="width: 12px">
						</td>
						<td style="width: 24px;">
							<a href="javascript:void(0)"  onclick="clearTable();"><img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"
									onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"></a>
						</td>
						<td style="width: 12px">
						</td>
						<td align="right">
							<%-- <a href="#"   onclick="addWF()" ><img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a> --%>
						</td>
						<td style="width: 14px">
						</td>
					</tr>
					<tr id="helpTr" style="display: none;">
					</tr>
				</table>

		</div>
		
		<div class="list-table">
		<table id="PM_dg" border="0" class="easyui-datagrid"
				data-options="singleSelect:true,collapsible:true,url:'${base}/Monitoring/JsonPagination',
				method:'post',fit:true,pagination:true,singleSelect: true,
				selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
			<thead>
				<tr>
					<th data-options="field:'fpid',hidden:true"></th>
					<th data-options="field:'number',align:'center'" width="5%">序号</th>
					<th data-options="field:'fpname',align:'left',resizable:false,sortable:true" width="15%">流程显示名称</th>
					<th data-options="field:'fpcode',align:'left',resizable:false,sortable:true" width="15%">流程定义代码</th>
					<th data-options="field:'departName',align:'left',resizable:false,sortable:true" width="15%">部门名称</th>
					<th data-options="field:'fcreateUser',align:'left',resizable:false,sortable:true" width="15%">发布人</th>
					<th data-options="field:'fupdateTime',align:'left',resizable:false,sortable:true,formatter: ChangeDateFormat" width="15%">发布时间</th>
					<th data-options="field:'name',align:'left',resizable:false,sortable:true,formatter:qiyong" width="10%">流程启用状态</th>
					<th data-options="field:'fstauts',align:'left',resizable:false,sortable:true,formatter:liuchen" width="10%">流程运行状态</th>
				</tr>
			</thead>
		</table>
    </div>
</div>
<script type="text/javascript">
//分页样式调整
$(function(){
	var pager = $('#PM_dg').datagrid().datagrid('getPager');	// get the pager of datagrid
	pager.pagination({
		layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
	});			
});
//清除查询条件
function clearTable() {
	$('#M_FPName').textbox('setValue',null);
	$('#M_FPCode').textbox('setValue',null);
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
function qiyong(val, row){
	if(row.fstauts=='1'){
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 已启用" + '</span>';
	}else if(row.fstauts=='0'){
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 未启用" + '</span>';
	}else if(row.fstauts=='2'){
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 已停用" + '</span>';
	}
}
function liuchen(val, row){
	if(row.fstauts=='1'){
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">' + " 运行正常" + '</span>';
	}else if(row.fstauts=='2'||row.fstauts=='0'){
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + " 运行异常" + '</span>';
	}
}
function CZ(val, row) {
	return '<a href="#" onclick="detail(' + row.fpid
			+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">' + '</a>   '
			+'&nbsp;&nbsp;&nbsp;&nbsp;'+ '<a href="#" onclick="editWF(' + row.fpid
			+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">' + '</a>'
			+'&nbsp;&nbsp;&nbsp;&nbsp;'+'<a href="#" onclick="deleteWF(' + row.fpid
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
function showE(obj){
	obj.src=base+'/resource-modality/${themenurl}/delete2.png';
}
function showF(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/delete1.png';
}
	function queryWF(){
		$('#PM_dg').datagrid('load',{ 
			FPName:$('#M_FPName').val(),
			FPCode:$('#M_FPCode').val(),
		}); 
	}
	function detail(id) {
		var win = creatWin('查看', 650, 400, 'icon-search','/wflow/detail/' + id);
		win.window('open');
	}	
	function deleteWF(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/wflow/delete/' + id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#PM_dg').form('clear');
						$("#PM_dg").datagrid('reload');
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		}
	}	
	function addWF(){
		var win=creatWin('新增-流程',650,400,'icon-search','/wflow/add');
		win.window('open');
	}
	function editWF(id){
		var win=creatWin('修改-流程',650,400,'icon-search','/wflow/edit/'+id);
		win.window('open');
	}
	function streetChange(streetCode){
		$('#streetJwh').combobox('reload',"${base}/street/jwh?streetCode="+streetCode);
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

