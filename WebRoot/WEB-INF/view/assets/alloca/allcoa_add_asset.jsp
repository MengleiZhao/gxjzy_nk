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
						<input id="alloca_receCode_fAssReceCode" name="" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<!-- <th class="top-table-td1">物资名称：</th> 
					<td class="top-table-td2">
						<input id="alloca_receCode_fAssName" name=""  style="width: 90px;height:25px;" class="easyui-textbox"></input>
					</td> -->
					<th class="top-table-td1">领用人</th> 
					<td class="top-table-td2">
						<input id="alloca_receCode_fReceUser" name="" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td align="left" style="width: 75px;padding-left: 20px">
						<a href="javascript:void(0)" onclick="queryCF();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
					<td >		
						<a href="javascript:void(0)"  onclick="alloca_clear();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')">
						</a>
					</td>
				</tr>
			</table>           
		</div>
		<div class="list-table" style="height: 400px">
			<table id="allcoa_choose_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Alloca/allAllcoaJsonPagination',
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
		<div style="text-align: left;height: 10px">
			<span style="color:#ff6800">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✧温馨提示：双击数据选择</span>
		</div>
	</div>
	


<script type="text/javascript">
/* $(function(){
	$("#allcoa_choose_dg").datagrid({
		 onDblClickRow:function(index, row){
			 var row = $('#allcoa_choose_dg').datagrid('getSelected');
				var selections = $('#allcoa_choose_dg').datagrid('getSelections');
				if (row != null && selections.length == 1) {
					$("#A_fAllocaName").textbox('setValue',row.fAssName); 
					$("#A_fAllocaCode").textbox('setValue',row.fAssCode); 
					$("#A_fSPModel").textbox('setValue',row.fSPModel); 
					$("#A_fAllocaNum").numberbox('setValue',row.stockNum); 
					$("#A_fTransUser").textbox('setValue',row.fUseName); 
					//$("#A_fTransUser").textbox('setValue',row.fUseNameID); 
					$("#A_fUseDeptID").textbox('setValue',row.fUseDeptID); 
					$("#A_fTransDept").textbox('setValue',row.fUseDept); 
					//$("#A_fTransTime").textbox('setValue',ChangeDateFormat(row.fReceTime)); 
					closeFirstWindow();
				} else {
					$.messager.alert('系统提示', '请选择一条数据！', 'info');
				}
		}
		});
}); */


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
	var row = $('#allcoa_choose_dg').datagrid('getSelected');
	var selections = $('#allcoa_choose_dg').datagrid('getSelections');
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
function queryCF(){  
	$('#allcoa_choose_dg').datagrid('load',{ 
		fAssReceCode:$('#alloca_receCode_fAssReceCode').textbox('getValue'),
		/* fAssName:$('#alloca_receCode_fAssName').textbox('getValue'), */
		fReceUser:$('#alloca_receCode_fReceUser').textbox('getValue'),
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

//清除查询条件
function alloca_clear() {
	$('#alloca_receCode_fAssReceCode').textbox('setValue',null),
	$('#alloca_receCode_fReceUser').textbox('setValue',null),
	queryCF();
}
</script>
</body>
</html>

