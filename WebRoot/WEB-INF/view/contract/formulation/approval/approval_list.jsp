<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
		<table class="top-table" cellpadding="0" cellspacing="0">
				<tr >
					<td class="top-table-search" >合同编号&nbsp;
						<input id="c_app_fcCode" name="" style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;合同名称&nbsp;
						<input id="c_app_fcTitle" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
						&nbsp;&nbsp;合同金额&nbsp;
						<input id="c_app_cAmountBegin" name="" style="width: 150px;height:25px;" data-options="icons: [{iconCls:'icon-yuan'}],precision:2" class="easyui-numberbox"></input>
						&nbsp;-&nbsp;
						<input id="c_app_cAmountEnd" name="" style="width: 150px;height:25px;" data-options="icons: [{iconCls:'icon-yuan'}],precision:2" class="easyui-numberbox"></input>
						&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="approval_query();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png"></a>
						&nbsp;&nbsp;
						<a href="javascript:void(0)"  onclick="approval_clearTable();"><img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
					
					</td> 
					<%-- <td class="top-table-td1" class="queryth">合同编号：</td> 
					<td class="top-table-td2">
						<input id="c_app_fcCode" name="" style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<td class="top-table-td1" class="queryth">合同名称：</td> 
					<td class="top-table-td2">
						<input id="c_app_fcTitle" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					<!-- <td class="top-table-td1" class="queryth">申请时间：</td> 
					<td class="top-table-td2">
						<input id="c_fReqtIME" name="" style="width: 150px;height:25px;" class="easyui-datebox"></input>
					</td> -->
					<td class="top-table-td1" class="queryth">合同金额：</td> 
					<td class="top-table-td2">
						<input id="c_fOperator" name="" style="width: 150px;height:25px;" data-options="prompt:'(万元)'" class="easyui-textbox"></input>
					</td>
					<td style="width: 30px;"></td>
					<td style="width: 24px;">
						<a href="javascript:void(0)" onclick="approval_query();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png"></a>
					</td>
					<td style="width: 8px;"></td>
					<td >
						<a href="javascript:void(0)"  onclick="approval_clearTable();"><img src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)"></a>
					</td> --%>
					</tr>
					<tr id="helpTr" style="display: none;">
					</tr>
			</table>           
				<!-- <div style="margin-left: 5px;">  
                <div class="easyui-panel" style="vertical-align:center;height:45px;padding-top: 10px;">
					<a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add32'" onclick="approval_addCF()" >添加</a>
					<a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-edit32'"onclick="editCF()">修改</a>
					<a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-cut32'" onclick="deleteCF()">删除</a>
					<a href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-view32'" onclick="detailDemo()">查看</a>
				</div>
				</div> -->
		</div>
		<div class="list-table">
			<table id="CF_app_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Approval/JsonPagination',
			method:'post',fit:true,pagination:true,singleSelect: true,
			selectOnCheck: true,checkOnSelect:true,remoteSort:false,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<!-- <th data-options="field:'ck',checkbox:true"></th> -->
						<th data-options="field:'fcId',hidden:true"></th>
						<th data-options="field:'number',align:'center',resizable:false,sortable:true" width="5%">序号</th>
						<th data-options="field:'fcCode',align:'center',resizable:false,sortable:true" width="17%">合同编号</th>
						<th data-options="field:'fcTitle',align:'center',resizable:false,sortable:true" width="20%">合同名称</th>
						<th data-options="field:'fcAmount',align:'right',resizable:false,sortable:true,formatter:function(value,row,index){return fomatMoney(value,2);}" width="10%">合同金额(元)</th>
						<th data-options="field:'fReqtIME',align:'center',formatter: ChangeDateFormat,resizable:false,sortable:true" width="9%" >申请日期</th>
						<th data-options="field:'fDeptName',align:'center',resizable:false,sortable:true" width="10%">申请部门</th>
						<th data-options="field:'fOperator',align:'center',resizable:false,sortable:true" width="10%">申请人</th>
						<th data-options="field:'fFlowStauts',align:'center',resizable:false,sortable:true,formatter:formatPrice" width="10%">审批状态</th>
						<th data-options="field:'name',align:'center',resizable:false,sortable:true,formatter:CZ" width="10%">操作</th>
					</tr>
				</thead>
			</table>
		</div>
</div>
	


<script type="text/javascript">
//清除查询条件
function approval_clearTable() {
	$('#c_app_fcCode').textbox('setValue',null);
	$('#c_app_fcTitle').textbox('setValue',null);
	$('#c_app_cAmountBegin').numberbox('setValue',null);
	$('#c_app_cAmountEnd').numberbox('setValue',null);
	approval_query();
}
//鼠标移入图片替换
function mouseOver(img){
	var src = $(img).attr("src");
	src = src.replace(/1/, "2");
	$(img).attr("src",src);
}
	
