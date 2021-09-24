<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/includes/taglibs.jsp"%>
<body>
<div class="list-div">
	<div style="height: 10px;background-color:#f0f5f7 "></div>
		<div class="list-top">
			<table class="top-table" cellpadding="0" cellspacing="0">
				<tr>
					<td class="top-table-search" class="queryth">
						&nbsp;&nbsp;品目名称&nbsp;
						<input id="query_name" name="fpName" style="width: 150px; height:25px;" class="easyui-textbox"></input>
						<a href="#" onclick="queryCF();">
						<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						<a href="#" onclick="clearTable();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/qingchu1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						<a href="#" style="float:right;margin-right:20px" onclick="saveItems();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/baocun1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
						
					</td>
				</tr>
			</table>           
		</div>
			<div class="list-table">
			<table id="choose_Items"  class="easyui-datagrid"
			data-options="collapsible:true,url:'${base}/cgsqsp/jsonPaginationItems?item=${item} ',
			method:'post',fit:true,pagination:false,
			singleSelect: false,
			selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'pId',hidden:true"></th>
						<th data-options="field:'fName',align:'center'" width="95%">品目名称</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	


<script type="text/javascript">

//查询
function queryCF() {
	$('#choose_Items').datagrid('load',{
		fName:$('#query_name').textbox('getValue').trim(),
	//	gName:$("#query_dept").textbox('getValue').trim(),
	});
}

//清除查询条件
function clearTable() {
	$('#query_name').textbox('setValue','');
	//$("#query_dept").textbox('setValue','');
	$('#choose_Items').datagrid('load',{});
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

function isRepeat(arr) {

	  	var isTrue = true;   //作为是否一样的标识
	   for(var i = 0;i<arr.length;i++){
	  		if(arr.indexOf(arr[i])!=0){      //用indexOf来判断是否一样 
	  			isTrue = false;
	  			break;
	  		}
	  	}
	   return isTrue;; 
	}
var flag=0;
function saveItems(){
	var rowindex  = '${index}';
	var tabId  = '${tabId}';
	var names = '';
	var ids = '';
	var rows = $('#choose_Items').datagrid('getSelections');
	if(rows==''){
		alert('请选择品目名称！');
		return false;
	}else{
		for (var i = 0 ; i < rows.length ; i++) {
			names=names + rows[i].fName+',';	
			ids=ids + rows[i].pId+',';
			if(rows[i].fCode!=''&&rows[i].fCode!=null){
				flag=1;
			}
		}
	}
	$('#isZc').val(flag);
	$('#fItemsDetail').textbox('setValue',names.substring(0,names.length-1));
	$('#fItemsDetailIds').val(ids.substring(0,ids.length-1));
	closeFirstWindow();
}
</script>
</body>
</html>