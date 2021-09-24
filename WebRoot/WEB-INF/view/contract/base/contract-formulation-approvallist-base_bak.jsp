<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<div  data-options="iconCls:'icon-xxlb'" style="overflow:auto;margin-top:10px;">
		<table cellpadding="0" cellspacing="0" style="width: 680px;" id="c_c_dg" class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/Change/CheckInfoJsonPagination?fcId='+${bean.fcId},
			method:'post',pagination:false,singleSelect: true,scrollbarSize:0,rownumbers:true,
			selectOnCheck: true,checkOnSelect: true,remoteSort:true,nowrap:false">
			<thead>
				<tr>
					<!-- <th data-options="field:'ck',checkbox:true"></th> -->
					<th data-options="field:'fcId',hidden:true"></th>
					<th data-options="field:'fUserName',align:'center'" width="20%">审批人</th>
					<th data-options="field:'fResult',align:'center',formatter:fresult" width="20%">审批结果</th>
					<th data-options="field:'fCheckTimel',align:'center',resizable:false,sortable:true,formatter: ChangeDateFormat2" width="20%">审批时间</th>
					<th data-options="field:'fremark',align:'center',resizable:false,sortable:true" width="20%">审批内容</th>
					<th data-options="field:'ftype',align:'center',resizable:false,sortable:true,formatter:filesshow" width="20%">审批附件</th>
				</tr>
			</thead>
		</table>
	</div>
<script type="text/javascript">
//时间格式化
function ChangeDateFormat2(val) {
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
    return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d) + ' ' + (h < 10 ? '0' + h : h) + ':' + (i < 10 ? '0' + i : i);
}
function fresult(val, row) {
	if (val == 1) {
		return '<span style="color:green;">' + " 通过" + '</span>';
	} else if (val == 0) {
		return '<span style="color:red;">' + " 未通过" + '</span>';
	}
}
function checkType(val,row){
	if(val==1){
		return "<span >合同拟定</span>";
	}else  if (val == 3){
		return "<span >合同终止</span>";
	}
}

function filesshow (val,row){
	console.log(val);
	if (val=="1") {
		return '<table><tr style="width: 75px;height:20px"><td><a href="#" onclick="openFiles(' + row.fproId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/fj1.png">' + '</a></td>'
		+'</table>';
	}else{
		return 	'<table><tr style="width: 75px;height:20px"><td><a href="#" onclick="openFiles(' + row.fproId+ ')" class="easyui-linkbutton"><img onmouseover="listMouseOver(this)" onmouseout="listMouseOut(this)" src="'+base+'/resource-modality/${themenurl}/list/fj1.png">' + '</a></td>'
				+'</table>';
	}
}

function openFiles(fileName,attId,isflag){
	if(isflag==0){
		alert("没有相关附件！");
		return;
	}
	//window.open(base+'/systemcentergl/viewPDF/'+fileName,'open');
	window.open(base+'/systemcentergl/viewPDF?systemId='+attId,'open');
}

</script>