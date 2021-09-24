<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<th class="top-table-td1">物资编号</th> 
					<td class="top-table-td2">
						<input id="handle_ABI_fAssCode" name="" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<th class="top-table-td1">物资名称</th> 
					<td class="top-table-td2">
						<input id="handle_ABI_fAssName" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td align="left" style="width: 75px;padding-left: 20px">
						<a href="javascript:void(0)" onclick="queryCF();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
				</tr>
			</table>           
		</div>
		<div class="list-table" style="height:400px">
			<table id="handle_assCode_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Handle/AssCodeJson?fAssType=${type}',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fAssId',hidden:true"></th>
						<th data-options="field:'fAssName',align:'center',resizable:false,sortable:true" width="25%">物资名称</th>
						<th data-options="field:'fAssCode',align:'center',resizable:false,sortable:true" width="25%">物资编号</th>
						<th data-options="field:'fAssType',align:'center',resizable:false,sortable:true,formatter:formatPrice" width="25%">物资类型</th>
						<th data-options="field:'fSPModel',align:'center',resizable:false,sortable:true" width="25" >规格型号</th>
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
	$("#handle_assCode_dg").datagrid({
		onDblClickRow:function (index,row){
			var row = $('#handle_assCode_dg').datagrid('getSelected');
			var selections = $('#handle_assCode_dg').datagrid('getSelections');
			if (row != null && selections.length == 1) {
				$("#H_fAssCode").textbox('setValue',row.code); 
				$("#H_fAssName").textbox('setValue',row.fAssName); 
				$("#H_fAssType").combobox('setValue',row.fAssType); 
				if($("#H_fAssType").val()=='ZCLX-02'){
					$("#H_fHandleNum").numberbox('setValue','1'); 
				}else {
					$("#H_fHandleNum").numberbox('setValue',''); 
				}
				$("#H_fMeasUnit").textbox('setValue',row.fMeasUnit); 
				$("#H_fOldAmount").textbox('setValue',row.fOldAmount); 
				$("#H_fWxTime").textbox('setValue',row.fWxTime); 
				$("#H_fBuyTime").datebox('setValue',ChangeDateFormat(row.fAcquisitionDate)); 
				closeFirstWindow();
			} else {
				$.messager.alert('系统提示', '请选择一条数据！', 'info');
			}
		}
	})
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
	var row = $('#handle_assCode_dg').datagrid('getSelected');
	var selections = $('#handle_assCode_dg').datagrid('getSelections');
	if (row != null && selections.length == 1) {
		$("#H_fAssCode").textbox('setValue',row.code); 
		$("#H_fAssName").textbox('setValue',row.fAssName); 
		$("#H_fAssType").combobox('setValue',row.fAssType); 
		if($("#H_fAssType").val()=='ZCLX-02'){
			$("#H_fHandleNum").textbox('setValue','1'); 
		}else {
			$("#H_fHandleNum").textbox('setValue',''); 
		}
		$("#H_fMeasUnit").textbox('setValue',row.fMeasUnit); 
		$("#H_fOldAmount").textbox('setValue',row.fOldAmount); 
		$("#H_fWxTime").textbox('setValue',row.fWxTime); 
		$("#H_fBuyTime").datebox('setValue',ChangeDateFormat(row.fAcquisitionDate)); 
		closeFirstWindow();
	} else {
		$.messager.alert('系统提示', '请选择一条数据！', 'info');
	}
}
function queryCF(){  
	$('#handle_assCode_dg').datagrid('load',{ 
		fAssCode:$('#handle_ABI_fAssCode').textbox('getValue'),
		fAssName:$('#handle_ABI_fAssName').textbox('getValue'),
		/* fAssType:$('#handle_ABI_fAssType').textbox('getValue'), */
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

