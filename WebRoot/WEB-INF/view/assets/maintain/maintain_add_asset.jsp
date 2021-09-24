<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<th class="top-table-td1">原配置单号</th> 
					<td class="top-table-td2">
						<input id="maintain_fAssCode" name="" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<th class="top-table-td1">物资名称</th> 
					<td class="top-table-td2">
						<input id="maintain_fAssName" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<th class="top-table-td1">资产状态</th> 
					<td class="top-table-td2">
						<input id="maintain_fAssStauts" name="" style="width: 150px;height:25px;" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',url:'${base}/Maintain/lookupsJson?parentCode=ZCZT',method:'POST',valueField:'code',textField:'text',editable:false" ></input>
					</td>
					<td align="left" style="width: 75px;padding-left: 20px">
						<a href="javascript:void(0)" onclick="maintainQuery();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
					<td >
						<a href="javascript:void(0)"  onclick="maintain_clear();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')">
						</a>
					</td>
				</tr>
			</table>           
		</div>
		<div class="list-table" style="height: 475px">
			<table id="maintain_choose_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Maintain/chooseJsonPagination',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fAssId',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="5%">序号</th>
						<th data-options="field:'fAssCode',align:'center',esizable:false,sortable:true" width="20%">资产编号</th>
						<th data-options="field:'fAssName',align:'center',resizable:false,sortable:true" width="20%">资产名称</th>
						<th data-options="field:'fSPModel',align:'center',resizable:false,sortable:true" width="15%">规格型号</th>
						<th data-options="field:'fMeasUnit',align:'center',resizable:false,sortable:true" width="10%">单位</th>
						<th data-options="field:'stockNum',align:'center',resizable:false,sortable:true" width="10%">数量</th>
						<th data-options="field:'fUseName',align:'center',resizable:false,sortable:true" width="10%">使用人</th>
						<th data-options="field:'assStauts',align:'center',resizable:false,sortable:true" width="10%">资产状态</th>
					</tr>
				</thead>
			</table>
		</div>
		<div data-options="region:'south'" style="height: 10px;width: 100%; border: 0px;">
			<div style="text-align: left;">
				<span style="color:#ff6800">&nbsp;&nbsp;&nbsp;&nbsp;✧温馨提示：请双击完成选择</span>
			</div>
		</div>
	</div>
	


<script type="text/javascript">
//分页样式调整
$(function(){
	$("#maintain_choose_dg").datagrid({
		onDblClickRow:function(index, row){
			 var row = $('#maintain_choose_dg').datagrid('getSelected');
				var selections = $('#maintain_choose_dg').datagrid('getSelections');
				if (row != null && selections.length == 1) {
					$("#m_fAssName").textbox('setValue',row.fAssName); 
					$("#m_fAssCode").textbox('setValue',row.fAssCode); 
					$("#m_fAssModel").textbox('setValue',row.fSPModel); 
					$("#m_fAcquisitionDate").datebox('setValue',ChangeDateFormat(row.fAcquisitionDate)); 
					closeFirstWindow();
				} else {
					$.messager.alert('系统提示', '请选择一条数据！', 'info');
				}
		}
		});
});


function formatPrice(val,row){
	if (val =="1"){
		return "公开招标";
	} else if(val =="2"){
		return "待邀请招标";
	} else if(val =="3"){
		return "竞争性谈判";
	} else if(val =="4"){
		return"单一来源采购";
	}
}
/*function CZ(val,row){
	return '<a href="#" onclick="PitchOn('+row.fpId+')" class="easyui-linkbutton">'+"选取"+'</a>';
}
 function PitchOn(id){
	var row = $('#maintain_choose_dg').datagrid('getSelected');
	var selections = $('#maintain_choose_dg').datagrid('getSelections');
	if (row != null && selections.length == 1) {
		$("#A_fReceCode").textbox('setValue',row.fAssReceCode); 
		$("#A_fTransUser").textbox('setValue',row.fReceUser); 
		$("#A_fTransDept").textbox('setValue',row.fReceDept); 
		$("#A_fTransTel").textbox('setValue',row.fReceTel); 
		$("#A_fTransTime").textbox('setValue',ChangeDateFormat(row.fReceTime)); 
		closeFirstWindow();
	} else {
		$.messager.alert('系统提示', '请选择一条数据！', 'info');
	}
} */
function maintainQuery(){  
	$('#maintain_choose_dg').datagrid('load',{ 
		fAssCode:$('#maintain_fAssCode').textbox('getValue'),
		fAssName:$('#maintain_fAssName').textbox('getValue'),
		assStauts:$('#maintain_fAssStauts').combobox('getValue'),
	} ); 
}
//清除查询条件
function maintain_clear() {
	$('#maintain_fAssCode').textbox('setValue',null),
	$('#maintain_fReceUser').textbox('setValue',null),
	$('#maintain_fAssName').textbox('setValue',null),
	maintainQuery();
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

