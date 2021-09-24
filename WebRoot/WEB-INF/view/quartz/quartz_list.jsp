<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="SUP_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
			<td class="top-table-search">任务名称&nbsp;
				<input id="list_jobdetailname"  style="width: 150px; height:25px;" class="easyui-textbox"></input>
				&nbsp;&nbsp;<a href="#" onclick="queryQuzrtz();">
					<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
				<a href="#" onclick="clearQuzrtzTable();">
					<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</td>
			<td align="right" style="padding-right: 10px">
				<a href="#" onclick="addQuzrtz()">
					<img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</td>
			</tr>
		</table>
	</div>
		
		
		
		<div style="margin: 0 10px 0 10px;height: 445px;">	
			<table id="Quzrtz_tab" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/quartzController/QuzrtzPageData',
			method:'post',fit:true,pagination:true,singleSelect: true,scrollbarSize:0,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr>
						<th data-options="field:'fwId',hidden:true"></th>
						<th data-options="field:'num',align:'center'" width="3%">序号</th>
						<th data-options="field:'jobdetailname',align:'center'" width="15%">任务名称</th>
						<th data-options="field:'cronexpression',align:'center'" width="10%">表达式</th>
						<th data-options="field:'targetobject',align:'center'" width="15%">任务类名</th>
						<th data-options="field:'methodname',align:'center'" width="7%">类名对应的方法名</th>
						<th data-options="field:'arguments',align:'center'" width="10%">参数</th>
						<th data-options="field:'concurrent',align:'center',formatter:formatConcurrent" width="10%">是否并发启动</th>
						<th data-options="field:'state',align:'center',formatter:formatState" width="6%">任务状态</th>
						<th data-options="field:'readme',align:'center'" width="17%">任务描述</th>
						<th data-options="field:'operation',align:'center',formatter:format_Quzrtz" width="8%">操作</th>
				</tr>
				</thead>
			</table>
		</div>
	

</div>

	<script type="text/javascript">
	
	//分页样式调整
	$(document).ready(function() {
		var pager = $('#Quzrtz_tab').datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
		});	
	});
	
	//点击查询
	function queryQuzrtz() {
		//alert($('#apply_time').val());
		$('#Quzrtz_tab').datagrid('load', {
			jobdetailname:$('#list_jobdetailname').val()
		});
	}
	//清除查询条件
	function clearQuzrtzTable() {
		/* $(".topTable :input[type='text']").each(function(){
			$(this).val("a");
		}); */
		$("#list_jobdetailname").textbox('setValue','');
		$('#Quzrtz_tab').datagrid('load',{//清空以后，重新查一次
		});
	}


	//设置任务状态
	function formatState(val, row) {
		var c = val;
		if (val == 0) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">' + "已停止" + '</a>';
		} else if (val == 1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">' + "运行中" + '</a>';
		} 
	}
	
	//设置并发状态
	function formatConcurrent(val, row) {
		var c = val;
		if (val == 0) {
			return '<a style="color:#666666;">' + "否" + '</a>';
		} else if (val == 1) {
			return '<a style="color:#666666;">' + "是" + '</a>';
		} 
	}
	
	//操作栏创建
	function format_Quzrtz(val,row) {		
						return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
								'<a href="#" onclick="Quzrtz_detail(' + row.id + ')" class="easyui-linkbutton">'+
						   		'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+
						   		'</a>'+ '</td><td style="width: 25px">'+
								'<a href="#" onclick="Quzrtz_update(' + row.id + ')" class="easyui-linkbutton">'+
								'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/update1.png">'+
								'</a>' + '</td><td style="width: 25px">'+
								'<a href="#" onclick="Quzrtz_delete(' + row.id + ')" class="easyui-linkbutton">'+
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
	function addQuzrtz() {
		var win = parent.creatWin('新增', 970, 580, 'icon-search', '/quartzController/add');
		win.window('open');
	}
	
	 //查看
	 function Quzrtz_detail(id) {
		var win = parent.creatWin(' ', 970, 580, 'icon-search',"/quartzController/detail?id=" + id);
		win.window('open'); 
	} 
	//修改
	function Quzrtz_update(id) {
		var win =parent.creatWin(' ', 970, 580, 'icon-search',"/quartzController/edit?id=" + id);
		win.window('open'); 
  }
	
	 
	
	 //删除
	function Quzrtz_delete(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/quartzController/delete?id='+id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#Quzrtz_tab').datagrid("reload");
					} else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		}
	}
	
	
	</script>
</body>

