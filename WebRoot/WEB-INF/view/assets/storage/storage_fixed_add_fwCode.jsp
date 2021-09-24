<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<th width="90px" class="queryth">供应商名称</th> 
					<td width="100px">
						<input id="storage_fwName" name="" style="width: 90px;height:25px;" class="easyui-textbox"></input>
					</td>
					<th width="90px" class="queryth">联系人</th> 
					<td width="90px">
						<input id="storage_fwuserName" name=""  style="width: 90px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td >
						<a href="javascript:void(0)" onclick="queryCF();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
					</td>
					<td >
						<a href="javascript:void(0)"  onclick="PitchOn();"><img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
					</td>
				</tr>
			</table>           
		</div>
		<div class="list-table">
			<table id="storage_fwCode_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Storage/codeJsonPagination',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fwName',align:'center'" width="25%">供应商名称</th>
						<th data-options="field:'fwCode',align:'center'" width="25%">供应商编码</th>
						<th data-options="field:'fwNameShort',align:'center',resizable:false,sortable:true" width="25%">供应商简称</th>
						<th data-options="field:'fwuserName',align:'center',resizable:false,sortable:true" width="25%">联系人</th>
					</tr>
				</thead>
			</table>
		</div>
		<div style="text-align: left;height: 20px">
			<span style="color:#ff6800">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;✧温馨提示：双击数据选择</span>
		</div>

	</div>
	


<script type="text/javascript">
//分页样式调整
$(function(){
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
	var row = $('#storage_fwCode_dg').datagrid('getSelected');
	var selections = $('#storage_fwCode_dg').datagrid('getSelections');
	if (row != null && selections.length == 1) {
		$("#S_fwName").textbox('setValue',row.fwName); 
		$("#S_fwCode").val(row.fwCode); 
		$("#S_fwNameShort").textbox('setValue',row.fwNameShort); 
		closeFirstWindow();
	} else {
		$.messager.alert('系统提示', '请选择一条数据！', 'info');
	}
}
function queryCF(){  
	$('#storage_fwCode_dg').datagrid('load',{ 
		fwName:$('#storage_fwName').textbox('getValue'),
		fwuserName:$('#storage_fwuserName').textbox('getValue'),
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

