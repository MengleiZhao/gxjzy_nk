<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-td1">处置单号</td> 
					<td class="top-table-td2">
						<input id="reg_fAssHandleCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">物资名称</td> 
					<td class="top-table-td2">
						<input id="reg_fAssName" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1">处置方式</td> 
					<td class="top-table-td2">
						 <input id="reg_fHandleKind" name="" style="width: 150px;height:25px;" data-options="url:'${base}/Handle/lookupsJson?parentCode=CZFS',method:'POST',valueField:'code',textField:'text',editable:false" class="easyui-combobox"></input>
					</td>
					<td align="left" style="width: 75px;padding-left: 20px">
						<a href="javascript:void(0)" onclick="queryCF();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
				</tr>
			</table>           
		</div>
		<div class="list-table" style="height:400px">
			<table id="handle_reg_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Handle/handleRegJson',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fId',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'fAssHandleCode',align:'left'" width="25%">资产处置单号（流水号）</th>
						<th data-options="field:'fAssName',align:'left',resizable:false,sortable:true" width="15%">处置物资名称</th>
						<th data-options="field:'fHandleKind',align:'left',formatter: CZFS" width="20%" >计划处置方式</th>
						<th data-options="field:'fHandleUser',align:'left',resizable:false,sortable:true" width="20%">处置人</th>
						<th data-options="field:'fReqTime',align:'left',formatter: ChangeDateFormat" width="15%" >申请时间</th>
					</tr>
				</thead>
			</table>
		</div>
		<div style="text-align: left;height: 10px">
			<span style="color:#ff6800">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✧温馨提示：双击数据选择</span>
		</div>
	</div>
	


<script type="text/javascript">
//分页样式调整
$(function(){
	$("#handle_reg_dg").datagrid({
		onDblClickRow:function (index,row){
			var row = $('#handle_reg_dg').datagrid('getSelected');
			var selections = $('#handle_reg_dg').datagrid('getSelections');
			if (row != null && selections.length == 1) {
				$("#Reg_fId").textbox('setValue',row.fId); 
				$("#Reg_fAssHandleCode").textbox('setValue',row.fAssHandleCode); 
				$("#Reg_fAssName").textbox('setValue',row.fAssName); 
				$("#Reg_fAssCode").textbox('setValue',row.fAssCode); 
				$("#Reg_fRegKind").combobox('setValue',row.fHandleKind); 
				$("#Reg_fHandleTimeR").textbox('setValue',ChangeDateFormat(row.fHandleTime)); 
				$("#Reg_fHandleUserR").textbox('setValue',row.fHandleUser); 
				closeFirstWindow();
			} else {
				$.messager.alert('系统提示', '请选择一条数据！', 'info');
			}
		}
	});
});


function formatPrice(val,row){
	if (val =="ZCLX-01"){
		return "低值易耗品";
	} else if(val =="ZCLX-02"){
		return "固定资产";
	} else if(val =="ZCLX-03"){
		return "无形资产";
	}
}
function PitchOn(id){
	var row = $('#handle_reg_dg').datagrid('getSelected');
	console.log(row)
	var selections = $('#handle_reg_dg').datagrid('getSelections');
	if (row != null && selections.length == 1) {
		$("#Reg_fId").textbox('setValue',row.fId); 
		$("#Reg_fAssHandleCode").textbox('setValue',row.fAssHandleCode); 
		$("#Reg_fAssName").textbox('setValue',row.fAssName); 
		$("#Reg_fAssCode").textbox('setValue',row.fAssCode); 
		$("#Reg_fRegKind").combobox('setValue',row.fHandleKind); 
		$("#Reg_fHandleTimeR").textbox('setValue',ChangeDateFormat(row.fHandleTime)); 
		$("#Reg_fHandleUserR").textbox('setValue',row.fHandleUser); 
		closeFirstWindow();
	} else {
		$.messager.alert('系统提示', '请选择一条数据！', 'info');
	}
}
function queryCF(){  
	$('#handle_reg_dg').datagrid('load',{ 
		fAssHandleCode:$('#reg_fAssHandleCode').textbox('getValue'),
		fAssName:$('#reg_fAssName').textbox('getValue'),
		fHandleKind:$('#reg_fHandleKind').textbox('getValue'),
	} ); 
}
//时间格式化
function ChangeDateFormat(val) {
	//alert(val)
    var t, y, m, d, h, i, s;
    if(val==null){
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
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) ;
}
</script>
</body>
</html>

