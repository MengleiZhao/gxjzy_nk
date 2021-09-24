<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-search">合同编号&nbsp;
						<input id="c_fcCode" name="" onchange="CheckYou()" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;合同名称&nbsp;
						<input id="c_fcTitle" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
						<!-- &nbsp;&nbsp;合同金额&nbsp;
						<input id="c_cAmountBegin"  name="" style="width: 150px;height:25px;" data-options="icons: [{iconCls:'icon-wanyuan'}],precision:2" validType="numberBegin[c_cAmountEnd]" class="easyui-numberbox"></input>
						&nbsp;-&nbsp;
						<input id="c_cAmountEnd" name="" style="width: 150px;height:25px;" data-options="icons: [{iconCls:'icon-wanyuan'}],precision:2" class="easyui-numberbox"></input>
						&nbsp;&nbsp; -->
						<a href="javascript:void(0)"  onclick="queryCF();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="clearTable();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')"></a>
					</td> 
				</tr>
			</table>           
		</div>
		<div class="list-table" style="height:420px">
			<table id="ending_contract_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/ending/contractList',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fId_R',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="10%">序号</th>
						<th data-options="field:'fcCode',align:'center'" width="25%">合同编号</th>
						<th data-options="field:'fcTitle',align:'center',resizable:false,sortable:true" width="28%">合同名称</th>
						<th data-options="field:'fcType',align:'center',resizable:false,sortable:true,formatter:HFLX" width="15%">合同分类</th>
						<th data-options="field:'fcAmount',align:'center',resizable:false,sortable:true" width="25%">合同金额(万元)</th>
					</tr>
				</thead>
			</table>
		</div>
		<div style="text-align: left;height: 20px">
			<span style="color:#ff6800">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✧温馨提示：双击数据选择</span>
		</div>
	</div>
	


<script type="text/javascript">

$("#ending_contract_dg").datagrid({
	 onDblClickRow:function(index, row){
		var row = $('#ending_contract_dg').datagrid('getSelected');
		var selections = $('#ending_contract_dg').datagrid('getSelections');
		if (row != null && selections.length == 1) {
			var win = creatWin('合同终止申请', 970, 580, 'icon-search','/ending/add?id='+row.fcId);
			win.window('open');
			closeFirstWindow();
		} else {
			$.messager.alert('系统提示', '请选择一条数据！', 'info');
		}
	}
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
function CZ(val,row){
	return '<a href="#" onclick="PitchOn('+row.fpId+')" class="easyui-linkbutton">'+"选取"+'</a>';
}
function PitchOn(id){
	var row = $('#ending_contract_dg').datagrid('getSelected');
	var selections = $('#ending_contract_dg').datagrid('getSelections');
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
}
function queryCF(){  
	$('#ending_contract_dg').datagrid('load',{ 
		fcCode:$('#c_fcCode').textbox('getValue'),
		fcTitle:$('#c_fcTitle').textbox('getValue'),
	} ); 
}
</script>
</body>
</html>

