<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-search" class="queryth">
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
						<a href="#" onclick="saveuser();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
				</tr>
			</table>           
		</div>
			<div class="list-table">
			<table id="choose_user_dg"  class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/user/jsonPagination',
			method:'post',fit:true,pagination:true,singleSelect: false,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'Id',hidden:true"></th>
						<th data-options="field:'accountNo',align:'center'" width="25%">账号</th>
						<th data-options="field:'name',align:'center'" width="25%">姓名</th>
						<th data-options="field:'departName',align:'center',resizable:false,sortable:true" width="23%">部门</th>
						<th data-options="field:'post',align:'center',resizable:false,sortable:true" width="25%">级别</th>
						<th data-options="field:'roleslevel',align:'center',resizable:false,sortable:true" width="25%"></th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	


<script type="text/javascript">
var rowindex = ${index};
var editType = ${editType};

//查询
function queryCF() {
	$('#choose_user_dg').datagrid('load',{
		name:$('#query_name').textbox('getValue').trim(),
	//	gName:$("#query_dept").textbox('getValue').trim(),
	});
}

//清除查询条件
function clearTable() {
	$('#query_name').textbox('setValue','');
	//$("#query_dept").textbox('setValue','');
	$('#choose_user_dg').datagrid('load',{});
}

function rolesreturn(val,row){//1：市级，2：局级，3：其他人员
	if(1==val){
		return '市级';
	}else if(2==val){
		return '局级';
	}else if(3==val){
		return '其他人员';
	}
}
function saveuser(){
	var names = '';
	var ids = '';
	var tabId = '${tabId}';
	var rows = $('#choose_user_dg').datagrid('getSelections');
	for (var i = 0 ; i < rows.length ; i++) {	
		names=names + rows[i].name+',';	
		ids=ids + rows[i].id+',';
	}
	
	names = names.substring(0,names.length-1);
	ids = ids.substring(0,ids.length-1);
	if(tabId=='reimbursein_hoteltab'){
		var travelPersonnel = $('#reimbursein_hoteltab').datagrid('getEditor',{
			index:rowindex,
			field:'travelPersonnel'
		});
		$(travelPersonnel.target).textbox('setValue', names);
		//人员id
		var travelPersonnelId = $('#reimbursein_hoteltab').datagrid('getEditor',{
			index:rowindex,
			field:'travelPersonnelId'
		});
		$(travelPersonnelId.target).textbox('setValue', ids);
	}else{
		var travelPersonnel = $('#hoteltab').datagrid('getEditor',{
			index:rowindex,
			field:'travelPersonnel'
		});
		$(travelPersonnel.target).textbox('setValue', names);
		//人员id
		var travelPersonnelId = $('#hoteltab').datagrid('getEditor',{
			index:rowindex,
			field:'travelPersonnelId'
		});
		$(travelPersonnelId.target).textbox('setValue', ids);
		
	}
	
	closeFirstWindow();
}
</script>
</body>
</html>