function mouseOut(img) {
	var src = $(img).attr("src");
	src = src.replace(/2/, "1");
	$(img).attr("src",src);
}
function formatPrice(val,row){
	if (val ==0){
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/zc.png">'+" 暂存"+'</span>';
	} else if(val ==1){
		return '<span style="color:#666666;"><img src="'+base+'/resource-modality/${themenurl}/dsp.png">'+" 待审批"+'</span>';
	}
}
function CZ(val,row){
	if(row.fFlowStauts==1){
	return 	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'+
			'<a href="#" onclick="approval_detail('+row.fcId+')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+'</a>    '
			+'</td><td style="width: 25px">'
			+'<a href="#" onclick="CF_sp(' + row.fcId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)"" src="'+base+'/resource-modality/${themenurl}/list/approval1.png">' + '</a>'
			+'</td></tr></table>';
	}else{
		return 	'<table><tr style="width: 105px;height:20px"><td style="width: 25px">'+
		'<a href="#" onclick="approval_detail('+row.fcId+')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/select1.png">'+'</a>    '
		+'</td></tr></table>';
	}
}
function CF_sp(fcId){
	var win=creatWin('合同审批',1115, 580,'icon-search','/Approval/approveList/'+fcId);
	win.window('open');
}
function formulationAPPshowB(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/approval2.png';
}
function formulationAPPshowA(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/approval1.png';
}
function formulationAPPshowC(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/select2.png';
}
function formulationAPPshowD(obj){
	obj.src=base+'/resource-modality/${themenurl}/list/select1.png';
}

/* $(function(){
	//定义双击事件
	$('#CF_app_dg').datagrid({
		onDblClickRow :function(rowIndex,rowData){
			approval_detail();
		}
	});
}); */
function approval_query(){  
	$('#CF_app_dg').datagrid('load',{ 
		fcCode:$('#c_app_fcCode').val(),
		fcTitle:$('#c_app_fcTitle').val(),
		cAmountBegin:$('#c_app_cAmountBegin').val(),
		cAmountEnd:$('#c_app_cAmountEnd').val(),
	} ); 
}
function approval_addCF(){
	var node=$('#CF_app_dg').datagrid('getSelected');
	var win=creatWin('新增-合同拟定',750,550,'icon-add','/Formulation/add');
	if(null!=node){
		win=creatWin('新增-合同拟定',750,550,'icon-add','/Formulation/add?departId='+node.id);
	}
	win.window('open');
}
function approval_detail(id) {
	var win = creatWin('合同审批', 1115, 580, 'icon-search',"/Approval/detail/" + id);
	win.window('open');
}
function editCF(){
	var row = $('#CF_app_dg').datagrid('getSelected');
	var selections = $('#CF_app_dg').datagrid('getSelections');
	if(row!=null&&selections.length==1){
		var win=creatWin('修改-合同拟定',840,550,'icon-search',"/Formulation/edit/"+row.fcId);
		  win.window('open');
	}else{
		 $.messager.alert('系统提示','请选择一条数据！','info');
	}
}
function CF_update(id){
	//var row = $('#CF_app_dg').datagrid('getSelected');
	console.log(id);
	var selections = $('#CF_app_dg').datagrid('getSelections');
		var win=creatWin('修改-合同拟定',750,550,'icon-search',"/Formulation/edit/"+id);
		  win.window('open');
}
function deleteCF(){
	var row = $('#CF_app_dg').datagrid('getSelected');
	var selections = $('#CF_app_dg').datagrid('getSelections');
	if(row!=null&&selections.length==1){
		if(confirm("确认删除吗？")){
			$.ajax({ 
				type: 'POST', 
				url: '${base}/Formulation/delete/'+row.fcId,
				dataType: 'json',  
				success: function(data){ 
					if(data.success){
						$.messager.alert('系统提示',data.info,'info');
						$("#CF_app_dg").datagrid('reload');
					}else{
						$.messager.alert('系统提示',data.info,'error');
					}
				} 
			}); 
		}
	}else{
		 $.messager.alert('系统提示','请选择一条数据！','info');
	}
}
function expListlawHelp(){
	 //var win=creatWin('导出-法律服务接待登记表',400,120,'icon-search','/demo/exportList');
	  //win.window('open');
	if(confirm("按当前查询条件导出？")){
	   var queryForm = document.getElementById("lawHelp_list_form");
		queryForm.setAttribute("action","${base}/demo/expList");
		queryForm.submit();
	}
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
//在线帮助
 function helpDemo(){
	window.open("./resource/onlinehelp/zzzx/demo/help.html");
} 
function test(val){
	alert('test')
}
function formatOper(value, row, index){
	return 'sfsdf';
	 //return '<a href="#" onclick="test('+index+')">修改</a>';  
//    return '<a href="javascript:void(0);" onclick="openviewzfrw(\''+row.person+'\',\''+row.data_status+'\')"><font color="blue">走访</font></a>'; 
}
</script>
</body>
</html>

