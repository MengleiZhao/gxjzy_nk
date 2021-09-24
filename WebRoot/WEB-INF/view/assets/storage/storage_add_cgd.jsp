<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<th class="top-table-td1">采购名称：</th> 
					<td class="top-table-td2">
						<input id="storage_cgd_fpName" name="" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<th class="top-table-td1">采购批次号：</th> 
					<td class="top-table-td2">
						<input id="storage_cgd_fpCode" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td align="left" style="width: 75px;padding-left: 20px">
						<a href="javascript:void(0)" onclick="queryCF();" >
							<img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')">
						</a>
					</td>
					<td >
						<a href="javascript:void(0)"  onclick="storage_cgd_clear();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')">
						</a>
					</td>
				</tr>
			</table>           
		</div>
		<div class="list-table" style="height:450px">
			<table id="storage_cgd_fwCode_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Storage/cgdJsonPagination',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fpCode',align:'center'" width="25%">采购批次号</th>
						<th data-options="field:'fpName',align:'center'" width="25%">采购名称</th>
						<th data-options="field:'fpAmount',align:'center',resizable:false,sortable:true" width="25%">采购金额（元）</th>
						<th data-options="field:'fReqTime',align:'center',resizable:false,sortable:true,formatter:ChangeDateFormat" width="25%">采购日期</th>
					</tr>
				</thead>
			</table>
		</div>

	</div>
	<input hidden="hidden" id="zclx" type="text" value="${zctype }">


<script type="text/javascript">
//分页样式调整
$(function(){
	$("#storage_cgd_fwCode_dg").datagrid({
	 onDblClickRow:function(index, row){
		var row = $('#storage_cgd_fwCode_dg').datagrid('getSelected');
		var selections = $('#storage_cgd_fwCode_dg').datagrid('getSelections');
		var zcType=$('#zclx').val();
		if (row != null && selections.length == 1) {
			$("#S_fwName").textbox('setValue',row.fOrgName); 
			$("#S_fwCode").val(row.fwCode); 
			$("#S_fwNameShort").textbox('setValue',row.fwNameShort);
			$("#S_fAcquisitionType").combobox('setValue','QDFS-02');
			if(zcType=='ZCLX-01'){
				$('#low_add_plan').datagrid({
					url:base+"/Storage/cgpmJsonPagination?fpCode="+row.fpCode+"&fAssType=ZCLX-01"
				});
			}else if(zcType=='ZCLX-02'){
				$('#fixed_add_plan').datagrid({
					url:base+"/Storage/cgpmJsonPagination?fpCode="+row.fpCode+"&fAssType=ZCLX-02"
				});
			}
			closeSearchDateWindow();
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
function CZ(val,row){
	return '<a href="#" onclick="PitchOn('+row.fpId+')" class="easyui-linkbutton">'+"选取"+'</a>';
}
function PitchOn(id,row,val){
	console.log(row)
	console.log(val)
	var row = $('#storage_cgd_fwCode_dg').datagrid('getSelected');
	var selections = $('#storage_cgd_fwCode_dg').datagrid('getSelections');
	var zcType=$('#zclx').val();
	if (row != null && selections.length == 1) {
		$("#S_fwName").textbox('setValue',row.fwName); 
		$("#S_fwCode").val(row.fwCode); 
		$("#S_fwNameShort").textbox('setValue',row.fwNameShort); 
		$("#S_fAcquisitionType").combobox('setValue','QDFS-02');
		/* if(zcType=='ZCLX-01'){
			var win = creatWin(' ', 970, 580, 'icon-search','/Storage/lowadd?fpCode='+row.fpCode+'&forgtype='+row.fpMethod.code);
			win.window('open');
		}else if(zcType=='ZCLX-02'){
			var win = creatWin(' ', 970, 580, 'icon-search','/Storage/fixedadd?fpCode='+row.fpCode+'&forgtype='+row.fpMethod.code);
			win.window('open');
		} */
		/* closeSearchDateWindow(); */
	} else {
		$.messager.alert('系统提示', '请选择一条数据！', 'info');
	}
}
function queryCF(){  
	$('#storage_cgd_fwCode_dg').datagrid('load',{ 
		fpName:$('#storage_cgd_fpName').textbox('getValue'),
		fpCode:$('#storage_cgd_fpCode').textbox('getValue'),
	} ); 
}
//清除查询条件
function storage_cgd_clear() {
	$('#ledger_flow_flowCode').textbox('setValue',null),
	$('#ledger_flow_flowDeptName').textbox('setValue',null),
	$('#ledger_flow_fOptType').combobox('setValue',null),
	queryCF();
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

