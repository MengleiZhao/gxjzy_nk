<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/includes/taglibs.jsp"%>
<%@ include file="/includes/links.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
<div class="easyui-layout" fit="true">
	<div data-options="region:'west',split:false"  style="width:200px;" >
		<ul id="CgCataTree" class="easyui-tree" data-options="url:'${base}/purchaseCatagl/tree',animate:true,lines:true" ></ul>
	</div>
	<div data-options="region:'center'" style="background-color: #f0f5f7">
	  <div style="height: 10px;background-color:#f0f5f7 "></div>

		<div class="list-top">
			<form action="" id="query_user_form" class="easyui-form" style="margin-bottom: 0px;" onkeydown="if(event.keyCode==13){queryCgCata();return false; }">
			 <table class="top-table" cellpadding="0" cellspacing="0">
				 <tr>
					<td class="top-table-td1">目录名称：</td> 
					<td class="top-table-td2">
						<input id="purchaseCata_name" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					
					<td style="width: 8px;"></td>
					
					<td class="top-table-td1">目录编号：</td> 
					<td class="top-table-td2">
						<input id="purchaseCata_code" name=""  style="width: 150px;height:25px;" class="easyui-textbox"></input>
					</td>
					
					<td style="width: 8px;"></td>
					<td style="width: 26px;">
						<a href="#" onclick="queryCgCata();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/detail1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					<td style="width: 8px;"></td>
					<td style="width: 26px;">
						<a href="#" onclick="addCgCata()">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xz1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					<td style="width: 8px;"></td>
					<td style="width: 26px;">
						<a href="#" onclick="editCgCata();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/xg1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					<td style="width: 8px;"></td>
					<td style="width: 26px;">
						<a href="#" onclick="deleteCgCata();">
							<img style="vertical-align:bottom" src="${base}/resource-modality/${themenurl}/button/scyh1.png" onMouseOver="mouseOver(this)" onMouseOut="mouseOut(this)">
						</a>
					</td>
					<td align="right" style="padding-right: 10px"></td>
				</tr>
			 </table>
			</form>
		</div>
		<div class="list-table" style="height: 90%">
		<table id="CgCata_dg" border="0" class="easyui-datagrid"
				data-options="singleSelect:true,collapsible:true,url:'${base}/purchaseCatagl/purchaseCataPageData',
				method:'post',fit:true,pagination:true,singleSelect: true,
				selectOnCheck: true,checkOnSelect:true,remoteSort:true,nowrap:false,striped: true,fitColumns: true" >
			<thead>
				<tr>
					<!-- <th data-options="field:'ck',checkbox:true"></th> -->
					<th data-options="field:'fId',hidden:true"></th>
					<th data-options="field:'fpurCode',align:'left',resizable:false,sortable:true" width="15%">科目编号</th>
					<th data-options="field:'fpurName',align:'center',resizable:false,sortable:true" width="30%">科目名称</th>
					<th data-options="field:'flevel',align:'center',resizable:false,sortable:true,formatter:kmjb" width="20%">科目级别</th>
					<th data-options="field:'fpPurCode',align:'center',resizable:false" width="10%">上级科目编号</th>
					<th data-options="field:'fmeasureUnit',align:'center',resizable:false" width="10%">计量单位</th>
					<th data-options="field:'fremark',align:'center',resizable:false" width="15%">备注</th>
				</tr>
			</thead>
		</table>
		</div>
    </div>
</div>
<script type="text/javascript">
//分页样式调整
$(function(){
	 var addr_tree = $("#CgCataTree").tree({  
	        url:'${base}/purchaseCatagl/tree',  
	        method:"post",  
	        onSelect:function(node){},
	        onLoadSuccess:function(node,data){  
	        	//找到第一条数据
	        	var n = $("#CgCataTree").tree('find', data[0].id);
		        //调用选中事件
		        $("#CgCataTree").tree('select', n.target);
	        	var node=$("#CgCataTree").tree('getSelected');
	        	$('#CgCata_dg').datagrid('load',{ 
	    			fpurName:$('#purchaseCata_name').val(),
	    			fPurCode:node.id,
	    		});
	         }  
	    }); 		
});
//科目级别
function kmjb(val, row){
	if(val=='1'){
		return '一级科目';
	}else if(val=='2'){
		return '二级科目';
	}else if(val=='3'){
		return '三级科目';
	}
}
	//点击查询
	function queryCgCata(){
		$('#CgCata_dg').datagrid('load',{ 
			fpurName:$('#purchaseCata_name').val(),
			fpurCode:$('#purchaseCata_code').val()
		}); 
	}
	//清除查询条件
	function clearTable() {
		$('#purchaseCata_name').textbox('setValue',null);
		$('#purchaseCata_code').textbox('setValue',null);
	}
	//新增	
	function addCgCata(){
		var node=$('#CgCataTree').tree('getSelected');
		//alert(node.col10);
		if(node==null){//第一级新增
			win=creatWin('新增',760,360,'icon-search','/purchaseCatagl/add?catamainid='+0);//新增一级
		}else{
			win=creatWin('新增',760,360,'icon-search','/purchaseCatagl/add?catamainid='+node.col10);//col10是当前点击节点的主键id 新增二三级
		}
		win.window('open'); 
	}
	//修改
	function editCgCata(){
		var row = $('#CgCata_dg').datagrid('getSelected');
		if(!row){
			 $.messager.alert('系统提示','请选择一条数据修改！');
		}else{
			var win=creatWin('修改',760,360,'icon-search','/purchaseCatagl/edit?id='+row.fId);
		    win.window('open');
		}
	}
	//删除
	function deleteCgCata(){
		var row = $('#CgCata_dg').datagrid('getSelected');
		if(!row){
			 $.messager.alert('系统提示','请选择一条数据删除！');
		}else{
			if (confirm("确认删除吗？")) {
				$.ajax({
					type : 'POST',
					url : '${base}/purchaseCatagl/delete?id='+row.fId,
					dataType : 'json',
					success : function(data) {
						if (data.success) {
							$.messager.alert('系统提示', data.info, 'info');
							$('#CgCata_dg').datagrid("reload");
						} else {
							$.messager.alert('系统提示', data.info, 'error');
						}
					}
				});
			}
		}
	}
   $('#CgCataTree').tree({
    	onClick: function(node){
			$('#CgCata_dg').datagrid('load',{ 
				fPurName:node.text,
				fPurCode:node.id
			}); 
    	}
    }); 
   /*  function da(){
    	var node=$('#CgCataTree').tree('getSelected');
    	console.log(node)
    } */
	/* $('#CgCataTree').tree({
		onClick: function(node){
			console.log(node)
			$('#CgCata_dg').datagrid('load',{ 
				fPeriod:node.text,
				fbId:node.id
				
			}); 
		}
	}); */
	function streetChange(streetCode){
		$('#streetJwh').combobox('reload',"${base}/street/jwh?streetCode="+streetCode);
	}
</script>
</body>
</html>

