<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-td1">科目编码：</td>
					<td	class="top-table-td2">
						<input id="functionClass_code" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					</td>
	
					<td class="top-table-td1">科目名称：</td>
					<td class="top-table-td2">
						<input id="functionClass_name" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					</td>
					<td style="width: 30px;"></td>				
					<td style="width: 26px;">
						<a href="#" onclick="queryFunctionClass();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>				
					<td style="width: 8px;"></td>			
					<td style="width: 26px;">
						<a href="#" onclick="clearFunctionClassTable();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>								
					<td align="right" style="padding-right: 10px">
						<a href="#" onclick="addFunctionClass()">
							<img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
				</tr>
			</table>
		</div>
		
		
		
		<div class="list-table">
			<table id="function_class_tab" border="0" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/finctionclassmgrgl/functionclassPageData',
				method:'post',fit:true,pagination:true,singleSelect: true,
				selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fmId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" width="20%">序号</th>
						<th data-options="field:'fecName',align:'left'" width="20%">科目名称</th>
						<th data-options="field:'fecCode',align:'left'" width="20%">科目编码</th>
						<th data-options="field:'fecDesc',align:'left'" width="30%">科目说明</th>
						<th data-options="field:'operation',align:'left',formatter:format_supplier" width="10%">操作</th>
				</tr>
				</thead>
			</table>
		</div>
	</div>

</div>

	<script type="text/javascript">
	
	//分页样式调整
	$(document).ready(function() {
		var pager = $('#function_class_tab').datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
		});	
	});
	
	//点击查询
	 function queryFunctionClass() {
		$('#function_class_tab').datagrid('load',{
			fecName : $('#functionClass_name').textbox('getValue'),
			fecCode : $('#functionClass_code').textbox('getValue')
		});
	}
		//清除查询条件
		function clearFunctionClassTable() {
			$("#functionClass_name").textbox('setValue','');
			$("#functionClass_code").textbox('setValue','');
		}

	
	//操作栏创建
	function format_supplier(val,row) {		
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
					'<a href="#" onclick="supplier_detail(' + row.fmId + ')" class="easyui-linkbutton">'+
			   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
			   		'</a>'+ '</td><td style="width: 25px">'+
					'<a href="#" onclick="supplier_update(' + row.fmId + ')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
					'</a>' + '</td><td style="width: 25px">'+
					'<a href="#" onclick="supplier_delete(' + row.fmId + ')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/delete1.png">'+
					'</a></td></tr></table>';
		
	}
	function showA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
	}
	function showB(obj){
		obj.src=base+'/resource-modality/${themenurl}/select2.png';
	}
	function showC(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/update1.png';
	}
	function showD(obj){
		obj.src=base+'/resource-modality/${themenurl}/update2.png';
	}
	function showE(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/delete1.png';
	}
	function showF(obj){
		obj.src=base+'/resource-modality/${themenurl}/delete2.png';
	}
	
	
	//新增页面
	function addFunctionClass() {
		var win = creatWin('新增', 750, 380, 'icon-search', '/finctionclassmgrgl/add');
		win.window('open');
	}
	
	 //查看
	 function supplier_detail(id) {
		var win = creatWin(' ', 750, 380, 'icon-search',"/finctionclassmgrgl/detail?id=" + id);
		win.window('open'); 
	} 
	//修改
	function supplier_update(id) {
		var win = creatWin(' ', 750, 380, 'icon-search',"/finctionclassmgrgl/edit?id=" + id);
		win.window('open'); 
  }
	
	 
	
	 //删除
	function supplier_delete(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/finctionclassmgrgl/delete?id='+id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#function_class_tab').datagrid("reload");
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		}
	}
	
	

		//鼠标移入图片替换
		function mouseOver(img) {
			var src = $(img).attr("src");
			src = src.replace(/1/, "2");
			$(img).attr("src", src);
		}

		function mouseOut(img) {
			var src = $(img).attr("src");
			src = src.replace(/2/, "1");
			$(img).attr("src", src);
		}
	</script>
</body>
</html>

