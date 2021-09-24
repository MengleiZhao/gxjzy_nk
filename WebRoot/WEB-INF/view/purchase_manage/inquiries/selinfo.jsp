<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body style="background-color: #f0f5f7;text-align: center;">	
<div >
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		
	<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-search">
						供应商名称
						<input id="sel_fwName" name="fwName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
						<input type="hidden" name="fpId" id="F_fpId" value="${fpid}"/>
						&nbsp;&nbsp;联系人
						<input id="sel_user" name="" style="width: 150px; height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;<a href="#" onclick="querySEL();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						<a href="#" onclick="clearSELTable();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
				</tr>
			</table> 
		</div>		
		
		
		<div style="margin: 0 10px 0 10px;height: 250px;">	
			<table id="sel_tab" class="easyui-datagrid"
				data-options="collapsible:true,url:'${base}/suppliergl/cgselPage?fpid=${fpid}',
			method:'post',fit:true,pagination:false,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true">
				<thead>
					<tr>
					<th data-options="field:'fwId',hidden:true"></th>
					<th data-options="field:'num',align:'center'" style="width: 5%">序号</th>
					<th data-options="field:'fwName',align:'left'" style="width: 27%">供应商名称</th>
					<th data-options="field:'fwuserName',align:'left',resizable:false,sortable:true" style="width: 8%">联系人</th>
					<th data-options="field:'fwTel',align:'left',resizable:false,sortable:true" style="width: 15%">联系电话</th>
					<th data-options="field:'fwAddr',align:'left',resizable:false,sortable:true" style="width: 35%">办公地址</th>
					<th data-options="field:'fwRemark',align:'left',resizable:false,sortable:true" style="width: 10%">备注</th>
				</tr>
				</thead>
			</table>
		</div>

			<div style="text-align: left;">
				<span style="color:#ff6800">&nbsp;&nbsp;&nbsp;&nbsp;✧温馨提示：请双击完成选择</span>
			</div>
			<div class="win-left-bottom-div" style="text-align: center;">
				<a href="javascript:void(0)" onclick="closeFirstWindow()">
					<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
				</a>
			</div>

	</div>
	<script type="text/javascript">
	
	//分页样式调整
	$(document).ready(function() {
		var pager = $('#sel_tab').datagrid().datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			layout:['sep','first','prev','links','next','last'/* ,'refresh' */]
		});	
		
		$("#sel_tab").datagrid({
			 onDblClickRow:function(index, row){
				 var row = $('#sel_tab').datagrid('getSelected');
					var selections = $('#sel_tab').datagrid('getSelections');
					if (row != null && selections.length == 1) {
						$("#F_fwId").val(row.fwId);
					    $("#F_fwName").textbox('setValue',row.fwName);
						$("#F_fwAddr").textbox('setValue',row.fwAddr);
						$("#F_fwuserName").textbox('setValue',row.fwuserName);
						$("#F_fwTel").textbox('setValue',row.fwTel);
						$("#F_fwRemark").textbox('setValue',row.fwRemark);
						closeFirstWindow();
					} else {
						$.messager.alert('系统提示', '请选择一条数据！', 'info');
					} 
			 }
		});
	});
	
	//点击查询
	 function querySEL() {
		$('#sel_tab').datagrid('load',{
			fwName : $('#sel_fwName').textbox('getValue'),
			fwuserName : $('#sel_user').textbox('getValue')
		});
	}
	
	//清除查询条件
	function clearSELTable() {
		$("#sel_fwName").textbox('setValue','');
		$("#sel_user").textbox('setValue','');
		$('#sel_tab').datagrid('load',{//清空以后，重新查一次
		});
	}

	function showA(obj){
		obj.src=base+'/resource-modality/${themenurl}/list/checked1.png';
	}
	function showB(obj){
		obj.src=base+'/resource-modality/${themenurl}/checked2.png';
	}		
 		
	</script>
</body>


