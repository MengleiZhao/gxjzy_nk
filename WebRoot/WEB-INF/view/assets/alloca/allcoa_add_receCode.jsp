<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<th class="top-table-td1">原配置单号：</th> 
					<td class="top-table-td2">
						<input id="alloca_receCode_fAssReceCode" name="" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<!-- <th class="top-table-td1">物资名称：</th> 
					<td class="top-table-td2">
						<input id="alloca_receCode_fAssName" name=""  style="width: 90px;height:25px;" class="easyui-textbox"></input>
					</td> -->
					<th class="top-table-td1">领用人：</th> 
					<td class="top-table-td2">
						<input id="alloca_receCode_fReceUser" name="" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td >
						<a href="javascript:void(0)" onclick="queryCF();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')"></a>
								&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="alloca_clear();">
							<img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu2.png')"onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/qingchu1.png')">
						</a>
					</td>
					<td >
						<%-- <a href="javascript:void(0)"  onclick="PitchOn();"><img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a> --%>
					</td>
				</tr>
			</table>           
		</div>
		<div class="list-table" style="height: 280px">
			<table id="allcoa_receCode_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Rece/allocaList',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'fId_R',hidden:true"></th>
						<th data-options="field:'number',align:'center'" width="10%">序号</th>
						<th data-options="field:'fAssReceCode',align:'center'" width="30%">原配置单编号</th>
						<!-- <th data-options="field:'fAssName',align:'center',resizable:false,sortable:true" width="20%">物资名称</th> -->
						<th data-options="field:'fReceUser',align:'center',resizable:false,sortable:true" width="20%">领用人</th>
						<th data-options="field:'fReceDept',align:'center',resizable:false,sortable:true" width="20%" >领用部门</th>
						<!-- <th data-options="field:'fReceTel',align:'center',resizable:false,sortable:true" width="15%">领用人电话</th> -->
						<th data-options="field:'fReceTime',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat" width="20%">领用时间</th>
					</tr>
				</thead>
			</table>
		</div>
		<div data-options="region:'south'" style="height: 20px;width: 100%; border: 0px;">
			<div style="text-align: left;">
				<span style="color:#ff6800">&nbsp;&nbsp;&nbsp;&nbsp;✧温馨提示：请双击完成选择</span>
			</div>
		</div>
	</div>
	


<script type="text/javascript">
//分页样式调整
$(function(){
	$("#allcoa_receCode_dg").datagrid({
		 onDblClickRow:function(index, row){
			 var row = $('#allcoa_receCode_dg').datagrid('getSelected');
				var selections = $('#allcoa_receCode_dg').datagrid('getSelections');
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
function PitchOn(id){
	var row = $('#allcoa_receCode_dg').datagrid('getSelected');
	var selections = $('#allcoa_receCode_dg').datagrid('getSelections');
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
	$('#allcoa_receCode_dg').datagrid('load',{ 
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

