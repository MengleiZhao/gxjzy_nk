<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table id="register_dg"  class="top-table" cellpadding="0" cellspacing="0">
			<tr>
				<td class="top-table-search">&nbsp;&nbsp;
					&nbsp;&nbsp;登记编号&nbsp;
					<input id="register_code" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;立项项目名称&nbsp;
					<input id="register_name" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;登记部门&nbsp;
					<input id="register_dept" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
					&nbsp;&nbsp;审批状态&nbsp;
					<select id="register_type" class="easyui-combobox" style="width: 150px; height:25px;" data-options="required:true,editable:false">
						<option value="">-请选择-</option>
						<option value="1">待审批</option>
						<option value="0">暂存</option>
						<option value="-4">已撤回</option>
						<option value="-1">已退回</option>
						<option value="9">已审批</option>
					</select>&nbsp;
					<a href="#" onclick="queryRegist();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
					&nbsp;&nbsp;
					<a href="#" onclick="clearRegistTable();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				
				</td>
				<%-- <td align="right" style="padding-right: 10px">
					<a href="#" onclick="addRegist()">
						<img src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
					</a>
				</td> --%>
			</tr>
		</table>
	</div>

	<div style="margin: 0 10px 0 10px;height: 445px;">	
		<table id="registerTab" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/srregister/registerPage?fFlowStauts=2',
		method:'post',fit:true,pagination:true,singleSelect: true,
		selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
			<thead>
				<tr>
					<th data-options="field:'fincomeId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'fincomeNum',align:'center'" style="width: 20%">登记编号</th>
					<th data-options="field:'fproName',align:'center',resizable:false,sortable:true" style="width: 15%">立项项目名称</th>
					<th data-options="field:'fregisterPerson',align:'center',resizable:false,sortable:true" style="width: 15%">登记人</th>
					<th data-options="field:'fregisterDepart',align:'center',resizable:false,sortable:true" style="width: 15%">登记部门</th>
					<th data-options="field:'fregisterTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" style="width: 12.5%">登记日期</th>
					<th data-options="field:'fFlowStauts',align:'center',resizable:false,formatter:flowStautsSet" style="width: 10%">审批状态</th>
					<!-- <th data-options="field:'fConfirmStatus',align:'center',resizable:false,formatter:confirmStautsSet" style="width: 10%">确认状态</th> -->
					<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" style="width: 10%">操作</th>
				</tr>
			</thead>
		</table>
	</div>

</div>
<script type="text/javascript">
	//分页样式调整
	$(function(){
		var pager = $('#registerTab').datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
		});
	});
	
	//设置审批状态
	function flowStautsSet(val, row) {
		if (val == 0) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "暂存" + '</a>';
		} else if (val == -1) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/yth.png">&nbsp;&nbsp;' + "已退回" + '</a>';
		} else if (val == 9) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已审批" + '</a>';
		} else if (val == -4) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已撤回" + '</a>';
		} else {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">&nbsp;&nbsp;' + "待审批" + '</a>';
		}
	}
	//设置确认状态
	function confirmStautsSet(val, row) {
		if (val == 0) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">&nbsp;&nbsp;' + "未确认" + '</a>';
		} else if (val == 9) {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/ytg.png">&nbsp;&nbsp;' + "已确认" + '</a>';
		}  else {
			return '<a style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">&nbsp;&nbsp;' + "确认中" + '</a>';
		}
	}
	
	//点击查询
	function queryRegist() {
		$('#registerTab').datagrid('load', {
			fCode : $('#register_code').textbox('getValue'),
			fProName : $('#register_name').textbox('getValue'),
			fDeptName : $('#register_dept').textbox('getValue'),
			fType : $('#register_type').combobox('getValue'),
		});                            
	}

	//清除查询条件
	function clearRegistTable() {
		$('#register_code').textbox('setValue',''),
		$('#register_name').textbox('setValue',''),
		$('#register_dept').textbox('setValue',''),
		$('#register_type').combobox('setValue',''),
		queryRegist();
	}
	
	//操作栏创建
	function CZ(val, row) {
		var c = row.fFlowStatus;
		if (c == 9) {
			return null;
		}else {
			return 	'<table><tr style="width: 75px;height:20px"><td style="width: 25px">'+
					'<a href="#" onclick="checkRegist(' + row.fincomeId + ')" class="easyui-linkbutton">'+
					'<img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/check1.png">'+
					'</a></td></tr></table>';
		}
	}
	//审批
	function checkRegist(id) {
		var win = creatWin('应收款项登记-审批', 1105, 580, 'icon-search', '/srregister/check?id=' + id);
		win.window('open');
	}
	//新增页面
	function addRegist() {
		var win = creatWin('应收款项登记-新增', 1105,580, 'icon-search', '/srregister/add');
		win.window('open');
	}

	//查看
	function detailRegist(id) {
		var win = creatWin('应收款项登记-查看', 1105,580, 'icon-search', '/srregister/detail?id=' + id);
		win.window('open');
	}
	
	//修改
	function updateRegst(id) {
		var win = creatWin('应收款项登记-修改', 1105,580, 'icon-search', '/srregister/edit?id=' + id);
		win.window('open');
	}
		
	//删除
	function deleteRegist(id) {
		if (confirm("确认删除吗？")) {
			$.ajax({
				type : 'POST',
				url : '${base}/srregister/delete?id='+id,
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						$.messager.alert('系统提示', data.info, 'info');
						$('#registerTab').datagrid("reload");
					}else {
						$.messager.alert('系统提示', data.info, 'error');
					}
				}
			});
		}
	}
</script>
</body>
</html>

