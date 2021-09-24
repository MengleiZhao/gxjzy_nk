<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>

<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<th class="top-table-td1">资产名称</th> 
					<td class="top-table-td2">
						<input id="maintain_reg_fAssName" name="" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<th class="top-table-td1">资产编号</th> 
					<td class="top-table-td2">
						<input id="maintain_reg_fAssCode" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td align="left" style="width: 75px;padding-left: 20px">
						<a href="javascript:void(0)" onclick="maintain_reg_query();">
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')">
						</a>
					</td>
					<td >
						<a href="javascript:void(0)"  onclick="maintain_reg_clear();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')">
						</a>
					</td>
				</tr>
			</table>           
		</div>
		<div class="list-table" style="height:430px">
			<table id="maintain_reg_list" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Maintain/chooseMainJson',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fAssName',align:'left',resizable:false,sortable:true," width="20%">资产名称</th>
						<th data-options="field:'fAssCode',align:'left',resizable:false,sortable:true," width="20%" >资产编号</th>
						<th data-options="field:'fAssModel',align:'center',resizable:false,sortable:true" width="20%" >规格型号</th>
						<th data-options="field:'fRepairTime',align:'center',formatter: ChangeDateFormat" width="15%">报修日期</th>
						<th data-options="field:'fFaultRemark',align:'left',resizable:false,sortable:true" width="25%">故障情况</th>
					</tr>
				</thead>
			</table>
		</div>
		<div style="text-align: left;height: 20px">
			<span style="color:#ff6800">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✧温馨提示：双击数据选择</span>
		</div>
	</div>
	<input hidden="hidden" id="zclx" type="text" value="${zctype }">


<script type="text/javascript">
//分页样式调整
$(function(){
	$("#maintain_reg_list").datagrid({
		onDblClickRow:function(index, row){
			var row = $('#maintain_reg_list').datagrid('getSelected');
			var selections = $('#maintain_reg_list').datagrid('getSelections');
			if (row != null && selections.length == 1) {
				$("#reg_mainID").val(row.fID); 
				$("#reg_mainCode").textbox('setValue',row.tAssetMainCode); 
				$("#reg_fMainWhether").combobox('setValue',row.fMainWhether.code); 
				if(row.fMainWhether.code=='sfcswxfy-01'){
					$("#reg_fRegAmount").numberbox('setValue',row.fMainAmount); 
				}else {
					$("#reg_fRegAmount").numberbox('setValue',0); 
				}
				closeFirstWindow();
			} else {
				$.messager.alert('系统提示', '请选择一条数据！', 'info');
			}
		}
	});
});


function maintain_reg_query(){  
	$('#maintain_reg_list').datagrid('load',{ 
		fAssName:$('#maintain_reg_fAssName').textbox('getValue'),
		fAssCode:$('#maintain_reg_fAssCode').textbox('getValue'),
	} ); 
}
//清除查询条件
function maintain_reg_clear() {
	$('#maintain_reg_fAssName').textbox('setValue',null),
	$('#maintain_reg_fAssCode').textbox('setValue',null),
	maintain_reg_query();
}
</script>

