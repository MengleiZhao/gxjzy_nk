<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-search" style="width: 650px" class="queryth">
						&nbsp;&nbsp;姓名&nbsp;
						<input id="query_name" style="width: 150px;height:25px;" class="easyui-textbox"/>
						
						<!-- &nbsp;&nbsp;部门&nbsp;
						<input id="query_dept" style="width: 150px;height:25px;" class="easyui-textbox"/> -->
						
						&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="queryCF();"><img src="${base}/resource-modality/${themenurl}/button/detail1.png" onmouseover="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail2.png')"
								onmouseout="this.setAttribute('src','${base}/resource-modality/${themenurl}/button/detail1.png')">
						</a>
						<a href="#" onclick="clearTable();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					<td>
						<a href="javascript:void(0)" onclick="select()">
							<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>&nbsp;&nbsp;
						<a href="javascript:void(0)" onclick="closeSecondWindow()">
							<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
				</tr>
			</table>           
		</div>
			<div class="list-table" style="height: 480px;">
			<table id="choose_nameAndDept_dg" 
				data-options="collapsible:true,url:'${base}/user/jsonPagination',checkbox: true,
              	collapsible:true,method:'post',fit:true,pagination:true,singleSelect: false,
				selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'Id',hidden:true"></th>
						<th data-options="field:'accountNo',align:'center'" width="24%">账号</th>
						<th data-options="field:'name',align:'center'" width="25%">姓名</th>
						<th data-options="field:'departName',align:'center',resizable:false,sortable:true" width="25%">部门</th>
						<th data-options="field:'dpcode',align:'center',resizable:false,sortable:true" width="25%">部门编码</th>
					</tr>
				</thead>
			</table>
		</div>
		<%-- <div class="win-left-bottom-div" style="height: 30px">
			<a href="javascript:void(0)" onclick="select()">
			<img src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>&nbsp;&nbsp;
			<a href="javascript:void(0)" onclick="closeSecondWindow()">
			<img src="${base}/resource-modality/${themenurl}/button/guanbi1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
			</a>
		</div> --%>
	</div>
	
<script type="text/javascript">
//查询
function queryCF() {
	$("#choose_nameAndDept_dg").datagrid('load',{
		name:$("#query_name").textbox('getValue').trim(),
	//	gName:$("#query_dept").textbox('getValue').trim(),
	});
}

//清除查询条件
function clearTable() {
	
	$("#query_name").textbox('setValue','');
	//$("#query_dept").textbox('setValue','');
	
	$("#choose_nameAndDept_dg").datagrid('load',{});
}
 //双击选择页面
$('#choose_nameAndDept_dg').datagrid({
	onDblClickRow: function(rowIndex, rowData){
		/* var i=${index};
		$('#people_'+i).val(rowData.name+"\xa0"+rowData.departName);
		//closeSecondWindow(); */
	}
}); 

 function select(){
	var s = '';
	var j=${index};
	var nodes = $('#choose_nameAndDept_dg').datagrid('getSelections');
	for(var i=0; i<nodes.length; i++){
		if(s==''){
			s=nodes[i].name+"("+nodes[i].departName+")";
		}else{
			s=s+"\xa0"+nodes[i].name+"("+nodes[i].departName+")";
		}
			s+=' | ';
	}
	$('#people_'+j).val(s.substring(0,s.length-3));
	closeSecondWindow();
} 
</script>
</body>
</html>

